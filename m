Received: from eggs.gnu.org ([2001:4830:134:3::10]:51497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsvu-0006jB-BA
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsvs-0006vB-5Y
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:10 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYsvr-0006ro-Rh
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:08 -0500
Received: by mail-wr0-x243.google.com with SMTP id b76so13906746wrd.3
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 04:23:07 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Jan 2018 12:22:44 +0000
Message-Id: <20180109122252.17670-13-alex.bennee@linaro.org>
In-Reply-To: <20180109122252.17670-1-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 12/20] fpu/softfloat: re-factor mul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

We can now add float16_mul and use the common decompose and
canonicalize functions to have a single implementation for
float16/32/64 versions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c         | 207 ++++++++++++++++++------------------------------
 include/fpu/softfloat.h |   1 +
 2 files changed, 80 insertions(+), 128 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index f89e47e3ef..6e9d4c172c 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -730,6 +730,85 @@ float64 float64_sub(float64 a, float64 b, float_status *status)
     return float64_round_pack_canonical(pr, status);
 }
 
+/*
+ * Returns the result of multiplying the floating-point values `a' and
+ * `b'. The operation is performed according to the IEC/IEEE Standard
+ * for Binary Floating-Point Arithmetic.
+ */
+
+static decomposed_parts mul_decomposed(decomposed_parts a, decomposed_parts b,
+                                       float_status *s)
+{
+    bool sign = a.sign ^ b.sign;
+
+    if (a.cls == float_class_normal && b.cls == float_class_normal) {
+        uint64_t hi, lo;
+        int exp = a.exp + b.exp;
+
+        mul64To128(a.frac, b.frac, &hi, &lo);
+        shift128RightJamming(hi, lo, DECOMPOSED_BINARY_POINT, &hi, &lo);
+        if (lo & DECOMPOSED_OVERFLOW_BIT) {
+            shift64RightJamming(lo, 1, &lo);
+            exp += 1;
+        }
+
+        /* Re-use a */
+        a.exp = exp;
+        a.sign = sign;
+        a.frac = lo;
+        return a;
+    }
+    /* handle all the NaN cases */
+    if (a.cls >= float_class_qnan || b.cls >= float_class_qnan) {
+        return pick_nan_parts(a, b, s);
+    }
+    /* Inf * Zero == NaN */
+    if (((1 << a.cls) | (1 << b.cls)) ==
+        ((1 << float_class_inf) | (1 << float_class_zero))) {
+        s->float_exception_flags |= float_flag_invalid;
+        a.cls = float_class_dnan;
+        a.sign = sign;
+        return a;
+    }
+    /* Multiply by 0 or Inf */
+    if (a.cls == float_class_inf || a.cls == float_class_zero) {
+        a.sign = sign;
+        return a;
+    }
+    if (b.cls == float_class_inf || b.cls == float_class_zero) {
+        b.sign = sign;
+        return b;
+    }
+    g_assert_not_reached();
+}
+
+float16 float16_mul(float16 a, float16 b, float_status *status)
+{
+    decomposed_parts pa = float16_unpack_canonical(a, status);
+    decomposed_parts pb = float16_unpack_canonical(b, status);
+    decomposed_parts pr = mul_decomposed(pa, pb, status);
+
+    return float16_round_pack_canonical(pr, status);
+}
+
+float32 float32_mul(float32 a, float32 b, float_status *status)
+{
+    decomposed_parts pa = float32_unpack_canonical(a, status);
+    decomposed_parts pb = float32_unpack_canonical(b, status);
+    decomposed_parts pr = mul_decomposed(pa, pb, status);
+
+    return float32_round_pack_canonical(pr, status);
+}
+
+float64 float64_mul(float64 a, float64 b, float_status *status)
+{
+    decomposed_parts pa = float64_unpack_canonical(a, status);
+    decomposed_parts pb = float64_unpack_canonical(b, status);
+    decomposed_parts pr = mul_decomposed(pa, pb, status);
+
+    return float64_round_pack_canonical(pr, status);
+}
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
@@ -2542,70 +2621,6 @@ float32 float32_round_to_int(float32 a, float_status *status)
 }
 
 
