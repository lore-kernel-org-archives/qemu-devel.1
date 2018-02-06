Received: from eggs.gnu.org ([2001:4830:134:3::10]:38115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ej1f9-0006hp-Po
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ej1f6-0004L9-Fl
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:43:47 -0500
Received: from mail.ispras.ru ([83.149.199.45]:52038)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ej1f6-0004Iw-3Y
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:43:44 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 06 Feb 2018 14:43:43 +0300
Message-ID: <20180206114343.13816.78250.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3] m68k: implement movep instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: huth@tuxfamily.org, dovgaluk@ispras.ru, laurent@vivier.eu, pavel.dovgaluk@ispras.ru

This patch implements movep instruction. It moves data between a data register
and alternate bytes within the address space starting at the location
specified and incrementing by two.

It was designed for the original 68000 and used in firmwares for
interfacing the 8-bit peripherals through the 16-bit data bus.
Without this patch opcode for this instruction is recognized as some bitop.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>

--

v3: - simplified movep function code
    - joined movep masks

v2: - disabled movep for Coldfire
    - fixed gen_store/load usage
---
 target/m68k/cpu.c       |    2 ++
 target/m68k/cpu.h       |    1 +
 target/m68k/translate.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 98919b3..461db85 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -113,6 +113,7 @@ static void m68000_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_M68000);
     m68k_set_feature(env, M68K_FEATURE_USP);
     m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
+    m68k_set_feature(env, M68K_FEATURE_MOVEP);
 }
 
 static void m68020_cpu_initfn(Object *obj)
@@ -135,6 +136,7 @@ static void m68020_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_BKPT);
     m68k_set_feature(env, M68K_FEATURE_RTD);
     m68k_set_feature(env, M68K_FEATURE_CHK2);
+    m68k_set_feature(env, M68K_FEATURE_MOVEP);
 }
 #define m68030_cpu_initfn m68020_cpu_initfn
 
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 627fb78..1d79885 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -492,6 +492,7 @@ enum m68k_features {
     M68K_FEATURE_RTD,
     M68K_FEATURE_CHK2,
     M68K_FEATURE_M68040, /* instructions specific to MC68040 */
+    M68K_FEATURE_MOVEP,
 };
 
 static inline int m68k_feature(CPUM68KState *env, int feature)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 34db97b..00e3efe 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2078,6 +2078,51 @@ DISAS_INSN(movem)
     tcg_temp_free(addr);
 }
 
+DISAS_INSN(movep)
+{
+    uint8_t i;
+    int16_t displ;
+    TCGv reg;
+    TCGv addr;
+    TCGv abuf;
+    TCGv dbuf;
+
+    displ = read_im16(env, s);
+
+    addr = AREG(insn, 0);
+    reg = DREG(insn, 9);
+
+    abuf = tcg_temp_new();
+    tcg_gen_addi_i32(abuf, addr, displ);
+    dbuf = tcg_temp_new();
+
+    if (insn & 0x40) {
+        i = 4;
+    } else {
+        i = 2;
+    }
+
+    if (insn & 0x80) {
+        for ( ; i > 0 ; i--) {
+            tcg_gen_shri_i32(dbuf, reg, (i - 1) * 8);
+            tcg_gen_qemu_st8(dbuf, abuf, IS_USER(s));
+            if (i > 1) {
+                tcg_gen_addi_i32(abuf, abuf, 2);
+            }
+        }
+    } else {
+        for ( ; i > 0 ; i--) {
+            tcg_gen_qemu_ld8u(dbuf, abuf, IS_USER(s));
+            tcg_gen_deposit_i32(reg, reg, dbuf, i * 8, 8);
+            if (i > 1) {
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
@@ -5678,6 +5723,7 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(bitop_reg, 0140, f1c0);
     BASE(bitop_reg, 0180, f1c0);
     BASE(bitop_reg, 01c0, f1c0);
+    INSN(movep,     0108, f138, MOVEP);
     INSN(arith_im,  0280, fff8, CF_ISA_A);
     INSN(arith_im,  0200, ff00, M68000);
     INSN(undef,     02c0, ffc0, M68000);
