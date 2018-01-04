Received: from eggs.gnu.org ([2001:4830:134:3::10]:50351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eX9nh-0007Jw-3B
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eX9ng-0008KQ-5G
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:59:33 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:43649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eX9nf-0008Jx-Uh
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:59:32 -0500
Received: by mail-wr0-x241.google.com with SMTP id w68so2251393wrc.10
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 09:59:31 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180103180805.18140-8-f4bug@amsat.org>
References: <20180103180805.18140-1-f4bug@amsat.org>
	<20180103180805.18140-8-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 4 Jan 2018 09:59:00 -0800
Message-ID: <CAKmqyKMvFCQ8S6kwy9x4LfVTYJ+MQ+VmABndNoYoAJEsMuLNhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 07/17] sdhci: refactor common sysbus/pci
 unrealize() into sdhci_common_unrealize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Jan 3, 2018 at 10:07 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sdhci.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index b3dbd994fd..089961bd66 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -31,6 +31,7 @@
>  #include "qemu/bitops.h"
>  #include "hw/sd/sdhci.h"
>  #include "sdhci-internal.h"
> +#include "qapi/error.h"
>  #include "qemu/log.h"
>
>  /* host controller debug messages */
> @@ -1203,15 +1204,23 @@ static void sdhci_common_realize(SDHCIState *s, E=
rror **errp)
>                            SDHC_REGISTERS_MAP_SIZE);
>  }
>
> +static void sdhci_common_unrealize(SDHCIState *s, Error **errp)
> +{
> +    /* This function is expected to be called only once for each class:
> +     * - SysBus:    via DeviceClass->unrealize(),
> +     * - PCI:       via PCIDeviceClass->exit().
> +     * However to avoid double-free and/or use-after-free we still nulli=
fy
> +     * this variable (better safe than sorry!). */
> +    g_free(s->fifo_buffer);
> +    s->fifo_buffer =3D NULL;

Can we assert() on s->fifo_buffer? That way if we are double freeing
it can be caught by developers.

Alistair

> +}
> +
>  static void sdhci_uninitfn(SDHCIState *s)
>  {
>      timer_del(s->insert_timer);
>      timer_free(s->insert_timer);
>      timer_del(s->transfer_timer);
>      timer_free(s->transfer_timer);
> -
> -    g_free(s->fifo_buffer);
> -    s->fifo_buffer =3D NULL;
>  }
>
>  static bool sdhci_pending_insert_vmstate_needed(void *opaque)
> @@ -1315,6 +1324,8 @@ static void sdhci_pci_realize(PCIDevice *dev, Error=
 **errp)
>  static void sdhci_pci_exit(PCIDevice *dev)
>  {
>      SDHCIState *s =3D PCI_SDHCI(dev);
> +
> +    sdhci_common_unrealize(s, &error_abort);
>      sdhci_uninitfn(s);
>  }
>
> @@ -1371,11 +1382,19 @@ static void sdhci_sysbus_realize(DeviceState *dev=
, Error ** errp)
>      sysbus_init_mmio(sbd, &s->iomem);
>  }
>
> +static void sdhci_sysbus_unrealize(DeviceState *dev, Error **errp)
> +{
> +    SDHCIState *s =3D SYSBUS_SDHCI(dev);
> +
> +    sdhci_common_unrealize(s, &error_abort);
> +}
> +
>  static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
>      dc->realize =3D sdhci_sysbus_realize;
> +    dc->unrealize =3D sdhci_sysbus_unrealize;
>
>      sdhci_common_class_init(klass, data);
>  }
> --
> 2.15.1
>
>
