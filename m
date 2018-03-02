Received: from eggs.gnu.org ([2001:4830:134:3::10]:43565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWm-00035n-Cg
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWk-00050V-P8
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:04 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWk-0004y8-E9
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:02 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWj-0001PJ-4n
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:07:01 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:29 +0000
Message-Id: <20180302110640.28004-29-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 28/39] target/arm: Decode aa64 armv8.1 three
 same extra
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180228193125.20577-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        |  9 +++++
 target/arm/translate-a64.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/vec_helper.c    | 74 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 2075c143d7..7f0d3b2d84 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -569,6 +569,15 @@ DEF_HELPER_2(dc_zva, void, env, i64)
 DEF_HELPER_FLAGS_2(neon_pmull_64_lo, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(neon_pmull_64_hi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
+DEF_HELPER_FLAGS_5(gvec_qrdmlah_s16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_qrdmlah_s32, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s32, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #endif
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 746ab0e63a..ae16313eb0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -701,6 +701,18 @@ static void gen_gvec_op3(DisasContext *s, bool is_q, int rd,
                    vec_full_reg_size(s), gvec_op);
 }
 
+/* Expand a 3-operand + env pointer operation using
+ * an out-of-line helper.
+ */
+static void gen_gvec_op3_env(DisasContext *s, bool is_q, int rd,
+                             int rn, int rm, gen_helper_gvec_3_ptr *fn)
+{
+    tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       vec_full_reg_offset(s, rm), cpu_env,
+                       is_q ? 16 : 8, vec_full_reg_size(s), 0, fn);
+}
+
 /* Set ZF and NF based on a 64 bit result. This is alas fiddlier
  * than the 32 bit equivalent.
  */
@@ -10789,6 +10801,76 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     clear_vec_high(s, is_q, rd);
 }
 
