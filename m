Received: from eggs.gnu.org ([2001:4830:134:3::10]:40666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7AC-0001On-Mi
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7AA-00025r-UN
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:44 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:38170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en7AA-00025S-Lt
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:42 -0500
Received: by mail-pl0-x241.google.com with SMTP id h10so3439633plt.5
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:23:03 -0800
Message-Id: <20180217182323.25885-48-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 47/67] target/arm: Implement SVE integer
 convert to floating-point
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
 target/arm/helper-sve.h    | 30 +++++++++++++++
 target/arm/sve_helper.c    | 52 ++++++++++++++++++++++++++
 target/arm/translate-sve.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      | 22 +++++++++++
 4 files changed, 196 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 74c2d642a3..fb7609f9ef 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -720,6 +720,36 @@ DEF_HELPER_FLAGS_5(gvec_rsqrts_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_rsqrts_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve_scvt_hh, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_scvt_sh, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_scvt_dh, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_scvt_ss, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_scvt_sd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_scvt_ds, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_scvt_dd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_ucvt_hh, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_ucvt_sh, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_ucvt_dh, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_ucvt_ss, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_ucvt_sd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_ucvt_ds, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_ucvt_dd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_ld1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index e259e910de..a1e0ceb5fb 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2789,6 +2789,58 @@ uint32_t HELPER(sve_while)(void *vd, uint32_t count, uint32_t pred_desc)
     return predtest_ones(d, oprsz, esz_mask);
 }
 
+/* Fully general two-operand expander, controlled by a predicate,
+ * With the extra float_status parameter.
+ */
+#define DO_ZPZ_FP(NAME, TYPE, H, OP)                            \
+void HELPER(NAME)(void *vd, void *vn, void *vg, void *status, uint32_t desc) \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc);                      \
+    for (i = 0; i < opr_sz; ) {                                 \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));         \
+        do {                                                    \
+            if (pg & 1) {                                       \
+                TYPE nn = *(TYPE *)(vn + H(i));                 \
+                *(TYPE *)(vd + H(i)) = OP(nn, status);          \
+            }                                                   \
+            i += sizeof(TYPE), pg >>= sizeof(TYPE);             \
+        } while (i & 15);                                       \
+    }                                                           \
+}
+
+/* Similarly, specialized for 64-bit operands.  */
+#define DO_ZPZ_FP_D(NAME, TYPE, OP)                             \
+void HELPER(NAME)(void *vd, void *vn, void *vg, void *status, uint32_t desc) \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;                  \
+    TYPE *d = vd, *n = vn;                                      \
+    uint8_t *pg = vg;                                           \
+    for (i = 0; i < opr_sz; i += 1) {                           \
+        if (pg[H1(i)] & 1) {                                    \
+            d[i] = OP(n[i], status);                            \
+        }                                                       \
+    }                                                           \
+}
+
+DO_ZPZ_FP(sve_scvt_hh, uint16_t, H1_2, int16_to_float16)
+DO_ZPZ_FP(sve_scvt_sh, uint32_t, H1_4, int32_to_float16)
+DO_ZPZ_FP(sve_scvt_ss, uint32_t, H1_4, int32_to_float32)
+DO_ZPZ_FP_D(sve_scvt_sd, uint64_t, int32_to_float64)
+DO_ZPZ_FP_D(sve_scvt_dh, uint64_t, int64_to_float16)
+DO_ZPZ_FP_D(sve_scvt_ds, uint64_t, int64_to_float32)
+DO_ZPZ_FP_D(sve_scvt_dd, uint64_t, int64_to_float64)
+
+DO_ZPZ_FP(sve_ucvt_hh, uint16_t, H1_2, uint16_to_float16)
+DO_ZPZ_FP(sve_ucvt_sh, uint32_t, H1_4, uint32_to_float16)
+DO_ZPZ_FP(sve_ucvt_ss, uint32_t, H1_4, uint32_to_float32)
+DO_ZPZ_FP_D(sve_ucvt_sd, uint64_t, uint32_to_float64)
+DO_ZPZ_FP_D(sve_ucvt_dh, uint64_t, uint64_to_float16)
+DO_ZPZ_FP_D(sve_ucvt_ds, uint64_t, uint64_to_float32)
+DO_ZPZ_FP_D(sve_ucvt_dd, uint64_t, uint64_to_float64)
+
+#undef DO_ZPZ_FP
+#undef DO_ZPZ_FP_D
+
 /*
  * Load contiguous data, protected by a governing predicate.
  */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 7b21102b7e..05c684222e 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3161,6 +3161,98 @@ DO_FP3(FRSQRTS, rsqrts)
 
 #undef DO_FP3
 
