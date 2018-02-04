Received: from eggs.gnu.org ([2001:4830:134:3::10]:47495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBf6-0004y7-O5
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBf3-00056a-DX
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:16 -0500
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:35608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBf3-00056C-1C
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:13 -0500
Received: by mail-pl0-x22e.google.com with SMTP id j19so9379309pll.2
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:12:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:34 -0800
Message-Id: <20180204041136.17525-23-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 22/24] fpu: Implement float_to_float with
 soft-fp.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org, hsp.cat7@gmail.com

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile.target            |   1 +
 fpu/softfloat-specialize.h |  40 ----
 include/fpu/softfloat.h    |   8 +-
 fpu/floatconv.c            | 154 ++++++++++++++
 fpu/softfloat.c            | 489 ---------------------------------------------
 5 files changed, 159 insertions(+), 533 deletions(-)
 create mode 100644 fpu/floatconv.c

diff --git a/Makefile.target b/Makefile.target
index b904085f77..94efb66775 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -102,6 +102,7 @@ obj-y += fpu/float16.o
 obj-y += fpu/float32.o
 obj-y += fpu/float64.o
 obj-y += fpu/float128.o
+obj-y += fpu/floatconv.o
 obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 4be0fb21ba..ffc0264018 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -278,46 +278,6 @@ float16 float16_maybe_silence_nan(float16 a_, float_status *status)
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
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index b97022be1d..53468eec1b 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -237,10 +237,10 @@ uint64_t float16_to_uint64(float16, float_status *status);
 uint64_t float16_to_uint64_round_to_zero(float16, float_status *status);
 int64_t float16_to_int64_round_to_zero(float16, float_status *status);
 
