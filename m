Received: from eggs.gnu.org ([2001:4830:134:3::10]:40041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f188m-0004MM-IL
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f188j-0007oN-Bn
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:17:12 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:44673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f188j-0007o8-0U
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:17:09 -0400
Received: by mail-wr0-x244.google.com with SMTP id u46so1686469wrc.11
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 03:17:08 -0700 (PDT)
References: <1522128840-498-1-git-send-email-cota@braap.org>
	<1522128840-498-9-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1522128840-498-9-git-send-email-cota@braap.org>
Date: Wed, 28 Mar 2018 11:17:06 +0100
Message-ID: <87k1tw8py5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/14] hardfloat: support float32/64
 addition and subtraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Emilio G. Cota <cota@braap.org> writes:

> Note that for float32 we do most checks on the float32 and not on
> the native type; for float64 we do the opposite. This is faster
> than going either way for both, as shown below.

This looks like the difference between SIMD float instructions and
straight mask and cmp. I guess it doesn't pay off until the bigger
sizes. It would be nice to not have to jump through hoops to convince
the compiler of that though. The fpclassify leads to an intrinsic
built-in so the compiler probably knows more about the behaviour.

>
> I am keeping both macro-based definitions to ease testing of
> either option.
>
> Performance results (single and double precision) for fp-bench
> run under aarch64-linux-user on an Intel(R) Core(TM) i7-4790K
> CPU @ 4.00GHz host:
>
> - before:
> add-single: 86.74 MFlops
> add-double: 86.46 MFlops
> sub-single: 83.33 MFlops
> sub-double: 84.57 MFlops
>
> - after this commit:
> add-single: 188.89 MFlops
> add-double: 172.27 MFlops
> sub-single: 187.69 MFlops
> sub-double: 171.89 MFlops
>
> - w/ both using float32/64_is_normal etc.:
> add-single: 187.63 MFlops
> add-double: 143.51 MFlops
> sub-single: 187.91 MFlops
> sub-double: 144.23 MFlops
>
> - w/ both using fpclassify etc.:
> add-single: 166.61 MFlops
> add-double: 172.32 MFlops
> sub-single: 169.13 MFlops
> sub-double: 173.09 MFlops
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  fpu/softfloat.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 112 insertions(+), 8 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index ffe16b2..e0ab0ca 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -829,8 +829,8 @@ float16  __attribute__((flatten)) float16_add(float16=
 a, float16 b,
>      return float16_round_pack_canonical(pr, status);
>  }
>
> -float32 __attribute__((flatten)) float32_add(float32 a, float32 b,
> -                                             float_status *status)
> +static float32 __attribute__((flatten, noinline))
> +soft_float32_add(float32 a, float32 b, float_status *status)
>  {
>      FloatParts pa =3D float32_unpack_canonical(a, status);
>      FloatParts pb =3D float32_unpack_canonical(b, status);
> @@ -839,8 +839,8 @@ float32 __attribute__((flatten)) float32_add(float32 =
a, float32 b,
>      return float32_round_pack_canonical(pr, status);
>  }
>
> -float64 __attribute__((flatten)) float64_add(float64 a, float64 b,
> -                                             float_status *status)
> +static float64 __attribute__((flatten, noinline))
> +soft_float64_add(float64 a, float64 b, float_status *status)
>  {
>      FloatParts pa =3D float64_unpack_canonical(a, status);
>      FloatParts pb =3D float64_unpack_canonical(b, status);
> @@ -859,8 +859,8 @@ float16 __attribute__((flatten)) float16_sub(float16 =
a, float16 b,
>      return float16_round_pack_canonical(pr, status);
>  }
>
> -float32 __attribute__((flatten)) float32_sub(float32 a, float32 b,
> -                                             float_status *status)
> +static float32 __attribute__((flatten, noinline))
> +soft_float32_sub(float32 a, float32 b, float_status *status)
>  {
>      FloatParts pa =3D float32_unpack_canonical(a, status);
>      FloatParts pb =3D float32_unpack_canonical(b, status);
> @@ -869,8 +869,8 @@ float32 __attribute__((flatten)) float32_sub(float32 =
a, float32 b,
>      return float32_round_pack_canonical(pr, status);
>  }
>
> -float64 __attribute__((flatten)) float64_sub(float64 a, float64 b,
> -                                             float_status *status)
> +static float64 __attribute__((flatten, noinline))
> +soft_float64_sub(float64 a, float64 b, float_status *status)
>  {
>      FloatParts pa =3D float64_unpack_canonical(a, status);
>      FloatParts pb =3D float64_unpack_canonical(b, status);
> @@ -879,6 +879,110 @@ float64 __attribute__((flatten)) float64_sub(float6=
4 a, float64 b,
>      return float64_round_pack_canonical(pr, status);
>  }

I don't know if we want to put a comment in about the inline strategy?

>From what I can tell if we do flatten into the ultimate function it just
means the compiler needs a bigger preamble which it can get away with
on hopefully the fast path. So I reluctantly agree the macros are worth
it.

>
> +#define GEN_FPU_ADDSUB(add_name, sub_name, soft_t, host_t,              \
> +                       host_abs_func, min_normal)                       \
> +    static inline __attribute__((always_inline)) soft_t                 \
> +    fpu_ ## soft_t ## _addsub(soft_t a, soft_t b, bool subtract,        \
> +                              float_status *s)                          \
> +    {                                                                   \
> +        soft_t ## _input_flush2(&a, &b, s);                             \
> +        if (likely((soft_t ## _is_normal(a) || soft_t ## _is_zero(a)) &&=
 \
> +                   (soft_t ## _is_normal(b) || soft_t ## _is_zero(b)) &&=
 \
> +                   s->float_exception_flags & float_flag_inexact &&     \
> +                   s->float_rounding_mode =3D=3D float_round_nearest_eve=
n)) { \
> +            host_t ha =3D soft_t ## _to_ ## host_t(a);                  =
  \
> +            host_t hb =3D soft_t ## _to_ ## host_t(b);                  =
  \
> +            host_t hr;                                                  \
> +            soft_t r;                                                   \
> +                                                                        \
> +            if (subtract) {                                             \
> +                hb =3D -hb;                                             =
  \
> +            }                                                           \
> +            hr =3D ha + hb;                                             =
  \
> +            r =3D host_t ## _to_ ## soft_t(hr);                         =
  \
> +            if (unlikely(soft_t ## _is_infinity(r))) {                  \
> +                s->float_exception_flags |=3D float_flag_overflow;      =
  \
> +            } else if (unlikely(host_abs_func(hr) <=3D min_normal) &&   =
  \
> +                       !(soft_t ## _is_zero(a) &&                       \
> +                         soft_t ## _is_zero(b))) {                      \
> +                goto soft;                                              \
> +            }                                                           \
> +            return r;                                                   \
> +        }                                                               \
> +    soft:                                                               \
> +        if (subtract) {                                                 \
> +            return soft_ ## soft_t ## _sub(a, b, s);                    \
> +        } else {                                                        \
> +            return soft_ ## soft_t ## _add(a, b, s);                    \
> +        }                                                               \
> +    }                                                                   \
> +                                                                        \
> +    soft_t add_name(soft_t a, soft_t b, float_status *status)           \
> +    {                                                                   \
> +        return fpu_ ## soft_t ## _addsub(a, b, false, status);          \
> +    }                                                                   \
> +                                                                        \
> +    soft_t sub_name(soft_t a, soft_t b, float_status *status)           \
> +    {                                                                   \
> +        return fpu_ ## soft_t ## _addsub(a, b, true, status);           \
> +    }
> +
> +GEN_FPU_ADDSUB(float32_add, float32_sub, float32, float, fabsf, FLT_MIN)
> +#undef GEN_FPU_ADDSUB
> +
> +#define GEN_FPU_ADDSUB(add_name, sub_name, soft_t, host_t,              \
> +                       host_abs_func, min_normal)                       \
> +    static inline __attribute__((always_inline)) soft_t                 \
> +    fpu_ ## soft_t ## _addsub(soft_t a, soft_t b, bool subtract,        \
> +                              float_status *s)                          \
> +    {                                                                   \
> +        double ha, hb;                                                  \
> +                                                                        \
> +        soft_t ## _input_flush2(&a, &b, s);                             \
> +        ha =3D soft_t ## _to_ ## host_t(a);                             =
  \
> +        hb =3D soft_t ## _to_ ## host_t(b);                             =
  \
> +        if (likely((fpclassify(ha) =3D=3D FP_NORMAL ||                  =
    \
> +                    fpclassify(ha) =3D=3D FP_ZERO) &&                   =
    \
> +                   (fpclassify(hb) =3D=3D FP_NORMAL ||                  =
    \
> +                    fpclassify(hb) =3D=3D FP_ZERO) &&                   =
    \
> +                   s->float_exception_flags & float_flag_inexact &&     \
> +                   s->float_rounding_mode =3D=3D float_round_nearest_eve=
n)) { \
> +            host_t hr;                                                  \
> +                                                                        \
> +            if (subtract) {                                             \
> +                hb =3D -hb;                                             =
  \
> +            }                                                           \
> +            hr =3D ha + hb;                                             =
  \
> +            if (unlikely(isinf(hr))) {                                  \
> +                s->float_exception_flags |=3D float_flag_overflow;      =
  \
> +            } else if (unlikely(host_abs_func(hr) <=3D min_normal) &&   =
  \
> +                       !(soft_t ## _is_zero(a) &&                       \
> +                         soft_t ## _is_zero(b))) {                      \
> +                goto soft;                                              \
> +            }                                                           \
> +            return host_t ## _to_ ## soft_t(hr);                        \
> +        }                                                               \
> +    soft:                                                               \
> +        if (subtract) {                                                 \
> +            return soft_ ## soft_t ## _sub(a, b, s);                    \
> +        } else {                                                        \
> +            return soft_ ## soft_t ## _add(a, b, s);                    \
> +        }                                                               \
> +    }                                                                   \
> +                                                                        \
> +    soft_t add_name(soft_t a, soft_t b, float_status *status)           \
> +    {                                                                   \
> +        return fpu_ ## soft_t ## _addsub(a, b, false, status);          \
> +    }                                                                   \
> +                                                                        \
> +    soft_t sub_name(soft_t a, soft_t b, float_status *status)           \
> +    {                                                                   \
> +        return fpu_ ## soft_t ## _addsub(a, b, true, status);           \
> +    }
> +
> +GEN_FPU_ADDSUB(float64_add, float64_sub, float64, double, fabs, DBL_MIN)
> +#undef GEN_FPU_ADDSUB
> +
>  /*
>   * Returns the result of multiplying the floating-point values `a' and
>   * `b'. The operation is performed according to the IEC/IEEE Standard


Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
