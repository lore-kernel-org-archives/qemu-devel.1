Received: from eggs.gnu.org ([2001:4830:134:3::10]:41845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32ld-0002d4-RX
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lb-0006dD-Dx
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:57 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:51102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32lb-0006cR-4S
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:55 -0400
Received: by mail-wr0-x22b.google.com with SMTP id q42so1429855wrb.7
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:24:55 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:23 +0100
Message-Id: <20171013162438.32458-16-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 15/30] softfloat: half-precision
 add/sub/mul/div support
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

Rather than following the SoftFloat3 implementation I've used the same
basic template as the rest of our softfloat code. One minor difference
is the 32bit intermediates end up with the binary point in the same
place as the 32 bit version so the change isn't totally mechanical.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat.c         | 352 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/fpu/softfloat.h |   6 +
 2 files changed, 358 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index cf7bf6d4f4..ff967f5525 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3532,6 +3532,358 @@ static void normalizeFloat16Subnormal(uint32_t aSig, int *zExpPtr,
     *zExpPtr = 1 - shiftCount;
 }
 
+/*----------------------------------------------------------------------------
+| Returns the result of adding the absolute values of the half-precision
+| floating-point values `a' and `b'.  If `zSign' is 1, the sum is negated
+| before being returned.  `zSign' is ignored if the result is a NaN.
+| The addition is performed according to the IEC/IEEE Standard for Binary
+| Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+static float16 addFloat16Sigs(float16 a, float16 b, flag zSign,
+                              float_status *status)
+{
+    int aExp, bExp, zExp;
+    uint16_t aSig, bSig, zSig;
+    int expDiff;
+
+    aSig = extractFloat16Frac( a );
+    aExp = extractFloat16Exp( a );
+    bSig = extractFloat16Frac( b );
+    bExp = extractFloat16Exp( b );
+    expDiff = aExp - bExp;
+    aSig <<= 3;
+    bSig <<= 3;
+    if ( 0 < expDiff ) {
+        if ( aExp == 0x1F ) {
+            if (aSig) {
+                return propagateFloat16NaN(a, b, status);
+            }
+            return a;
+        }
+        if ( bExp == 0 ) {
+            --expDiff;
+        }
+        else {
+            bSig |= 0x20000000;
+        }
+        shift16RightJamming( bSig, expDiff, &bSig );
+        zExp = aExp;
+    }
+    else if ( expDiff < 0 ) {
+        if ( bExp == 0x1F ) {
+            if (bSig) {
+                return propagateFloat16NaN(a, b, status);
+            }
+            return packFloat16( zSign, 0x1F, 0 );
+        }
+        if ( aExp == 0 ) {
+            ++expDiff;
+        }
+        else {
+            aSig |= 0x0400;
+        }
+        shift16RightJamming( aSig, - expDiff, &aSig );
+        zExp = bExp;
+    }
+    else {
+        if ( aExp == 0x1F ) {
+            if (aSig | bSig) {
+                return propagateFloat16NaN(a, b, status);
+            }
+            return a;
+        }
+        if ( aExp == 0 ) {
+            if (status->flush_to_zero) {
+                if (aSig | bSig) {
+                    float_raise(float_flag_output_denormal, status);
+                }
+                return packFloat16(zSign, 0, 0);
+            }
+            return packFloat16( zSign, 0, ( aSig + bSig )>>3 );
+        }
+        zSig = 0x0400 + aSig + bSig;
+        zExp = aExp;
+        goto roundAndPack;
+    }
+    aSig |= 0x0400;
+    zSig = ( aSig + bSig )<<1;
+    --zExp;
+    if ( (int16_t) zSig < 0 ) {
+        zSig = aSig + bSig;
+        ++zExp;
+    }
+ roundAndPack:
+    return roundAndPackFloat16(zSign, zExp, zSig, true, status);
+
+}
+
+/*----------------------------------------------------------------------------
+| Returns the result of subtracting the absolute values of the half-
+| precision floating-point values `a' and `b'.  If `zSign' is 1, the
+| difference is negated before being returned.  `zSign' is ignored if the
+| result is a NaN.  The subtraction is performed according to the IEC/IEEE
+| Standard for Binary Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+static float16 subFloat16Sigs(float16 a, float16 b, flag zSign,
+                              float_status *status)
+{
+    int aExp, bExp, zExp;
+    uint16_t aSig, bSig, zSig;
+    int expDiff;
+
+    aSig = extractFloat16Frac( a );
+    aExp = extractFloat16Exp( a );
+    bSig = extractFloat16Frac( b );
+    bExp = extractFloat16Exp( b );
+    expDiff = aExp - bExp;
+    aSig <<= 7;
+    bSig <<= 7;
+    if ( 0 < expDiff ) goto aExpBigger;
+    if ( expDiff < 0 ) goto bExpBigger;
+    if ( aExp == 0xFF ) {
+        if (aSig | bSig) {
+            return propagateFloat16NaN(a, b, status);
+        }
+        float_raise(float_flag_invalid, status);
+        return float16_default_nan(status);
+    }
+    if ( aExp == 0 ) {
+        aExp = 1;
+        bExp = 1;
+    }
+    if ( bSig < aSig ) goto aBigger;
+    if ( aSig < bSig ) goto bBigger;
+    return packFloat16(status->float_rounding_mode == float_round_down, 0, 0);
+ bExpBigger:
+    if ( bExp == 0xFF ) {
+        if (bSig) {
+            return propagateFloat16NaN(a, b, status);
+        }
+        return packFloat16( zSign ^ 1, 0xFF, 0 );
+    }
+    if ( aExp == 0 ) {
+        ++expDiff;
+    }
+    else {
+        aSig |= 0x40000000;
+    }
+    shift16RightJamming( aSig, - expDiff, &aSig );
+    bSig |= 0x40000000;
+ bBigger:
+    zSig = bSig - aSig;
+    zExp = bExp;
+    zSign ^= 1;
+    goto normalizeRoundAndPack;
+ aExpBigger:
+    if ( aExp == 0xFF ) {
+        if (aSig) {
+            return propagateFloat16NaN(a, b, status);
+        }
+        return a;
+    }
+    if ( bExp == 0 ) {
+        --expDiff;
+    }
+    else {
+        bSig |= 0x40000000;
+    }
+    shift16RightJamming( bSig, expDiff, &bSig );
+    aSig |= 0x40000000;
+ aBigger:
+    zSig = aSig - bSig;
+    zExp = aExp;
+ normalizeRoundAndPack:
+    --zExp;
+    return normalizeRoundAndPackFloat16(zSign, zExp, zSig, status);
+
+}
+
+/*----------------------------------------------------------------------------
+| Returns the result of adding the half-precision floating-point values `a'
+| and `b'.  The operation is performed according to the IEC/IEEE Standard for
+| Binary Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+float16 float16_add(float16 a, float16 b, float_status *status)
+{
+    flag aSign, bSign;
+    a = float16_squash_input_denormal(a, status);
+    b = float16_squash_input_denormal(b, status);
+
+    aSign = extractFloat16Sign( a );
+    bSign = extractFloat16Sign( b );
+    if ( aSign == bSign ) {
+        return addFloat16Sigs(a, b, aSign, status);
+    }
+    else {
+        return subFloat16Sigs(a, b, aSign, status);
+    }
+
+}
+
+/*----------------------------------------------------------------------------
+| Returns the result of subtracting the half-precision floating-point values
+| `a' and `b'.  The operation is performed according to the IEC/IEEE Standard
+| for Binary Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+float16 float16_sub(float16 a, float16 b, float_status *status)
+{
+    flag aSign, bSign;
+    a = float16_squash_input_denormal(a, status);
+    b = float16_squash_input_denormal(b, status);
+
+    aSign = extractFloat16Sign( a );
+    bSign = extractFloat16Sign( b );
+    if ( aSign == bSign ) {
+        return subFloat16Sigs(a, b, aSign, status);
+    }
+    else {
+        return addFloat16Sigs(a, b, aSign, status);
+    }
+
+}
+
+/*----------------------------------------------------------------------------
+| Returns the result of multiplying the half-precision floating-point values
+| `a' and `b'.  The operation is performed according to the IEC/IEEE Standard
+| for Binary Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+float16 float16_mul(float16 a, float16 b, float_status *status)
+{
+    flag aSign, bSign, zSign;
+    int aExp, bExp, zExp;
+    uint32_t aSig, bSig;
+    uint32_t zSig32; /* no zSig as zSig32 passed into rp&f */
+
+    a = float16_squash_input_denormal(a, status);
+    b = float16_squash_input_denormal(b, status);
+
+    aSig = extractFloat16Frac( a );
+    aExp = extractFloat16Exp( a );
+    aSign = extractFloat16Sign( a );
+    bSig = extractFloat16Frac( b );
+    bExp = extractFloat16Exp( b );
+    bSign = extractFloat16Sign( b );
+    zSign = aSign ^ bSign;
+    if ( aExp == 0x1F ) {
+        if ( aSig || ( ( bExp == 0x1F ) && bSig ) ) {
+            return propagateFloat16NaN(a, b, status);
+        }
+        if ( ( bExp | bSig ) == 0 ) {
+            float_raise(float_flag_invalid, status);
+            return float16_default_nan(status);
+        }
+        return packFloat16( zSign, 0x1F, 0 );
+    }
+    if ( bExp == 0x1F ) {
+        if (bSig) {
+            return propagateFloat16NaN(a, b, status);
+        }
+        if ( ( aExp | aSig ) == 0 ) {
+            float_raise(float_flag_invalid, status);
+            return float16_default_nan(status);
+        }
+        return packFloat16( zSign, 0x1F, 0 );
+    }
+    if ( aExp == 0 ) {
+        if ( aSig == 0 ) return packFloat16( zSign, 0, 0 );
+        normalizeFloat16Subnormal( aSig, &aExp, &aSig );
+    }
+    if ( bExp == 0 ) {
+        if ( bSig == 0 ) return packFloat16( zSign, 0, 0 );
+        normalizeFloat16Subnormal( bSig, &bExp, &bSig );
+    }
+    zExp = aExp + bExp - 0xF;
+    /* Add implicit bit */
+    aSig = ( aSig | 0x0400 )<<4;
+    bSig = ( bSig | 0x0400 )<<5;
+    /* Max (format " => 0x%x" (* (lsh #x400 4)  (lsh #x400 5))) => 0x20000000
+     * So shift so binary point from 30/29 to 23/22
+     */
+    shift32RightJamming( ( (uint32_t) aSig ) * bSig, 7, &zSig32 );
+    /* At this point the significand is at the same point as
+     * float32_mul, so we can do the same test */
+    if ( 0 <= (int32_t) ( zSig32<<1 ) ) {
+        zSig32 <<= 1;
+        --zExp;
+    }
+    return roundAndPackFloat16(zSign, zExp, zSig32, true, status);
+}
+
+/*----------------------------------------------------------------------------
+| Returns the result of dividing the half-precision floating-point value `a'
+| by the corresponding value `b'.  The operation is performed according to the
+| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+float16 float16_div(float16 a, float16 b, float_status *status)
+{
+    flag aSign, bSign, zSign;
+    int aExp, bExp, zExp;
+    uint32_t aSig, bSig, zSig;
+    a = float16_squash_input_denormal(a, status);
+    b = float16_squash_input_denormal(b, status);
+
+    aSig = extractFloat16Frac( a );
+    aExp = extractFloat16Exp( a );
+    aSign = extractFloat16Sign( a );
+    bSig = extractFloat16Frac( b );
+    bExp = extractFloat16Exp( b );
+    bSign = extractFloat16Sign( b );
+    zSign = aSign ^ bSign;
+    if ( aExp == 0xFF ) {
+        if (aSig) {
+            return propagateFloat16NaN(a, b, status);
+        }
+        if ( bExp == 0xFF ) {
+            if (bSig) {
+                return propagateFloat16NaN(a, b, status);
+            }
+            float_raise(float_flag_invalid, status);
+            return float16_default_nan(status);
+        }
+        return packFloat16( zSign, 0xFF, 0 );
+    }
+    if ( bExp == 0xFF ) {
+        if (bSig) {
+            return propagateFloat16NaN(a, b, status);
+        }
+        return packFloat16( zSign, 0, 0 );
+    }
+    if ( bExp == 0 ) {
+        if ( bSig == 0 ) {
+            if ( ( aExp | aSig ) == 0 ) {
+                float_raise(float_flag_invalid, status);
+                return float16_default_nan(status);
+            }
+            float_raise(float_flag_divbyzero, status);
+            return packFloat16( zSign, 0xFF, 0 );
+        }
+        normalizeFloat16Subnormal( bSig, &bExp, &bSig );
+    }
+    if ( aExp == 0 ) {
+        if ( aSig == 0 ) return packFloat16( zSign, 0, 0 );
+        normalizeFloat16Subnormal( aSig, &aExp, &aSig );
+    }
+    zExp = aExp - bExp + 0x7D;
+    aSig = ( aSig | 0x00800000 )<<7;
+    bSig = ( bSig | 0x00800000 )<<8;
+    if ( bSig <= ( aSig + aSig ) ) {
+        aSig >>= 1;
+        ++zExp;
+    }
+    zSig = ( ( (uint64_t) aSig )<<16 ) / bSig;
+    if ( ( zSig & 0x3F ) == 0 ) {
+        zSig |= ( (uint64_t) bSig * zSig != ( (uint64_t) aSig )<<16 );
+    }
+    return roundAndPackFloat16(zSign, zExp, zSig, true, status);
+
+}
+
 /* Half precision floats come in two formats: standard IEEE and "ARM" format.
    The latter gains extra exponent range by omitting the NaN/Inf encodings.  */
 
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index d89fdf7675..f1d79b6d03 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -345,6 +345,12 @@ float64 float16_to_float64(float16 a, flag ieee, float_status *status);
 /*----------------------------------------------------------------------------
 | Software half-precision operations.
 *----------------------------------------------------------------------------*/
+
+float16 float16_add(float16, float16, float_status *status);
+float16 float16_sub(float16, float16, float_status *status);
+float16 float16_mul(float16, float16, float_status *status);
+float16 float16_div(float16, float16, float_status *status);
+
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
 float16 float16_maybe_silence_nan(float16, float_status *status);
-- 
2.14.1
