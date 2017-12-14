Received: from eggs.gnu.org ([2001:4830:134:3::10]:48228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXXN-0001vP-4O
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:43:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXXM-0004l4-4y
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:43:13 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:43988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ePXXL-0004jm-UP
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:43:12 -0500
Received: by mail-wm0-x243.google.com with SMTP id n138so12880108wmg.2
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 09:43:11 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213195852.30439-8-f4bug@amsat.org>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-8-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 09:42:40 -0800
Message-ID: <CAKmqyKMYGLWTDhPaPfzEO6oJ2OkMMbfNhN_UwP2aLLAXz+kJWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/14] sdhci: refactor common sysbus/pci
 realize() into sdhci_realizefn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 11:58 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sdhci.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index c8b7b1ca4c..a96cd8a2df 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1182,6 +1182,15 @@ static void sdhci_initfn(SDHCIState *s)
>      s->transfer_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_tr=
ansfer, s);
>  }
>
> +static void sdhci_realizefn(SDHCIState *s, Error **errp)
> +{
> +    s->buf_maxsz =3D sdhci_get_fifolen(s);
> +    s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdh=
ci",
> +                          SDHC_REGISTERS_MAP_SIZE);
> +}
> +
>  static void sdhci_uninitfn(SDHCIState *s)
>  {
>      timer_del(s->insert_timer);
> @@ -1272,12 +1281,11 @@ static void sdhci_pci_realize(PCIDevice *dev, Err=
or **errp)
>      SDHCIState *s =3D PCI_SDHCI(dev);
>      dev->config[PCI_CLASS_PROG] =3D 0x01; /* Standard Host supported DMA=
 */
>      dev->config[PCI_INTERRUPT_PIN] =3D 0x01; /* interrupt pin A */
> +
>      sdhci_initfn(s);
> -    s->buf_maxsz =3D sdhci_get_fifolen(s);
> -    s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
> +    sdhci_realizefn(s, errp);
> +
>      s->irq =3D pci_allocate_irq(dev);
> -    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdh=
ci",
> -            SDHC_REGISTERS_MAP_SIZE);
>      pci_register_bar(dev, 0, 0, &s->iomem);
>  }
>
> @@ -1334,11 +1342,9 @@ static void sdhci_sysbus_realize(DeviceState *dev,=
 Error ** errp)
>      SDHCIState *s =3D SYSBUS_SDHCI(dev);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>
> -    s->buf_maxsz =3D sdhci_get_fifolen(s);
> -    s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
> +    sdhci_realizefn(s, errp);
> +
>      sysbus_init_irq(sbd, &s->irq);
> -    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdh=
ci",
> -            SDHC_REGISTERS_MAP_SIZE);
>      sysbus_init_mmio(sbd, &s->iomem);
>  }
>
> --
> 2.15.1
>
>
