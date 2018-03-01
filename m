Received: from eggs.gnu.org ([2001:4830:134:3::10]:33830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJw-0003kG-5r
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJv-00088H-4P
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:20 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJu-00082m-Rc
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:19 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJt-0000c8-Uh
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:17 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:40 +0000
Message-Id: <20180301112403.12487-20-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/42] arm/translate-a64: add FP16 FMULA/X/S to
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180227143852.11175-12-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.h    |  2 ++
 target/arm/helper-a64.c    | 24 ++++++++++++++++++++++++
 target/arm/translate-a64.c | 15 +++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 1cf40bda5e..9c1a95594c 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -61,3 +61,5 @@ DEF_HELPER_3(advsimd_cge_f16, i32, f16, f16, ptr)
 DEF_HELPER_3(advsimd_cgt_f16, i32, f16, f16, ptr)
 DEF_HELPER_3(advsimd_acge_f16, i32, f16, f16, ptr)
 DEF_HELPER_3(advsimd_acgt_f16, i32, f16, f16, ptr)
+DEF_HELPER_3(advsimd_mulxh, f16, f16, f16, ptr)
+DEF_HELPER_4(advsimd_muladdh, f16, f16, f16, f16, ptr)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index d0b284fec4..1ef13abd76 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -595,6 +595,30 @@ ADVSIMD_HALFOP(max)
 ADVSIMD_HALFOP(minnum)
 ADVSIMD_HALFOP(maxnum)
 
+/* Data processing - scalar floating-point and advanced SIMD */
+float16 HELPER(advsimd_mulxh)(float16 a, float16 b, void *fpstp)
+{
+    float_status *fpst = fpstp;
+
+    a = float16_squash_input_denormal(a, fpst);
+    b = float16_squash_input_denormal(b, fpst);
+
+    if ((float16_is_zero(a) && float16_is_infinity(b)) ||
+        (float16_is_infinity(a) && float16_is_zero(b))) {
+        /* 2.0 with the sign bit set to sign(A) XOR sign(B) */
+        return make_float16((1U << 14) |
+                            ((float16_val(a) ^ float16_val(b)) & (1U << 15)));
+    }
+    return float16_mul(a, b, fpst);
+}
+
+/* fused multiply-accumulate */
+float16 HELPER(advsimd_muladdh)(float16 a, float16 b, float16 c, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    return float16_muladd(a, b, c, 0, fpst);
+}
+
 /*
  * Floating point comparisons produce an integer result. Softfloat
  * routines return float_relation types which we convert to the 0/-1
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fb74dc1c45..0e2d298687 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10286,9 +10286,17 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         case 0x0: /* FMAXNM */
             gen_helper_advsimd_maxnumh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
+        case 0x1: /* FMLA */
+            read_vec_element_i32(s, tcg_res, rd, pass, MO_16);
+            gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_res,
+                                       fpst);
+            break;
         case 0x2: /* FADD */
             gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
+        case 0x3: /* FMULX */
+            gen_helper_advsimd_mulxh(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
         case 0x4: /* FCMEQ */
             gen_helper_advsimd_ceq_f16(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
@@ -10298,6 +10306,13 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         case 0x8: /* FMINNM */
             gen_helper_advsimd_minnumh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
+        case 0x9: /* FMLS */
+             /* As usual for ARM, separate negation for fused multiply-add */
+            tcg_gen_xori_i32(tcg_op1, tcg_op1, 0x8000);
+            read_vec_element_i32(s, tcg_res, rd, pass, MO_16);
+            gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_res,
+                                       fpst);
+            break;
         case 0xa: /* FSUB */
             gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
-- 
2.16.2
