Received: from eggs.gnu.org ([2001:4830:134:3::10]:33172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea1hz-0001Ep-Ko
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 10:57:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea1hx-00031j-Bc
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 10:57:31 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:33153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ea1hx-0002zs-23
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 10:57:29 -0500
Received: by mail-ot0-x230.google.com with SMTP id x15so5420545ote.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 07:57:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-12-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-12-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 15:57:07 +0000
Message-ID: <CAFEAcA-3nkmeJMHFqMeiwZtQycmieXdPiaCvKZsFuKY3MqtdCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/20] fpu/softfloat: re-factor add/sub
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

On 9 January 2018 at 12:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
> We can now add float16_add/sub and use the common decompose and
> canonicalize functions to have a single implementation for
> float16/32/64 add and sub functions.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c         | 904 +++++++++++++++++++++++++-----------------=
------
>  include/fpu/softfloat.h |   4 +
>  2 files changed, 481 insertions(+), 427 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index fcba28d3f8..f89e47e3ef 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -195,7 +195,7 @@ typedef enum {
>      float_class_zero,
>      float_class_normal,
>      float_class_inf,
> -    float_class_qnan,
> +    float_class_qnan,  /* all NaNs from here */

This comment change should be squashed into the previous patch.

>      float_class_snan,
>      float_class_dnan,
>      float_class_msnan, /* maybe silenced */
> @@ -254,6 +254,482 @@ static const decomposed_params float64_params =3D {
>      FRAC_PARAMS(DECOMPOSED_BINARY_POINT - 52)
>  };
>
> +/* Unpack a float16 to parts, but do not canonicalize.  */
> +static inline decomposed_parts float16_unpack_raw(float16 f)
> +{
> +    return (decomposed_parts){
> +        .cls =3D float_class_unclassified,
> +        .sign =3D extract32(f, 15, 1),
> +        .exp =3D extract32(f, 10, 5),
> +        .frac =3D extract32(f, 0, 10)

In the previous patch we defined a bunch of structs that
give information about each float format, so it seems a bit
odd to be hardcoding bit numbers here.

> +    };
> +}
> +
> +/* Unpack a float32 to parts, but do not canonicalize.  */
> +static inline decomposed_parts float32_unpack_raw(float32 f)
> +{
> +    return (decomposed_parts){
> +        .cls =3D float_class_unclassified,
> +        .sign =3D extract32(f, 31, 1),
> +        .exp =3D extract32(f, 23, 8),
> +        .frac =3D extract32(f, 0, 23)
> +    };
> +}
> +
> +/* Unpack a float64 to parts, but do not canonicalize.  */
> +static inline decomposed_parts float64_unpack_raw(float64 f)
> +{
> +    return (decomposed_parts){
> +        .cls =3D float_class_unclassified,
> +        .sign =3D extract64(f, 63, 1),
> +        .exp =3D extract64(f, 52, 11),
> +        .frac =3D extract64(f, 0, 52),
> +    };
> +}
> +
> +/* Pack a float32 from parts, but do not canonicalize.  */
> +static inline float16 float16_pack_raw(decomposed_parts p)
> +{
> +    uint32_t ret =3D p.frac;
> +    ret =3D deposit32(ret, 10, 5, p.exp);
> +    ret =3D deposit32(ret, 15, 1, p.sign);
> +    return make_float16(ret);
> +}
> +
> +/* Pack a float32 from parts, but do not canonicalize.  */
> +static inline float32 float32_pack_raw(decomposed_parts p)
> +{
> +    uint32_t ret =3D p.frac;
> +    ret =3D deposit32(ret, 23, 8, p.exp);
> +    ret =3D deposit32(ret, 31, 1, p.sign);
> +    return make_float32(ret);
> +}
> +
> +/* Pack a float64 from parts, but do not canonicalize.  */
> +static inline float64 float64_pack_raw(decomposed_parts p)
> +{
> +    uint64_t ret =3D p.frac;
> +    ret =3D deposit64(ret, 52, 11, p.exp);
> +    ret =3D deposit64(ret, 63, 1, p.sign);
> +    return make_float64(ret);
> +}
> +
> +/* Canonicalize EXP and FRAC, setting CLS.  */
> +static decomposed_parts decomposed_canonicalize(decomposed_parts part,
> +                                        const decomposed_params *parm,

If you pick more compact names for your decomposed_params and
decomposed_parts structs, you won't have such awkwardness trying
to format function prototypes. (checkpatch complains that you have
an overlong line somewhere in this patch for this reason.)

In particular "decomposed_params" I think should change -- it's
confusingly similar to decomposed_parts, and it isn't really
a decomposed anything. It's just a collection of useful information
describing the float format. Try 'fmtinfo', maybe?

I see we're passing and returning decomposed_parts structs everywhere
rather than pointers to them. How well does that compile? (I guess
everything ends up inlining...)

> +                                        float_status *status)
> +{
> +    if (part.exp =3D=3D parm->exp_max) {
> +        if (part.frac =3D=3D 0) {
> +            part.cls =3D float_class_inf;
> +        } else {
> +#ifdef NO_SIGNALING_NANS

The old code didn't seem to need to ifdef this; why's the new
code different? (at some point we'll want to make this a runtime
setting so we can support one binary handling CPUs with it both
set and unset, but that is a far future thing we can ignore for now)

> +            part.cls =3D float_class_qnan;
> +#else
> +            int64_t msb =3D part.frac << (parm->frac_shift + 2);
> +            if ((msb < 0) =3D=3D status->snan_bit_is_one) {
> +                part.cls =3D float_class_snan;
> +            } else {
> +                part.cls =3D float_class_qnan;
> +            }
> +#endif
> +        }
> +    } else if (part.exp =3D=3D 0) {
> +        if (likely(part.frac =3D=3D 0)) {
> +            part.cls =3D float_class_zero;
> +        } else if (status->flush_inputs_to_zero) {
> +            float_raise(float_flag_input_denormal, status);
> +            part.cls =3D float_class_zero;
> +            part.frac =3D 0;
> +        } else {
> +            int shift =3D clz64(part.frac) - 1;
> +            part.cls =3D float_class_normal;

This is really confusing. This is a *denormal*, but we're setting
the classification to "normal" ? (It's particularly confusing in
the code that uses the decomposed numbers, because it looks like
"if (a.cls =3D=3D float_class_normal...)" is handling the normal-number
case and denormals are going to be in a later if branch, but actually
it's dealing with both.)

> +            part.exp =3D parm->frac_shift - parm->exp_bias - shift + 1;
> +            part.frac <<=3D shift;
> +        }
> +    } else {
> +        part.cls =3D float_class_normal;
> +        part.exp -=3D parm->exp_bias;
> +        part.frac =3D DECOMPOSED_IMPLICIT_BIT + (part.frac << parm->frac=
_shift);
> +    }
> +    return part;
> +}
> +
> +/* Round and uncanonicalize a floating-point number by parts.
> +   There are FRAC_SHIFT bits that may require rounding at the bottom
> +   of the fraction; these bits will be removed.  The exponent will be
> +   biased by EXP_BIAS and must be bounded by [EXP_MAX-1, 0].  */

This is an inconsistent multiline comment style to what you use
elsewhere in this patch...

> +static decomposed_parts decomposed_round_canonical(decomposed_parts p,
> +                                                   float_status *s,
> +                                                   const decomposed_para=
ms *parm)
> +{
> +    const uint64_t frac_lsbm1 =3D parm->frac_lsbm1;
> +    const uint64_t round_mask =3D parm->round_mask;
> +    const uint64_t roundeven_mask =3D parm->roundeven_mask;
> +    const int exp_max =3D parm->exp_max;
> +    const int frac_shift =3D parm->frac_shift;
> +    uint64_t frac, inc;
> +    int exp, flags =3D 0;
> +    bool overflow_norm;
> +
> +    frac =3D p.frac;
> +    exp =3D p.exp;
> +
> +    switch (p.cls) {
> +    case float_class_normal:
> +        switch (s->float_rounding_mode) {
> +        case float_round_nearest_even:
> +            overflow_norm =3D false;
> +            inc =3D ((frac & roundeven_mask) !=3D frac_lsbm1 ? frac_lsbm=
1 : 0);
> +            break;
> +        case float_round_ties_away:
> +            overflow_norm =3D false;
> +            inc =3D frac_lsbm1;
> +            break;
> +        case float_round_to_zero:
> +            overflow_norm =3D true;
> +            inc =3D 0;
> +            break;
> +        case float_round_up:
> +            inc =3D p.sign ? 0 : round_mask;
> +            overflow_norm =3D p.sign;
> +            break;
> +        case float_round_down:
> +            inc =3D p.sign ? round_mask : 0;
> +            overflow_norm =3D !p.sign;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +
> +        exp +=3D parm->exp_bias;
> +        if (likely(exp > 0)) {
> +            if (frac & round_mask) {
> +                flags |=3D float_flag_inexact;
> +                frac +=3D inc;
> +                if (frac & DECOMPOSED_OVERFLOW_BIT) {
> +                    frac >>=3D 1;
> +                    exp++;
> +                }
> +            }
> +            frac >>=3D frac_shift;
> +
> +            if (unlikely(exp >=3D exp_max)) {
> +                flags |=3D float_flag_overflow | float_flag_inexact;
> +                if (overflow_norm) {
> +                    exp =3D exp_max - 1;
> +                    frac =3D -1;
> +                } else {
> +                    p.cls =3D float_class_inf;
> +                    goto do_inf;
> +                }
> +            }
> +        } else if (s->flush_to_zero) {
> +            flags |=3D float_flag_output_denormal;
> +            p.cls =3D float_class_zero;
> +            goto do_zero;
> +        } else {
> +            bool is_tiny =3D (s->float_detect_tininess
> +                            =3D=3D float_tininess_before_rounding)
> +                        || (exp < 0)
> +                        || !((frac + inc) & DECOMPOSED_OVERFLOW_BIT);
> +
> +            shift64RightJamming(frac, 1 - exp, &frac);
> +            if (frac & round_mask) {
> +                /* Need to recompute round-to-even.  */
> +                if (s->float_rounding_mode =3D=3D float_round_nearest_ev=
en) {
> +                    inc =3D ((frac & roundeven_mask) !=3D frac_lsbm1
> +                           ? frac_lsbm1 : 0);
> +                }
> +                flags |=3D float_flag_inexact;
> +                frac +=3D inc;
> +            }
> +
> +            exp =3D (frac & DECOMPOSED_IMPLICIT_BIT ? 1 : 0);
> +            frac >>=3D frac_shift;
> +
> +            if (is_tiny && (flags & float_flag_inexact)) {
> +                flags |=3D float_flag_underflow;
> +            }
> +            if (exp =3D=3D 0 && frac =3D=3D 0) {
> +                p.cls =3D float_class_zero;
> +            }
> +        }
> +        break;
> +
> +    case float_class_zero:
> +    do_zero:
> +        exp =3D 0;
> +        frac =3D 0;
> +        break;
> +
> +    case float_class_inf:
> +    do_inf:
> +        exp =3D exp_max;
> +        frac =3D 0;
> +        break;
> +
> +    case float_class_qnan:
> +    case float_class_snan:
> +        exp =3D exp_max;
> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    float_raise(flags, s);
> +    p.exp =3D exp;
> +    p.frac =3D frac;
> +    return p;
> +}
> +
> +static decomposed_parts float16_unpack_canonical(float16 f, float_status=
 *s)
> +{
> +    return decomposed_canonicalize(float16_unpack_raw(f), &float16_param=
s, s);
> +}
> +
> +static float16 float16_round_pack_canonical(decomposed_parts p, float_st=
atus *s)
> +{
> +    switch (p.cls) {
> +    case float_class_dnan:
> +        return float16_default_nan(s);
> +    case float_class_msnan:
> +        return float16_maybe_silence_nan(float16_pack_raw(p), s);

I think you will find that doing the silencing of the NaNs like this
isn't quite the right approach. Specifically, for Arm targets we
currently have a bug in float-to-float conversion from a wider
format to a narrower one when the input is a signaling NaN that we
want to silence, and its non-zero mantissa bits are all at the
less-significant end of the mantissa such that they don't fit into
the narrower format. If you pack the float into a float16 first and
then call maybe_silence_nan() on it you've lost the info about those
low bits which the silence function needs to know to return the
right answer. What you want to do instead is pass the silence_nan
function the decomposed value.

(The effect of this bug is that we return a default NaN, with the
sign bit clear, but the Arm FPConvertNaN pseudocode says that we
should effectively get the default NaN but with the same sign bit
as the input SNaN.)

Given that this is a bug currently in the version we have, we don't
necessarily need to fix it now, but I thought I'd mention it since
the redesign has almost but not quite managed to deliver the right
information to the silencing code to allow us to fix it soon :-)

> +    default:
> +        p =3D decomposed_round_canonical(p, s, &float16_params);
> +        return float16_pack_raw(p);
> +    }
> +}
> +
> +static decomposed_parts float32_unpack_canonical(float32 f, float_status=
 *s)
> +{
> +    return decomposed_canonicalize(float32_unpack_raw(f), &float32_param=
s, s);
> +}
> +
> +static float32 float32_round_pack_canonical(decomposed_parts p, float_st=
atus *s)
> +{
> +    switch (p.cls) {
> +    case float_class_dnan:
> +        return float32_default_nan(s);
> +    case float_class_msnan:
> +        return float32_maybe_silence_nan(float32_pack_raw(p), s);
> +    default:
> +        p =3D decomposed_round_canonical(p, s, &float32_params);
> +        return float32_pack_raw(p);
> +    }
> +}
> +
> +static decomposed_parts float64_unpack_canonical(float64 f, float_status=
 *s)
> +{
> +    return decomposed_canonicalize(float64_unpack_raw(f), &float64_param=
s, s);
> +}
> +
> +static float64 float64_round_pack_canonical(decomposed_parts p, float_st=
atus *s)
> +{
> +    switch (p.cls) {
> +    case float_class_dnan:
> +        return float64_default_nan(s);
> +    case float_class_msnan:
> +        return float64_maybe_silence_nan(float64_pack_raw(p), s);
> +    default:
> +        p =3D decomposed_round_canonical(p, s, &float64_params);
> +        return float64_pack_raw(p);
> +    }
> +}
> +
> +static decomposed_parts pick_nan_parts(decomposed_parts a, decomposed_pa=
rts b,
> +                                       float_status *s)
> +{
> +    if (a.cls =3D=3D float_class_snan || b.cls =3D=3D float_class_snan) =
{
> +        s->float_exception_flags |=3D float_flag_invalid;
> +    }
> +
> +    if (s->default_nan_mode) {
> +        a.cls =3D float_class_dnan;
> +    } else {
> +        if (pickNaN(a.cls =3D=3D float_class_qnan,
> +                    a.cls =3D=3D float_class_snan,
> +                    b.cls =3D=3D float_class_qnan,
> +                    b.cls =3D=3D float_class_snan,
> +                    a.frac > b.frac
> +                    || (a.frac =3D=3D b.frac && a.sign < b.sign))) {
> +            a =3D b;
> +        }
> +        a.cls =3D float_class_msnan;
> +    }
> +    return a;
> +}
> +
> +
> +/*
> + * Returns the result of adding the absolute values of the
> + * floating-point values `a' and `b'. If `subtract' is set, the sum is
> + * negated before being returned. `subtract' is ignored if the result
> + * is a NaN. The addition is performed according to the IEC/IEEE
> + * Standard for Binary Floating-Point Arithmetic.
> + */

This comment doesn't seem to match what the code is doing,
because it says it adds the absolute values of 'a' and 'b',
but the code looks at a_sign and b_sign to decide whether it's
doing an addition or subtraction rather than ignoring the signs
(as you would for absolute arithmetic).

Put another way, this comment has been copied from the old addFloat64Sigs()
and not updated to account for the way the new function includes handling
of subFloat64Sigs().

> +
> +static decomposed_parts add_decomposed(decomposed_parts a, decomposed_pa=
rts b,
> +                                       bool subtract, float_status *s)
> +{
> +    bool a_sign =3D a.sign;
> +    bool b_sign =3D b.sign ^ subtract;
> +
> +    if (a_sign !=3D b_sign) {
> +        /* Subtraction */
> +
> +        if (a.cls =3D=3D float_class_normal && b.cls =3D=3D float_class_=
normal) {
> +            int a_exp =3D a.exp;
> +            int b_exp =3D b.exp;
> +            uint64_t a_frac =3D a.frac;
> +            uint64_t b_frac =3D b.frac;

Do we really have to use locals here rather than just using a.frac,
b.frac etc in place ? If we trust the compiler enough to throw
structs in and out of functions and let everything inline, it
ought to be able to handle a uint64_t in a struct local variable.

> +
> +            if (a_exp > b_exp || (a_exp =3D=3D b_exp && a_frac >=3D b_fr=
ac)) {
> +                shift64RightJamming(b_frac, a_exp - b_exp, &b_frac);
> +                a_frac =3D a_frac - b_frac;
> +            } else {
> +                shift64RightJamming(a_frac, b_exp - a_exp, &a_frac);
> +                a_frac =3D b_frac - a_frac;
> +                a_exp =3D b_exp;
> +                a_sign ^=3D 1;
> +            }
> +
> +            if (a_frac =3D=3D 0) {
> +                a.cls =3D float_class_zero;
> +                a.sign =3D s->float_rounding_mode =3D=3D float_round_dow=
n;
> +            } else {
> +                int shift =3D clz64(a_frac) - 1;
> +                a.frac =3D a_frac << shift;
> +                a.exp =3D a_exp - shift;
> +                a.sign =3D a_sign;
> +            }
> +            return a;
> +        }
> +        if (a.cls >=3D float_class_qnan
> +            ||
> +            b.cls >=3D float_class_qnan)
> +        {
> +            return pick_nan_parts(a, b, s);
> +        }
> +        if (a.cls =3D=3D float_class_inf) {
> +            if (b.cls =3D=3D float_class_inf) {
> +                float_raise(float_flag_invalid, s);
> +                a.cls =3D float_class_dnan;
> +            }
> +            return a;
> +        }
> +        if (a.cls =3D=3D float_class_zero && b.cls =3D=3D float_class_ze=
ro) {
> +            a.sign =3D s->float_rounding_mode =3D=3D float_round_down;
> +            return a;
> +        }
> +        if (a.cls =3D=3D float_class_zero || b.cls =3D=3D float_class_in=
f) {
> +            b.sign =3D a_sign ^ 1;
> +            return b;
> +        }
> +        if (b.cls =3D=3D float_class_zero) {
> +            return a;
> +        }
> +    } else {
> +        /* Addition */
> +        if (a.cls =3D=3D float_class_normal && b.cls =3D=3D float_class_=
normal) {
> +            int a_exp =3D a.exp;
> +            int b_exp =3D b.exp;
> +            uint64_t a_frac =3D a.frac;
> +            uint64_t b_frac =3D b.frac;
> +
> +            if (a_exp > b_exp) {
> +                shift64RightJamming(b_frac, a_exp - b_exp, &b_frac);
> +            } else if (a_exp < b_exp) {
> +                shift64RightJamming(a_frac, b_exp - a_exp, &a_frac);
> +                a_exp =3D b_exp;
> +            }
> +            a_frac +=3D b_frac;
> +            if (a_frac & DECOMPOSED_OVERFLOW_BIT) {
> +                a_frac >>=3D 1;
> +                a_exp +=3D 1;
> +            }
> +
> +            a.exp =3D a_exp;
> +            a.frac =3D a_frac;
> +            return a;
> +        }
> +        if (a.cls >=3D float_class_qnan
> +            ||
> +            b.cls >=3D float_class_qnan) {

We should helper functions for "is some kind of NaN" rather than
baking the assumption about order of the enum values directly
into every function. (Also "float_is_any_nan(a)" is easier to read.)

> +            return pick_nan_parts(a, b, s);
> +        }
> +        if (a.cls =3D=3D float_class_inf || b.cls =3D=3D float_class_zer=
o) {
> +            return a;
> +        }
> +        if (b.cls =3D=3D float_class_inf || a.cls =3D=3D float_class_zer=
o) {
> +            b.sign =3D b_sign;
> +            return b;
> +        }
> +    }
> +    g_assert_not_reached();
> +}
> +
> +/*
> + * Returns the result of adding or subtracting the floating-point
> + * values `a' and `b'. The operation is performed according to the
> + * IEC/IEEE Standard for Binary Floating-Point Arithmetic.
> + */
> +
> +float16 float16_add(float16 a, float16 b, float_status *status)
> +{
> +    decomposed_parts pa =3D float16_unpack_canonical(a, status);
> +    decomposed_parts pb =3D float16_unpack_canonical(b, status);
> +    decomposed_parts pr =3D add_decomposed(pa, pb, false, status);
> +
> +    return float16_round_pack_canonical(pr, status);
> +}
> +
> +float32 float32_add(float32 a, float32 b, float_status *status)
> +{
> +    decomposed_parts pa =3D float32_unpack_canonical(a, status);
> +    decomposed_parts pb =3D float32_unpack_canonical(b, status);
> +    decomposed_parts pr =3D add_decomposed(pa, pb, false, status);
> +
> +    return float32_round_pack_canonical(pr, status);
> +}
> +
> +float64 float64_add(float64 a, float64 b, float_status *status)
> +{
> +    decomposed_parts pa =3D float64_unpack_canonical(a, status);
> +    decomposed_parts pb =3D float64_unpack_canonical(b, status);
> +    decomposed_parts pr =3D add_decomposed(pa, pb, false, status);
> +
> +    return float64_round_pack_canonical(pr, status);
> +}
> +
> +float16 float16_sub(float16 a, float16 b, float_status *status)
> +{
> +    decomposed_parts pa =3D float16_unpack_canonical(a, status);
> +    decomposed_parts pb =3D float16_unpack_canonical(b, status);
> +    decomposed_parts pr =3D add_decomposed(pa, pb, true, status);
> +
> +    return float16_round_pack_canonical(pr, status);
> +}
> +
> +float32 float32_sub(float32 a, float32 b, float_status *status)
> +{
> +    decomposed_parts pa =3D float32_unpack_canonical(a, status);
> +    decomposed_parts pb =3D float32_unpack_canonical(b, status);
> +    decomposed_parts pr =3D add_decomposed(pa, pb, true, status);
> +
> +    return float32_round_pack_canonical(pr, status);
> +}
> +
> +float64 float64_sub(float64 a, float64 b, float_status *status)
> +{
> +    decomposed_parts pa =3D float64_unpack_canonical(a, status);
> +    decomposed_parts pb =3D float64_unpack_canonical(b, status);
> +    decomposed_parts pr =3D add_decomposed(pa, pb, true, status);
> +
> +    return float64_round_pack_canonical(pr, status);
> +}

This part is a pretty good advert for the benefits of the refactoring...

I'm not particularly worried about the performance of softfloat,
but out of curiosity have you benchmarked the old vs new?

thanks
-- PMM
