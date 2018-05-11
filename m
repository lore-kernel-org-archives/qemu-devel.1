Received: from eggs.gnu.org ([2001:4830:134:3::10]:52135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGwAS-0007Wu-Ab
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGwAQ-0004uW-Iz
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:44:16 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:42591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGwAQ-0004uR-Ay
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:44:14 -0400
Received: by mail-pf0-x241.google.com with SMTP id p14-v6so1859953pfh.9
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 17:44:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 17:43:44 -0700
Message-Id: <20180511004345.26708-19-richard.henderson@linaro.org>
In-Reply-To: <20180511004345.26708-1-richard.henderson@linaro.org>
References: <20180511004345.26708-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 18/19] fpu/softfloat: Pass FloatClass to pickNaN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

For each operand, pass a single enumeration instead of a pair of booleans.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 168 ++++++++++++++++++-------------------
 fpu/softfloat.c            |  35 ++++----
 2 files changed, 98 insertions(+), 105 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index e7b4544e48..83e5bf83b9 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -490,10 +490,10 @@ static float32 commonNaNToFloat32(commonNaNT a, float_status *status)
 | tie-break rule.
 *----------------------------------------------------------------------------*/
 
-#if defined(TARGET_ARM)
-static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
+static int pickNaN(FloatClass a_cls, FloatClass b_cls,
                    flag aIsLargerSignificand)
 {
+#if defined(TARGET_ARM) || defined(TARGET_MIPS) || defined(TARGET_HPPA)
     /* ARM mandated NaN propagation rules (see FPProcessNaNs()), take
      * the first of:
      *  1. A if it is signaling
@@ -502,20 +502,6 @@ static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
      *  4. B (quiet)
      * A signaling NaN is always quietened before returning it.
      */
-    if (aIsSNaN) {
-        return 0;
-    } else if (bIsSNaN) {
-        return 1;
-    } else if (aIsQNaN) {
-        return 0;
-    } else {
-        return 1;
-    }
-}
-#elif defined(TARGET_MIPS) || defined(TARGET_HPPA)
-static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
-                    flag aIsLargerSignificand)
-{
     /* According to MIPS specifications, if one of the two operands is
      * a sNaN, a new qNaN has to be generated. This is done in
      * floatXX_silence_nan(). For qNaN inputs the specifications
@@ -529,35 +515,21 @@ static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
      *  4. B (quiet)
      * A signaling NaN is always silenced before returning it.
      */
-    if (aIsSNaN) {
+    if (is_snan(a_cls)) {
         return 0;
-    } else if (bIsSNaN) {
+    } else if (is_snan(b_cls)) {
         return 1;
-    } else if (aIsQNaN) {
+    } else if (is_qnan(a_cls)) {
         return 0;
     } else {
         return 1;
     }
-}
-#elif defined(TARGET_PPC) || defined(TARGET_XTENSA)
-static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
-                   flag aIsLargerSignificand)
-{
+#elif defined(TARGET_PPC) || defined(TARGET_XTENSA) || defined(TARGET_M68K)
     /* PowerPC propagation rules:
      *  1. A if it sNaN or qNaN
      *  2. B if it sNaN or qNaN
      * A signaling NaN is always silenced before returning it.
      */
-    if (aIsSNaN || aIsQNaN) {
-        return 0;
-    } else {
-        return 1;
-    }
-}
-#elif defined(TARGET_M68K)
-static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
-                   flag aIsLargerSignificand)
-{
     /* M68000 FAMILY PROGRAMMER'S REFERENCE MANUAL
      * 3.4 FLOATING-POINT INSTRUCTION DETAILS
      * If either operand, but not both operands, of an operation is a
@@ -572,16 +544,12 @@ static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
      * a nonsignaling NaN. The operation then continues as described in the
      * preceding paragraph for nonsignaling NaNs.
      */
-    if (aIsQNaN || aIsSNaN) { /* a is the destination operand */
-        return 0; /* return the destination operand */
+    if (is_nan(a_cls)) {
+        return 0;
     } else {
-        return 1; /* return b */
+        return 1;
     }
-}
 #else
-static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
-                    flag aIsLargerSignificand)
-{
     /* This implements x87 NaN propagation rules:
      * SNaN + QNaN => return the QNaN
      * two SNaNs => return the one with the larger significand, silenced
@@ -592,13 +560,13 @@ static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
      * If we get down to comparing significands and they are the same,
      * return the NaN with the positive sign bit (if any).
      */
-    if (aIsSNaN) {
-        if (bIsSNaN) {
+    if (is_snan(a_cls)) {
+        if (is_snan(b_cls)) {
             return aIsLargerSignificand ? 0 : 1;
         }
-        return bIsQNaN ? 1 : 0;
-    } else if (aIsQNaN) {
-        if (bIsSNaN || !bIsQNaN) {
+        return is_qnan(b_cls) ? 1 : 0;
+    } else if (is_qnan(a_cls)) {
+        if (is_snan(b_cls) || !is_qnan(b_cls)) {
             return 0;
         } else {
             return aIsLargerSignificand ? 0 : 1;
@@ -606,8 +574,8 @@ static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
     } else {
         return 1;
     }
-}
 #endif
+}
 
 /*----------------------------------------------------------------------------
 | Select which NaN to propagate for a three-input operation.
@@ -741,18 +709,26 @@ static int pickNaNMulAdd(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
 
 static float32 propagateFloat32NaN(float32 a, float32 b, float_status *status)
 {
-    flag aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN;
     flag aIsLargerSignificand;
     uint32_t av, bv;
+    FloatClass a_cls, b_cls;
+
+    /* This is not complete, but is good enough for pickNaN.  */
+    a_cls = (!float32_is_any_nan(a)
+             ? float_class_normal
+             : float32_is_signaling_nan(a, status)
+             ? float_class_snan
+             : float_class_qnan);
+    b_cls = (!float32_is_any_nan(b)
+             ? float_class_normal
+             : float32_is_signaling_nan(b, status)
+             ? float_class_snan
+             : float_class_qnan);
 
-    aIsQuietNaN = float32_is_quiet_nan(a, status);
-    aIsSignalingNaN = float32_is_signaling_nan(a, status);
-    bIsQuietNaN = float32_is_quiet_nan(b, status);
-    bIsSignalingNaN = float32_is_signaling_nan(b, status);
     av = float32_val(a);
     bv = float32_val(b);
 
-    if (aIsSignalingNaN | bIsSignalingNaN) {
+    if (is_snan(a_cls) || is_snan(b_cls)) {
         float_raise(float_flag_invalid, status);
     }
 
@@ -768,14 +744,13 @@ static float32 propagateFloat32NaN(float32 a, float32 b, float_status *status)
         aIsLargerSignificand = (av < bv) ? 1 : 0;
     }
 
-    if (pickNaN(aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN,
-                aIsLargerSignificand)) {
-        if (bIsSignalingNaN) {
+    if (pickNaN(a_cls, b_cls, aIsLargerSignificand)) {
+        if (is_snan(b_cls)) {
             return float32_silence_nan(b, status);
         }
         return b;
     } else {
-        if (aIsSignalingNaN) {
+        if (is_snan(a_cls)) {
             return float32_silence_nan(a, status);
         }
         return a;
@@ -897,18 +872,26 @@ static float64 commonNaNToFloat64(commonNaNT a, float_status *status)
 
 static float64 propagateFloat64NaN(float64 a, float64 b, float_status *status)
 {
-    flag aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN;
     flag aIsLargerSignificand;
     uint64_t av, bv;
+    FloatClass a_cls, b_cls;
+
+    /* This is not complete, but is good enough for pickNaN.  */
+    a_cls = (!float64_is_any_nan(a)
+             ? float_class_normal
+             : float64_is_signaling_nan(a, status)
+             ? float_class_snan
+             : float_class_qnan);
+    b_cls = (!float64_is_any_nan(b)
+             ? float_class_normal
+             : float64_is_signaling_nan(b, status)
+             ? float_class_snan
+             : float_class_qnan);
 
-    aIsQuietNaN = float64_is_quiet_nan(a, status);
-    aIsSignalingNaN = float64_is_signaling_nan(a, status);
-    bIsQuietNaN = float64_is_quiet_nan(b, status);
-    bIsSignalingNaN = float64_is_signaling_nan(b, status);
     av = float64_val(a);
     bv = float64_val(b);
 
-    if (aIsSignalingNaN | bIsSignalingNaN) {
+    if (is_snan(a_cls) || is_snan(b_cls)) {
         float_raise(float_flag_invalid, status);
     }
 
@@ -924,14 +907,13 @@ static float64 propagateFloat64NaN(float64 a, float64 b, float_status *status)
         aIsLargerSignificand = (av < bv) ? 1 : 0;
     }
 
-    if (pickNaN(aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN,
-                aIsLargerSignificand)) {
-        if (bIsSignalingNaN) {
+    if (pickNaN(a_cls, b_cls, aIsLargerSignificand)) {
+        if (is_snan(b_cls)) {
             return float64_silence_nan(b, status);
         }
         return b;
     } else {
-        if (aIsSignalingNaN) {
+        if (is_snan(a_cls)) {
             return float64_silence_nan(a, status);
         }
         return a;
@@ -1064,15 +1046,22 @@ static floatx80 commonNaNToFloatx80(commonNaNT a, float_status *status)
 
 floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
 {
-    flag aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN;
     flag aIsLargerSignificand;
+    FloatClass a_cls, b_cls;
 
-    aIsQuietNaN = floatx80_is_quiet_nan(a, status);
-    aIsSignalingNaN = floatx80_is_signaling_nan(a, status);
-    bIsQuietNaN = floatx80_is_quiet_nan(b, status);
-    bIsSignalingNaN = floatx80_is_signaling_nan(b, status);
+    /* This is not complete, but is good enough for pickNaN.  */
+    a_cls = (!floatx80_is_any_nan(a)
+             ? float_class_normal
+             : floatx80_is_signaling_nan(a, status)
+             ? float_class_snan
+             : float_class_qnan);
+    b_cls = (!floatx80_is_any_nan(b)
+             ? float_class_normal
+             : floatx80_is_signaling_nan(b, status)
+             ? float_class_snan
+             : float_class_qnan);
 
-    if (aIsSignalingNaN | bIsSignalingNaN) {
+    if (is_snan(a_cls) || is_snan(b_cls)) {
         float_raise(float_flag_invalid, status);
     }
 
@@ -1088,14 +1077,13 @@ floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
         aIsLargerSignificand = (a.high < b.high) ? 1 : 0;
     }
 
-    if (pickNaN(aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN,
-                aIsLargerSignificand)) {
-        if (bIsSignalingNaN) {
+    if (pickNaN(a_cls, b_cls, aIsLargerSignificand)) {
+        if (is_snan(b_cls)) {
             return floatx80_silence_nan(b, status);
         }
         return b;
     } else {
-        if (aIsSignalingNaN) {
+        if (is_snan(a_cls)) {
             return floatx80_silence_nan(a, status);
         }
         return a;
@@ -1206,15 +1194,22 @@ static float128 commonNaNToFloat128(commonNaNT a, float_status *status)
 static float128 propagateFloat128NaN(float128 a, float128 b,
                                      float_status *status)
 {
-    flag aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN;
     flag aIsLargerSignificand;
+    FloatClass a_cls, b_cls;
 
-    aIsQuietNaN = float128_is_quiet_nan(a, status);
-    aIsSignalingNaN = float128_is_signaling_nan(a, status);
-    bIsQuietNaN = float128_is_quiet_nan(b, status);
-    bIsSignalingNaN = float128_is_signaling_nan(b, status);
+    /* This is not complete, but is good enough for pickNaN.  */
+    a_cls = (!float128_is_any_nan(a)
+             ? float_class_normal
+             : float128_is_signaling_nan(a, status)
+             ? float_class_snan
+             : float_class_qnan);
+    b_cls = (!float128_is_any_nan(b)
+             ? float_class_normal
+             : float128_is_signaling_nan(b, status)
+             ? float_class_snan
+             : float_class_qnan);
 
-    if (aIsSignalingNaN | bIsSignalingNaN) {
+    if (is_snan(a_cls) || is_snan(b_cls)) {
         float_raise(float_flag_invalid, status);
     }
 
@@ -1230,14 +1225,13 @@ static float128 propagateFloat128NaN(float128 a, float128 b,
         aIsLargerSignificand = (a.high < b.high) ? 1 : 0;
     }
 
-    if (pickNaN(aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN,
-                aIsLargerSignificand)) {
-        if (bIsSignalingNaN) {
+    if (pickNaN(a_cls, b_cls, aIsLargerSignificand)) {
+        if (is_snan(b_cls)) {
             return float128_silence_nan(b, status);
         }
         return b;
     } else {
-        if (aIsSignalingNaN) {
+        if (is_snan(a_cls)) {
             return float128_silence_nan(a, status);
         }
         return a;
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index cce94136d4..cd56beb277 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -181,6 +181,22 @@ typedef enum __attribute__ ((__packed__)) {
     float_class_snan,
 } FloatClass;
 
+/* Simple helpers for checking if what NaN we have */
+static bool is_nan(FloatClass c)
+{
+    return unlikely(c >= float_class_qnan);
+}
+
+static bool is_snan(FloatClass c)
+{
+    return c == float_class_snan;
+}
+
+static bool is_qnan(FloatClass c)
+{
+    return c == float_class_qnan;
+}
+
 /*
  * Structure holding all of the decomposed parts of a float. The
  * exponent is unbiased and the fraction is normalized. All
@@ -546,22 +562,6 @@ static float64 float64_round_pack_canonical(FloatParts p, float_status *s)
     return float64_pack_raw(round_canonical(p, s, &float64_params));
 }
 
-/* Simple helpers for checking if what NaN we have */
-static bool is_nan(FloatClass c)
-{
-    return unlikely(c >= float_class_qnan);
-}
-
-static bool is_snan(FloatClass c)
-{
-    return c == float_class_snan;
-}
-
-static bool is_qnan(FloatClass c)
-{
-    return c == float_class_qnan;
-}
-
 static FloatParts return_nan(FloatParts a, float_status *s)
 {
     switch (a.cls) {
@@ -590,8 +590,7 @@ static FloatParts pick_nan(FloatParts a, FloatParts b, float_status *s)
     if (s->default_nan_mode) {
         return parts_default_nan(s);
     } else {
-        if (pickNaN(is_qnan(a.cls), is_snan(a.cls),
-                    is_qnan(b.cls), is_snan(b.cls),
+        if (pickNaN(a.cls, b.cls,
                     a.frac > b.frac ||
                     (a.frac == b.frac && a.sign < b.sign))) {
             a = b;
-- 
2.17.0
