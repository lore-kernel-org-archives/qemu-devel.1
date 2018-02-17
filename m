Received: from eggs.gnu.org ([2001:4830:134:3::10]:41035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7Aa-0001uZ-93
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7AY-0002Gx-QA
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:25:08 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:38521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en7AY-0002Gi-I1
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:25:06 -0500
Received: by mail-pf0-x241.google.com with SMTP id i3so593060pfe.5
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:25:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:23:18 -0800
Message-Id: <20180217182323.25885-63-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 62/67] target/arm: Implement SVE FP Compare
 with Zero Group
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
 target/arm/helper-sve.h    | 42 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/sve_helper.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 41 +++++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      | 10 ++++++++++
 4 files changed, 138 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index c07b2245ba..696c97648b 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -767,6 +767,48 @@ DEF_HELPER_FLAGS_5(sve_fadda_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve_fadda_d, TCG_CALL_NO_RWG,
                    i64, i64, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve_fcmge0_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcmge0_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcmge0_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_fcmgt0_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcmgt0_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcmgt0_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_fcmlt0_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcmlt0_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcmlt0_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_fcmle0_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcmle0_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcmle0_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_fcmeq0_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcmeq0_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcmeq0_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_fcmne0_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcmne0_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcmne0_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_6(sve_fadd_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sve_fadd_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 29deefcd86..6a052ce9ad 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3270,6 +3270,8 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg,               \
 
 #define DO_FCMGE(TYPE, X, Y, ST)  TYPE##_compare(Y, X, ST) <= 0
 #define DO_FCMGT(TYPE, X, Y, ST)  TYPE##_compare(Y, X, ST) < 0
+#define DO_FCMLE(TYPE, X, Y, ST)  TYPE##_compare(X, Y, ST) <= 0
+#define DO_FCMLT(TYPE, X, Y, ST)  TYPE##_compare(X, Y, ST) < 0
 #define DO_FCMEQ(TYPE, X, Y, ST)  TYPE##_compare_quiet(X, Y, ST) == 0
 #define DO_FCMNE(TYPE, X, Y, ST)  TYPE##_compare_quiet(X, Y, ST) != 0
 #define DO_FCMUO(TYPE, X, Y, ST)  \
@@ -3293,6 +3295,49 @@ DO_FPCMP_PPZZ_ALL(sve_facgt, DO_FACGT)
 #undef DO_FPCMP_PPZZ_H
 #undef DO_FPCMP_PPZZ
 
+/* One operand floating-point comparison against zero, controlled
+ * by a predicate.
+ */
+#define DO_FPCMP_PPZ0(NAME, TYPE, H, OP)                   \
+void HELPER(NAME)(void *vd, void *vn, void *vg,            \
+                  void *status, uint32_t desc)             \
+{                                                          \
+    intptr_t opr_sz = simd_oprsz(desc);                    \
+    intptr_t i = opr_sz, j = ((opr_sz - 1) & -64) >> 3;    \
+    do {                                                   \
+        uint64_t out = 0;                                  \
+        uint64_t pg = *(uint64_t *)(vg + j);               \
+        do {                                               \
+            i -= sizeof(TYPE), out <<= sizeof(TYPE);       \
+            if ((pg >> (i & 63)) & 1) {                    \
+                TYPE nn = *(TYPE *)(vn + H(i));            \
+                out |= OP(TYPE, nn, 0, status);            \
+            }                                              \
+        } while (i & 63);                                  \
+        *(uint64_t *)(vd + j) = out;                       \
+        j -= 8;                                            \
+    } while (i > 0);                                       \
+}
+
+#define DO_FPCMP_PPZ0_H(NAME, OP) \
+    DO_FPCMP_PPZ0(NAME##_h, float16, H1_2, OP)
+#define DO_FPCMP_PPZ0_S(NAME, OP) \
+    DO_FPCMP_PPZ0(NAME##_s, float32, H1_4, OP)
+#define DO_FPCMP_PPZ0_D(NAME, OP) \
+    DO_FPCMP_PPZ0(NAME##_d, float64,     , OP)
+
+#define DO_FPCMP_PPZ0_ALL(NAME, OP) \
+    DO_FPCMP_PPZ0_H(NAME, OP)   \
+    DO_FPCMP_PPZ0_S(NAME, OP)   \
+    DO_FPCMP_PPZ0_D(NAME, OP)
+
+DO_FPCMP_PPZ0_ALL(sve_fcmge0, DO_FCMGE)
+DO_FPCMP_PPZ0_ALL(sve_fcmgt0, DO_FCMGT)
+DO_FPCMP_PPZ0_ALL(sve_fcmle0, DO_FCMLE)
+DO_FPCMP_PPZ0_ALL(sve_fcmlt0, DO_FCMLT)
+DO_FPCMP_PPZ0_ALL(sve_fcmeq0, DO_FCMEQ)
+DO_FPCMP_PPZ0_ALL(sve_fcmne0, DO_FCMNE)
+
 /*
  * Load contiguous data, protected by a governing predicate.
  */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 463ff7b690..02655bff03 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3278,6 +3278,47 @@ static void trans_FRSQRTE(DisasContext *s, arg_rr_esz *a, uint32_t insn)
     }
 }
 
+/*
+ *** SVE Floating Point Compare with Zero Group
+ */
+
+static void do_ppz_fp(DisasContext *s, arg_rpr_esz *a,
+                      gen_helper_gvec_3_ptr *fn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+
+    tcg_gen_gvec_3_ptr(pred_full_reg_offset(s, a->rd),
+                       vec_full_reg_offset(s, a->rn),
+                       pred_full_reg_offset(s, a->pg),
+                       status, vsz, vsz, 0, fn);
+    tcg_temp_free_ptr(status);
+}
+
+#define DO_PPZ(NAME, name) \
+static void trans_##NAME(DisasContext *s, arg_rpr_esz *a, uint32_t insn) \
+{                                                                 \
+    static gen_helper_gvec_3_ptr * const fns[3] = {               \
+        gen_helper_sve_##name##_h,                                \
+        gen_helper_sve_##name##_s,                                \
+        gen_helper_sve_##name##_d,                                \
+    };                                                            \
+    if (a->esz == 0) {                                            \
+        unallocated_encoding(s);                                  \
+        return;                                                   \
+    }                                                             \
+    do_ppz_fp(s, a, fns[a->esz - 1]);                             \
+}
+
+DO_PPZ(FCMGE_ppz0, fcmge0)
+DO_PPZ(FCMGT_ppz0, fcmgt0)
+DO_PPZ(FCMLE_ppz0, fcmle0)
+DO_PPZ(FCMLT_ppz0, fcmlt0)
+DO_PPZ(FCMEQ_ppz0, fcmeq0)
+DO_PPZ(FCMNE_ppz0, fcmne0)
+
+#undef DO_PPZ
+
 /*
  *** SVE Floating Point Accumulating Reduction Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 112e85174c..f4505ad0bf 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -141,6 +141,7 @@
 # One register operand, with governing predicate, vector element size
 @rd_pg_rn	........ esz:2 ... ... ... pg:3 rn:5 rd:5	&rpr_esz
 @rd_pg4_pn	........ esz:2 ... ... .. pg:4 . rn:4 rd:5	&rpr_esz
+@pd_pg_rn	........ esz:2 ... ... ... pg:3 rn:5 . rd:4	&rpr_esz
 
 # One register operand, with governing predicate, no vector element size
 @rd_pg_rn_e0	........ .. ... ... ... pg:3 rn:5 rd:5		&rpr_esz esz=0
@@ -752,6 +753,15 @@ FMINV		01100101 .. 000 111 001 ... ..... .....		@rd_pg_rn
 FRECPE		01100101 .. 001 110 001110 ..... .....		@rd_rn
 FRSQRTE		01100101 .. 001 111 001110 ..... .....		@rd_rn
 
+### SVE FP Compare with Zero Group
+
+FCMGE_ppz0	01100101 .. 0100 00 001 ... ..... 0 ....	@pd_pg_rn
+FCMGT_ppz0	01100101 .. 0100 00 001 ... ..... 1 ....	@pd_pg_rn
+FCMLT_ppz0	01100101 .. 0100 01 001 ... ..... 0 ....	@pd_pg_rn
+FCMLE_ppz0	01100101 .. 0100 01 001 ... ..... 1 ....	@pd_pg_rn
+FCMEQ_ppz0	01100101 .. 0100 10 001 ... ..... 0 ....	@pd_pg_rn
+FCMNE_ppz0	01100101 .. 0100 11 001 ... ..... 0 ....	@pd_pg_rn
+
 ### SVE FP Accumulating Reduction Group
 
 # SVE floating-point serial reduction (predicated)
-- 
2.14.3