-float16 float32_to_float16(float32, flag, float_status *status);
-float32 float16_to_float32(float16, flag, float_status *status);
-float16 float64_to_float16(float64 a, flag ieee, float_status *status);
-float64 float16_to_float64(float16 a, flag ieee, float_status *status);
+float16 float32_to_float16(float32, bool ieee, float_status *status);
+float32 float16_to_float32(float16, bool ieee, float_status *status);
+float16 float64_to_float16(float64 a, bool ieee, float_status *status);
+float64 float16_to_float64(float16 a, bool ieee, float_status *status);
 
 /*----------------------------------------------------------------------------
 | Software half-precision operations.
diff --git a/fpu/floatconv.c b/fpu/floatconv.c
new file mode 100644
index 0000000000..7268a0e3c5
--- /dev/null
+++ b/fpu/floatconv.c
@@ -0,0 +1,154 @@
+/*
+ * Conversions between floating point types
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "fpu/softfloat.h"
+#include "soft-fp.h"
+#include "soft-fp-specialize.h"
+#include "half.h"
+#include "single.h"
+#include "double.h"
+#include "quad.h"
+
+
+#define DO_EXTEND(TYPEI, TYPEO, FI, FO, NI, NO)                     \
+TYPEO glue(TYPEI, glue(_to_, TYPEO))(TYPEI a, float_status *status) \
+{                                                                   \
+    FP_DECL_EX;                                                     \
+    FP_DECL_##FI(A);                                                \
+    FP_DECL_##FO(R);                                                \
+    TYPEO r;                                                        \
+    FP_INIT_EXCEPTIONS;                                             \
+    FP_UNPACK_RAW_##FI(A, a);                                       \
+    FP_EXTEND(FO, FI, NO, NI, R, A);                                \
+    FP_PACK_RAW_##FO(r, R);                                         \
+    FP_HANDLE_EXCEPTIONS;                                           \
+    return r;                                                       \
+}
+
+DO_EXTEND(float32, float64,  S, D, 1, 1)
+DO_EXTEND(float32, float128, S, Q, 1, 2)
+DO_EXTEND(float64, float128, D, Q, 1, 2)
+
+
+#define DO_TRUNC(TYPEI, TYPEO, FI, FO, NI, NO)                      \
+TYPEO glue(TYPEI, glue(_to_, TYPEO))(TYPEI a, float_status *status) \
+{                                                                   \
+    FP_DECL_EX;                                                     \
+    FP_DECL_##FI(A);                                                \
+    FP_DECL_##FO(R);                                                \
+    TYPEO r;                                                        \
+    FP_INIT_EXCEPTIONS;                                             \
+    FP_UNPACK_SEMIRAW_##FI(A, a);                                   \
+    FP_TRUNC(FO, FI, NO, NI, R, A);                                 \
+    FP_PACK_SEMIRAW_##FO(r, R);                                     \
+    FP_HANDLE_EXCEPTIONS;                                           \
+    return r;                                                       \
+}
+
+DO_TRUNC(float128, float64,  Q, D, 2, 1)
+DO_TRUNC(float128, float32,  Q, S, 2, 1)
+DO_TRUNC(float64, float32,   D, S, 1, 1)
+
+
+/* Half precision floats come in two formats: standard IEEE and "ARM" format.
+ * The latter gains extra exponent range by omitting the NaN/Inf encodings.
+ */
+
+#define DO_EXTEND_H(TYPEO, FO)                                      \
+TYPEO glue(float16_to_, TYPEO)(float16 a, bool ieee, float_status *status) \
+{                                                                   \
+    FP_DECL_EX;                                                     \
+    FP_DECL_H(A);                                                   \
+    FP_DECL_##FO(R);                                                \
+    TYPEO r;                                                        \
+    FP_INIT_EXCEPTIONS;                                             \
+    FP_UNPACK_RAW_H(A, a);                                          \
+    if (!ieee && A_e == _FP_EXPMAX_H) {                             \
+        R_s = A_s;                                                  \
+        R_e = A_e + _FP_EXPBIAS_##FO - _FP_EXPBIAS_H;               \
+        R_f = A_f;                                                  \
+        _FP_FRAC_SLL_1(R, (_FP_FRACBITS_##FO - _FP_FRACBITS_H));    \
+    } else {                                                        \
+        FP_EXTEND(FO, H, 1, 1, R, A);                               \
+    }                                                               \
+    FP_PACK_RAW_##FO(r, R);                                         \
+    FP_HANDLE_EXCEPTIONS;                                           \
+    return r;                                                       \
+}
+
+DO_EXTEND_H(float32, S)
+DO_EXTEND_H(float64, D)
+
+#define DO_TRUNC_H(TYPEI, FI)                                       \
+float16 glue(TYPEI, _to_float16)(TYPEI a, bool ieee, float_status *status) \
+{                                                                   \
+    FP_DECL_EX;                                                     \
+    FP_DECL_##FI(A);                                                \
+    FP_DECL_H(R);                                                   \
+    float16 r;                                                      \
+    FP_INIT_EXCEPTIONS;                                             \
+    FP_UNPACK_SEMIRAW_##FI(A, a);                                   \
+    if (unlikely(!ieee)) {                                          \
+        R_s = A_s;                                                  \
+        if (A_e == _FP_EXPMAX_##FI) {                               \
+            FP_SET_EXCEPTION(FP_EX_INVALID);                        \
+            if (A_f == 0) {                                         \
+                /* Inf maps to largest normal.  */                  \
+                R_e = _FP_EXPMAX_H;                                 \
+                R_f = (1 << _FP_FRACBITS_H) - 1;                    \
+            } else {                                                \
+                /* NaN maps to zero.  */                            \
+                R_e = R_f = 0;                                      \
+            }                                                       \
+            FP_PACK_RAW_H(r, R);                                    \
+            goto done;                                              \
+        }                                                           \
+        /* ARM format needs different rounding near max exponent. */ \
+        R_e = A_e + _FP_EXPBIAS_H - _FP_EXPBIAS_##FI;               \
+        if (R_e >= _FP_EXPMAX_H - 1) {                              \
+            _FP_FRAC_SRS_1(A, (_FP_WFRACBITS_##FI - _FP_WFRACBITS_H), \
+                           _FP_WFRACBITS_##FI);                     \
+            R_f = A_f;                                              \
+            _FP_ROUND(1, R);                                        \
+            if (R_f & (_FP_OVERFLOW_H >> 1)) {                      \
+                R_f &= ~(_FP_OVERFLOW_H >> 1);                      \
+                R_e++;                                              \
+                if (R_e > _FP_EXPMAX_H) {                           \
+                    /* Overflow saturates to largest normal.  */    \
+                    FP_SET_EXCEPTION(FP_EX_INVALID);                \
+                    R_e = _FP_EXPMAX_H;                             \
+                    R_f = (1 << _FP_FRACBITS_H) - 1;                \
+                } else {                                            \
+                    R_f >>= _FP_WORKBITS;                           \
+                }                                                   \
+            } else {                                                \
+                R_f >>= _FP_WORKBITS;                               \
+            }                                                       \
+            FP_PACK_RAW_H(r, R);                                    \
+            goto done;                                              \
+        }                                                           \
+    }                                                               \
+    FP_TRUNC(H, FI, 1, 1, R, A);                                    \
+    FP_PACK_SEMIRAW_H(r, R);                                        \
+ done:                                                              \
+    FP_HANDLE_EXCEPTIONS;                                           \
+    return r;                                                       \
+}
+
+DO_TRUNC_H(float64, D)
+DO_TRUNC_H(float32, S)
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 2550028d9f..dab9e39480 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1278,38 +1278,6 @@ floatx80 int64_to_floatx80(int64_t a, float_status *status)
 
 }
 
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
@@ -1342,38 +1310,6 @@ floatx80 float32_to_floatx80(float32 a, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of converting the single-precision floating-point value
-| `a' to the double-precision floating-point format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float128 float32_to_float128(float32 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    uint32_t aSig;
-
-    a = float32_squash_input_denormal(a, status);
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    aSign = extractFloat32Sign( a );
-    if ( aExp == 0xFF ) {
-        if (aSig) {
-            return commonNaNToFloat128(float32ToCommonNaN(a, status), status);
-        }
-        return packFloat128( aSign, 0x7FFF, 0, 0 );
-    }
-    if ( aExp == 0 ) {
-        if ( aSig == 0 ) return packFloat128( aSign, 0, 0, 0 );
-        normalizeFloat32Subnormal( aSig, &aExp, &aSig );
-        --aExp;
-    }
-    return packFloat128( aSign, aExp + 0x3F80, ( (uint64_t) aSig )<<25, 0 );
-
-}
-
 /*----------------------------------------------------------------------------
 | Rounds the single-precision floating-point value `a' to an integer, and
 | returns the result as a single-precision floating-point value.  The
@@ -1915,172 +1851,6 @@ float32 float32_log2(float32 a, float_status *status)
     return normalizeRoundAndPackFloat32(zSign, 0x85, zSig, status);
 }
 
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
@@ -2096,163 +1866,6 @@ float16 float16_squash_input_denormal(float16 a, float_status *status)
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
@@ -2285,40 +1898,6 @@ floatx80 float64_to_floatx80(float64 a, float_status *status)
             aSign, aExp + 0x3C00, ( aSig | LIT64( 0x0010000000000000 ) )<<11 );
 
 }
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the double-precision floating-point value
-| `a' to the quadruple-precision floating-point format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float128 float64_to_float128(float64 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    uint64_t aSig, zSig0, zSig1;
-
-    a = float64_squash_input_denormal(a, status);
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    aSign = extractFloat64Sign( a );
-    if ( aExp == 0x7FF ) {
-        if (aSig) {
-            return commonNaNToFloat128(float64ToCommonNaN(a, status), status);
-        }
-        return packFloat128( aSign, 0x7FFF, 0, 0 );
-    }
-    if ( aExp == 0 ) {
-        if ( aSig == 0 ) return packFloat128( aSign, 0, 0, 0 );
-        normalizeFloat64Subnormal( aSig, &aExp, &aSig );
-        --aExp;
-    }
-    shift128Right( aSig, 0, 4, &zSig0, &zSig1 );
-    return packFloat128( aSign, aExp + 0x3C00, zSig0, zSig1 );
-
-}
-
 /*----------------------------------------------------------------------------
 | Rounds the double-precision floating-point value `a' to an integer, and
 | returns the result as a double-precision floating-point value.  The
@@ -3680,74 +3259,6 @@ floatx80 floatx80_sqrt(floatx80 a, float_status *status)
                                 0, zExp, zSig0, zSig1, status);
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of converting the quadruple-precision floating-point
-| value `a' to the single-precision floating-point format.  The conversion
-| is performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float32 float128_to_float32(float128 a, float_status *status)
-{
-    flag aSign;
-    int32_t aExp;
-    uint64_t aSig0, aSig1;
-    uint32_t zSig;
-
-    aSig1 = extractFloat128Frac1( a );
-    aSig0 = extractFloat128Frac0( a );
-    aExp = extractFloat128Exp( a );
-    aSign = extractFloat128Sign( a );
-    if ( aExp == 0x7FFF ) {
-        if ( aSig0 | aSig1 ) {
-            return commonNaNToFloat32(float128ToCommonNaN(a, status), status);
-        }
-        return packFloat32( aSign, 0xFF, 0 );
-    }
-    aSig0 |= ( aSig1 != 0 );
-    shift64RightJamming( aSig0, 18, &aSig0 );
-    zSig = aSig0;
-    if ( aExp || zSig ) {
-        zSig |= 0x40000000;
-        aExp -= 0x3F81;
-    }
-    return roundAndPackFloat32(aSign, aExp, zSig, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the quadruple-precision floating-point
-| value `a' to the double-precision floating-point format.  The conversion
-| is performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float64 float128_to_float64(float128 a, float_status *status)
-{
-    flag aSign;
-    int32_t aExp;
-    uint64_t aSig0, aSig1;
-
-    aSig1 = extractFloat128Frac1( a );
-    aSig0 = extractFloat128Frac0( a );
-    aExp = extractFloat128Exp( a );
-    aSign = extractFloat128Sign( a );
-    if ( aExp == 0x7FFF ) {
-        if ( aSig0 | aSig1 ) {
-            return commonNaNToFloat64(float128ToCommonNaN(a, status), status);
-        }
-        return packFloat64( aSign, 0x7FF, 0 );
-    }
-    shortShift128Left( aSig0, aSig1, 14, &aSig0, &aSig1 );
-    aSig0 |= ( aSig1 != 0 );
-    if ( aExp || aSig0 ) {
-        aSig0 |= LIT64( 0x4000000000000000 );
-        aExp -= 0x3C01;
-    }
-    return roundAndPackFloat64(aSign, aExp, aSig0, status);
-
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the quadruple-precision floating-point
 | value `a' to the extended double-precision floating-point format.  The
-- 
2.14.3
