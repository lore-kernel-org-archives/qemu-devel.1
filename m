Received: from eggs.gnu.org ([2001:4830:134:3::10]:46078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFUm-00006G-Ef
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFUk-0005rF-LH
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:42:48 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFUk-0005ph-Ce
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:42:46 -0500
Received: by mail-wm0-x244.google.com with SMTP id h21so5445296wmd.1
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:42:46 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:36:31 +0000
Message-Id: <20180223153636.29809-27-alex.bennee@linaro.org>
In-Reply-To: <20180223153636.29809-1-alex.bennee@linaro.org>
References: <20180223153636.29809-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 26/31] arm/helper.c: re-factor rsqrte and
 add rsqrte_f16
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

Much like recpe the ARM ARM has simplified the pseudo code for the
calculation which is done on a fixed point 9 bit integer maths. So
while adding f16 we can also clean this up to be a little less heavy
on the floating point and just return the fractional part and leave
the calle's to do the final packing of the result.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2
  - checkpatch fixes
---
 target/arm/helper.c | 221 ++++++++++++++++++++++++----------------------------
 target/arm/helper.h |   1 +
 2 files changed, 104 insertions(+), 118 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e2d0ff0b4c..c82f63d440 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11756,56 +11756,97 @@ float64 HELPER(recpe_f64)(float64 input, void *fpstp)
 /* The algorithm that must be used to calculate the estimate
  * is specified by the ARM ARM.
  */
