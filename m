Received: from eggs.gnu.org ([209.51.188.92]:33374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1guj4v-0005Qv-WC
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1guj4u-0003R3-7t
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:23:17 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1guj4t-0003MS-VO
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:23:16 -0500
Received: by mail-pf1-x441.google.com with SMTP id u6so5266991pfh.11
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 11:23:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Feb 2019 11:23:01 -0800
Message-Id: <20190215192302.27855-8-richard.henderson@linaro.org>
In-Reply-To: <20190215192302.27855-1-richard.henderson@linaro.org>
References: <20190215192302.27855-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 7/8] target/arm: Implement VFMAL and VFMSL
 for aarch32
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
 target/arm/cpu.h       |   5 ++
 target/arm/translate.c | 103 +++++++++++++++++++++++++++++------------
 2 files changed, 79 insertions(+), 29 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 69589573e4..9cf439fb8d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3283,6 +3283,11 @@ static inline bool isar_feature_aa32_dp(const ARMISARegisters *id)
     return FIELD_EX32(id->id_isar6, ID_ISAR6, DP) != 0;
 }
 
+static inline bool isar_feature_aa32_fhm(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar6, ID_ISAR6, FHM) != 0;
+}
+
 static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
 {
     /*
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c1175798ac..c319ba9aae 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8372,15 +8372,8 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
     gen_helper_gvec_3_ptr *fn_gvec_ptr = NULL;
     int rd, rn, rm, opr_sz;
     int data = 0;
-    bool q;
-
-    q = extract32(insn, 6, 1);
-    VFP_DREG_D(rd, insn);
-    VFP_DREG_N(rn, insn);
-    VFP_DREG_M(rm, insn);
-    if ((rd | rn | rm) & q) {
-        return 1;
-    }
+    int off_rn, off_rm;
+    bool is_long = false, q = extract32(insn, 6, 1);
 
     if ((insn & 0xfe200f10) == 0xfc200800) {
         /* VCMLA -- 1111 110R R.1S .... .... 1000 ...0 .... */
@@ -8407,10 +8400,38 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
             return 1;
         }
         fn_gvec = u ? gen_helper_gvec_udot_b : gen_helper_gvec_sdot_b;
+    } else if ((insn & 0xff300f10) == 0xfc200810) {
+        /* VFM[AS]L -- 1111 1100 S.10 .... .... 1000 .Q.1 .... */
+        int is_s = extract32(insn, 23, 1);
+        if (!dc_isar_feature(aa32_fhm, s)) {
+            return 1;
+        }
+        is_long = true;
+        fn_gvec_ptr = gen_helper_gvec_fmlal_h;
+        data = is_s; /* is_2 == 0 */
     } else {
         return 1;
     }
 
