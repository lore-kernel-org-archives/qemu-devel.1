Received: from eggs.gnu.org ([2001:4830:134:3::10]:34716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1C0e-0002ON-S8
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1C0d-0006ns-D2
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:20:32 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1C0d-0006na-3a
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:20:31 -0400
Received: by mail-wr0-x230.google.com with SMTP id z109so35518841wrb.1
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 06:20:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170408054318.19830-1-omar.rizwan@gmail.com>
References: <20170408054318.19830-1-omar.rizwan@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 14:20:09 +0100
Message-ID: <CAFEAcA_t1L_UPwV7Uwy9ygEOjBw=RLEkdcD13yepMJe+s7kQmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] raspi: Add Raspberry Pi 1 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Omar Rizwan <omar.rizwan@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>

On 8 April 2017 at 06:43, Omar Rizwan <omar.rizwan@gmail.com> wrote:
> Signed-off-by: Omar Rizwan <omar.rizwan@gmail.com>
> ---
>  hw/arm/Makefile.objs         |   2 +-
>  hw/arm/bcm2835.c             | 119 +++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/bcm2835_peripherals.c |   1 +
>  hw/arm/raspi.c               |  47 ++++++++++++++---
>  include/hw/arm/bcm2835.h     |  31 +++++++++++
>  5 files changed, 191 insertions(+), 9 deletions(-)
>  create mode 100644 hw/arm/bcm2835.c
>  create mode 100644 include/hw/arm/bcm2835.h

Hi; thanks for this patch. I have a few comments below to add to the ones
from Andrew.


> +/* Peripheral base address seen by the CPU */
> +#define BCM2835_PERI_BASE       0x20000000
> +
> +static void bcm2835_init(Object *obj)
> +{
> +    BCM2835State *s = BCM2835(obj);
> +
> +    object_initialize(&s->cpu, sizeof(s->cpu), "arm1176-" TYPE_ARM_CPU);
> +    object_property_add_child(obj, "cpu", OBJECT(&s->cpu), &error_abort);
> +
> +    object_initialize(&s->peripherals, sizeof(s->peripherals),
> +                      TYPE_BCM2835_PERIPHERALS);
> +    object_property_add_child(obj, "peripherals", OBJECT(&s->peripherals),
> +                              &error_abort);
> +    object_property_add_alias(obj, "board-rev", OBJECT(&s->peripherals),
> +                              "board-rev", &error_abort);
> +    object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
> +                              "vcram-size", &error_abort);
> +    qdev_set_parent_bus(DEVICE(&s->peripherals), sysbus_get_default());
> +}
> +
> +static void bcm2835_realize(DeviceState *dev, Error **errp)
> +{
> +    BCM2835State *s = BCM2835(dev);
> +    Object *obj;
> +    Error *err = NULL;
> +
> +    /* common peripherals from bcm2835 */
> +    obj = object_property_get_link(OBJECT(dev), "ram", &err);
> +    if (obj == NULL) {
> +        error_setg(errp, "%s: required ram link not found: %s",
> +                   __func__, error_get_pretty(err));
> +        return;
> +    }
> +
> +    object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    object_property_set_bool(OBJECT(&s->peripherals), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->peripherals),
> +                              "sd-bus", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
> +                            BCM2835_PERI_BASE, 1);
> +
> +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 1,
> +                            0x40000000, 1);

If this mapping is correct, can we have a #define for this address, like we
do for BCM2835_PERI_BASE ?

(I see from Andrew's review that it's not clear whether we should be
mapping this here.)

> +
> +    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
> +    if (err) {
> +        error_report_err(err);
> +        exit(1);
> +    }
> +
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
> +                       qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
> +                       qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
> +
> +}
> +
> +static void bcm2835_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->realize = bcm2835_realize;
> +
> +    /*
> +     * Reason: creates an ARM CPU, thus use after free(), see
> +     * arm_cpu_class_init()
> +     */
> +    dc->cannot_destroy_with_object_finalize_yet = true;

This assignment and its attached comment can be deleted, because
the issue with arm_cpu_class_init() has now been fixed upstream
(there's a patchset on the list that removes the DeviceClass
field entirely).

> +}
> +
> +static const TypeInfo bcm2835_type_info = {
> +    .name = TYPE_BCM2835,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(BCM2835State),
> +    .instance_init = bcm2835_init,
> +    .class_init = bcm2835_class_init,
> +};
> +
> +static void bcm2835_register_types(void)
> +{
> +    type_register_static(&bcm2835_type_info);
> +}
> +
> +type_init(bcm2835_register_types)
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 369ef1e..a6cd54a 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -34,6 +34,7 @@ static void bcm2835_peripherals_init(Object *obj)
>      /* Internal memory region for peripheral bus addresses (not exported) */
>      memory_region_init(&s->gpu_bus_mr, obj, "bcm2835-gpu", (uint64_t)1 << 32);
>      object_property_add_child(obj, "gpu-bus", OBJECT(&s->gpu_bus_mr), NULL);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->gpu_bus_mr);

If we determine that this is correct, then we should delete the "(not exported)"
part of the comment above, because this added call to sysbus_init_mmio()
is exporting the memory region.

>      /* Internal memory region for request/response communication with
>       * mailbox-addressable peripherals (not exported)
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 2b295f1..dca6077 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -2,9 +2,11 @@
>   * Raspberry Pi emulation (c) 2012 Gregory Estrade
>   * Upstreaming code cleanup [including bcm2835_*] (c) 2013 Jan Petrous
>   *
> - * Rasperry Pi 2 emulation Copyright (c) 2015, Microsoft
> + * Raspberry Pi 2 emulation Copyright (c) 2015, Microsoft
>   * Written by Andrew Baumann
>   *
> + * Raspberry Pi 1 rebase onto master (c) 2017, Omar Rizwan
> + *
>   * This code is licensed under the GNU GPLv2 and later.
>   */
>
> @@ -12,6 +14,7 @@
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
> +#include "hw/arm/bcm2835.h"
>  #include "hw/arm/bcm2836.h"
>  #include "qemu/error-report.h"
>  #include "hw/boards.h"
> @@ -27,6 +30,11 @@
>  /* Table of Linux board IDs for different Pi versions */
>  static const int raspi_boardid[] = {[1] = 0xc42, [2] = 0xc43};
>
> +/* Table of board revisions:
> + * https://github.com/AndrewFromMelbourne/raspberry_pi_revision/blob/2764c19983fb7b1ef8cb21031e94c293703afa2e/README.md
> + */
> +static const uint32_t raspi_boardrev[] = {[1] = 0x10, [2] = 0xa21041};

So we have three things here that are per-board:
 * the boardid value
 * the boardrev value
 * the soc_type value

which we have stored in two arrays plus passing a different parameter
to the raspi_machine_init function.

Perhaps this would be better as a
typedef struct RPiInfo {
    const char *soc_type;
    uint32_t boardrev;
    uint32_t boardid;
} RPiInfo;

static const RPiInfo rpi_boards[] = {
    {
         /* Raspberry Pi 1 */
         .soc_type = TYPE_BCM2835,
         .boardrev = 0x10,
         .boardid = 0xc42,
    }, {
         /* Raspberry Pi 2 */
         ...
    }
};

?

thanks
-- PMM
