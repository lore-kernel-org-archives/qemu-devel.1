Received: from eggs.gnu.org ([2001:4830:134:3::10]:35402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSDe-000422-Fu
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSDb-0006ii-Ai
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:50 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:40318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eoSDa-0006iM-S9
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:47 -0500
Received: by mail-wr0-x241.google.com with SMTP id o76so3270891wrb.7
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 03:05:46 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Feb 2018 11:05:12 +0000
Message-Id: <20180221110523.859-13-alex.bennee@linaro.org>
In-Reply-To: <20180221110523.859-1-alex.bennee@linaro.org>
References: <20180221110523.859-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/22] fpu/softfloat: re-factor add/sub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

We can now add float16_add/sub and use the common decompose and
canonicalize functions to have a single implementation for
float16/32/64 add and sub functions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 568d555595..2190e7de56 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -83,6 +83,7 @@ this code that are retained.
  * target-dependent and needs the TARGET_* macros.
  */
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "fpu/softfloat.h"
 
 /* We only need stdlib for abort() */
@@ -270,6 +271,470 @@ static const FloatFmt float64_params = {
     FLOAT_PARAMS(11, 52)
 };
 
+/* Unpack a float to parts, but do not canonicalize.  */
+static inline FloatParts unpack_raw(FloatFmt fmt, uint64_t raw)
+{
+    const int sign_pos = fmt.frac_size + fmt.exp_size;
+
+    return (FloatParts) {
+        .cls = float_class_unclassified,
+        .sign = extract64(raw, sign_pos, 1),
+        .exp = extract64(raw, fmt.frac_size, fmt.exp_size),
+        .frac = extract64(raw, 0, fmt.frac_size),
+    };
+}
+
+static inline FloatParts float16_unpack_raw(float16 f)
+{
+    return unpack_raw(float16_params, f);
+}
+
+static inline FloatParts float32_unpack_raw(float32 f)
+{
+    return unpack_raw(float32_params, f);
+}
+
+static inline FloatParts float64_unpack_raw(float64 f)
+{
+    return unpack_raw(float64_params, f);
+}
+
+/* Pack a float from parts, but do not canonicalize.  */
+static inline uint64_t pack_raw(FloatFmt fmt, FloatParts p)
+{
+    const int sign_pos = fmt.frac_size + fmt.exp_size;
+    uint64_t ret = deposit64(p.frac, fmt.frac_size, fmt.exp_size, p.exp);
+    return deposit64(ret, sign_pos, 1, p.sign);
+}
+
+static inline float16 float16_pack_raw(FloatParts p)
+{
+    return make_float16(pack_raw(float16_params, p));
+}
+
+static inline float32 float32_pack_raw(FloatParts p)
+{
+    return make_float32(pack_raw(float32_params, p));
+}
+
+static inline float64 float64_pack_raw(FloatParts p)
+{
+    return make_float64(pack_raw(float64_params, p));
+}
+
+/* Canonicalize EXP and FRAC, setting CLS.  */
+static FloatParts canonicalize(FloatParts part, const FloatFmt *parm,
+                               float_status *status)
+{
+    if (part.exp == parm->exp_max) {
+        if (part.frac == 0) {
+            part.cls = float_class_inf;
+        } else {
+#ifdef NO_SIGNALING_NANS
+            part.cls = float_class_qnan;
+#else
+            int64_t msb = part.frac << (parm->frac_shift + 2);
+            if ((msb < 0) == status->snan_bit_is_one) {
+                part.cls = float_class_snan;
+            } else {
+                part.cls = float_class_qnan;
+            }
+#endif
+        }
+    } else if (part.exp == 0) {
+        if (likely(part.frac == 0)) {
+            part.cls = float_class_zero;
+        } else if (status->flush_inputs_to_zero) {
+            float_raise(float_flag_input_denormal, status);
+            part.cls = float_class_zero;
+            part.frac = 0;
+        } else {
+            int shift = clz64(part.frac) - 1;
+            part.cls = float_class_normal;
+            part.exp = parm->frac_shift - parm->exp_bias - shift + 1;
+            part.frac <<= shift;
+        }
+    } else {
+        part.cls = float_class_normal;
+        part.exp -= parm->exp_bias;
+        part.frac = DECOMPOSED_IMPLICIT_BIT + (part.frac << parm->frac_shift);
+    }
+    return part;
+}
+
+/* Round and uncanonicalize a floating-point number by parts. There
+ * are FRAC_SHIFT bits that may require rounding at the bottom of the
+ * fraction; these bits will be removed. The exponent will be biased
+ * by EXP_BIAS and must be bounded by [EXP_MAX-1, 0].
+ */
+
+static FloatParts round_canonical(FloatParts p, float_status *s,
+                                  const FloatFmt *parm)
+{
+    const uint64_t frac_lsbm1 = parm->frac_lsbm1;
+    const uint64_t round_mask = parm->round_mask;
+    const uint64_t roundeven_mask = parm->roundeven_mask;
+    const int exp_max = parm->exp_max;
+    const int frac_shift = parm->frac_shift;
+    uint64_t frac, inc;
+    int exp, flags = 0;
+    bool overflow_norm;
+
+    frac = p.frac;
+    exp = p.exp;
+
+    switch (p.cls) {
+    case float_class_normal:
+        switch (s->float_rounding_mode) {
+        case float_round_nearest_even:
+            overflow_norm = false;
+            inc = ((frac & roundeven_mask) != frac_lsbm1 ? frac_lsbm1 : 0);
+            break;
+        case float_round_ties_away:
+            overflow_norm = false;
+            inc = frac_lsbm1;
+            break;
+        case float_round_to_zero:
+            overflow_norm = true;
+            inc = 0;
+            break;
+        case float_round_up:
+            inc = p.sign ? 0 : round_mask;
+            overflow_norm = p.sign;
+            break;
+        case float_round_down:
+            inc = p.sign ? round_mask : 0;
+            overflow_norm = !p.sign;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        exp += parm->exp_bias;
+        if (likely(exp > 0)) {
+            if (frac & round_mask) {
+                flags |= float_flag_inexact;
+                frac += inc;
+                if (frac & DECOMPOSED_OVERFLOW_BIT) {
+                    frac >>= 1;
+                    exp++;
+                }
+            }
+            frac >>= frac_shift;
+
+            if (unlikely(exp >= exp_max)) {
+                flags |= float_flag_overflow | float_flag_inexact;
+                if (overflow_norm) {
+                    exp = exp_max - 1;
+                    frac = -1;
+                } else {
+                    p.cls = float_class_inf;
+                    goto do_inf;
+                }
+            }
+        } else if (s->flush_to_zero) {
+            flags |= float_flag_output_denormal;
+            p.cls = float_class_zero;
+            goto do_zero;
+        } else {
+            bool is_tiny = (s->float_detect_tininess
+                            == float_tininess_before_rounding)
+                        || (exp < 0)
+                        || !((frac + inc) & DECOMPOSED_OVERFLOW_BIT);
+
+            shift64RightJamming(frac, 1 - exp, &frac);
+            if (frac & round_mask) {
+                /* Need to recompute round-to-even.  */
+                if (s->float_rounding_mode == float_round_nearest_even) {
+                    inc = ((frac & roundeven_mask) != frac_lsbm1
+                           ? frac_lsbm1 : 0);
+                }
+                flags |= float_flag_inexact;
+                frac += inc;
+            }
+
+            exp = (frac & DECOMPOSED_IMPLICIT_BIT ? 1 : 0);
+            frac >>= frac_shift;
+
+            if (is_tiny && (flags & float_flag_inexact)) {
+                flags |= float_flag_underflow;
+            }
+            if (exp == 0 && frac == 0) {
+                p.cls = float_class_zero;
+            }
+        }
+        break;
+
+    case float_class_zero:
+    do_zero:
+        exp = 0;
+        frac = 0;
+        break;
+
+    case float_class_inf:
+    do_inf:
+        exp = exp_max;
+        frac = 0;
+        break;
+
+    case float_class_qnan:
+    case float_class_snan:
+        exp = exp_max;
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    float_raise(flags, s);
+    p.exp = exp;
+    p.frac = frac;
+    return p;
+}
+
+static FloatParts float16_unpack_canonical(float16 f, float_status *s)
+{
+    return canonicalize(float16_unpack_raw(f), &float16_params, s);
+}
+
+static float16 float16_round_pack_canonical(FloatParts p, float_status *s)
+{
+    switch (p.cls) {
+    case float_class_dnan:
+        return float16_default_nan(s);
+    case float_class_msnan:
+        return float16_maybe_silence_nan(float16_pack_raw(p), s);
+    default:
+        p = round_canonical(p, s, &float16_params);
+        return float16_pack_raw(p);
+    }
+}
+
+static FloatParts float32_unpack_canonical(float32 f, float_status *s)
+{
+    return canonicalize(float32_unpack_raw(f), &float32_params, s);
+}
+
+static float32 float32_round_pack_canonical(FloatParts p, float_status *s)
+{
+    switch (p.cls) {
+    case float_class_dnan:
+        return float32_default_nan(s);
+    case float_class_msnan:
+        return float32_maybe_silence_nan(float32_pack_raw(p), s);
+    default:
+        p = round_canonical(p, s, &float32_params);
+        return float32_pack_raw(p);
+    }
+}
+
+static FloatParts float64_unpack_canonical(float64 f, float_status *s)
+{
+    return canonicalize(float64_unpack_raw(f), &float64_params, s);
+}
+
+static float64 float64_round_pack_canonical(FloatParts p, float_status *s)
+{
+    switch (p.cls) {
+    case float_class_dnan:
+        return float64_default_nan(s);
+    case float_class_msnan:
+        return float64_maybe_silence_nan(float64_pack_raw(p), s);
+    default:
+        p = round_canonical(p, s, &float64_params);
+        return float64_pack_raw(p);
+    }
+}
+
+/* Simple helpers for checking if what NaN we have */
+static bool is_nan(FloatClass c)
+{
+    return unlikely(c >= float_class_qnan);
+}
+static bool is_snan(FloatClass c)
+{
+    return c == float_class_snan;
+}
+static bool is_qnan(FloatClass c)
+{
+    return c == float_class_qnan;
+}
+
+static FloatParts pick_nan(FloatParts a, FloatParts b, float_status *s)
+{
+    if (is_snan(a.cls) || is_snan(b.cls)) {
+        s->float_exception_flags |= float_flag_invalid;
+    }
+
+    if (s->default_nan_mode) {
+        a.cls = float_class_dnan;
+    } else {
+        if (pickNaN(is_qnan(a.cls), is_snan(a.cls),
+                    is_qnan(b.cls), is_snan(b.cls),
+                    a.frac > b.frac ||
+                    (a.frac == b.frac && a.sign < b.sign))) {
+            a = b;
+        }
+        a.cls = float_class_msnan;
+    }
+    return a;
+}
+
+/*
+ * Returns the result of adding or subtracting the values of the
+ * floating-point values `a' and `b'. The operation is performed
+ * according to the IEC/IEEE Standard for Binary Floating-Point
+ * Arithmetic.
+ */
+
+static FloatParts addsub_floats(FloatParts a, FloatParts b, bool subtract,
+                                float_status *s)
+{
+    bool a_sign = a.sign;
+    bool b_sign = b.sign ^ subtract;
+
+    if (a_sign != b_sign) {
+        /* Subtraction */
+
+        if (a.cls == float_class_normal && b.cls == float_class_normal) {
+            if (a.exp > b.exp || (a.exp == b.exp && a.frac >= b.frac)) {
+                shift64RightJamming(b.frac, a.exp - b.exp, &b.frac);
+                a.frac = a.frac - b.frac;
+            } else {
+                shift64RightJamming(a.frac, b.exp - a.exp, &a.frac);
+                a.frac = b.frac - a.frac;
+                a.exp = b.exp;
+                a_sign ^= 1;
+            }
+
+            if (a.frac == 0) {
+                a.cls = float_class_zero;
+                a.sign = s->float_rounding_mode == float_round_down;
+            } else {
+                int shift = clz64(a.frac) - 1;
+                a.frac = a.frac << shift;
+                a.exp = a.exp - shift;
+                a.sign = a_sign;
+            }
+            return a;
+        }
+        if (is_nan(a.cls) || is_nan(b.cls)) {
+            return pick_nan(a, b, s);
+        }
+        if (a.cls == float_class_inf) {
+            if (b.cls == float_class_inf) {
+                float_raise(float_flag_invalid, s);
+                a.cls = float_class_dnan;
+            }
+            return a;
+        }
+        if (a.cls == float_class_zero && b.cls == float_class_zero) {
+            a.sign = s->float_rounding_mode == float_round_down;
+            return a;
+        }
+        if (a.cls == float_class_zero || b.cls == float_class_inf) {
+            b.sign = a_sign ^ 1;
+            return b;
+        }
+        if (b.cls == float_class_zero) {
+            return a;
+        }
+    } else {
+        /* Addition */
+        if (a.cls == float_class_normal && b.cls == float_class_normal) {
+            if (a.exp > b.exp) {
+                shift64RightJamming(b.frac, a.exp - b.exp, &b.frac);
+            } else if (a.exp < b.exp) {
+                shift64RightJamming(a.frac, b.exp - a.exp, &a.frac);
+                a.exp = b.exp;
+            }
+            a.frac += b.frac;
+            if (a.frac & DECOMPOSED_OVERFLOW_BIT) {
+                a.frac >>= 1;
+                a.exp += 1;
+            }
+            return a;
+        }
+        if (is_nan(a.cls) || is_nan(b.cls)) {
+            return pick_nan(a, b, s);
+        }
+        if (a.cls == float_class_inf || b.cls == float_class_zero) {
+            return a;
+        }
+        if (b.cls == float_class_inf || a.cls == float_class_zero) {
+            b.sign = b_sign;
+            return b;
+        }
+    }
+    g_assert_not_reached();
+}
+
+/*
+ * Returns the result of adding or subtracting the floating-point
+ * values `a' and `b'. The operation is performed according to the
+ * IEC/IEEE Standard for Binary Floating-Point Arithmetic.
+ */
+
+float16  __attribute__((flatten)) float16_add(float16 a, float16 b,
+                                              float_status *status)
+{
+    FloatParts pa = float16_unpack_canonical(a, status);
+    FloatParts pb = float16_unpack_canonical(b, status);
+    FloatParts pr = addsub_floats(pa, pb, false, status);
+
+    return float16_round_pack_canonical(pr, status);
+}
+
+float32 __attribute__((flatten)) float32_add(float32 a, float32 b,
+                                             float_status *status)
+{
+    FloatParts pa = float32_unpack_canonical(a, status);
+    FloatParts pb = float32_unpack_canonical(b, status);
+    FloatParts pr = addsub_floats(pa, pb, false, status);
+
+    return float32_round_pack_canonical(pr, status);
+}
+
+float64 __attribute__((flatten)) float64_add(float64 a, float64 b,
+                                             float_status *status)
+{
+    FloatParts pa = float64_unpack_canonical(a, status);
+    FloatParts pb = float64_unpack_canonical(b, status);
+    FloatParts pr = addsub_floats(pa, pb, false, status);
+
+    return float64_round_pack_canonical(pr, status);
+}
+
+float16 __attribute__((flatten)) float16_sub(float16 a, float16 b,
+                                             float_status *status)
+{
+    FloatParts pa = float16_unpack_canonical(a, status);
+    FloatParts pb = float16_unpack_canonical(b, status);
+    FloatParts pr = addsub_floats(pa, pb, true, status);
+
+    return float16_round_pack_canonical(pr, status);
+}
+
+float32 __attribute__((flatten)) float32_sub(float32 a, float32 b,
+                                             float_status *status)
+{
+    FloatParts pa = float32_unpack_canonical(a, status);
+    FloatParts pb = float32_unpack_canonical(b, status);
+    FloatParts pr = addsub_floats(pa, pb, true, status);
+
+    return float32_round_pack_canonical(pr, status);
+}
+
+float64 __attribute__((flatten)) float64_sub(float64 a, float64 b,
+                                             float_status *status)
+{
+    FloatParts pa = float64_unpack_canonical(a, status);
+    FloatParts pb = float64_unpack_canonical(b, status);
+    FloatParts pr = addsub_floats(pa, pb, true, status);
+
+    return float64_round_pack_canonical(pr, status);
+}
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
@@ -2081,220 +2546,6 @@ float32 float32_round_to_int(float32 a, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of adding the absolute values of the single-precision
-| floating-point values `a' and `b'.  If `zSign' is 1, the sum is negated
-| before being returned.  `zSign' is ignored if the result is a NaN.
-| The addition is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-static float32 addFloat32Sigs(float32 a, float32 b, flag zSign,
-                              float_status *status)
-{
-    int aExp, bExp, zExp;
-    uint32_t aSig, bSig, zSig;
-    int expDiff;
-
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    bSig = extractFloat32Frac( b );
-    bExp = extractFloat32Exp( b );
-    expDiff = aExp - bExp;
-    aSig <<= 6;
-    bSig <<= 6;
-    if ( 0 < expDiff ) {
-        if ( aExp == 0xFF ) {
-            if (aSig) {
-                return propagateFloat32NaN(a, b, status);
-            }
-            return a;
-        }
-        if ( bExp == 0 ) {
-            --expDiff;
-        }
-        else {
-            bSig |= 0x20000000;
-        }
-        shift32RightJamming( bSig, expDiff, &bSig );
-        zExp = aExp;
-    }
-    else if ( expDiff < 0 ) {
-        if ( bExp == 0xFF ) {
-            if (bSig) {
-                return propagateFloat32NaN(a, b, status);
-            }
-            return packFloat32( zSign, 0xFF, 0 );
-        }
-        if ( aExp == 0 ) {
-            ++expDiff;
-        }
-        else {
-            aSig |= 0x20000000;
-        }
-        shift32RightJamming( aSig, - expDiff, &aSig );
-        zExp = bExp;
-    }
-    else {
-        if ( aExp == 0xFF ) {
-            if (aSig | bSig) {
-                return propagateFloat32NaN(a, b, status);
-            }
-            return a;
-        }
-        if ( aExp == 0 ) {
-            if (status->flush_to_zero) {
-                if (aSig | bSig) {
-                    float_raise(float_flag_output_denormal, status);
-                }
-                return packFloat32(zSign, 0, 0);
-            }
-            return packFloat32( zSign, 0, ( aSig + bSig )>>6 );
-        }
-        zSig = 0x40000000 + aSig + bSig;
-        zExp = aExp;
-        goto roundAndPack;
-    }
-    aSig |= 0x20000000;
-    zSig = ( aSig + bSig )<<1;
-    --zExp;
-    if ( (int32_t) zSig < 0 ) {
-        zSig = aSig + bSig;
-        ++zExp;
-    }
- roundAndPack:
-    return roundAndPackFloat32(zSign, zExp, zSig, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of subtracting the absolute values of the single-
-| precision floating-point values `a' and `b'.  If `zSign' is 1, the
-| difference is negated before being returned.  `zSign' is ignored if the
-| result is a NaN.  The subtraction is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-static float32 subFloat32Sigs(float32 a, float32 b, flag zSign,
-                              float_status *status)
-{
-    int aExp, bExp, zExp;
-    uint32_t aSig, bSig, zSig;
-    int expDiff;
-
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    bSig = extractFloat32Frac( b );
-    bExp = extractFloat32Exp( b );
-    expDiff = aExp - bExp;
-    aSig <<= 7;
-    bSig <<= 7;
-    if ( 0 < expDiff ) goto aExpBigger;
-    if ( expDiff < 0 ) goto bExpBigger;
-    if ( aExp == 0xFF ) {
-        if (aSig | bSig) {
-            return propagateFloat32NaN(a, b, status);
-        }
-        float_raise(float_flag_invalid, status);
-        return float32_default_nan(status);
-    }
-    if ( aExp == 0 ) {
-        aExp = 1;
-        bExp = 1;
-    }
-    if ( bSig < aSig ) goto aBigger;
-    if ( aSig < bSig ) goto bBigger;
-    return packFloat32(status->float_rounding_mode == float_round_down, 0, 0);
- bExpBigger:
-    if ( bExp == 0xFF ) {
-        if (bSig) {
-            return propagateFloat32NaN(a, b, status);
-        }
-        return packFloat32( zSign ^ 1, 0xFF, 0 );
-    }
-    if ( aExp == 0 ) {
-        ++expDiff;
-    }
-    else {
-        aSig |= 0x40000000;
-    }
-    shift32RightJamming( aSig, - expDiff, &aSig );
-    bSig |= 0x40000000;
- bBigger:
-    zSig = bSig - aSig;
-    zExp = bExp;
-    zSign ^= 1;
-    goto normalizeRoundAndPack;
- aExpBigger:
-    if ( aExp == 0xFF ) {
-        if (aSig) {
-            return propagateFloat32NaN(a, b, status);
-        }
-        return a;
-    }
-    if ( bExp == 0 ) {
-        --expDiff;
-    }
-    else {
-        bSig |= 0x40000000;
-    }
-    shift32RightJamming( bSig, expDiff, &bSig );
-    aSig |= 0x40000000;
- aBigger:
-    zSig = aSig - bSig;
-    zExp = aExp;
- normalizeRoundAndPack:
-    --zExp;
-    return normalizeRoundAndPackFloat32(zSign, zExp, zSig, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of adding the single-precision floating-point values `a'
-| and `b'.  The operation is performed according to the IEC/IEEE Standard for
-| Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float32 float32_add(float32 a, float32 b, float_status *status)
-{
-    flag aSign, bSign;
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    aSign = extractFloat32Sign( a );
-    bSign = extractFloat32Sign( b );
-    if ( aSign == bSign ) {
-        return addFloat32Sigs(a, b, aSign, status);
-    }
-    else {
-        return subFloat32Sigs(a, b, aSign, status);
-    }
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of subtracting the single-precision floating-point values
-| `a' and `b'.  The operation is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float32 float32_sub(float32 a, float32 b, float_status *status)
-{
-    flag aSign, bSign;
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    aSign = extractFloat32Sign( a );
-    bSign = extractFloat32Sign( b );
-    if ( aSign == bSign ) {
-        return subFloat32Sigs(a, b, aSign, status);
-    }
-    else {
-        return addFloat32Sigs(a, b, aSign, status);
-    }
-
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of multiplying the single-precision floating-point values
 | `a' and `b'.  The operation is performed according to the IEC/IEEE Standard
@@ -3891,219 +4142,6 @@ float64 float64_trunc_to_int(float64 a, float_status *status)
     return res;
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of adding the absolute values of the double-precision
-| floating-point values `a' and `b'.  If `zSign' is 1, the sum is negated
-| before being returned.  `zSign' is ignored if the result is a NaN.
-| The addition is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-static float64 addFloat64Sigs(float64 a, float64 b, flag zSign,
-                              float_status *status)
-{
-    int aExp, bExp, zExp;
-    uint64_t aSig, bSig, zSig;
-    int expDiff;
-
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    bSig = extractFloat64Frac( b );
-    bExp = extractFloat64Exp( b );
-    expDiff = aExp - bExp;
-    aSig <<= 9;
-    bSig <<= 9;
-    if ( 0 < expDiff ) {
-        if ( aExp == 0x7FF ) {
-            if (aSig) {
-                return propagateFloat64NaN(a, b, status);
-            }
-            return a;
-        }
-        if ( bExp == 0 ) {
-            --expDiff;
-        }
-        else {
-            bSig |= LIT64( 0x2000000000000000 );
-        }
-        shift64RightJamming( bSig, expDiff, &bSig );
-        zExp = aExp;
-    }
-    else if ( expDiff < 0 ) {
-        if ( bExp == 0x7FF ) {
-            if (bSig) {
-                return propagateFloat64NaN(a, b, status);
-            }
-            return packFloat64( zSign, 0x7FF, 0 );
-        }
-        if ( aExp == 0 ) {
-            ++expDiff;
-        }
-        else {
-            aSig |= LIT64( 0x2000000000000000 );
-        }
-        shift64RightJamming( aSig, - expDiff, &aSig );
-        zExp = bExp;
-    }
-    else {
-        if ( aExp == 0x7FF ) {
-            if (aSig | bSig) {
-                return propagateFloat64NaN(a, b, status);
-            }
-            return a;
-        }
-        if ( aExp == 0 ) {
-            if (status->flush_to_zero) {
-                if (aSig | bSig) {
-                    float_raise(float_flag_output_denormal, status);
-                }
-                return packFloat64(zSign, 0, 0);
-            }
-            return packFloat64( zSign, 0, ( aSig + bSig )>>9 );
-        }
-        zSig = LIT64( 0x4000000000000000 ) + aSig + bSig;
-        zExp = aExp;
-        goto roundAndPack;
-    }
-    aSig |= LIT64( 0x2000000000000000 );
-    zSig = ( aSig + bSig )<<1;
-    --zExp;
-    if ( (int64_t) zSig < 0 ) {
-        zSig = aSig + bSig;
-        ++zExp;
-    }
- roundAndPack:
-    return roundAndPackFloat64(zSign, zExp, zSig, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of subtracting the absolute values of the double-
-| precision floating-point values `a' and `b'.  If `zSign' is 1, the
-| difference is negated before being returned.  `zSign' is ignored if the
-| result is a NaN.  The subtraction is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-static float64 subFloat64Sigs(float64 a, float64 b, flag zSign,
-                              float_status *status)
-{
-    int aExp, bExp, zExp;
-    uint64_t aSig, bSig, zSig;
-    int expDiff;
-
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    bSig = extractFloat64Frac( b );
-    bExp = extractFloat64Exp( b );
-    expDiff = aExp - bExp;
-    aSig <<= 10;
-    bSig <<= 10;
-    if ( 0 < expDiff ) goto aExpBigger;
-    if ( expDiff < 0 ) goto bExpBigger;
-    if ( aExp == 0x7FF ) {
-        if (aSig | bSig) {
-            return propagateFloat64NaN(a, b, status);
-        }
-        float_raise(float_flag_invalid, status);
-        return float64_default_nan(status);
-    }
-    if ( aExp == 0 ) {
-        aExp = 1;
-        bExp = 1;
-    }
-    if ( bSig < aSig ) goto aBigger;
-    if ( aSig < bSig ) goto bBigger;
-    return packFloat64(status->float_rounding_mode == float_round_down, 0, 0);
- bExpBigger:
-    if ( bExp == 0x7FF ) {
-        if (bSig) {
-            return propagateFloat64NaN(a, b, status);
-        }
-        return packFloat64( zSign ^ 1, 0x7FF, 0 );
-    }
-    if ( aExp == 0 ) {
-        ++expDiff;
-    }
-    else {
-        aSig |= LIT64( 0x4000000000000000 );
-    }
-    shift64RightJamming( aSig, - expDiff, &aSig );
-    bSig |= LIT64( 0x4000000000000000 );
- bBigger:
-    zSig = bSig - aSig;
-    zExp = bExp;
-    zSign ^= 1;
-    goto normalizeRoundAndPack;
- aExpBigger:
-    if ( aExp == 0x7FF ) {
-        if (aSig) {
-            return propagateFloat64NaN(a, b, status);
-        }
-        return a;
-    }
-    if ( bExp == 0 ) {
-        --expDiff;
-    }
-    else {
-        bSig |= LIT64( 0x4000000000000000 );
-    }
-    shift64RightJamming( bSig, expDiff, &bSig );
-    aSig |= LIT64( 0x4000000000000000 );
- aBigger:
-    zSig = aSig - bSig;
-    zExp = aExp;
- normalizeRoundAndPack:
-    --zExp;
-    return normalizeRoundAndPackFloat64(zSign, zExp, zSig, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of adding the double-precision floating-point values `a'
-| and `b'.  The operation is performed according to the IEC/IEEE Standard for
-| Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float64 float64_add(float64 a, float64 b, float_status *status)
-{
-    flag aSign, bSign;
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    aSign = extractFloat64Sign( a );
-    bSign = extractFloat64Sign( b );
-    if ( aSign == bSign ) {
-        return addFloat64Sigs(a, b, aSign, status);
-    }
-    else {
-        return subFloat64Sigs(a, b, aSign, status);
-    }
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of subtracting the double-precision floating-point values
-| `a' and `b'.  The operation is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float64 float64_sub(float64 a, float64 b, float_status *status)
-{
-    flag aSign, bSign;
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    aSign = extractFloat64Sign( a );
-    bSign = extractFloat64Sign( b );
-    if ( aSign == bSign ) {
-        return subFloat64Sigs(a, b, aSign, status);
-    }
-    else {
-        return addFloat64Sigs(a, b, aSign, status);
-    }
-
-}
 
 /*----------------------------------------------------------------------------
 | Returns the result of multiplying the double-precision floating-point values
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 23824a3000..693ece0974 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -236,6 +236,10 @@ float64 float16_to_float64(float16 a, flag ieee, float_status *status);
 /*----------------------------------------------------------------------------
 | Software half-precision operations.
 *----------------------------------------------------------------------------*/
+
+float16 float16_add(float16, float16, float_status *status);
+float16 float16_sub(float16, float16, float_status *status);
+
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
 float16 float16_maybe_silence_nan(float16, float_status *status);
-- 
2.15.1
