Received: from eggs.gnu.org ([2001:4830:134:3::10]:44507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFP3-0002u9-U5
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFP2-0007Me-DD
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:53 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFP2-0007K5-2r
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:52 -0500
Received: by mail-wm0-x243.google.com with SMTP id z9so5312295wmb.3
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:36:51 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:36:18 +0000
Message-Id: <20180223153636.29809-14-alex.bennee@linaro.org>
In-Reply-To: <20180223153636.29809-1-alex.bennee@linaro.org>
References: <20180223153636.29809-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 13/31] arm/translate-a64: add FP16 pairwise
 ops simd_three_reg_same_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

This includes FMAXNMP, FADDP, FMAXP, FMINNMP, FMINP.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - checkpatch fixes
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
2.15.1
