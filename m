Received: from eggs.gnu.org ([2001:4830:134:3::10]:54452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3V-0003Sv-C5
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3T-0006v2-VJ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:17 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejq3T-0006tZ-K1
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:15 -0500
Received: by mail-wm0-x242.google.com with SMTP id j21so408025wmh.1
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:32:15 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Feb 2018 17:31:38 +0000
Message-Id: <20180208173157.24705-14-alex.bennee@linaro.org>
In-Reply-To: <20180208173157.24705-1-alex.bennee@linaro.org>
References: <20180208173157.24705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 13/32] arm/translate-a64: add FP16
 FR[ECP/SQRT]S to simd_three_reg_same_fp16
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
 target/arm/helper-a64.c    | 34 ++++++++++++++++++++++++++++++++++
 target/arm/helper-a64.h    |  2 ++
 target/arm/translate-a64.c |  6 ++++++
 3 files changed, 42 insertions(+)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index bdfcac111f..6358b42472 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -192,6 +192,10 @@ uint64_t HELPER(neon_cgt_f64)(float64 a, float64 b, void *fpstp)
  * versions, these do a fully fused multiply-add or
  * multiply-add-and-halve.
  */
+#define float16_two make_float16(0x4000)
+#define float16_three make_float16(0x4200)
+#define float16_one_point_five make_float16(0x3e00)
+
 #define float32_two make_float32(0x40000000)
 #define float32_three make_float32(0x40400000)
 #define float32_one_point_five make_float32(0x3fc00000)
@@ -200,6 +204,21 @@ uint64_t HELPER(neon_cgt_f64)(float64 a, float64 b, void *fpstp)
 #define float64_three make_float64(0x4008000000000000ULL)
 #define float64_one_point_five make_float64(0x3FF8000000000000ULL)
 
+float16 HELPER(recpsf_f16)(float16 a, float16 b, void *fpstp)
+{
+    float_status *fpst = fpstp;
+
+    a = float16_squash_input_denormal(a, fpst);
+    b = float16_squash_input_denormal(b, fpst);
+
+    a = float16_chs(a);
+    if ((float16_is_infinity(a) && float16_is_zero(b)) ||
+        (float16_is_infinity(b) && float16_is_zero(a))) {
+        return float16_two;
+    }
+    return float16_muladd(a, b, float16_two, 0, fpst);
+}
+
 float32 HELPER(recpsf_f32)(float32 a, float32 b, void *fpstp)
 {
     float_status *fpst = fpstp;
@@ -230,6 +249,21 @@ float64 HELPER(recpsf_f64)(float64 a, float64 b, void *fpstp)
     return float64_muladd(a, b, float64_two, 0, fpst);
 }
 
+float16 HELPER(rsqrtsf_f16)(float16 a, float16 b, void *fpstp)
+{
+    float_status *fpst = fpstp;
+
+    a = float16_squash_input_denormal(a, fpst);
+    b = float16_squash_input_denormal(b, fpst);
+
+    a = float16_chs(a);
+    if ((float16_is_infinity(a) && float16_is_zero(b)) ||
+        (float16_is_infinity(b) && float16_is_zero(a))) {
+        return float16_one_point_five;
+    }
+    return float16_muladd(a, b, float16_three, float_muladd_halve_result, fpst);
+}
+
 float32 HELPER(rsqrtsf_f32)(float32 a, float32 b, void *fpstp)
 {
     float_status *fpst = fpstp;
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 7900299efd..d347f473d4 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -29,8 +29,10 @@ DEF_HELPER_FLAGS_3(vfp_mulxd, TCG_CALL_NO_RWG, f64, f64, f64, ptr)
 DEF_HELPER_FLAGS_3(neon_ceq_f64, TCG_CALL_NO_RWG, i64, i64, i64, ptr)
 DEF_HELPER_FLAGS_3(neon_cge_f64, TCG_CALL_NO_RWG, i64, i64, i64, ptr)
 DEF_HELPER_FLAGS_3(neon_cgt_f64, TCG_CALL_NO_RWG, i64, i64, i64, ptr)
+DEF_HELPER_FLAGS_3(recpsf_f16, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
 DEF_HELPER_FLAGS_3(recpsf_f32, TCG_CALL_NO_RWG, f32, f32, f32, ptr)
 DEF_HELPER_FLAGS_3(recpsf_f64, TCG_CALL_NO_RWG, f64, f64, f64, ptr)
+DEF_HELPER_FLAGS_3(rsqrtsf_f16, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
 DEF_HELPER_FLAGS_3(rsqrtsf_f32, TCG_CALL_NO_RWG, f32, f32, f32, ptr)
 DEF_HELPER_FLAGS_3(rsqrtsf_f64, TCG_CALL_NO_RWG, f64, f64, f64, ptr)
 DEF_HELPER_FLAGS_1(neon_addlp_s8, TCG_CALL_NO_RWG_SE, i64, i64)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 3eec52eb34..06fbf9df24 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9869,6 +9869,9 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         case 0x6: /* FMAX */
             gen_helper_advsimd_maxh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
+        case 0x7: /* FRECPS */
+            gen_helper_recpsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
         case 0x8: /* FMINNM */
             gen_helper_advsimd_minnumh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
@@ -9885,6 +9888,9 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         case 0xe: /* FMIN */
             gen_helper_advsimd_minh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
+        case 0xf: /* FRSQRTS */
+            gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
         case 0x13: /* FMUL */
             gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
-- 
2.15.1
