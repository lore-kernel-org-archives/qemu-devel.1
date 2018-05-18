Received: from eggs.gnu.org ([2001:4830:134:3::10]:36026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3I-0000hT-2x
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3F-0007Ul-6D
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:23 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj3E-0007Rj-FI
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:20 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3D-0004pF-DS
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:19 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:19:50 +0100
Message-Id: <20180518172009.14416-14-peter.maydell@linaro.org>
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 13/32] target/arm: Implement SVE Predicate
 Logical Operations Group
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
Message-id: 20180516223007.10256-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |   4 +-
 target/arm/helper-sve.h    |  10 +
 target/arm/sve_helper.c    |  39 ++++
 target/arm/translate-sve.c | 361 +++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  16 ++
 5 files changed, 429 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 01281f5c56..df21e143cc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -541,6 +541,8 @@ typedef struct CPUARMState {
 #ifdef TARGET_AARCH64
         /* Store FFR as pregs[16] to make it easier to treat as any other.  */
         ARMPredicateReg pregs[17];
+        /* Scratch space for aa64 sve predicate temporary.  */
+        ARMPredicateReg preg_tmp;
 #endif
 
         uint32_t xregs[16];
@@ -548,7 +550,7 @@ typedef struct CPUARMState {
         int vec_len;
         int vec_stride;
 
-        /* scratch space when Tn are not sufficient.  */
+        /* Scratch space for aa32 neon expansion.  */
         uint32_t scratch[8];
 
         /* There are a number of distinct float control structures:
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index b6e91539ae..57adc4d912 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -19,3 +19,13 @@
 
 DEF_HELPER_FLAGS_2(sve_predtest1, TCG_CALL_NO_WG, i32, i64, i64)
 DEF_HELPER_FLAGS_3(sve_predtest, TCG_CALL_NO_WG, i32, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_sel_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_orr_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_orn_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_nor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_nand_pppp, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 1ebb67e1df..2eda6f2ef1 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -76,3 +76,42 @@ uint32_t HELPER(sve_predtest)(void *vd, void *vg, uint32_t words)
 
     return flags;
 }
+
+#define LOGICAL_PPPP(NAME, FUNC) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)  \
+{                                                                         \
+    uintptr_t opr_sz = simd_oprsz(desc);                                  \
+    uint64_t *d = vd, *n = vn, *m = vm, *g = vg;                          \
+    uintptr_t i;                                                          \
+    for (i = 0; i < opr_sz / 8; ++i) {                                    \
+        d[i] = FUNC(n[i], m[i], g[i]);                                    \
+    }                                                                     \
+}
+
+#define DO_AND(N, M, G)  (((N) & (M)) & (G))
+#define DO_BIC(N, M, G)  (((N) & ~(M)) & (G))
+#define DO_EOR(N, M, G)  (((N) ^ (M)) & (G))
+#define DO_ORR(N, M, G)  (((N) | (M)) & (G))
+#define DO_ORN(N, M, G)  (((N) | ~(M)) & (G))
+#define DO_NOR(N, M, G)  (~((N) | (M)) & (G))
+#define DO_NAND(N, M, G) (~((N) & (M)) & (G))
+#define DO_SEL(N, M, G)  (((N) & (G)) | ((M) & ~(G)))
+
+LOGICAL_PPPP(sve_and_pppp, DO_AND)
+LOGICAL_PPPP(sve_bic_pppp, DO_BIC)
+LOGICAL_PPPP(sve_eor_pppp, DO_EOR)
+LOGICAL_PPPP(sve_sel_pppp, DO_SEL)
+LOGICAL_PPPP(sve_orr_pppp, DO_ORR)
+LOGICAL_PPPP(sve_orn_pppp, DO_ORN)
+LOGICAL_PPPP(sve_nor_pppp, DO_NOR)
+LOGICAL_PPPP(sve_nand_pppp, DO_NAND)
+
+#undef DO_AND
+#undef DO_BIC
+#undef DO_EOR
+#undef DO_ORR
+#undef DO_ORN
+#undef DO_NOR
+#undef DO_NAND
+#undef DO_SEL
+#undef LOGICAL_PPPP
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index c3f1b0bfa6..67fb3091ac 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -56,6 +56,28 @@ static inline int pred_full_reg_size(DisasContext *s)
     return s->sve_len >> 3;
 }
 
+/* Round up the size of a register to a size allowed by
+ * the tcg vector infrastructure.  Any operation which uses this
+ * size may assume that the bits above pred_full_reg_size are zero,
+ * and must leave them the same way.
+ *
+ * Note that this is not needed for the vector registers as they
+ * are always properly sized for tcg vectors.
+ */
+static int size_for_gvec(int size)
+{
+    if (size <= 8) {
+        return 8;
+    } else {
+        return QEMU_ALIGN_UP(size, 16);
+    }
+}
+
+static int pred_gvec_reg_size(DisasContext *s)
+{
+    return size_for_gvec(pred_full_reg_size(s));
+}
+
 /* Invoke a vector expander on two Zregs.  */
 static bool do_vector2_z(DisasContext *s, GVecGen2Fn *gvec_fn,
                          int esz, int rd, int rn)
@@ -87,6 +109,52 @@ static bool do_mov_z(DisasContext *s, int rd, int rn)
     return do_vector2_z(s, tcg_gen_gvec_mov, 0, rd, rn);
 }
 
+/* Invoke a vector expander on two Pregs.  */
+static bool do_vector2_p(DisasContext *s, GVecGen2Fn *gvec_fn,
+                         int esz, int rd, int rn)
+{
+    if (sve_access_check(s)) {
+        unsigned psz = pred_gvec_reg_size(s);
+        gvec_fn(esz, pred_full_reg_offset(s, rd),
+                pred_full_reg_offset(s, rn), psz, psz);
+    }
+    return true;
+}
+
+/* Invoke a vector expander on three Pregs.  */
+static bool do_vector3_p(DisasContext *s, GVecGen3Fn *gvec_fn,
+                         int esz, int rd, int rn, int rm)
+{
+    if (sve_access_check(s)) {
+        unsigned psz = pred_gvec_reg_size(s);
+        gvec_fn(esz, pred_full_reg_offset(s, rd),
+                pred_full_reg_offset(s, rn),
+                pred_full_reg_offset(s, rm), psz, psz);
+    }
+    return true;
+}
+
+/* Invoke a vector operation on four Pregs.  */
+static bool do_vecop4_p(DisasContext *s, const GVecGen4 *gvec_op,
+                        int rd, int rn, int rm, int rg)
+{
+    if (sve_access_check(s)) {
+        unsigned psz = pred_gvec_reg_size(s);
+        tcg_gen_gvec_4(pred_full_reg_offset(s, rd),
+                       pred_full_reg_offset(s, rn),
+                       pred_full_reg_offset(s, rm),
+                       pred_full_reg_offset(s, rg),
+                       psz, psz, gvec_op);
+    }
+    return true;
+}
+
+/* Invoke a vector move on two Pregs.  */
+static bool do_mov_p(DisasContext *s, int rd, int rn)
+{
+    return do_vector2_p(s, tcg_gen_gvec_mov, 0, rd, rn);
+}
+
 /* Set the cpu flags as per a return from an SVE helper.  */
 static void do_pred_flags(TCGv_i32 t)
 {
@@ -152,6 +220,299 @@ static bool trans_BIC_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
     return do_vector3_z(s, tcg_gen_gvec_andc, 0, a->rd, a->rn, a->rm);
 }
 
+/*
+ *** SVE Predicate Logical Operations Group
+ */
+
+static bool do_pppp_flags(DisasContext *s, arg_rprr_s *a,
+                          const GVecGen4 *gvec_op)
+{
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    unsigned psz = pred_gvec_reg_size(s);
+    int dofs = pred_full_reg_offset(s, a->rd);
+    int nofs = pred_full_reg_offset(s, a->rn);
+    int mofs = pred_full_reg_offset(s, a->rm);
+    int gofs = pred_full_reg_offset(s, a->pg);
+
+    if (psz == 8) {
+        /* Do the operation and the flags generation in temps.  */
+        TCGv_i64 pd = tcg_temp_new_i64();
+        TCGv_i64 pn = tcg_temp_new_i64();
+        TCGv_i64 pm = tcg_temp_new_i64();
+        TCGv_i64 pg = tcg_temp_new_i64();
+
+        tcg_gen_ld_i64(pn, cpu_env, nofs);
+        tcg_gen_ld_i64(pm, cpu_env, mofs);
+        tcg_gen_ld_i64(pg, cpu_env, gofs);
+
+        gvec_op->fni8(pd, pn, pm, pg);
+        tcg_gen_st_i64(pd, cpu_env, dofs);
+
+        do_predtest1(pd, pg);
+
+        tcg_temp_free_i64(pd);
+        tcg_temp_free_i64(pn);
+        tcg_temp_free_i64(pm);
+        tcg_temp_free_i64(pg);
+    } else {
+        /* The operation and flags generation is large.  The computation
+         * of the flags depends on the original contents of the guarding
+         * predicate.  If the destination overwrites the guarding predicate,
+         * then the easiest way to get this right is to save a copy.
+          */
+        int tofs = gofs;
+        if (a->rd == a->pg) {
+            tofs = offsetof(CPUARMState, vfp.preg_tmp);
+            tcg_gen_gvec_mov(0, tofs, gofs, psz, psz);
+        }
+
+        tcg_gen_gvec_4(dofs, nofs, mofs, gofs, psz, psz, gvec_op);
+        do_predtest(s, dofs, tofs, psz / 8);
+    }
+    return true;
+}
+
+static void gen_and_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
+{
+    tcg_gen_and_i64(pd, pn, pm);
+    tcg_gen_and_i64(pd, pd, pg);
+}
+
+static void gen_and_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
+                           TCGv_vec pm, TCGv_vec pg)
+{
+    tcg_gen_and_vec(vece, pd, pn, pm);
+    tcg_gen_and_vec(vece, pd, pd, pg);
+}
+
+static bool trans_AND_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+{
+    static const GVecGen4 op = {
+        .fni8 = gen_and_pg_i64,
+        .fniv = gen_and_pg_vec,
+        .fno = gen_helper_sve_and_pppp,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    if (a->s) {
+        return do_pppp_flags(s, a, &op);
+    } else if (a->rn == a->rm) {
+        if (a->pg == a->rn) {
+            return do_mov_p(s, a->rd, a->rn);
+        } else {
+            return do_vector3_p(s, tcg_gen_gvec_and, 0, a->rd, a->rn, a->pg);
+        }
+    } else if (a->pg == a->rn || a->pg == a->rm) {
+        return do_vector3_p(s, tcg_gen_gvec_and, 0, a->rd, a->rn, a->rm);
+    } else {
+        return do_vecop4_p(s, &op, a->rd, a->rn, a->rm, a->pg);
+    }
+}
+
+static void gen_bic_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
+{
+    tcg_gen_andc_i64(pd, pn, pm);
+    tcg_gen_and_i64(pd, pd, pg);
+}
+
+static void gen_bic_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
+                           TCGv_vec pm, TCGv_vec pg)
+{
+    tcg_gen_andc_vec(vece, pd, pn, pm);
+    tcg_gen_and_vec(vece, pd, pd, pg);
+}
+
+static bool trans_BIC_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+{
+    static const GVecGen4 op = {
+        .fni8 = gen_bic_pg_i64,
+        .fniv = gen_bic_pg_vec,
+        .fno = gen_helper_sve_bic_pppp,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    if (a->s) {
+        return do_pppp_flags(s, a, &op);
+    } else if (a->pg == a->rn) {
+        return do_vector3_p(s, tcg_gen_gvec_andc, 0, a->rd, a->rn, a->rm);
+    } else {
+        return do_vecop4_p(s, &op, a->rd, a->rn, a->rm, a->pg);
+    }
+}
+
+static void gen_eor_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
+{
+    tcg_gen_xor_i64(pd, pn, pm);
+    tcg_gen_and_i64(pd, pd, pg);
+}
+
+static void gen_eor_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
+                           TCGv_vec pm, TCGv_vec pg)
+{
+    tcg_gen_xor_vec(vece, pd, pn, pm);
+    tcg_gen_and_vec(vece, pd, pd, pg);
+}
+
+static bool trans_EOR_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+{
+    static const GVecGen4 op = {
+        .fni8 = gen_eor_pg_i64,
+        .fniv = gen_eor_pg_vec,
+        .fno = gen_helper_sve_eor_pppp,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    if (a->s) {
+        return do_pppp_flags(s, a, &op);
+    } else {
+        return do_vecop4_p(s, &op, a->rd, a->rn, a->rm, a->pg);
+    }
+}
+
+static void gen_sel_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
+{
+    tcg_gen_and_i64(pn, pn, pg);
+    tcg_gen_andc_i64(pm, pm, pg);
+    tcg_gen_or_i64(pd, pn, pm);
+}
+
+static void gen_sel_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
+                           TCGv_vec pm, TCGv_vec pg)
+{
+    tcg_gen_and_vec(vece, pn, pn, pg);
+    tcg_gen_andc_vec(vece, pm, pm, pg);
+    tcg_gen_or_vec(vece, pd, pn, pm);
+}
+
+static bool trans_SEL_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+{
+    static const GVecGen4 op = {
+        .fni8 = gen_sel_pg_i64,
+        .fniv = gen_sel_pg_vec,
+        .fno = gen_helper_sve_sel_pppp,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    if (a->s) {
+        return false;
+    } else {
+        return do_vecop4_p(s, &op, a->rd, a->rn, a->rm, a->pg);
+    }
+}
+
+static void gen_orr_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
+{
+    tcg_gen_or_i64(pd, pn, pm);
+    tcg_gen_and_i64(pd, pd, pg);
+}
+
+static void gen_orr_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
+                           TCGv_vec pm, TCGv_vec pg)
+{
+    tcg_gen_or_vec(vece, pd, pn, pm);
+    tcg_gen_and_vec(vece, pd, pd, pg);
+}
+
+static bool trans_ORR_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+{
+    static const GVecGen4 op = {
+        .fni8 = gen_orr_pg_i64,
+        .fniv = gen_orr_pg_vec,
+        .fno = gen_helper_sve_orr_pppp,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    if (a->s) {
+        return do_pppp_flags(s, a, &op);
+    } else if (a->pg == a->rn && a->rn == a->rm) {
+        return do_mov_p(s, a->rd, a->rn);
+    } else {
+        return do_vecop4_p(s, &op, a->rd, a->rn, a->rm, a->pg);
+    }
+}
+
+static void gen_orn_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
+{
+    tcg_gen_orc_i64(pd, pn, pm);
+    tcg_gen_and_i64(pd, pd, pg);
+}
+
+static void gen_orn_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
+                           TCGv_vec pm, TCGv_vec pg)
+{
+    tcg_gen_orc_vec(vece, pd, pn, pm);
+    tcg_gen_and_vec(vece, pd, pd, pg);
+}
+
+static bool trans_ORN_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+{
+    static const GVecGen4 op = {
+        .fni8 = gen_orn_pg_i64,
+        .fniv = gen_orn_pg_vec,
+        .fno = gen_helper_sve_orn_pppp,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    if (a->s) {
+        return do_pppp_flags(s, a, &op);
+    } else {
+        return do_vecop4_p(s, &op, a->rd, a->rn, a->rm, a->pg);
+    }
+}
+
+static void gen_nor_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
+{
+    tcg_gen_or_i64(pd, pn, pm);
+    tcg_gen_andc_i64(pd, pg, pd);
+}
+
+static void gen_nor_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
+                           TCGv_vec pm, TCGv_vec pg)
+{
+    tcg_gen_or_vec(vece, pd, pn, pm);
+    tcg_gen_andc_vec(vece, pd, pg, pd);
+}
+
+static bool trans_NOR_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+{
+    static const GVecGen4 op = {
+        .fni8 = gen_nor_pg_i64,
+        .fniv = gen_nor_pg_vec,
+        .fno = gen_helper_sve_nor_pppp,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    if (a->s) {
+        return do_pppp_flags(s, a, &op);
+    } else {
+        return do_vecop4_p(s, &op, a->rd, a->rn, a->rm, a->pg);
+    }
+}
+
+static void gen_nand_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
+{
+    tcg_gen_and_i64(pd, pn, pm);
+    tcg_gen_andc_i64(pd, pg, pd);
+}
+
+static void gen_nand_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
+                           TCGv_vec pm, TCGv_vec pg)
+{
+    tcg_gen_and_vec(vece, pd, pn, pm);
+    tcg_gen_andc_vec(vece, pd, pg, pd);
+}
+
+static bool trans_NAND_pppp(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+{
+    static const GVecGen4 op = {
+        .fni8 = gen_nand_pg_i64,
+        .fniv = gen_nand_pg_vec,
+        .fno = gen_helper_sve_nand_pppp,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    if (a->s) {
+        return do_pppp_flags(s, a, &op);
+    } else {
+        return do_vecop4_p(s, &op, a->rd, a->rn, a->rm, a->pg);
+    }
+}
+
 /*
  *** SVE Predicate Misc Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index a44ca2f551..f695dda3b1 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -31,6 +31,7 @@
 
 &rri            rd rn imm
 &rrr_esz        rd rn rm esz
+&rprr_s         rd pg rn rm s
 
 ###########################################################################
 # Named instruction formats.  These are generally used to
@@ -39,6 +40,9 @@
 # Three operand with unused vector element size
 @rd_rn_rm_e0    ........ ... rm:5 ... ... rn:5 rd:5             &rrr_esz esz=0
 
+# Three predicate operand, with governing predicate, flag setting
+@pd_pg_pn_pm_s  ........ . s:1 .. rm:4 .. pg:4 . rn:4 . rd:4    &rprr_s
+
 # Basic Load/Store with 9-bit immediate offset
 @pd_rn_i9       ........ ........ ...... rn:5 . rd:4    \
                 &rri imm=%imm9_16_10
@@ -56,6 +60,18 @@ ORR_zzz         00000100 01 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
 EOR_zzz         00000100 10 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
 BIC_zzz         00000100 11 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
 
+### SVE Predicate Logical Operations Group
+
+# SVE predicate logical operations
+AND_pppp        00100101 0. 00 .... 01 .... 0 .... 0 ....       @pd_pg_pn_pm_s
+BIC_pppp        00100101 0. 00 .... 01 .... 0 .... 1 ....       @pd_pg_pn_pm_s
+EOR_pppp        00100101 0. 00 .... 01 .... 1 .... 0 ....       @pd_pg_pn_pm_s
+SEL_pppp        00100101 0. 00 .... 01 .... 1 .... 1 ....       @pd_pg_pn_pm_s
+ORR_pppp        00100101 1. 00 .... 01 .... 0 .... 0 ....       @pd_pg_pn_pm_s
+ORN_pppp        00100101 1. 00 .... 01 .... 0 .... 1 ....       @pd_pg_pn_pm_s
+NOR_pppp        00100101 1. 00 .... 01 .... 1 .... 0 ....       @pd_pg_pn_pm_s
+NAND_pppp       00100101 1. 00 .... 01 .... 1 .... 1 ....       @pd_pg_pn_pm_s
+
 ### SVE Predicate Misc Group
 
 # SVE predicate test
-- 
2.17.0
