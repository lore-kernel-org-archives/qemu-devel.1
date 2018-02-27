Received: from eggs.gnu.org ([2001:4830:134:3::10]:58669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgYM-0003rH-UT
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgYE-000282-Ml
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:26 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:44621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eqgYE-00023m-5M
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:18 -0500
Received: by mail-wr0-x242.google.com with SMTP id v65so25110877wrc.11
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:48:18 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 27 Feb 2018 14:38:43 +0000
Message-Id: <20180227143852.11175-23-alex.bennee@linaro.org>
In-Reply-To: <20180227143852.11175-1-alex.bennee@linaro.org>
References: <20180227143852.11175-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 22/31] arm/helper.c: re-factor recpe and add
 recepe_f16
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

It looks like the ARM ARM has simplified the pseudo code for the
calculation which is done on a fixed point 9 bit integer maths. So
while adding f16 we can also clean this up to be a little less heavy
on the floating point and just return the fractional part and leave
the calle's to do the final packing of the result.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v3
  - fix comment 2.0^-16
  - f16_exp >= 29 (biased)
  - remove confusing comment about fpst
---
 target/arm/helper.c | 224 +++++++++++++++++++++++++++++-----------------------
 target/arm/helper.h |   1 +
 2 files changed, 128 insertions(+), 97 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6e3dadb754..e2d0ff0b4c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11523,80 +11523,75 @@ float32 HELPER(rsqrts_f32)(float32 a, float32 b, CPUARMState *env)
  * int->float conversions at run-time.  */
 #define float64_256 make_float64(0x4070000000000000LL)
 #define float64_512 make_float64(0x4080000000000000LL)
+#define float16_maxnorm make_float16(0x7bff)
 #define float32_maxnorm make_float32(0x7f7fffff)
 #define float64_maxnorm make_float64(0x7fefffffffffffffLL)
 
 /* Reciprocal functions
  *
  * The algorithm that must be used to calculate the estimate
- * is specified by the ARM ARM, see FPRecipEstimate()
+ * is specified by the ARM ARM, see FPRecipEstimate()/RecipEstimate
  */
 
