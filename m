Received: from eggs.gnu.org ([2001:4830:134:3::10]:32986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUU9Q-0000Xr-CC
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUU9N-0005WL-4E
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:11:28 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gUU9M-0005Qy-Sr
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:11:25 -0500
Received: by mail-wr1-x443.google.com with SMTP id l9so19006445wrt.13
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 02:11:23 -0800 (PST)
References: <20181124235553.17371-1-cota@braap.org>
	<20181124235553.17371-11-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181124235553.17371-11-cota@braap.org>
Date: Wed, 05 Dec 2018 10:11:21 +0000
Message-ID: <877ego2shi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 10/13] hardfloat: implement float32/64
 division
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
> 1. Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
> - before:
> div-single: 34.84 MFlops
> div-double: 34.04 MFlops
> - after:
> div-single: 275.23 MFlops
> div-double: 216.38 MFlops
>
> 2. ARM Aarch64 A57 @ 2.4GHz
> - before:
> div-single: 9.33 MFlops
> div-double: 9.30 MFlops
> - after:
> div-single: 51.55 MFlops
> div-double: 15.09 MFlops
>
> 3. IBM POWER8E @ 2.1 GHz
> - before:
> div-single: 25.65 MFlops
> div-double: 24.91 MFlops
> - after:
> div-single: 96.83 MFlops
> div-double: 31.01 MFlops
>
> Here setting 2FP64_USE_FP to 1 pays off for x86_64:
> [1] 215.97 vs [0] 62.15 MFlops
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  fpu/softfloat.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 62 insertions(+), 2 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 58e67d9b80..e35ebfaae7 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1624,7 +1624,8 @@ float16 float16_div(float16 a, float16 b, float_sta=
tus *status)
>      return float16_round_pack_canonical(pr, status);
>  }
>
> -float32 float32_div(float32 a, float32 b, float_status *status)
> +static float32 QEMU_SOFTFLOAT_ATTR
> +soft_f32_div(float32 a, float32 b, float_status *status)
>  {
>      FloatParts pa =3D float32_unpack_canonical(a, status);
>      FloatParts pb =3D float32_unpack_canonical(b, status);
> @@ -1633,7 +1634,8 @@ float32 float32_div(float32 a, float32 b, float_sta=
tus *status)
>      return float32_round_pack_canonical(pr, status);
>  }
>
> -float64 float64_div(float64 a, float64 b, float_status *status)
> +static float64 QEMU_SOFTFLOAT_ATTR
> +soft_f64_div(float64 a, float64 b, float_status *status)
>  {
>      FloatParts pa =3D float64_unpack_canonical(a, status);
>      FloatParts pb =3D float64_unpack_canonical(b, status);
> @@ -1642,6 +1644,64 @@ float64 float64_div(float64 a, float64 b, float_st=
atus *status)
>      return float64_round_pack_canonical(pr, status);
>  }
>
> +static float hard_f32_div(float a, float b)
> +{
> +    return a / b;
> +}
> +
> +static double hard_f64_div(double a, double b)
> +{
> +    return a / b;
> +}
> +
> +static bool f32_div_pre(union_float32 a, union_float32 b)
> +{
> +    if (QEMU_HARDFLOAT_2F32_USE_FP) {
> +        return (fpclassify(a.h) =3D=3D FP_NORMAL || fpclassify(a.h) =3D=
=3D FP_ZERO) &&
> +               fpclassify(b.h) =3D=3D FP_NORMAL;
> +    }
> +    return float32_is_zero_or_normal(a.s) && float32_is_normal(b.s);
> +}
> +
> +static bool f64_div_pre(union_float64 a, union_float64 b)
> +{
> +    if (QEMU_HARDFLOAT_2F64_USE_FP) {
> +        return (fpclassify(a.h) =3D=3D FP_NORMAL || fpclassify(a.h) =3D=
=3D FP_ZERO) &&
> +               fpclassify(b.h) =3D=3D FP_NORMAL;
> +    }
> +    return float64_is_zero_or_normal(a.s) && float64_is_normal(b.s);
> +}
> +
> +static bool f32_div_post(union_float32 a, union_float32 b)
> +{
> +    if (QEMU_HARDFLOAT_2F32_USE_FP) {
> +        return fpclassify(a.h) !=3D FP_ZERO;
> +    }
> +    return !float32_is_zero(a.s);
> +}
> +
> +static bool f64_div_post(union_float64 a, union_float64 b)
> +{
> +    if (QEMU_HARDFLOAT_2F64_USE_FP) {
> +        return fpclassify(a.h) !=3D FP_ZERO;
> +    }
> +    return !float64_is_zero(a.s);
> +}
> +
> +float32 QEMU_FLATTEN
> +float32_div(float32 a, float32 b, float_status *s)
> +{
> +    return float32_gen2(a, b, s, hard_f32_div, soft_f32_div,
> +                        f32_div_pre, f32_div_post, NULL, NULL);
> +}
> +
> +float64 QEMU_FLATTEN
> +float64_div(float64 a, float64 b, float_status *s)
> +{
> +    return float64_gen2(a, b, s, hard_f64_div, soft_f64_div,
> +                        f64_div_pre, f64_div_post, NULL, NULL);
> +}
> +
>  /*
>   * Float to Float conversions
>   *


--
Alex Benn=C3=A9e
