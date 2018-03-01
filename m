Received: from eggs.gnu.org ([2001:4830:134:3::10]:33874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJy-0003mO-9B
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJw-00089Q-TX
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:22 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJw-000887-JV
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:20 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJv-0000cd-CB
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:19 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:42 +0000
Message-Id: <20180301112403.12487-22-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/42] arm/translate-a64: add FP16 pairwise ops
 simd_three_reg_same_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

This includes FMAXNMP, FADDP, FMAXP, FMINNMP, FMINP.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180227143852.11175-14-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 208 +++++++++++++++++++++++++++++----------------
 1 file changed, 133 insertions(+), 75 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 217e73ef58..e96e6cdd15 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10247,6 +10247,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     int datasize, elements;
     int pass;
     TCGv_ptr fpst;
+    bool pairwise = false;
 
     if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
         unallocated_encoding(s);
@@ -10272,91 +10273,148 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     datasize = is_q ? 128 : 64;
     elements = datasize / 16;
 
+    switch (fpopcode) {
+    case 0x10: /* FMAXNMP */
+    case 0x12: /* FADDP */
+    case 0x16: /* FMAXP */
+    case 0x18: /* FMINNMP */
+    case 0x1e: /* FMINP */
+        pairwise = true;
+        break;
+    }
+
     fpst = get_fpstatus_ptr(true);
 
