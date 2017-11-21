Received: from eggs.gnu.org ([2001:4830:134:3::10]:49429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHD0U-0002xV-Hw
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHD0T-0000SB-Bh
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:10:50 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHD0T-0000Rv-5t
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:10:49 -0500
Received: by mail-oi0-x241.google.com with SMTP id f135so9164137oib.0
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 10:10:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171106154813.19936-15-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-15-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 18:10:28 +0000
Message-ID: <CAFEAcA8gxXmEL3yeu0J12C8D0AkKFqBKC1Sud2HLbT1EdUO41Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 14/30] i.MX: Add code to emulate i.MX2
 watchdog IP block
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
> Add enough code to emulate i.MX2 watchdog IP block so it would be
> possible to reboot the machine running Linux Guest.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/misc/Makefile.objs      |  1 +
>  hw/misc/imx2_wdt.c         | 88 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/misc/imx2_wdt.h | 34 ++++++++++++++++++
>  3 files changed, 123 insertions(+)
>  create mode 100644 hw/misc/imx2_wdt.c
>  create mode 100644 include/hw/misc/imx2_wdt.h
>
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index ac1be05a03..c393a93456 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -35,6 +35,7 @@ obj-$(CONFIG_IMX) +=3D imx25_ccm.o
>  obj-$(CONFIG_IMX) +=3D imx6_ccm.o
>  obj-$(CONFIG_IMX) +=3D imx6_src.o
>  obj-$(CONFIG_IMX) +=3D imx7_ccm.o
> +obj-$(CONFIG_IMX) +=3D imx2_wdt.o
>  obj-$(CONFIG_MILKYMIST) +=3D milkymist-hpdmc.o
>  obj-$(CONFIG_MILKYMIST) +=3D milkymist-pfpu.o
>  obj-$(CONFIG_MAINSTONE) +=3D mst_fpga.o
> diff --git a/hw/misc/imx2_wdt.c b/hw/misc/imx2_wdt.c
> new file mode 100644
> index 0000000000..3a1c33aa51
> --- /dev/null
> +++ b/hw/misc/imx2_wdt.c
> @@ -0,0 +1,88 @@
> +/*
> + * Copyright (c) 2017, Impinj, Inc.
> + *
> + * i.MX2 Watchdog IP block
> + *
> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/watchdog.h"
> +
> +#include "hw/misc/imx2_wdt.h"
> +
> +#define IMX2_WDT_WCR_WDA    BIT(5)      /* -> External Reset WDOG_B */
> +#define IMX2_WDT_WCR_SRS    BIT(4)      /* -> Software Reset Signal */
> +
> +static uint64_t imx2_wdt_read(void *opaque, hwaddr addr,
> +                              unsigned int size)
> +{
> +    return 0;
> +}
> +
> +static void imx2_wdt_write(void *opaque, hwaddr addr,
> +                           uint64_t value, unsigned int size)
> +{
> +    if (addr =3D=3D IMX2_WDT_WCR &&
> +        (value & (IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS))) {
> +        watchdog_perform_action();
> +    }
> +}
> +
> +static const MemoryRegionOps imx2_wdt_ops =3D {
> +    .read  =3D imx2_wdt_read,
> +    .write =3D imx2_wdt_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .impl =3D {
> +        /*
> +         * Our device would not work correctly if the guest was doing
> +         * unaligned access. This might not be a limitation on the
> +         * real device but in practice there is no reason for a guest
> +         * to access this device unaligned.
> +         */
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +        .unaligned =3D false,
> +    },
> +};
> +
> +static void imx2_wdt_realize(DeviceState *dev, Error **errp)
> +{
> +    IMX2WdtState *s =3D IMX2_WDT(dev);
> +
> +    memory_region_init_io(&s->mmio, OBJECT(dev),
> +                          &imx2_wdt_ops, s,
> +                          TYPE_IMX2_WDT".mmio",
> +                          IMX2_WDT_REG_NUM * sizeof(uint16_t));
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
> +}
> +
> +static void imx2_wdt_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D imx2_wdt_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static const TypeInfo imx2_wdt_info =3D {
> +    .name          =3D TYPE_IMX2_WDT,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(IMX2WdtState),
> +    .class_init    =3D imx2_wdt_class_init,
> +};
> +
> +static WatchdogTimerModel model =3D {
> +    .wdt_name =3D "imx2-watchdog",
> +    .wdt_description =3D "i.MX2 Watchdog",
> +};
> +
> +static void imx2_wdt_register_type(void)
> +{
> +    watchdog_add_model(&model);
> +    type_register_static(&imx2_wdt_info);
> +}
> +type_init(imx2_wdt_register_type)
> diff --git a/include/hw/misc/imx2_wdt.h b/include/hw/misc/imx2_wdt.h
> new file mode 100644
> index 0000000000..e67ac6939d
> --- /dev/null
> +++ b/include/hw/misc/imx2_wdt.h
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright (c) 2017, Impinj, Inc.
> + *
> + * i.MX2 Watchdog IP block
> + *
> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef IMX2_WDT_H
> +#define IMX2_WDT_H
> +
> +#include "qemu/bitops.h"
> +#include "hw/sysbus.h"

The bitops.h include should be in the .c file, not here.

> +
> +#define TYPE_IMX2_WDT "imx2.wdt"
> +#define IMX2_WDT(obj) OBJECT_CHECK(IMX2WdtState, (obj), TYPE_IMX2_WDT)
> +
> +enum IMX2WdtRegisters {
> +    IMX2_WDT_WCR     =3D 0x0000,
> +    IMX2_WDT_REG_NUM =3D 0x0008 / sizeof(uint16_t) + 1,
> +};
> +
> +
> +typedef struct IMX2WdtState {
> +    /* <private> */
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +} IMX2WdtState;
> +
> +#endif /* IMX7_SNVS_H */
> --
> 2.13.6
>
Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
