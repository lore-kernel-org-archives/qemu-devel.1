Received: from eggs.gnu.org ([2001:4830:134:3::10]:58487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7hrw-0000VF-AW
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7hrl-0002cl-6T
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:11:09 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7hrk-0002Zw-Q4
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:11:05 -0400
Received: by mail-oi1-x243.google.com with SMTP id p125-v6so4628308oic.3
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 07:10:58 -0700 (PDT)
References: <20181002195347.26712-1-richard.henderson@linaro.org>
	<87ftxnl6ps.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7a6d2dc6-76e7-cc4d-9df3-834252c14890@linaro.org>
Date: Wed, 3 Oct 2018 09:10:53 -0500
MIME-Version: 1.0
In-Reply-To: <87ftxnl6ps.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] softfloat: Fix division
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, cota@braap.org

On 10/3/18 4:28 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> The __udiv_qrnnd primitive that we nicked from gmp requires its
>> inputs to be normalized.  We were not doing that.  Because the
>> inputs are nearly normalized already, finishing that is trivial.
>> Inline div128to64 into its one user, because it is no longer a
>> general-purpose routine.
>>
>> Fixes: cf07323d494
>> Fixes: https://bugs.launchpad.net/qemu/+bug/1793119
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  include/fpu/softfloat-macros.h | 48 -----------------------
>>  fpu/softfloat.c                | 72 ++++++++++++++++++++++++++++++----
>>  2 files changed, 64 insertions(+), 56 deletions(-)
>>
>> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
>> index 35e1603a5e..f29426ac46 100644
>> --- a/include/fpu/softfloat-macros.h
>> +++ b/include/fpu/softfloat-macros.h
>> @@ -625,54 +625,6 @@ static inline uint64_t estimateDiv128To64(uint64_t a0, uint64_t a1, uint64_t b)
>>
>>  }
>>
>> -/* From the GNU Multi Precision Library - longlong.h __udiv_qrnnd
>> - * (https://gmplib.org/repo/gmp/file/tip/longlong.h)
>> - *
>> - * Licensed under the GPLv2/LGPLv3
>> - */
>> -static inline uint64_t div128To64(uint64_t n0, uint64_t n1, uint64_t d)
>> -{
>> -    uint64_t d0, d1, q0, q1, r1, r0, m;
>> -
>> -    d0 = (uint32_t)d;
>> -    d1 = d >> 32;
>> -
>> -    r1 = n1 % d1;
>> -    q1 = n1 / d1;
>> -    m = q1 * d0;
>> -    r1 = (r1 << 32) | (n0 >> 32);
>> -    if (r1 < m) {
>> -        q1 -= 1;
>> -        r1 += d;
>> -        if (r1 >= d) {
>> -            if (r1 < m) {
>> -                q1 -= 1;
>> -                r1 += d;
>> -            }
>> -        }
>> -    }
>> -    r1 -= m;
>> -
>> -    r0 = r1 % d1;
>> -    q0 = r1 / d1;
>> -    m = q0 * d0;
>> -    r0 = (r0 << 32) | (uint32_t)n0;
>> -    if (r0 < m) {
>> -        q0 -= 1;
>> -        r0 += d;
>> -        if (r0 >= d) {
>> -            if (r0 < m) {
>> -                q0 -= 1;
>> -                r0 += d;
>> -            }
>> -        }
>> -    }
>> -    r0 -= m;
>> -
>> -    /* Return remainder in LSB */
>> -    return (q1 << 32) | q0 | (r0 != 0);
>> -}
>> -
>>  /*----------------------------------------------------------------------------
>>  | Returns an approximation to the square root of the 32-bit significand given
>>  | by `a'.  Considered as an integer, `a' must be at least 2^31.  If bit 0 of
>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>> index 9405f12a03..93edc06996 100644
>> --- a/fpu/softfloat.c
>> +++ b/fpu/softfloat.c
>> @@ -1112,19 +1112,75 @@ static FloatParts div_floats(FloatParts a, FloatParts b, float_status *s)
>>      bool sign = a.sign ^ b.sign;
>>
>>      if (a.cls == float_class_normal && b.cls == float_class_normal) {
>> -        uint64_t temp_lo, temp_hi;
>> +        uint64_t n0, n1, d0, d1, q0, q1, r1, r0, m, d;
>>          int exp = a.exp - b.exp;
>> +
>> +        /*
>> +         * We want the 2*N / N-bit division to produce exactly an N-bit
>> +         * result, so that we do not have to renormalize afterward.
>> +         * If A < B, then division would produce an (N-1)-bit result;
>> +         * shift A left by one to produce the an N-bit result, and
>> +         * decrement the exponent to match.
>> +         *
>> +         * The udiv_qrnnd algorithm that we're using requires normalization,
>> +         * i.e. the msb of the denominator must be set.  Since we know that
>> +         * DECOMPOSED_BINARY_POINT is msb-1, everything must be shifted left
>> +         * by one more.
>> +         */
>>          if (a.frac < b.frac) {
>>              exp -= 1;
>> -            shortShift128Left(0, a.frac, DECOMPOSED_BINARY_POINT + 1,
>> -                              &temp_hi, &temp_lo);
>> +            shortShift128Left(0, a.frac, DECOMPOSED_BINARY_POINT + 2, &n1, &n0);
>>          } else {
>> -            shortShift128Left(0, a.frac, DECOMPOSED_BINARY_POINT,
>> -                              &temp_hi, &temp_lo);
>> +            shortShift128Left(0, a.frac, DECOMPOSED_BINARY_POINT + 1, &n1, &n0);
>>          }
>> -        /* LSB of quot is set if inexact which roundandpack will use
>> -         * to set flags. Yet again we re-use a for the result */
>> -        a.frac = div128To64(temp_lo, temp_hi, b.frac);
>> +        d = b.frac << 1;
>> +
>> +        /*
>> +         * From the GNU Multi Precision Library - longlong.h __udiv_qrnnd
>> +         * (https://gmplib.org/repo/gmp/file/tip/longlong.h)
>> +         * Licensed under the GPLv2/LGPLv3.
>> +         */
>> +        d0 = (uint32_t)d;
>> +        d1 = d >> 32;
>> +
>> +        r1 = n1 % d1;
>> +        q1 = n1 / d1;
>> +        m = q1 * d0;
>> +        r1 = (r1 << 32) | (n0 >> 32);
>> +        if (r1 < m) {
>> +            q1 -= 1;
>> +            r1 += d;
>> +            if (r1 >= d) {
>> +                if (r1 < m) {
>> +                    q1 -= 1;
>> +                    r1 += d;
>> +                }
>> +            }
>> +        }
>> +        r1 -= m;
>> +
>> +        r0 = r1 % d1;
>> +        q0 = r1 / d1;
>> +        m = q0 * d0;
>> +        r0 = (r0 << 32) | (uint32_t)n0;
>> +        if (r0 < m) {
>> +            q0 -= 1;
>> +            r0 += d;
>> +            if (r0 >= d) {
>> +                if (r0 < m) {
>> +                    q0 -= 1;
>> +                    r0 += d;
>> +                }
>> +            }
>> +        }
>> +        r0 -= m;
>> +        /* End of __udiv_qrnnd.  */
>> +
>> +        /* Adjust remainder for normalization step.  */
>> +        r0 >>= 1;
>> +
>> +        /* Set lsb if there is a remainder, to set inexact.  */
>> +        a.frac = (q1 << 32) | q0 | (r0 != 0);
>>          a.sign = sign;
>>          a.exp = exp;
>>          return a;
> 
> I guess if we get to the 80 bit stuff this will need to be commonised
> again?

I suppose I could leave it separate as udiv_qrnnd, and not try to pretend it's
a full division operation as we did before.  Because, yes, we'd probably use it
in forming the 256/128-bit division we'd need for float128 (and that floatx80
would hang off).


r~