-    for (pass = 0; pass < elements; pass++) {
+    if (pairwise) {
+        int maxpass = is_q ? 8 : 4;
         TCGv_i32 tcg_op1 = tcg_temp_new_i32();
         TCGv_i32 tcg_op2 = tcg_temp_new_i32();
-        TCGv_i32 tcg_res = tcg_temp_new_i32();
+        TCGv_i32 tcg_res[8];
 
-        read_vec_element_i32(s, tcg_op1, rn, pass, MO_16);
-        read_vec_element_i32(s, tcg_op2, rm, pass, MO_16);
+        for (pass = 0; pass < maxpass; pass++) {
+            int passreg = pass < (maxpass / 2) ? rn : rm;
+            int passelt = (pass << 1) & (maxpass - 1);
 
-        switch (fpopcode) {
-        case 0x0: /* FMAXNM */
-            gen_helper_advsimd_maxnumh(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0x1: /* FMLA */
-            read_vec_element_i32(s, tcg_res, rd, pass, MO_16);
-            gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_res,
-                                       fpst);
-            break;
-        case 0x2: /* FADD */
-            gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0x3: /* FMULX */
-            gen_helper_advsimd_mulxh(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0x4: /* FCMEQ */
-            gen_helper_advsimd_ceq_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0x6: /* FMAX */
-            gen_helper_advsimd_maxh(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0x7: /* FRECPS */
-            gen_helper_recpsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0x8: /* FMINNM */
-            gen_helper_advsimd_minnumh(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0x9: /* FMLS */
-             /* As usual for ARM, separate negation for fused multiply-add */
-            tcg_gen_xori_i32(tcg_op1, tcg_op1, 0x8000);
-            read_vec_element_i32(s, tcg_res, rd, pass, MO_16);
-            gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_res,
-                                       fpst);
-            break;
-        case 0xa: /* FSUB */
-            gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0xe: /* FMIN */
-            gen_helper_advsimd_minh(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0xf: /* FRSQRTS */
-            gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0x13: /* FMUL */
-            gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0x14: /* FCMGE */
-            gen_helper_advsimd_cge_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0x15: /* FACGE */
-            gen_helper_advsimd_acge_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0x17: /* FDIV */
-            gen_helper_advsimd_divh(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0x1a: /* FABD */
-            gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
-            tcg_gen_andi_i32(tcg_res, tcg_res, 0x7fff);
-            break;
-        case 0x1c: /* FCMGT */
-            gen_helper_advsimd_cgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0x1d: /* FACGT */
-            gen_helper_advsimd_acgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        default:
-            fprintf(stderr, "%s: insn %#04x, fpop %#2x @ %#" PRIx64 "\n",
-                    __func__, insn, fpopcode, s->pc);
-            g_assert_not_reached();
+            read_vec_element_i32(s, tcg_op1, passreg, passelt, MO_16);
+            read_vec_element_i32(s, tcg_op2, passreg, passelt + 1, MO_16);
+            tcg_res[pass] = tcg_temp_new_i32();
+
+            switch (fpopcode) {
+            case 0x10: /* FMAXNMP */
+                gen_helper_advsimd_maxnumh(tcg_res[pass], tcg_op1, tcg_op2,
+                                           fpst);
+                break;
+            case 0x12: /* FADDP */
+                gen_helper_advsimd_addh(tcg_res[pass], tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x16: /* FMAXP */
+                gen_helper_advsimd_maxh(tcg_res[pass], tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x18: /* FMINNMP */
+                gen_helper_advsimd_minnumh(tcg_res[pass], tcg_op1, tcg_op2,
+                                           fpst);
+                break;
+            case 0x1e: /* FMINP */
+                gen_helper_advsimd_minh(tcg_res[pass], tcg_op1, tcg_op2, fpst);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        }
+
+        for (pass = 0; pass < maxpass; pass++) {
+            write_vec_element_i32(s, tcg_res[pass], rd, pass, MO_16);
+            tcg_temp_free_i32(tcg_res[pass]);
         }
 
-        write_vec_element_i32(s, tcg_res, rd, pass, MO_16);
-        tcg_temp_free_i32(tcg_res);
         tcg_temp_free_i32(tcg_op1);
         tcg_temp_free_i32(tcg_op2);
+
+    } else {
+        for (pass = 0; pass < elements; pass++) {
+            TCGv_i32 tcg_op1 = tcg_temp_new_i32();
+            TCGv_i32 tcg_op2 = tcg_temp_new_i32();
+            TCGv_i32 tcg_res = tcg_temp_new_i32();
+
+            read_vec_element_i32(s, tcg_op1, rn, pass, MO_16);
+            read_vec_element_i32(s, tcg_op2, rm, pass, MO_16);
+
+            switch (fpopcode) {
+            case 0x0: /* FMAXNM */
+                gen_helper_advsimd_maxnumh(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x1: /* FMLA */
+                read_vec_element_i32(s, tcg_res, rd, pass, MO_16);
+                gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_res,
+                                           fpst);
+                break;
+            case 0x2: /* FADD */
+                gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x3: /* FMULX */
+                gen_helper_advsimd_mulxh(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x4: /* FCMEQ */
+                gen_helper_advsimd_ceq_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x6: /* FMAX */
+                gen_helper_advsimd_maxh(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x7: /* FRECPS */
+                gen_helper_recpsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x8: /* FMINNM */
+                gen_helper_advsimd_minnumh(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x9: /* FMLS */
+                /* As usual for ARM, separate negation for fused multiply-add */
+                tcg_gen_xori_i32(tcg_op1, tcg_op1, 0x8000);
+                read_vec_element_i32(s, tcg_res, rd, pass, MO_16);
+                gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_res,
+                                           fpst);
+                break;
+            case 0xa: /* FSUB */
+                gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0xe: /* FMIN */
+                gen_helper_advsimd_minh(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0xf: /* FRSQRTS */
+                gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x13: /* FMUL */
+                gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x14: /* FCMGE */
+                gen_helper_advsimd_cge_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x15: /* FACGE */
+                gen_helper_advsimd_acge_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x17: /* FDIV */
+                gen_helper_advsimd_divh(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x1a: /* FABD */
+                gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
+                tcg_gen_andi_i32(tcg_res, tcg_res, 0x7fff);
+                break;
+            case 0x1c: /* FCMGT */
+                gen_helper_advsimd_cgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x1d: /* FACGT */
+                gen_helper_advsimd_acgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            default:
+                fprintf(stderr, "%s: insn %#04x, fpop %#2x @ %#" PRIx64 "\n",
+                        __func__, insn, fpopcode, s->pc);
+                g_assert_not_reached();
+            }
+
+            write_vec_element_i32(s, tcg_res, rd, pass, MO_16);
+            tcg_temp_free_i32(tcg_res);
+            tcg_temp_free_i32(tcg_op1);
+            tcg_temp_free_i32(tcg_op2);
+        }
     }
 
     tcg_temp_free_ptr(fpst);
-- 
2.16.2
