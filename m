Received: from eggs.gnu.org ([2001:4830:134:3::10]:60163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cbAag-0004vG-Pl
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:34:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cbAaa-0001V2-28
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:34:10 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:54713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cbAaZ-0001Ua-JH
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:34:03 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  7 Feb 2017 19:33:56 +0100
Message-Id: <20170207183356.17840-6-laurent@vivier.eu>
In-Reply-To: <20170207183356.17840-1-laurent@vivier.eu>
References: <20170207183356.17840-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 5/5] m68k: manage memory block
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

Add a new risu op to restore modified address register (OP_NORMALIZE)
and allow to manage several registers in the memory block

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 m68k.risu       | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 risu.h          |  1 +
 risu_m68k.c     |  5 +++
 risugen_m68k.pm | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 198 insertions(+), 3 deletions(-)

diff --git a/m68k.risu b/m68k.risu
index 4297283..dba9a5c 100644
--- a/m68k.risu
+++ b/m68k.risu
@@ -18,6 +18,9 @@ ABCD  M68000 1100 Dx:3 10000 0 Dy:3 \
 # add $dx,$dy
 ADD   M68000 1101 Dx:3 0 opmode:2 000 Dy:3 \
                  !constraints { $opmode != 0b11; }
+ADDm  M68000 1101 Dx:3 opmode:3 010 Ay:3 \
+                 !constraints { ($opmode & 0b11) != 0b11; } \
+                 !memory { reg($Ay); }
 # adda $dx, $ay
 ADDA  M68000 1101 Ax:3 size:1 11 000 Dy:3
 # addi #Imm, $dx
@@ -31,6 +34,9 @@ ADDQ  M68000 0101 imm:3 0 size:2 000 Dx:3 \
 # addx $dx,$dy
 ADDX  M68000 1101 Dx:3 1 size:2 00 0 Dy:3 \
                  !constraints { $size != 0b11; }
+ADDXm M68000 1101 Ax:3 1 size:2 00 1 Ay:3 \
+                 !constraints { $size != 0b11; } \
+                 !memory { reg($Ax); reg($Ay); } \
 # and $dx, $dy
 AND   M68000 1100 Dx:3 0 opmode:2 000 Dy:3 \
                  !constraints { $opmode != 0b11; }
@@ -48,29 +54,67 @@ ASx   M68000 1110 count:3 d:1 size:2 i:1 00 r:3 \
 # bchg $dx,$dy
 BCHG  M68000 0000 Dx:3 101 000 Dy:3
 BCHGI M68000 0000 100  001 000 Dx:3 0000000 data:9
+BCHGm M68000 0000 Dx:3 101 010 Ay:3 !memory { reg($Ay); }
 # blcr $dx,$dy
 BCLR  M68000 0000 Dx:3 110 000 Dy:3
 BCLRI M68000 0000 100  010 000 Dx:3 0000000 data:9
+BCLRm M68000 0000 Dx:3 110 010 Ay:3 !memory { reg($Ay); }
 # bfchg $dx,offset:width
 BFCHG M68020 1110101011 000 Dx:3 0000 Do:1 offset:5 Dw:1 width:5 \
                 !constraints { (!$Do || $offset < 8) &&          \
                                (!$Dw || $width < 8);             \
                              }
+BFCHGm M68020 1110101011 010 Ax:3 0000 Do:1 offset:5 Dw:1 width:5 \
+                !constraints { (!$Do || $offset < 8) &&          \
+                               (!$Dw || $width < 8);             \
+                             }                                   \
+                !memory { if ($Do) {                             \
+                              write_mov_di($offset, rand(2048) - 1024); \
+                          }                                             \
+                          reg($Ax);                                     \
+                        }
 # bfclr $dx,offset:width
 BFCLR M68020 1110110011 000 Dx:3 0000 Do:1 offset:5 Dw:1 width:5 \
                 !constraints { (!$Do || $offset < 8) &&          \
                                (!$Dw || $width < 8);             \
                              }
