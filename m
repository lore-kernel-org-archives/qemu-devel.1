Received: from eggs.gnu.org ([2001:4830:134:3::10]:54195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3M-0003JV-NW
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3L-0006Yc-47
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:08 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejq3K-0006Wq-Ql
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:07 -0500
Received: by mail-wr0-x241.google.com with SMTP id w50so5572950wrc.2
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:32:06 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Feb 2018 17:31:36 +0000
Message-Id: <20180208173157.24705-12-alex.bennee@linaro.org>
In-Reply-To: <20180208173157.24705-1-alex.bennee@linaro.org>
References: <20180208173157.24705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 11/32] arm/translate-a64: add FP16
 F[A]C[EQ/GE/GT] to simd_three_reg_same_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper-a64.c    | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/helper-a64.h    |  5 +++++
 target/arm/translate-a64.c | 15 ++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 25e45121af..78eeda31d1 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -599,3 +599,52 @@ ADVSIMD_HALFOP(min)
 ADVSIMD_HALFOP(max)
 ADVSIMD_HALFOP(minnum)
 ADVSIMD_HALFOP(maxnum)
+
+/*
+ * Floating point comparisons produce an integer result. Softfloat
+ * routines return float_relation types which we convert to the 0/-1
+ * Neon requires.
+ */
+
+#define ADVSIMD_CMPRES(test) (test) ? 0xffff : 0
+
+uint32_t HELPER(advsimd_ceq_f16)(float16 a, float16 b, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    int compare = float16_compare_quiet(a, b, fpst);
+    return ADVSIMD_CMPRES(compare == float_relation_equal);
+}
+
+uint32_t HELPER(advsimd_cge_f16)(float16 a, float16 b, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    int compare = float16_compare(a, b, fpst);
+    return ADVSIMD_CMPRES(compare == float_relation_greater ||
+                          compare == float_relation_equal);
+}
+
+uint32_t HELPER(advsimd_cgt_f16)(float16 a, float16 b, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    int compare = float16_compare(a, b, fpst);
+    return ADVSIMD_CMPRES(compare == float_relation_greater);
+}
+
+uint32_t HELPER(advsimd_acge_f16)(float16 a, float16 b, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    float16 f0 = float16_abs(a);
+    float16 f1 = float16_abs(b);
+    int compare = float16_compare(f0, f1, fpst);
+    return ADVSIMD_CMPRES(compare == float_relation_greater ||
+                          compare == float_relation_equal);
+}
+
+uint32_t HELPER(advsimd_acgt_f16)(float16 a, float16 b, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    float16 f0 = float16_abs(a);
+    float16 f1 = float16_abs(b);
+    int compare = float16_compare(f0, f1, fpst);
+    return ADVSIMD_CMPRES(compare == float_relation_greater);
+}
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 5cbabcc27a..e701644ae7 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -57,3 +57,8 @@ DEF_HELPER_3(advsimd_maxh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_minh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_maxnumh, f16, f16, f16, ptr)
 DEF_HELPER_3(advsimd_minnumh, f16, f16, f16, ptr)
+DEF_HELPER_3(advsimd_ceq_f16, i32, f16, f16, ptr)
+DEF_HELPER_3(advsimd_cge_f16, i32, f16, f16, ptr)
+DEF_HELPER_3(advsimd_cgt_f16, i32, f16, f16, ptr)
+DEF_HELPER_3(advsimd_acge_f16, i32, f16, f16, ptr)
+DEF_HELPER_3(advsimd_acgt_f16, i32, f16, f16, ptr)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 93d71d8b2c..14572f26e1 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9855,6 +9855,9 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         case 0x2: /* FADD */
             gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
+        case 0x4: /* FCMEQ */
+            gen_helper_advsimd_ceq_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
         case 0x6: /* FMAX */
             gen_helper_advsimd_maxh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
@@ -9870,6 +9873,12 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         case 0x13: /* FMUL */
             gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
+        case 0x14: /* FCMGE */
+            gen_helper_advsimd_cge_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
+        case 0x15: /* FACGE */
+            gen_helper_advsimd_acge_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
         case 0x17: /* FDIV */
             gen_helper_advsimd_divh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
@@ -9877,6 +9886,12 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
             gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
             gen_helper_advsimd_absh(tcg_res, tcg_res);
             break;
+        case 0x1c: /* FCMGT */
+            gen_helper_advsimd_cgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
+        case 0x1d: /* FACGT */
+            gen_helper_advsimd_acgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
         default:
             fprintf(stderr, "%s: insn %#04x, fpop %#2x @ %#" PRIx64 "\n",
                     __func__, insn, fpopcode, s->pc);
-- 
2.15.1
