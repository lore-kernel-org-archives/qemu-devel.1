Received: from eggs.gnu.org ([2001:4830:134:3::10]:60570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29V-0004Jz-9z
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29T-0000cy-4V
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:33:57 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:40253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY29S-0000bZ-RT
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:33:55 -0400
Received: by mail-pg0-x230.google.com with SMTP id w8-v6so362709pgp.7
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 21:33:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 21:33:09 -0700
Message-Id: <20180627043328.11531-17-richard.henderson@linaro.org>
In-Reply-To: <20180627043328.11531-1-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 16/35] target/arm: Implement SVE
 floating-point compare vectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 49 ++++++++++++++++++++++++++++++
 target/arm/sve_helper.c    | 62 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 40 ++++++++++++++++++++++++
 target/arm/sve.decode      | 11 +++++++
 4 files changed, 162 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 55e8a908d4..6089b3a53f 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -839,6 +839,55 @@ DEF_HELPER_FLAGS_5(sve_ucvt_ds, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve_ucvt_dd, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_6(sve_fcmge_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fcmge_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fcmge_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fcmgt_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fcmgt_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fcmgt_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fcmeq_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fcmeq_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fcmeq_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fcmne_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fcmne_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fcmne_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fcmuo_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fcmuo_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fcmuo_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_facge_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_facge_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_facge_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_facgt_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_facgt_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_facgt_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 81fc968087..41d8ce6b54 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3193,6 +3193,68 @@ void HELPER(sve_fnmls_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
     do_fmla_zpzzz_d(env, vg, desc, 0, INT64_MIN);
 }
 
+/* Two operand floating-point comparison controlled by a predicate.
+ * Unlike the integer version, we are not allowed to optimistically
+ * compare operands, since the comparison may have side effects wrt
+ * the FPSR.
+ */
+#define DO_FPCMP_PPZZ(NAME, TYPE, H, OP)                                \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg,               \
+                  void *status, uint32_t desc)                          \
+{                                                                       \
+    intptr_t i = simd_oprsz(desc), j = (i - 1) >> 6;                    \
+    uint64_t *d = vd, *g = vg;                                          \
+    do {                                                                \
+        uint64_t out = 0, pg = g[j];                                    \
+        do {                                                            \
+            i -= sizeof(TYPE), out <<= sizeof(TYPE);                    \
+            if (likely((pg >> (i & 63)) & 1)) {                         \
+                TYPE nn = *(TYPE *)(vn + H(i));                         \
+                TYPE mm = *(TYPE *)(vm + H(i));                         \
+                out |= OP(TYPE, nn, mm, status);                        \
+            }                                                           \
+        } while (i & 63);                                               \
+        d[j--] = out;                                                   \
+    } while (i > 0);                                                    \
+}
+
+#define DO_FPCMP_PPZZ_H(NAME, OP) \
+    DO_FPCMP_PPZZ(NAME##_h, float16, H1_2, OP)
+#define DO_FPCMP_PPZZ_S(NAME, OP) \
+    DO_FPCMP_PPZZ(NAME##_s, float32, H1_4, OP)
+#define DO_FPCMP_PPZZ_D(NAME, OP) \
+    DO_FPCMP_PPZZ(NAME##_d, float64,     , OP)
+
+#define DO_FPCMP_PPZZ_ALL(NAME, OP) \
+    DO_FPCMP_PPZZ_H(NAME, OP)   \
+    DO_FPCMP_PPZZ_S(NAME, OP)   \
+    DO_FPCMP_PPZZ_D(NAME, OP)
+
+#define DO_FCMGE(TYPE, X, Y, ST)  TYPE##_compare(Y, X, ST) <= 0
+#define DO_FCMGT(TYPE, X, Y, ST)  TYPE##_compare(Y, X, ST) < 0
+#define DO_FCMEQ(TYPE, X, Y, ST)  TYPE##_compare_quiet(X, Y, ST) == 0
+#define DO_FCMNE(TYPE, X, Y, ST)  TYPE##_compare_quiet(X, Y, ST) != 0
+#define DO_FCMUO(TYPE, X, Y, ST)  \
+    TYPE##_compare_quiet(X, Y, ST) == float_relation_unordered
+#define DO_FACGE(TYPE, X, Y, ST)  \
+    TYPE##_compare(TYPE##_abs(Y), TYPE##_abs(X), ST) <= 0
+#define DO_FACGT(TYPE, X, Y, ST)  \
+    TYPE##_compare(TYPE##_abs(Y), TYPE##_abs(X), ST) < 0
+
+DO_FPCMP_PPZZ_ALL(sve_fcmge, DO_FCMGE)
+DO_FPCMP_PPZZ_ALL(sve_fcmgt, DO_FCMGT)
+DO_FPCMP_PPZZ_ALL(sve_fcmeq, DO_FCMEQ)
+DO_FPCMP_PPZZ_ALL(sve_fcmne, DO_FCMNE)
+DO_FPCMP_PPZZ_ALL(sve_fcmuo, DO_FCMUO)
+DO_FPCMP_PPZZ_ALL(sve_facge, DO_FACGE)
+DO_FPCMP_PPZZ_ALL(sve_facgt, DO_FACGT)
+
+#undef DO_FPCMP_PPZZ_ALL
+#undef DO_FPCMP_PPZZ_D
+#undef DO_FPCMP_PPZZ_S
+#undef DO_FPCMP_PPZZ_H
+#undef DO_FPCMP_PPZZ
+
 /*
  * Load contiguous data, protected by a governing predicate.
  */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 9eb2530d3b..b028a034fd 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3533,6 +3533,46 @@ DO_FP3(FMULX, fmulx)
 
 #undef DO_FP3
 
+static bool do_fp_cmp(DisasContext *s, arg_rprr_esz *a,
+                      gen_helper_gvec_4_ptr *fn)
+{
+    if (fn == NULL) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        tcg_gen_gvec_4_ptr(pred_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           pred_full_reg_offset(s, a->pg),
+                           status, vsz, vsz, 0, fn);
+        tcg_temp_free_ptr(status);
+    }
+    return true;
+}
+
+#define DO_FPCMP(NAME, name) \
+static bool trans_##NAME##_ppzz(DisasContext *s, arg_rprr_esz *a,     \
+                                uint32_t insn)                        \
+{                                                                     \
+    static gen_helper_gvec_4_ptr * const fns[4] = {                   \
+        NULL, gen_helper_sve_##name##_h,                              \
+        gen_helper_sve_##name##_s, gen_helper_sve_##name##_d          \
+    };                                                                \
+    return do_fp_cmp(s, a, fns[a->esz]);                              \
+}
+
+DO_FPCMP(FCMGE, fcmge)
+DO_FPCMP(FCMGT, fcmgt)
+DO_FPCMP(FCMEQ, fcmeq)
+DO_FPCMP(FCMNE, fcmne)
+DO_FPCMP(FCMUO, fcmuo)
+DO_FPCMP(FACGE, facge)
+DO_FPCMP(FACGT, facgt)
+
+#undef DO_FPCMP
+
 typedef void gen_helper_sve_fmla(TCGv_env, TCGv_ptr, TCGv_i32);
 
 static bool do_fmla(DisasContext *s, arg_rprrr_esz *a, gen_helper_sve_fmla *fn)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 75133ce659..a1bc6cb395 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -324,6 +324,17 @@ UXTH            00000100 .. 010 011 101 ... ..... .....         @rd_pg_rn
 SXTW            00000100 .. 010 100 101 ... ..... .....         @rd_pg_rn
 UXTW            00000100 .. 010 101 101 ... ..... .....         @rd_pg_rn
 
+### SVE Floating Point Compare - Vectors Group
+
+# SVE floating-point compare vectors
+FCMGE_ppzz      01100101 .. 0 ..... 010 ... ..... 0 ....        @pd_pg_rn_rm
+FCMGT_ppzz      01100101 .. 0 ..... 010 ... ..... 1 ....        @pd_pg_rn_rm
+FCMEQ_ppzz      01100101 .. 0 ..... 011 ... ..... 0 ....        @pd_pg_rn_rm
+FCMNE_ppzz      01100101 .. 0 ..... 011 ... ..... 1 ....        @pd_pg_rn_rm
+FCMUO_ppzz      01100101 .. 0 ..... 110 ... ..... 0 ....        @pd_pg_rn_rm
+FACGE_ppzz      01100101 .. 0 ..... 110 ... ..... 1 ....        @pd_pg_rn_rm
+FACGT_ppzz      01100101 .. 0 ..... 111 ... ..... 1 ....        @pd_pg_rn_rm
+
 ### SVE Integer Multiply-Add Group
 
 # SVE integer multiply-add writing addend (predicated)
-- 
2.17.1
