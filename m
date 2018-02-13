Received: from eggs.gnu.org ([2001:4830:134:3::10]:57326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elcrN-0002tC-5r
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elcrM-0005SY-0P
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:51:09 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:41579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elcrL-0005SH-Q8
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:51:07 -0500
Received: by mail-ot0-x244.google.com with SMTP id r23so17666127ote.8
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:51:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180206164815.10084-23-alex.bennee@linaro.org>
References: <20180206164815.10084-1-alex.bennee@linaro.org>
	<20180206164815.10084-23-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 15:50:46 +0000
Message-ID: <CAFEAcA_Tp9cH5CBi4C6CRHpZ4ozygGSFYhdLaURBQOVZ9zVxvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 22/22] fpu/softfloat: re-factor sqrt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 6 February 2018 at 16:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> This is a little bit of a departure from softfloat's original approach
> as we skip the estimate step in favour of a straight iteration.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v3
>   - added to series
>   - fixed renames of structs
> v4
>   - fix up comments
>   - use is_nan
>   - use return_nan instead of pick_nan(a,a)
> ---
>  fpu/softfloat.c         | 201 ++++++++++++++++++++++--------------------=
------
>  include/fpu/softfloat.h |   1 +
>  2 files changed, 91 insertions(+), 111 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 8fc1c2a8d9..80301d8e04 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1897,6 +1897,96 @@ float64 float64_scalbn(float64 a, int n, float_sta=
tus *status)
>      return float64_round_pack_canonical(pr, status);
>  }
>
> +/*
> + * Square Root
> + *
> + * The old softfloat code did an approximation step before zeroing in
> + * on the final result. However for simpleness we just compute the
> + * square root by iterating down from the implicit bit to enough extra
> + * bits to ensure we get a correctly rounded result.

So is this new approach slower?

> + */
> +
> +static FloatParts sqrt_float(FloatParts a, float_status *s, const FloatF=
mt *p)
> +{
> +    uint64_t a_frac, r_frac, s_frac;
> +    int bit, last_bit;
> +
> +    if (is_nan(a.cls)) {
> +        return return_nan(a, s);
> +    }
> +    if (a.cls =3D=3D float_class_zero) {
> +        return a;  /* sqrt(+-0) =3D +-0 */
> +    }
> +    if (a.sign) {
> +        s->float_exception_flags |=3D float_flag_invalid;
> +        a.cls =3D float_class_dnan;
> +        return a;
> +    }
> +    if (a.cls =3D=3D float_class_inf) {
> +        return a;  /* sqrt(+inf) =3D +inf */
> +    }
> +
> +    assert(a.cls =3D=3D float_class_normal);
> +
> +    /* We need two overflow bits at the top.  Adding room for that is
> +       a right shift.  If the exponent is odd, we can discard the low
> +       bit by multiplying the fraction by 2; that's a left shift.
> +       Combine those and we shift right if the exponent is even.  */
> +    a_frac =3D a.frac;
> +    if (!(a.exp & 1)) {
> +        a_frac >>=3D 1;
> +    }
> +    a.exp >>=3D 1;

Comment says "shift right if the exponent is even", but code
says "shift right by 1 if exponent is odd, by 2 if exponent is even".

> +
> +    /* Bit-by-bit computation of sqrt.  */
> +    r_frac =3D 0;
> +    s_frac =3D 0;
> +
> +    /* Iterate from implicit bit down to the 3 extra bits to compute a
> +     * properly rounded result.  Remember we've inserted one more bit
> +     * at the top, so these positions are one less.  */

Some consistency in multiline comment formatting would be nice.
The top-of-function header and these two in the body of
the function have 3 different styles between them...

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
