Received: from eggs.gnu.org ([2001:4830:134:3::10]:56008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccFw9-0003fp-V7
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:28:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccFw8-0005Ib-Ib
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:28:49 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ccFw8-0005IB-73
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:28:48 -0500
Received: by mail-wm0-x229.google.com with SMTP id v77so55596501wmv.0
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 10:28:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170210180600.45797-1-marcinch7@gmail.com>
References: <20170210180600.45797-1-marcinch7@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 18:28:26 +0000
Message-ID: <CAFEAcA84rHjGHgq2W2_Hj3e7TwHP0dYLXpLo+_uwEzM8nmNRgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] target-arm: Implement BCM2835 hardware RNG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcin Chojnacki <marcinch7@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 10 February 2017 at 18:06, Marcin Chojnacki <marcinch7@gmail.com> wrote:
> Recent vanilla Raspberry Pi kernels started to make use of
> the hardware random number generator in BCM2835 SoC. As a
> result, those kernels wouldn't work anymore under QEMU
> but rather just freeze during the boot process.
>
> This patch implements a trivial BCM2835 compatible RNG,
> and adds it as a peripheral to BCM2835 platform, which
> allows to boot a vanilla Raspberry Pi kernel under Qemu.

Very nice...easier than I feared it might be.

> Signed-off-by: Marcin Chojnacki <marcinch7@gmail.com>
> ---
>  hw/arm/bcm2835_peripherals.c         |  15 +++++
>  hw/misc/Makefile.objs                |   1 +
>  hw/misc/bcm2835_rng.c                | 115 +++++++++++++++++++++++++++++++++++
>  include/hw/arm/bcm2835_peripherals.h |   2 +
>  include/hw/misc/bcm2835_rng.h        |  23 +++++++
>  5 files changed, 156 insertions(+)
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
> index 0000000..00fb083
> --- /dev/null
> +++ b/hw/misc/bcm2835_rng.c
> @@ -0,0 +1,115 @@
> +/*
> + * Raspberry Pi emulation (c) 2017 Marcin Chojnacki
> + * This code is licensed under the GNU GPLv2 and later.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/misc/bcm2835_rng.h"
> +
> +static uint64_t bcm2835_rng_read(void *opaque, hwaddr offset,
> +    unsigned size)
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

It would be nice if we could avoid calling rand() here:
 * Coverity doesn't like it and will complain
 * it means we become nondeterministic which is awkward for
   record-replay

We have an API for devices that are RNGs, in
include/sysemu/rng.h. It's a bit awkward for the "I just
want some bytes" case, but there's an example of doing
that in hw/ppc/spapr_rng.c.

Let me just put together a patch that abstracts that
out of the spapr code so it's a bit easier to use here.

> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "bcm2835_rng_read: Bad offset %x\n", (int)offset);
> +        res = 0;
> +        break;
> +    }
> +
> +    return res;
> +}
> +
> +static void bcm2835_rng_write(void *opaque, hwaddr offset,
> +    uint64_t value, unsigned size)
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
> +        s->rng_status = value;

We shouldn't let the guest write to bits [31..20] (since
that interferes with the value we want to return in the
RND_VAL field), so just mask them out here.

> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "bcm2835_rng_write: Bad offset %x\n", (int)offset);
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
> +    .minimum_version_id_old = 1,

You don't need to specify minimum_version_id_old here if
it's the same as minimum_version_id.

> +    .fields      = (VMStateField[]) {

This should have field entries for the state
the guest can affect (ie rng_ctrl and rng_status).

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
> +static void bcm2835_rng_realize(DeviceState *dev, Error **errp)
> +{
> +    BCM2835RngState *s = BCM2835_RNG(dev);
> +
> +    s->rng_ctrl = 0;
> +    s->rng_status = 0;

These should go in a reset function, not realize.

> +}
> +
> +static void bcm2835_rng_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = bcm2835_rng_realize;
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

thanks
-- PMM