+BFCLRm M68020 1110110011 010 Ax:3 0000 Do:1 offset:5 Dw:1 width:5 \
+                !constraints { (!$Do || $offset < 8) &&          \
+                               (!$Dw || $width < 8);             \
+                             }                                   \
+                !memory { if ($Do) {                             \
+                              write_mov_di($offset, rand(2048) - 1024); \
+                          }                                             \
+                          reg($Ax);                                     \
+                        }
 # bfexts $dx,offset:width,$dy
 BFEXTS M68020 1110101111 000 Dx:3 0 Dy:3 Do:1 offset:5 Dw:1 width:5 \
                 !constraints { (!$Do || $offset < 8) &&          \
                                (!$Dw || $width < 8);             \
                              }
+BFEXTSm M68020 1110101111 010 Ax:3 0 Dy:3 Do:1 offset:5 Dw:1 width:5 \
+                !constraints { (!$Do || $offset < 8) &&          \
+                               (!$Dw || $width < 8);             \
+                             }                                   \
+                !memory { if ($Do) {                             \
+                              write_mov_di($offset, rand(2048) - 1024); \
+                          }                                             \
+                          reg($Ax);                                     \
+                        }
 # bfextu $dx,offset:width,$dy
 BFEXTU M68020 1110100111 000 Dx:3 0 Dy:3 Do:1 offset:5 Dw:1 width:5 \
                 !constraints { (!$Do || $offset < 8) &&          \
                                (!$Dw || $width < 8);             \
                              }
+BFEXTUm M68020 1110100111 010 Ax:3 0 Dy:3 Do:1 offset:5 Dw:1 width:5 \
+                !constraints { (!$Do || $offset < 8) &&          \
+                               (!$Dw || $width < 8);             \
+                             }                                   \
+                !memory { if ($Do) {                             \
+                              write_mov_di($offset, rand(2048) - 1024); \
+                          }                                             \
+                          reg($Ax);                                     \
+                        }
 # bfffo $dx,offset:width,$dy
 # there is a bug in 68040 with D(offset) > 31
 BFFFO M68020 1110110111 000 Dx:3 0 Dy:3 Do:1 offset:5 Dw:1 width:5    \
@@ -80,27 +124,73 @@ BFFFO M68020 1110110111 000 Dx:3 0 Dy:3 Do:1 offset:5 Dw:1 width:5    \
                                (!$Do || $offset < 8) &&          \
                                (!$Dw || $width < 8);             \
                              }
+BFFFOm M68020 1110110111 010 Ax:3 0 Dy:3 Do:1 offset:5 Dw:1 width:5    \
+                !constraints { (!$Do || $offset < 8) &&          \
+                               (!$Dw || $width < 8);             \
+                             }                                   \
+                !memory { if ($Do) {                             \
+                              write_mov_di($offset, rand(2048) - 1024); \
+                          }                                             \
+                          reg($Ax);                                     \
+                        }
 # bfins $dx,offset:width,$dy
 BFINS M68020 1110111111 000 Dx:3 0 Dy:3 Do:1 offset:5 Dw:1 width:5 \
                 !constraints { (!$Do || $offset < 8) &&          \
                                (!$Dw || $width < 8);             \
                              }
+BFINSm M68020 1110111111 010 Ax:3 0 Dy:3 Do:1 offset:5 Dw:1 width:5 \
+                !constraints { (!$Do || $offset < 8) &&          \
+                               (!$Dw || $width < 8);             \
+                             }                                   \
+                !memory { if ($Do) {                             \
+                              write_mov_di($offset, rand(2048) - 1024); \
+                          }                                             \
+                          reg($Ax);                                     \
+                        }
 # bfset $dx,offset:width
 BFSET M68020 1110111011 000 Dx:3 0000 Do:1 offset:5 Dw:1 width:5 \
                 !constraints { (!$Do || $offset < 8) &&          \
                                (!$Dw || $width < 8);             \
                              }
+BFSETm M68020 1110111011 010 Ax:3 0000 Do:1 offset:5 Dw:1 width:5 \
+                !constraints { (!$Do || $offset < 8) &&          \
+                               (!$Dw || $width < 8);             \
+                             }                                   \
+                !memory { if ($Do) {                             \
+                              write_mov_di($offset, rand(2048) - 1024); \
+                          }                                             \
+                          reg($Ax);                                     \
+                        }
 # bftst $dx,offset:width
 BFTST M68020 1110100011 000 Dx:3 0000 Do:1 offset:5 Dw:1 width:5 \
                 !constraints { (!$Do || $offset < 8) &&          \
                                (!$Dw || $width < 8);             \
                              }
