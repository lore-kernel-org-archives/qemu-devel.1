Received: from eggs.gnu.org ([2001:4830:134:3::10]:60763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZkfe-00021G-E4
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZkfd-0008Ns-JI
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:13:42 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZkfd-0008NT-DS
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:13:41 -0400
Received: by mail-wm0-x231.google.com with SMTP id c184so41581301wmd.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:13:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-12-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-12-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 22:13:19 +0100
Message-ID: <CAFEAcA9nkfXfXn3fiZMS3dnrp7v8NVysqFS+pb-Ehf=+xOFfWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 11/35] i2c/exynos4210: correctly
 check i2c_recv() return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 24 July 2017 at 19:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> i2c_recv() returns -1 on error, if the I2CCON_ACK_GEN bit was not set thi=
s code
> was setting i2cds =3D -1.
>
> i2c/exynos4210_i2c.c:117:20: warning: Loss of sign in implicit conversion
>         s->i2cds =3D ret;
>                    ^~~
>
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/i2c/exynos4210_i2c.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i2c/exynos4210_i2c.c b/hw/i2c/exynos4210_i2c.c
> index c96fa7d7be..4424dbd233 100644
> --- a/hw/i2c/exynos4210_i2c.c
> +++ b/hw/i2c/exynos4210_i2c.c
> @@ -111,10 +111,12 @@ static void exynos4210_i2c_data_receive(void *opaqu=
e)
>      s->i2cstat &=3D ~I2CSTAT_LAST_BIT;
>      s->scl_free =3D false;
>      ret =3D i2c_recv(s->bus);
> -    if (ret < 0 && (s->i2ccon & I2CCON_ACK_GEN)) {
> -        s->i2cstat |=3D I2CSTAT_LAST_BIT;  /* Data is not acknowledged *=
/
> -    } else {
> +    if (ret >=3D 0) {
>          s->i2cds =3D ret;
> +    } else {
> +        if (s->i2ccon & I2CCON_ACK_GEN) {
> +            s->i2cstat |=3D I2CSTAT_LAST_BIT;  /* Data is not acknowledg=
ed */
> +        }
>      }
>      exynos4210_i2c_raise_interrupt(s);
>  }
> --

Have you checked this change against the data sheet for
the device?

thanks
-- PMM
