Received: from eggs.gnu.org ([2001:4830:134:3::10]:33978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYums-0007YB-OY
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumq-0006xU-DU
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYumq-0006qw-3T
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:12 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumo-0004fH-JS
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:10 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:18 +0100
Message-Id: <20180629145347.652-27-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 26/55] target/arm: Implement SVE Floating Point
 Unary Operations - Unpredicated Group
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
Message-id: 20180627043328.11531-21-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        |  8 +++++++
 target/arm/translate-sve.c | 47 ++++++++++++++++++++++++++++++++++++++
 target/arm/vec_helper.c    | 20 ++++++++++++++++
 target/arm/sve.decode      |  5 ++++
 4 files changed, 80 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 56439ac1e41..ad9cb6c7d57 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -601,6 +601,14 @@ DEF_HELPER_FLAGS_5(gvec_fcmlas_idx, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_fcmlad, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
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
index b026ee34202..b8019095025 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3507,6 +3507,53 @@ DO_VPZ(FMAXNMV, fmaxnmv)
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
+static bool trans_FRECPE(DisasContext *s, arg_rr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_2_ptr * const fns[3] = {
+        gen_helper_gvec_frecpe_h,
+        gen_helper_gvec_frecpe_s,
+        gen_helper_gvec_frecpe_d,
+    };
+    if (a->esz == 0) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        do_zz_fp(s, a, fns[a->esz - 1]);
+    }
+    return true;
+}
+
+static bool trans_FRSQRTE(DisasContext *s, arg_rr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_2_ptr * const fns[3] = {
+        gen_helper_gvec_frsqrte_h,
+        gen_helper_gvec_frsqrte_s,
+        gen_helper_gvec_frsqrte_d,
+    };
+    if (a->esz == 0) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        do_zz_fp(s, a, fns[a->esz - 1]);
+    }
+    return true;
+}
+
 /*
  *** SVE Floating Point Accumulating Reduction Group
  */
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 97af75a61b3..073e5c58e7e 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -427,6 +427,26 @@ void HELPER(gvec_fcmlad)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
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
index 66b0fd0cc40..ca93bdb2b30 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -743,6 +743,11 @@ FMINNMV         01100101 .. 000 101 001 ... ..... .....         @rd_pg_rn
 FMAXV           01100101 .. 000 110 001 ... ..... .....         @rd_pg_rn
 FMINV           01100101 .. 000 111 001 ... ..... .....         @rd_pg_rn
 
+## SVE Floating Point Unary Operations - Unpredicated Group
+
+FRECPE          01100101 .. 001 110 001100 ..... .....          @rd_rn
+FRSQRTE         01100101 .. 001 111 001100 ..... .....          @rd_rn
+
 ### SVE FP Accumulating Reduction Group
 
 # SVE floating-point serial reduction (predicated)
-- 
2.17.1
