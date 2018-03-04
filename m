Received: from eggs.gnu.org ([2001:4830:134:3::10]:57146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1esXVO-0003FC-Gf
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 12:33:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1esXVK-0006PF-GP
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 12:33:02 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:45953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1esXVK-0006Nb-3E
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 12:32:58 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun,  4 Mar 2018 18:32:29 +0100
Message-Id: <20180304173232.22814-3-laurent@vivier.eu>
In-Reply-To: <20180304173232.22814-1-laurent@vivier.eu>
References: <20180304173232.22814-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 2/5] softfloat: export some functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>

Move fpu/softfloat-macros.h to include/fpu/

Export floatx80 functions to be used by target floatx80
specific implementations.

Exports:
  propagateFloatx80NaN(), extractFloatx80Frac(),
  extractFloatx80Exp(), extractFloatx80Sign(),
  normalizeFloatx80Subnormal(), packFloatx80(),
  roundAndPackFloatx80(), normalizeRoundAndPackFloatx80()

Also exports packFloat32() that will be used to implement
m68k fsinh, fcos, fsin, ftan operations.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180224201802.911-2-laurent@vivier.eu>
---
 fpu/softfloat-specialize.h              |   3 +-
 fpu/softfloat.c                         |  91 +++---------------------
 {fpu => include/fpu}/softfloat-macros.h |  10 +--
 include/fpu/softfloat.h                 | 121 ++++++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+), 88 deletions(-)
 rename {fpu => include/fpu}/softfloat-macros.h (98%)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index e81ca001e1..46126e9e0a 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -1011,8 +1011,7 @@ static floatx80 commonNaNToFloatx80(commonNaNT a, float_status *status)
 | `b' is a signaling NaN, the invalid exception is raised.
 *----------------------------------------------------------------------------*/
 
-static floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b,
-                                     float_status *status)
+floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
 {
     flag aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN;
     flag aIsLargerSignificand;
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index e7fb0d357a..fb4853682e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -93,7 +93,7 @@ this code that are retained.
 | division and square root approximations.  (Can be specialized to target if
 | desired.)
 *----------------------------------------------------------------------------*/
-#include "softfloat-macros.h"
+#include "fpu/softfloat-macros.h"
 
 /*----------------------------------------------------------------------------
 | Functions and definitions to determine:  (1) whether tininess for underflow
@@ -2192,25 +2192,6 @@ static void
 
 }
 
-/*----------------------------------------------------------------------------
-| Packs the sign `zSign', exponent `zExp', and significand `zSig' into a
-| single-precision floating-point value, returning the result.  After being
-| shifted into the proper positions, the three fields are simply added
-| together to form the result.  This means that any integer portion of `zSig'
-| will be added into the exponent.  Since a properly normalized significand
-| will have an integer portion equal to 1, the `zExp' input should be 1 less
-| than the desired result exponent whenever `zSig' is a complete, normalized
-| significand.
-*----------------------------------------------------------------------------*/
-
-static inline float32 packFloat32(flag zSign, int zExp, uint32_t zSig)
-{
-
-    return make_float32(
-          ( ( (uint32_t) zSign )<<31 ) + ( ( (uint32_t) zExp )<<23 ) + zSig);
-
-}
-
 /*----------------------------------------------------------------------------
 | Takes an abstract floating-point value having sign `zSign', exponent `zExp',
 | and significand `zSig', and returns the proper single-precision floating-
@@ -2490,42 +2471,6 @@ static float64
 
 }
 
-/*----------------------------------------------------------------------------
-| Returns the fraction bits of the extended double-precision floating-point
-| value `a'.
-*----------------------------------------------------------------------------*/
-
-static inline uint64_t extractFloatx80Frac( floatx80 a )
-{
-
-    return a.low;
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the exponent bits of the extended double-precision floating-point
-| value `a'.
-*----------------------------------------------------------------------------*/
-
-static inline int32_t extractFloatx80Exp( floatx80 a )
-{
-
-    return a.high & 0x7FFF;
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the sign bit of the extended double-precision floating-point value
-| `a'.
-*----------------------------------------------------------------------------*/
-
-static inline flag extractFloatx80Sign( floatx80 a )
-{
-
-    return a.high>>15;
-
-}
-
 /*----------------------------------------------------------------------------
 | Normalizes the subnormal extended double-precision floating-point value
 | represented by the denormalized significand `aSig'.  The normalized exponent
@@ -2533,30 +2478,14 @@ static inline flag extractFloatx80Sign( floatx80 a )
 | `zSigPtr', respectively.
 *----------------------------------------------------------------------------*/
 
-static void
- normalizeFloatx80Subnormal( uint64_t aSig, int32_t *zExpPtr, uint64_t *zSigPtr )
+void normalizeFloatx80Subnormal(uint64_t aSig, int32_t *zExpPtr,
+                                uint64_t *zSigPtr)
 {
     int8_t shiftCount;
 
     shiftCount = countLeadingZeros64( aSig );
     *zSigPtr = aSig<<shiftCount;
     *zExpPtr = 1 - shiftCount;
-
-}
-
-/*----------------------------------------------------------------------------
-| Packs the sign `zSign', exponent `zExp', and significand `zSig' into an
-| extended double-precision floating-point value, returning the result.
-*----------------------------------------------------------------------------*/
-
-static inline floatx80 packFloatx80( flag zSign, int32_t zExp, uint64_t zSig )
-{
-    floatx80 z;
-
-    z.low = zSig;
-    z.high = ( ( (uint16_t) zSign )<<15 ) + zExp;
-    return z;
-
 }
 
 /*----------------------------------------------------------------------------
@@ -2583,9 +2512,9 @@ static inline floatx80 packFloatx80( flag zSign, int32_t zExp, uint64_t zSig )
 | Floating-Point Arithmetic.
 *----------------------------------------------------------------------------*/
 
-static floatx80 roundAndPackFloatx80(int8_t roundingPrecision, flag zSign,
-                                     int32_t zExp, uint64_t zSig0, uint64_t zSig1,
-                                     float_status *status)
+floatx80 roundAndPackFloatx80(int8_t roundingPrecision, flag zSign,
+                              int32_t zExp, uint64_t zSig0, uint64_t zSig1,
+                              float_status *status)
 {
     int8_t roundingMode;
     flag roundNearestEven, increment, isTiny;
@@ -2779,10 +2708,10 @@ static floatx80 roundAndPackFloatx80(int8_t roundingPrecision, flag zSign,
 | normalized.
 *----------------------------------------------------------------------------*/
 
-static floatx80 normalizeRoundAndPackFloatx80(int8_t roundingPrecision,
-                                              flag zSign, int32_t zExp,
-                                              uint64_t zSig0, uint64_t zSig1,
-                                              float_status *status)
+floatx80 normalizeRoundAndPackFloatx80(int8_t roundingPrecision,
+                                       flag zSign, int32_t zExp,
+                                       uint64_t zSig0, uint64_t zSig1,
+                                       float_status *status)
 {
     int8_t shiftCount;
 
diff --git a/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
similarity index 98%
rename from fpu/softfloat-macros.h
rename to include/fpu/softfloat-macros.h
index c45a23193e..35e1603a5e 100644
--- a/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -603,7 +603,7 @@ static inline void
 | unsigned integer is returned.
 *----------------------------------------------------------------------------*/
 
-static uint64_t estimateDiv128To64( uint64_t a0, uint64_t a1, uint64_t b )
+static inline uint64_t estimateDiv128To64(uint64_t a0, uint64_t a1, uint64_t b)
 {
     uint64_t b0, b1;
     uint64_t rem0, rem1, term0, term1;
@@ -630,7 +630,7 @@ static uint64_t estimateDiv128To64( uint64_t a0, uint64_t a1, uint64_t b )
  *
  * Licensed under the GPLv2/LGPLv3
  */
-static uint64_t div128To64(uint64_t n0, uint64_t n1, uint64_t d)
+static inline uint64_t div128To64(uint64_t n0, uint64_t n1, uint64_t d)
 {
     uint64_t d0, d1, q0, q1, r1, r0, m;
 
@@ -683,7 +683,7 @@ static uint64_t div128To64(uint64_t n0, uint64_t n1, uint64_t d)
 | value.
 *----------------------------------------------------------------------------*/
 
-static uint32_t estimateSqrt32(int aExp, uint32_t a)
+static inline uint32_t estimateSqrt32(int aExp, uint32_t a)
 {
     static const uint16_t sqrtOddAdjustments[] = {
         0x0004, 0x0022, 0x005D, 0x00B1, 0x011D, 0x019F, 0x0236, 0x02E0,
@@ -717,7 +717,7 @@ static uint32_t estimateSqrt32(int aExp, uint32_t a)
 | `a'.  If `a' is zero, 32 is returned.
 *----------------------------------------------------------------------------*/
 
-static int8_t countLeadingZeros32( uint32_t a )
+static inline int8_t countLeadingZeros32(uint32_t a)
 {
 #if SOFTFLOAT_GNUC_PREREQ(3, 4)
     if (a) {
@@ -765,7 +765,7 @@ static int8_t countLeadingZeros32( uint32_t a )
 | `a'.  If `a' is zero, 64 is returned.
 *----------------------------------------------------------------------------*/
 
-static int8_t countLeadingZeros64( uint64_t a )
+static inline int8_t countLeadingZeros64(uint64_t a)
 {
 #if SOFTFLOAT_GNUC_PREREQ(3, 4)
     if (a) {
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 27876e711c..fa4fae224f 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -425,6 +425,23 @@ static inline float32 float32_set_sign(float32 a, int sign)
 #define float32_three make_float32(0x40400000)
 #define float32_infinity make_float32(0x7f800000)
 
+/*----------------------------------------------------------------------------
+| Packs the sign `zSign', exponent `zExp', and significand `zSig' into a
+| single-precision floating-point value, returning the result.  After being
+| shifted into the proper positions, the three fields are simply added
+| together to form the result.  This means that any integer portion of `zSig'
+| will be added into the exponent.  Since a properly normalized significand
+| will have an integer portion equal to 1, the `zExp' input should be 1 less
+| than the desired result exponent whenever `zSig' is a complete, normalized
+| significand.
+*----------------------------------------------------------------------------*/
+
+static inline float32 packFloat32(flag zSign, int zExp, uint32_t zSig)
+{
+    return make_float32(
+          (((uint32_t)zSign) << 31) + (((uint32_t)zExp) << 23) + zSig);
+}
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated single-precision NaN.
 *----------------------------------------------------------------------------*/
@@ -640,6 +657,110 @@ static inline bool floatx80_invalid_encoding(floatx80 a)
 #define floatx80_half make_floatx80(0x3ffe, 0x8000000000000000LL)
 #define floatx80_infinity make_floatx80(0x7fff, 0x8000000000000000LL)
 
+/*----------------------------------------------------------------------------
+| Returns the fraction bits of the extended double-precision floating-point
+| value `a'.
+*----------------------------------------------------------------------------*/
+
+static inline uint64_t extractFloatx80Frac(floatx80 a)
+{
+    return a.low;
+}
+
+/*----------------------------------------------------------------------------
+| Returns the exponent bits of the extended double-precision floating-point
+| value `a'.
+*----------------------------------------------------------------------------*/
+
+static inline int32_t extractFloatx80Exp(floatx80 a)
+{
+    return a.high & 0x7FFF;
+}
+
+/*----------------------------------------------------------------------------
+| Returns the sign bit of the extended double-precision floating-point value
+| `a'.
+*----------------------------------------------------------------------------*/
+
+static inline flag extractFloatx80Sign(floatx80 a)
+{
+    return a.high >> 15;
+}
+
+/*----------------------------------------------------------------------------
+| Packs the sign `zSign', exponent `zExp', and significand `zSig' into an
+| extended double-precision floating-point value, returning the result.
+*----------------------------------------------------------------------------*/
+
+static inline floatx80 packFloatx80(flag zSign, int32_t zExp, uint64_t zSig)
+{
+    floatx80 z;
+
+    z.low = zSig;
+    z.high = (((uint16_t)zSign) << 15) + zExp;
+    return z;
+}
+
+/*----------------------------------------------------------------------------
+| Normalizes the subnormal extended double-precision floating-point value
+| represented by the denormalized significand `aSig'.  The normalized exponent
+| and significand are stored at the locations pointed to by `zExpPtr' and
+| `zSigPtr', respectively.
+*----------------------------------------------------------------------------*/
+
+void normalizeFloatx80Subnormal(uint64_t aSig, int32_t *zExpPtr,
+                                uint64_t *zSigPtr);
+
+/*----------------------------------------------------------------------------
+| Takes two extended double-precision floating-point values `a' and `b', one
+| of which is a NaN, and returns the appropriate NaN result.  If either `a' or
+| `b' is a signaling NaN, the invalid exception is raised.
+*----------------------------------------------------------------------------*/
+
+floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status);
+
+/*----------------------------------------------------------------------------
+| Takes an abstract floating-point value having sign `zSign', exponent `zExp',
+| and extended significand formed by the concatenation of `zSig0' and `zSig1',
+| and returns the proper extended double-precision floating-point value
+| corresponding to the abstract input.  Ordinarily, the abstract value is
+| rounded and packed into the extended double-precision format, with the
+| inexact exception raised if the abstract input cannot be represented
+| exactly.  However, if the abstract value is too large, the overflow and
+| inexact exceptions are raised and an infinity or maximal finite value is
+| returned.  If the abstract value is too small, the input value is rounded to
+| a subnormal number, and the underflow and inexact exceptions are raised if
+| the abstract input cannot be represented exactly as a subnormal extended
+| double-precision floating-point number.
+|     If `roundingPrecision' is 32 or 64, the result is rounded to the same
+| number of bits as single or double precision, respectively.  Otherwise, the
+| result is rounded to the full precision of the extended double-precision
+| format.
+|     The input significand must be normalized or smaller.  If the input
+| significand is not normalized, `zExp' must be 0; in that case, the result
+| returned is a subnormal number, and it must not require rounding.  The
+| handling of underflow and overflow follows the IEC/IEEE Standard for Binary
+| Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+floatx80 roundAndPackFloatx80(int8_t roundingPrecision, flag zSign,
+                              int32_t zExp, uint64_t zSig0, uint64_t zSig1,
+                              float_status *status);
+
+/*----------------------------------------------------------------------------
+| Takes an abstract floating-point value having sign `zSign', exponent
+| `zExp', and significand formed by the concatenation of `zSig0' and `zSig1',
+| and returns the proper extended double-precision floating-point value
+| corresponding to the abstract input.  This routine is just like
+| `roundAndPackFloatx80' except that the input significand does not have to be
+| normalized.
+*----------------------------------------------------------------------------*/
+
+floatx80 normalizeRoundAndPackFloatx80(int8_t roundingPrecision,
+                                       flag zSign, int32_t zExp,
+                                       uint64_t zSig0, uint64_t zSig1,
+                                       float_status *status);
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated extended double-precision NaN.
 *----------------------------------------------------------------------------*/
-- 
2.14.3
