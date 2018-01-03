Received: from eggs.gnu.org ([2001:4830:134:3::10]:33266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWn2y-0005RR-EU
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 12:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWn2x-0007n6-ED
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 12:41:48 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:34656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWn2x-0007mo-8o
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 12:41:47 -0500
Received: by mail-io0-x244.google.com with SMTP id q188so2874822iod.1
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 09:41:47 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20180103110126.29209-7-f4bug@amsat.org>
References: <20180103110126.29209-1-f4bug@amsat.org>
	<20180103110126.29209-7-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 3 Jan 2018 14:41:46 -0300
Message-ID: <CAAdtpL7TL7EQXZd3VqBgGiNM-C-i8nDpe33nD2z7QL1xFL4Vkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 06/17] sdhci: refactor common sysbus/pci
 realize() into sdhci_realizefn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

Oops I sent this patch too fast.

On Wed, Jan 3, 2018 at 8:01 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>  hw/sd/sdhci.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 38d82b4c61..d5c6d8ab0b 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -29,6 +29,7 @@
>  #include "sysemu/dma.h"
>  #include "qemu/timer.h"
>  #include "qemu/bitops.h"
> +#include "qapi/error.h"
>  #include "hw/sd/sdhci.h"
>  #include "sdhci-internal.h"
>  #include "qemu/log.h"
> @@ -1194,6 +1195,15 @@ static void sdhci_initfn(SDHCIState *s)
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
> @@ -1290,14 +1300,18 @@ static void sdhci_class_init(ObjectClass *klass, =
void *data)
>  static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
>  {
>      SDHCIState *s =3D PCI_SDHCI(dev);
> +    Error *err_local =3D NULL;
> +
> +    sdhci_initfn(s);
> +    sdhci_realizefn(s, errp);

                                      ^ &err_local

> +    if (errp) {

             ^ err_local

> +        error_propagate(errp, err_local);
> +        return;
> +    }
> +
>      dev->config[PCI_CLASS_PROG] =3D 0x01; /* Standard Host supported DMA=
 */
>      dev->config[PCI_INTERRUPT_PIN] =3D 0x01; /* interrupt pin A */
> -    sdhci_initfn(s);
> -    s->buf_maxsz =3D sdhci_get_fifolen(s);
> -    s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
>      s->irq =3D pci_allocate_irq(dev);
> -    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdh=
ci",
> -            SDHC_REGISTERS_MAP_SIZE);
>      pci_register_bar(dev, 0, 0, &s->iomem);
>  }
>
> @@ -1350,12 +1364,15 @@ static void sdhci_sysbus_realize(DeviceState *dev=
, Error ** errp)
>  {
>      SDHCIState *s =3D SYSBUS_SDHCI(dev);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    Error *err_local =3D NULL;
> +
> +    sdhci_realizefn(s, &err_local);
> +    if (errp) {

             ^ err_local

> +        error_propagate(errp, err_local);
> +        return;
> +    }
>
> -    s->buf_maxsz =3D sdhci_get_fifolen(s);
> -    s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
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
