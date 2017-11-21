Received: from eggs.gnu.org ([2001:4830:134:3::10]:40518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHCep-00086M-EP
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHCeo-000835-Ib
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:48:27 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:34285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHCeo-000821-EC
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:48:26 -0500
Received: by mail-ot0-x242.google.com with SMTP id o23so11262422otd.1
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 09:48:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171106154813.19936-11-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-11-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 17:48:05 +0000
Message-ID: <CAFEAcA8CLwzHj9-n+OJKB4GTn1u3D_4secBV_CGdFkR383EAOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 10/30] imx_fec: Reserve full 4K page for
 the register file
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
> Some i.MX SoCs (e.g. i.MX7) have FEC registers going as far as offset
> 0x614, so to avoid getting aborts when accessing those on QEMU, extend
> the register file to cover 4KB of address space instead of just 1K.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/net/imx_fec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 48d012cad6..e236bc933c 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -1252,7 +1252,7 @@ static void imx_eth_realize(DeviceState *dev, Error=
 **errp)
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>
>      memory_region_init_io(&s->iomem, OBJECT(dev), &imx_eth_ops, s,
> -                          TYPE_IMX_FEC, 0x400);
> +                          TYPE_IMX_FEC, 0x1000);
>      sysbus_init_mmio(sbd, &s->iomem);
>      sysbus_init_irq(sbd, &s->irq[0]);
>      sysbus_init_irq(sbd, &s->irq[1]);
> --

I notice that we have an unused #define FSL_IMX25_FEC_SIZE 0x4000 in
fsl-imx25.h, and the Linux device trees for the imx25 define the size
of the FEC register block as 0x4000. Should this be 0x4000 ?

thanks
-- PMM
