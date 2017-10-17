Received: from eggs.gnu.org ([2001:4830:134:3::10]:33947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4HRj-0001BF-MO
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 22:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4HRg-0002kt-IU
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 22:17:31 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:43403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4HRg-0002kH-BV
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 22:17:28 -0400
Received: by mail-pf0-x22c.google.com with SMTP id a8so229116pfc.0
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 19:17:28 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-24-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4ea7a069-0a84-d5fa-e75a-82e429ab9705@linaro.org>
Date: Mon, 16 Oct 2017 19:17:23 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-24-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 23/30] softfloat: add float16_rem and
 float16_muladd (!CHECK)
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
> +float16 float16_rem(float16 a, float16 b, float_status *status)
> +{
> +    flag aSign, zSign;
> +    int aExp, bExp, expDiff;
> +    uint32_t aSig, bSig;
> +    uint32_t q;
> +    uint64_t aSig64, bSig64, q64;
> +    uint32_t alternateASig;
> +    int32_t sigMean;
> +    a = float16_squash_input_denormal(a, status);
> +    b = float16_squash_input_denormal(b, status);
> +
> +    aSig = extractFloat32Frac( a );
> +    aExp = extractFloat32Exp( a );
> +    aSign = extractFloat32Sign( a );
> +    bSig = extractFloat32Frac( b );
> +    bExp = extractFloat32Exp( b );
> +    if ( aExp == 0xFF ) {
> +        if ( aSig || ( ( bExp == 0xFF ) && bSig ) ) {
> +            return propagateFloat32NaN(a, b, status);
> +        }
> +        float_raise(float_flag_invalid, status);
> +        return float16_default_nan(status);
> +    }
> +    if ( bExp == 0xFF ) {
> +        if (bSig) {
> +            return propagateFloat32NaN(a, b, status);
> +        }
> +        return a;
> +    }

s/0xff/0x1f/.

> +    if ( bExp == 0 ) {
> +        if ( bSig == 0 ) {
> +            float_raise(float_flag_invalid, status);
> +            return float16_default_nan(status);
> +        }
> +        normalizeFloat32Subnormal( bSig, &bExp, &bSig );
> +    }
> +    if ( aExp == 0 ) {
> +        if ( aSig == 0 ) return a;
> +        normalizeFloat32Subnormal( aSig, &aExp, &aSig );
> +    }
> +    expDiff = aExp - bExp;
> +    aSig |= 0x00800000;
> +    bSig |= 0x00800000;

These implicit bits are set for float32.

> +    if ( expDiff < 32 ) {
> +        aSig <<= 8;
> +        bSig <<= 8;

This algorithm isn't going to work unless the fractions are normalized to
0b1xxx_xxxx_xxx0_0000, just like for float32.  Indeed, I think you should
actually share code.

> +    return normalizeRoundAndPackFloat32(aSign ^ zSign, bExp, aSig, status);

... but you really will have to pack into the correct format.

> +    if (((aExp == 0xff) && aSig) ||
> +        ((bExp == 0xff) && bSig) ||
> +        ((cExp == 0xff) && cSig)) {

0x1f, lots more times.

> +    /* Calculate the actual result a * b + c */
> +
> +    /* Multiply first; this is easy. */
> +    /* NB: we subtract 0x7e where float16_mul() subtracts 0x7f
> +     * because we want the true exponent, not the "one-less-than"
> +     * flavour that roundAndPackFloat16() takes.
> +     */
> +    pExp = aExp + bExp - 0x7e;
> +    aSig = (aSig | 0x00800000) << 7;
> +    bSig = (bSig | 0x00800000) << 8;

All of these constants are for float32, not float16.


r~
