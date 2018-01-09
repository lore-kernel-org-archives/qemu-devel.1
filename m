Received: from eggs.gnu.org ([2001:4830:134:3::10]:53761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYt15-0002ag-Tv
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYt12-0002BV-K4
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:31 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYt12-0002AK-9y
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:28 -0500
Received: by mail-wm0-x243.google.com with SMTP id a79so20274124wma.0
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 04:28:28 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Jan 2018 12:22:45 +0000
Message-Id: <20180109122252.17670-14-alex.bennee@linaro.org>
In-Reply-To: <20180109122252.17670-1-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 13/20] fpu/softfloat: re-factor div
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

We can now add float16_div and use the common decompose and
canonicalize functions to have a single implementation for
float16/32/64 versions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-macros.h  |  44 +++++++++
 fpu/softfloat.c         | 235 ++++++++++++++++++------------------------------
 include/fpu/softfloat.h |   1 +
 3 files changed, 134 insertions(+), 146 deletions(-)

diff --git a/fpu/softfloat-macros.h b/fpu/softfloat-macros.h
index 9cc6158cb4..980be2c051 100644
--- a/fpu/softfloat-macros.h
+++ b/fpu/softfloat-macros.h
@@ -625,6 +625,50 @@ static uint64_t estimateDiv128To64( uint64_t a0, uint64_t a1, uint64_t b )
 
 }
 
+/* Nicked from gmp longlong.h __udiv_qrnnd */
+static uint64_t div128To64(uint64_t n0, uint64_t n1, uint64_t d)
+{
+    uint64_t d0, d1, q0, q1, r1, r0, m;
+
+    d0 = (uint32_t)d;
+    d1 = d >> 32;
+
+    r1 = n1 % d1;
+    q1 = n1 / d1;
+    m = q1 * d0;
+    r1 = (r1 << 32) | (n0 >> 32);
+    if (r1 < m) {
+        q1 -= 1;
+        r1 += d;
+        if (r1 >= d) {
+            if (r1 < m) {
+                q1 -= 1;
+                r1 += d;
+            }
+        }
+    }
+    r1 -= m;
+
+    r0 = r1 % d1;
+    q0 = r1 / d1;
+    m = q0 * d0;
+    r0 = (r0 << 32) | (uint32_t)n0;
+    if (r0 < m) {
+        q0 -= 1;
+        r0 += d;
+        if (r0 >= d) {
+            if (r0 < m) {
+                q0 -= 1;
+                r0 += d;
+            }
+        }
+    }
+    r0 -= m;
+
+    /* Return remainder in LSB */
+    return (q1 << 32) | q0 | (r0 != 0);
+}
+
 /*----------------------------------------------------------------------------
 | Returns an approximation to the square root of the 32-bit significand given
 | by `a'.  Considered as an integer, `a' must be at least 2^31.  If bit 0 of
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6e9d4c172c..2b703c12ed 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -809,6 +809,95 @@ float64 float64_mul(float64 a, float64 b, float_status *status)
     return float64_round_pack_canonical(pr, status);
 }
 
+/*
+ * Returns the result of dividing the floating-point value `a' by the
+ * corresponding value `b'. The operation is performed according to
+ * the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
+ */
+
+static decomposed_parts div_decomposed(decomposed_parts a, decomposed_parts b,
+                                       float_status *s)
+{
+    bool sign = a.sign ^ b.sign;
+
+    if (a.cls == float_class_normal && b.cls == float_class_normal) {
+        uint64_t temp_lo, temp_hi;
+        int exp = a.exp - b.exp;
+        if (a.frac < b.frac) {
+            exp -= 1;
+            shortShift128Left(0, a.frac, DECOMPOSED_BINARY_POINT + 1,
+                              &temp_hi, &temp_lo);
+        } else {
+            shortShift128Left(0, a.frac, DECOMPOSED_BINARY_POINT,
+                              &temp_hi, &temp_lo);
+        }
+        /* LSB of quot is set if inexact which roundandpack will use
+         * to set flags. Yet again we re-use a for the result */
+        a.frac = div128To64(temp_lo, temp_hi, b.frac);
+        a.sign = sign;
+        a.exp = exp;
+        return a;
+    }
+    /* handle all the NaN cases */
+    if (a.cls >= float_class_qnan || b.cls >= float_class_qnan) {
+        return pick_nan_parts(a, b, s);
+    }
+    /* 0/0 or Inf/Inf */
+    if (a.cls == b.cls
+        &&
+        (a.cls == float_class_inf || a.cls == float_class_zero)) {
+        s->float_exception_flags |= float_flag_invalid;
+        a.cls = float_class_dnan;
+        return a;
+    }
+    /* Div 0 => Inf */
+    if (b.cls == float_class_zero) {
+        s->float_exception_flags |= float_flag_divbyzero;
+        a.cls = float_class_inf;
+        a.sign = sign;
+        return a;
+    }
+    /* Inf / x or 0 / x */
+    if (a.cls == float_class_inf || a.cls == float_class_zero) {
+        a.sign = sign;
+        return a;
+    }
+    /* Div by Inf */
+    if (b.cls == float_class_inf) {
+        a.cls = float_class_zero;
+        a.sign = sign;
+        return a;
+    }
+    g_assert_not_reached();
+}
+
+float16 float16_div(float16 a, float16 b, float_status *status)
+{
+    decomposed_parts pa = float16_unpack_canonical(a, status);
+    decomposed_parts pb = float16_unpack_canonical(b, status);
+    decomposed_parts pr = div_decomposed(pa, pb, status);
+
+    return float16_round_pack_canonical(pr, status);
+}
+
+float32 float32_div(float32 a, float32 b, float_status *status)
+{
+    decomposed_parts pa = float32_unpack_canonical(a, status);
+    decomposed_parts pb = float32_unpack_canonical(b, status);
+    decomposed_parts pr = div_decomposed(pa, pb, status);
+
+    return float32_round_pack_canonical(pr, status);
+}
+
+float64 float64_div(float64 a, float64 b, float_status *status)
+{
+    decomposed_parts pa = float64_unpack_canonical(a, status);
+    decomposed_parts pb = float64_unpack_canonical(b, status);
+    decomposed_parts pr = div_decomposed(pa, pb, status);
+
+    return float64_round_pack_canonical(pr, status);
+}
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
@@ -2622,75 +2711,6 @@ float32 float32_round_to_int(float32 a, float_status *status)
 
 
 
