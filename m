Received: from eggs.gnu.org ([2001:4830:134:3::10]:46833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDtv5-0004Mz-Aw
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDtv2-0008MN-Ee
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:43:51 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:44201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fDtv2-0008Lq-2p
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:43:48 -0400
Received: by mail-wr0-x242.google.com with SMTP id y15-v6so2808085wrg.11
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 08:43:47 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  2 May 2018 16:43:42 +0100
Message-Id: <20180502154344.10585-2-alex.bennee@linaro.org>
In-Reply-To: <20180502154344.10585-1-alex.bennee@linaro.org>
References: <20180502154344.10585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/3] fpu/softfloat: re-factor float to float
 conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

This allows us to delete a lot of additional boilerplate code which is
no longer needed. Currently the ieee flag is ignored (everything is
assumed to be ieee). Handling for ARM AHP will be in the next patch.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - pass FloatFmt to float_to_float instead of sizes
  - split AHP handling to another patch
  - use rth's suggested re-packing (+ setting .exp)
---
 fpu/softfloat-specialize.h |  40 ----
 fpu/softfloat.c            | 443 +++++++------------------------------
 include/fpu/softfloat.h    |   8 +-
 3 files changed, 88 insertions(+), 403 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 27834af0de..a20b440159 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -293,46 +293,6 @@ float16 float16_maybe_silence_nan(float16 a_, float_status *status)
     return a_;
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of converting the half-precision floating-point NaN
-| `a' to the canonical NaN format.  If `a' is a signaling NaN, the invalid
-| exception is raised.
-*----------------------------------------------------------------------------*/
-
-static commonNaNT float16ToCommonNaN(float16 a, float_status *status)
-{
-    commonNaNT z;
-
-    if (float16_is_signaling_nan(a, status)) {
-        float_raise(float_flag_invalid, status);
-    }
-    z.sign = float16_val(a) >> 15;
-    z.low = 0;
-    z.high = ((uint64_t) float16_val(a)) << 54;
-    return z;
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the canonical NaN `a' to the half-
-| precision floating-point format.
-*----------------------------------------------------------------------------*/
-
-static float16 commonNaNToFloat16(commonNaNT a, float_status *status)
-{
-    uint16_t mantissa = a.high >> 54;
-
-    if (status->default_nan_mode) {
-        return float16_default_nan(status);
-    }
-
-    if (mantissa) {
-        return make_float16(((((uint16_t) a.sign) << 15)
-                             | (0x1F << 10) | mantissa));
-    } else {
-        return float16_default_nan(status);
-    }
-}
-
 #ifdef NO_SIGNALING_NANS
 int float32_is_quiet_nan(float32 a_, float_status *status)
 {
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 70e0c40a1c..28b9f4f79b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1194,6 +1194,90 @@ float64 float64_div(float64 a, float64 b, float_status *status)
     return float64_round_pack_canonical(pr, status);
 }
 
+/*
+ * Float to Float conversions
+ *
+ * Returns the result of converting one float format to another. The
+ * conversion is performed according to the IEC/IEEE Standard for
+ * Binary Floating-Point Arithmetic.
+ *
+ * The float_to_float helper only needs to take care of raising
+ * invalid exceptions and handling the conversion on NaNs.
+ */
+
+static FloatParts float_to_float(FloatParts a,
+                                 const FloatFmt *srcf, const FloatFmt *dstf,
+                                 float_status *s)
+{
+    if (is_nan(a.cls)) {
+
+        if (is_snan(a.cls)) {
+            s->float_exception_flags |= float_flag_invalid;
+        }
+
+        if (s->default_nan_mode) {
+            a.cls = float_class_dnan;
+            return a;
+        }
+
+        /*
+         * Our only option now is to "re-pack" the NaN. As the
+         * canonilization process doesn't mess with fraction bits for
+         * NaNs we do it all here. We also reset a.exp to the
+         * destination format exp_max as the maybe_silence_nan code
+         * assumes it is correct (which is would be for non-conversions).
+         */
+        a.frac = a.frac << (64 - srcf->frac_size) >> (64 - dstf->frac_size);
+        a.exp = dstf->exp_max;
+        a.cls = float_class_msnan;
+    }
+
+    return a;
+}
+
+float32 float16_to_float32(float16 a, bool ieee, float_status *s)
+{
+    FloatParts p = float16_unpack_canonical(a, s);
+    FloatParts pr = float_to_float(p, &float16_params, &float32_params, s);
+    return float32_round_pack_canonical(pr, s);
+}
+
+float64 float16_to_float64(float16 a, bool ieee, float_status *s)
+{
+    FloatParts p = float16_unpack_canonical(a, s);
+    FloatParts pr = float_to_float(p, &float16_params, &float64_params, s);
+    return float64_round_pack_canonical(pr, s);
+}
+
+float16 float32_to_float16(float32 a, bool ieee, float_status *s)
+{
+    FloatParts p = float32_unpack_canonical(a, s);
+    FloatParts pr = float_to_float(p, &float32_params, &float16_params, s);
+    return float16_round_pack_canonical(pr, s);
+}
+
+float64 float32_to_float64(float32 a, float_status *s)
+{
+    FloatParts p = float32_unpack_canonical(a, s);
+    FloatParts pr = float_to_float(p, &float32_params, &float64_params, s);
+    return float64_round_pack_canonical(pr, s);
+}
+
+float16 float64_to_float16(float64 a, bool ieee, float_status *s)
+{
+    FloatParts p = float64_unpack_canonical(a, s);
+    FloatParts pr = float_to_float(p, &float64_params, &float16_params, s);
+    return float16_round_pack_canonical(pr, s);
+}
+
+float32 float64_to_float32(float64 a, float_status *s)
+{
+    FloatParts p = float64_unpack_canonical(a, s);
+    FloatParts pr = float_to_float(p, &float64_params, &float32_params, s);
+    return float32_round_pack_canonical(pr, s);
+}
+
+
 /*
  * Rounds the floating-point value `a' to an integer, and returns the
  * result as a floating-point value. The operation is performed
@@ -3142,41 +3226,6 @@ float128 uint64_to_float128(uint64_t a, float_status *status)
     return normalizeRoundAndPackFloat128(0, 0x406E, a, 0, status);
 }
 
