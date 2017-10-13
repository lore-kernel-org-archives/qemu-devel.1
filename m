Received: from eggs.gnu.org ([2001:4830:134:3::10]:44006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32sX-0000Yw-TO
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32sW-0002F9-0d
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:05 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:48949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32sV-0002Dq-Ob
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:03 -0400
Received: by mail-wm0-x22c.google.com with SMTP id i124so22416664wmf.3
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:32:03 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:31 +0100
Message-Id: <20171013162438.32458-24-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 23/30] softfloat: add float16_rem and
 float16_muladd (!CHECK)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat-specialize.h |  52 +++++++
 fpu/softfloat.c            | 327 +++++++++++++++++++++++++++++++++++++++++++++
 include/fpu/softfloat.h    |   2 +
 3 files changed, 381 insertions(+)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 2ccd4abe11..33c4be1757 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -728,6 +728,58 @@ static float16 propagateFloat16NaN(float16 a, float16 b, float_status *status)
     }
 }
 
+/*----------------------------------------------------------------------------
+| Takes three half-precision floating-point values `a', `b' and `c', one of
+| which is a NaN, and returns the appropriate NaN result.  If any of  `a',
+| `b' or `c' is a signaling NaN, the invalid exception is raised.
+| The input infzero indicates whether a*b was 0*inf or inf*0 (in which case
+| obviously c is a NaN, and whether to propagate c or some other NaN is
+| implementation defined).
+*----------------------------------------------------------------------------*/
+
+static float16 propagateFloat16MulAddNaN(float16 a, float16 b,
+                                         float16 c, flag infzero,
+                                         float_status *status)
+{
+    flag aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN,
+        cIsQuietNaN, cIsSignalingNaN;
+    int which;
+
+    aIsQuietNaN = float16_is_quiet_nan(a, status);
+    aIsSignalingNaN = float16_is_signaling_nan(a, status);
+    bIsQuietNaN = float16_is_quiet_nan(b, status);
+    bIsSignalingNaN = float16_is_signaling_nan(b, status);
+    cIsQuietNaN = float16_is_quiet_nan(c, status);
+    cIsSignalingNaN = float16_is_signaling_nan(c, status);
+
+    if (aIsSignalingNaN | bIsSignalingNaN | cIsSignalingNaN) {
+        float_raise(float_flag_invalid, status);
+    }
+
+    which = pickNaNMulAdd(aIsQuietNaN, aIsSignalingNaN,
+                          bIsQuietNaN, bIsSignalingNaN,
+                          cIsQuietNaN, cIsSignalingNaN, infzero, status);
+
+    if (status->default_nan_mode) {
+        /* Note that this check is after pickNaNMulAdd so that function
+         * has an opportunity to set the Invalid flag.
+         */
+        return float16_default_nan(status);
+    }
+
+    switch (which) {
+    case 0:
+        return float16_maybe_silence_nan(a, status);
+    case 1:
+        return float16_maybe_silence_nan(b, status);
+    case 2:
+        return float16_maybe_silence_nan(c, status);
+    case 3:
+    default:
+        return float16_default_nan(status);
+    }
+}
+
 /*----------------------------------------------------------------------------
 | Takes two single-precision floating-point values `a' and `b', one of which
 | is a NaN, and returns the appropriate NaN result.  If either `a' or `b' is a
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index fdb2999c41..f7473f97e3 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3884,6 +3884,333 @@ float16 float16_div(float16 a, float16 b, float_status *status)
 
 }
 
+/*----------------------------------------------------------------------------
+| Returns the remainder of the half-precision floating-point value `a'
+| with respect to the corresponding value `b'.  The operation is performed
+| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+float16 float16_rem(float16 a, float16 b, float_status *status)
+{
+    flag aSign, zSign;
+    int aExp, bExp, expDiff;
+    uint32_t aSig, bSig;
+    uint32_t q;
+    uint64_t aSig64, bSig64, q64;
+    uint32_t alternateASig;
+    int32_t sigMean;
+    a = float16_squash_input_denormal(a, status);
+    b = float16_squash_input_denormal(b, status);
+
+    aSig = extractFloat32Frac( a );
+    aExp = extractFloat32Exp( a );
+    aSign = extractFloat32Sign( a );
+    bSig = extractFloat32Frac( b );
+    bExp = extractFloat32Exp( b );
+    if ( aExp == 0xFF ) {
+        if ( aSig || ( ( bExp == 0xFF ) && bSig ) ) {
+            return propagateFloat32NaN(a, b, status);
+        }
+        float_raise(float_flag_invalid, status);
+        return float16_default_nan(status);
+    }
+    if ( bExp == 0xFF ) {
+        if (bSig) {
+            return propagateFloat32NaN(a, b, status);
+        }
+        return a;
+    }
+    if ( bExp == 0 ) {
+        if ( bSig == 0 ) {
+            float_raise(float_flag_invalid, status);
+            return float16_default_nan(status);
+        }
+        normalizeFloat32Subnormal( bSig, &bExp, &bSig );
+    }
+    if ( aExp == 0 ) {
+        if ( aSig == 0 ) return a;
+        normalizeFloat32Subnormal( aSig, &aExp, &aSig );
+    }
+    expDiff = aExp - bExp;
+    aSig |= 0x00800000;
+    bSig |= 0x00800000;
+    if ( expDiff < 32 ) {
+        aSig <<= 8;
+        bSig <<= 8;
+        if ( expDiff < 0 ) {
+            if ( expDiff < -1 ) return a;
+            aSig >>= 1;
+        }
+        q = ( bSig <= aSig );
+        if ( q ) aSig -= bSig;
+        if ( 0 < expDiff ) {
+            q = ( ( (uint64_t) aSig )<<32 ) / bSig;
+            q >>= 32 - expDiff;
+            bSig >>= 2;
+            aSig = ( ( aSig>>1 )<<( expDiff - 1 ) ) - bSig * q;
+        }
+        else {
+            aSig >>= 2;
+            bSig >>= 2;
+        }
+    }
+    else {
+        if ( bSig <= aSig ) aSig -= bSig;
+        aSig64 = ( (uint64_t) aSig )<<40;
+        bSig64 = ( (uint64_t) bSig )<<40;
+        expDiff -= 64;
+        while ( 0 < expDiff ) {
+            q64 = estimateDiv128To64( aSig64, 0, bSig64 );
+            q64 = ( 2 < q64 ) ? q64 - 2 : 0;
+            aSig64 = - ( ( bSig * q64 )<<38 );
+            expDiff -= 62;
+        }
+        expDiff += 64;
+        q64 = estimateDiv128To64( aSig64, 0, bSig64 );
+        q64 = ( 2 < q64 ) ? q64 - 2 : 0;
+        q = q64>>( 64 - expDiff );
+        bSig <<= 6;
+        aSig = ( ( aSig64>>33 )<<( expDiff - 1 ) ) - bSig * q;
+    }
+    do {
+        alternateASig = aSig;
+        ++q;
+        aSig -= bSig;
+    } while ( 0 <= (int32_t) aSig );
+    sigMean = aSig + alternateASig;
+    if ( ( sigMean < 0 ) || ( ( sigMean == 0 ) && ( q & 1 ) ) ) {
+        aSig = alternateASig;
+    }
+    zSign = ( (int32_t) aSig < 0 );
+    if ( zSign ) aSig = - aSig;
+    return normalizeRoundAndPackFloat32(aSign ^ zSign, bExp, aSig, status);
+}
+
+/*----------------------------------------------------------------------------
+| Returns the result of multiplying the half-precision floating-point values
+| `a' and `b' then adding 'c', with no intermediate rounding step after the
+| multiplication.  The operation is performed according to the IEC/IEEE
+| Standard for Binary Floating-Point Arithmetic 754-2008.
+| The flags argument allows the caller to select negation of the
+| addend, the intermediate product, or the final result. (The difference
+| between this and having the caller do a separate negation is that negating
+| externally will flip the sign bit on NaNs.)
+*----------------------------------------------------------------------------*/
+
+float16 float16_muladd(float16 a, float16 b, float16 c, int flags,
+                       float_status *status)
+{
+    flag aSign, bSign, cSign, zSign;
+    int aExp, bExp, cExp, pExp, zExp, expDiff;
+    uint32_t aSig, bSig, cSig;
+    flag pInf, pZero, pSign;
+    uint64_t pSig64, cSig64, zSig64;
+    uint32_t pSig;
+    int shiftcount;
+    flag signflip, infzero;
+
+    a = float16_squash_input_denormal(a, status);
+    b = float16_squash_input_denormal(b, status);
+    c = float16_squash_input_denormal(c, status);
+    aSig = extractFloat16Frac(a);
+    aExp = extractFloat16Exp(a);
+    aSign = extractFloat16Sign(a);
+    bSig = extractFloat16Frac(b);
+    bExp = extractFloat16Exp(b);
+    bSign = extractFloat16Sign(b);
+    cSig = extractFloat16Frac(c);
+    cExp = extractFloat16Exp(c);
+    cSign = extractFloat16Sign(c);
+
+    infzero = ((aExp == 0 && aSig == 0 && bExp == 0x1f && bSig == 0) ||
+               (aExp == 0x1f && aSig == 0 && bExp == 0 && bSig == 0));
+
+    /* It is implementation-defined whether the cases of (0,inf,qnan)
+     * and (inf,0,qnan) raise InvalidOperation or not (and what QNaN
+     * they return if they do), so we have to hand this information
+     * off to the target-specific pick-a-NaN routine.
+     */
+    if (((aExp == 0xff) && aSig) ||
+        ((bExp == 0xff) && bSig) ||
+        ((cExp == 0xff) && cSig)) {
+        return propagateFloat16MulAddNaN(a, b, c, infzero, status);
+    }
+
+    if (infzero) {
+        float_raise(float_flag_invalid, status);
+        return float16_default_nan(status);
+    }
+
+    if (flags & float_muladd_negate_c) {
+        cSign ^= 1;
+    }
+
+    signflip = (flags & float_muladd_negate_result) ? 1 : 0;
+
+    /* Work out the sign and type of the product */
+    pSign = aSign ^ bSign;
+    if (flags & float_muladd_negate_product) {
+        pSign ^= 1;
+    }
+    pInf = (aExp == 0xff) || (bExp == 0xff);
+    pZero = ((aExp | aSig) == 0) || ((bExp | bSig) == 0);
+
+    if (cExp == 0xff) {
+        if (pInf && (pSign ^ cSign)) {
+            /* addition of opposite-signed infinities => InvalidOperation */
+            float_raise(float_flag_invalid, status);
+            return float16_default_nan(status);
+        }
+        /* Otherwise generate an infinity of the same sign */
+        return packFloat16(cSign ^ signflip, 0xff, 0);
+    }
+
+    if (pInf) {
+        return packFloat16(pSign ^ signflip, 0xff, 0);
+    }
+
+    if (pZero) {
+        if (cExp == 0) {
+            if (cSig == 0) {
+                /* Adding two exact zeroes */
+                if (pSign == cSign) {
+                    zSign = pSign;
+                } else if (status->float_rounding_mode == float_round_down) {
+                    zSign = 1;
+                } else {
+                    zSign = 0;
+                }
+                return packFloat16(zSign ^ signflip, 0, 0);
+            }
+            /* Exact zero plus a denorm */
+            if (status->flush_to_zero) {
+                float_raise(float_flag_output_denormal, status);
+                return packFloat16(cSign ^ signflip, 0, 0);
+            }
+        }
+        /* Zero plus something non-zero : just return the something */
+        if (flags & float_muladd_halve_result) {
+            if (cExp == 0) {
+                normalizeFloat16Subnormal(cSig, &cExp, &cSig);
+            }
+            /* Subtract one to halve, and one again because roundAndPackFloat16
+             * wants one less than the true exponent.
+             */
+            cExp -= 2;
+            cSig = (cSig | 0x00800000) << 7;
+            return roundAndPackFloat16(cSign ^ signflip, cExp, cSig, true, status);
+        }
+        return packFloat16(cSign ^ signflip, cExp, cSig);
+    }
+
+    if (aExp == 0) {
+        normalizeFloat16Subnormal(aSig, &aExp, &aSig);
+    }
+    if (bExp == 0) {
+        normalizeFloat16Subnormal(bSig, &bExp, &bSig);
+    }
+
+    /* Calculate the actual result a * b + c */
+
+    /* Multiply first; this is easy. */
+    /* NB: we subtract 0x7e where float16_mul() subtracts 0x7f
+     * because we want the true exponent, not the "one-less-than"
+     * flavour that roundAndPackFloat16() takes.
+     */
+    pExp = aExp + bExp - 0x7e;
+    aSig = (aSig | 0x00800000) << 7;
+    bSig = (bSig | 0x00800000) << 8;
+    pSig64 = (uint64_t)aSig * bSig;
+    if ((int64_t)(pSig64 << 1) >= 0) {
+        pSig64 <<= 1;
+        pExp--;
+    }
+
+    zSign = pSign ^ signflip;
+
+    /* Now pSig64 is the significand of the multiply, with the explicit bit in
+     * position 62.
+     */
+    if (cExp == 0) {
+        if (!cSig) {
+            /* Throw out the special case of c being an exact zero now */
+            shift64RightJamming(pSig64, 32, &pSig64);
+            pSig = pSig64;
+            if (flags & float_muladd_halve_result) {
+                pExp--;
+            }
+            return roundAndPackFloat16(zSign, pExp - 1,
+                                       pSig, true, status);
+        }
+        normalizeFloat16Subnormal(cSig, &cExp, &cSig);
+    }
+
+    cSig64 = (uint64_t)cSig << (62 - 23);
+    cSig64 |= LIT64(0x4000000000000000);
+    expDiff = pExp - cExp;
+
+    if (pSign == cSign) {
+        /* Addition */
+        if (expDiff > 0) {
+            /* scale c to match p */
+            shift64RightJamming(cSig64, expDiff, &cSig64);
+            zExp = pExp;
+        } else if (expDiff < 0) {
+            /* scale p to match c */
+            shift64RightJamming(pSig64, -expDiff, &pSig64);
+            zExp = cExp;
+        } else {
+            /* no scaling needed */
+            zExp = cExp;
+        }
+        /* Add significands and make sure explicit bit ends up in posn 62 */
+        zSig64 = pSig64 + cSig64;
+        if ((int64_t)zSig64 < 0) {
+            shift64RightJamming(zSig64, 1, &zSig64);
+        } else {
+            zExp--;
+        }
+    } else {
+        /* Subtraction */
+        if (expDiff > 0) {
+            shift64RightJamming(cSig64, expDiff, &cSig64);
+            zSig64 = pSig64 - cSig64;
+            zExp = pExp;
+        } else if (expDiff < 0) {
+            shift64RightJamming(pSig64, -expDiff, &pSig64);
+            zSig64 = cSig64 - pSig64;
+            zExp = cExp;
+            zSign ^= 1;
+        } else {
+            zExp = pExp;
+            if (cSig64 < pSig64) {
+                zSig64 = pSig64 - cSig64;
+            } else if (pSig64 < cSig64) {
+                zSig64 = cSig64 - pSig64;
+                zSign ^= 1;
+            } else {
+                /* Exact zero */
+                zSign = signflip;
+                if (status->float_rounding_mode == float_round_down) {
+                    zSign ^= 1;
+                }
+                return packFloat16(zSign, 0, 0);
+            }
+        }
+        --zExp;
+        /* Normalize to put the explicit bit back into bit 62. */
+        shiftcount = countLeadingZeros64(zSig64) - 1;
+        zSig64 <<= shiftcount;
+        zExp -= shiftcount;
+    }
+    if (flags & float_muladd_halve_result) {
+        zExp--;
+    }
+
+    shift64RightJamming(zSig64, 32, &zSig64);
+    return roundAndPackFloat16(zSign, zExp, zSig64, true, status);
+}
+
 /*----------------------------------------------------------------------------
 | Returns 1 if the half-precision floating-point value `a' is equal to
 | the corresponding value `b', and 0 otherwise.  The invalid exception is
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 76a8310780..a7435e2a5b 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -350,6 +350,8 @@ float16 float16_add(float16, float16, float_status *status);
 float16 float16_sub(float16, float16, float_status *status);
 float16 float16_mul(float16, float16, float_status *status);
 float16 float16_div(float16, float16, float_status *status);
+float16 float16_rem(float16, float16, float_status *status);
+float16 float16_muladd(float16, float16, float16, int, float_status *status);
 int float16_eq(float16, float16, float_status *status);
 int float16_le(float16, float16, float_status *status);
 int float16_lt(float16, float16, float_status *status);
-- 
2.14.1
