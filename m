Received: from eggs.gnu.org ([2001:4830:134:3::10]:60107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cbAab-0004tQ-Ve
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:34:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cbAaY-0001Ue-Oy
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:34:05 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:57003)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cbAaY-0001TT-EM
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:34:02 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  7 Feb 2017 19:33:55 +0100
Message-Id: <20170207183356.17840-5-laurent@vivier.eu>
In-Reply-To: <20170207183356.17840-1-laurent@vivier.eu>
References: <20170207183356.17840-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 4/5] m68k: add instruction needing an extended
 word
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

Some instructions are encoded on more than 32 bits.

To be able to add this word, we introduce a new keyword: "post".
This keyword adds a block to be executed after the instruction
generation.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 m68k.risu       | 42 ++++++++++++++++++++++++++++++++++++------
 risugen         |  2 +-
 risugen_m68k.pm |  4 ++++
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/m68k.risu b/m68k.risu
index 3317005..4297283 100644
--- a/m68k.risu
+++ b/m68k.risu
@@ -23,6 +23,8 @@ ADDA  M68000 1101 Ax:3 size:1 11 000 Dy:3
 # addi #Imm, $dx
 ADDIB M68000 00000110 00 000 Dx:3 00000000 data:8
 ADDIW M68000 00000110 01 000 Dx:3 data:16
+ADDIL M68000 00000110 10 000 Dx:3 \
+                 !post { insn32(rand(0xffffffff)); }
 # addq #Imm3, $dx
 ADDQ  M68000 0101 imm:3 0 size:2 000 Dx:3 \
                  !constraints { $size != 0b11; }
@@ -35,6 +37,8 @@ AND   M68000 1100 Dx:3 0 opmode:2 000 Dy:3 \
 # andi #Imm,$dx
 ANDIB M68000 00000010 00 000 Dx:3 00000000 data:8
 ANDIW M68000 00000010 01 000 Dx:3 data:16
+ANDIL M68000 00000010 10 000 Dx:3 \
+                 !post { insn32(rand(0xffffffff)); }
 # andi #imm,ccr
 ANDICCR M68000 0000001000111100 data:16 \
                  !constraints { write_mov_ccr(rand(0x100)); 1; }
@@ -68,15 +72,13 @@ BFEXTU M68020 1110100111 000 Dx:3 0 Dy:3 Do:1 offset:5 Dw:1 width:5 \
                                (!$Dw || $width < 8);             \
                              }
 # bfffo $dx,offset:width,$dy
-# there is a bug in 68040 with offset > 31
+# there is a bug in 68040 with D(offset) > 31
 BFFFO M68020 1110110111 000 Dx:3 0 Dy:3 Do:1 offset:5 Dw:1 width:5    \
