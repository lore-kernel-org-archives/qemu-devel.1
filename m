Received: from eggs.gnu.org ([2001:4830:134:3::10]:33644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1epgHA-00023b-ED
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 15:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1epgH7-00083X-72
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 15:18:32 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:54695)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1epgH6-00082W-T3
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 15:18:29 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 24 Feb 2018 21:18:01 +0100
Message-Id: <20180224201802.911-4-laurent@vivier.eu>
In-Reply-To: <20180224201802.911-1-laurent@vivier.eu>
References: <20180224201802.911-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v4 3/4] softfloat: use floatx80_infinity in
 softfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>

Since f3218a8 ("softfloat: add floatx80 constants")
floatx80_infinity is defined but never used.

This patch updates floatx80 functions to use
this definition.

This allows to define a different default Infinity
value on m68k: the m68k FPU defines infinity with
all bits set to zero in the mantissa.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
CC: Aurelien Jarno <aurelien@aurel32.net>
    v4: fix floatx80_to_int64() to check for NaN, not for infinity
        fix floatx80_is_infinity() to ignore mantissa's MSB

 fpu/softfloat-specialize.h | 14 ++++++++++++++
 fpu/softfloat.c            | 39 +++++++++++++++++++++++++--------------
 include/fpu/softfloat.h    | 13 +++++++++++--
 3 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 46126e9e0a..9ccb59422c 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -177,6 +177,20 @@ floatx80 floatx80_default_nan(float_status *status)
     return r;
 }
 
+/*----------------------------------------------------------------------------
+| The pattern for a default generated extended double-precision inf.
+*----------------------------------------------------------------------------*/
+
+#define floatx80_infinity_high 0x7FFF
+#if defined(TARGET_M68K)
+#define floatx80_infinity_low  LIT64(0x0000000000000000)
+#else
+#define floatx80_infinity_low  LIT64(0x8000000000000000)
+#endif
+
+const floatx80 floatx80_infinity
+    = make_floatx80_init(floatx80_infinity_high, floatx80_infinity_low);
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated quadruple-precision NaN.
 *----------------------------------------------------------------------------*/
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index fb4853682e..e124df9f7e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2636,7 +2636,9 @@ floatx80 roundAndPackFloatx80(int8_t roundingPrecision, flag zSign,
                ) {
                 return packFloatx80( zSign, 0x7FFE, ~ roundMask );
             }
