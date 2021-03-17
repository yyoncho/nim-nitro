import std/hashes
import pkg/questionable
import pkg/questionable/results
import pkg/stew/byteutils
import ./ethaddress

include questionable/errorban

type Destination* = distinct array[32, byte]

func toArray*(destination: Destination): array[32, byte] =
  array[32, byte](destination)

func `$`*(destination: Destination): string =
  destination.toArray().toHex()

func parse*(_: type Destination, s: string): ?Destination =
   Destination(array[32, byte].fromHex(s)).catch.option

func `==`*(a, b: Destination): bool {.borrow.}
func hash*(destination: Destination): Hash {.borrow.}

func toDestination*(address: EthAddress): Destination =
  var bytes: array[32, byte]
  for i in 0..<20:
    bytes[12 + i] = array[20, byte](address)[i]
  Destination(bytes)
