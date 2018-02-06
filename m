Received: from eggs.gnu.org ([2001:4830:134:3::10]:36841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eizyy-0005KC-Ly
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eizyt-0006pF-O4
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:56:08 -0500
Received: from mail.ispras.ru ([83.149.199.45]:39852)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eizyt-0006p5-FU
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:56:03 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 06 Feb 2018 12:56:03 +0300
Message-ID: <20180206095603.26500.5959.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] m68k: implement movep instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dovgaluk@ispras.ru, laurent@vivier.eu, pavel.dovgaluk@ispras.ru

This patch implements movep instruction. It moves data between a data register
and alternate bytes within the address space starting at the location
specified and incrementing by two.

It was designed for the original 68000 and used in firmwares for
interfacing the 8-bit peripherals through the 16-bit data bus.
Without this patch opcode for this instruction is recognized as some bitop.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
---
 target/m68k/translate.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f0e86a7..a849c74 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2071,6 +2071,55 @@ DISAS_INSN(movem)
     tcg_temp_free(addr);
 }
 
+DISAS_INSN(movep)
+{
+    uint8_t i;
+    uint8_t op;
+    uint16_t displ;
+    TCGv reg;
+    TCGv addr;
+    TCGv abuf;
+    TCGv dbuf;
+
+    op = (insn >> 6) & 7;
+    displ = read_im16(env, s);
+
+    addr = AREG(insn, 0);
+    reg = DREG(insn, 9);
+
+    abuf = tcg_temp_new();
+    tcg_gen_addi_i32(abuf, addr, displ);
+    dbuf = tcg_temp_new();
+
+    if (op & 1) {
+        i = 4;
+    } else {
+        i = 2;
+    }
+
+    if (op & 2) {
+        for ( ; i > 0 ; i--) {
+            tcg_gen_shri_i32(dbuf, reg, (i - 1) * 8);
+            gen_store(s, OS_BYTE, abuf, dbuf);
+            if (i > 1) {
+                tcg_gen_addi_i32(abuf, abuf, 2);
+            }
+        }
+    } else {
+        tcg_gen_movi_i32(reg, 0);
+        for ( ; i > 0 ; i--) {
+            dbuf = gen_load(s, OS_BYTE, abuf, 1);
+            tcg_gen_or_i32(reg, reg, dbuf);
+            if (i > 1) {
+                tcg_gen_shli_i32(reg, reg, 8);
+                tcg_gen_addi_i32(abuf, abuf, 2);
+            }
+        }
+    }
+    tcg_temp_free(abuf);
+    tcg_temp_free(dbuf);
+}
+
 DISAS_INSN(bitop_im)
 {
     int opsize;
@@ -5579,9 +5628,13 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(chk2,      00c0, f9c0, CHK2);
     INSN(bitrev,    00c0, fff8, CF_ISA_APLUSC);
     BASE(bitop_reg, 0100, f1c0);
+    BASE(movep,     0108, f1f8);
     BASE(bitop_reg, 0140, f1c0);
+    BASE(movep,     0148, f1f8);
     BASE(bitop_reg, 0180, f1c0);
+    BASE(movep,     0188, f1f8);
     BASE(bitop_reg, 01c0, f1c0);
+    BASE(movep,     01c8, f1f8);
     INSN(arith_im,  0280, fff8, CF_ISA_A);
     INSN(arith_im,  0200, ff00, M68000);
     INSN(undef,     02c0, ffc0, M68000);