-static float64 recip_sqrt_estimate(float64 a, float_status *real_fp_status)
-{
-    /* These calculations mustn't set any fp exception flags,
-     * so we use a local copy of the fp_status.
-     */
-    float_status dummy_status = *real_fp_status;
-    float_status *s = &dummy_status;
-    float64 q;
-    int64_t q_int;
-
-    if (float64_lt(a, float64_half, s)) {
-        /* range 0.25 <= a < 0.5 */
-
-        /* a in units of 1/512 rounded down */
-        /* q0 = (int)(a * 512.0);  */
-        q = float64_mul(float64_512, a, s);
-        q_int = float64_to_int64_round_to_zero(q, s);
-
-        /* reciprocal root r */
-        /* r = 1.0 / sqrt(((double)q0 + 0.5) / 512.0);  */
-        q = int64_to_float64(q_int, s);
-        q = float64_add(q, float64_half, s);
-        q = float64_div(q, float64_512, s);
-        q = float64_sqrt(q, s);
-        q = float64_div(float64_one, q, s);
+
+static int do_recip_sqrt_estimate(int a)
+{
+    int b, estimate;
+
+    assert(128 <= a && a < 512);
+    if (a < 256) {
+        a = a * 2 + 1;
     } else {
-        /* range 0.5 <= a < 1.0 */
+        a = (a >> 1) << 1;
+        a = (a + 1) * 2;
+    }
+    b = 512;
+    while (a * (b + 1) * (b + 1) < (1 << 28)) {
+        b += 1;
+    }
+    estimate = (b + 1) / 2;
+    assert(256 <= estimate && estimate < 512);
+
+    return estimate;
+}
+
 
-        /* a in units of 1/256 rounded down */
-        /* q1 = (int)(a * 256.0); */
-        q = float64_mul(float64_256, a, s);
-        int64_t q_int = float64_to_int64_round_to_zero(q, s);
+static uint64_t recip_sqrt_estimate(int *exp , int exp_off, uint64_t frac)
+{
+    int estimate;
+    uint32_t scaled;
 
-        /* reciprocal root r */
-        /* r = 1.0 /sqrt(((double)q1 + 0.5) / 256); */
-        q = int64_to_float64(q_int, s);
-        q = float64_add(q, float64_half, s);
-        q = float64_div(q, float64_256, s);
-        q = float64_sqrt(q, s);
-        q = float64_div(float64_one, q, s);
+    if (*exp == 0) {
+        while (extract64(frac, 51, 1) == 0) {
+            frac = frac << 1;
+            *exp -= 1;
+        }
+        frac = extract64(frac, 0, 51) << 1;
     }
-    /* r in units of 1/256 rounded to nearest */
-    /* s = (int)(256.0 * r + 0.5); */
 
-    q = float64_mul(q, float64_256,s );
-    q = float64_add(q, float64_half, s);
-    q_int = float64_to_int64_round_to_zero(q, s);
+    if (*exp & 1) {
+        /* scaled = UInt('01':fraction<51:45>) */
+        scaled = deposit32(1 << 7, 0, 7, extract64(frac, 45, 7));
+    } else {
+        /* scaled = UInt('1':fraction<51:44>) */
+        scaled = deposit32(1 << 8, 0, 8, extract64(frac, 44, 8));
+    }
+    estimate = do_recip_sqrt_estimate(scaled);
 
-    /* return (double)s / 256.0;*/
-    return float64_div(int64_to_float64(q_int, s), float64_256, s);
+    *exp = (exp_off - *exp) / 2;
+    return extract64(estimate, 0, 8) << 44;
+}
+
+float16 HELPER(rsqrte_f16)(float16 input, void *fpstp)
+{
+    float_status *s = fpstp;
+    float16 f16 = float16_squash_input_denormal(input, s);
+    uint16_t val = float16_val(f16);
+    bool f16_sign = float16_is_neg(f16);
+    int f16_exp = extract32(val, 10, 5);
+    uint16_t f16_frac = extract32(val, 0, 10);
+    uint64_t f64_frac;
+
+    if (float16_is_any_nan(f16)) {
+        float16 nan = f16;
+        if (float16_is_signaling_nan(f16, s)) {
+            float_raise(float_flag_invalid, s);
+            nan = float16_maybe_silence_nan(f16, s);
+        }
+        if (s->default_nan_mode) {
+            nan =  float16_default_nan(s);
+        }
+        return nan;
+    } else if (float16_is_zero(f16)) {
+        float_raise(float_flag_divbyzero, s);
+        return float16_set_sign(float16_infinity, f16_sign);
+    } else if (f16_sign) {
+        float_raise(float_flag_invalid, s);
+        return float16_default_nan(s);
+    } else if (float16_is_infinity(f16)) {
+        return float16_zero;
+    }
+
+    /* Scale and normalize to a double-precision value between 0.25 and 1.0,
+     * preserving the parity of the exponent.  */
+
+    f64_frac = ((uint64_t) f16_frac) << (52 - 10);
+
+    f64_frac = recip_sqrt_estimate(&f16_exp, 44, f64_frac);
+
+    /* result = sign : result_exp<4:0> : estimate<7:0> : Zeros(2) */
+    val = deposit32(0, 15, 1, f16_sign);
+    val = deposit32(val, 10, 5, f16_exp);
+    val = deposit32(val, 2, 8, extract64(f64_frac, 52 - 8, 8));
+    return make_float16(val);
 }
 
 float32 HELPER(rsqrte_f32)(float32 input, void *fpstp)
@@ -11813,13 +11854,10 @@ float32 HELPER(rsqrte_f32)(float32 input, void *fpstp)
     float_status *s = fpstp;
     float32 f32 = float32_squash_input_denormal(input, s);
     uint32_t val = float32_val(f32);
-    uint32_t f32_sbit = 0x80000000 & val;
-    int32_t f32_exp = extract32(val, 23, 8);
+    uint32_t f32_sign = float32_is_neg(f32);
+    int f32_exp = extract32(val, 23, 8);
     uint32_t f32_frac = extract32(val, 0, 23);
     uint64_t f64_frac;
-    uint64_t val64;
-    int result_exp;
-    float64 f64;
 
     if (float32_is_any_nan(f32)) {
         float32 nan = f32;
@@ -11845,32 +11883,13 @@ float32 HELPER(rsqrte_f32)(float32 input, void *fpstp)
      * preserving the parity of the exponent.  */
 
     f64_frac = ((uint64_t) f32_frac) << 29;
-    if (f32_exp == 0) {
-        while (extract64(f64_frac, 51, 1) == 0) {
-            f64_frac = f64_frac << 1;
-            f32_exp = f32_exp-1;
-        }
-        f64_frac = extract64(f64_frac, 0, 51) << 1;
-    }
-
-    if (extract64(f32_exp, 0, 1) == 0) {
-        f64 = make_float64(((uint64_t) f32_sbit) << 32
-                           | (0x3feULL << 52)
-                           | f64_frac);
-    } else {
-        f64 = make_float64(((uint64_t) f32_sbit) << 32
-                           | (0x3fdULL << 52)
-                           | f64_frac);
-    }
 
-    result_exp = (380 - f32_exp) / 2;
+    f64_frac = recip_sqrt_estimate(&f32_exp, 380, f64_frac);
 
-    f64 = recip_sqrt_estimate(f64, s);
-
-    val64 = float64_val(f64);
-
-    val = ((result_exp & 0xff) << 23)
-        | ((val64 >> 29)  & 0x7fffff);
+    /* result = sign : result_exp<4:0> : estimate<7:0> : Zeros(15) */
+    val = deposit32(0, 31, 1, f32_sign);
+    val = deposit32(val, 23, 8, f32_exp);
+    val = deposit32(val, 15, 8, extract64(f64_frac, 52 - 8, 8));
     return make_float32(val);
 }
 
@@ -11879,11 +11898,9 @@ float64 HELPER(rsqrte_f64)(float64 input, void *fpstp)
     float_status *s = fpstp;
     float64 f64 = float64_squash_input_denormal(input, s);
     uint64_t val = float64_val(f64);
-    uint64_t f64_sbit = 0x8000000000000000ULL & val;
-    int64_t f64_exp = extract64(val, 52, 11);
+    bool f64_sign = float64_is_neg(f64);
+    int f64_exp = extract64(val, 52, 11);
     uint64_t f64_frac = extract64(val, 0, 52);
-    int64_t result_exp;
-    uint64_t result_frac;
 
     if (float64_is_any_nan(f64)) {
         float64 nan = f64;
@@ -11905,36 +11922,13 @@ float64 HELPER(rsqrte_f64)(float64 input, void *fpstp)
         return float64_zero;
     }
 
-    /* Scale and normalize to a double-precision value between 0.25 and 1.0,
-     * preserving the parity of the exponent.  */
-
-    if (f64_exp == 0) {
-        while (extract64(f64_frac, 51, 1) == 0) {
-            f64_frac = f64_frac << 1;
-            f64_exp = f64_exp - 1;
-        }
-        f64_frac = extract64(f64_frac, 0, 51) << 1;
-    }
+    f64_frac = recip_sqrt_estimate(&f64_exp, 3068, f64_frac);
 
-    if (extract64(f64_exp, 0, 1) == 0) {
-        f64 = make_float64(f64_sbit
-                           | (0x3feULL << 52)
-                           | f64_frac);
-    } else {
-        f64 = make_float64(f64_sbit
-                           | (0x3fdULL << 52)
-                           | f64_frac);
-    }
-
-    result_exp = (3068 - f64_exp) / 2;
-
-    f64 = recip_sqrt_estimate(f64, s);
-
-    result_frac = extract64(float64_val(f64), 0, 52);
-
-    return make_float64(f64_sbit |
-                        ((result_exp & 0x7ff) << 52) |
-                        result_frac);
+    /* result = sign : result_exp<4:0> : estimate<7:0> : Zeros(44) */
+    val = deposit64(0, 61, 1, f64_sign);
+    val = deposit64(val, 52, 11, f64_exp);
+    val = deposit64(val, 44, 8, extract64(f64_frac, 52 - 8, 8));
+    return make_float64(val);
 }
 
 uint32_t HELPER(recpe_u32)(uint32_t a, void *fpstp)
@@ -11954,24 +11948,15 @@ uint32_t HELPER(recpe_u32)(uint32_t a, void *fpstp)
 
 uint32_t HELPER(rsqrte_u32)(uint32_t a, void *fpstp)
 {
-    float_status *fpst = fpstp;
-    float64 f64;
+    int estimate;
 
     if ((a & 0xc0000000) == 0) {
         return 0xffffffff;
     }
 
-    if (a & 0x80000000) {
-        f64 = make_float64((0x3feULL << 52)
-                           | ((uint64_t)(a & 0x7fffffff) << 21));
-    } else { /* bits 31-30 == '01' */
-        f64 = make_float64((0x3fdULL << 52)
-                           | ((uint64_t)(a & 0x3fffffff) << 22));
-    }
-
-    f64 = recip_sqrt_estimate(f64, fpst);
+    estimate = do_recip_sqrt_estimate(extract32(a, 23, 9));
 
-    return 0x80000000 | ((float64_val(f64) >> 21) & 0x7fffffff);
+    return deposit32(0, 23, 9, estimate);
 }
 
 /* VFPv4 fused multiply-accumulate */
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 81d7baed6d..6dd8504ec3 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -195,6 +195,7 @@ DEF_HELPER_3(rsqrts_f32, f32, f32, f32, env)
 DEF_HELPER_FLAGS_2(recpe_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
 DEF_HELPER_FLAGS_2(recpe_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(recpe_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
+DEF_HELPER_FLAGS_2(rsqrte_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
 DEF_HELPER_FLAGS_2(rsqrte_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(rsqrte_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_2(recpe_u32, i32, i32, ptr)
-- 
2.15.1
