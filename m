Received: from eggs.gnu.org ([2001:4830:134:3::10]:45991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gaLZA-0006rb-PF
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gaLZA-0007JF-5a
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:14:16 -0500
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:45761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1gaLZ9-0007Id-UE
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:14:16 -0500
Received: by mail-qt1-x841.google.com with SMTP id e5so5747288qtr.12
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 06:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20181220111008.24954-1-alex.bennee@linaro.org>
In-Reply-To: <20181220111008.24954-1-alex.bennee@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Fri, 21 Dec 2018 15:14:14 +0100
Message-ID: <CABoDooNLKh7y0vqNM+zJkpDVS8H1PChxbXFCuA=7TjV7rG147g@mail.gmail.com>
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>

Hi,

On Thu, Dec 20, 2018 at 12:10 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> Some versions of glibc have been reported to have problems with
> fused-multiply-accumulate operations. If the underlying fma
> implementation does a two step operation it will instroduce subtle
> rounding errors. Newer versions of the library seem to deal with this
> better and modern hardware has fused operations which the library can
> use.

Thanks for taking care of this issue.  The fix was tested on our
machines and it works as expected.

So:

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>

> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Emilio G. Cota <cota@braap.org>
> ---
>  fpu/softfloat.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
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
> @@ -1551,6 +1570,9 @@ float32_muladd(float32 xa, float32 xb, float32 xc, =
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
> @@ -1612,6 +1634,9 @@ float64_muladd(float64 xa, float64 xb, float64 xc, =
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
