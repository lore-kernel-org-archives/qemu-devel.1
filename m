Received: from eggs.gnu.org ([2001:4830:134:3::10]:48360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ccVwR-0006qw-62
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 06:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ccVwO-000527-1H
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 06:34:11 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ccVwN-00050S-N2
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 06:34:07 -0500
Received: by mail-wr0-x233.google.com with SMTP id o16so124739560wra.1
	for <qemu-devel@nongnu.org>; Sat, 11 Feb 2017 03:34:07 -0800 (PST)
References: <20170210210857.47893-1-marcinch7@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170210210857.47893-1-marcinch7@gmail.com>
Date: Sat, 11 Feb 2017 11:34:20 +0000
Message-ID: <8737flj70j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2] target-arm: Implement
 BCM2835 hardware RNG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcin Chojnacki <marcinch7@gmail.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org


Marcin Chojnacki <marcinch7@gmail.com> writes:

> Recent vanilla Raspberry Pi kernels started to make use of
> the hardware random number generator in BCM2835 SoC. As a
> result, those kernels wouldn't work anymore under QEMU
> but rather just freeze during the boot process.
>
> This patch implements a trivial BCM2835 compatible RNG,
> and adds it as a peripheral to BCM2835 platform, which
> allows to boot a vanilla Raspberry Pi kernel under Qemu.
>
> Changes since v1:
>  * Prevented guest from writing [31..20] bits in rng_status
>  * Removed redundant minimum_version_id_old
>  * Added field entries for the state
>  * Changed realize function to reset
>
> Signed-off-by: Marcin Chojnacki <marcinch7@gmail.com>
> ---
>  hw/arm/bcm2835_peripherals.c         |  15 +++++
>  hw/misc/Makefile.objs                |   1 +
>  hw/misc/bcm2835_rng.c                | 124 +++++++++++++++++++++++++++++++++++
>  include/hw/arm/bcm2835_peripherals.h |   2 +
>  include/hw/misc/bcm2835_rng.h        |  27 ++++++++
>  5 files changed, 169 insertions(+)
>  create mode 100644 hw/misc/bcm2835_rng.c
>  create mode 100644 include/hw/misc/bcm2835_rng.h
>
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 2e641a3..9ed22d5 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -86,6 +86,11 @@ static void bcm2835_peripherals_init(Object *obj)
>      object_property_add_const_link(OBJECT(&s->property), "dma-mr",
>                                     OBJECT(&s->gpu_bus_mr), &error_abort);
>
> +    /* Random Number Generator */
> +    object_initialize(&s->rng, sizeof(s->rng), TYPE_BCM2835_RNG);
> +    object_property_add_child(obj, "rng", OBJECT(&s->rng), NULL);
> +    qdev_set_parent_bus(DEVICE(&s->rng), sysbus_get_default());
> +
>      /* Extended Mass Media Controller */
>      object_initialize(&s->sdhci, sizeof(s->sdhci), TYPE_SYSBUS_SDHCI);
>      object_property_add_child(obj, "sdhci", OBJECT(&s->sdhci), NULL);
> @@ -226,6 +231,16 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->property), 0,
>                        qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_PROPERTY));
>
> +    /* Random Number Generator */
> +    object_property_set_bool(OBJECT(&s->rng), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    memory_region_add_subregion(&s->peri_mr, RNG_OFFSET,
> +                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng), 0));
> +
>      /* Extended Mass Media Controller */
>      object_property_set_int(OBJECT(&s->sdhci), BCM2835_SDHC_CAPAREG, "capareg",
>                              &err);
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 898e4cc..57a4406 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -42,6 +42,7 @@ obj-$(CONFIG_OMAP) += omap_sdrc.o
>  obj-$(CONFIG_OMAP) += omap_tap.o
>  obj-$(CONFIG_RASPI) += bcm2835_mbox.o
>  obj-$(CONFIG_RASPI) += bcm2835_property.o
> +obj-$(CONFIG_RASPI) += bcm2835_rng.o
>  obj-$(CONFIG_SLAVIO) += slavio_misc.o
>  obj-$(CONFIG_ZYNQ) += zynq_slcr.o
>  obj-$(CONFIG_ZYNQ) += zynq-xadc.o
> diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
> new file mode 100644
> index 0000000..d9a5acf
> --- /dev/null
> +++ b/hw/misc/bcm2835_rng.c
> @@ -0,0 +1,124 @@
> +/*
> + * BCM2835 Random Number Generator emulation
> + *
> + * Copyright (C) 2017 Marcin Chojnacki <marcinch7@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/misc/bcm2835_rng.h"
> +
> +static uint64_t bcm2835_rng_read(void *opaque, hwaddr offset,
> +                                 unsigned size)
> +{
> +    BCM2835RngState *s = (BCM2835RngState *)opaque;
> +    uint32_t res = 0;
> +
> +    assert(size == 4);
> +
> +    switch (offset) {
> +    case 0x0:    /* rng_ctrl */
> +        res = s->rng_ctrl;
> +        break;
> +    case 0x4:    /* rng_status */
> +        res = s->rng_status | (1 << 24);
> +        break;
> +    case 0x8:    /* rng_data */
> +        res = rand();

