Received: from eggs.gnu.org ([2001:4830:134:3::10]:52344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5UG-0003H4-1G
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5UA-0008NR-T7
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:28 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:35370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq5UA-0008Mo-L5
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:22 -0400
Received: by mail-pf0-x233.google.com with SMTP id g13so1630069pfm.2
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:41:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 15:40:47 -0700
Message-Id: <20170907224051.21518-20-richard.henderson@linaro.org>
In-Reply-To: <20170907224051.21518-1-richard.henderson@linaro.org>
References: <20170907224051.21518-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 19/23] tcg/arm: Use constant pool for movi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.h     |  1 +
 tcg/arm/tcg-target.inc.c | 92 ++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 2e92cb3283..94b3578c55 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -143,5 +143,6 @@ void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 #ifdef CONFIG_SOFTMMU
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
+#define TCG_TARGET_NEED_POOL_LABELS
 
 #endif
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 78603a19db..2736022d5a 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -23,6 +23,7 @@
  */
 
 #include "elf.h"
+#include "tcg-pool.inc.c"
 
 int arm_arch = __ARM_ARCH;
 
@@ -203,9 +204,39 @@ static inline void reloc_pc24_atomic(tcg_insn_unit *code_ptr, tcg_insn_unit *tar
 static void patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
-    tcg_debug_assert(type == R_ARM_PC24);
     tcg_debug_assert(addend == 0);
-    reloc_pc24(code_ptr, (tcg_insn_unit *)value);
+
+    if (type == R_ARM_PC24) {
+        reloc_pc24(code_ptr, (tcg_insn_unit *)value);
+    } else if (type == R_ARM_PC13) {
+        intptr_t diff = value - (uintptr_t)(code_ptr + 2);
+        tcg_insn_unit insn = *code_ptr;
+        bool u;
+
+        if (diff >= -0xfff && diff <= 0xfff) {
+            u = (diff >= 0);
+            if (!u) {
+                diff = -diff;
+            }
+        } else {
+            int rd = extract32(insn, 12, 4);
+            int rt = rd == TCG_REG_PC ? TCG_REG_TMP : rd;
+            assert(diff >= 0x1000 && diff < 0x100000);
+            /* add rt, pc, #high */
+            *code_ptr++ = ((insn & 0xf0000000) | (1 << 25) | ARITH_ADD
+                           | (TCG_REG_PC << 16) | (rt << 12)
+                           | (20 << 7) | (diff >> 12));
+            /* ldr rd, [rt, #low] */
+            insn = deposit32(insn, 12, 4, rt);
+            diff &= 0xfff;
+            u = 1;
+        }
+        insn = deposit32(insn, 23, 1, u);
+        insn = deposit32(insn, 0, 12, diff);
+        *code_ptr = insn;
+    } else {
+        g_assert_not_reached();
+    }
 }
 
 #define TCG_CT_CONST_ARM  0x100
@@ -581,9 +612,20 @@ static inline void tcg_out_ld8s_r(TCGContext *s, int cond, TCGReg rt,
     tcg_out_memop_r(s, cond, INSN_LDRSB_REG, rt, rn, rm, 1, 1, 0);
 }
 
+static void tcg_out_movi_pool(TCGContext *s, int cond, int rd, uint32_t arg)
+{
+    /* The 12-bit range on the ldr insn is sometimes a bit too small.
+       In order to get around that we require two insns, one of which
+       will usually be a nop, but may be replaced in patch_reloc.  */
+    new_pool_label(s, arg, R_ARM_PC13, s->code_ptr, 0);
+    tcg_out_ld32_12(s, cond, rd, TCG_REG_PC, 0);
+    tcg_out_nop(s);
+}
+
 static void tcg_out_movi32(TCGContext *s, int cond, int rd, uint32_t arg)
 {
-    int rot, opc, rn, diff;
+    int rot, diff, opc, sh1, sh2;
+    uint32_t tt0, tt1, tt2;
 
     /* Check a single MOV/MVN before anything else.  */
     rot = encode_imm(arg);
@@ -631,24 +673,30 @@ static void tcg_out_movi32(TCGContext *s, int cond, int rd, uint32_t arg)
         return;
     }
 
-    /* TODO: This is very suboptimal, we can easily have a constant
-       pool somewhere after all the instructions.  */
+    /* Look for sequences of two insns.  If we have lots of 1's, we can
+       shorten the sequence by beginning with mvn and then clearing
+       higher bits with eor.  */
+    tt0 = arg;
     opc = ARITH_MOV;
-    rn = 0;
-    /* If we have lots of leading 1's, we can shorten the sequence by
-       beginning with mvn and then clearing higher bits with eor.  */
-    if (clz32(~arg) > clz32(arg)) {
-        opc = ARITH_MVN, arg = ~arg;
+    if (ctpop32(arg) > 16) {
+        tt0 = ~arg;
+        opc = ARITH_MVN;
+    }
+    sh1 = ctz32(tt0) & ~1;
+    tt1 = tt0 & ~(0xff << sh1);
+    sh2 = ctz32(tt1) & ~1;
+    tt2 = tt1 & ~(0xff << sh2);
+    if (tt2 == 0) {
+        rot = ((32 - sh1) << 7) & 0xf00;
+        tcg_out_dat_imm(s, cond, opc, rd,  0, ((tt0 >> sh1) & 0xff) | rot);
+        rot = ((32 - sh2) << 7) & 0xf00;
+        tcg_out_dat_imm(s, cond, ARITH_EOR, rd, rd,
+                        ((tt0 >> sh2) & 0xff) | rot);
+        return;
     }
-    do {
-        int i = ctz32(arg) & ~1;
-        rot = ((32 - i) << 7) & 0xf00;
-        tcg_out_dat_imm(s, cond, opc, rd, rn, ((arg >> i) & 0xff) | rot);
-        arg &= ~(0xff << i);
 
-        opc = ARITH_EOR;
-        rn = rd;
-    } while (arg);
+    /* Otherwise, drop it into the constant pool.  */
+    tcg_out_movi_pool(s, cond, rd, arg);
 }
 
 static inline void tcg_out_dat_rI(TCGContext *s, int cond, int opc, TCGArg dst,
@@ -2164,6 +2212,14 @@ static inline void tcg_out_movi(TCGContext *s, TCGType type,
     tcg_out_movi32(s, COND_AL, ret, arg);
 }
 
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
+{
+    int i;
+    for (i = 0; i < count; ++i) {
+        p[i] = INSN_NOP;
+    }
+}
+
 /* Compute frame size via macros, to share between tcg_target_qemu_prologue
    and tcg_register_jit.  */
 
-- 
2.13.5