-            return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+            return packFloatx80(zSign,
+                                floatx80_infinity_high,
+                                floatx80_infinity_low);
         }
         if ( zExp <= 0 ) {
             isTiny =
@@ -3182,7 +3184,9 @@ floatx80 float32_to_floatx80(float32 a, float_status *status)
         if (aSig) {
             return commonNaNToFloatx80(float32ToCommonNaN(a, status), status);
         }
-        return packFloatx80( aSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+        return packFloatx80(aSign,
+                            floatx80_infinity_high,
+                            floatx80_infinity_low);
     }
     if ( aExp == 0 ) {
         if ( aSig == 0 ) return packFloatx80( aSign, 0, 0 );
@@ -4037,7 +4041,9 @@ floatx80 float64_to_floatx80(float64 a, float_status *status)
         if (aSig) {
             return commonNaNToFloatx80(float64ToCommonNaN(a, status), status);
         }
-        return packFloatx80( aSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+        return packFloatx80(aSign,
+                            floatx80_infinity_high,
+                            floatx80_infinity_low);
     }
     if ( aExp == 0 ) {
         if ( aSig == 0 ) return packFloatx80( aSign, 0, 0 );
@@ -4549,10 +4555,7 @@ int64_t floatx80_to_int64(floatx80 a, float_status *status)
     if ( shiftCount <= 0 ) {
         if ( shiftCount ) {
             float_raise(float_flag_invalid, status);
-            if (    ! aSign
-                 || (    ( aExp == 0x7FFF )
-                      && ( aSig != LIT64( 0x8000000000000000 ) ) )
-               ) {
+            if (!aSign || floatx80_is_any_nan(a)) {
                 return LIT64( 0x7FFFFFFFFFFFFFFF );
             }
             return (int64_t) LIT64( 0x8000000000000000 );
@@ -4858,7 +4861,9 @@ static floatx80 addFloatx80Sigs(floatx80 a, floatx80 b, flag zSign,
             if ((uint64_t)(bSig << 1)) {
                 return propagateFloatx80NaN(a, b, status);
             }
-            return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+            return packFloatx80(zSign,
+                                floatx80_infinity_high,
+                                floatx80_infinity_low);
         }
         if ( aExp == 0 ) ++expDiff;
         shift64ExtraRightJamming( aSig, 0, - expDiff, &aSig, &zSig1 );
@@ -4933,7 +4938,8 @@ static floatx80 subFloatx80Sigs(floatx80 a, floatx80 b, flag zSign,
         if ((uint64_t)(bSig << 1)) {
             return propagateFloatx80NaN(a, b, status);
         }
-        return packFloatx80( zSign ^ 1, 0x7FFF, LIT64( 0x8000000000000000 ) );
+        return packFloatx80(zSign ^ 1, floatx80_infinity_high,
+                            floatx80_infinity_low);
     }
     if ( aExp == 0 ) ++expDiff;
     shift128RightJamming( aSig, 0, - expDiff, &aSig, &zSig1 );
@@ -5038,7 +5044,8 @@ floatx80 floatx80_mul(floatx80 a, floatx80 b, float_status *status)
             return propagateFloatx80NaN(a, b, status);
         }
         if ( ( bExp | bSig ) == 0 ) goto invalid;
-        return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+        return packFloatx80(zSign, floatx80_infinity_high,
+                                   floatx80_infinity_low);
     }
     if ( bExp == 0x7FFF ) {
         if ((uint64_t)(bSig << 1)) {
@@ -5049,7 +5056,8 @@ floatx80 floatx80_mul(floatx80 a, floatx80 b, float_status *status)
             float_raise(float_flag_invalid, status);
             return floatx80_default_nan(status);
         }
-        return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+        return packFloatx80(zSign, floatx80_infinity_high,
+                                   floatx80_infinity_low);
     }
     if ( aExp == 0 ) {
         if ( aSig == 0 ) return packFloatx80( zSign, 0, 0 );
@@ -5103,7 +5111,8 @@ floatx80 floatx80_div(floatx80 a, floatx80 b, float_status *status)
             }
             goto invalid;
         }
-        return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+        return packFloatx80(zSign, floatx80_infinity_high,
+                                   floatx80_infinity_low);
     }
     if ( bExp == 0x7FFF ) {
         if ((uint64_t)(bSig << 1)) {
@@ -5119,7 +5128,8 @@ floatx80 floatx80_div(floatx80 a, floatx80 b, float_status *status)
                 return floatx80_default_nan(status);
             }
             float_raise(float_flag_divbyzero, status);
-            return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+            return packFloatx80(zSign, floatx80_infinity_high,
+                                       floatx80_infinity_low);
         }
         normalizeFloatx80Subnormal( bSig, &bExp, &bSig );
     }
@@ -5942,7 +5952,8 @@ floatx80 float128_to_floatx80(float128 a, float_status *status)
         if ( aSig0 | aSig1 ) {
             return commonNaNToFloatx80(float128ToCommonNaN(a, status), status);
         }
-        return packFloatx80( aSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+        return packFloatx80(aSign, floatx80_infinity_high,
+                                   floatx80_infinity_low);
     }
     if ( aExp == 0 ) {
         if ( ( aSig0 | aSig1 ) == 0 ) return packFloatx80( aSign, 0, 0 );
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 125dcb5586..873a520e3e 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -563,6 +563,11 @@ float32 floatx80_to_float32(floatx80, float_status *status);
 float64 floatx80_to_float64(floatx80, float_status *status);
 float128 floatx80_to_float128(floatx80, float_status *status);
 
+/*----------------------------------------------------------------------------
+| The pattern for an extended double-precision inf.
+*----------------------------------------------------------------------------*/
+extern const floatx80 floatx80_infinity;
+
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE extended double-precision operations.
 *----------------------------------------------------------------------------*/
@@ -603,7 +608,12 @@ static inline floatx80 floatx80_chs(floatx80 a)
 
 static inline int floatx80_is_infinity(floatx80 a)
 {
-    return (a.high & 0x7fff) == 0x7fff && a.low == 0x8000000000000000LL;
+#if defined(TARGET_M68K)
+    return (a.high & 0x7fff) == floatx80_infinity.high && !(a.low << 1);
+#else
+    return (a.high & 0x7fff) == floatx80_infinity.high &&
+                       a.low == floatx80_infinity.low;
+#endif
 }
 
 static inline int floatx80_is_neg(floatx80 a)
@@ -646,7 +656,6 @@ static inline bool floatx80_invalid_encoding(floatx80 a)
 #define floatx80_ln2 make_floatx80(0x3ffe, 0xb17217f7d1cf79acLL)
 #define floatx80_pi make_floatx80(0x4000, 0xc90fdaa22168c235LL)
 #define floatx80_half make_floatx80(0x3ffe, 0x8000000000000000LL)
-#define floatx80_infinity make_floatx80(0x7fff, 0x8000000000000000LL)
 
 /*----------------------------------------------------------------------------
 | Returns the fraction bits of the extended double-precision floating-point
-- 
2.14.3
