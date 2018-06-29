Received: from eggs.gnu.org ([2001:4830:134:3::10]:33946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumq-0007W1-T6
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumn-0006ou-U7
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYumn-0006kj-9N
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:09 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumm-0004dv-6z
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:08 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:15 +0100
Message-Id: <20180629145347.652-24-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 23/55] target/arm: Implement SVE floating-point
 arithmetic with immediate
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
Message-id: 20180627043328.11531-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    | 56 ++++++++++++++++++++++++++++
 target/arm/sve_helper.c    | 69 +++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 75 ++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      | 14 +++++++
 4 files changed, 214 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 6089b3a53fd..087819ec2b5 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -809,6 +809,62 @@ DEF_HELPER_FLAGS_6(sve_fmulx_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_fmulx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_6(sve_fadds_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fadds_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fadds_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fsubs_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fsubs_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fsubs_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fmuls_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmuls_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmuls_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fsubrs_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fsubrs_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fsubrs_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fmaxnms_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmaxnms_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmaxnms_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fminnms_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fminnms_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fminnms_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fmaxs_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmaxs_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmaxs_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve_fmins_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmins_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fmins_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_scvt_hh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_scvt_sh, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 41d8ce6b54d..bc23c66221f 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2997,6 +2997,75 @@ DO_ZPZZ_FP(sve_fmulx_d, uint64_t,     , helper_vfp_mulxd)
 
 #undef DO_ZPZZ_FP
 
+/* Three-operand expander, with one scalar operand, controlled by
+ * a predicate, with the extra float_status parameter.
+ */
+#define DO_ZPZS_FP(NAME, TYPE, H, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vg, uint64_t scalar,  \
+                  void *status, uint32_t desc)                    \
+{                                                                 \
+    intptr_t i = simd_oprsz(desc);                                \
+    uint64_t *g = vg;                                             \
+    TYPE mm = scalar;                                             \
+    do {                                                          \
+        uint64_t pg = g[(i - 1) >> 6];                            \
+        do {                                                      \
+            i -= sizeof(TYPE);                                    \
+            if (likely((pg >> (i & 63)) & 1)) {                   \
+                TYPE nn = *(TYPE *)(vn + H(i));                   \
+                *(TYPE *)(vd + H(i)) = OP(nn, mm, status);        \
+            }                                                     \
+        } while (i & 63);                                         \
+    } while (i != 0);                                             \
+}
+
+DO_ZPZS_FP(sve_fadds_h, float16, H1_2, float16_add)
+DO_ZPZS_FP(sve_fadds_s, float32, H1_4, float32_add)
+DO_ZPZS_FP(sve_fadds_d, float64,     , float64_add)
+
+DO_ZPZS_FP(sve_fsubs_h, float16, H1_2, float16_sub)
+DO_ZPZS_FP(sve_fsubs_s, float32, H1_4, float32_sub)
+DO_ZPZS_FP(sve_fsubs_d, float64,     , float64_sub)
+
+DO_ZPZS_FP(sve_fmuls_h, float16, H1_2, float16_mul)
+DO_ZPZS_FP(sve_fmuls_s, float32, H1_4, float32_mul)
+DO_ZPZS_FP(sve_fmuls_d, float64,     , float64_mul)
+
+static inline float16 subr_h(float16 a, float16 b, float_status *s)
+{
+    return float16_sub(b, a, s);
+}
+
+static inline float32 subr_s(float32 a, float32 b, float_status *s)
+{
+    return float32_sub(b, a, s);
+}
+
+static inline float64 subr_d(float64 a, float64 b, float_status *s)
+{
+    return float64_sub(b, a, s);
+}
+
+DO_ZPZS_FP(sve_fsubrs_h, float16, H1_2, subr_h)
+DO_ZPZS_FP(sve_fsubrs_s, float32, H1_4, subr_s)
+DO_ZPZS_FP(sve_fsubrs_d, float64,     , subr_d)
+
+DO_ZPZS_FP(sve_fmaxnms_h, float16, H1_2, float16_maxnum)
+DO_ZPZS_FP(sve_fmaxnms_s, float32, H1_4, float32_maxnum)
+DO_ZPZS_FP(sve_fmaxnms_d, float64,     , float64_maxnum)
+
+DO_ZPZS_FP(sve_fminnms_h, float16, H1_2, float16_minnum)
+DO_ZPZS_FP(sve_fminnms_s, float32, H1_4, float32_minnum)
+DO_ZPZS_FP(sve_fminnms_d, float64,     , float64_minnum)
+
+DO_ZPZS_FP(sve_fmaxs_h, float16, H1_2, float16_max)
+DO_ZPZS_FP(sve_fmaxs_s, float32, H1_4, float32_max)
+DO_ZPZS_FP(sve_fmaxs_d, float64,     , float64_max)
+
+DO_ZPZS_FP(sve_fmins_h, float16, H1_2, float16_min)
+DO_ZPZS_FP(sve_fmins_s, float32, H1_4, float32_min)
+DO_ZPZS_FP(sve_fmins_d, float64,     , float64_min)
+
 /* Fully general two-operand expander, controlled by a predicate,
  * With the extra float_status parameter.
  */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 0397109778b..1b467a5ddcd 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -32,6 +32,7 @@
 #include "exec/log.h"
 #include "trace-tcg.h"
 #include "translate-a64.h"
+#include "fpu/softfloat.h"
 
 
 typedef void GVecGen2sFn(unsigned, uint32_t, uint32_t,
@@ -3533,6 +3534,80 @@ DO_FP3(FMULX, fmulx)
 
 #undef DO_FP3
 
+typedef void gen_helper_sve_fp2scalar(TCGv_ptr, TCGv_ptr, TCGv_ptr,
+                                      TCGv_i64, TCGv_ptr, TCGv_i32);
+
+static void do_fp_scalar(DisasContext *s, int zd, int zn, int pg, bool is_fp16,
+                         TCGv_i64 scalar, gen_helper_sve_fp2scalar *fn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    TCGv_ptr t_zd, t_zn, t_pg, status;
+    TCGv_i32 desc;
+
+    t_zd = tcg_temp_new_ptr();
+    t_zn = tcg_temp_new_ptr();
+    t_pg = tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(t_zd, cpu_env, vec_full_reg_offset(s, zd));
+    tcg_gen_addi_ptr(t_zn, cpu_env, vec_full_reg_offset(s, zn));
+    tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
+
+    status = get_fpstatus_ptr(is_fp16);
+    desc = tcg_const_i32(simd_desc(vsz, vsz, 0));
+    fn(t_zd, t_zn, t_pg, scalar, status, desc);
+
+    tcg_temp_free_i32(desc);
+    tcg_temp_free_ptr(status);
+    tcg_temp_free_ptr(t_pg);
+    tcg_temp_free_ptr(t_zn);
+    tcg_temp_free_ptr(t_zd);
+}
+
+static void do_fp_imm(DisasContext *s, arg_rpri_esz *a, uint64_t imm,
+                      gen_helper_sve_fp2scalar *fn)
+{
+    TCGv_i64 temp = tcg_const_i64(imm);
+    do_fp_scalar(s, a->rd, a->rn, a->pg, a->esz == MO_16, temp, fn);
+    tcg_temp_free_i64(temp);
+}
+
+#define DO_FP_IMM(NAME, name, const0, const1) \
+static bool trans_##NAME##_zpzi(DisasContext *s, arg_rpri_esz *a,         \
+                                uint32_t insn)                            \
+{                                                                         \
+    static gen_helper_sve_fp2scalar * const fns[3] = {                    \
+        gen_helper_sve_##name##_h,                                        \
+        gen_helper_sve_##name##_s,                                        \
+        gen_helper_sve_##name##_d                                         \
+    };                                                                    \
+    static uint64_t const val[3][2] = {                                   \
+        { float16_##const0, float16_##const1 },                           \
+        { float32_##const0, float32_##const1 },                           \
+        { float64_##const0, float64_##const1 },                           \
+    };                                                                    \
+    if (a->esz == 0) {                                                    \
+        return false;                                                     \
+    }                                                                     \
+    if (sve_access_check(s)) {                                            \
+        do_fp_imm(s, a, val[a->esz - 1][a->imm], fns[a->esz - 1]);        \
+    }                                                                     \
+    return true;                                                          \
+}
+
+#define float16_two  make_float16(0x4000)
+#define float32_two  make_float32(0x40000000)
+#define float64_two  make_float64(0x4000000000000000ULL)
+
+DO_FP_IMM(FADD, fadds, half, one)
+DO_FP_IMM(FSUB, fsubs, half, one)
+DO_FP_IMM(FMUL, fmuls, half, two)
+DO_FP_IMM(FSUBR, fsubrs, half, one)
+DO_FP_IMM(FMAXNM, fmaxnms, zero, one)
+DO_FP_IMM(FMINNM, fminnms, zero, one)
+DO_FP_IMM(FMAX, fmaxs, zero, one)
+DO_FP_IMM(FMIN, fmins, zero, one)
+
+#undef DO_FP_IMM
+
 static bool do_fp_cmp(DisasContext *s, arg_rprr_esz *a,
                       gen_helper_gvec_4_ptr *fn)
 {
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index a1bc6cb395c..267eb2dcfc6 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -160,6 +160,10 @@
 @rdn_pg4        ........ esz:2 .. pg:4 ... ........ rd:5 \
                 &rpri_esz rn=%reg_movprfx
 
+# Two register operand, one one-bit floating-point operand.
+@rdn_i1         ........ esz:2 ......... pg:3 .... imm:1 rd:5 \
+                &rpri_esz rn=%reg_movprfx
+
 # Two register operand, one encoded bitmask.
 @rdn_dbm        ........ .. .... dbm:13 rd:5 \
                 &rr_dbm rn=%reg_movprfx
@@ -744,6 +748,16 @@ FMULX           01100101 .. 00 1010 100 ... ..... .....    @rdn_pg_rm
 FDIV            01100101 .. 00 1100 100 ... ..... .....    @rdm_pg_rn # FDIVR
 FDIV            01100101 .. 00 1101 100 ... ..... .....    @rdn_pg_rm
 
+# SVE floating-point arithmetic with immediate (predicated)
+FADD_zpzi       01100101 .. 011 000 100 ... 0000 . .....        @rdn_i1
+FSUB_zpzi       01100101 .. 011 001 100 ... 0000 . .....        @rdn_i1
+FMUL_zpzi       01100101 .. 011 010 100 ... 0000 . .....        @rdn_i1
+FSUBR_zpzi      01100101 .. 011 011 100 ... 0000 . .....        @rdn_i1
+FMAXNM_zpzi     01100101 .. 011 100 100 ... 0000 . .....        @rdn_i1
+FMINNM_zpzi     01100101 .. 011 101 100 ... 0000 . .....        @rdn_i1
+FMAX_zpzi       01100101 .. 011 110 100 ... 0000 . .....        @rdn_i1
+FMIN_zpzi       01100101 .. 011 111 100 ... 0000 . .....        @rdn_i1
+
 ### SVE FP Multiply-Add Group
 
 # SVE floating-point multiply-accumulate writing addend
-- 
2.17.1