+/* AdvSIMD three same extra
+ *  31   30  29 28       24 23  22  21 20  16  15 14    11  10 9  5 4  0
+ * +---+---+---+-----------+------+---+------+---+--------+---+----+----+
+ * | 0 | Q | U | 0 1 1 1 0 | size | 0 |  Rm  | 1 | opcode | 1 | Rn | Rd |
+ * +---+---+---+-----------+------+---+------+---+--------+---+----+----+
+ */
+static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
+{
+    int rd = extract32(insn, 0, 5);
+    int rn = extract32(insn, 5, 5);
+    int opcode = extract32(insn, 11, 4);
+    int rm = extract32(insn, 16, 5);
+    int size = extract32(insn, 22, 2);
+    bool u = extract32(insn, 29, 1);
+    bool is_q = extract32(insn, 30, 1);
+    int feature;
+
+    switch (u * 16 + opcode) {
+    case 0x10: /* SQRDMLAH (vector) */
+    case 0x11: /* SQRDMLSH (vector) */
+        if (size != 1 && size != 2) {
+            unallocated_encoding(s);
+            return;
+        }
+        feature = ARM_FEATURE_V8_RDM;
+        break;
+    default:
+        unallocated_encoding(s);
+        return;
+    }
+    if (!arm_dc_feature(s, feature)) {
+        unallocated_encoding(s);
+        return;
+    }
+    if (!fp_access_check(s)) {
+        return;
+    }
+
+    switch (opcode) {
+    case 0x0: /* SQRDMLAH (vector) */
+        switch (size) {
+        case 1:
+            gen_gvec_op3_env(s, is_q, rd, rn, rm, gen_helper_gvec_qrdmlah_s16);
+            break;
+        case 2:
+            gen_gvec_op3_env(s, is_q, rd, rn, rm, gen_helper_gvec_qrdmlah_s32);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        return;
+
+    case 0x1: /* SQRDMLSH (vector) */
+        switch (size) {
+        case 1:
+            gen_gvec_op3_env(s, is_q, rd, rn, rm, gen_helper_gvec_qrdmlsh_s16);
+            break;
+        case 2:
+            gen_gvec_op3_env(s, is_q, rd, rn, rm, gen_helper_gvec_qrdmlsh_s32);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        return;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
                                   int size, int rn, int rd)
 {
@@ -12869,6 +12951,7 @@ static void disas_crypto_three_reg_imm2(DisasContext *s, uint32_t insn)
 static const AArch64DecodeTable data_proc_simd[] = {
     /* pattern  ,  mask     ,  fn                        */
     { 0x0e200400, 0x9f200400, disas_simd_three_reg_same },
+    { 0x0e008400, 0x9f208400, disas_simd_three_reg_same_extra },
     { 0x0e200000, 0x9f200c00, disas_simd_three_reg_diff },
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
     { 0x0e300800, 0x9f3e0c00, disas_simd_across_lanes },
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 9febdff69c..3072df4d77 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -26,6 +26,16 @@
 
 #define SET_QC() env->vfp.xregs[ARM_VFP_FPSCR] |= CPSR_Q
 
+static void clear_tail(void *vd, uintptr_t opr_sz, uintptr_t max_sz)
+{
+    uint64_t *d = vd + opr_sz;
+    uintptr_t i;
+
+    for (i = opr_sz; i < max_sz; i += 8) {
+        *d++ = 0;
+    }
+}
+
 /* Signed saturating rounding doubling multiply-accumulate high half, 16-bit */
 static uint16_t inl_qrdmlah_s16(CPUARMState *env, int16_t src1,
                                 int16_t src2, int16_t src3)
@@ -52,6 +62,22 @@ uint32_t HELPER(neon_qrdmlah_s16)(CPUARMState *env, uint32_t src1,
     return deposit32(e1, 16, 16, e2);
 }
 
+void HELPER(gvec_qrdmlah_s16)(void *vd, void *vn, void *vm,
+                              void *ve, uint32_t desc)
+{
+    uintptr_t opr_sz = simd_oprsz(desc);
+    int16_t *d = vd;
+    int16_t *n = vn;
+    int16_t *m = vm;
+    CPUARMState *env = ve;
+    uintptr_t i;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        d[i] = inl_qrdmlah_s16(env, n[i], m[i], d[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 /* Signed saturating rounding doubling multiply-subtract high half, 16-bit */
 static uint16_t inl_qrdmlsh_s16(CPUARMState *env, int16_t src1,
                                 int16_t src2, int16_t src3)
@@ -78,6 +104,22 @@ uint32_t HELPER(neon_qrdmlsh_s16)(CPUARMState *env, uint32_t src1,
     return deposit32(e1, 16, 16, e2);
 }
 
+void HELPER(gvec_qrdmlsh_s16)(void *vd, void *vn, void *vm,
+                              void *ve, uint32_t desc)
+{
+    uintptr_t opr_sz = simd_oprsz(desc);
+    int16_t *d = vd;
+    int16_t *n = vn;
+    int16_t *m = vm;
+    CPUARMState *env = ve;
+    uintptr_t i;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        d[i] = inl_qrdmlsh_s16(env, n[i], m[i], d[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 /* Signed saturating rounding doubling multiply-accumulate high half, 32-bit */
 uint32_t HELPER(neon_qrdmlah_s32)(CPUARMState *env, int32_t src1,
                                   int32_t src2, int32_t src3)
@@ -93,6 +135,22 @@ uint32_t HELPER(neon_qrdmlah_s32)(CPUARMState *env, int32_t src1,
     return ret;
 }
 
+void HELPER(gvec_qrdmlah_s32)(void *vd, void *vn, void *vm,
+                              void *ve, uint32_t desc)
+{
+    uintptr_t opr_sz = simd_oprsz(desc);
+    int32_t *d = vd;
+    int32_t *n = vn;
+    int32_t *m = vm;
+    CPUARMState *env = ve;
+    uintptr_t i;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = helper_neon_qrdmlah_s32(env, n[i], m[i], d[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 /* Signed saturating rounding doubling multiply-subtract high half, 32-bit */
 uint32_t HELPER(neon_qrdmlsh_s32)(CPUARMState *env, int32_t src1,
                                   int32_t src2, int32_t src3)
@@ -107,3 +165,19 @@ uint32_t HELPER(neon_qrdmlsh_s32)(CPUARMState *env, int32_t src1,
     }
     return ret;
 }
+
+void HELPER(gvec_qrdmlsh_s32)(void *vd, void *vn, void *vm,
+                              void *ve, uint32_t desc)
+{
+    uintptr_t opr_sz = simd_oprsz(desc);
+    int32_t *d = vd;
+    int32_t *n = vn;
+    int32_t *m = vm;
+    CPUARMState *env = ve;
+    uintptr_t i;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = helper_neon_qrdmlsh_s32(env, n[i], m[i], d[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
-- 
2.16.2
