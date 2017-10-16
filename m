Received: from eggs.gnu.org ([2001:4830:134:3::10]:40141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4DS5-0005YA-MS
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4DS0-0008Sc-RB
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:01:37 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:46770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4DS0-0008SB-IV
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:01:32 -0400
Received: by mail-pg0-x22f.google.com with SMTP id k7so7897829pga.3
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 15:01:32 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ab25e46e-9edd-5b81-095d-4b859e71ceec@linaro.org>
Date: Mon, 16 Oct 2017 15:01:27 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 15/30] softfloat: half-precision
 add/sub/mul/div support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> +static float16 addFloat16Sigs(float16 a, float16 b, flag zSign,
> +                              float_status *status)
> +{
> +    int aExp, bExp, zExp;
> +    uint16_t aSig, bSig, zSig;
> +    int expDiff;
> +
> +    aSig = extractFloat16Frac( a );
> +    aExp = extractFloat16Exp( a );
> +    bSig = extractFloat16Frac( b );
> +    bExp = extractFloat16Exp( b );
> +    expDiff = aExp - bExp;
> +    aSig <<= 3;
> +    bSig <<= 3;
> +    if ( 0 < expDiff ) {
> +        if ( aExp == 0x1F ) {
> +            if (aSig) {
> +                return propagateFloat16NaN(a, b, status);
> +            }
> +            return a;
> +        }
> +        if ( bExp == 0 ) {
> +            --expDiff;
> +        }
> +        else {
> +            bSig |= 0x20000000;
> +        }

This number is wrong.  The 32-bit number is the implicit bit (0x800000) << 6
(which is the shift applied there).  Here it should be 0x400 << 3.  And it
probably should be written that way for clarity.

> +    else if ( expDiff < 0 ) {
> +        if ( bExp == 0x1F ) {
> +            if (bSig) {
> +                return propagateFloat16NaN(a, b, status);
> +            }
> +            return packFloat16( zSign, 0x1F, 0 );
> +        }
> +        if ( aExp == 0 ) {
> +            ++expDiff;
> +        }
> +        else {
> +            aSig |= 0x0400;

This number is wrong because you didn't apply the << 3.

> +        if ( aExp == 0 ) {
> +            if (status->flush_to_zero) {
> +                if (aSig | bSig) {
> +                    float_raise(float_flag_output_denormal, status);
> +                }
> +                return packFloat16(zSign, 0, 0);
> +            }
> +            return packFloat16( zSign, 0, ( aSig + bSig )>>3 );
> +        }
> +        zSig = 0x0400 + aSig + bSig;
> +        zExp = aExp;
> +        goto roundAndPack;
> +    }
> +    aSig |= 0x0400;

Needs << 3.

> +    zSig = ( aSig + bSig )<<1;
> +    --zExp;
> +    if ( (int16_t) zSig < 0 ) {
> +        zSig = aSig + bSig;
> +        ++zExp;
> +    }

As a side-note, I really wish the existing code didn't try to half-optimize
this.  Both aSig and bSig really should have their implicit bits added.  Of
course, that affects this weird zExp dance as well.

> +    int aExp, bExp, zExp;
> +    uint16_t aSig, bSig, zSig;
> +    int expDiff;
> +
> +    aSig = extractFloat16Frac( a );
> +    aExp = extractFloat16Exp( a );
> +    bSig = extractFloat16Frac( b );
> +    bExp = extractFloat16Exp( b );
> +    expDiff = aExp - bExp;
> +    aSig <<= 7;
> +    bSig <<= 7;

You've just lost one frac bit off the left of the uint16_t.

You cannot add that many bias bits and still use that as an intermediate data
type.  You can only shift by 3, as you did for add.  Or, widen to uint32_t.

> +    if ( 0 < expDiff ) goto aExpBigger;
> +    if ( expDiff < 0 ) goto bExpBigger;
> +    if ( aExp == 0xFF ) {
> +        if (aSig | bSig) {
> +            return propagateFloat16NaN(a, b, status);
> +        }
> +        float_raise(float_flag_invalid, status);
> +        return float16_default_nan(status);
> +    }
> +    if ( aExp == 0 ) {
> +        aExp = 1;
> +        bExp = 1;
> +    }
> +    if ( bSig < aSig ) goto aBigger;
> +    if ( aSig < bSig ) goto bBigger;
> +    return packFloat16(status->float_rounding_mode == float_round_down, 0, 0);
> + bExpBigger:
> +    if ( bExp == 0xFF ) {
> +        if (bSig) {
> +            return propagateFloat16NaN(a, b, status);
> +        }
> +        return packFloat16( zSign ^ 1, 0xFF, 0 );
> +    }
> +    if ( aExp == 0 ) {
> +        ++expDiff;
> +    }
> +    else {
> +        aSig |= 0x40000000;
> +    }
> +    shift16RightJamming( aSig, - expDiff, &aSig );
> +    bSig |= 0x40000000;

These should be 0x400 << shl.  It should be obvious that 0x40000000 doesn't fit
in uint16_t.

> + bBigger:
> +    zSig = bSig - aSig;
> +    zExp = bExp;
> +    zSign ^= 1;
> +    goto normalizeRoundAndPack;
> + aExpBigger:
> +    if ( aExp == 0xFF ) {
> +        if (aSig) {
> +            return propagateFloat16NaN(a, b, status);
> +        }
> +        return a;
> +    }
> +    if ( bExp == 0 ) {
> +        --expDiff;
> +    }
> +    else {
> +        bSig |= 0x40000000;
> +    }
> +    shift16RightJamming( bSig, expDiff, &bSig );
> +    aSig |= 0x40000000;

Likewise.

> + aBigger:
> +    zSig = aSig - bSig;
> +    zExp = aExp;
> + normalizeRoundAndPack:
> +    --zExp;
> +    return normalizeRoundAndPackFloat16(zSign, zExp, zSig, status);

This reinforces my point about not using uint16_t

> +float16 float16_mul(float16 a, float16 b, float_status *status)
...
> +    if ( aExp == 0 ) {
> +        if ( aSig == 0 ) return packFloat16( zSign, 0, 0 );
> +        normalizeFloat16Subnormal( aSig, &aExp, &aSig );
> +    }
> +    if ( bExp == 0 ) {
> +        if ( bSig == 0 ) return packFloat16( zSign, 0, 0 );
> +        normalizeFloat16Subnormal( bSig, &bExp, &bSig );
> +    }
> +    zExp = aExp + bExp - 0xF;
> +    /* Add implicit bit */
> +    aSig = ( aSig | 0x0400 )<<4;
> +    bSig = ( bSig | 0x0400 )<<5;

The implicit bit shouldn't be added for denormals.  It *probably* doesn't
matter since the normalization step should be setting the same bit, but it's
certainly less than clear.

Is there a particular reason to add the 9 bits of shifting?  I thought we
demonstrated to your satisfaction that it wasn't required.

> +    /* Max (format " => 0x%x" (* (lsh #x400 4)  (lsh #x400 5))) => 0x20000000
> +     * So shift so binary point from 30/29 to 23/22
> +     */

That's the minimum, not maximum.  Maximum would be

  0x7ff<<4 * 0x7ff<<5 => 0x7fe00200

I am totally unclear why the binary point should be at 23/22.  That doesn't
seem to match up with the shifts you've used for either addition or
subtraction.  Both of which were different, btw...


> +    shift32RightJamming( ( (uint32_t) aSig ) * bSig, 7, &zSig32 );
> +    /* At this point the significand is at the same point as
> +     * float32_mul, so we can do the same test */
> +    if ( 0 <= (int32_t) ( zSig32<<1 ) ) {
> +        zSig32 <<= 1;
> +        --zExp;
> +    }

These two are definitely in the wrong order.  You can certainly normalize
0x20000000 to 0x40000000 via that IF, but not if you've already right-shifted
by 7 bits.


> +/*----------------------------------------------------------------------------
> +| Returns the result of dividing the half-precision floating-point value `a'
> +| by the corresponding value `b'.  The operation is performed according to the
> +| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
> +*----------------------------------------------------------------------------*/
> +
> +float16 float16_div(float16 a, float16 b, float_status *status)
> +{
> +    flag aSign, bSign, zSign;
> +    int aExp, bExp, zExp;
> +    uint32_t aSig, bSig, zSig;
> +    a = float16_squash_input_denormal(a, status);
> +    b = float16_squash_input_denormal(b, status);
> +
> +    aSig = extractFloat16Frac( a );
> +    aExp = extractFloat16Exp( a );
> +    aSign = extractFloat16Sign( a );
> +    bSig = extractFloat16Frac( b );
> +    bExp = extractFloat16Exp( b );
> +    bSign = extractFloat16Sign( b );
> +    zSign = aSign ^ bSign;
> +    if ( aExp == 0xFF ) {
> +        if (aSig) {
> +            return propagateFloat16NaN(a, b, status);
> +        }
> +        if ( bExp == 0xFF ) {
> +            if (bSig) {
> +                return propagateFloat16NaN(a, b, status);
> +            }
> +            float_raise(float_flag_invalid, status);
> +            return float16_default_nan(status);
> +        }
> +        return packFloat16( zSign, 0xFF, 0 );

All these 0xff should be 0x1f for float16.

> +    if ( bExp == 0 ) {
> +        if ( bSig == 0 ) {
> +            if ( ( aExp | aSig ) == 0 ) {
> +                float_raise(float_flag_invalid, status);
> +                return float16_default_nan(status);
> +            }
> +            float_raise(float_flag_divbyzero, status);
> +            return packFloat16( zSign, 0xFF, 0 );
> +        }
> +        normalizeFloat16Subnormal( bSig, &bExp, &bSig );
> +    }
> +    if ( aExp == 0 ) {
> +        if ( aSig == 0 ) return packFloat16( zSign, 0, 0 );
> +        normalizeFloat16Subnormal( aSig, &aExp, &aSig );
> +    }
> +    zExp = aExp - bExp + 0x7D;

The exponent bias correction is wrong.

> +    aSig = ( aSig | 0x00800000 )<<7;
> +    bSig = ( bSig | 0x00800000 )<<8;

Again, the implicit bit isn't correct, and probably should be explicitly set
for subnormals.

> +    if ( bSig <= ( aSig + aSig ) ) {
> +        aSig >>= 1;
> +        ++zExp;
> +    }
> +    zSig = ( ( (uint64_t) aSig )<<16 ) / bSig;

If you hadn't already shifted by 7 & 8, you wouldn't need to make this a
uint64_t for division.  Indeed, those shift were chosen for float32 so that the
float32 fraction was at the top of the uint32_t.  We then normalize the
operands such that result must be fractional.

> +    if ( ( zSig & 0x3F ) == 0 ) {
> +        zSig |= ( (uint64_t) bSig * zSig != ( (uint64_t) aSig )<<16 );
> +    }

Well, the 0x3f isn't right.  I think ideally we'd use div and mod
unconditionally and let the compiler dtrt, e.g.

  aSig <<= 16;
  q = aSig / bSig;
  r = aSig % bSig;
  zSig = q | (r != 0);


r~
