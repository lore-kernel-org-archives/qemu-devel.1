Received: from eggs.gnu.org ([2001:4830:134:3::10]:42099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIyjz-0004gy-O6
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIyjx-0005A8-Sm
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:53:23 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:43231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIyjx-00059h-KX
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:53:21 -0400
Received: by mail-pf0-x235.google.com with SMTP id j20-v6so562583pff.10
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 08:53:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 16 May 2018 08:52:39 -0700
Message-Id: <20180516155243.16937-25-richard.henderson@linaro.org>
In-Reply-To: <20180516155243.16937-1-richard.henderson@linaro.org>
References: <20180516155243.16937-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/28] fpu/softfloat: Pass FloatClass to pickNaN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

For each operand, pass a single enumeration instead of a pair of booleans.
The commit also merges multiple different ifdef-selected implementations
of pickNaN into a single function whose body is ifdef-selected.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 168 ++++++++++++++++++-------------------
 fpu/softfloat.c            |   3 +-
 2 files changed, 82 insertions(+), 89 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index d1e06da75b..2695183188 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -501,10 +501,10 @@ static float32 commonNaNToFloat32(commonNaNT a, float_status *status)
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
@@ -513,20 +513,6 @@ static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
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
@@ -540,35 +526,21 @@ static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
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
@@ -583,16 +555,12 @@ static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
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
@@ -603,13 +571,13 @@ static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
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
@@ -617,8 +585,8 @@ static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
     } else {
         return 1;
     }
-}
 #endif
+}
 
 /*----------------------------------------------------------------------------
 | Select which NaN to propagate for a three-input operation.
@@ -752,18 +720,26 @@ static int pickNaNMulAdd(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
 
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
 
@@ -779,14 +755,13 @@ static float32 propagateFloat32NaN(float32 a, float32 b, float_status *status)
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
@@ -908,18 +883,26 @@ static float64 commonNaNToFloat64(commonNaNT a, float_status *status)
 
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
 
@@ -935,14 +918,13 @@ static float64 propagateFloat64NaN(float64 a, float64 b, float_status *status)
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
@@ -1075,15 +1057,22 @@ static floatx80 commonNaNToFloatx80(commonNaNT a, float_status *status)
 
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
 
@@ -1099,14 +1088,13 @@ floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
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
@@ -1217,15 +1205,22 @@ static float128 commonNaNToFloat128(commonNaNT a, float_status *status)
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
 
@@ -1241,14 +1236,13 @@ static float128 propagateFloat128NaN(float128 a, float128 b,
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
index ea252e0c84..55954385ff 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -580,8 +580,7 @@ static FloatParts pick_nan(FloatParts a, FloatParts b, float_status *s)
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
