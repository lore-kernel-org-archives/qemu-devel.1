Received: from eggs.gnu.org ([2001:4830:134:3::10]:33859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJx-0003lg-E4
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJv-00088l-Uy
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:21 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJv-000887-Kt
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:19 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJu-0000cP-MX
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:18 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:41 +0000
Message-Id: <20180301112403.12487-21-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/42] arm/translate-a64: add FP16 FR[ECP/SQRT]S
 to simd_three_reg_same_fp16
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

As some of the constants here will also be needed
elsewhere (specifically for the upcoming SVE support) we move them out
to softfloat.h.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180227143852.11175-13-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/fpu/softfloat.h    | 18 +++++++++++++-----
 target/arm/helper-a64.h    |  2 ++
 target/arm/helper-a64.c    | 34 ++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c |  6 ++++++
 4 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 9b7b5e34e2..27876e711c 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -306,8 +306,11 @@ static inline float16 float16_set_sign(float16 a, int sign)
 }
 
 #define float16_zero make_float16(0)
-#define float16_one make_float16(0x3c00)
 #define float16_half make_float16(0x3800)
+#define float16_one make_float16(0x3c00)
+#define float16_one_point_five make_float16(0x3e00)
+#define float16_two make_float16(0x4000)
+#define float16_three make_float16(0x4200)
 #define float16_infinity make_float16(0x7c00)
 
 /*----------------------------------------------------------------------------
@@ -415,11 +418,13 @@ static inline float32 float32_set_sign(float32 a, int sign)
 }
 
 #define float32_zero make_float32(0)
-#define float32_one make_float32(0x3f800000)
 #define float32_half make_float32(0x3f000000)
+#define float32_one make_float32(0x3f800000)
+#define float32_one_point_five make_float32(0x3fc00000)
+#define float32_two make_float32(0x40000000)
+#define float32_three make_float32(0x40400000)
 #define float32_infinity make_float32(0x7f800000)
 
-
 /*----------------------------------------------------------------------------
 | The pattern for a default generated single-precision NaN.
 *----------------------------------------------------------------------------*/
@@ -526,9 +531,12 @@ static inline float64 float64_set_sign(float64 a, int sign)
 }
 
 #define float64_zero make_float64(0)
-#define float64_one make_float64(0x3ff0000000000000LL)
-#define float64_ln2 make_float64(0x3fe62e42fefa39efLL)
 #define float64_half make_float64(0x3fe0000000000000LL)
+#define float64_one make_float64(0x3ff0000000000000LL)
+#define float64_one_point_five make_float64(0x3FF8000000000000ULL)
+#define float64_two make_float64(0x4000000000000000ULL)
+#define float64_three make_float64(0x4008000000000000ULL)
+#define float64_ln2 make_float64(0x3fe62e42fefa39efLL)
 #define float64_infinity make_float64(0x7ff0000000000000LL)
 
 /*----------------------------------------------------------------------------
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 9c1a95594c..79012eee9d 100644
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
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 1ef13abd76..8fdbe034f3 100644
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
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 0e2d298687..217e73ef58 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10303,6 +10303,9 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         case 0x6: /* FMAX */
             gen_helper_advsimd_maxh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
+        case 0x7: /* FRECPS */
+            gen_helper_recpsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
         case 0x8: /* FMINNM */
             gen_helper_advsimd_minnumh(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
@@ -10319,6 +10322,9 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
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
2.16.2
