Received: from eggs.gnu.org ([2001:4830:134:3::10]:44132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSv2O-0002Zi-K0
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSv2M-0006Jq-VL
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:57:28 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:40640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSv2M-0006Jd-MU
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:57:26 -0400
Received: by mail-pl0-x241.google.com with SMTP id t12-v6so551091plo.7
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 18:57:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Jun 2018 15:56:37 -1000
Message-Id: <20180613015641.5667-15-richard.henderson@linaro.org>
In-Reply-To: <20180613015641.5667-1-richard.henderson@linaro.org>
References: <20180613015641.5667-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4b 14/18] target/arm: Implement SVE Predicate
 Count Group
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |   2 +
 target/arm/sve_helper.c    |  14 ++++
 target/arm/translate-sve.c | 133 +++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  27 ++++++++
 4 files changed, 176 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index f0a3ed3414..dd4f8f754d 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -676,3 +676,5 @@ DEF_HELPER_FLAGS_4(sve_brkbs_m, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(sve_brkn, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_brkns, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve_cntp, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b27b502d75..a4ecd653c1 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2724,3 +2724,17 @@ uint32_t HELPER(sve_brkns)(void *vd, void *vn, void *vg, uint32_t pred_desc)
         return do_zero(vd, oprsz);
     }
 }
+
+uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    intptr_t esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
+    uint64_t *n = vn, *g = vg, sum = 0, mask = pred_esz_masks[esz];
+    intptr_t i;
+
+    for (i = 0; i < DIV_ROUND_UP(oprsz, 8); ++i) {
+        uint64_t t = n[i] & g[i] & mask;
+        sum += ctpop64(t);
+    }
+    return sum;
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index c381240b6f..6b0b8c55d0 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -34,6 +34,9 @@
 #include "translate-a64.h"
 
 
+typedef void GVecGen2sFn(unsigned, uint32_t, uint32_t,
+                         TCGv_i64, uint32_t, uint32_t);
+
 typedef void gen_helper_gvec_flags_3(TCGv_i32, TCGv_ptr, TCGv_ptr,
                                      TCGv_ptr, TCGv_i32);
 typedef void gen_helper_gvec_flags_4(TCGv_i32, TCGv_ptr, TCGv_ptr,
@@ -2959,6 +2962,136 @@ static bool trans_BRKN(DisasContext *s, arg_rpr_s *a, uint32_t insn)
     return do_brk2(s, a, gen_helper_sve_brkn, gen_helper_sve_brkns);
 }
 
+/*
+ *** SVE Predicate Count Group
+ */
+
+static void do_cntp(DisasContext *s, TCGv_i64 val, int esz, int pn, int pg)
+{
+    unsigned psz = pred_full_reg_size(s);
+
+    if (psz <= 8) {
+        uint64_t psz_mask;
+
+        tcg_gen_ld_i64(val, cpu_env, pred_full_reg_offset(s, pn));
+        if (pn != pg) {
+            TCGv_i64 g = tcg_temp_new_i64();
+            tcg_gen_ld_i64(g, cpu_env, pred_full_reg_offset(s, pg));
+            tcg_gen_and_i64(val, val, g);
+            tcg_temp_free_i64(g);
+        }
+
+        /* Reduce the pred_esz_masks value simply to reduce the
+         * size of the code generated here.
+         */
+        psz_mask = MAKE_64BIT_MASK(0, psz * 8);
+        tcg_gen_andi_i64(val, val, pred_esz_masks[esz] & psz_mask);
+
+        tcg_gen_ctpop_i64(val, val);
+    } else {
+        TCGv_ptr t_pn = tcg_temp_new_ptr();
+        TCGv_ptr t_pg = tcg_temp_new_ptr();
+        unsigned desc;
+        TCGv_i32 t_desc;
+
+        desc = psz - 2;
+        desc = deposit32(desc, SIMD_DATA_SHIFT, 2, esz);
+
+        tcg_gen_addi_ptr(t_pn, cpu_env, pred_full_reg_offset(s, pn));
+        tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
+        t_desc = tcg_const_i32(desc);
+
+        gen_helper_sve_cntp(val, t_pn, t_pg, t_desc);
+        tcg_temp_free_ptr(t_pn);
+        tcg_temp_free_ptr(t_pg);
+        tcg_temp_free_i32(t_desc);
+    }
+}
+
+static bool trans_CNTP(DisasContext *s, arg_CNTP *a, uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        do_cntp(s, cpu_reg(s, a->rd), a->esz, a->rn, a->pg);
+    }
+    return true;
+}
+
+static bool trans_INCDECP_r(DisasContext *s, arg_incdec_pred *a,
+                            uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        TCGv_i64 reg = cpu_reg(s, a->rd);
+        TCGv_i64 val = tcg_temp_new_i64();
+
+        do_cntp(s, val, a->esz, a->pg, a->pg);
+        if (a->d) {
+            tcg_gen_sub_i64(reg, reg, val);
+        } else {
+            tcg_gen_add_i64(reg, reg, val);
+        }
+        tcg_temp_free_i64(val);
+    }
+    return true;
+}
+
+static bool trans_INCDECP_z(DisasContext *s, arg_incdec2_pred *a,
+                            uint32_t insn)
+{
+    if (a->esz == 0) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_i64 val = tcg_temp_new_i64();
+        GVecGen2sFn *gvec_fn = a->d ? tcg_gen_gvec_subs : tcg_gen_gvec_adds;
+
+        do_cntp(s, val, a->esz, a->pg, a->pg);
+        gvec_fn(a->esz, vec_full_reg_offset(s, a->rd),
+                vec_full_reg_offset(s, a->rn), val, vsz, vsz);
+    }
+    return true;
+}
+
+static bool trans_SINCDECP_r_32(DisasContext *s, arg_incdec_pred *a,
+                                uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        TCGv_i64 reg = cpu_reg(s, a->rd);
+        TCGv_i64 val = tcg_temp_new_i64();
+
+        do_cntp(s, val, a->esz, a->pg, a->pg);
+        do_sat_addsub_32(reg, val, a->u, a->d);
+    }
+    return true;
+}
+
+static bool trans_SINCDECP_r_64(DisasContext *s, arg_incdec_pred *a,
+                                uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        TCGv_i64 reg = cpu_reg(s, a->rd);
+        TCGv_i64 val = tcg_temp_new_i64();
+
+        do_cntp(s, val, a->esz, a->pg, a->pg);
+        do_sat_addsub_64(reg, val, a->u, a->d);
+    }
+    return true;
+}
+
+static bool trans_SINCDECP_z(DisasContext *s, arg_incdec2_pred *a,
+                             uint32_t insn)
+{
+    if (a->esz == 0) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        TCGv_i64 val = tcg_temp_new_i64();
+        do_cntp(s, val, a->esz, a->pg, a->pg);
+        do_sat_addsub_vec(s, a->esz, a->rd, a->rn, val, a->u, a->d);
+    }
+    return true;
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 66e1ee6b5c..62d51c252b 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -67,6 +67,8 @@
 &ptrue          rd esz pat s
 &incdec_cnt     rd pat esz imm d u
 &incdec2_cnt    rd rn pat esz imm d u
