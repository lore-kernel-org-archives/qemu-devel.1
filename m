Received: from eggs.gnu.org ([2001:4830:134:3::10]:47441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBf2-0004tJ-A4
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBf0-00054e-8H
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:12 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:43339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBf0-00053s-05
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:10 -0500
Received: by mail-pl0-x243.google.com with SMTP id f4so9361191plr.10
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:12:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:32 -0800
Message-Id: <20180204041136.17525-21-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 20/24] fpu: Implement sqrt with soft-fp.h
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

Add float16 support.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h |   1 +
 fpu/floatxx.inc.c       |  16 +++++
 fpu/softfloat.c         | 179 ------------------------------------------------
 3 files changed, 17 insertions(+), 179 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 95590d8420..0aae0454e2 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -250,6 +250,7 @@ float16 float16_add(float16, float16, float_status *status);
 float16 float16_sub(float16, float16, float_status *status);
 float16 float16_mul(float16, float16, float_status *status);
 float16 float16_div(float16, float16, float_status *status);
+float16 float16_sqrt(float16, float_status *status);
 int float16_eq(float16, float16, float_status *status);
 int float16_le(float16, float16, float_status *status);
 int float16_lt(float16, float16, float_status *status);
diff --git a/fpu/floatxx.inc.c b/fpu/floatxx.inc.c
index 0b6b8b4fd3..7a7f53dd5d 100644
--- a/fpu/floatxx.inc.c
+++ b/fpu/floatxx.inc.c
@@ -101,6 +101,22 @@ FLOATXX glue(FLOATXX,_div)(FLOATXX a, FLOATXX b, float_status *status)
     return r;
 }
 
