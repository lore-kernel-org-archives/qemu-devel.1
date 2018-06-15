Received: from eggs.gnu.org ([2001:4830:134:3::10]:32891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfk-0001wY-A0
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfi-0006Qw-Km
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:52 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfi-0006PV-B6
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:50 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfh-0003qJ-34
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:49 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:25:14 +0100
Message-Id: <20180615142521.19143-37-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 36/43] target/arm: Implement SVE Floating Point
 Arithmetic - Unpredicated Group
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
Message-id: 20180613015641.5667-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    | 14 ++++++++
 target/arm/helper.h        | 19 +++++++++++
 target/arm/translate-sve.c | 42 +++++++++++++++++++++++
 target/arm/vec_helper.c    | 69 ++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      | 10 ++++++
 5 files changed, 154 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 97bfe0f47b9..2e760849927 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -705,3 +705,17 @@ DEF_HELPER_FLAGS_4(sve_umini_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_umini_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_umini_s, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_umini_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_5(gvec_recps_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_recps_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_recps_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_rsqrts_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_rsqrts_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_rsqrts_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 0c6a1444585..879a7229e99 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -601,6 +601,25 @@ DEF_HELPER_FLAGS_5(gvec_fcmlas_idx, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_fcmlad, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fsub_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmul_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmul_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmul_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_ftsmul_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index afd0b1638dc..226c97579ce 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3372,6 +3372,48 @@ DO_ZZI(UMIN, umin)
 
 #undef DO_ZZI
 
+/*
+ *** SVE Floating Point Arithmetic - Unpredicated Group
+ */
+
+static bool do_zzz_fp(DisasContext *s, arg_rrr_esz *a,
+                      gen_helper_gvec_3_ptr *fn)
+{
+    if (fn == NULL) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           status, vsz, vsz, 0, fn);
+        tcg_temp_free_ptr(status);
+    }
+    return true;
+}
+
+
+#define DO_FP3(NAME, name) \
+static bool trans_##NAME(DisasContext *s, arg_rrr_esz *a, uint32_t insn) \
+{                                                                   \
+    static gen_helper_gvec_3_ptr * const fns[4] = {                 \
+        NULL, gen_helper_gvec_##name##_h,                           \
+        gen_helper_gvec_##name##_s, gen_helper_gvec_##name##_d      \
+    };                                                              \
+    return do_zzz_fp(s, a, fns[a->esz]);                            \
+}
+
+DO_FP3(FADD_zzz, fadd)
+DO_FP3(FSUB_zzz, fsub)
+DO_FP3(FMUL_zzz, fmul)
+DO_FP3(FTSMUL, ftsmul)
+DO_FP3(FRECPS, recps)
+DO_FP3(FRSQRTS, rsqrts)
+
+#undef DO_FP3
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 25e209da314..f504dd53c8f 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -426,3 +426,72 @@ void HELPER(gvec_fcmlad)(void *vd, void *vn, void *vm,
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
+
+/* Floating-point trigonometric starting value.
+ * See the ARM ARM pseudocode function FPTrigSMul.
+ */
+static float16 float16_ftsmul(float16 op1, uint16_t op2, float_status *stat)
+{
+    float16 result = float16_mul(op1, op1, stat);
+    if (!float16_is_any_nan(result)) {
+        result = float16_set_sign(result, op2 & 1);
+    }
+    return result;
+}
+
+static float32 float32_ftsmul(float32 op1, uint32_t op2, float_status *stat)
+{
+    float32 result = float32_mul(op1, op1, stat);
+    if (!float32_is_any_nan(result)) {
+        result = float32_set_sign(result, op2 & 1);
+    }
+    return result;
+}
+
+static float64 float64_ftsmul(float64 op1, uint64_t op2, float_status *stat)
+{
+    float64 result = float64_mul(op1, op1, stat);
+    if (!float64_is_any_nan(result)) {
+        result = float64_set_sign(result, op2 & 1);
+    }
+    return result;
+}
+
+#define DO_3OP(NAME, FUNC, TYPE) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
+{                                                                          \
+    intptr_t i, oprsz = simd_oprsz(desc);                                  \
+    TYPE *d = vd, *n = vn, *m = vm;                                        \
+    for (i = 0; i < oprsz / sizeof(TYPE); i++) {                           \
+        d[i] = FUNC(n[i], m[i], stat);                                     \
+    }                                                                      \
+}
+
+DO_3OP(gvec_fadd_h, float16_add, float16)
+DO_3OP(gvec_fadd_s, float32_add, float32)
+DO_3OP(gvec_fadd_d, float64_add, float64)
+
+DO_3OP(gvec_fsub_h, float16_sub, float16)
+DO_3OP(gvec_fsub_s, float32_sub, float32)
+DO_3OP(gvec_fsub_d, float64_sub, float64)
+
+DO_3OP(gvec_fmul_h, float16_mul, float16)
+DO_3OP(gvec_fmul_s, float32_mul, float32)
+DO_3OP(gvec_fmul_d, float64_mul, float64)
+
+DO_3OP(gvec_ftsmul_h, float16_ftsmul, float16)
+DO_3OP(gvec_ftsmul_s, float32_ftsmul, float32)
+DO_3OP(gvec_ftsmul_d, float64_ftsmul, float64)
+
+#ifdef TARGET_AARCH64
+
+DO_3OP(gvec_recps_h, helper_recpsf_f16, float16)
+DO_3OP(gvec_recps_s, helper_recpsf_f32, float32)
+DO_3OP(gvec_recps_d, helper_recpsf_f64, float64)
+
+DO_3OP(gvec_rsqrts_h, helper_rsqrtsf_f16, float16)
+DO_3OP(gvec_rsqrts_s, helper_rsqrtsf_f32, float32)
+DO_3OP(gvec_rsqrts_d, helper_rsqrtsf_f64, float64)
+
+#endif
+#undef DO_3OP
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index eee8726bdfe..6f436f9096d 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -648,6 +648,16 @@ UMIN_zzi        00100101 .. 101 011 110 ........ .....          @rdn_i8u
 # SVE integer multiply immediate (unpredicated)
 MUL_zzi         00100101 .. 110 000 110 ........ .....          @rdn_i8s
 
+### SVE Floating Point Arithmetic - Unpredicated Group
+
+# SVE floating-point arithmetic (unpredicated)
+FADD_zzz        01100101 .. 0 ..... 000 000 ..... .....         @rd_rn_rm
+FSUB_zzz        01100101 .. 0 ..... 000 001 ..... .....         @rd_rn_rm
+FMUL_zzz        01100101 .. 0 ..... 000 010 ..... .....         @rd_rn_rm
+FTSMUL          01100101 .. 0 ..... 000 011 ..... .....         @rd_rn_rm
+FRECPS          01100101 .. 0 ..... 000 110 ..... .....         @rd_rn_rm
+FRSQRTS         01100101 .. 0 ..... 000 111 ..... .....         @rd_rn_rm
+
 ### SVE Memory - 32-bit Gather and Unsized Contiguous Group
 
 # SVE load predicate register
-- 
2.17.1
