Received: from eggs.gnu.org ([2001:4830:134:3::10]:43925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elcI4-0003yI-Sv
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:14:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elcI3-0002Go-Ns
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:14:40 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:38811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elcI3-0002GM-Ge
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:14:39 -0500
Received: by mail-ot0-x244.google.com with SMTP id h14so17548690otj.5
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:14:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180206164815.10084-17-alex.bennee@linaro.org>
References: <20180206164815.10084-1-alex.bennee@linaro.org>
	<20180206164815.10084-17-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 15:14:18 +0000
Message-ID: <CAFEAcA87C7qahZ9UYKXPR6qNthNXp3wJSBA9XsJNLkW-tSH2pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 16/22] fpu/softfloat: re-factor
 round_to_int
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
> We can now add float16_round_to_int and use the common round_decomposed a=
nd
> canonicalize functions to have a single implementation for
> float16/32/64 round_to_int functions.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v3
>   - rename structures and functions
> v4
>   - move NaN handling to return NaN
> ---
>  fpu/softfloat.c         | 322 ++++++++++++++++++++++--------------------=
------
>  include/fpu/softfloat.h |   1 +
>  2 files changed, 148 insertions(+), 175 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index ae4ba6de51..5d04e65538 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -560,7 +560,26 @@ static bool is_qnan(FloatClass c)
>      return c =3D=3D float_class_qnan;
>  }
>
> -static FloatParts pick_nan(FloatParts a, FloatParts b, float_status *s)
> +static inline FloatParts return_nan(FloatParts a, float_status *s)
> +{
> +    switch (a.cls) {
> +    case float_class_snan:
> +        s->float_exception_flags |=3D float_flag_invalid;
> +        a.cls =3D float_class_msnan;
> +        /* FALLTHRU */

"/* fall through */" is the usual way of spelling it in QEMU
(255 instances vs 60).

> +    case float_class_qnan:
> +        if (s->default_nan_mode) {
> +            a.cls =3D float_class_dnan;
> +        }
> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return a;
> +}
> +
> +static inline FloatParts pick_nan(FloatParts a, FloatParts b, float_stat=
us *s)
>  {
>      if (is_snan(a.cls) || is_snan(b.cls)) {
>          s->float_exception_flags |=3D float_flag_invalid;

This hunk looks a bit weird because the patch is also adding
an "inline" qualifier to pick_nan(). Should that have been in an
earlier patch (eg "fpu/softfloat: re-factor add/sub" where the
pick_nan() function was added) ?

> @@ -1175,6 +1194,133 @@ float64 float64_div(float64 a, float64 b, float_s=
tatus *status)
>      return float64_round_pack_canonical(pr, status);
>  }
>
> +/*
> + * Rounds the floating-point value `a' to an integer, and returns the
> + * result as a floating-point value. The operation is performed
> + * according to the IEC/IEEE Standard for Binary Floating-Point
> + * Arithmetic.
> + */
> +
> +static FloatParts round_to_int(FloatParts a, int rounding_mode, float_st=
atus *s)
> +{
> +    if (is_nan(a.cls)) {
> +        return return_nan(a, s);
> +    }
> +
> +    switch (a.cls) {
> +    case float_class_zero:
> +    case float_class_inf:
> +    case float_class_qnan:
> +        /* already "integral" */
> +        break;
> +    case float_class_normal:
> +        if (a.exp >=3D DECOMPOSED_BINARY_POINT) {
> +            /* already integral */
> +            break;
> +        }
> +        if (a.exp < 0) {
> +            bool one;
> +            /* all fractional */
> +            s->float_exception_flags |=3D float_flag_inexact;
> +            switch (rounding_mode) {
> +            case float_round_nearest_even:
> +                one =3D a.exp =3D=3D -1 && a.frac > DECOMPOSED_IMPLICIT_=
BIT;
> +                break;
> +            case float_round_ties_away:
> +                one =3D a.exp =3D=3D -1 && a.frac >=3D DECOMPOSED_IMPLIC=
IT_BIT;
> +                break;
> +            case float_round_to_zero:
> +                one =3D false;
> +                break;
> +            case float_round_up:
> +                one =3D !a.sign;
> +                break;
> +            case float_round_down:
> +                one =3D a.sign;
> +                break;
> +            default:
> +                g_assert_not_reached();
> +            }
> +
> +            if (one) {
> +                a.frac =3D DECOMPOSED_IMPLICIT_BIT;
> +                a.exp =3D 0;
> +            } else {
> +                a.cls =3D float_class_zero;
> +            }
> +        } else {
> +            uint64_t frac_lsb, frac_lsbm1, round_mask, roundeven_mask, i=
nc;
> +
> +            frac_lsb =3D DECOMPOSED_IMPLICIT_BIT >> a.exp;
> +            frac_lsbm1 =3D frac_lsb >> 1;
> +            roundeven_mask =3D (frac_lsb - 1) | frac_lsb;
> +            round_mask =3D roundeven_mask >> 1;
> +
> +            switch (rounding_mode) {
> +            case float_round_nearest_even:
> +                inc =3D ((a.frac & roundeven_mask) !=3D frac_lsbm1 ? fra=
c_lsbm1 : 0);

This is that long line...

> +                break;

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
