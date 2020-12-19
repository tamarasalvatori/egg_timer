//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel?

    @IBOutlet weak var progressBar: UIProgressView!

    let eggTimer : [String : Int] = ["Soft": 3, "Medium": 4,  "Hard": 7]

    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()

        let hardness = sender.currentTitle!
        totalTime = eggTimer[hardness]!

        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel?.text = hardness

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsPassed <= self.totalTime {

                self.progressBar.progress = Float(self.secondsPassed) / Float(self.totalTime)

                print(Float(self.secondsPassed) / Float(self.totalTime))

                self.secondsPassed += 1
            } else {
                Timer.invalidate()
                self.titleLabel?.text = "DONE!"
                self.playSound(soundName: "alarm_sound")
            }
        }
    }

    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