-                !constraints {                                        \
-                               if ($Dw == 1) { $width &= 0x7; ;}      \
-                               if ($Do == 1) {                        \
-                                   $offset &= 0x7;                    \
+                !constraints { if ($Do == 1 && $offset < 8) {         \
                                    write_mov_di($offset, rand(0x20)); \
                                }                                      \
-                               1;                                     \
+                               (!$Do || $offset < 8) &&          \
+                               (!$Dw || $width < 8);             \
                              }
 # bfins $dx,offset:width,$dy
 BFINS M68020 1110111111 000 Dx:3 0 Dy:3 Do:1 offset:5 Dw:1 width:5 \
@@ -110,6 +112,8 @@ CMPA  M68000 1011 Ax:3 size:1 11 000 Dy:3
 # cmpi #Imm, $dx
 CMPIB M68000 00001100 00 000 Dx:3 00000000 data:8
 CMPIW M68000 00001100 01 000 Dx:3 data:16
+CMPIL M68000 00001100 10 000 Dx:3 \
+                 !post { insn32(rand(0xffffffff)); }
 # divs $dx,$dy
 DIVS  M68000 1000 Dy:3 111 000 Dx:3 \
                  !constraints { \
@@ -140,6 +144,8 @@ EOR   M68000 1011 Dx:3 1 size:2 000 Dy:3 \
 # eori #Imm, $dx
 EORIB M68000 00001010 00 000 Dx:3 00000000 data:8
 EORIW M68000 00001010 01 000 Dx:3 data:16
+EORIL M68000 00001010 10 000 Dx:3 \
+                 !post { insn32(rand(0xffffffff)); }
 # eori #imm,ccr
 EORICCR M68000 0000101000111100 data:16 \
                  !constraints { write_mov_ccr(rand(0x100)); 1; }
@@ -153,6 +159,26 @@ EXG   M68000 1100 Dx:3 1 01000 Ay:3
 EXT   M68000 0100100 opmode:3 000 Dx:3 \
                  !constraints { $opmode == 0b010 || $opmode == 0b011 }
 EXTB  M68020 0100100 111 000 Dx:3
+# lea <ea> (XXX: must test full extension word format)
+LEA   M68000 0100 Ax:3 111 mode:3 reg:3 \
+                 !constraints { $reg != 6 && $reg != 7 &&                    \
+                                ($mode == 0b010 || $mode == 0b101 ||         \
+                                $mode == 0b110 ||                            \
+                                ($mode == 0b111 && $reg == 0b000) ||         \
+                                ($mode == 0b111 && $reg == 0b001));          \
+                              }                                              \
+                 !post        { if ($mode == 0b101) {                        \
+                                    insn16(rand(0x10000));                   \
+                                } elsif ($mode == 0b110) {                   \
+                                    insn16(((rand(0x80) & 0b1000111) |       \
+                                            (rand(6) << 3)) << 9 |           \
+                                           rand(0x100));                     \
+                                } elsif ($mode == 0b111 && $reg == 0b000) {  \
+                                    insn16(rand(0x10000));                   \
+                                } elsif ($mode == 0b111 && $reg == 0b001) {  \
+                                    insn32(rand(0xffffffff));                \
+                                }                                            \
+                              }
 # lsl/lsr $dx,$dy , lsl/lsr #im3,$r
 LSx   M68000 1110 count:3 d:1 size:2 i:1 01 r:3 \
                  !constraints { $size != 0b11; }
@@ -199,6 +225,8 @@ OR    M68000 1000 Dy:3 0 size:2 000 Dx:3 \
 # ori #Imm, $dx
 ORIB M68000 00000000 00 000 Dx:3 00000000 data:8
 ORIW M68000 00000000 01 000 Dx:3 data:16
+ORIL M68000 00000000 10 000 Dx:3 \
+                 !post { insn32(rand(0xffffffff)); }
 # ori #imm,ccr
 ORICCR M68000 0000000000111100 data:16 \
                  !constraints { write_mov_ccr(rand(0x100)); 1; }
@@ -226,6 +254,8 @@ SUBA  M68000 1001 Ax:3 size:1 11 000 Dy:3
 # subi #Imm, $dx
 SUBIB M68000 00000100 00 000 Dx:3 00000000 data:8
 SUBIW M68000 00000100 01 000 Dx:3 data:16
+SUBIL M68000 00000100 10 000 Dx:3 \
+                 !post { insn32(rand(0xffffffff)); }
 # subq #Imm3n $dx
 SUBQ  M68000 0101 imm:3 1 size:2 000 Dx:3 \
                  !constraints { $size != 0b11; }
diff --git a/risugen b/risugen
index 77a550b..b46567c 100755
--- a/risugen
+++ b/risugen
@@ -34,7 +34,7 @@ my @pattern_re = ();            # include pattern
 my @not_pattern_re = ();        # exclude pattern
 
 # Valid block names (keys in blocks hash)
-my %valid_blockname = ( constraints => 1, memory => 1 );
+my %valid_blockname = ( constraints => 1, memory => 1, post => 1 );
 
 my $lastprog;
 my $proglen;
diff --git a/risugen_m68k.pm b/risugen_m68k.pm
index a9a4341..60223f0 100644
--- a/risugen_m68k.pm
+++ b/risugen_m68k.pm
@@ -161,6 +161,7 @@ sub gen_one_insn($$)
         my $fixedbits = $rec->{fixedbits};
         my $fixedbitmask = $rec->{fixedbitmask};
         my $constraint = $rec->{blocks}{"constraints"};
+        my $post = $rec->{blocks}{"post"};
         my $memblock = $rec->{blocks}{"memory"};
 
         $insn &= ~$fixedbitmask;
@@ -194,6 +195,9 @@ sub gen_one_insn($$)
         if ($insnwidth == 32) {
             insn16($insn & 0xffff);
         }
+        if (defined $post) {
+            eval_with_fields($insnname, $insn, $rec, "post", $post);
+        }
 
         return;
     }
-- 
2.9.3