+BFTSTm M68020 1110100011 010 Ax:3 0000 Do:1 offset:5 Dw:1 width:5 \
+                !constraints { (!$Do || $offset < 8) &&          \
+                               (!$Dw || $width < 8);             \
+                             }                                   \
+                !memory { if ($Do == 1) {                    \
+                              write_mov_di($offset, rand(2048) - 1024); \
+                          }                                 \
+                          reg($Ax);                         \
+                        }                                   \
 # bset $dx,$dy
 BSET  M68000 0000 Dx:3 111 000 Dy:3
 BSETI M68000 0000 100  011 000 Dx:3 0000000 data:9
 # btst $dx,$dy
 BTST  M68000 0000 Dx:3 100 000 Dy:3
 BTSTI M68000 0000 100  000 000 Dx:3 0000000 data:9
+# cas $dc,$du,($ax)
+CAS   M68020 00001 size:2 011 010 Ax:3 0000000 Du:3 000 Dc:3 \
+                 !constraints { $size != 0b00; } \
+                 !memory { reg($Ax); }
+CAS2  M68020 00001 size:2 011111100 \
+                 !memory { reg(0); reg(1); } \
+                 !constraints { $size == 0b10 || $size == 0b11; } \
+                 !post { insn16(0x8000 | (rand(8) << 6) | rand(8)); \
+                         insn16(0x9000 | (rand(8) << 6) | rand(8)); \
+                       }
 # clr $dx
 CLR   M68000 01000010 size:2 000 Dx:3 \
                  !constraints { $size != 0b11; }
@@ -114,6 +204,9 @@ CMPIB M68000 00001100 00 000 Dx:3 00000000 data:8
 CMPIW M68000 00001100 01 000 Dx:3 data:16
 CMPIL M68000 00001100 10 000 Dx:3 \
                  !post { insn32(rand(0xffffffff)); }
+# cmpm ($ay)+,$(ax)+
+CMPM  M68000 1011 Ax:3 1 size:2 001 Ay:3         \
+                 !memory { reg($Ax); reg($Ay); }
 # divs $dx,$dy
 DIVS  M68000 1000 Dy:3 111 000 Dx:3 \
                  !constraints { \
@@ -192,6 +285,11 @@ MOVEA M68000 00 size:2 Ay:3 001 000 Dx:3 \
 MOVEFROMCCR  M68010 0100001011 000 Dx:3
 # move $dx,ccr
 MOVETOCCR M68000 0100010011 000 Dx:3
+# movem list,($ax) movem ($ax),list
+MOVEM     M68000 01001 dir:1 001 size:1 010 Ax:3 list:16 \
+                 !constraints { !($list & (0xc000 | (1 << ($Ax + 8)))); } \
+                 !memory { reg($Ax); }
+
 # moveq #Imm8, $dx
 MOVEQ M68000 0111 Dx:3 0 data:8
 # muls $dx,$dy
diff --git a/risu.h b/risu.h
index 26ed834..794b5f1 100644
--- a/risu.h
+++ b/risu.h
@@ -33,6 +33,7 @@ extern int test_fp_exc;
 #define OP_SETMEMBLOCK 2
 #define OP_GETMEMBLOCK 3
 #define OP_COMPAREMEM 4
+#define OP_NORMALIZE 5
 
 /* The memory block should be this long */
 #define MEMBLOCKLEN 8192
diff --git a/risu_m68k.c b/risu_m68k.c
index 15e30b1..f47132c 100644
--- a/risu_m68k.c
+++ b/risu_m68k.c
@@ -60,6 +60,8 @@ int send_register_info(int sock, void *uc)
         break;
     case OP_COMPAREMEM:
         return send_data_pkt(sock, memblock, MEMBLOCKLEN);
+    case OP_NORMALIZE:
+        set_a0(uc, ri.gregs[R_A0] - (uintptr_t)memblock);
         break;
     }
     return 0;
@@ -108,6 +110,9 @@ int recv_and_compare_register_info(int sock, void *uc)
         }
         send_response_byte(sock, resp);
         break;
+    case OP_NORMALIZE:
+        set_a0(uc, master_ri.gregs[R_A0] - (uintptr_t)memblock);
+        break;
     }
     return resp;
 }
