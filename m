Received: from eggs.gnu.org ([2001:4830:134:3::10]:35208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHCOZ-0004Mv-SM
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHCOY-00014p-PM
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:31:39 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:42820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHCOY-00014J-KL
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:31:38 -0500
Received: by mail-ot0-x241.google.com with SMTP id 18so11200228oty.9
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 09:31:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171106154813.19936-5-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-5-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 17:31:17 +0000
Message-ID: <CAFEAcA9EhzPxayCGDOiM_6U9YSS6HK1gCgBroR=C1LM=H=FpQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/30] imx_fec: Use ENET_FTRL to
 determine truncation length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 6 November 2017 at 15:47, Andrey Smirnov <andrew.smirnov@gmail.com> wrot=
e:
> Frame truncation length, TRUNC_FL, is determined by the contents of
> ENET_FTRL register, so convert the code to use it instead of a
> hardcoded constant.
>
> To avoid the case where TRUNC_FL is greater that ENET_MAX_FRAME_SIZE,
> increase the value of the latter to its theoretical maximum of 16K.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/net/imx_fec.c         | 4 ++--
>  include/hw/net/imx_fec.h | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index eb034ffd0c..dda0816fb3 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -1052,8 +1052,8 @@ static ssize_t imx_enet_receive(NetClientState *nc,=
 const uint8_t *buf,
>      crc_ptr =3D (uint8_t *) &crc;
>
>      /* Huge frames are truncted.  */
> -    if (size > ENET_MAX_FRAME_SIZE) {
> -        size =3D ENET_MAX_FRAME_SIZE;
> +    if (size > s->regs[ENET_FTRL]) {
> +        size =3D s->regs[ENET_FTRL];
>          flags |=3D ENET_BD_TR | ENET_BD_LG;
>      }
>
> diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
> index 4bc8f03ec2..0fcc4f0c71 100644
> --- a/include/hw/net/imx_fec.h
> +++ b/include/hw/net/imx_fec.h
> @@ -86,7 +86,6 @@
>  #define ENET_TCCR3             393
>  #define ENET_MAX               400
>
> -#define ENET_MAX_FRAME_SIZE    2032
>
>  /* EIR and EIMR */
>  #define ENET_INT_HB            (1 << 31)
> @@ -155,6 +154,8 @@
>  #define ENET_RCR_NLC           (1 << 30)
>  #define ENET_RCR_GRS           (1 << 31)
>
> +#define ENET_MAX_FRAME_SIZE    (1 << ENET_RCR_MAX_FL_LENGTH)

This means we now have functions with 16K local array
variables on the stack, which seems like a bad idea.

thanks
-- PMM
