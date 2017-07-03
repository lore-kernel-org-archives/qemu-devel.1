Received: from eggs.gnu.org ([2001:4830:134:3::10]:48946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dS48t-0002ot-RY
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dS48q-00010n-Hc
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:24:07 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:63259)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dS48q-00010L-68
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:24:04 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  3 Jul 2017 18:23:25 +0200
Message-Id: <20170703162328.24474-2-laurent@vivier.eu>
In-Reply-To: <20170703162328.24474-1-laurent@vivier.eu>
References: <20170703162328.24474-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 1/4] softfloat: use floatx80_infinity in
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Since f3218a8 ("softfloat: add floatx80 constants")
floatx80_infinity is defined but never used.

This patch updates floatx80 functions to use
this definition.

This allows to define a different default Infinity
value on m68k: the m68k FPU defines infinity with
all bits set to zero in the mantissa.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 fpu/softfloat-specialize.h | 14 ++++++++++++++
 fpu/softfloat.c            | 38 ++++++++++++++++++++++++++------------
 include/fpu/softfloat.h    |  9 +++++++--
 3 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index de2c5d5..1cb3502 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -178,6 +178,20 @@ floatx80 floatx80_default_nan(float_status *status)
 }
 
 /*----------------------------------------------------------------------------
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
+/*----------------------------------------------------------------------------
 | The pattern for a default generated quadruple-precision NaN.
 *----------------------------------------------------------------------------*/
 float128 float128_default_nan(float_status *status)
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 433c5da..2355403 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -913,7 +913,9 @@ static floatx80 roundAndPackFloatx80(int8_t roundingPrecision, flag zSign,
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
@@ -1885,7 +1887,9 @@ floatx80 float32_to_floatx80(float32 a, float_status *status)
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
@@ -3666,7 +3670,9 @@ floatx80 float64_to_floatx80(float64 a, float_status *status)
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
@@ -4927,8 +4933,8 @@ int64_t floatx80_to_int64(floatx80 a, float_status *status)
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
@@ -5235,7 +5241,9 @@ static floatx80 addFloatx80Sigs(floatx80 a, floatx80 b, flag zSign,
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
@@ -5310,7 +5318,8 @@ static floatx80 subFloatx80Sigs(floatx80 a, floatx80 b, flag zSign,
         if ((uint64_t)(bSig << 1)) {
             return propagateFloatx80NaN(a, b, status);
         }
-        return packFloatx80( zSign ^ 1, 0x7FFF, LIT64( 0x8000000000000000 ) );
+        return packFloatx80(zSign ^ 1, floatx80_infinity_high,
+                            floatx80_infinity_low);
     }
     if ( aExp == 0 ) ++expDiff;
     shift128RightJamming( aSig, 0, - expDiff, &aSig, &zSig1 );
@@ -5415,7 +5424,8 @@ floatx80 floatx80_mul(floatx80 a, floatx80 b, float_status *status)
             return propagateFloatx80NaN(a, b, status);
         }
         if ( ( bExp | bSig ) == 0 ) goto invalid;
-        return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+        return packFloatx80(zSign, floatx80_infinity_high,
+                                   floatx80_infinity_low);
     }
     if ( bExp == 0x7FFF ) {
         if ((uint64_t)(bSig << 1)) {
@@ -5426,7 +5436,8 @@ floatx80 floatx80_mul(floatx80 a, floatx80 b, float_status *status)
             float_raise(float_flag_invalid, status);
             return floatx80_default_nan(status);
         }
-        return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+        return packFloatx80(zSign, floatx80_infinity_high,
+                                   floatx80_infinity_low);
     }
     if ( aExp == 0 ) {
         if ( aSig == 0 ) return packFloatx80( zSign, 0, 0 );
@@ -5480,7 +5491,8 @@ floatx80 floatx80_div(floatx80 a, floatx80 b, float_status *status)
             }
             goto invalid;
         }
-        return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+        return packFloatx80(zSign, floatx80_infinity_high,
+                                   floatx80_infinity_low);
     }
     if ( bExp == 0x7FFF ) {
         if ((uint64_t)(bSig << 1)) {
@@ -5496,7 +5508,8 @@ floatx80 floatx80_div(floatx80 a, floatx80 b, float_status *status)
                 return floatx80_default_nan(status);
             }
             float_raise(float_flag_divbyzero, status);
-            return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) );
+            return packFloatx80(zSign, floatx80_infinity_high,
+                                       floatx80_infinity_low);
         }
         normalizeFloatx80Subnormal( bSig, &bExp, &bSig );
     }
@@ -6319,7 +6332,8 @@ floatx80 float128_to_floatx80(float128 a, float_status *status)
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
index d9689ec..464a0f7 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -619,6 +619,11 @@ float64 floatx80_to_float64(floatx80, float_status *status);
 float128 floatx80_to_float128(floatx80, float_status *status);
 
 /*----------------------------------------------------------------------------
+| The pattern for an extended double-precision inf.
+*----------------------------------------------------------------------------*/
+extern const floatx80 floatx80_infinity;
+
+/*----------------------------------------------------------------------------
 | Software IEC/IEEE extended double-precision operations.
 *----------------------------------------------------------------------------*/
 floatx80 floatx80_round(floatx80 a, float_status *status);
@@ -658,7 +663,8 @@ static inline floatx80 floatx80_chs(floatx80 a)
 
 static inline int floatx80_is_infinity(floatx80 a)
 {
-    return (a.high & 0x7fff) == 0x7fff && a.low == 0x8000000000000000LL;
+    return (a.high & 0x7fff) == floatx80_infinity.high &&
+                       a.low == floatx80_infinity.low;
 }
 
 static inline int floatx80_is_neg(floatx80 a)
@@ -701,7 +707,6 @@ static inline bool floatx80_invalid_encoding(floatx80 a)
 #define floatx80_ln2 make_floatx80(0x3ffe, 0xb17217f7d1cf79acLL)
 #define floatx80_pi make_floatx80(0x4000, 0xc90fdaa22168c235LL)
 #define floatx80_half make_floatx80(0x3ffe, 0x8000000000000000LL)
-#define floatx80_infinity make_floatx80(0x7fff, 0x8000000000000000LL)
 
 /*----------------------------------------------------------------------------
 | The pattern for a default generated extended double-precision NaN.
-- 
2.9.4
