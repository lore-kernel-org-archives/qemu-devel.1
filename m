Received: from eggs.gnu.org ([2001:4830:134:3::10]:45454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkhA-0007Ua-Sd
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkh7-00085g-H0
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:41:00 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:50988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cKkh7-000844-5a
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:57 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 24 Dec 2016 12:40:31 +0100
Message-Id: <1482579633-3393-11-git-send-email-laurent@vivier.eu>
In-Reply-To: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
References: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 10/12] target-m68k: Inline shifts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

From: Richard Henderson <rth@twiddle.net>

Also manage word and byte operands and fix the computation of
overflow in the case of M68000 arithmetic shifts.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <1478699171-10637-4-git-send-email-rth@twiddle.net>
---
 target/m68k/helper.c    |  52 -----------
 target/m68k/helper.h    |   3 -
 target/m68k/translate.c | 226 ++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 201 insertions(+), 80 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 7aed9ff..f750d3d 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -284,58 +284,6 @@ void HELPER(set_sr)(CPUM68KState *env, uint32_t val)
     m68k_switch_sp(env);
 }
 
-uint32_t HELPER(shl_cc)(CPUM68KState *env, uint32_t val, uint32_t shift)
-{
-    uint64_t result;
-
-    shift &= 63;
-    result = (uint64_t)val << shift;
-
-    env->cc_c = (result >> 32) & 1;
-    env->cc_n = result;
-    env->cc_z = result;
-    env->cc_v = 0;
-    env->cc_x = shift ? env->cc_c : env->cc_x;
-
-    return result;
-}
-
-uint32_t HELPER(shr_cc)(CPUM68KState *env, uint32_t val, uint32_t shift)
-{
-    uint64_t temp;
-    uint32_t result;
-
-    shift &= 63;
-    temp = (uint64_t)val << 32 >> shift;
-    result = temp >> 32;
-
-    env->cc_c = (temp >> 31) & 1;
-    env->cc_n = result;
-    env->cc_z = result;
-    env->cc_v = 0;
-    env->cc_x = shift ? env->cc_c : env->cc_x;
-
-    return result;
-}
-
-uint32_t HELPER(sar_cc)(CPUM68KState *env, uint32_t val, uint32_t shift)
-{
-    uint64_t temp;
-    uint32_t result;
-
-    shift &= 63;
-    temp = (int64_t)val << 32 >> shift;
-    result = temp >> 32;
-
-    env->cc_c = (temp >> 31) & 1;
-    env->cc_n = result;
-    env->cc_z = result;
-    env->cc_v = result ^ val;
-    env->cc_x = shift ? env->cc_c : env->cc_x;
-
-    return result;
-}
-
 /* FPU helpers.  */
 uint32_t HELPER(f64_to_i32)(CPUM68KState *env, float64 val)
 {
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index a6f88fc..17ec342 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -7,9 +7,6 @@ DEF_HELPER_4(divul, void, env, int, int, i32)
 DEF_HELPER_4(divsl, void, env, int, int, s32)
 DEF_HELPER_4(divull, void, env, int, int, i32)
 DEF_HELPER_4(divsll, void, env, int, int, s32)
-DEF_HELPER_3(shl_cc, i32, env, i32, i32)
-DEF_HELPER_3(shr_cc, i32, env, i32, i32)
-DEF_HELPER_3(sar_cc, i32, env, i32, i32)
 DEF_HELPER_2(set_sr, void, env, i32)
 DEF_HELPER_3(movec, void, env, i32, i32)
 DEF_HELPER_4(cas2w, void, env, i32, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 0417c32..76c77ee 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2883,48 +2883,217 @@ DISAS_INSN(addx_mem)
     gen_store(s, opsize, addr_dest, QREG_CC_N);
 }
 
-/* TODO: This could be implemented without helper functions.  */
-DISAS_INSN(shift_im)
+static inline void shift_im(DisasContext *s, uint16_t insn, int opsize)
 {
-    TCGv reg;
-    int tmp;
-    TCGv shift;
+    int count = (insn >> 9) & 7;
+    int logical = insn & 8;
+    int left = insn & 0x100;
+    int bits = opsize_bytes(opsize) * 8;
+    TCGv reg = gen_extend(DREG(insn, 0), opsize, !logical);
+
+    if (count == 0) {
+        count = 8;
+    }
+
+    tcg_gen_movi_i32(QREG_CC_V, 0);
+    if (left) {
+        tcg_gen_shri_i32(QREG_CC_C, reg, bits - count);
+        tcg_gen_shli_i32(QREG_CC_N, reg, count);
+
+        /* Note that ColdFire always clears V (done above),
+           while M68000 sets if the most significant bit is changed at
+           any time during the shift operation */
+        if (!logical && m68k_feature(s->env, M68K_FEATURE_M68000)) {
+            /* if shift count >= bits, V is (reg != 0) */
+            if (count >= bits) {
+                tcg_gen_setcond_i32(TCG_COND_NE, QREG_CC_V, reg, QREG_CC_V);
+            } else {
+                TCGv t0 = tcg_temp_new();
+                tcg_gen_sari_i32(QREG_CC_V, reg, bits - 1);
+                tcg_gen_sari_i32(t0, reg, bits - count - 1);
+                tcg_gen_setcond_i32(TCG_COND_NE, QREG_CC_V, QREG_CC_V, t0);
+                tcg_temp_free(t0);
+            }
+            tcg_gen_neg_i32(QREG_CC_V, QREG_CC_V);
+        }
+    } else {
+        tcg_gen_shri_i32(QREG_CC_C, reg, count - 1);
+        if (logical) {
+            tcg_gen_shri_i32(QREG_CC_N, reg, count);
+        } else {
+            tcg_gen_sari_i32(QREG_CC_N, reg, count);
+        }
+    }
+
+    gen_ext(QREG_CC_N, QREG_CC_N, opsize, 1);
+    tcg_gen_andi_i32(QREG_CC_C, QREG_CC_C, 1);
+    tcg_gen_mov_i32(QREG_CC_Z, QREG_CC_N);
+    tcg_gen_mov_i32(QREG_CC_X, QREG_CC_C);
 
+    gen_partset_reg(opsize, DREG(insn, 0), QREG_CC_N);
     set_cc_op(s, CC_OP_FLAGS);
+}
 
-    reg = DREG(insn, 0);
-    tmp = (insn >> 9) & 7;
-    if (tmp == 0)
-        tmp = 8;
-    shift = tcg_const_i32(tmp);
-    /* No need to flush flags becuse we know we will set C flag.  */
-    if (insn & 0x100) {
-        gen_helper_shl_cc(reg, cpu_env, reg, shift);
+static inline void shift_reg(DisasContext *s, uint16_t insn, int opsize)
+{
+    int logical = insn & 8;
+    int left = insn & 0x100;
+    int bits = opsize_bytes(opsize) * 8;
+    TCGv reg = gen_extend(DREG(insn, 0), opsize, !logical);
+    TCGv s32;
+    TCGv_i64 t64, s64;
+
+    t64 = tcg_temp_new_i64();
+    s64 = tcg_temp_new_i64();
+    s32 = tcg_temp_new();
+
+    /* Note that m68k truncates the shift count modulo 64, not 32.
+       In addition, a 64-bit shift makes it easy to find "the last
+       bit shifted out", for the carry flag.  */
+    tcg_gen_andi_i32(s32, DREG(insn, 9), 63);
+    tcg_gen_extu_i32_i64(s64, s32);
+    tcg_gen_extu_i32_i64(t64, reg);
+
+    /* Optimistically set V=0.  Also used as a zero source below.  */
+    tcg_gen_movi_i32(QREG_CC_V, 0);
+    if (left) {
+        tcg_gen_shl_i64(t64, t64, s64);
+
+        if (opsize == OS_LONG) {
+            tcg_gen_extr_i64_i32(QREG_CC_N, QREG_CC_C, t64);
+            /* Note that C=0 if shift count is 0, and we get that for free.  */
+        } else {
+            TCGv zero = tcg_const_i32(0);
+            tcg_gen_extrl_i64_i32(QREG_CC_N, t64);
+            tcg_gen_shri_i32(QREG_CC_C, QREG_CC_N, bits);
+            tcg_gen_movcond_i32(TCG_COND_EQ, QREG_CC_C,
+                                s32, zero, zero, QREG_CC_C);
+            tcg_temp_free(zero);
+        }
+        tcg_gen_andi_i32(QREG_CC_C, QREG_CC_C, 1);
+
+        /* X = C, but only if the shift count was non-zero.  */
+        tcg_gen_movcond_i32(TCG_COND_NE, QREG_CC_X, s32, QREG_CC_V,
+                            QREG_CC_C, QREG_CC_X);
+
+        /* M68000 sets V if the most significant bit is changed at
+         * any time during the shift operation.  Do this via creating
+         * an extension of the sign bit, comparing, and discarding
+         * the bits below the sign bit.  I.e.
+         *     int64_t s = (intN_t)reg;
+         *     int64_t t = (int64_t)(intN_t)reg << count;
+         *     V = ((s ^ t) & (-1 << (bits - 1))) != 0
+         */
+        if (!logical && m68k_feature(s->env, M68K_FEATURE_M68000)) {
+            TCGv_i64 tt = tcg_const_i64(32);
+            /* if shift is greater than 32, use 32 */
+            tcg_gen_movcond_i64(TCG_COND_GT, s64, s64, tt, tt, s64);
+            tcg_temp_free_i64(tt);
+            /* Sign extend the input to 64 bits; re-do the shift.  */
+            tcg_gen_ext_i32_i64(t64, reg);
+            tcg_gen_shl_i64(s64, t64, s64);
+            /* Clear all bits that are unchanged.  */
+            tcg_gen_xor_i64(t64, t64, s64);
+            /* Ignore the bits below the sign bit.  */
+            tcg_gen_andi_i64(t64, t64, -1ULL << (bits - 1));
+            /* If any bits remain set, we have overflow.  */
+            tcg_gen_setcondi_i64(TCG_COND_NE, t64, t64, 0);
+            tcg_gen_extrl_i64_i32(QREG_CC_V, t64);
+            tcg_gen_neg_i32(QREG_CC_V, QREG_CC_V);
+        }
     } else {
-        if (insn & 8) {
-            gen_helper_shr_cc(reg, cpu_env, reg, shift);
+        tcg_gen_shli_i64(t64, t64, 32);
+        if (logical) {
+            tcg_gen_shr_i64(t64, t64, s64);
         } else {
-            gen_helper_sar_cc(reg, cpu_env, reg, shift);
+            tcg_gen_sar_i64(t64, t64, s64);
         }
+        tcg_gen_extr_i64_i32(QREG_CC_C, QREG_CC_N, t64);
+
+        /* Note that C=0 if shift count is 0, and we get that for free.  */
+        tcg_gen_shri_i32(QREG_CC_C, QREG_CC_C, 31);
+
+        /* X = C, but only if the shift count was non-zero.  */
+        tcg_gen_movcond_i32(TCG_COND_NE, QREG_CC_X, s32, QREG_CC_V,
+                            QREG_CC_C, QREG_CC_X);
     }
+    gen_ext(QREG_CC_N, QREG_CC_N, opsize, 1);
+    tcg_gen_mov_i32(QREG_CC_Z, QREG_CC_N);
+
+    tcg_temp_free(s32);
+    tcg_temp_free_i64(s64);
+    tcg_temp_free_i64(t64);
+
+    /* Write back the result.  */
+    gen_partset_reg(opsize, DREG(insn, 0), QREG_CC_N);
+    set_cc_op(s, CC_OP_FLAGS);
+}
+
+DISAS_INSN(shift8_im)
+{
+    shift_im(s, insn, OS_BYTE);
+}
+
+DISAS_INSN(shift16_im)
+{
+    shift_im(s, insn, OS_WORD);
+}
+
+DISAS_INSN(shift_im)
+{
+    shift_im(s, insn, OS_LONG);
+}
+
+DISAS_INSN(shift8_reg)
+{
+    shift_reg(s, insn, OS_BYTE);
+}
+
+DISAS_INSN(shift16_reg)
+{
+    shift_reg(s, insn, OS_WORD);
 }
 
 DISAS_INSN(shift_reg)
 {
-    TCGv reg;
-    TCGv shift;
+    shift_reg(s, insn, OS_LONG);
+}
 
-    reg = DREG(insn, 0);
-    shift = DREG(insn, 9);
-    if (insn & 0x100) {
-        gen_helper_shl_cc(reg, cpu_env, reg, shift);
+DISAS_INSN(shift_mem)
+{
+    int logical = insn & 8;
+    int left = insn & 0x100;
+    TCGv src;
+    TCGv addr;
+
+    SRC_EA(env, src, OS_WORD, !logical, &addr);
+    tcg_gen_movi_i32(QREG_CC_V, 0);
+    if (left) {
+        tcg_gen_shri_i32(QREG_CC_C, src, 15);
+        tcg_gen_shli_i32(QREG_CC_N, src, 1);
+
+        /* Note that ColdFire always clears V,
+           while M68000 sets if the most significant bit is changed at
+           any time during the shift operation */
+        if (!logical && m68k_feature(s->env, M68K_FEATURE_M68000)) {
+            src = gen_extend(src, OS_WORD, 1);
+            tcg_gen_xor_i32(QREG_CC_V, QREG_CC_N, src);
+        }
     } else {
-        if (insn & 8) {
-            gen_helper_shr_cc(reg, cpu_env, reg, shift);
+        tcg_gen_mov_i32(QREG_CC_C, src);
+        if (logical) {
+            tcg_gen_shri_i32(QREG_CC_N, src, 1);
         } else {
-            gen_helper_sar_cc(reg, cpu_env, reg, shift);
+            tcg_gen_sari_i32(QREG_CC_N, src, 1);
         }
     }
+
+    gen_ext(QREG_CC_N, QREG_CC_N, OS_WORD, 1);
+    tcg_gen_andi_i32(QREG_CC_C, QREG_CC_C, 1);
+    tcg_gen_mov_i32(QREG_CC_Z, QREG_CC_N);
+    tcg_gen_mov_i32(QREG_CC_X, QREG_CC_C);
+
+    DEST_EA(env, insn, OS_WORD, QREG_CC_N, &addr);
     set_cc_op(s, CC_OP_FLAGS);
 }
 
@@ -4005,6 +4174,13 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(adda,      d0c0, f0c0, M68000);
     INSN(shift_im,  e080, f0f0, CF_ISA_A);
     INSN(shift_reg, e0a0, f0f0, CF_ISA_A);
+    INSN(shift8_im, e000, f0f0, M68000);
+    INSN(shift16_im, e040, f0f0, M68000);
+    INSN(shift_im,  e080, f0f0, M68000);
+    INSN(shift8_reg, e020, f0f0, M68000);
+    INSN(shift16_reg, e060, f0f0, M68000);
+    INSN(shift_reg, e0a0, f0f0, M68000);
+    INSN(shift_mem, e0c0, fcc0, M68000);
     INSN(undef_fpu, f000, f000, CF_ISA_A);
     INSN(fpu,       f200, ffc0, CF_FPU);
     INSN(fbcc,      f280, ffc0, CF_FPU);
-- 
2.7.4