-/*----------------------------------------------------------------------------
-| Returns the result of multiplying the single-precision floating-point values
-| `a' and `b'.  The operation is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float32 float32_mul(float32 a, float32 b, float_status *status)
-{
-    flag aSign, bSign, zSign;
-    int aExp, bExp, zExp;
-    uint32_t aSig, bSig;
-    uint64_t zSig64;
-    uint32_t zSig;
-
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    aSign = extractFloat32Sign( a );
-    bSig = extractFloat32Frac( b );
-    bExp = extractFloat32Exp( b );
-    bSign = extractFloat32Sign( b );
-    zSign = aSign ^ bSign;
-    if ( aExp == 0xFF ) {
-        if ( aSig || ( ( bExp == 0xFF ) && bSig ) ) {
-            return propagateFloat32NaN(a, b, status);
-        }
-        if ( ( bExp | bSig ) == 0 ) {
-            float_raise(float_flag_invalid, status);
-            return float32_default_nan(status);
-        }
-        return packFloat32( zSign, 0xFF, 0 );
-    }
-    if ( bExp == 0xFF ) {
-        if (bSig) {
-            return propagateFloat32NaN(a, b, status);
-        }
-        if ( ( aExp | aSig ) == 0 ) {
-            float_raise(float_flag_invalid, status);
-            return float32_default_nan(status);
-        }
-        return packFloat32( zSign, 0xFF, 0 );
-    }
-    if ( aExp == 0 ) {
-        if ( aSig == 0 ) return packFloat32( zSign, 0, 0 );
-        normalizeFloat32Subnormal( aSig, &aExp, &aSig );
-    }
-    if ( bExp == 0 ) {
-        if ( bSig == 0 ) return packFloat32( zSign, 0, 0 );
-        normalizeFloat32Subnormal( bSig, &bExp, &bSig );
-    }
-    zExp = aExp + bExp - 0x7F;
-    aSig = ( aSig | 0x00800000 )<<7;
-    bSig = ( bSig | 0x00800000 )<<8;
-    shift64RightJamming( ( (uint64_t) aSig ) * bSig, 32, &zSig64 );
-    zSig = zSig64;
-    if ( 0 <= (int32_t) ( zSig<<1 ) ) {
-        zSig <<= 1;
-        --zExp;
-    }
-    return roundAndPackFloat32(zSign, zExp, zSig, status);
-
-}
 
 /*----------------------------------------------------------------------------
 | Returns the result of dividing the single-precision floating-point value `a'
@@ -4138,70 +4153,6 @@ float64 float64_trunc_to_int(float64 a, float_status *status)
     return res;
 }
 
-
-/*----------------------------------------------------------------------------
-| Returns the result of multiplying the double-precision floating-point values
-| `a' and `b'.  The operation is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float64 float64_mul(float64 a, float64 b, float_status *status)
-{
-    flag aSign, bSign, zSign;
-    int aExp, bExp, zExp;
-    uint64_t aSig, bSig, zSig0, zSig1;
-
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    aSign = extractFloat64Sign( a );
-    bSig = extractFloat64Frac( b );
-    bExp = extractFloat64Exp( b );
-    bSign = extractFloat64Sign( b );
-    zSign = aSign ^ bSign;
-    if ( aExp == 0x7FF ) {
-        if ( aSig || ( ( bExp == 0x7FF ) && bSig ) ) {
-            return propagateFloat64NaN(a, b, status);
-        }
-        if ( ( bExp | bSig ) == 0 ) {
-            float_raise(float_flag_invalid, status);
-            return float64_default_nan(status);
-        }
-        return packFloat64( zSign, 0x7FF, 0 );
-    }
-    if ( bExp == 0x7FF ) {
-        if (bSig) {
-            return propagateFloat64NaN(a, b, status);
-        }
-        if ( ( aExp | aSig ) == 0 ) {
-            float_raise(float_flag_invalid, status);
-            return float64_default_nan(status);
-        }
-        return packFloat64( zSign, 0x7FF, 0 );
-    }
-    if ( aExp == 0 ) {
-        if ( aSig == 0 ) return packFloat64( zSign, 0, 0 );
-        normalizeFloat64Subnormal( aSig, &aExp, &aSig );
-    }
-    if ( bExp == 0 ) {
-        if ( bSig == 0 ) return packFloat64( zSign, 0, 0 );
-        normalizeFloat64Subnormal( bSig, &bExp, &bSig );
-    }
-    zExp = aExp + bExp - 0x3FF;
-    aSig = ( aSig | LIT64( 0x0010000000000000 ) )<<10;
-    bSig = ( bSig | LIT64( 0x0010000000000000 ) )<<11;
-    mul64To128( aSig, bSig, &zSig0, &zSig1 );
-    zSig0 |= ( zSig1 != 0 );
-    if ( 0 <= (int64_t) ( zSig0<<1 ) ) {
-        zSig0 <<= 1;
-        --zExp;
-    }
-    return roundAndPackFloat64(zSign, zExp, zSig0, status);
-
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of dividing the double-precision floating-point value `a'
 | by the corresponding value `b'.  The operation is performed according to
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 3a21a2bcef..cfee28061e 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -321,6 +321,7 @@ float64 float16_to_float64(float16 a, flag ieee, float_status *status);
 
 float16 float16_add(float16, float16, float_status *status);
 float16 float16_sub(float16, float16, float_status *status);
+float16 float16_mul(float16, float16, float_status *status);
 
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
-- 
2.15.1