-/*----------------------------------------------------------------------------
-| Returns the result of dividing the single-precision floating-point value `a'
-| by the corresponding value `b'.  The operation is performed according to the
-| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float32 float32_div(float32 a, float32 b, float_status *status)
-{
-    flag aSign, bSign, zSign;
-    int aExp, bExp, zExp;
-    uint32_t aSig, bSig, zSig;
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
-        if (aSig) {
-            return propagateFloat32NaN(a, b, status);
-        }
-        if ( bExp == 0xFF ) {
-            if (bSig) {
-                return propagateFloat32NaN(a, b, status);
-            }
-            float_raise(float_flag_invalid, status);
-            return float32_default_nan(status);
-        }
-        return packFloat32( zSign, 0xFF, 0 );
-    }
-    if ( bExp == 0xFF ) {
-        if (bSig) {
-            return propagateFloat32NaN(a, b, status);
-        }
-        return packFloat32( zSign, 0, 0 );
-    }
-    if ( bExp == 0 ) {
-        if ( bSig == 0 ) {
-            if ( ( aExp | aSig ) == 0 ) {
-                float_raise(float_flag_invalid, status);
-                return float32_default_nan(status);
-            }
-            float_raise(float_flag_divbyzero, status);
-            return packFloat32( zSign, 0xFF, 0 );
-        }
-        normalizeFloat32Subnormal( bSig, &bExp, &bSig );
-    }
-    if ( aExp == 0 ) {
-        if ( aSig == 0 ) return packFloat32( zSign, 0, 0 );
-        normalizeFloat32Subnormal( aSig, &aExp, &aSig );
-    }
-    zExp = aExp - bExp + 0x7D;
-    aSig = ( aSig | 0x00800000 )<<7;
-    bSig = ( bSig | 0x00800000 )<<8;
-    if ( bSig <= ( aSig + aSig ) ) {
-        aSig >>= 1;
-        ++zExp;
-    }
-    zSig = ( ( (uint64_t) aSig )<<32 ) / bSig;
-    if ( ( zSig & 0x3F ) == 0 ) {
-        zSig |= ( (uint64_t) bSig * zSig != ( (uint64_t) aSig )<<32 );
-    }
-    return roundAndPackFloat32(zSign, zExp, zSig, status);
-
-}
 
 /*----------------------------------------------------------------------------
 | Returns the remainder of the single-precision floating-point value `a'
@@ -4153,83 +4173,6 @@ float64 float64_trunc_to_int(float64 a, float_status *status)
     return res;
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of dividing the double-precision floating-point value `a'
-| by the corresponding value `b'.  The operation is performed according to
-| the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float64 float64_div(float64 a, float64 b, float_status *status)
-{
-    flag aSign, bSign, zSign;
-    int aExp, bExp, zExp;
-    uint64_t aSig, bSig, zSig;
-    uint64_t rem0, rem1;
-    uint64_t term0, term1;
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
-        if (aSig) {
-            return propagateFloat64NaN(a, b, status);
-        }
-        if ( bExp == 0x7FF ) {
-            if (bSig) {
-                return propagateFloat64NaN(a, b, status);
-            }
-            float_raise(float_flag_invalid, status);
-            return float64_default_nan(status);
-        }
-        return packFloat64( zSign, 0x7FF, 0 );
-    }
-    if ( bExp == 0x7FF ) {
-        if (bSig) {
-            return propagateFloat64NaN(a, b, status);
-        }
-        return packFloat64( zSign, 0, 0 );
-    }
-    if ( bExp == 0 ) {
-        if ( bSig == 0 ) {
-            if ( ( aExp | aSig ) == 0 ) {
-                float_raise(float_flag_invalid, status);
-                return float64_default_nan(status);
-            }
-            float_raise(float_flag_divbyzero, status);
-            return packFloat64( zSign, 0x7FF, 0 );
-        }
-        normalizeFloat64Subnormal( bSig, &bExp, &bSig );
-    }
-    if ( aExp == 0 ) {
-        if ( aSig == 0 ) return packFloat64( zSign, 0, 0 );
-        normalizeFloat64Subnormal( aSig, &aExp, &aSig );
-    }
-    zExp = aExp - bExp + 0x3FD;
-    aSig = ( aSig | LIT64( 0x0010000000000000 ) )<<10;
-    bSig = ( bSig | LIT64( 0x0010000000000000 ) )<<11;
-    if ( bSig <= ( aSig + aSig ) ) {
-        aSig >>= 1;
-        ++zExp;
-    }
-    zSig = estimateDiv128To64( aSig, 0, bSig );
-    if ( ( zSig & 0x1FF ) <= 2 ) {
-        mul64To128( bSig, zSig, &term0, &term1 );
-        sub128( aSig, 0, term0, term1, &rem0, &rem1 );
-        while ( (int64_t) rem0 < 0 ) {
-            --zSig;
-            add128( rem0, rem1, 0, bSig, &rem0, &rem1 );
-        }
-        zSig |= ( rem1 != 0 );
-    }
-    return roundAndPackFloat64(zSign, zExp, zSig, status);
-
-}
 
 /*----------------------------------------------------------------------------
 | Returns the remainder of the double-precision floating-point value `a'
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index cfee28061e..335f199bb6 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -322,6 +322,7 @@ float64 float16_to_float64(float16 a, flag ieee, float_status *status);
 float16 float16_add(float16, float16, float_status *status);
 float16 float16_sub(float16, float16, float_status *status);
 float16 float16_mul(float16, float16, float_status *status);
+float16 float16_div(float16, float16, float_status *status);
 
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
-- 
2.15.1
