Received: from eggs.gnu.org ([2001:4830:134:3::10]:32831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUU8w-0008Vx-EP
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUU8s-00057s-F8
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:10:58 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gUU8o-0004yr-KC
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:10:52 -0500
Received: by mail-wr1-x444.google.com with SMTP id x10so19011547wrs.8
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 02:10:49 -0800 (PST)
References: <20181124235553.17371-1-cota@braap.org>
	<20181124235553.17371-10-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181124235553.17371-10-cota@braap.org>
Date: Wed, 05 Dec 2018 10:10:46 +0000
Message-ID: <878t142sih.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 09/13] hardfloat: implement float32/64
 multiplication
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
> mul-single: 126.91 MFlops
> mul-double: 118.28 MFlops
> - after:
> mul-single: 258.02 MFlops
> mul-double: 197.96 MFlops
>
> 2. ARM Aarch64 A57 @ 2.4GHz
> - before:
> mul-single: 37.42 MFlops
> mul-double: 38.77 MFlops
> - after:
> mul-single: 73.41 MFlops
> mul-double: 76.93 MFlops
>
> 3. IBM POWER8E @ 2.1 GHz
> - before:
> mul-single: 58.40 MFlops
> mul-double: 59.33 MFlops
> - after:
> mul-single: 60.25 MFlops
> mul-double: 94.79 MFlops
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  fpu/softfloat.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index cc500b1618..58e67d9b80 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1232,7 +1232,8 @@ float16 QEMU_FLATTEN float16_mul(float16 a, float16=
 b, float_status *status)
>      return float16_round_pack_canonical(pr, status);
>  }
>
> -float32 QEMU_FLATTEN float32_mul(float32 a, float32 b, float_status *sta=
tus)
> +static float32 QEMU_SOFTFLOAT_ATTR
> +soft_f32_mul(float32 a, float32 b, float_status *status)
>  {
>      FloatParts pa =3D float32_unpack_canonical(a, status);
>      FloatParts pb =3D float32_unpack_canonical(b, status);
> @@ -1241,7 +1242,8 @@ float32 QEMU_FLATTEN float32_mul(float32 a, float32=
 b, float_status *status)
>      return float32_round_pack_canonical(pr, status);
>  }
>
> -float64 QEMU_FLATTEN float64_mul(float64 a, float64 b, float_status *sta=
tus)
> +static float64 QEMU_SOFTFLOAT_ATTR
> +soft_f64_mul(float64 a, float64 b, float_status *status)
>  {
>      FloatParts pa =3D float64_unpack_canonical(a, status);
>      FloatParts pb =3D float64_unpack_canonical(b, status);
> @@ -1250,6 +1252,54 @@ float64 QEMU_FLATTEN float64_mul(float64 a, float6=
4 b, float_status *status)
>      return float64_round_pack_canonical(pr, status);
>  }
>
> +static float hard_f32_mul(float a, float b)
> +{
> +    return a * b;
> +}
> +
> +static double hard_f64_mul(double a, double b)
> +{
> +    return a * b;
> +}
> +
> +static bool f32_mul_fast_test(union_float32 a, union_float32 b)
> +{
> +    return float32_is_zero(a.s) || float32_is_zero(b.s);
> +}
> +
> +static bool f64_mul_fast_test(union_float64 a, union_float64 b)
> +{
> +    return float64_is_zero(a.s) || float64_is_zero(b.s);
> +}
> +
> +static float32 f32_mul_fast_op(float32 a, float32 b, float_status *s)
> +{
> +    bool signbit =3D float32_is_neg(a) ^ float32_is_neg(b);
> +
> +    return float32_set_sign(float32_zero, signbit);
> +}
> +
> +static float64 f64_mul_fast_op(float64 a, float64 b, float_status *s)
> +{
> +    bool signbit =3D float64_is_neg(a) ^ float64_is_neg(b);
> +
> +    return float64_set_sign(float64_zero, signbit);
> +}
> +
> +float32 QEMU_FLATTEN
> +float32_mul(float32 a, float32 b, float_status *s)
> +{
> +    return float32_gen2(a, b, s, hard_f32_mul, soft_f32_mul,
> +                        f32_is_zon2, NULL, f32_mul_fast_test, f32_mul_fa=
st_op);
> +}
> +
> +float64 QEMU_FLATTEN
> +float64_mul(float64 a, float64 b, float_status *s)
> +{
> +    return float64_gen2(a, b, s, hard_f64_mul, soft_f64_mul,
> +                        f64_is_zon2, NULL, f64_mul_fast_test, f64_mul_fa=
st_op);
> +}
> +
>  /*
>   * Returns the result of multiplying the floating-point values `a' and
>   * `b' then adding 'c', with no intermediate rounding step after the


--
Alex Benn=C3=A9e
