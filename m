Received: from eggs.gnu.org ([2001:4830:134:3::10]:44580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gZyH9-0005gF-4A
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 08:22:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gZy5W-00084k-Fi
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 08:10:07 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1gZy5W-000847-8r
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 08:10:06 -0500
Received: by mail-ot1-x341.google.com with SMTP id v23so1768857otk.9
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 05:10:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181220111008.24954-1-alex.bennee@linaro.org>
References: <20181220111008.24954-1-alex.bennee@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 20 Dec 2018 14:10:04 +0100
Message-ID: <CAL1e-=hdaZCX37gxFunDC1k6xvXiqMBB-rHdAXQvK6sqDH_yEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] fpu: add compile time check for old
 glibc/libm and fma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>, laurent.desnogues@gmail.com, Aurelien Jarno <aurelien@aurel32.net>

On Dec 20, 2018 12:11 PM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> wrote=
:
>
> Some versions of glibc have been reported to have problems with
> fused-multiply-accumulate operations. If the underlying fma
> implementation does a two step operation it will instroduce subtle
> rounding errors. Newer versions of the library seem to deal with this
> better and modern hardware has fused operations which the library can
> use.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Emilio G. Cota <cota@braap.org>
> ---
>  fpu/softfloat.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>

Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 59eac97d10..9c2dbd04b5 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -203,6 +203,25 @@ GEN_INPUT_FLUSH3(float64_input_flush3, float64)
>  # define QEMU_HARDFLOAT_3F64_USE_FP 0
>  #endif
>
> +/*
> + * Choose whether to accelerate fused multiply-accumulate operations
> + * with hard float functions. Some versions of glibc's maths library
> + * have been reported to be broken on x86 without FMA instructions.
> + */
> +#if defined(__x86_64__)
> +/* this was actually reported as glibc-2.12-1.149.el6_6.5.x86_64 was
> + * broken but glibc 2.12-1.209 works but out of caution lets disable
> + * for all older glibcs.
> + */
> +#if defined(__GLIBC__) && (__GLIBC__ =3D=3D 2 && __GLIBC_MINOR__ <=3D 12=
)
> +#define QEMU_HARDFLOAT_USE_FMA 0
> +#else
> +#define QEMU_HARDFLOAT_USE_FMA 1
> +#endif
> +#else
> +#define QEMU_HARDFLOAT_USE_FMA 1
> +#endif
> +
>  /*
>   * QEMU_HARDFLOAT_USE_ISINF chooses whether to use isinf() over
>   * float{32,64}_is_infinity when !USE_FP.
> @@ -1551,6 +1570,9 @@ float32_muladd(float32 xa, float32 xb, float32 xc,
int flags, float_status *s)
>      ub.s =3D xb;
>      uc.s =3D xc;
>
> +    if (!QEMU_HARDFLOAT_USE_FMA) {
> +        goto soft;
> +    }
>      if (unlikely(!can_use_fpu(s))) {
>          goto soft;
>      }
> @@ -1612,6 +1634,9 @@ float64_muladd(float64 xa, float64 xb, float64 xc,
int flags, float_status *s)
>      ub.s =3D xb;
>      uc.s =3D xc;
>
> +    if (!QEMU_HARDFLOAT_USE_FMA) {
> +        goto soft;
> +    }
>      if (unlikely(!can_use_fpu(s))) {
>          goto soft;
>      }
> --
> 2.17.1
>
>
