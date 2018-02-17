Received: from eggs.gnu.org ([2001:4830:134:3::10]:41012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7AX-0001rI-Po
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7AW-0002GE-Lm
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:25:05 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:39714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en7AW-0002Fn-EL
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:25:04 -0500
Received: by mail-pg0-x242.google.com with SMTP id w17so4356674pgv.6
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:25:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:23:17 -0800
Message-Id: <20180217182323.25885-62-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 61/67] target/arm: Implement SVE Floating
 Point Unary Operations - Unpredicated Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  8 ++++++++
 target/arm/translate-sve.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 target/arm/vec_helper.c    | 20 ++++++++++++++++++++
 target/arm/sve.decode      |  5 +++++
 4 files changed, 76 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index a8d824b085..4bfefe42b2 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -565,6 +565,14 @@ DEF_HELPER_2(dc_zva, void, env, i64)
 DEF_HELPER_FLAGS_2(neon_pmull_64_lo, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(neon_pmull_64_hi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
+DEF_HELPER_FLAGS_4(gvec_frecpe_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_frecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_frecpe_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_frsqrte_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_frsqrte_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_frsqrte_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_fadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index a77ddf0f4b..463ff7b690 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3235,6 +3235,49 @@ DO_VPZ(FMAXNMV, fmaxnmv)
 DO_VPZ(FMINV, fminv)
 DO_VPZ(FMAXV, fmaxv)
 
+/*
+ *** SVE Floating Point Unary Operations - Unpredicated Group
+ */
+
+static void do_zz_fp(DisasContext *s, arg_rr_esz *a, gen_helper_gvec_2_ptr *fn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+
+    tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->rd),
+                       vec_full_reg_offset(s, a->rn),
+                       status, vsz, vsz, 0, fn);
+    tcg_temp_free_ptr(status);
+}
+
+static void trans_FRECPE(DisasContext *s, arg_rr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_2_ptr * const fns[3] = {
+        gen_helper_gvec_frecpe_h,
+        gen_helper_gvec_frecpe_s,
+        gen_helper_gvec_frecpe_d,
+    };
+    if (a->esz == 0) {
+        unallocated_encoding(s);
+    } else {
+        do_zz_fp(s, a, fns[a->esz - 1]);
+    }
+}
+
+static void trans_FRSQRTE(DisasContext *s, arg_rr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_2_ptr * const fns[3] = {
+        gen_helper_gvec_frsqrte_h,
+        gen_helper_gvec_frsqrte_s,
+        gen_helper_gvec_frsqrte_d,
+    };
+    if (a->esz == 0) {
+        unallocated_encoding(s);
+    } else {
+        do_zz_fp(s, a, fns[a->esz - 1]);
+    }
+}
+
 /*
  *** SVE Floating Point Accumulating Reduction Group
  */
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index e711a3217d..60dc07cf87 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -40,6 +40,26 @@
 #define H4(x)   (x)
 #endif
 
+#define DO_2OP(NAME, FUNC, TYPE) \
+void HELPER(NAME)(void *vd, void *vn, void *stat, uint32_t desc)  \
+{                                                                 \
+    intptr_t i, oprsz = simd_oprsz(desc);                         \
+    TYPE *d = vd, *n = vn;                                        \
+    for (i = 0; i < oprsz / sizeof(TYPE); i++) {                  \
+        d[i] = FUNC(n[i], stat);                                  \
+    }                                                             \
+}
+
+DO_2OP(gvec_frecpe_h, helper_recpe_f16, float16)
+DO_2OP(gvec_frecpe_s, helper_recpe_f32, float32)
+DO_2OP(gvec_frecpe_d, helper_recpe_f64, float64)
+
+DO_2OP(gvec_frsqrte_h, helper_rsqrte_f16, float16)
+DO_2OP(gvec_frsqrte_s, helper_rsqrte_f32, float32)
+DO_2OP(gvec_frsqrte_d, helper_rsqrte_f64, float64)
+
+#undef DO_2OP
+
 /* Floating-point trigonometric starting value.
  * See the ARM ARM pseudocode function FPTrigSMul.
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index feb8c65e89..112e85174c 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -747,6 +747,11 @@ FMINNMV		01100101 .. 000 101 001 ... ..... .....		@rd_pg_rn
 FMAXV		01100101 .. 000 110 001 ... ..... .....		@rd_pg_rn
 FMINV		01100101 .. 000 111 001 ... ..... .....		@rd_pg_rn
 
+## SVE Floating Point Unary Operations - Unpredicated Group
+
+FRECPE		01100101 .. 001 110 001110 ..... .....		@rd_rn
+FRSQRTE		01100101 .. 001 111 001110 ..... .....		@rd_rn
+
 ### SVE FP Accumulating Reduction Group
 
 # SVE floating-point serial reduction (predicated)
-- 
2.14.3
