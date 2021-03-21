// The Game Of Life problem statement -
// Any live cell with fewer than two live neighbours dies, as if by loneliness. ... Any live cell with more than three live neighbours dies, as if by overcrowding. 3. Any live cell with two or three live neighbours lives, unchanged, to the next generation.

class GameOfLifeCode {
    var gameArray = [[Int]]()
    
    func compute(gameArray: [[Int]]) -> [[Int]]{
        self.gameArray = gameArray
        for (i, item) in self.gameArray.enumerated() {
            for (j,_) in item.enumerated() {
                self.gameArray[i][j] = determineCellState(liveNeighbourCount: getCellNeighbourCount(i: i, j: j), cellState: self.gameArray[i][j])
            }
        }
        return self.gameArray
    }
    func determineCellState(liveNeighbourCount: Int, cellState: Int) -> Int {
        //        var result = cellState
        //        if cellState == 1 {
        //            if liveNeighbourCount < 2 {
        //                result = 0
        //            }else if liveNeighbourCount == 2 || liveNeighbourCount == 3{
        //
        //            }else if liveNeighbourCount > 3 {
        //                result = 0
        //            }
        //        } else if liveNeighbourCount == 3 {
        //            result = 1
        //        }
        //        return result
        let exp2 = (liveNeighbourCount > 3) ? 0 : cellState
        let exp1 = (liveNeighbourCount < 2) ? 0 : exp2
        let exp3 = (liveNeighbourCount == 3) ? 1 : cellState
        return (cellState == 1) ? exp1 : exp3
    }
    private func getCellNeighbourCount(i: Int, j: Int) -> Int{
        var count = 0
        count = (i != gameArray.count-1 && j != 0) ? (count + computeCellState(x: gameArray[i+1][j-1])) : count
        count = (i != 0 && j != gameArray[0].count-1) ? (count + computeCellState(x: gameArray[i-1][j+1])) : count
        count = (j != 0) ? (count + computeCellState(x: gameArray[i][j-1])) : count
        count = (i != 0) ? (count + computeCellState(x: gameArray[j][i-1])) : count
        count = (i != 0 && j != 0) ? (count + computeCellState(x: gameArray[i-1][j-1])) : count
        count = (i != gameArray.count-1) ? (count + computeCellState(x: gameArray[j][i+1])) : count
        count = (j != gameArray[0].count-1) ? (count + computeCellState(x: gameArray[i][j+1])) : count
        count = (i != gameArray.count-1 && j != gameArray[0].count-1) ? (count + computeCellState(x: gameArray[i+1][j+1])) : count
        return count
    }
    private func computeCellState(x: Int) -> Int{
        return (x == 1 ? 1 : 0)
    }
    
}

var gameArray = [[0,0,0,0,0,0,0,0],
                 [0,0,0,1,1,0,0,0],
                 [0,0,0,0,1,0,0,0],
                 [0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0],
                 [0,0,0,1,1,0,0,0],
                 [0,0,1,1,0,0,0,0],
                 [0,0,0,0,0,1,0,0],
]
print("Before solution: ", gameArray)
let gameOfLifeCode = GameOfLifeCode()
print("After solution: ", gameOfLifeCode.compute(gameArray: gameArray))

import XCTest
class GameOfLifeCodeTests: XCTestCase {
    let gameOfLifeCode = GameOfLifeCode()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDeadCellWithThreeNeighbours(){
        XCTAssertEqual(gameOfLifeCode.determineCellState(liveNeighbourCount: 3, cellState: 0), 1)
    }
    func testLiveCellWithTwoNeighbours(){
        XCTAssertEqual(gameOfLifeCode.determineCellState(liveNeighbourCount: 3, cellState: 1), 1)
    }
    func testLiveCellWithOneNeighbours(){
        XCTAssertEqual(gameOfLifeCode.determineCellState(liveNeighbourCount: 1, cellState: 1), 0)
    }
    func testLiveCellWithFoureNieghbours(){
        XCTAssertEqual(gameOfLifeCode.determineCellState(liveNeighbourCount: 4, cellState: 1), 0)
    }
    
}
GameOfLifeCodeTests.defaultTestSuite.run()