+    VFP_DREG_D(rd, insn);
+    if (rd & q) {
+        return 1;
+    }
+    if (q || !is_long) {
+        VFP_DREG_N(rn, insn);
+        VFP_DREG_M(rm, insn);
+        if ((rn | rm) & q & !is_long) {
+            return 1;
+        }
+        off_rn = vfp_reg_offset(1, rn);
+        off_rm = vfp_reg_offset(1, rm);
+    } else {
+        rn = VFP_SREG_N(insn);
+        rm = VFP_SREG_M(insn);
+        off_rn = vfp_reg_offset(0, rn);
+        off_rm = vfp_reg_offset(0, rm);
+    }
+
     if (s->fp_excp_el) {
         gen_exception_insn(s, 4, EXCP_UDEF,
                            syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
@@ -8423,15 +8444,11 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
     opr_sz = (1 + q) * 8;
     if (fn_gvec_ptr) {
         TCGv_ptr fpst = get_fpstatus_ptr(1);
-        tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
-                           vfp_reg_offset(1, rn),
-                           vfp_reg_offset(1, rm), fpst,
+        tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd), off_rn, off_rm, fpst,
                            opr_sz, opr_sz, data, fn_gvec_ptr);
         tcg_temp_free_ptr(fpst);
     } else {
-        tcg_gen_gvec_3_ool(vfp_reg_offset(1, rd),
-                           vfp_reg_offset(1, rn),
-                           vfp_reg_offset(1, rm),
+        tcg_gen_gvec_3_ool(vfp_reg_offset(1, rd), off_rn, off_rm,
                            opr_sz, opr_sz, data, fn_gvec);
     }
     return 0;
@@ -8450,14 +8467,8 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
     gen_helper_gvec_3 *fn_gvec = NULL;
     gen_helper_gvec_3_ptr *fn_gvec_ptr = NULL;
     int rd, rn, rm, opr_sz, data;
-    bool q;
-
-    q = extract32(insn, 6, 1);
-    VFP_DREG_D(rd, insn);
-    VFP_DREG_N(rn, insn);
-    if ((rd | rn) & q) {
-        return 1;
-    }
+    int off_rn, off_rm;
+    bool is_long = false, q = extract32(insn, 6, 1);
 
     if ((insn & 0xff000f10) == 0xfe000800) {
         /* VCMLA (indexed) -- 1111 1110 S.RR .... .... 1000 ...0 .... */
@@ -8486,6 +8497,7 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
     } else if ((insn & 0xffb00f00) == 0xfe200d00) {
         /* V[US]DOT -- 1111 1110 0.10 .... .... 1101 .Q.U .... */
         int u = extract32(insn, 4, 1);
+
         if (!dc_isar_feature(aa32_dp, s)) {
             return 1;
         }
@@ -8493,10 +8505,47 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
         /* rm is just Vm, and index is M.  */
         data = extract32(insn, 5, 1); /* index */
         rm = extract32(insn, 0, 4);
+    } else if ((insn & 0xffa00f10) == 0xfe000810) {
+        /* VFM[AS]L -- 1111 1110 0.0S .... .... 1000 .Q.1 .... */
+        int is_s = extract32(insn, 20, 1);
+        int vm20 = extract32(insn, 0, 3);
+        int vm3 = extract32(insn, 3, 1);
+        int m = extract32(insn, 5, 1);
+        int index;
+
+        if (!dc_isar_feature(aa32_fhm, s)) {
+            return 1;
+        }
+        if (q) {
+            rm = vm20;
+            index = m * 2 + vm3;
+        } else {
+            rm = vm20 * 2 + m;
+            index = vm3;
+        }
+        is_long = true;
+        data = (index << 2) | is_s; /* is_2 == 0 */
+        fn_gvec_ptr = gen_helper_gvec_fmlal_idx_h;
     } else {
         return 1;
     }
 
+    VFP_DREG_D(rd, insn);
+    if (rd & q) {
+        return 1;
+    }
+    if (q || !is_long) {
+        VFP_DREG_N(rn, insn);
+        if (rn & q & !is_long) {
+            return 1;
+        }
+        off_rn = vfp_reg_offset(1, rn);
+        off_rm = vfp_reg_offset(1, rm);
+    } else {
+        rn = VFP_SREG_N(insn);
+        off_rn = vfp_reg_offset(0, rn);
+        off_rm = vfp_reg_offset(0, rm);
+    }
     if (s->fp_excp_el) {
         gen_exception_insn(s, 4, EXCP_UDEF,
                            syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
@@ -8509,15 +8558,11 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
     opr_sz = (1 + q) * 8;
     if (fn_gvec_ptr) {
         TCGv_ptr fpst = get_fpstatus_ptr(1);
-        tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
-                           vfp_reg_offset(1, rn),
-                           vfp_reg_offset(1, rm), fpst,
+        tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd), off_rn, off_rm, fpst,
                            opr_sz, opr_sz, data, fn_gvec_ptr);
         tcg_temp_free_ptr(fpst);
     } else {
-        tcg_gen_gvec_3_ool(vfp_reg_offset(1, rd),
-                           vfp_reg_offset(1, rn),
-                           vfp_reg_offset(1, rm),
+        tcg_gen_gvec_3_ool(vfp_reg_offset(1, rd), off_rn, off_rm,
                            opr_sz, opr_sz, data, fn_gvec);
     }
     return 0;
-- 
2.17.2