+
+/*
+ *** SVE Floating Point Unary Operations Prediated Group
+ */
+
+static void do_zpz_ptr(DisasContext *s, int rd, int rn, int pg,
+                       bool is_fp16, gen_helper_gvec_3_ptr *fn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    TCGv_ptr status;
+
+    if (fn == NULL) {
+        unallocated_encoding(s);
+        return;
+    }
+    status = get_fpstatus_ptr(is_fp16);
+    tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       pred_full_reg_offset(s, pg),
+                       status, vsz, vsz, 0, fn);
+}
+
+static void trans_SCVTF_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_scvt_hh);
+}
+
+static void trans_SCVTF_sh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_scvt_sh);
+}
+
+static void trans_SCVTF_dh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_scvt_dh);
+}
+
+static void trans_SCVTF_ss(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_scvt_ss);
+}
+
+static void trans_SCVTF_ds(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_scvt_ds);
+}
+
+static void trans_SCVTF_sd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_scvt_sd);
+}
+
+static void trans_SCVTF_dd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_scvt_dd);
+}
+
+static void trans_UCVTF_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_ucvt_hh);
+}
+
+static void trans_UCVTF_sh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_ucvt_sh);
+}
+
+static void trans_UCVTF_dh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_ucvt_dh);
+}
+
+static void trans_UCVTF_ss(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_ucvt_ss);
+}
+
+static void trans_UCVTF_ds(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_ucvt_ds);
+}
+
+static void trans_UCVTF_sd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_ucvt_sd);
+}
+
+static void trans_UCVTF_dd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_ucvt_dd);
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 6c906e25e9..b571b70050 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -134,6 +134,9 @@
 @rd_pg_rn	........ esz:2 ... ... ... pg:3 rn:5 rd:5	&rpr_esz
 @rd_pg4_pn	........ esz:2 ... ... .. pg:4 . rn:4 rd:5	&rpr_esz
 
+# One register operand, with governing predicate, no vector element size
+@rd_pg_rn_e0	........ .. ... ... ... pg:3 rn:5 rd:5		&rpr_esz esz=0
+
 # Two register operands with a 6-bit signed immediate.
 @rd_rn_i6	........ ... rn:5 ..... imm:s6 rd:5		&rri
 
@@ -689,6 +692,25 @@ FTSMUL		01100101 .. 0 ..... 000 011 ..... .....		@rd_rn_rm
 FRECPS		01100101 .. 0 ..... 000 110 ..... .....		@rd_rn_rm
 FRSQRTS		01100101 .. 0 ..... 000 111 ..... .....		@rd_rn_rm
 
+### SVE FP Unary Operations Predicated Group
+
+# SVE integer convert to floating-point
+SCVTF_hh	01100101 01 010 01 0 101 ... ..... .....	@rd_pg_rn_e0
+SCVTF_sh	01100101 01 010 10 0 101 ... ..... .....	@rd_pg_rn_e0
+SCVTF_dh	01100101 01 010 11 0 101 ... ..... .....	@rd_pg_rn_e0
+SCVTF_ss	01100101 10 010 10 0 101 ... ..... .....	@rd_pg_rn_e0
+SCVTF_sd	01100101 11 010 00 0 101 ... ..... .....	@rd_pg_rn_e0
+SCVTF_ds	01100101 11 010 10 0 101 ... ..... .....	@rd_pg_rn_e0
+SCVTF_dd	01100101 11 010 11 0 101 ... ..... .....	@rd_pg_rn_e0
+
+UCVTF_hh	01100101 01 010 01 1 101 ... ..... .....	@rd_pg_rn_e0
+UCVTF_sh	01100101 01 010 10 1 101 ... ..... .....	@rd_pg_rn_e0
+UCVTF_dh	01100101 01 010 11 1 101 ... ..... .....	@rd_pg_rn_e0
+UCVTF_ss	01100101 10 010 10 1 101 ... ..... .....	@rd_pg_rn_e0
+UCVTF_sd	01100101 11 010 00 1 101 ... ..... .....	@rd_pg_rn_e0
+UCVTF_ds	01100101 11 010 10 1 101 ... ..... .....	@rd_pg_rn_e0
+UCVTF_dd	01100101 11 010 11 1 101 ... ..... .....	@rd_pg_rn_e0
+
 ### SVE Memory - 32-bit Gather and Unsized Contiguous Group
 
 # SVE load predicate register
-- 
2.14.3
