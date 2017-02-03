Received: from eggs.gnu.org ([2001:4830:134:3::10]:46855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZf2Q-0000b7-8T
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZf2O-00041I-G8
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:40:34 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZf2O-00040g-76
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:40:32 -0500
Received: by mail-wm0-x22d.google.com with SMTP id r141so30498717wmg.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 06:40:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485946146-21639-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1485946146-21639-1-git-send-email-bharata@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 14:40:09 +0000
Message-ID: <CAFEAcA_gno6etAWKkssBYSzYethD7_qNQh6CJCdviTNPqn2x9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH v0] softfloat: Add
 float128_to_uint64_round_to_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 1 February 2017 at 10:49, Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> Implement float128_to_uint64() and use that to implement
> float128_to_uint64_round_to_zero()
>
> This is required by xscvqpudz instruction of PowerPC ISA 3.0.
>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  fpu/softfloat.c         | 65 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/fpu/softfloat.h |  2 ++
>  2 files changed, 67 insertions(+)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index c295f31..49a06c5 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -6110,6 +6110,71 @@ int64_t float128_to_int64_round_to_zero(float128 a, float_status *status)
>
>  /*----------------------------------------------------------------------------
>  | Returns the result of converting the quadruple-precision floating-point
> +| value `a' to the 64-bit unsigned integer format.  The conversion
> +| is performed according to the IEC/IEEE Standard for Binary Floating-Point
> +| Arithmetic---which means in particular that the conversion is rounded
> +| according to the current rounding mode.  If `a' is a NaN, the largest
> +| positive integer is returned.  Otherwise, if the conversion overflows, the
> +| largest unsigned integer is returned. If 'a' is negative, the value is
> +| rounded and zero is returned; negative values that do not round to zero
> +| will raise the inexact exception.
> +*----------------------------------------------------------------------------*/
> +
> +uint64_t float128_to_uint64(float128 a, float_status *status)
> +{
> +    flag aSign;
> +    int32_t aExp, shiftCount;
> +    uint64_t aSig0, aSig1;

I think we should have a float128_squash_input_denormal() function
which we call here (compare float64_to_uint64).

> +
> +    aSig1 = extractFloat128Frac1( a );

Can you use the QEMU coding style for this rather than following
the softfloat weird one, please?

> +    aSig0 = extractFloat128Frac0( a );
> +    aExp = extractFloat128Exp( a );
> +    aSign = extractFloat128Sign( a );
> +    if ( aExp ) aSig0 |= LIT64( 0x0001000000000000 );
> +    shiftCount = 0x402F - aExp;
> +    if ( shiftCount <= 0 ) {
> +        if ( 0x403E < aExp ) {
> +            float_raise(float_flag_invalid, status);
> +            if (    ! aSign
> +                 || (    ( aExp == 0x7FFF )
> +                      && ( aSig1 || ( aSig0 != LIT64( 0x0001000000000000 ) ) )
> +                    )
> +               ) {
> +                return LIT64( 0xFFFFFFFFFFFFFFFF );
> +            }
> +            return 0;
> +        }
> +        shortShift128Left( aSig0, aSig1, - shiftCount, &aSig0, &aSig1 );
> +    }
> +    else {
> +        shift64ExtraRightJamming( aSig0, aSig1, shiftCount, &aSig0, &aSig1 );
> +    }
> +    return roundAndPackUint64(aSign, aSig0, aSig1, status);

I'm finding this a bit difficult to understand, because it doesn't
follow the code pattern of (for instance) float64_to_uint64().
Is it based on some other existing function?

> +}
> +
> +/*----------------------------------------------------------------------------
> +| Returns the result of converting the quadruple-precision floating-point
> +| value `a' to the 64-bit unsigned integer format.  The conversion
> +| is performed according to the IEC/IEEE Standard for Binary Floating-Point
> +| Arithmetic, except that the conversion is always rounded toward zero.
> +| according to the current rounding mode.  If `a' is a NaN, the largest
> +| positive integer is returned.  Otherwise, if the conversion overflows, the
> +| largest unsigned integer is returned. If 'a' is negative, the value is
> +| rounded and zero is returned; negative values that do not round to zero
> +| will raise the inexact exception.
> +*----------------------------------------------------------------------------*/
> +
> +uint64_t float128_to_uint64_round_to_zero(float128 a, float_status *status)
> +{
> +    signed char current_rounding_mode = status->float_rounding_mode;
> +    set_float_rounding_mode(float_round_to_zero, status);
> +    uint64_t v = float128_to_uint64(a, status);
> +    set_float_rounding_mode(current_rounding_mode, status);
> +    return v;
> +}

This function is OK, though our coding style would suggest putting
the declaration of 'uint64_t v;' at the top of the function.

> +
> +/*----------------------------------------------------------------------------
> +| Returns the result of converting the quadruple-precision floating-point
>  | value `a' to the single-precision floating-point format.  The conversion
>  | is performed according to the IEC/IEEE Standard for Binary Floating-Point
>  | Arithmetic.
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 842ec6b..4e99253 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -712,6 +712,8 @@ int32_t float128_to_int32(float128, float_status *status);
>  int32_t float128_to_int32_round_to_zero(float128, float_status *status);
>  int64_t float128_to_int64(float128, float_status *status);
>  int64_t float128_to_int64_round_to_zero(float128, float_status *status);
> +uint64_t float128_to_uint64(float128, float_status *status);
> +uint64_t float128_to_uint64_round_to_zero(float128, float_status *status);
>  float32 float128_to_float32(float128, float_status *status);
>  float64 float128_to_float64(float128, float_status *status);
>  floatx80 float128_to_floatx80(float128, float_status *status);
> --
> 2.7.4

thanks
-- PMM
