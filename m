Received: from eggs.gnu.org ([2001:4830:134:3::10]:37316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSK5-000160-Mt
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSK3-0002LZ-Oa
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:12:29 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:40457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eoSK3-0002L7-Fs
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:12:27 -0500
Received: by mail-wr0-x242.google.com with SMTP id o76so3326904wrb.7
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 03:12:27 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Feb 2018 11:05:22 +0000
Message-Id: <20180221110523.859-23-alex.bennee@linaro.org>
In-Reply-To: <20180221110523.859-1-alex.bennee@linaro.org>
References: <20180221110523.859-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/22] fpu/softfloat: re-factor sqrt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

This is a little bit of a departure from softfloat's original approach
as we skip the estimate step in favour of a straight iteration. There
is a minor optimisation to avoid calculating more bits of precision
than we need however this still brings a performance drop, especially
for float64 operations.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 4bc425d7e4..e7fb0d357a 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1896,6 +1896,102 @@ float64 float64_scalbn(float64 a, int n, float_status *status)
     return float64_round_pack_canonical(pr, status);
 }
 
+/*
+ * Square Root
+ *
+ * The old softfloat code did an approximation step before zeroing in
+ * on the final result. However for simpleness we just compute the
+ * square root by iterating down from the implicit bit to enough extra
+ * bits to ensure we get a correctly rounded result.
+ *
+ * This does mean however the calculation is slower than before,
+ * especially for 64 bit floats.
+ */
+
+static FloatParts sqrt_float(FloatParts a, float_status *s, const FloatFmt *p)
+{
+    uint64_t a_frac, r_frac, s_frac;
+    int bit, last_bit;
+
+    if (is_nan(a.cls)) {
+        return return_nan(a, s);
+    }
+    if (a.cls == float_class_zero) {
+        return a;  /* sqrt(+-0) = +-0 */
+    }
+    if (a.sign) {
+        s->float_exception_flags |= float_flag_invalid;
+        a.cls = float_class_dnan;
+        return a;
+    }
+    if (a.cls == float_class_inf) {
+        return a;  /* sqrt(+inf) = +inf */
+    }
+
+    assert(a.cls == float_class_normal);
+
+    /* We need two overflow bits at the top. Adding room for that is a
+     * right shift. If the exponent is odd, we can discard the low bit
+     * by multiplying the fraction by 2; that's a left shift. Combine
+     * those and we shift right if the exponent is even.
+     */
+    a_frac = a.frac;
+    if (!(a.exp & 1)) {
+        a_frac >>= 1;
+    }
+    a.exp >>= 1;
+
+    /* Bit-by-bit computation of sqrt.  */
+    r_frac = 0;
+    s_frac = 0;
+
+    /* Iterate from implicit bit down to the 3 extra bits to compute a
+     * properly rounded result. Remember we've inserted one more bit
+     * at the top, so these positions are one less.
+     */
+    bit = DECOMPOSED_BINARY_POINT - 1;
+    last_bit = MAX(p->frac_shift - 4, 0);
+    do {
+        uint64_t q = 1ULL << bit;
+        uint64_t t_frac = s_frac + q;
+        if (t_frac <= a_frac) {
+            s_frac = t_frac + q;
+            a_frac -= t_frac;
+            r_frac += q;
+        }
+        a_frac <<= 1;
+    } while (--bit >= last_bit);
+
+    /* Undo the right shift done above. If there is any remaining
+     * fraction, the result is inexact. Set the sticky bit.
+     */
+    a.frac = (r_frac << 1) + (a_frac != 0);
+
+    return a;
+}
+
+float16 __attribute__((flatten)) float16_sqrt(float16 a, float_status *status)
+{
+    FloatParts pa = float16_unpack_canonical(a, status);
+    FloatParts pr = sqrt_float(pa, status, &float16_params);
+    return float16_round_pack_canonical(pr, status);
+}
+
+float32 __attribute__((flatten)) float32_sqrt(float32 a, float_status *status)
+{
+    FloatParts pa = float32_unpack_canonical(a, status);
+    FloatParts pr = sqrt_float(pa, status, &float32_params);
+    return float32_round_pack_canonical(pr, status);
+}
+
+float64 __attribute__((flatten)) float64_sqrt(float64 a, float_status *status)
+{
+    FloatParts pa = float64_unpack_canonical(a, status);
+    FloatParts pr = sqrt_float(pa, status, &float64_params);
+    return float64_round_pack_canonical(pr, status);
+}
+
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
@@ -3303,62 +3399,6 @@ float32 float32_rem(float32 a, float32 b, float_status *status)
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
 
 /*----------------------------------------------------------------------------
 | Returns the binary exponential of the single-precision floating-point value
@@ -4202,61 +4242,6 @@ float64 float64_rem(float64 a, float64 b, float_status *status)
 
 }
 
-
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
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index cebe37b716..9b7b5e34e2 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -251,6 +251,7 @@ float16 float16_minnum(float16, float16, float_status *status);
 float16 float16_maxnum(float16, float16, float_status *status);
 float16 float16_minnummag(float16, float16, float_status *status);
 float16 float16_maxnummag(float16, float16, float_status *status);
+float16 float16_sqrt(float16, float_status *status);
 int float16_compare(float16, float16, float_status *status);
 int float16_compare_quiet(float16, float16, float_status *status);
 
-- 
2.15.1
