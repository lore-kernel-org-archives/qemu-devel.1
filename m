Received: from eggs.gnu.org ([2001:4830:134:3::10]:51537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsvy-0006mC-LQ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsvv-00072D-1b
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:14 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:47025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYsvu-0006zp-Kr
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:10 -0500
Received: by mail-wr0-x243.google.com with SMTP id g21so8109890wrb.13
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 04:23:10 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Jan 2018 12:22:46 +0000
Message-Id: <20180109122252.17670-15-alex.bennee@linaro.org>
In-Reply-To: <20180109122252.17670-1-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 14/20] fpu/softfloat: re-factor muladd
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

We can now add float16_muladd and use the common decompose and
canonicalize functions to have a single implementation for
float16/32/64 muladd functions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 104 -------
 fpu/softfloat.c            | 756 +++++++++++++++++----------------------------
 include/fpu/softfloat.h    |   1 +
 3 files changed, 286 insertions(+), 575 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 3d507d8c77..98fb0e7001 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -729,58 +729,6 @@ static float32 propagateFloat32NaN(float32 a, float32 b, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
-| Takes three single-precision floating-point values `a', `b' and `c', one of
-| which is a NaN, and returns the appropriate NaN result.  If any of  `a',
-| `b' or `c' is a signaling NaN, the invalid exception is raised.
-| The input infzero indicates whether a*b was 0*inf or inf*0 (in which case
-| obviously c is a NaN, and whether to propagate c or some other NaN is
-| implementation defined).
-*----------------------------------------------------------------------------*/
-
-static float32 propagateFloat32MulAddNaN(float32 a, float32 b,
-                                         float32 c, flag infzero,
-                                         float_status *status)
-{
-    flag aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN,
-        cIsQuietNaN, cIsSignalingNaN;
-    int which;
-
-    aIsQuietNaN = float32_is_quiet_nan(a, status);
-    aIsSignalingNaN = float32_is_signaling_nan(a, status);
-    bIsQuietNaN = float32_is_quiet_nan(b, status);
-    bIsSignalingNaN = float32_is_signaling_nan(b, status);
-    cIsQuietNaN = float32_is_quiet_nan(c, status);
-    cIsSignalingNaN = float32_is_signaling_nan(c, status);
-
-    if (aIsSignalingNaN | bIsSignalingNaN | cIsSignalingNaN) {
-        float_raise(float_flag_invalid, status);
-    }
-
-    which = pickNaNMulAdd(aIsQuietNaN, aIsSignalingNaN,
-                          bIsQuietNaN, bIsSignalingNaN,
-                          cIsQuietNaN, cIsSignalingNaN, infzero, status);
-
-    if (status->default_nan_mode) {
-        /* Note that this check is after pickNaNMulAdd so that function
-         * has an opportunity to set the Invalid flag.
-         */
-        return float32_default_nan(status);
-    }
-
-    switch (which) {
-    case 0:
-        return float32_maybe_silence_nan(a, status);
-    case 1:
-        return float32_maybe_silence_nan(b, status);
-    case 2:
-        return float32_maybe_silence_nan(c, status);
-    case 3:
-    default:
-        return float32_default_nan(status);
-    }
-}
-
 #ifdef NO_SIGNALING_NANS
 int float64_is_quiet_nan(float64 a_, float_status *status)
 {
@@ -936,58 +884,6 @@ static float64 propagateFloat64NaN(float64 a, float64 b, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
-| Takes three double-precision floating-point values `a', `b' and `c', one of
-| which is a NaN, and returns the appropriate NaN result.  If any of  `a',
-| `b' or `c' is a signaling NaN, the invalid exception is raised.
-| The input infzero indicates whether a*b was 0*inf or inf*0 (in which case
-| obviously c is a NaN, and whether to propagate c or some other NaN is
-| implementation defined).
-*----------------------------------------------------------------------------*/
-
-static float64 propagateFloat64MulAddNaN(float64 a, float64 b,
-                                         float64 c, flag infzero,
-                                         float_status *status)
-{
-    flag aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN,
-        cIsQuietNaN, cIsSignalingNaN;
-    int which;
-
-    aIsQuietNaN = float64_is_quiet_nan(a, status);
-    aIsSignalingNaN = float64_is_signaling_nan(a, status);
-    bIsQuietNaN = float64_is_quiet_nan(b, status);
-    bIsSignalingNaN = float64_is_signaling_nan(b, status);
-    cIsQuietNaN = float64_is_quiet_nan(c, status);
-    cIsSignalingNaN = float64_is_signaling_nan(c, status);
-
-    if (aIsSignalingNaN | bIsSignalingNaN | cIsSignalingNaN) {
-        float_raise(float_flag_invalid, status);
-    }
-
-    which = pickNaNMulAdd(aIsQuietNaN, aIsSignalingNaN,
-                          bIsQuietNaN, bIsSignalingNaN,
-                          cIsQuietNaN, cIsSignalingNaN, infzero, status);
-
-    if (status->default_nan_mode) {
-        /* Note that this check is after pickNaNMulAdd so that function
-         * has an opportunity to set the Invalid flag.
-         */
-        return float64_default_nan(status);
-    }
-
-    switch (which) {
-    case 0:
-        return float64_maybe_silence_nan(a, status);
-    case 1:
-        return float64_maybe_silence_nan(b, status);
-    case 2:
-        return float64_maybe_silence_nan(c, status);
-    case 3:
-    default:
-        return float64_default_nan(status);
-    }
-}
-
 #ifdef NO_SIGNALING_NANS
 int floatx80_is_quiet_nan(floatx80 a_, float_status *status)
 {
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 2b703c12ed..84386f354b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -561,6 +561,50 @@ static decomposed_parts pick_nan_parts(decomposed_parts a, decomposed_parts b,
     return a;
 }
 
+static decomposed_parts pick_nan_muladd_parts(decomposed_parts a,
+                                              decomposed_parts b,
+                                              decomposed_parts c,
+                                              bool inf_zero,
+                                              float_status *s)
+{
+    if (a.cls == float_class_snan
+        ||
+        b.cls == float_class_snan
+        ||
+        c.cls == float_class_snan) {
+        s->float_exception_flags |= float_flag_invalid;
+    }
+
+    if (s->default_nan_mode) {
+        a.cls = float_class_dnan;
+    } else {
+        switch (pickNaNMulAdd(a.cls == float_class_qnan,
+                              a.cls == float_class_snan,
+                              b.cls == float_class_qnan,
+                              b.cls == float_class_snan,
+                              c.cls == float_class_qnan,
+                              c.cls == float_class_snan,
+                              inf_zero, s)) {
+        case 0:
+            break;
+        case 1:
+            a = b;
+            break;
+        case 2:
+            a = c;
+            break;
+        case 3:
+            a.cls = float_class_dnan;
+            return a;
+        default:
+            g_assert_not_reached();
+        }
+
+        a.cls = float_class_msnan;
+    }
+    return a;
+}
+
 
 /*
  * Returns the result of adding the absolute values of the
@@ -809,6 +853,247 @@ float64 float64_mul(float64 a, float64 b, float_status *status)
     return float64_round_pack_canonical(pr, status);
 }
 
+/*
+ * Returns the result of multiplying the floating-point values `a' and
+ * `b' then adding 'c', with no intermediate rounding step after the
+ * multiplication. The operation is performed according to the
+ * IEC/IEEE Standard for Binary Floating-Point Arithmetic 754-2008.
+ * The flags argument allows the caller to select negation of the
+ * addend, the intermediate product, or the final result. (The
+ * difference between this and having the caller do a separate
+ * negation is that negating externally will flip the sign bit on
+ * NaNs.)
+ */
+
+static decomposed_parts muladd_decomposed(decomposed_parts a,
+                                          decomposed_parts b,
+                                          decomposed_parts c, int flags,
+                                          float_status *s)
+{
+    bool inf_zero = ((1 << a.cls) | (1 << b.cls)) ==
+                    ((1 << float_class_inf) | (1 << float_class_zero));
+    bool p_sign;
+    bool sign_flip = flags & float_muladd_negate_result;
+    float_class p_class;
+    uint64_t hi, lo;
+    int p_exp;
+
+    /* It is implementation-defined whether the cases of (0,inf,qnan)
+     * and (inf,0,qnan) raise InvalidOperation or not (and what QNaN
+     * they return if they do), so we have to hand this information
+     * off to the target-specific pick-a-NaN routine.
+     */
+    if (a.cls >= float_class_qnan ||
+        b.cls >= float_class_qnan ||
+        c.cls >= float_class_qnan) {
+        return pick_nan_muladd_parts(a, b, c, inf_zero, s);
+    }
+
+    if (inf_zero) {
+        s->float_exception_flags |= float_flag_invalid;
+        a.cls = float_class_dnan;
+        return a;
+    }
+
+    if (flags & float_muladd_negate_c) {
+        c.sign ^= 1;
+    }
+
+    p_sign = a.sign ^ b.sign;
+
+    if (flags & float_muladd_negate_product) {
+        p_sign ^= 1;
+    }
+
+    if (a.cls == float_class_inf || b.cls == float_class_inf) {
+        p_class = float_class_inf;
+    } else if (a.cls == float_class_zero || b.cls == float_class_zero) {
+        p_class = float_class_zero;
+    } else {
+        p_class = float_class_normal;
+    }
+
+    if (c.cls == float_class_inf) {
+        if (p_class == float_class_inf && p_sign != c.sign) {
+            s->float_exception_flags |= float_flag_invalid;
+            a.cls = float_class_dnan;
+        } else {
+            a.cls = float_class_inf;
+            a.sign = c.sign ^ sign_flip;
+        }
+        return a;
+    }
+
+    if (p_class == float_class_inf) {
+        a.cls = float_class_inf;
+        a.sign = p_sign ^ sign_flip;
+        return a;
+    }
+
+    if (p_class == float_class_zero) {
+        if (c.cls == float_class_zero) {
+            if (p_sign != c.sign) {
+                p_sign = s->float_rounding_mode == float_round_down;
+            }
+            c.sign = p_sign;
+        } else if (flags & float_muladd_halve_result) {
+            c.exp -= 1;
+        }
+        c.sign ^= sign_flip;
+        return c;
+    }
+
+    /* a & b should be normals now... */
+    assert(a.cls == float_class_normal &&
+           b.cls == float_class_normal);
+
+    p_exp = a.exp + b.exp;
+
+    /* Multiply of 2 62-bit numbers produces a (2*62) == 124-bit
+     * result.
+     */
+    mul64To128(a.frac, b.frac, &hi, &lo);
+    /* binary point now at bit 124 */
+
+    /* check for overflow */
+    if (hi & (1ULL << (DECOMPOSED_BINARY_POINT * 2 + 1 - 64))) {
+        shift128RightJamming(hi, lo, 1, &hi, &lo);
+        p_exp += 1;
+    }
+
+    /* + add/sub */
+    if (c.cls == float_class_zero) {
+        /* move binary point back to 62 */
+        shift128RightJamming(hi, lo, DECOMPOSED_BINARY_POINT, &hi, &lo);
+    } else {
+        int exp_diff = p_exp - c.exp;
+        if (p_sign == c.sign) {
+            /* Addition */
+            if (exp_diff <= 0) {
+                shift128RightJamming(hi, lo,
+                                     DECOMPOSED_BINARY_POINT - exp_diff,
+                                     &hi, &lo);
+                lo += c.frac;
+                p_exp = c.exp;
+            } else {
+                uint64_t c_hi, c_lo;
+                /* shift c to the same binary point as the product (124) */
+                c_hi = c.frac >> 2;
+                c_lo = 0;
+                shift128RightJamming(c_hi, c_lo,
+                                     exp_diff,
+                                     &c_hi, &c_lo);
+                add128(hi, lo, c_hi, c_lo, &hi, &lo);
+                /* move binary point back to 62 */
+                shift128RightJamming(hi, lo, DECOMPOSED_BINARY_POINT, &hi, &lo);
+            }
+
+            if (lo & DECOMPOSED_OVERFLOW_BIT) {
+                shift64RightJamming(lo, 1, &lo);
+                p_exp += 1;
+            }
+
+        } else {
+            /* Subtraction */
+            uint64_t c_hi, c_lo;
+            /* make C binary point match product at bit 124 */
+            c_hi = c.frac >> 2;
+            c_lo = 0;
+
+            if (exp_diff <= 0) {
+                shift128RightJamming(hi, lo, -exp_diff, &hi, &lo);
+                if (exp_diff == 0
+                    &&
+                    (hi > c_hi || (hi == c_hi && lo >= c_lo))) {
+                    sub128(hi, lo, c_hi, c_lo, &hi, &lo);
+                } else {
+                    sub128(c_hi, c_lo, hi, lo, &hi, &lo);
+                    p_sign ^= 1;
+                    p_exp = c.exp;
+                }
+            } else {
+                shift128RightJamming(c_hi, c_lo,
+                                     exp_diff,
+                                     &c_hi, &c_lo);
+                sub128(hi, lo, c_hi, c_lo, &hi, &lo);
+            }
+
+            if (hi == 0 && lo == 0) {
+                a.cls = float_class_zero;
+                a.sign = s->float_rounding_mode == float_round_down;
+                a.sign ^= sign_flip;
+                return a;
+            } else {
+                int shift;
+                if (hi != 0) {
+                    shift = clz64(hi);
+                } else {
+                    shift = clz64(lo) + 64;
+                }
+                /* Normalizing to a binary point of 124 is the
+                   correct adjust for the exponent.  However since we're
+                   shifting, we might as well put the binary point back
+                   at 62 where we really want it.  Therefore shift as
+                   if we're leaving 1 bit at the top of the word, but
+                   adjust the exponent as if we're leaving 3 bits.  */
+                shift -= 1;
+                if (shift >= 64) {
+                    lo = lo << (shift - 64);
+                } else {
+                    hi = (hi << shift) | (lo >> (64 - shift));
+                    lo = hi | ((lo << shift) != 0);
+                }
+                p_exp -= shift - 2;
+            }
+        }
+    }
+
+    if (flags & float_muladd_halve_result) {
+        p_exp -= 1;
+    }
+
+    /* finally prepare our result */
+    a.cls = float_class_normal;
+    a.sign = p_sign ^ sign_flip;
+    a.exp = p_exp;
+    a.frac = lo;
+
+    return a;
+}
+
+float16 float16_muladd(float16 a, float16 b, float16 c, int flags,
+                       float_status *status)
+{
+    decomposed_parts pa = float16_unpack_canonical(a, status);
+    decomposed_parts pb = float16_unpack_canonical(b, status);
+    decomposed_parts pc = float16_unpack_canonical(c, status);
+    decomposed_parts pr = muladd_decomposed(pa, pb, pc, flags, status);
+
+    return float16_round_pack_canonical(pr, status);
+}
+
+float32 float32_muladd(float32 a, float32 b, float32 c, int flags,
+                       float_status *status)
+{
+    decomposed_parts pa = float32_unpack_canonical(a, status);
+    decomposed_parts pb = float32_unpack_canonical(b, status);
+    decomposed_parts pc = float32_unpack_canonical(c, status);
+    decomposed_parts pr = muladd_decomposed(pa, pb, pc, flags, status);
+
+    return float32_round_pack_canonical(pr, status);
+}
+
+float64 float64_muladd(float64 a, float64 b, float64 c, int flags,
+                       float_status *status)
+{
+    decomposed_parts pa = float64_unpack_canonical(a, status);
+    decomposed_parts pb = float64_unpack_canonical(b, status);
+    decomposed_parts pc = float64_unpack_canonical(c, status);
+    decomposed_parts pr = muladd_decomposed(pa, pb, pc, flags, status);
+
+    return float64_round_pack_canonical(pr, status);
+}
+
 /*
  * Returns the result of dividing the floating-point value `a' by the
  * corresponding value `b'. The operation is performed according to
@@ -2814,231 +3099,6 @@ float32 float32_rem(float32 a, float32 b, float_status *status)
     return normalizeRoundAndPackFloat32(aSign ^ zSign, bExp, aSig, status);
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of multiplying the single-precision floating-point values
-| `a' and `b' then adding 'c', with no intermediate rounding step after the
-| multiplication.  The operation is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic 754-2008.
-| The flags argument allows the caller to select negation of the
-| addend, the intermediate product, or the final result. (The difference
-| between this and having the caller do a separate negation is that negating
-| externally will flip the sign bit on NaNs.)
-*----------------------------------------------------------------------------*/
-
-float32 float32_muladd(float32 a, float32 b, float32 c, int flags,
-                       float_status *status)
-{
-    flag aSign, bSign, cSign, zSign;
-    int aExp, bExp, cExp, pExp, zExp, expDiff;
-    uint32_t aSig, bSig, cSig;
-    flag pInf, pZero, pSign;
-    uint64_t pSig64, cSig64, zSig64;
-    uint32_t pSig;
-    int shiftcount;
-    flag signflip, infzero;
-
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-    c = float32_squash_input_denormal(c, status);
-    aSig = extractFloat32Frac(a);
-    aExp = extractFloat32Exp(a);
-    aSign = extractFloat32Sign(a);
-    bSig = extractFloat32Frac(b);
-    bExp = extractFloat32Exp(b);
-    bSign = extractFloat32Sign(b);
-    cSig = extractFloat32Frac(c);
-    cExp = extractFloat32Exp(c);
-    cSign = extractFloat32Sign(c);
-
-    infzero = ((aExp == 0 && aSig == 0 && bExp == 0xff && bSig == 0) ||
-               (aExp == 0xff && aSig == 0 && bExp == 0 && bSig == 0));
-
-    /* It is implementation-defined whether the cases of (0,inf,qnan)
-     * and (inf,0,qnan) raise InvalidOperation or not (and what QNaN
-     * they return if they do), so we have to hand this information
-     * off to the target-specific pick-a-NaN routine.
-     */
-    if (((aExp == 0xff) && aSig) ||
-        ((bExp == 0xff) && bSig) ||
-        ((cExp == 0xff) && cSig)) {
-        return propagateFloat32MulAddNaN(a, b, c, infzero, status);
-    }
-
-    if (infzero) {
-        float_raise(float_flag_invalid, status);
-        return float32_default_nan(status);
-    }
-
-    if (flags & float_muladd_negate_c) {
-        cSign ^= 1;
-    }
-
-    signflip = (flags & float_muladd_negate_result) ? 1 : 0;
-
-    /* Work out the sign and type of the product */
-    pSign = aSign ^ bSign;
-    if (flags & float_muladd_negate_product) {
-        pSign ^= 1;
-    }
-    pInf = (aExp == 0xff) || (bExp == 0xff);
-    pZero = ((aExp | aSig) == 0) || ((bExp | bSig) == 0);
-
-    if (cExp == 0xff) {
-        if (pInf && (pSign ^ cSign)) {
-            /* addition of opposite-signed infinities => InvalidOperation */
-            float_raise(float_flag_invalid, status);
-            return float32_default_nan(status);
-        }
-        /* Otherwise generate an infinity of the same sign */
-        return packFloat32(cSign ^ signflip, 0xff, 0);
-    }
-
-    if (pInf) {
-        return packFloat32(pSign ^ signflip, 0xff, 0);
-    }
-
-    if (pZero) {
-        if (cExp == 0) {
-            if (cSig == 0) {
-                /* Adding two exact zeroes */
-                if (pSign == cSign) {
-                    zSign = pSign;
-                } else if (status->float_rounding_mode == float_round_down) {
-                    zSign = 1;
-                } else {
-                    zSign = 0;
-                }
-                return packFloat32(zSign ^ signflip, 0, 0);
-            }
-            /* Exact zero plus a denorm */
-            if (status->flush_to_zero) {
-                float_raise(float_flag_output_denormal, status);
-                return packFloat32(cSign ^ signflip, 0, 0);
-            }
-        }
-        /* Zero plus something non-zero : just return the something */
-        if (flags & float_muladd_halve_result) {
-            if (cExp == 0) {
-                normalizeFloat32Subnormal(cSig, &cExp, &cSig);
-            }
-            /* Subtract one to halve, and one again because roundAndPackFloat32
-             * wants one less than the true exponent.
-             */
-            cExp -= 2;
-            cSig = (cSig | 0x00800000) << 7;
-            return roundAndPackFloat32(cSign ^ signflip, cExp, cSig, status);
-        }
-        return packFloat32(cSign ^ signflip, cExp, cSig);
-    }
-
-    if (aExp == 0) {
-        normalizeFloat32Subnormal(aSig, &aExp, &aSig);
-    }
-    if (bExp == 0) {
-        normalizeFloat32Subnormal(bSig, &bExp, &bSig);
-    }
-
-    /* Calculate the actual result a * b + c */
-
-    /* Multiply first; this is easy. */
-    /* NB: we subtract 0x7e where float32_mul() subtracts 0x7f
-     * because we want the true exponent, not the "one-less-than"
-     * flavour that roundAndPackFloat32() takes.
-     */
-    pExp = aExp + bExp - 0x7e;
-    aSig = (aSig | 0x00800000) << 7;
-    bSig = (bSig | 0x00800000) << 8;
-    pSig64 = (uint64_t)aSig * bSig;
-    if ((int64_t)(pSig64 << 1) >= 0) {
-        pSig64 <<= 1;
-        pExp--;
-    }
-
-    zSign = pSign ^ signflip;
-
-    /* Now pSig64 is the significand of the multiply, with the explicit bit in
-     * position 62.
-     */
-    if (cExp == 0) {
-        if (!cSig) {
-            /* Throw out the special case of c being an exact zero now */
-            shift64RightJamming(pSig64, 32, &pSig64);
-            pSig = pSig64;
-            if (flags & float_muladd_halve_result) {
-                pExp--;
-            }
-            return roundAndPackFloat32(zSign, pExp - 1,
-                                       pSig, status);
-        }
-        normalizeFloat32Subnormal(cSig, &cExp, &cSig);
-    }
-
-    cSig64 = (uint64_t)cSig << (62 - 23);
-    cSig64 |= LIT64(0x4000000000000000);
-    expDiff = pExp - cExp;
-
-    if (pSign == cSign) {
-        /* Addition */
-        if (expDiff > 0) {
-            /* scale c to match p */
-            shift64RightJamming(cSig64, expDiff, &cSig64);
-            zExp = pExp;
-        } else if (expDiff < 0) {
-            /* scale p to match c */
-            shift64RightJamming(pSig64, -expDiff, &pSig64);
-            zExp = cExp;
-        } else {
-            /* no scaling needed */
-            zExp = cExp;
-        }
-        /* Add significands and make sure explicit bit ends up in posn 62 */
-        zSig64 = pSig64 + cSig64;
-        if ((int64_t)zSig64 < 0) {
-            shift64RightJamming(zSig64, 1, &zSig64);
-        } else {
-            zExp--;
-        }
-    } else {
-        /* Subtraction */
-        if (expDiff > 0) {
-            shift64RightJamming(cSig64, expDiff, &cSig64);
-            zSig64 = pSig64 - cSig64;
-            zExp = pExp;
-        } else if (expDiff < 0) {
-            shift64RightJamming(pSig64, -expDiff, &pSig64);
-            zSig64 = cSig64 - pSig64;
-            zExp = cExp;
-            zSign ^= 1;
-        } else {
-            zExp = pExp;
-            if (cSig64 < pSig64) {
-                zSig64 = pSig64 - cSig64;
-            } else if (pSig64 < cSig64) {
-                zSig64 = cSig64 - pSig64;
-                zSign ^= 1;
-            } else {
-                /* Exact zero */
-                zSign = signflip;
-                if (status->float_rounding_mode == float_round_down) {
-                    zSign ^= 1;
-                }
-                return packFloat32(zSign, 0, 0);
-            }
-        }
-        --zExp;
-        /* Normalize to put the explicit bit back into bit 62. */
-        shiftcount = countLeadingZeros64(zSig64) - 1;
-        zSig64 <<= shiftcount;
-        zExp -= shiftcount;
-    }
-    if (flags & float_muladd_halve_result) {
-        zExp--;
-    }
-
-    shift64RightJamming(zSig64, 32, &zSig64);
-    return roundAndPackFloat32(zSign, zExp, zSig64, status);
-}
-
 
 /*----------------------------------------------------------------------------
 | Returns the square root of the single-precision floating-point value `a'.
@@ -4262,252 +4322,6 @@ float64 float64_rem(float64 a, float64 b, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of multiplying the double-precision floating-point values
-| `a' and `b' then adding 'c', with no intermediate rounding step after the
-| multiplication.  The operation is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic 754-2008.
-| The flags argument allows the caller to select negation of the
-| addend, the intermediate product, or the final result. (The difference
-| between this and having the caller do a separate negation is that negating
-| externally will flip the sign bit on NaNs.)
-*----------------------------------------------------------------------------*/
-
-float64 float64_muladd(float64 a, float64 b, float64 c, int flags,
-                       float_status *status)
-{
-    flag aSign, bSign, cSign, zSign;
-    int aExp, bExp, cExp, pExp, zExp, expDiff;
-    uint64_t aSig, bSig, cSig;
-    flag pInf, pZero, pSign;
-    uint64_t pSig0, pSig1, cSig0, cSig1, zSig0, zSig1;
-    int shiftcount;
-    flag signflip, infzero;
-
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-    c = float64_squash_input_denormal(c, status);
-    aSig = extractFloat64Frac(a);
-    aExp = extractFloat64Exp(a);
-    aSign = extractFloat64Sign(a);
-    bSig = extractFloat64Frac(b);
-    bExp = extractFloat64Exp(b);
-    bSign = extractFloat64Sign(b);
-    cSig = extractFloat64Frac(c);
-    cExp = extractFloat64Exp(c);
-    cSign = extractFloat64Sign(c);
-
-    infzero = ((aExp == 0 && aSig == 0 && bExp == 0x7ff && bSig == 0) ||
-               (aExp == 0x7ff && aSig == 0 && bExp == 0 && bSig == 0));
-
-    /* It is implementation-defined whether the cases of (0,inf,qnan)
-     * and (inf,0,qnan) raise InvalidOperation or not (and what QNaN
-     * they return if they do), so we have to hand this information
-     * off to the target-specific pick-a-NaN routine.
-     */
-    if (((aExp == 0x7ff) && aSig) ||
-        ((bExp == 0x7ff) && bSig) ||
-        ((cExp == 0x7ff) && cSig)) {
-        return propagateFloat64MulAddNaN(a, b, c, infzero, status);
-    }
-
-    if (infzero) {
-        float_raise(float_flag_invalid, status);
-        return float64_default_nan(status);
-    }
-
-    if (flags & float_muladd_negate_c) {
-        cSign ^= 1;
-    }
-
-    signflip = (flags & float_muladd_negate_result) ? 1 : 0;
-
-    /* Work out the sign and type of the product */
-    pSign = aSign ^ bSign;
-    if (flags & float_muladd_negate_product) {
-        pSign ^= 1;
-    }
-    pInf = (aExp == 0x7ff) || (bExp == 0x7ff);
-    pZero = ((aExp | aSig) == 0) || ((bExp | bSig) == 0);
-
-    if (cExp == 0x7ff) {
-        if (pInf && (pSign ^ cSign)) {
-            /* addition of opposite-signed infinities => InvalidOperation */
-            float_raise(float_flag_invalid, status);
-            return float64_default_nan(status);
-        }
-        /* Otherwise generate an infinity of the same sign */
-        return packFloat64(cSign ^ signflip, 0x7ff, 0);
-    }
-
-    if (pInf) {
-        return packFloat64(pSign ^ signflip, 0x7ff, 0);
-    }
-
-    if (pZero) {
-        if (cExp == 0) {
-            if (cSig == 0) {
-                /* Adding two exact zeroes */
-                if (pSign == cSign) {
-                    zSign = pSign;
-                } else if (status->float_rounding_mode == float_round_down) {
-                    zSign = 1;
-                } else {
-                    zSign = 0;
-                }
-                return packFloat64(zSign ^ signflip, 0, 0);
-            }
-            /* Exact zero plus a denorm */
-            if (status->flush_to_zero) {
-                float_raise(float_flag_output_denormal, status);
-                return packFloat64(cSign ^ signflip, 0, 0);
-            }
-        }
-        /* Zero plus something non-zero : just return the something */
-        if (flags & float_muladd_halve_result) {
-            if (cExp == 0) {
-                normalizeFloat64Subnormal(cSig, &cExp, &cSig);
-            }
-            /* Subtract one to halve, and one again because roundAndPackFloat64
-             * wants one less than the true exponent.
-             */
-            cExp -= 2;
-            cSig = (cSig | 0x0010000000000000ULL) << 10;
-            return roundAndPackFloat64(cSign ^ signflip, cExp, cSig, status);
-        }
-        return packFloat64(cSign ^ signflip, cExp, cSig);
-    }
-
-    if (aExp == 0) {
-        normalizeFloat64Subnormal(aSig, &aExp, &aSig);
-    }
-    if (bExp == 0) {
-        normalizeFloat64Subnormal(bSig, &bExp, &bSig);
-    }
-
-    /* Calculate the actual result a * b + c */
-
-    /* Multiply first; this is easy. */
-    /* NB: we subtract 0x3fe where float64_mul() subtracts 0x3ff
-     * because we want the true exponent, not the "one-less-than"
-     * flavour that roundAndPackFloat64() takes.
-     */
-    pExp = aExp + bExp - 0x3fe;
-    aSig = (aSig | LIT64(0x0010000000000000))<<10;
-    bSig = (bSig | LIT64(0x0010000000000000))<<11;
-    mul64To128(aSig, bSig, &pSig0, &pSig1);
-    if ((int64_t)(pSig0 << 1) >= 0) {
-        shortShift128Left(pSig0, pSig1, 1, &pSig0, &pSig1);
-        pExp--;
-    }
-
-    zSign = pSign ^ signflip;
-
-    /* Now [pSig0:pSig1] is the significand of the multiply, with the explicit
-     * bit in position 126.
-     */
-    if (cExp == 0) {
-        if (!cSig) {
-            /* Throw out the special case of c being an exact zero now */
-            shift128RightJamming(pSig0, pSig1, 64, &pSig0, &pSig1);
-            if (flags & float_muladd_halve_result) {
-                pExp--;
-            }
-            return roundAndPackFloat64(zSign, pExp - 1,
-                                       pSig1, status);
-        }
-        normalizeFloat64Subnormal(cSig, &cExp, &cSig);
-    }
-
-    /* Shift cSig and add the explicit bit so [cSig0:cSig1] is the
-     * significand of the addend, with the explicit bit in position 126.
-     */
-    cSig0 = cSig << (126 - 64 - 52);
-    cSig1 = 0;
-    cSig0 |= LIT64(0x4000000000000000);
-    expDiff = pExp - cExp;
-
-    if (pSign == cSign) {
-        /* Addition */
-        if (expDiff > 0) {
-            /* scale c to match p */
-            shift128RightJamming(cSig0, cSig1, expDiff, &cSig0, &cSig1);
-            zExp = pExp;
-        } else if (expDiff < 0) {
-            /* scale p to match c */
-            shift128RightJamming(pSig0, pSig1, -expDiff, &pSig0, &pSig1);
-            zExp = cExp;
-        } else {
-            /* no scaling needed */
-            zExp = cExp;
-        }
-        /* Add significands and make sure explicit bit ends up in posn 126 */
-        add128(pSig0, pSig1, cSig0, cSig1, &zSig0, &zSig1);
-        if ((int64_t)zSig0 < 0) {
-            shift128RightJamming(zSig0, zSig1, 1, &zSig0, &zSig1);
-        } else {
-            zExp--;
-        }
-        shift128RightJamming(zSig0, zSig1, 64, &zSig0, &zSig1);
-        if (flags & float_muladd_halve_result) {
-            zExp--;
-        }
-        return roundAndPackFloat64(zSign, zExp, zSig1, status);
-    } else {
-        /* Subtraction */
-        if (expDiff > 0) {
-            shift128RightJamming(cSig0, cSig1, expDiff, &cSig0, &cSig1);
-            sub128(pSig0, pSig1, cSig0, cSig1, &zSig0, &zSig1);
-            zExp = pExp;
-        } else if (expDiff < 0) {
-            shift128RightJamming(pSig0, pSig1, -expDiff, &pSig0, &pSig1);
-            sub128(cSig0, cSig1, pSig0, pSig1, &zSig0, &zSig1);
-            zExp = cExp;
-            zSign ^= 1;
-        } else {
-            zExp = pExp;
-            if (lt128(cSig0, cSig1, pSig0, pSig1)) {
-                sub128(pSig0, pSig1, cSig0, cSig1, &zSig0, &zSig1);
-            } else if (lt128(pSig0, pSig1, cSig0, cSig1)) {
-                sub128(cSig0, cSig1, pSig0, pSig1, &zSig0, &zSig1);
-                zSign ^= 1;
-            } else {
-                /* Exact zero */
-                zSign = signflip;
-                if (status->float_rounding_mode == float_round_down) {
-                    zSign ^= 1;
-                }
-                return packFloat64(zSign, 0, 0);
-            }
-        }
-        --zExp;
-        /* Do the equivalent of normalizeRoundAndPackFloat64() but
-         * starting with the significand in a pair of uint64_t.
-         */
-        if (zSig0) {
-            shiftcount = countLeadingZeros64(zSig0) - 1;
-            shortShift128Left(zSig0, zSig1, shiftcount, &zSig0, &zSig1);
-            if (zSig1) {
-                zSig0 |= 1;
-            }
-            zExp -= shiftcount;
-        } else {
-            shiftcount = countLeadingZeros64(zSig1);
-            if (shiftcount == 0) {
-                zSig0 = (zSig1 >> 1) | (zSig1 & 1);
-                zExp -= 63;
-            } else {
-                shiftcount--;
-                zSig0 = zSig1 << shiftcount;
-                zExp -= (shiftcount + 64);
-            }
-        }
-        if (flags & float_muladd_halve_result) {
-            zExp--;
-        }
-        return roundAndPackFloat64(zSign, zExp, zSig0, status);
-    }
-}
 
 /*----------------------------------------------------------------------------
 | Returns the square root of the double-precision floating-point value `a'.
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 335f199bb6..c92147abec 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -322,6 +322,7 @@ float64 float16_to_float64(float16 a, flag ieee, float_status *status);
 float16 float16_add(float16, float16, float_status *status);
 float16 float16_sub(float16, float16, float_status *status);
 float16 float16_mul(float16, float16, float_status *status);
+float16 float16_muladd(float16, float16, float16, int, float_status *status);
 float16 float16_div(float16, float16, float_status *status);
 
 int float16_is_quiet_nan(float16, float_status *status);
-- 
2.15.1
