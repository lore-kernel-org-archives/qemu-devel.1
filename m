Received: from eggs.gnu.org ([2001:4830:134:3::10]:50001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWdui-0005ZY-D6
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 02:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWdue-0000nf-HI
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 02:56:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eWdue-0000nG-AE
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 02:56:36 -0500
Date: Wed, 3 Jan 2018 15:56:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180103075633.GE25984@localhost.localdomain>
References: <20171229174933.1781-1-f4bug@amsat.org>
	<20171229174933.1781-8-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171229174933.1781-8-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 07/42] sdhci: refactor common sysbus/pci
 unrealize() into sdhci_unrealizefn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Xiaoqiang Zhao <zxq_yx_007@163.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org

On Fri, 12/29 14:48, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  hw/sd/sdhci.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index ad5853d527..06a1ec6f91 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -31,6 +31,7 @@
>  #include "qemu/bitops.h"
>  #include "hw/sd/sdhci.h"
>  #include "sdhci-internal.h"
> +#include "qapi/error.h"
>  #include "qemu/log.h"
> =20
>  /* host controller debug messages */
> @@ -1203,15 +1204,17 @@ static void sdhci_realizefn(SDHCIState *s, Erro=
r **errp)
>                            SDHC_REGISTERS_MAP_SIZE);
>  }
> =20
> +static void sdhci_unrealizefn(SDHCIState *s, Error **errp)
> +{
> +    g_free(s->fifo_buffer);

Set s->fifo_buffer to NULL to avoid double-free and/or use-after-free?
Especially since you call this from both the ->exit and the ->unrealize
callbacks.

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
> =20
>  static bool sdhci_pending_insert_vmstate_needed(void *opaque)
> @@ -1312,6 +1315,8 @@ static void sdhci_pci_realize(PCIDevice *dev, Err=
or **errp)
>  static void sdhci_pci_exit(PCIDevice *dev)
>  {
>      SDHCIState *s =3D PCI_SDHCI(dev);
> +
> +    sdhci_unrealizefn(s, &error_abort);
>      sdhci_uninitfn(s);
>  }
> =20
> @@ -1365,11 +1370,19 @@ static void sdhci_sysbus_realize(DeviceState *d=
ev, Error ** errp)
>      sysbus_init_mmio(sbd, &s->iomem);
>  }
> =20
> +static void sdhci_sysbus_unrealize(DeviceState *dev, Error **errp)
> +{
> +    SDHCIState *s =3D SYSBUS_SDHCI(dev);
> +
> +    sdhci_unrealizefn(s, errp);
> +}
> +
>  static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
>      dc->realize =3D sdhci_sysbus_realize;
> +    dc->unrealize =3D sdhci_sysbus_unrealize;
> =20
>      sdhci_class_init(klass, data);
>  }
> --=20
> 2.15.1
>=20
>=20

Fam
