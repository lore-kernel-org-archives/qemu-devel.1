Received: from eggs.gnu.org ([2001:4830:134:3::10]:34929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1epEpt-0006Sb-Un
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:00:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1epEpn-0005ej-QM
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:00:34 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:52945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1epEpn-0005d4-Ax
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:00:27 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 23 Feb 2018 15:59:58 +0100
Message-Id: <20180223145959.18761-4-laurent@vivier.eu>
In-Reply-To: <20180223145959.18761-1-laurent@vivier.eu>
References: <20180223145959.18761-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v3 3/4] softfloat: use floatx80_infinity in
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
Cc: Richard Henderson <rth@twiddle.net>, Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>

Since f3218a8 ("softfloat: add floatx80 constants")
floatx80_infinity is defined but never used.

This patch updates floatx80 functions to use
this definition.

This allows to define a different default Infinity
value on m68k: the m68k FPU defines infinity with
all bits set to zero in the mantissa.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
CC: Aurelien Jarno <aurelien@aurel32.net>

 fpu/softfloat-specialize.h | 14 ++++++++++++++
 fpu/softfloat.c            | 38 ++++++++++++++++++++++++++------------
 include/fpu/softfloat.h    |  9 +++++++--
 3 files changed, 47 insertions(+), 14 deletions(-)

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
index fb4853682e..70a86e156c 100644
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
@@ -4550,8 +4556,8 @@ int64_t floatx80_to_int64(floatx80 a, float_status *status)
         if ( shiftCount ) {
             float_raise(float_flag_invalid, status);
             if (    ! aSign
-                 || (    ( aExp == 0x7FFF )
-                      && ( aSig != LIT64( 0x8000000000000000 ) ) )
+                 || ((aExp == floatx80_infinity_high)
+                     && (aSig != floatx80_infinity_low))
                ) {
                 return LIT64( 0x7FFFFFFFFFFFFFFF );
             }
@@ -4858,7 +4864,9 @@ static floatx80 addFloatx80Sigs(floatx80 a, floatx80 b, flag zSign,
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
@@ -4933,7 +4941,8 @@ static floatx80 subFloatx80Sigs(floatx80 a, floatx80 b, flag zSign,
         if ((uint64_t)(bSig << 1)) {
             return propagateFloatx80NaN(a, b, status);
         }
-        return packFloatx80( zSign ^ 1, 0x7FFF, LIT64( 0x8000000000000000 ) );
+        return packFloatx80(zSign ^ 1, floatx80_infinity_high,
+                            floatx80_infinity_low);
     }
     if ( aExp == 0 ) ++expDiff;
     shift128RightJamming( aSig, 0, - expDiff, &aSig, &zSig1 );
@@ -5038,7 +5047,8 @@ floatx80 floatx80_mul(floatx80 a, floatx80 b, float_status *status)
             return propagateFloatx80NaN(a, b, status);
         }
         if ( ( bExp | bSig ) == 0 ) goto invalid;
-        return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+        return packFloatx80(zSign, floatx80_infinity_high,
+                                   floatx80_infinity_low);
     }
     if ( bExp == 0x7FFF ) {
         if ((uint64_t)(bSig << 1)) {
@@ -5049,7 +5059,8 @@ floatx80 floatx80_mul(floatx80 a, floatx80 b, float_status *status)
             float_raise(float_flag_invalid, status);
             return floatx80_default_nan(status);
         }
-        return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+        return packFloatx80(zSign, floatx80_infinity_high,
+                                   floatx80_infinity_low);
     }
     if ( aExp == 0 ) {
         if ( aSig == 0 ) return packFloatx80( zSign, 0, 0 );
@@ -5103,7 +5114,8 @@ floatx80 floatx80_div(floatx80 a, floatx80 b, float_status *status)
             }
             goto invalid;
         }
-        return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+        return packFloatx80(zSign, floatx80_infinity_high,
+                                   floatx80_infinity_low);
     }
     if ( bExp == 0x7FFF ) {
         if ((uint64_t)(bSig << 1)) {
@@ -5119,7 +5131,8 @@ floatx80 floatx80_div(floatx80 a, floatx80 b, float_status *status)
                 return floatx80_default_nan(status);
             }
             float_raise(float_flag_divbyzero, status);
-            return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+            return packFloatx80(zSign, floatx80_infinity_high,
+                                       floatx80_infinity_low);
         }
         normalizeFloatx80Subnormal( bSig, &bExp, &bSig );
     }
@@ -5942,7 +5955,8 @@ floatx80 float128_to_floatx80(float128 a, float_status *status)
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
index 125dcb5586..7edf407cbc 100644
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
@@ -603,7 +608,8 @@ static inline floatx80 floatx80_chs(floatx80 a)
 
 static inline int floatx80_is_infinity(floatx80 a)
 {
-    return (a.high & 0x7fff) == 0x7fff && a.low == 0x8000000000000000LL;
+    return (a.high & 0x7fff) == floatx80_infinity.high &&
+                       a.low == floatx80_infinity.low;
 }
 
 static inline int floatx80_is_neg(floatx80 a)
@@ -646,7 +652,6 @@ static inline bool floatx80_invalid_encoding(floatx80 a)
 #define floatx80_ln2 make_floatx80(0x3ffe, 0xb17217f7d1cf79acLL)
 #define floatx80_pi make_floatx80(0x4000, 0xc90fdaa22168c235LL)
 #define floatx80_half make_floatx80(0x3ffe, 0x8000000000000000LL)
-#define floatx80_infinity make_floatx80(0x7fff, 0x8000000000000000LL)
 
 /*----------------------------------------------------------------------------
 | Returns the fraction bits of the extended double-precision floating-point
-- 
2.14.3
