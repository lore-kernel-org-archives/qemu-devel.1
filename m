Received: from eggs.gnu.org ([2001:4830:134:3::10]:40693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7AE-0001Qz-Ez
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7AC-00026n-Kw
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:46 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:37017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en7AC-00026D-Bz
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:44 -0500
Received: by mail-pl0-x243.google.com with SMTP id ay8so3443274plb.4
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:23:04 -0800
Message-Id: <20180217182323.25885-49-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 48/67] target/arm: Implement SVE
 floating-point arithmetic (predicated)
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
 target/arm/helper-sve.h    |  77 ++++++++++++++++++++++++++++++++
 target/arm/sve_helper.c    | 107 +++++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c |  47 ++++++++++++++++++++
 target/arm/sve.decode      |  17 +++++++
 4 files changed, 248 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index fb7609f9ef..84d0a8978c 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -720,6 +720,83 @@ DEF_HELPER_FLAGS_5(gvec_rsqrts_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_rsqrts_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_6(sve_fadd_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fadd_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fadd_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fsub_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fsub_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fsub_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fmul_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmul_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmul_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fdiv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fdiv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fdiv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fmin_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmin_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmin_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fmax_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmax_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmax_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fminnum_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fminnum_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fminnum_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fmaxnum_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmaxnum_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmaxnum_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fabd_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fabd_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fabd_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fscalbn_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fscalbn_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fscalbn_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fmulx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmulx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmulx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_scvt_hh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_scvt_sh, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index a1e0ceb5fb..d80babfae7 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2789,6 +2789,113 @@ uint32_t HELPER(sve_while)(void *vd, uint32_t count, uint32_t pred_desc)
     return predtest_ones(d, oprsz, esz_mask);
 }
 
+/* Fully general three-operand expander, controlled by a predicate,
+ * With the extra float_status parameter.
+ */
+#define DO_ZPZZ_FP(NAME, TYPE, H, OP)                           \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg,       \
+                  void *status, uint32_t desc)                  \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc);                      \
+    for (i = 0; i < opr_sz; ) {                                 \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));         \
+        do {                                                    \
+            if (pg & 1) {                                       \
+                TYPE nn = *(TYPE *)(vn + H(i));                 \
+                TYPE mm = *(TYPE *)(vm + H(i));                 \
+                *(TYPE *)(vd + H(i)) = OP(nn, mm, status);      \
+            }                                                   \
+            i += sizeof(TYPE), pg >>= sizeof(TYPE);             \
+        } while (i & 15);                                       \
+    }                                                           \
+}
+
+/* Similarly, specialized for 64-bit operands.  */
+#define DO_ZPZZ_FP_D(NAME, TYPE, OP)                            \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg,       \
+                  void *status, uint32_t desc)                  \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;                  \
+    TYPE *d = vd, *n = vn, *m = vm;                             \
+    uint8_t *pg = vg;                                           \
+    for (i = 0; i < opr_sz; i += 1) {                           \
+        if (pg[H1(i)] & 1) {                                    \
+            d[i] = OP(n[i], m[i], status);                      \
+        }                                                       \
+    }                                                           \
+}
+
+DO_ZPZZ_FP(sve_fadd_h, uint16_t, H1_2, float16_add)
+DO_ZPZZ_FP(sve_fadd_s, uint16_t, H1_4, float32_add)
+DO_ZPZZ_FP_D(sve_fadd_d, uint64_t, float64_add)
+
+DO_ZPZZ_FP(sve_fsub_h, uint16_t, H1_2, float16_sub)
+DO_ZPZZ_FP(sve_fsub_s, uint16_t, H1_4, float32_sub)
+DO_ZPZZ_FP_D(sve_fsub_d, uint64_t, float64_sub)
+
+DO_ZPZZ_FP(sve_fmul_h, uint16_t, H1_2, float16_mul)
+DO_ZPZZ_FP(sve_fmul_s, uint16_t, H1_4, float32_mul)
+DO_ZPZZ_FP_D(sve_fmul_d, uint64_t, float64_mul)
+
+DO_ZPZZ_FP(sve_fdiv_h, uint16_t, H1_2, float16_div)
+DO_ZPZZ_FP(sve_fdiv_s, uint16_t, H1_4, float32_div)
+DO_ZPZZ_FP_D(sve_fdiv_d, uint64_t, float64_div)
+
+DO_ZPZZ_FP(sve_fmin_h, uint16_t, H1_2, float16_min)
+DO_ZPZZ_FP(sve_fmin_s, uint16_t, H1_4, float32_min)
+DO_ZPZZ_FP_D(sve_fmin_d, uint64_t, float64_min)
+
+DO_ZPZZ_FP(sve_fmax_h, uint16_t, H1_2, float16_max)
+DO_ZPZZ_FP(sve_fmax_s, uint16_t, H1_4, float32_max)
+DO_ZPZZ_FP_D(sve_fmax_d, uint64_t, float64_max)
+
+DO_ZPZZ_FP(sve_fminnum_h, uint16_t, H1_2, float16_minnum)
+DO_ZPZZ_FP(sve_fminnum_s, uint16_t, H1_4, float32_minnum)
+DO_ZPZZ_FP_D(sve_fminnum_d, uint64_t, float64_minnum)
+
+DO_ZPZZ_FP(sve_fmaxnum_h, uint16_t, H1_2, float16_maxnum)
+DO_ZPZZ_FP(sve_fmaxnum_s, uint16_t, H1_4, float32_maxnum)
+DO_ZPZZ_FP_D(sve_fmaxnum_d, uint64_t, float64_maxnum)
+
+static inline uint16_t abd_h(float16 a, float16 b, float_status *s)
+{
+    return float16_abs(float16_sub(a, b, s));
+
+}
+
+static inline uint32_t abd_s(float32 a, float32 b, float_status *s)
+{
+    return float32_abs(float32_sub(a, b, s));
+
+}
+
+static inline uint64_t abd_d(float64 a, float64 b, float_status *s)
+{
+    return float64_abs(float64_sub(a, b, s));
+
+}
+
+DO_ZPZZ_FP(sve_fabd_h, uint16_t, H1_2, abd_h)
+DO_ZPZZ_FP(sve_fabd_s, uint16_t, H1_4, abd_s)
+DO_ZPZZ_FP_D(sve_fabd_d, uint64_t, abd_d)
+
+static inline uint64_t scalbn_d(float64 a, int64_t b, float_status *s)
+{
+    int b_int = MIN(MAX(b, INT_MIN), INT_MAX);
+    return float64_scalbn(a, b_int, s);
+}
+
+DO_ZPZZ_FP(sve_fscalbn_h, uint16_t, H1_2, float16_scalbn)
+DO_ZPZZ_FP(sve_fscalbn_s, uint16_t, H1_4, float32_scalbn)
+DO_ZPZZ_FP_D(sve_fscalbn_d, uint64_t, scalbn_d)
+
+DO_ZPZZ_FP(sve_fmulx_h, uint16_t, H1_2, helper_advsimd_mulxh)
+DO_ZPZZ_FP(sve_fmulx_s, uint16_t, H1_4, helper_vfp_mulxs)
+DO_ZPZZ_FP_D(sve_fmulx_d, uint64_t, helper_vfp_mulxd)
+
+#undef DO_ZPZZ_FP
+#undef DO_ZPZZ_FP_D
+
 /* Fully general two-operand expander, controlled by a predicate,
  * With the extra float_status parameter.
  */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 05c684222e..1692980d20 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3161,6 +3161,52 @@ DO_FP3(FRSQRTS, rsqrts)
 
 #undef DO_FP3
 
