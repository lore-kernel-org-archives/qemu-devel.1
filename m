Received: from eggs.gnu.org ([2001:4830:134:3::10]:60797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29d-0004Vb-6v
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29a-0000lo-AG
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:05 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:35710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY29a-0000kx-06
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:02 -0400
Received: by mail-pf0-x22e.google.com with SMTP id c22-v6so389951pfi.2
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 21:34:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 21:33:14 -0700
Message-Id: <20180627043328.11531-22-richard.henderson@linaro.org>
In-Reply-To: <20180627043328.11531-1-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 21/35] target/arm: Implement SVE FP Compare
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
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 42 +++++++++++++++++++++++++++++++++++++
 target/arm/sve_helper.c    | 43 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 43 ++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      | 10 +++++++++
 4 files changed, 138 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index ff69d143a0..44a98440c9 100644
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
index 4c44d52a23..0486cb1e5e 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3362,6 +3362,8 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg,               \
 
 #define DO_FCMGE(TYPE, X, Y, ST)  TYPE##_compare(Y, X, ST) <= 0
 #define DO_FCMGT(TYPE, X, Y, ST)  TYPE##_compare(Y, X, ST) < 0
+#define DO_FCMLE(TYPE, X, Y, ST)  TYPE##_compare(X, Y, ST) <= 0
+#define DO_FCMLT(TYPE, X, Y, ST)  TYPE##_compare(X, Y, ST) < 0
 #define DO_FCMEQ(TYPE, X, Y, ST)  TYPE##_compare_quiet(X, Y, ST) == 0
 #define DO_FCMNE(TYPE, X, Y, ST)  TYPE##_compare_quiet(X, Y, ST) != 0
 #define DO_FCMUO(TYPE, X, Y, ST)  \
@@ -3385,6 +3387,47 @@ DO_FPCMP_PPZZ_ALL(sve_facgt, DO_FACGT)
 #undef DO_FPCMP_PPZZ_H
 #undef DO_FPCMP_PPZZ
 
+/* One operand floating-point comparison against zero, controlled
+ * by a predicate.
+ */
+#define DO_FPCMP_PPZ0(NAME, TYPE, H, OP)                   \
+void HELPER(NAME)(void *vd, void *vn, void *vg,            \
+                  void *status, uint32_t desc)             \
+{                                                          \
+    intptr_t i = simd_oprsz(desc), j = (i - 1) >> 6;       \
+    uint64_t *d = vd, *g = vg;                             \
+    do {                                                   \
+        uint64_t out = 0, pg = g[j];                       \
+        do {                                               \
+            i -= sizeof(TYPE), out <<= sizeof(TYPE);       \
+            if ((pg >> (i & 63)) & 1) {                    \
+                TYPE nn = *(TYPE *)(vn + H(i));            \
+                out |= OP(TYPE, nn, 0, status);            \
+            }                                              \
+        } while (i & 63);                                  \
+        d[j--] = out;                                      \
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
index 1dcc2d38c9..cfee256be9 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3554,6 +3554,49 @@ static bool trans_FRSQRTE(DisasContext *s, arg_rr_esz *a, uint32_t insn)
     return true;
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
+static bool trans_##NAME(DisasContext *s, arg_rpr_esz *a, uint32_t insn) \
+{                                                                 \
+    static gen_helper_gvec_3_ptr * const fns[3] = {               \
+        gen_helper_sve_##name##_h,                                \
+        gen_helper_sve_##name##_s,                                \
+        gen_helper_sve_##name##_d,                                \
+    };                                                            \
+    if (a->esz == 0) {                                            \
+        return false;                                             \
+    }                                                             \
+    if (sve_access_check(s)) {                                    \
+        do_ppz_fp(s, a, fns[a->esz - 1]);                         \
+    }                                                             \
+    return true;                                                  \
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
index ca93bdb2b3..a774becd6c 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -140,6 +140,7 @@
 # One register operand, with governing predicate, vector element size
 @rd_pg_rn       ........ esz:2 ... ... ... pg:3 rn:5 rd:5       &rpr_esz
 @rd_pg4_pn      ........ esz:2 ... ... .. pg:4 . rn:4 rd:5      &rpr_esz
+@pd_pg_rn       ........ esz:2 ... ... ... pg:3 rn:5 . rd:4     &rpr_esz
 
 # One register operand, with governing predicate, no vector element size
 @rd_pg_rn_e0    ........ .. ... ... ... pg:3 rn:5 rd:5          &rpr_esz esz=0
@@ -748,6 +749,15 @@ FMINV           01100101 .. 000 111 001 ... ..... .....         @rd_pg_rn
 FRECPE          01100101 .. 001 110 001100 ..... .....          @rd_rn
 FRSQRTE         01100101 .. 001 111 001100 ..... .....          @rd_rn
 
+### SVE FP Compare with Zero Group
+
+FCMGE_ppz0      01100101 .. 0100 00 001 ... ..... 0 ....        @pd_pg_rn
+FCMGT_ppz0      01100101 .. 0100 00 001 ... ..... 1 ....        @pd_pg_rn
+FCMLT_ppz0      01100101 .. 0100 01 001 ... ..... 0 ....        @pd_pg_rn
+FCMLE_ppz0      01100101 .. 0100 01 001 ... ..... 1 ....        @pd_pg_rn
+FCMEQ_ppz0      01100101 .. 0100 10 001 ... ..... 0 ....        @pd_pg_rn
+FCMNE_ppz0      01100101 .. 0100 11 001 ... ..... 0 ....        @pd_pg_rn
+
 ### SVE FP Accumulating Reduction Group
 
 # SVE floating-point serial reduction (predicated)
-- 
2.17.1
