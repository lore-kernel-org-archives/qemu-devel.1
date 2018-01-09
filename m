Received: from eggs.gnu.org ([2001:4830:134:3::10]:53760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYt15-0002af-TE
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYt11-0002AS-Q8
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:31 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYt11-00029k-Gg
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:27 -0500
Received: by mail-wr0-x244.google.com with SMTP id b76so13921202wrd.3
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 04:28:27 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Jan 2018 12:22:47 +0000
Message-Id: <20180109122252.17670-16-alex.bennee@linaro.org>
In-Reply-To: <20180109122252.17670-1-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 15/20] fpu/softfloat: re-factor round_to_int
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

We can now add float16_round_to_int and use the common round_decomposed and
canonicalize functions to have a single implementation for
float16/32/64 round_to_int functions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c         | 304 ++++++++++++++++++++----------------------------
 include/fpu/softfloat.h |   1 +
 2 files changed, 130 insertions(+), 175 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 84386f354b..edc35300d1 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1183,6 +1183,135 @@ float64 float64_div(float64 a, float64 b, float_status *status)
     return float64_round_pack_canonical(pr, status);
 }
 
+/*
+ * Rounds the floating-point value `a' to an integer, and returns the
+ * result as a floating-point value. The operation is performed
+ * according to the IEC/IEEE Standard for Binary Floating-Point
+ * Arithmetic.
+ */
+
+static decomposed_parts round_decomposed(decomposed_parts a, int rounding_mode,
+                                         float_status *s)
+{
+
+    switch (a.cls) {
+    case float_class_snan:
+        a.cls = s->default_nan_mode ? float_class_dnan : float_class_msnan;
+        s->float_exception_flags |= float_flag_invalid;
+        break;
+    case float_class_zero:
+    case float_class_inf:
+    case float_class_qnan:
+        /* already "integral" */
+        break;
+    case float_class_normal:
+        if (a.exp >= DECOMPOSED_BINARY_POINT) {
+            /* already integral */
+            break;
+        }
+        if (a.exp < 0) {
+            bool one;
+            /* all fractional */
+            s->float_exception_flags |= float_flag_inexact;
+            switch (rounding_mode) {
+            case float_round_nearest_even:
+                one = a.exp == -1 && a.frac > DECOMPOSED_IMPLICIT_BIT;
+                break;
+            case float_round_ties_away:
+                one = a.exp == -1 && a.frac >= DECOMPOSED_IMPLICIT_BIT;
+                break;
+            case float_round_to_zero:
+                one = false;
+                break;
+            case float_round_up:
+                one = !a.sign;
+                break;
+            case float_round_down:
+                one = a.sign;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+
+            if (one) {
+                a.frac = DECOMPOSED_IMPLICIT_BIT;
+                a.exp = 0;
+            } else {
+                a.cls = float_class_zero;
+            }
+        } else {
+            uint64_t frac_lsb, frac_lsbm1, round_mask, roundeven_mask, inc;
+
+            frac_lsb = DECOMPOSED_IMPLICIT_BIT >> a.exp;
+            frac_lsbm1 = frac_lsb >> 1;
+            roundeven_mask = (frac_lsb - 1) | frac_lsb;
+            round_mask = roundeven_mask >> 1;
+
+            switch (rounding_mode) {
+            case float_round_nearest_even:
+                inc = ((a.frac & roundeven_mask) != frac_lsbm1 ? frac_lsbm1 : 0);
+                break;
+            case float_round_ties_away:
+                inc = frac_lsbm1;
+                break;
+            case float_round_to_zero:
+                inc = 0;
+                break;
+            case float_round_up:
+                inc = a.sign ? 0 : round_mask;
+                break;
+            case float_round_down:
+                inc = a.sign ? round_mask : 0;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+
+            if (a.frac & round_mask) {
+                s->float_exception_flags |= float_flag_inexact;
+                a.frac += inc;
+                a.frac &= ~round_mask;
+                if (a.frac & DECOMPOSED_OVERFLOW_BIT) {
+                    a.frac >>= 1;
+                    a.exp++;
+                }
+            }
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return a;
+}
+
+float16 float16_round_to_int(float16 a, float_status *s)
+{
+    decomposed_parts pa = float16_unpack_canonical(a, s);
+    decomposed_parts pr = round_decomposed(pa, s->float_rounding_mode, s);
+    return float16_round_pack_canonical(pr, s);
+}
+
+float32 float32_round_to_int(float32 a, float_status *s)
+{
+    decomposed_parts pa = float32_unpack_canonical(a, s);
+    decomposed_parts pr = round_decomposed(pa, s->float_rounding_mode, s);
+    return float32_round_pack_canonical(pr, s);
+}
+
+float64 float64_round_to_int(float64 a, float_status *s)
+{
+    decomposed_parts pa = float64_unpack_canonical(a, s);
+    decomposed_parts pr = round_decomposed(pa, s->float_rounding_mode, s);
+    return float64_round_pack_canonical(pr, s);
+}
+
+float64 float64_trunc_to_int(float64 a, float_status *s)
+{
+    decomposed_parts pa = float64_unpack_canonical(a, s);
+    decomposed_parts pr = round_decomposed(pa, float_round_to_zero, s);
+    return float64_round_pack_canonical(pr, s);
+}
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
@@ -2913,88 +3042,6 @@ float128 float32_to_float128(float32 a, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Rounds the single-precision floating-point value `a' to an integer, and
-| returns the result as a single-precision floating-point value.  The
-| operation is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float32 float32_round_to_int(float32 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    uint32_t lastBitMask, roundBitsMask;
-    uint32_t z;
-    a = float32_squash_input_denormal(a, status);
-
-    aExp = extractFloat32Exp( a );
-    if ( 0x96 <= aExp ) {
-        if ( ( aExp == 0xFF ) && extractFloat32Frac( a ) ) {
-            return propagateFloat32NaN(a, a, status);
-        }
-        return a;
-    }
-    if ( aExp <= 0x7E ) {
-        if ( (uint32_t) ( float32_val(a)<<1 ) == 0 ) return a;
-        status->float_exception_flags |= float_flag_inexact;
-        aSign = extractFloat32Sign( a );
-        switch (status->float_rounding_mode) {
-         case float_round_nearest_even:
-            if ( ( aExp == 0x7E ) && extractFloat32Frac( a ) ) {
-                return packFloat32( aSign, 0x7F, 0 );
-            }
-            break;
-        case float_round_ties_away:
-            if (aExp == 0x7E) {
-                return packFloat32(aSign, 0x7F, 0);
-            }
-            break;
-         case float_round_down:
-            return make_float32(aSign ? 0xBF800000 : 0);
-         case float_round_up:
-            return make_float32(aSign ? 0x80000000 : 0x3F800000);
-        }
-        return packFloat32( aSign, 0, 0 );
-    }
-    lastBitMask = 1;
-    lastBitMask <<= 0x96 - aExp;
-    roundBitsMask = lastBitMask - 1;
-    z = float32_val(a);
-    switch (status->float_rounding_mode) {
-    case float_round_nearest_even:
-        z += lastBitMask>>1;
-        if ((z & roundBitsMask) == 0) {
-            z &= ~lastBitMask;
-        }
-        break;
-    case float_round_ties_away:
-        z += lastBitMask >> 1;
-        break;
-    case float_round_to_zero:
-        break;
-    case float_round_up:
-        if (!extractFloat32Sign(make_float32(z))) {
-            z += roundBitsMask;
-        }
-        break;
-    case float_round_down:
-        if (extractFloat32Sign(make_float32(z))) {
-            z += roundBitsMask;
-        }
-        break;
-    default:
-        abort();
-    }
-    z &= ~ roundBitsMask;
-    if (z != float32_val(a)) {
-        status->float_exception_flags |= float_flag_inexact;
-    }
-    return make_float32(z);
-
-}
-
-
 
 
 /*----------------------------------------------------------------------------
@@ -4140,99 +4187,6 @@ float128 float64_to_float128(float64 a, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Rounds the double-precision floating-point value `a' to an integer, and
-| returns the result as a double-precision floating-point value.  The
-| operation is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float64 float64_round_to_int(float64 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    uint64_t lastBitMask, roundBitsMask;
-    uint64_t z;
-    a = float64_squash_input_denormal(a, status);
-
-    aExp = extractFloat64Exp( a );
-    if ( 0x433 <= aExp ) {
-        if ( ( aExp == 0x7FF ) && extractFloat64Frac( a ) ) {
-            return propagateFloat64NaN(a, a, status);
-        }
-        return a;
-    }
-    if ( aExp < 0x3FF ) {
-        if ( (uint64_t) ( float64_val(a)<<1 ) == 0 ) return a;
-        status->float_exception_flags |= float_flag_inexact;
-        aSign = extractFloat64Sign( a );
-        switch (status->float_rounding_mode) {
-         case float_round_nearest_even:
-            if ( ( aExp == 0x3FE ) && extractFloat64Frac( a ) ) {
-                return packFloat64( aSign, 0x3FF, 0 );
-            }
-            break;
-        case float_round_ties_away:
-            if (aExp == 0x3FE) {
-                return packFloat64(aSign, 0x3ff, 0);
-            }
-            break;
-         case float_round_down:
-            return make_float64(aSign ? LIT64( 0xBFF0000000000000 ) : 0);
-         case float_round_up:
-            return make_float64(
-            aSign ? LIT64( 0x8000000000000000 ) : LIT64( 0x3FF0000000000000 ));
-        }
-        return packFloat64( aSign, 0, 0 );
-    }
-    lastBitMask = 1;
-    lastBitMask <<= 0x433 - aExp;
-    roundBitsMask = lastBitMask - 1;
-    z = float64_val(a);
-    switch (status->float_rounding_mode) {
-    case float_round_nearest_even:
-        z += lastBitMask >> 1;
-        if ((z & roundBitsMask) == 0) {
-            z &= ~lastBitMask;
-        }
-        break;
-    case float_round_ties_away:
-        z += lastBitMask >> 1;
-        break;
-    case float_round_to_zero:
-        break;
-    case float_round_up:
-        if (!extractFloat64Sign(make_float64(z))) {
-            z += roundBitsMask;
-        }
-        break;
-    case float_round_down:
-        if (extractFloat64Sign(make_float64(z))) {
-            z += roundBitsMask;
-        }
-        break;
-    default:
-        abort();
-    }
-    z &= ~ roundBitsMask;
-    if (z != float64_val(a)) {
-        status->float_exception_flags |= float_flag_inexact;
-    }
-    return make_float64(z);
-
-}
-
-float64 float64_trunc_to_int(float64 a, float_status *status)
-{
-    int oldmode;
-    float64 res;
-    oldmode = status->float_rounding_mode;
-    status->float_rounding_mode = float_round_to_zero;
-    res = float64_round_to_int(a, status);
-    status->float_rounding_mode = oldmode;
-    return res;
-}
-
 
 /*----------------------------------------------------------------------------
 | Returns the remainder of the double-precision floating-point value `a'
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index c92147abec..6427762a9a 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -319,6 +319,7 @@ float64 float16_to_float64(float16 a, flag ieee, float_status *status);
 | Software half-precision operations.
 *----------------------------------------------------------------------------*/
 
+float16 float16_round_to_int(float16, float_status *status);
 float16 float16_add(float16, float16, float_status *status);
 float16 float16_sub(float16, float16, float_status *status);
 float16 float16_mul(float16, float16, float_status *status);
-- 
2.15.1