+/*
+ *** SVE Floating Point Arithmetic - Predicated Group
+ */
+
+static void do_zpzz_fp(DisasContext *s, arg_rprr_esz *a,
+                       gen_helper_gvec_4_ptr *fn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    TCGv_ptr status;
+
+    if (fn == NULL) {
+        unallocated_encoding(s);
+        return;
+    }
+    status = get_fpstatus_ptr(a->esz == MO_16);
+    tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
+                       vec_full_reg_offset(s, a->rn),
+                       vec_full_reg_offset(s, a->rm),
+                       pred_full_reg_offset(s, a->pg),
+                       status, vsz, vsz, 0, fn);
+    tcg_temp_free_ptr(status);
+}
+
+#define DO_FP3(NAME, name) \
+static void trans_##NAME(DisasContext *s, arg_rprr_esz *a, uint32_t insn) \
+{                                                                   \
+    static gen_helper_gvec_4_ptr * const fns[4] = {                 \
+        NULL, gen_helper_sve_##name##_h,                            \
+        gen_helper_sve_##name##_s, gen_helper_sve_##name##_d        \
+    };                                                              \
+    do_zpzz_fp(s, a, fns[a->esz]);                                  \
+}
+
+DO_FP3(FADD_zpzz, fadd)
+DO_FP3(FSUB_zpzz, fsub)
+DO_FP3(FMUL_zpzz, fmul)
+DO_FP3(FMIN_zpzz, fmin)
+DO_FP3(FMAX_zpzz, fmax)
+DO_FP3(FMINNM_zpzz, fminnum)
+DO_FP3(FMAXNM_zpzz, fmaxnum)
+DO_FP3(FABD, fabd)
+DO_FP3(FSCALE, fscalbn)
+DO_FP3(FDIV, fdiv)
+DO_FP3(FMULX, fmulx)
+
+#undef DO_FP3
 
 /*
  *** SVE Floating Point Unary Operations Prediated Group
@@ -3181,6 +3227,7 @@ static void do_zpz_ptr(DisasContext *s, int rd, int rn, int pg,
                        vec_full_reg_offset(s, rn),
                        pred_full_reg_offset(s, pg),
                        status, vsz, vsz, 0, fn);
+    tcg_temp_free_ptr(status);
 }
 
 static void trans_SCVTF_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index b571b70050..1a13c603ff 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -692,6 +692,23 @@ FTSMUL		01100101 .. 0 ..... 000 011 ..... .....		@rd_rn_rm
 FRECPS		01100101 .. 0 ..... 000 110 ..... .....		@rd_rn_rm
 FRSQRTS		01100101 .. 0 ..... 000 111 ..... .....		@rd_rn_rm
 
+### SVE FP Arithmetic Predicated Group
+
+# SVE floating-point arithmetic (predicated)
+FADD_zpzz	01100101 .. 00 0000 100 ... ..... .....    @rdn_pg_rm
+FSUB_zpzz	01100101 .. 00 0001 100 ... ..... .....    @rdn_pg_rm
+FMUL_zpzz	01100101 .. 00 0010 100 ... ..... .....    @rdn_pg_rm
+FSUB_zpzz	01100101 .. 00 0011 100 ... ..... .....    @rdm_pg_rn # FSUBR
+FMAXNM_zpzz	01100101 .. 00 0100 100 ... ..... .....    @rdn_pg_rm
+FMINNM_zpzz	01100101 .. 00 0101 100 ... ..... .....    @rdn_pg_rm
+FMAX_zpzz	01100101 .. 00 0110 100 ... ..... .....    @rdn_pg_rm
+FMIN_zpzz	01100101 .. 00 0111 100 ... ..... .....    @rdn_pg_rm
+FABD		01100101 .. 00 1000 100 ... ..... .....    @rdn_pg_rm
+FSCALE		01100101 .. 00 1001 100 ... ..... .....    @rdn_pg_rm
+FMULX		01100101 .. 00 1010 100 ... ..... .....    @rdn_pg_rm
+FDIV		01100101 .. 00 1100 100 ... ..... .....    @rdm_pg_rn # FDIVR
+FDIV		01100101 .. 00 1101 100 ... ..... .....    @rdn_pg_rm
+
 ### SVE FP Unary Operations Predicated Group
 
 # SVE integer convert to floating-point
-- 
2.14.3