I know we are running under emulation but is rand() the right call to
feed data to the guest? There is the virtio rng and PPC spar RNG which
both use rng_backend_request_entropy() to collect random data. We should
probably make the Pi RNG as good as the other guests.

> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "bcm2835_rng_read: Bad offset %x\n",
> +                      (int)offset);
> +        res = 0;
> +        break;
> +    }
> +
> +    return res;
> +}
> +
> +static void bcm2835_rng_write(void *opaque, hwaddr offset,
> +                              uint64_t value, unsigned size)
> +{
> +    BCM2835RngState *s = (BCM2835RngState *)opaque;
> +
> +    assert(size == 4);
> +
> +    switch (offset) {
> +    case 0x0:    /* rng_ctrl */
> +        s->rng_ctrl = value;
> +        break;
> +    case 0x4:    /* rng_status */
> +        /* we shouldn't let the guest write to bits [31..20] */
> +        s->rng_status &= ~0xFFFFF;        /* clear 20 lower bits */
> +        s->rng_status |= value & 0xFFFFF; /* set them to new value */
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "bcm2835_rng_write: Bad offset %x\n",
> +                      (int)offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps bcm2835_rng_ops = {
> +    .read = bcm2835_rng_read,
> +    .write = bcm2835_rng_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static const VMStateDescription vmstate_bcm2835_rng = {
> +    .name = TYPE_BCM2835_RNG,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(rng_ctrl, BCM2835RngState),
> +        VMSTATE_UINT32(rng_status, BCM2835RngState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void bcm2835_rng_init(Object *obj)
> +{
> +    BCM2835RngState *s = BCM2835_RNG(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &bcm2835_rng_ops, s,
> +                          TYPE_BCM2835_RNG, 0x10);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
> +}
> +
> +static void bcm2835_rng_reset(DeviceState *dev)
> +{
> +    BCM2835RngState *s = BCM2835_RNG(dev);
> +
> +    s->rng_ctrl = 0;
> +    s->rng_status = 0;
> +}
> +
> +static void bcm2835_rng_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = bcm2835_rng_reset;
> +    dc->vmsd = &vmstate_bcm2835_rng;
> +}
> +
> +static TypeInfo bcm2835_rng_info = {
> +    .name          = TYPE_BCM2835_RNG,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(BCM2835RngState),
> +    .class_init    = bcm2835_rng_class_init,
> +    .instance_init = bcm2835_rng_init,
> +};
> +
> +static void bcm2835_rng_register_types(void)
> +{
> +    type_register_static(&bcm2835_rng_info);
> +}
> +
> +type_init(bcm2835_rng_register_types)
> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
> index e12ae37..31241c7 100644
> --- a/include/hw/arm/bcm2835_peripherals.h
> +++ b/include/hw/arm/bcm2835_peripherals.h
> @@ -19,6 +19,7 @@
>  #include "hw/dma/bcm2835_dma.h"
>  #include "hw/intc/bcm2835_ic.h"
>  #include "hw/misc/bcm2835_property.h"
> +#include "hw/misc/bcm2835_rng.h"
>  #include "hw/misc/bcm2835_mbox.h"
>  #include "hw/sd/sdhci.h"
>
> @@ -41,6 +42,7 @@ typedef struct BCM2835PeripheralState {
>      BCM2835DMAState dma;
>      BCM2835ICState ic;
>      BCM2835PropertyState property;
> +    BCM2835RngState rng;
>      BCM2835MboxState mboxes;
>      SDHCIState sdhci;
>  } BCM2835PeripheralState;
> diff --git a/include/hw/misc/bcm2835_rng.h b/include/hw/misc/bcm2835_rng.h
> new file mode 100644
> index 0000000..41a531b
> --- /dev/null
> +++ b/include/hw/misc/bcm2835_rng.h
> @@ -0,0 +1,27 @@
> +/*
> + * BCM2835 Random Number Generator emulation
> + *
> + * Copyright (C) 2017 Marcin Chojnacki <marcinch7@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef BCM2835_RNG_H
> +#define BCM2835_RNG_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_BCM2835_RNG "bcm2835-rng"
> +#define BCM2835_RNG(obj) \
> +        OBJECT_CHECK(BCM2835RngState, (obj), TYPE_BCM2835_RNG)
> +
> +typedef struct {
> +    SysBusDevice busdev;
> +    MemoryRegion iomem;
> +
> +    uint32_t rng_ctrl;
> +    uint32_t rng_status;
> +} BCM2835RngState;
> +
> +#endif


--
Alex Bennée
