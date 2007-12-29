{-# LANGUAGE CPP,TemplateHaskell #-}
module Data.Encoding.ISO885910
	(ISO885910(..)) where

import Data.Array ((!),Array)
import Data.Word (Word8)
import Data.Map (Map,lookup,member)
import Data.Encoding.Base
import Prelude hiding (lookup)
import Control.Exception (throwDyn)

data ISO885910 = ISO885910 deriving Show

enc :: Char -> Word8
enc c = case lookup c encodeMap of
	Just v -> v
	Nothing -> throwDyn (HasNoRepresentation c)

instance Encoding ISO885910 where
	encode _ = encodeSinglebyte enc
	encodeLazy _ = encodeSinglebyteLazy enc
	encodable _ c = member c encodeMap
	decode _ = decodeSinglebyte (decodeArr!)

decodeArr :: Array Word8 Char
#ifndef __HADDOCK__
decodeArr = $(decodingArray "8859-10.TXT")
#endif

encodeMap :: Map Char Word8
#ifndef __HADDOCK__
encodeMap =  $(encodingMap "8859-10.TXT")
#endif