-
-
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the single-precision floating-point value
-| `a' to the double-precision floating-point format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float64 float32_to_float64(float32 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    uint32_t aSig;
-    a = float32_squash_input_denormal(a, status);
-
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    aSign = extractFloat32Sign( a );
-    if ( aExp == 0xFF ) {
-        if (aSig) {
-            return commonNaNToFloat64(float32ToCommonNaN(a, status), status);
-        }
-        return packFloat64( aSign, 0x7FF, 0 );
-    }
-    if ( aExp == 0 ) {
-        if ( aSig == 0 ) return packFloat64( aSign, 0, 0 );
-        normalizeFloat32Subnormal( aSig, &aExp, &aSig );
-        --aExp;
-    }
-    return packFloat64( aSign, aExp + 0x380, ( (uint64_t) aSig )<<29 );
-
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the single-precision floating-point value
 | `a' to the extended double-precision floating-point format.  The conversion
@@ -3695,173 +3744,6 @@ int float32_unordered_quiet(float32 a, float32 b, float_status *status)
     return 0;
 }
 
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the double-precision floating-point value
-| `a' to the single-precision floating-point format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float32 float64_to_float32(float64 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    uint64_t aSig;
-    uint32_t zSig;
-    a = float64_squash_input_denormal(a, status);
-
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    aSign = extractFloat64Sign( a );
-    if ( aExp == 0x7FF ) {
-        if (aSig) {
-            return commonNaNToFloat32(float64ToCommonNaN(a, status), status);
-        }
-        return packFloat32( aSign, 0xFF, 0 );
-    }
-    shift64RightJamming( aSig, 22, &aSig );
-    zSig = aSig;
-    if ( aExp || zSig ) {
-        zSig |= 0x40000000;
-        aExp -= 0x381;
-    }
-    return roundAndPackFloat32(aSign, aExp, zSig, status);
-
-}
-
-
-/*----------------------------------------------------------------------------
-| Packs the sign `zSign', exponent `zExp', and significand `zSig' into a
-| half-precision floating-point value, returning the result.  After being
-| shifted into the proper positions, the three fields are simply added
-| together to form the result.  This means that any integer portion of `zSig'
-| will be added into the exponent.  Since a properly normalized significand
-| will have an integer portion equal to 1, the `zExp' input should be 1 less
-| than the desired result exponent whenever `zSig' is a complete, normalized
-| significand.
-*----------------------------------------------------------------------------*/
-static float16 packFloat16(flag zSign, int zExp, uint16_t zSig)
-{
-    return make_float16(
-        (((uint32_t)zSign) << 15) + (((uint32_t)zExp) << 10) + zSig);
-}
-
-/*----------------------------------------------------------------------------
-| Takes an abstract floating-point value having sign `zSign', exponent `zExp',
-| and significand `zSig', and returns the proper half-precision floating-
-| point value corresponding to the abstract input.  Ordinarily, the abstract
-| value is simply rounded and packed into the half-precision format, with
-| the inexact exception raised if the abstract input cannot be represented
-| exactly.  However, if the abstract value is too large, the overflow and
-| inexact exceptions are raised and an infinity or maximal finite value is
-| returned.  If the abstract value is too small, the input value is rounded to
-| a subnormal number, and the underflow and inexact exceptions are raised if
-| the abstract input cannot be represented exactly as a subnormal half-
-| precision floating-point number.
-| The `ieee' flag indicates whether to use IEEE standard half precision, or
-| ARM-style "alternative representation", which omits the NaN and Inf
-| encodings in order to raise the maximum representable exponent by one.
-|     The input significand `zSig' has its binary point between bits 22
-| and 23, which is 13 bits to the left of the usual location.  This shifted
-| significand must be normalized or smaller.  If `zSig' is not normalized,
-| `zExp' must be 0; in that case, the result returned is a subnormal number,
-| and it must not require rounding.  In the usual case that `zSig' is
-| normalized, `zExp' must be 1 less than the ``true'' floating-point exponent.
-| Note the slightly odd position of the binary point in zSig compared with the
-| other roundAndPackFloat functions. This should probably be fixed if we
-| need to implement more float16 routines than just conversion.
-| The handling of underflow and overflow follows the IEC/IEEE Standard for
-| Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-static float16 roundAndPackFloat16(flag zSign, int zExp,
-                                   uint32_t zSig, flag ieee,
-                                   float_status *status)
-{
-    int maxexp = ieee ? 29 : 30;
-    uint32_t mask;
-    uint32_t increment;
-    bool rounding_bumps_exp;
-    bool is_tiny = false;
-
-    /* Calculate the mask of bits of the mantissa which are not
-     * representable in half-precision and will be lost.
-     */
-    if (zExp < 1) {
-        /* Will be denormal in halfprec */
-        mask = 0x00ffffff;
-        if (zExp >= -11) {
-            mask >>= 11 + zExp;
-        }
-    } else {
-        /* Normal number in halfprec */
-        mask = 0x00001fff;
-    }
-
-    switch (status->float_rounding_mode) {
-    case float_round_nearest_even:
-        increment = (mask + 1) >> 1;
-        if ((zSig & mask) == increment) {
-            increment = zSig & (increment << 1);
-        }
-        break;
-    case float_round_ties_away:
-        increment = (mask + 1) >> 1;
-        break;
-    case float_round_up:
-        increment = zSign ? 0 : mask;
-        break;
-    case float_round_down:
-        increment = zSign ? mask : 0;
-        break;
-    default: /* round_to_zero */
-        increment = 0;
-        break;
-    }
-
-    rounding_bumps_exp = (zSig + increment >= 0x01000000);
-
-    if (zExp > maxexp || (zExp == maxexp && rounding_bumps_exp)) {
-        if (ieee) {
-            float_raise(float_flag_overflow | float_flag_inexact, status);
-            return packFloat16(zSign, 0x1f, 0);
-        } else {
-            float_raise(float_flag_invalid, status);
-            return packFloat16(zSign, 0x1f, 0x3ff);
-        }
-    }
-
-    if (zExp < 0) {
-        /* Note that flush-to-zero does not affect half-precision results */
-        is_tiny =
-            (status->float_detect_tininess == float_tininess_before_rounding)
-            || (zExp < -1)
-            || (!rounding_bumps_exp);
-    }
-    if (zSig & mask) {
-        float_raise(float_flag_inexact, status);
-        if (is_tiny) {
-            float_raise(float_flag_underflow, status);
-        }
-    }
-
-    zSig += increment;
-    if (rounding_bumps_exp) {
-        zSig >>= 1;
-        zExp++;
-    }
-
-    if (zExp < -10) {
-        return packFloat16(zSign, 0, 0);
-    }
-    if (zExp < 0) {
-        zSig >>= -zExp;
-        zExp = 0;
-    }
-    return packFloat16(zSign, zExp, zSig >> 13);
-}
-
 /*----------------------------------------------------------------------------
 | If `a' is denormal and we are in flush-to-zero mode then set the
 | input-denormal exception and return zero. Otherwise just return the value.
@@ -3877,163 +3759,6 @@ float16 float16_squash_input_denormal(float16 a, float_status *status)
     return a;
 }
 
-static void normalizeFloat16Subnormal(uint32_t aSig, int *zExpPtr,
-                                      uint32_t *zSigPtr)
-{
-    int8_t shiftCount = countLeadingZeros32(aSig) - 21;
-    *zSigPtr = aSig << shiftCount;
-    *zExpPtr = 1 - shiftCount;
-}
-
-/* Half precision floats come in two formats: standard IEEE and "ARM" format.
-   The latter gains extra exponent range by omitting the NaN/Inf encodings.  */
-
-float32 float16_to_float32(float16 a, flag ieee, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    uint32_t aSig;
-
-    aSign = extractFloat16Sign(a);
-    aExp = extractFloat16Exp(a);
-    aSig = extractFloat16Frac(a);
-
-    if (aExp == 0x1f && ieee) {
-        if (aSig) {
-            return commonNaNToFloat32(float16ToCommonNaN(a, status), status);
-        }
-        return packFloat32(aSign, 0xff, 0);
-    }
-    if (aExp == 0) {
-        if (aSig == 0) {
-            return packFloat32(aSign, 0, 0);
-        }
-
-        normalizeFloat16Subnormal(aSig, &aExp, &aSig);
-        aExp--;
-    }
-    return packFloat32( aSign, aExp + 0x70, aSig << 13);
-}
-
-float16 float32_to_float16(float32 a, flag ieee, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    uint32_t aSig;
-
-    a = float32_squash_input_denormal(a, status);
-
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    aSign = extractFloat32Sign( a );
-    if ( aExp == 0xFF ) {
-        if (aSig) {
-            /* Input is a NaN */
-            if (!ieee) {
-                float_raise(float_flag_invalid, status);
-                return packFloat16(aSign, 0, 0);
-            }
-            return commonNaNToFloat16(
-                float32ToCommonNaN(a, status), status);
-        }
-        /* Infinity */
-        if (!ieee) {
-            float_raise(float_flag_invalid, status);
-            return packFloat16(aSign, 0x1f, 0x3ff);
-        }
-        return packFloat16(aSign, 0x1f, 0);
-    }
-    if (aExp == 0 && aSig == 0) {
-        return packFloat16(aSign, 0, 0);
-    }
-    /* Decimal point between bits 22 and 23. Note that we add the 1 bit
-     * even if the input is denormal; however this is harmless because
-     * the largest possible single-precision denormal is still smaller
-     * than the smallest representable half-precision denormal, and so we
-     * will end up ignoring aSig and returning via the "always return zero"
-     * codepath.
-     */
-    aSig |= 0x00800000;
-    aExp -= 0x71;
-
-    return roundAndPackFloat16(aSign, aExp, aSig, ieee, status);
-}
-
-float64 float16_to_float64(float16 a, flag ieee, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    uint32_t aSig;
-
-    aSign = extractFloat16Sign(a);
-    aExp = extractFloat16Exp(a);
-    aSig = extractFloat16Frac(a);
-
-    if (aExp == 0x1f && ieee) {
-        if (aSig) {
-            return commonNaNToFloat64(
-                float16ToCommonNaN(a, status), status);
-        }
-        return packFloat64(aSign, 0x7ff, 0);
-    }
-    if (aExp == 0) {
-        if (aSig == 0) {
-            return packFloat64(aSign, 0, 0);
-        }
-
-        normalizeFloat16Subnormal(aSig, &aExp, &aSig);
-        aExp--;
-    }
-    return packFloat64(aSign, aExp + 0x3f0, ((uint64_t)aSig) << 42);
-}
-
-float16 float64_to_float16(float64 a, flag ieee, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    uint64_t aSig;
-    uint32_t zSig;
-
-    a = float64_squash_input_denormal(a, status);
-
-    aSig = extractFloat64Frac(a);
-    aExp = extractFloat64Exp(a);
-    aSign = extractFloat64Sign(a);
-    if (aExp == 0x7FF) {
-        if (aSig) {
-            /* Input is a NaN */
-            if (!ieee) {
-                float_raise(float_flag_invalid, status);
-                return packFloat16(aSign, 0, 0);
-            }
-            return commonNaNToFloat16(
-                float64ToCommonNaN(a, status), status);
-        }
-        /* Infinity */
-        if (!ieee) {
-            float_raise(float_flag_invalid, status);
-            return packFloat16(aSign, 0x1f, 0x3ff);
-        }
-        return packFloat16(aSign, 0x1f, 0);
-    }
-    shift64RightJamming(aSig, 29, &aSig);
-    zSig = aSig;
-    if (aExp == 0 && zSig == 0) {
-        return packFloat16(aSign, 0, 0);
-    }
-    /* Decimal point between bits 22 and 23. Note that we add the 1 bit
-     * even if the input is denormal; however this is harmless because
-     * the largest possible single-precision denormal is still smaller
-     * than the smallest representable half-precision denormal, and so we
-     * will end up ignoring aSig and returning via the "always return zero"
-     * codepath.
-     */
-    zSig |= 0x00800000;
-    aExp -= 0x3F1;
-
-    return roundAndPackFloat16(aSign, aExp, zSig, ieee, status);
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the double-precision floating-point value
 | `a' to the extended double-precision floating-point format.  The conversion
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 36626a501b..01ef1c6b81 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -211,10 +211,10 @@ float128 uint64_to_float128(uint64_t, float_status *status);
 /*----------------------------------------------------------------------------
 | Software half-precision conversion routines.
 *----------------------------------------------------------------------------*/
-float16 float32_to_float16(float32, flag, float_status *status);
-float32 float16_to_float32(float16, flag, float_status *status);
-float16 float64_to_float16(float64 a, flag ieee, float_status *status);
-float64 float16_to_float64(float16 a, flag ieee, float_status *status);
+float16 float32_to_float16(float32, bool ieee, float_status *status);
+float32 float16_to_float32(float16, bool ieee, float_status *status);
+float16 float64_to_float16(float64 a, bool ieee, float_status *status);
+float64 float16_to_float64(float16 a, bool ieee, float_status *status);
 int16_t float16_to_int16(float16, float_status *status);
 uint16_t float16_to_uint16(float16 a, float_status *status);
 int16_t float16_to_int16_round_to_zero(float16, float_status *status);
-- 
2.17.0
