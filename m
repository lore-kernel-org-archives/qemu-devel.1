Received: from eggs.gnu.org ([2001:4830:134:3::10]:51098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUWGN-0004VQ-6i
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUWGJ-0005Xs-QF
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:26:47 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gUWGJ-0005Wt-Gh
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:26:43 -0500
Received: by mail-wr1-x441.google.com with SMTP id j2so19506424wrw.1
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 04:26:43 -0800 (PST)
References: <20181124235553.17371-1-cota@braap.org>
	<20181124235553.17371-13-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181124235553.17371-13-cota@braap.org>
Date: Wed, 05 Dec 2018 12:26:40 +0000
Message-ID: <874lbs2m7z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 12/13] hardfloat: implement float32/64
 square root
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Performance results for fp-bench:
>
> Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
> - before:
> sqrt-single: 42.30 MFlops
> sqrt-double: 22.97 MFlops
> - after:
> sqrt-single: 311.42 MFlops
> sqrt-double: 311.08 MFlops
>
> Here USE_FP makes a huge difference for f64's, with throughput
> going from ~200 MFlops to ~300 MFlops.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  fpu/softfloat.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 2 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index e03feafb6f..4c6ecd1883 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -3040,20 +3040,76 @@ float16 QEMU_FLATTEN float16_sqrt(float16 a, floa=
t_status *status)
>      return float16_round_pack_canonical(pr, status);
>  }
>
> -float32 QEMU_FLATTEN float32_sqrt(float32 a, float_status *status)
> +static float32 QEMU_SOFTFLOAT_ATTR
> +soft_f32_sqrt(float32 a, float_status *status)
>  {
>      FloatParts pa =3D float32_unpack_canonical(a, status);
>      FloatParts pr =3D sqrt_float(pa, status, &float32_params);
>      return float32_round_pack_canonical(pr, status);
>  }
>
> -float64 QEMU_FLATTEN float64_sqrt(float64 a, float_status *status)
> +static float64 QEMU_SOFTFLOAT_ATTR
> +soft_f64_sqrt(float64 a, float_status *status)
>  {
>      FloatParts pa =3D float64_unpack_canonical(a, status);
>      FloatParts pr =3D sqrt_float(pa, status, &float64_params);
>      return float64_round_pack_canonical(pr, status);
>  }
>
> +float32 QEMU_FLATTEN float32_sqrt(float32 xa, float_status *s)
> +{
> +    union_float32 ua, ur;
> +
> +    ua.s =3D xa;
> +    if (unlikely(!can_use_fpu(s))) {
> +        goto soft;
> +    }
> +
> +    float32_input_flush1(&ua.s, s);
> +    if (QEMU_HARDFLOAT_1F32_USE_FP) {
> +        if (unlikely(!(fpclassify(ua.h) =3D=3D FP_NORMAL ||
> +                       fpclassify(ua.h) =3D=3D FP_ZERO) ||
> +                     signbit(ua.h))) {
> +            goto soft;
> +        }
> +    } else if (unlikely(!float32_is_zero_or_normal(ua.s) ||
> +                        float32_is_neg(ua.s))) {
> +        goto soft;
> +    }
> +    ur.h =3D sqrtf(ua.h);
> +    return ur.s;
> +
> + soft:
> +    return soft_f32_sqrt(ua.s, s);
> +}
> +
> +float64 QEMU_FLATTEN float64_sqrt(float64 xa, float_status *s)
> +{
> +    union_float64 ua, ur;
> +
> +    ua.s =3D xa;
> +    if (unlikely(!can_use_fpu(s))) {
> +        goto soft;
> +    }
> +
> +    float64_input_flush1(&ua.s, s);
> +    if (QEMU_HARDFLOAT_1F64_USE_FP) {
> +        if (unlikely(!(fpclassify(ua.h) =3D=3D FP_NORMAL ||
> +                       fpclassify(ua.h) =3D=3D FP_ZERO) ||
> +                     signbit(ua.h))) {
> +            goto soft;
> +        }
> +    } else if (unlikely(!float64_is_zero_or_normal(ua.s) ||
> +                        float64_is_neg(ua.s))) {
> +        goto soft;
> +    }
> +    ur.h =3D sqrt(ua.h);
> +    return ur.s;
> +
> + soft:
> +    return soft_f64_sqrt(ua.s, s);
> +}
> +
>  /*----------------------------------------------------------------------=
------
>  | The pattern for a default generated NaN.
>  *-----------------------------------------------------------------------=
-----*/


--
Alex Benn=C3=A9e
