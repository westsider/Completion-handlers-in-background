//
//  ViewController.swift
//  Completion Handlers
//
//  Created by Warren Hansen on 11/17/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var updateLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let block = {
            let textupdate = "Completion block has been run" ;
            self.updateLable(with: textupdate)
        }
        // do calculations in background thread
        DispatchQueue.global(qos: .background).async {
            for counter in 0...100 {
                self.runCodeAndConplete(text: "Completed Network Call \(counter)", count: counter, completion: block)
            }
        }
    }

    func runCodeAndConplete(text: String, count: Int, completion: @escaping () -> ()) {
        // update UI on start
        updateLable(with: "Starting network call \(count)")
        for i in 1...1000000 {
            let n = i * 100
            _ = i * n
        }
        // update  UI on completion
        DispatchQueue.main.async {
            completion()
            self.updateLable(with: text)
        }
    }
    
    // update UI on main thread
    func updateLable(with: String) {
        DispatchQueue.main.async {
            print(with)
            self.updateLable?.text =  with
        }
    }
}

