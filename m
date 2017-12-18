Received: from eggs.gnu.org ([2001:4830:134:3::10]:55849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUZ-0008Jj-ND
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUX-00029I-UD
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:19 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:34548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUX-00028b-M9
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:17 -0500
Received: by mail-pl0-x241.google.com with SMTP id d21so5238067pll.1
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:46:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:43 -0800
Message-Id: <20171218174552.18871-15-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 14/23] target/arm: Implement SVE Integer
 Arithmetic - Unary Predicated Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  60 +++++++++++++++++++++
 target/arm/sve_helper.c    | 128 +++++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 107 +++++++++++++++++++++++++++++++++++++
 target/arm/sve.def         |  21 ++++++++
 4 files changed, 316 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index a2db3e2fd9..e9382de300 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -279,6 +279,66 @@ DEF_HELPER_FLAGS_4(sve_asrd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_asrd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_asrd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_cls_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cls_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cls_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cls_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_clz_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_clz_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_clz_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_clz_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_cnt_zpz_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cnt_zpz_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cnt_zpz_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cnt_zpz_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_cnot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cnot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cnot_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cnot_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_fabs_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_fabs_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_fabs_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_fneg_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_fneg_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_fneg_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_not_zpz_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_not_zpz_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_not_zpz_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_not_zpz_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_sxtb_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_sxtb_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_sxtb_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_uxtb_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_uxtb_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_uxtb_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_sxth_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_sxth_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_uxth_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_uxth_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_sxtw_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_uxtw_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_abs_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_abs_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_abs_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_abs_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_neg_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_neg_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_neg_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_neg_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 3be6d1ae05..481b3bdefe 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -553,6 +553,134 @@ DO_ZPZW(sve_lsl_zpzw_s, uint32_t, uint64_t, H1_4, DO_LSL)
 
 #undef DO_ZPZW
 
+/* Fully general two-operand expander, controlled by a predicate.
+ */
+#define DO_ZPZ(NAME, TYPE, H, OP)                               \
+void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)  \
+{                                                               \
+    intptr_t iv = 0, ib = 0, opr_sz = simd_oprsz(desc);         \
+    for (iv = ib = 0; iv < opr_sz; iv += 16, ib += 2) {         \
+        uint16_t pg = *(uint16_t *)(vg + H2(ib));               \
+        intptr_t i = 0;                                         \
+        do {                                                    \
+            if (pg & 1) {                                       \
+                TYPE nn = *(TYPE *)(vn + iv + H(i));            \
+                *(TYPE *)(vd + iv + H(i)) = OP(nn);             \
+            }                                                   \
+            i += sizeof(TYPE), pg >>= sizeof(TYPE);             \
+        } while (pg);                                           \
+    }                                                           \
+}
+
+/* Similarly, specialized for 64-bit operands.  */
+#define DO_ZPZ_D(NAME, TYPE, OP)                                \
+void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)  \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;                  \
+    TYPE *d = vd, *n = vn;                                      \
+    uint8_t *pg = vg;                                           \
+    for (i = 0; i < opr_sz; i += 1) {                           \
+        if (pg[H1(i)] & 1) {                                    \
+            TYPE nn = n[i];                                     \
+            d[i] = OP(nn);                                      \
+        }                                                       \
+    }                                                           \
+}
+
+#define DO_CLS_B(N)   (clrsb32(N) - 24)
+#define DO_CLS_H(N)   (clrsb32(N) - 16)
+
+DO_ZPZ(sve_cls_b, int8_t, H1, DO_CLS_B)
+DO_ZPZ(sve_cls_h, int16_t, H1_2, DO_CLS_H)
+DO_ZPZ(sve_cls_s, int32_t, H1_4, clrsb32)
+DO_ZPZ_D(sve_cls_d, int64_t, clrsb64)
+
+#define DO_CLZ_B(N)   (clz32(N) - 24)
+#define DO_CLZ_H(N)   (clz32(N) - 16)
+
+DO_ZPZ(sve_clz_b, uint8_t, H1, DO_CLZ_B)
+DO_ZPZ(sve_clz_h, uint16_t, H1_2, DO_CLZ_H)
+DO_ZPZ(sve_clz_s, uint32_t, H1_4, clz32)
+DO_ZPZ_D(sve_clz_d, uint64_t, clz64)
+
+DO_ZPZ(sve_cnt_zpz_b, uint8_t, H1, ctpop8)
+DO_ZPZ(sve_cnt_zpz_h, uint16_t, H1_2, ctpop16)
+DO_ZPZ(sve_cnt_zpz_s, uint32_t, H1_4, ctpop32)
+DO_ZPZ_D(sve_cnt_zpz_d, uint64_t, ctpop64)
+
+#define DO_CNOT(N)    (N == 0)
+
+DO_ZPZ(sve_cnot_b, uint8_t, H1, DO_CNOT)
+DO_ZPZ(sve_cnot_h, uint16_t, H1_2, DO_CNOT)
+DO_ZPZ(sve_cnot_s, uint32_t, H1_4, DO_CNOT)
+DO_ZPZ_D(sve_cnot_d, uint64_t, DO_CNOT)
+
+#define DO_FABS(N)    (N & ((__typeof(N))-1 >> 1))
+
+DO_ZPZ(sve_fabs_h, uint16_t, H1_2, DO_FABS)
+DO_ZPZ(sve_fabs_s, uint32_t, H1_4, DO_FABS)
+DO_ZPZ_D(sve_fabs_d, uint64_t, DO_FABS)
+
+#define DO_FNEG(N)    (N ^ ~((__typeof(N))-1 >> 1))
+
+DO_ZPZ(sve_fneg_h, uint16_t, H1_2, DO_FNEG)
+DO_ZPZ(sve_fneg_s, uint32_t, H1_4, DO_FNEG)
+DO_ZPZ_D(sve_fneg_d, uint64_t, DO_FNEG)
+
+#define DO_NOT(N)    (~N)
+
+DO_ZPZ(sve_not_zpz_b, uint8_t, H1, DO_NOT)
+DO_ZPZ(sve_not_zpz_h, uint16_t, H1_2, DO_NOT)
+DO_ZPZ(sve_not_zpz_s, uint32_t, H1_4, DO_NOT)
+DO_ZPZ_D(sve_not_zpz_d, uint64_t, DO_NOT)
+
+#define DO_SXTB(N)    ((int8_t)N)
+#define DO_SXTH(N)    ((int16_t)N)
+#define DO_SXTS(N)    ((int32_t)N)
+#define DO_UXTB(N)    ((uint8_t)N)
+#define DO_UXTH(N)    ((uint16_t)N)
+#define DO_UXTS(N)    ((uint32_t)N)
+
+DO_ZPZ(sve_sxtb_h, uint16_t, H1_2, DO_SXTB)
+DO_ZPZ(sve_sxtb_s, uint32_t, H1_4, DO_SXTB)
+DO_ZPZ(sve_sxth_s, uint32_t, H1_4, DO_SXTH)
+DO_ZPZ_D(sve_sxtb_d, uint64_t, DO_SXTB)
+DO_ZPZ_D(sve_sxth_d, uint64_t, DO_SXTH)
+DO_ZPZ_D(sve_sxtw_d, uint64_t, DO_SXTS)
+
+DO_ZPZ(sve_uxtb_h, uint16_t, H1_2, DO_UXTB)
+DO_ZPZ(sve_uxtb_s, uint32_t, H1_4, DO_UXTB)
+DO_ZPZ(sve_uxth_s, uint32_t, H1_4, DO_UXTH)
+DO_ZPZ_D(sve_uxtb_d, uint64_t, DO_UXTB)
+DO_ZPZ_D(sve_uxth_d, uint64_t, DO_UXTH)
+DO_ZPZ_D(sve_uxtw_d, uint64_t, DO_UXTS)
+
+#define DO_ABS(N)    (N < 0 ? -N : N)
+
+DO_ZPZ(sve_abs_b, int8_t, H1, DO_ABS)
+DO_ZPZ(sve_abs_h, int16_t, H1_2, DO_ABS)
+DO_ZPZ(sve_abs_s, int32_t, H1_4, DO_ABS)
+DO_ZPZ_D(sve_abs_d, int64_t, DO_ABS)
+
+#define DO_NEG(N)    (-N)
+
+DO_ZPZ(sve_neg_b, uint8_t, H1, DO_NEG)
+DO_ZPZ(sve_neg_h, uint16_t, H1_2, DO_NEG)
+DO_ZPZ(sve_neg_s, uint32_t, H1_4, DO_NEG)
+DO_ZPZ_D(sve_neg_d, uint64_t, DO_NEG)
+
+#undef DO_CLS_B
+#undef DO_CLS_H
+#undef DO_CLZ_B
+#undef DO_CLZ_H
+#undef DO_CNOT
+#undef DO_FABS
+#undef DO_FNEG
+#undef DO_ABS
+#undef DO_NEG
+#undef DO_ZPZ
+#undef DO_ZPZ_D
+
 /* Two-operand reduction expander, controlled by a predicate.
  * The difference between TYPERED and TYPERET has to do with
  * sign-extension.  E.g. for SMAX, TYPERED must be signed,
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 91f07d57e3..7dbc43fb6e 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -250,6 +250,113 @@ DO_ZPZW(LSL, lsl)
 
 #undef DO_ZPZW
 
+static void do_zpz_ool(DisasContext *s, arg_rpr_esz *a, gen_helper_gvec_3 *fn)
+{
+    unsigned vsz = size_for_gvec(vec_full_reg_size(s));
+    if (fn == NULL) {
+        unallocated_encoding(s);
+        return;
+    }
+    tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                       vec_full_reg_offset(s, a->rn),
+                       pred_full_reg_offset(s, a->pg),
+                       vsz, vsz, 0, fn);
+}
+
+#define DO_ZPZ(NAME, name) \
+void trans_##NAME(DisasContext *s, arg_rpr_esz *a, uint32_t insn)   \
+{                                                                   \
+    static gen_helper_gvec_3 * const fns[4] = {                     \
+        gen_helper_sve_##name##_b, gen_helper_sve_##name##_h,       \
+        gen_helper_sve_##name##_s, gen_helper_sve_##name##_d,       \
+    };                                                              \
+    do_zpz_ool(s, a, fns[a->esz]);                                  \
+}
+
+DO_ZPZ(CLS, cls)
+DO_ZPZ(CLZ, clz)
+DO_ZPZ(CNT_zpz, cnt_zpz)
+DO_ZPZ(CNOT, cnot)
+DO_ZPZ(NOT_zpz, not_zpz)
+DO_ZPZ(ABS, abs)
+DO_ZPZ(NEG, neg)
+
+void trans_FABS(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        NULL,
+        gen_helper_sve_fabs_h,
+        gen_helper_sve_fabs_s,
+        gen_helper_sve_fabs_d
+    };
+    do_zpz_ool(s, a, fns[a->esz]);
+}
+
+void trans_FNEG(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        NULL,
+        gen_helper_sve_fneg_h,
+        gen_helper_sve_fneg_s,
+        gen_helper_sve_fneg_d
+    };
+    do_zpz_ool(s, a, fns[a->esz]);
+}
+
+void trans_SXTB(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        NULL,
+        gen_helper_sve_sxtb_h,
+        gen_helper_sve_sxtb_s,
+        gen_helper_sve_sxtb_d
+    };
+    do_zpz_ool(s, a, fns[a->esz]);
+}
+
+void trans_UXTB(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        NULL,
+        gen_helper_sve_uxtb_h,
+        gen_helper_sve_uxtb_s,
+        gen_helper_sve_uxtb_d
+    };
+    do_zpz_ool(s, a, fns[a->esz]);
+}
+
+void trans_SXTH(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        NULL, NULL,
+        gen_helper_sve_sxth_s,
+        gen_helper_sve_sxth_d
+    };
+    do_zpz_ool(s, a, fns[a->esz]);
+}
+
+void trans_UXTH(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        NULL, NULL,
+        gen_helper_sve_uxth_s,
+        gen_helper_sve_uxth_d
+    };
+    do_zpz_ool(s, a, fns[a->esz]);
+}
+
+void trans_SXTW(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ool(s, a, a->esz == 3 ? gen_helper_sve_sxtw_d : NULL);
+}
+
+void trans_UXTW(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ool(s, a, a->esz == 3 ? gen_helper_sve_uxtw_d : NULL);
+}
+
+#undef DO_ZPZ
+
 typedef void gen_helper_gvec_reduc(TCGv_i64, TCGv_ptr, TCGv_ptr, TCGv_i32);
 static void do_vpz_ool(DisasContext *s, arg_rpr_esz *a,
                        gen_helper_gvec_reduc *fn)
diff --git a/target/arm/sve.def b/target/arm/sve.def
index 66be950ca5..955a0275a1 100644
--- a/target/arm/sve.def
+++ b/target/arm/sve.def
@@ -147,6 +147,27 @@ ASR_zpzw		00000100 .. 011 000 100 ... ..... .....		@rdn_pg_rm_esz
 LSR_zpzw		00000100 .. 011 001 100 ... ..... .....		@rdn_pg_rm_esz
 LSL_zpzw		00000100 .. 011 011 100 ... ..... .....		@rdn_pg_rm_esz
 
+### SVE Integer Arithmetic - Unary Predicated Group
+
+# SVE unary bit operations (predicated)
+CLS			00000100 .. 011 000 101 ... ..... .....		@rd_pg_rn_esz
+CLZ			00000100 .. 011 001 101 ... ..... .....		@rd_pg_rn_esz
+CNT_zpz			00000100 .. 011 010 101 ... ..... .....		@rd_pg_rn_esz
+CNOT			00000100 .. 011 011 101 ... ..... .....		@rd_pg_rn_esz
+NOT_zpz			00000100 .. 011 110 101 ... ..... .....		@rd_pg_rn_esz
+FABS			00000100 .. 011 100 101 ... ..... .....		@rd_pg_rn_esz # Note size != 0
+FNEG			00000100 .. 011 101 101 ... ..... .....		@rd_pg_rn_esz # Note size != 0
+
+# SVE integer unary operations (predicated)
+ABS			00000100 .. 010 110 101 ... ..... .....		@rd_pg_rn_esz
+NEG			00000100 .. 010 111 101 ... ..... .....		@rd_pg_rn_esz
+SXTB			00000100 .. 010 000 101 ... ..... .....		@rd_pg_rn_esz # Note size != 0
+UXTB			00000100 .. 010 001 101 ... ..... .....		@rd_pg_rn_esz # Note size != 0
+SXTH			00000100 .. 010 010 101 ... ..... .....		@rd_pg_rn_esz # Note size > 1
+UXTH			00000100 .. 010 011 101 ... ..... .....		@rd_pg_rn_esz # Note size > 1
+SXTW			00000100 .. 010 100 101 ... ..... .....		@rd_pg_rn_esz # Note size == 3
+UXTW			00000100 .. 010 101 101 ... ..... .....		@rd_pg_rn_esz # Note size == 3
+
 ### SVE Logical - Unpredicated Group
 
 # SVE bitwise logical operations (unpredicated)
-- 
2.14.3
