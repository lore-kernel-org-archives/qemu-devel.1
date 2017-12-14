Received: from eggs.gnu.org ([2001:4830:134:3::10]:50392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXb6-0005Gq-1Z
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXb4-0004dV-Ps
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:47:04 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:39035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ePXb4-0004bw-FE
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:47:02 -0500
Received: by mail-wr0-x242.google.com with SMTP id a41so5833126wra.6
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 09:47:02 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213195852.30439-10-f4bug@amsat.org>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-10-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 09:46:30 -0800
Message-ID: <CAKmqyKN5dk=sEpSqbnDzyUoSp01YdOaOGQQZBDjcQsaEVhZ-xQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/14] sdhci: refactor common sysbus/pci
 unrealize() into sdhci_unrealizefn()
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
> ---
>  hw/sd/sdhci.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 893be0e606..044e3d62f1 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -31,6 +31,7 @@
>  #include "hw/sd/sdhci.h"
>  #include "sdhci-internal.h"
>  #include "sd-internal.h"
> +#include "qapi/error.h"
>  #include "qemu/log.h"
>
>  /* host controller debug messages */
> @@ -1191,17 +1192,21 @@ static void sdhci_realizefn(SDHCIState *s, Error =
**errp)
>                            SDHC_REGISTERS_MAP_SIZE);
>  }
>
> +static void sdhci_unrealizefn(SDHCIState *s, Error **errp)
> +{
> +    g_free(s->fifo_buffer);
> +    s->fifo_buffer =3D NULL;

I don't think setting this to NULL is required. Shouldn't g_free() do
that for you?

Alistair

> +}
> +
>  static void sdhci_uninitfn(SDHCIState *s)
>  {
>      timer_del(s->insert_timer);
>      timer_free(s->insert_timer);
>      timer_del(s->transfer_timer);
>      timer_free(s->transfer_timer);
> +
>      qemu_free_irq(s->eject_cb);
>      qemu_free_irq(s->ro_cb);
> -
> -    g_free(s->fifo_buffer);
> -    s->fifo_buffer =3D NULL;
>  }
>
>  static bool sdhci_pending_insert_vmstate_needed(void *opaque)
> @@ -1302,6 +1307,8 @@ static void sdhci_pci_realize(PCIDevice *dev, Error=
 **errp)
>  static void sdhci_pci_exit(PCIDevice *dev)
>  {
>      SDHCIState *s =3D PCI_SDHCI(dev);
> +
> +    sdhci_unrealizefn(s, &error_abort);
>      sdhci_uninitfn(s);
>  }
>
> @@ -1355,11 +1362,19 @@ static void sdhci_sysbus_realize(DeviceState *dev=
, Error ** errp)
>      sysbus_init_mmio(sbd, &s->iomem);
>  }
>
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
>
>      dc->realize =3D sdhci_sysbus_realize;
> +    dc->unrealize =3D sdhci_sysbus_unrealize;
>
>      sdhci_class_init(klass, data);
>  }
> --
> 2.15.1
>
>