+FLOATXX glue(FLOATXX,_sqrt)(FLOATXX a, float_status *status)
+{
+    FP_DECL_EX;
+    glue(FP_DECL_, FS)(A);
+    glue(FP_DECL_, FS)(R);
+    FLOATXX r;
+
+    FP_INIT_ROUNDMODE;
+    glue(FP_UNPACK_, FS)(A, a);
+    glue(FP_SQRT_, FS)(R, A);
+    glue(FP_PACK_, FS)(r, R);
+    FP_HANDLE_EXCEPTIONS;
+
+    return r;
+}
+
 #define DO_FLOAT_TO_INT(NAME, SZ, FP_TO_INT_WHICH)   \
 int##SZ##_t NAME(FLOATXX a, float_status *status) \
 {                                                 \
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 68dfb464d5..83995cc60f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1783,63 +1783,6 @@ float32 float32_muladd(float32 a, float32 b, float32 c, int flags,
 }
 
 
-/*----------------------------------------------------------------------------
-| Returns the square root of the single-precision floating-point value `a'.
-| The operation is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float32 float32_sqrt(float32 a, float_status *status)
-{
-    flag aSign;
-    int aExp, zExp;
-    uint32_t aSig, zSig;
-    uint64_t rem, term;
-    a = float32_squash_input_denormal(a, status);
-
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    aSign = extractFloat32Sign( a );
-    if ( aExp == 0xFF ) {
-        if (aSig) {
-            return propagateFloat32NaN(a, float32_zero, status);
-        }
-        if ( ! aSign ) return a;
-        float_raise(float_flag_invalid, status);
-        return float32_default_nan(status);
-    }
-    if ( aSign ) {
-        if ( ( aExp | aSig ) == 0 ) return a;
-        float_raise(float_flag_invalid, status);
-        return float32_default_nan(status);
-    }
-    if ( aExp == 0 ) {
-        if ( aSig == 0 ) return float32_zero;
-        normalizeFloat32Subnormal( aSig, &aExp, &aSig );
-    }
-    zExp = ( ( aExp - 0x7F )>>1 ) + 0x7E;
-    aSig = ( aSig | 0x00800000 )<<8;
-    zSig = estimateSqrt32( aExp, aSig ) + 2;
-    if ( ( zSig & 0x7F ) <= 5 ) {
-        if ( zSig < 2 ) {
-            zSig = 0x7FFFFFFF;
-            goto roundAndPack;
-        }
-        aSig >>= aExp & 1;
-        term = ( (uint64_t) zSig ) * zSig;
-        rem = ( ( (uint64_t) aSig )<<32 ) - term;
-        while ( (int64_t) rem < 0 ) {
-            --zSig;
-            rem += ( ( (uint64_t) zSig )<<1 ) | 1;
-        }
-        zSig |= ( rem != 0 );
-    }
-    shift32RightJamming( zSig, 1, &zSig );
- roundAndPack:
-    return roundAndPackFloat32(0, zExp, zSig, status);
-
-}
-
 /*----------------------------------------------------------------------------
 | Returns the binary exponential of the single-precision floating-point value
 | `a'. The operation is performed according to the IEC/IEEE Standard for
@@ -2804,60 +2747,6 @@ float64 float64_muladd(float64 a, float64 b, float64 c, int flags,
     }
 }
 
-/*----------------------------------------------------------------------------
-| Returns the square root of the double-precision floating-point value `a'.
-| The operation is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float64 float64_sqrt(float64 a, float_status *status)
-{
-    flag aSign;
-    int aExp, zExp;
-    uint64_t aSig, zSig, doubleZSig;
-    uint64_t rem0, rem1, term0, term1;
-    a = float64_squash_input_denormal(a, status);
-
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    aSign = extractFloat64Sign( a );
-    if ( aExp == 0x7FF ) {
-        if (aSig) {
-            return propagateFloat64NaN(a, a, status);
-        }
-        if ( ! aSign ) return a;
-        float_raise(float_flag_invalid, status);
-        return float64_default_nan(status);
-    }
-    if ( aSign ) {
-        if ( ( aExp | aSig ) == 0 ) return a;
-        float_raise(float_flag_invalid, status);
-        return float64_default_nan(status);
-    }
-    if ( aExp == 0 ) {
-        if ( aSig == 0 ) return float64_zero;
-        normalizeFloat64Subnormal( aSig, &aExp, &aSig );
-    }
-    zExp = ( ( aExp - 0x3FF )>>1 ) + 0x3FE;
-    aSig |= LIT64( 0x0010000000000000 );
-    zSig = estimateSqrt32( aExp, aSig>>21 );
-    aSig <<= 9 - ( aExp & 1 );
-    zSig = estimateDiv128To64( aSig, 0, zSig<<32 ) + ( zSig<<30 );
-    if ( ( zSig & 0x1FF ) <= 5 ) {
-        doubleZSig = zSig<<1;
-        mul64To128( zSig, zSig, &term0, &term1 );
-        sub128( aSig, 0, term0, term1, &rem0, &rem1 );
-        while ( (int64_t) rem0 < 0 ) {
-            --zSig;
-            doubleZSig -= 2;
-            add128( rem0, rem1, zSig>>63, doubleZSig | 1, &rem0, &rem1 );
-        }
-        zSig |= ( ( rem0 | rem1 ) != 0 );
-    }
-    return roundAndPackFloat64(0, zExp, zSig, status);
-
-}
-
 /*----------------------------------------------------------------------------
 | Returns the binary log of the double-precision floating-point value `a'.
 | The operation is performed according to the IEC/IEEE Standard for Binary
@@ -4139,74 +4028,6 @@ float128 float128_rem(float128 a, float128 b, float_status *status)
                                          status);
 }
 
-/*----------------------------------------------------------------------------
-| Returns the square root of the quadruple-precision floating-point value `a'.
-| The operation is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float128 float128_sqrt(float128 a, float_status *status)
-{
-    flag aSign;
-    int32_t aExp, zExp;
-    uint64_t aSig0, aSig1, zSig0, zSig1, zSig2, doubleZSig0;
-    uint64_t rem0, rem1, rem2, rem3, term0, term1, term2, term3;
-
-    aSig1 = extractFloat128Frac1( a );
-    aSig0 = extractFloat128Frac0( a );
-    aExp = extractFloat128Exp( a );
-    aSign = extractFloat128Sign( a );
-    if ( aExp == 0x7FFF ) {
-        if (aSig0 | aSig1) {
-            return propagateFloat128NaN(a, a, status);
-        }
-        if ( ! aSign ) return a;
-        goto invalid;
-    }
-    if ( aSign ) {
-        if ( ( aExp | aSig0 | aSig1 ) == 0 ) return a;
- invalid:
-        float_raise(float_flag_invalid, status);
-        return float128_default_nan(status);
-    }
-    if ( aExp == 0 ) {
-        if ( ( aSig0 | aSig1 ) == 0 ) return packFloat128( 0, 0, 0, 0 );
-        normalizeFloat128Subnormal( aSig0, aSig1, &aExp, &aSig0, &aSig1 );
-    }
-    zExp = ( ( aExp - 0x3FFF )>>1 ) + 0x3FFE;
-    aSig0 |= LIT64( 0x0001000000000000 );
-    zSig0 = estimateSqrt32( aExp, aSig0>>17 );
-    shortShift128Left( aSig0, aSig1, 13 - ( aExp & 1 ), &aSig0, &aSig1 );
-    zSig0 = estimateDiv128To64( aSig0, aSig1, zSig0<<32 ) + ( zSig0<<30 );
-    doubleZSig0 = zSig0<<1;
-    mul64To128( zSig0, zSig0, &term0, &term1 );
-    sub128( aSig0, aSig1, term0, term1, &rem0, &rem1 );
-    while ( (int64_t) rem0 < 0 ) {
-        --zSig0;
-        doubleZSig0 -= 2;
-        add128( rem0, rem1, zSig0>>63, doubleZSig0 | 1, &rem0, &rem1 );
-    }
-    zSig1 = estimateDiv128To64( rem1, 0, doubleZSig0 );
-    if ( ( zSig1 & 0x1FFF ) <= 5 ) {
-        if ( zSig1 == 0 ) zSig1 = 1;
-        mul64To128( doubleZSig0, zSig1, &term1, &term2 );
-        sub128( rem1, 0, term1, term2, &rem1, &rem2 );
-        mul64To128( zSig1, zSig1, &term2, &term3 );
-        sub192( rem1, rem2, 0, 0, term2, term3, &rem1, &rem2, &rem3 );
-        while ( (int64_t) rem1 < 0 ) {
-            --zSig1;
-            shortShift128Left( 0, zSig1, 1, &term2, &term3 );
-            term3 |= 1;
-            term2 |= doubleZSig0;
-            add192( rem1, rem2, rem3, 0, term2, term3, &rem1, &rem2, &rem3 );
-        }
-        zSig1 |= ( ( rem1 | rem2 | rem3 ) != 0 );
-    }
-    shift128ExtraRightJamming( zSig0, zSig1, 0, 14, &zSig0, &zSig1, &zSig2 );
-    return roundAndPackFloat128(0, zExp, zSig0, zSig1, zSig2, status);
-
-}
-
 static inline int floatx80_compare_internal(floatx80 a, floatx80 b,
                                             int is_quiet, float_status *status)
 {
-- 
2.14.3
