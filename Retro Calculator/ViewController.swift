//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Steven Yang on 8/10/16.
//  Copyright © 2016 Yato. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValueString = ""
    var rightValueString = ""
    var result = ""
    
    var buttonSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOf: soundURL)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLabel.text = "0"
        
    }
    
    
    @IBAction func numbersPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func onDivideButtonTapped(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyButtonTapped(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractButtonTapped(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddButtonTapped(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualButtonTapped(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearButtonTapped(sender: AnyObject) {
        clearButton() 
    }
    
    func playSound() {
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }

    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            
            //A user selected an operator and then another one without first entering a number
            if runningNumber != "" {
                rightValueString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValueString )! * Double(rightValueString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValueString )! / Double(rightValueString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValueString )! - Double(rightValueString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValueString )! + Double(rightValueString)!)"
                }
                
                leftValueString = result
                outputLabel.text = result
            }
            
            currentOperation = operation
        } else {
            leftValueString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    func clearButton() {
        playSound()
        currentOperation = Operation.Empty
        runningNumber = ""
        leftValueString = ""
        rightValueString = ""
        result = ""
        outputLabel.text = "0"
    }
    
}

