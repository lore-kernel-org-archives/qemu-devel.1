Received: from eggs.gnu.org ([2001:4830:134:3::10]:39336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVoo9-0004bI-21
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVoo8-0003I8-18
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:45 -0400
Received: from mail-pl0-x22f.google.com ([2607:f8b0:400e:c01::22f]:38072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fVoo7-0003Hl-PM
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:43 -0400
Received: by mail-pl0-x22f.google.com with SMTP id d10-v6so757627plo.5
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:54:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Jun 2018 15:53:44 -1000
Message-Id: <20180621015359.12018-21-richard.henderson@linaro.org>
In-Reply-To: <20180621015359.12018-1-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 20/35] target/arm: Implement SVE Floating
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
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  8 +++++++
 target/arm/translate-sve.c | 47 ++++++++++++++++++++++++++++++++++++++
 target/arm/vec_helper.c    | 20 ++++++++++++++++
 target/arm/sve.decode      |  5 ++++
 4 files changed, 80 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 56439ac1e4..ad9cb6c7d5 100644
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
index 47d64f2fc7..d7957cddbd 100644
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
index 97af75a61b..073e5c58e7 100644
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
index 39a803621f..191be9463d 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -739,6 +739,11 @@ FMINNMV         01100101 .. 000 101 001 ... ..... .....         @rd_pg_rn
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