-static float64 recip_estimate(float64 a, float_status *real_fp_status)
-{
-    /* These calculations mustn't set any fp exception flags,
-     * so we use a local copy of the fp_status.
-     */
-    float_status dummy_status = *real_fp_status;
-    float_status *s = &dummy_status;
-    /* q = (int)(a * 512.0) */
-    float64 q = float64_mul(float64_512, a, s);
-    int64_t q_int = float64_to_int64_round_to_zero(q, s);
-
-    /* r = 1.0 / (((double)q + 0.5) / 512.0) */
-    q = int64_to_float64(q_int, s);
-    q = float64_add(q, float64_half, s);
-    q = float64_div(q, float64_512, s);
-    q = float64_div(float64_one, q, s);
-
-    /* s = (int)(256.0 * r + 0.5) */
-    q = float64_mul(q, float64_256, s);
-    q = float64_add(q, float64_half, s);
-    q_int = float64_to_int64_round_to_zero(q, s);
+/* See RecipEstimate()
+ *
+ * input is a 9 bit fixed point number
+ * input range 256 .. 511 for a number from 0.5 <= x < 1.0.
+ * result range 256 .. 511 for a number from 1.0 to 511/256.
+ */
 
-    /* return (double)s / 256.0 */
-    return float64_div(int64_to_float64(q_int, s), float64_256, s);
+static int recip_estimate(int input)
+{
+    int a, b, r;
+    assert(256 <= input && input < 512);
+    a = (input * 2) + 1;
+    b = (1 << 19) / a;
+    r = (b + 1) >> 1;
+    assert(256 <= r && r < 512);
+    return r;
 }
 
-/* Common wrapper to call recip_estimate */
-static float64 call_recip_estimate(float64 num, int off, float_status *fpst)
+/*
+ * Common wrapper to call recip_estimate
+ *
+ * The parameters are exponent and 64 bit fraction (without implicit
+ * bit) where the binary point is nominally at bit 52. Returns a
+ * float64 which can then be rounded to the appropriate size by the
+ * callee.
+ */
+
+static uint64_t call_recip_estimate(int *exp, int exp_off, uint64_t frac)
 {
-    uint64_t val64 = float64_val(num);
-    uint64_t frac = extract64(val64, 0, 52);
-    int64_t exp = extract64(val64, 52, 11);
-    uint64_t sbit;
-    float64 scaled, estimate;
+    uint32_t scaled, estimate;
+    uint64_t result_frac;
+    int result_exp;
 
-    /* Generate the scaled number for the estimate function */
-    if (exp == 0) {
+    /* Handle sub-normals */
+    if (*exp == 0) {
         if (extract64(frac, 51, 1) == 0) {
-            exp = -1;
-            frac = extract64(frac, 0, 50) << 2;
+            *exp = -1;
+            frac <<= 2;
         } else {
-            frac = extract64(frac, 0, 51) << 1;
+            frac <<= 1;
         }
     }
 
-    /* scaled = '0' : '01111111110' : fraction<51:44> : Zeros(44); */
-    scaled = make_float64((0x3feULL << 52)
-                          | extract64(frac, 44, 8) << 44);
-
-    estimate = recip_estimate(scaled, fpst);
+    /* scaled = UInt('1':fraction<51:44>) */
+    scaled = deposit32(1 << 8, 0, 8, extract64(frac, 44, 8));
+    estimate = recip_estimate(scaled);
 
-    /* Build new result */
-    val64 = float64_val(estimate);
-    sbit = 0x8000000000000000ULL & val64;
-    exp = off - exp;
-    frac = extract64(val64, 0, 52);
-
-    if (exp == 0) {
-        frac = 1ULL << 51 | extract64(frac, 1, 51);
-    } else if (exp == -1) {
-        frac = 1ULL << 50 | extract64(frac, 2, 50);
-        exp = 0;
+    result_exp = exp_off - *exp;
+    result_frac = deposit64(0, 44, 8, estimate);
+    if (result_exp == 0) {
+        result_frac = deposit64(result_frac >> 1, 51, 1, 1);
+    } else if (result_exp == -1) {
+        result_frac = deposit64(result_frac >> 2, 50, 2, 1);
+        result_exp = 0;
     }
 
-    return make_float64(sbit | (exp << 52) | frac);
+    *exp = result_exp;
+
+    return result_frac;
 }
 
 static bool round_to_inf(float_status *fpst, bool sign_bit)
@@ -11615,18 +11610,63 @@ static bool round_to_inf(float_status *fpst, bool sign_bit)
     g_assert_not_reached();
 }
 
+float16 HELPER(recpe_f16)(float16 input, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    float16 f16 = float16_squash_input_denormal(input, fpst);
+    uint32_t f16_val = float16_val(f16);
+    uint32_t f16_sign = float16_is_neg(f16);
+    int f16_exp = extract32(f16_val, 10, 5);
+    uint32_t f16_frac = extract32(f16_val, 0, 10);
+    uint64_t f64_frac;
+
+    if (float16_is_any_nan(f16)) {
+        float16 nan = f16;
+        if (float16_is_signaling_nan(f16, fpst)) {
+            float_raise(float_flag_invalid, fpst);
+            nan = float16_maybe_silence_nan(f16, fpst);
+        }
+        if (fpst->default_nan_mode) {
+            nan =  float16_default_nan(fpst);
+        }
+        return nan;
+    } else if (float16_is_infinity(f16)) {
+        return float16_set_sign(float16_zero, float16_is_neg(f16));
+    } else if (float16_is_zero(f16)) {
+        float_raise(float_flag_divbyzero, fpst);
+        return float16_set_sign(float16_infinity, float16_is_neg(f16));
+    } else if (float16_abs(f16) < (1 << 8)) {
+        /* Abs(value) < 2.0^-16 */
+        float_raise(float_flag_overflow | float_flag_inexact, fpst);
+        if (round_to_inf(fpst, f16_sign)) {
+            return float16_set_sign(float16_infinity, f16_sign);
+        } else {
+            return float16_set_sign(float16_maxnorm, f16_sign);
+        }
+    } else if (f16_exp >= 29 && fpst->flush_to_zero) {
+        float_raise(float_flag_underflow, fpst);
+        return float16_set_sign(float16_zero, float16_is_neg(f16));
+    }
+
+    f64_frac = call_recip_estimate(&f16_exp, 29,
+                                   ((uint64_t) f16_frac) << (52 - 10));
+
+    /* result = sign : result_exp<4:0> : fraction<51:42> */
+    f16_val = deposit32(0, 15, 1, f16_sign);
+    f16_val = deposit32(f16_val, 10, 5, f16_exp);
+    f16_val = deposit32(f16_val, 0, 10, extract64(f64_frac, 52 - 10, 10));
+    return make_float16(f16_val);
+}
+
 float32 HELPER(recpe_f32)(float32 input, void *fpstp)
 {
     float_status *fpst = fpstp;
     float32 f32 = float32_squash_input_denormal(input, fpst);
     uint32_t f32_val = float32_val(f32);
-    uint32_t f32_sbit = 0x80000000ULL & f32_val;
-    int32_t f32_exp = extract32(f32_val, 23, 8);
+    bool f32_sign = float32_is_neg(f32);
+    int f32_exp = extract32(f32_val, 23, 8);
     uint32_t f32_frac = extract32(f32_val, 0, 23);
-    float64 f64, r64;
-    uint64_t r64_val;
-    int64_t r64_exp;
-    uint64_t r64_frac;
+    uint64_t f64_frac;
 
     if (float32_is_any_nan(f32)) {
         float32 nan = f32;
@@ -11643,30 +11683,27 @@ float32 HELPER(recpe_f32)(float32 input, void *fpstp)
     } else if (float32_is_zero(f32)) {
         float_raise(float_flag_divbyzero, fpst);
         return float32_set_sign(float32_infinity, float32_is_neg(f32));
-    } else if ((f32_val & ~(1ULL << 31)) < (1ULL << 21)) {
+    } else if (float32_abs(f32) < (1ULL << 21)) {
         /* Abs(value) < 2.0^-128 */
         float_raise(float_flag_overflow | float_flag_inexact, fpst);
-        if (round_to_inf(fpst, f32_sbit)) {
-            return float32_set_sign(float32_infinity, float32_is_neg(f32));
+        if (round_to_inf(fpst, f32_sign)) {
+            return float32_set_sign(float32_infinity, f32_sign);
         } else {
-            return float32_set_sign(float32_maxnorm, float32_is_neg(f32));
+            return float32_set_sign(float32_maxnorm, f32_sign);
         }
     } else if (f32_exp >= 253 && fpst->flush_to_zero) {
         float_raise(float_flag_underflow, fpst);
         return float32_set_sign(float32_zero, float32_is_neg(f32));
     }
 
+    f64_frac = call_recip_estimate(&f32_exp, 253,
+                                   ((uint64_t) f32_frac) << (52 - 23));
 
-    f64 = make_float64(((int64_t)(f32_exp) << 52) | (int64_t)(f32_frac) << 29);
-    r64 = call_recip_estimate(f64, 253, fpst);
-    r64_val = float64_val(r64);
-    r64_exp = extract64(r64_val, 52, 11);
-    r64_frac = extract64(r64_val, 0, 52);
-
-    /* result = sign : result_exp<7:0> : fraction<51:29>; */
-    return make_float32(f32_sbit |
-                        (r64_exp & 0xff) << 23 |
-                        extract64(r64_frac, 29, 24));
+    /* result = sign : result_exp<7:0> : fraction<51:29> */
+    f32_val = deposit32(0, 31, 1, f32_sign);
+    f32_val = deposit32(f32_val, 23, 8, f32_exp);
+    f32_val = deposit32(f32_val, 0, 23, extract64(f64_frac, 52 - 23, 23));
+    return make_float32(f32_val);
 }
 
 float64 HELPER(recpe_f64)(float64 input, void *fpstp)
@@ -11674,12 +11711,9 @@ float64 HELPER(recpe_f64)(float64 input, void *fpstp)
     float_status *fpst = fpstp;
     float64 f64 = float64_squash_input_denormal(input, fpst);
     uint64_t f64_val = float64_val(f64);
-    uint64_t f64_sbit = 0x8000000000000000ULL & f64_val;
-    int64_t f64_exp = extract64(f64_val, 52, 11);
-    float64 r64;
-    uint64_t r64_val;
-    int64_t r64_exp;
-    uint64_t r64_frac;
+    bool f64_sign = float64_is_neg(f64);
+    int f64_exp = extract64(f64_val, 52, 11);
+    uint64_t f64_frac = extract64(f64_val, 0, 52);
 
     /* Deal with any special cases */
     if (float64_is_any_nan(f64)) {
@@ -11700,25 +11734,23 @@ float64 HELPER(recpe_f64)(float64 input, void *fpstp)
     } else if ((f64_val & ~(1ULL << 63)) < (1ULL << 50)) {
         /* Abs(value) < 2.0^-1024 */
         float_raise(float_flag_overflow | float_flag_inexact, fpst);
-        if (round_to_inf(fpst, f64_sbit)) {
-            return float64_set_sign(float64_infinity, float64_is_neg(f64));
+        if (round_to_inf(fpst, f64_sign)) {
+            return float64_set_sign(float64_infinity, f64_sign);
         } else {
-            return float64_set_sign(float64_maxnorm, float64_is_neg(f64));
+            return float64_set_sign(float64_maxnorm, f64_sign);
         }
     } else if (f64_exp >= 2045 && fpst->flush_to_zero) {
         float_raise(float_flag_underflow, fpst);
         return float64_set_sign(float64_zero, float64_is_neg(f64));
     }
 
-    r64 = call_recip_estimate(f64, 2045, fpst);
-    r64_val = float64_val(r64);
-    r64_exp = extract64(r64_val, 52, 11);
-    r64_frac = extract64(r64_val, 0, 52);
+    f64_frac = call_recip_estimate(&f64_exp, 2045, f64_frac);
 
-    /* result = sign : result_exp<10:0> : fraction<51:0> */
-    return make_float64(f64_sbit |
-                        ((r64_exp & 0x7ff) << 52) |
-                        r64_frac);
+    /* result = sign : result_exp<10:0> : fraction<51:0>; */
+    f64_val = deposit64(0, 63, 1, f64_sign);
+    f64_val = deposit64(f64_val, 52, 11, f64_exp);
+    f64_val = deposit64(f64_val, 0, 52, f64_frac);
+    return make_float64(f64_val);
 }
 
 /* The algorithm that must be used to calculate the estimate
@@ -11907,19 +11939,17 @@ float64 HELPER(rsqrte_f64)(float64 input, void *fpstp)
 
 uint32_t HELPER(recpe_u32)(uint32_t a, void *fpstp)
 {
-    float_status *s = fpstp;
-    float64 f64;
+    /* float_status *s = fpstp; */
+    int input, estimate;
 
     if ((a & 0x80000000) == 0) {
         return 0xffffffff;
     }
 
-    f64 = make_float64((0x3feULL << 52)
-                       | ((int64_t)(a & 0x7fffffff) << 21));
-
-    f64 = recip_estimate(f64, s);
+    input = extract32(a, 23, 9);
+    estimate = recip_estimate(input);
 
-    return 0x80000000 | ((float64_val(f64) >> 21) & 0x7fffffff);
+    return deposit32(0, (32 - 9), 9, estimate);
 }
 
 uint32_t HELPER(rsqrte_u32)(uint32_t a, void *fpstp)
diff --git a/target/arm/helper.h b/target/arm/helper.h
index c0f35592ff..81d7baed6d 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -192,6 +192,7 @@ DEF_HELPER_4(vfp_muladds, f32, f32, f32, f32, ptr)
 
 DEF_HELPER_3(recps_f32, f32, f32, f32, env)
 DEF_HELPER_3(rsqrts_f32, f32, f32, f32, env)
+DEF_HELPER_FLAGS_2(recpe_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
 DEF_HELPER_FLAGS_2(recpe_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(recpe_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_FLAGS_2(rsqrte_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
-- 
2.15.1