diff --git a/risugen_m68k.pm b/risugen_m68k.pm
index 60223f0..d57224b 100644
--- a/risugen_m68k.pm
+++ b/risugen_m68k.pm
@@ -104,6 +104,13 @@ sub write_mov_ri($$)
     }
 }
 
+sub write_exg_aa($$)
+{
+    my ($reg0, $reg1) = @_;
+
+    insn16(0xc148 | ($reg0 << 9) | $reg1);
+}
+
 sub write_random_regdata()
 {
     # general purpose registers (except A6 (FP) and A7 (SP))
@@ -116,9 +123,10 @@ sub write_random_regdata()
 
 my $OP_COMPARE = 0;        # compare registers
 my $OP_TESTEND = 1;        # end of test, stop
-my $OP_SETMEMBLOCK = 2;    # r0 is address of memory block (8192 bytes)
-my $OP_GETMEMBLOCK = 3;    # add the address of memory block to r0
+my $OP_SETMEMBLOCK = 2;    # a0 is address of memory block (8192 bytes)
+my $OP_GETMEMBLOCK = 3;    # add the address of memory block to a0
 my $OP_COMPAREMEM = 4;     # compare memory block
+my $OP_NORMALIZE = 5;      # normalize a0 between master and apprentice
 
 sub write_random_register_data()
 {
@@ -126,6 +134,73 @@ sub write_random_register_data()
     write_risuop($OP_COMPARE);
 }
 
+sub write_pc_addr($$)
+{
+    my ($ad, $imm) = @_;
+
+    # lea (pc)len, Ad
+
+    insn16(0x41fa | ($ad << 9));
+    insn16($imm + 2);
+}
+
+sub write_jmp_fwd($)
+{
+    my ($len) = @_;
+
+    # bra (pc)len
+    insn16(0x6000);
+    insn16($len + 2);
+}
+
+sub write_memblock_setup()
+{
+    my $datalen = 8192;
+
+    write_pc_addr(0, 8);
+    write_risuop($OP_SETMEMBLOCK); # 4 bytes
+    write_jmp_fwd($datalen);       # 4 bytes
+    for (my $i = 0; $i < $datalen / 2; $i++) {
+        insn16(rand(0x10000));
+    }
+}
+
+sub write_get_offset()
+{
+    my $offset = (rand(2048 - 256) + 128) & ~1;
+    write_mov_ai(0, $offset);
+    write_risuop($OP_GETMEMBLOCK);
+}
+
+my @basereg;
+
+sub reg($)
+{
+    my ($reg) = @_;
+
+    if ($reg != 0) {
+        write_exg_aa($reg, 0);
+        write_get_offset();
+        write_exg_aa(0, $reg);
+    } else {
+        write_get_offset();
+    }
+    push @basereg, $reg;
+}
+
+sub normalize($)
+{
+    my ($reg) = @_;
+
+    if ($reg != 0) {
+        write_exg_aa($reg, 0);
+        write_risuop($OP_NORMALIZE);
+        write_exg_aa(0, $reg);
+    } else {
+        write_risuop($OP_NORMALIZE);
+    }
+}
+
 sub eval_with_fields($$$$$) {
     # Evaluate the given block in an environment with Perl variables
     # set corresponding to the variable fields for the insn.
@@ -191,6 +266,10 @@ sub gen_one_insn($$)
         # OK, we got a good one
         $constraintfailures = 0;
 
+
+        if (defined $memblock) {
+            eval_with_fields($insnname, $insn, $rec, "memory", $memblock);
+        }
         insn16($insn >> 16);
         if ($insnwidth == 32) {
             insn16($insn & 0xffff);
@@ -198,7 +277,19 @@ sub gen_one_insn($$)
         if (defined $post) {
             eval_with_fields($insnname, $insn, $rec, "post", $post);
         }
-
+        if (defined $memblock) {
+            my $r0;
+            $r0 = pop @basereg;
+            if (defined $r0) {
+                my $r1;
+                normalize($r0);
+                $r1 = pop @basereg;
+                if (defined $r1 && $r1 != $r0) {
+                    normalize($r1);
+                }
+            }
+            write_risuop($OP_COMPAREMEM);
+        }
         return;
     }
 }
-- 
2.9.3