+&incdec_pred    rd pg esz d u
+&incdec2_pred   rd rn pg esz d u
 
 ###########################################################################
 # Named instruction formats.  These are generally used to
@@ -113,6 +115,7 @@
 
 # One register operand, with governing predicate, vector element size
 @rd_pg_rn       ........ esz:2 ... ... ... pg:3 rn:5 rd:5       &rpr_esz
+@rd_pg4_pn      ........ esz:2 ... ... .. pg:4 . rn:4 rd:5      &rpr_esz
 
 # Two register operands with a 6-bit signed immediate.
 @rd_rn_i6       ........ ... rn:5 ..... imm:s6 rd:5             &rri
@@ -153,6 +156,12 @@
 @incdec2_cnt    ........ esz:2 .. .... ...... pat:5 rd:5 \
                 &incdec2_cnt imm=%imm4_16_p1 rn=%reg_movprfx
 
+# One register, predicate.
+# User must fill in U and D.
+@incdec_pred    ........ esz:2 .... .. ..... .. pg:4 rd:5       &incdec_pred
+@incdec2_pred   ........ esz:2 .... .. ..... .. pg:4 rd:5 \
+                &incdec2_pred rn=%reg_movprfx
+
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
 
@@ -579,6 +588,24 @@ BRKB_m          00100101 1. 01000001 .... 0 .... 1 ....         @pd_pg_pn_s
 # SVE propagate break to next partition
 BRKN            00100101 0. 01100001 .... 0 .... 0 ....         @pd_pg_pn_s
 
+### SVE Predicate Count Group
+
+# SVE predicate count
+CNTP            00100101 .. 100 000 10 .... 0 .... .....        @rd_pg4_pn
+
+# SVE inc/dec register by predicate count
+INCDECP_r       00100101 .. 10110 d:1 10001 00 .... .....     @incdec_pred u=1
+
+# SVE inc/dec vector by predicate count
+INCDECP_z       00100101 .. 10110 d:1 10000 00 .... .....    @incdec2_pred u=1
+
+# SVE saturating inc/dec register by predicate count
+SINCDECP_r_32   00100101 .. 1010 d:1 u:1 10001 00 .... .....    @incdec_pred
+SINCDECP_r_64   00100101 .. 1010 d:1 u:1 10001 10 .... .....    @incdec_pred
+
+# SVE saturating inc/dec vector by predicate count
+SINCDECP_z      00100101 .. 1010 d:1 u:1 10000 00 .... .....    @incdec2_pred
+
 ### SVE Memory - 32-bit Gather and Unsized Contiguous Group
 
 # SVE load predicate register
-- 
2.17.1
