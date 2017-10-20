Received: from eggs.gnu.org ([2001:4830:134:3::10]:35498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5fR1-0002KN-J7
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5fQx-0003wd-Jd
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:06:31 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:45164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5fQx-0003wX-Dm
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:06:27 -0400
Received: by mail-qt0-x233.google.com with SMTP id p1so20217046qtg.2
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 15:06:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508514204-16019-1-git-send-email-gabriel291075@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8a805ab0-e41a-77da-73f2-40a0f1c39140@amsat.org>
Date: Fri, 20 Oct 2017 19:06:23 -0300
MIME-Version: 1.0
In-Reply-To: <1508514204-16019-1-git-send-email-gabriel291075@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 10/11] kinetis_k64_flextimer.c has been
 added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gabriel Augusto Costa <gabriel291075@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Hi Gabriel,

On 10/20/2017 12:43 PM, Gabriel Augusto Costa wrote:
> I made a new arm machine with some peripherals. The machine is mk64fn1m0, a
> cortex-m4 microcontroller from NXP Kinetis family. The machine can run a
> simple arm binary file using UART0 in polling mode.
> I have prepared a series of patchs to include this machine:
> PATCH v3 n/11: It adds the machine and peripherals devices;
> PATCH v4 n/2: It changes the Make files to compile this machine.
> 
> Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
> ---
>  hw/timer/kinetis_k64_flextimer.c | 137 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 hw/timer/kinetis_k64_flextimer.c
> 
> diff --git a/hw/timer/kinetis_k64_flextimer.c b/hw/timer/kinetis_k64_flextimer.c
> new file mode 100644
> index 0000000..7edad6d
> --- /dev/null
> +++ b/hw/timer/kinetis_k64_flextimer.c
> @@ -0,0 +1,137 @@
> +/*
> + * Kinetis K64 peripheral microcontroller emulation.
> + *
> + * Copyright (c) 2017 Advantech Wireless
> + * Written by Gabriel Costa <gabriel291075@gmail.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 or
> + *  (at your option) any later version.
> + */
> +
> +/* Kinetis K64 series FLEXTIMER controller.  */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "hw/ssi/ssi.h"
> +#include "hw/arm/arm.h"
> +#include "hw/devices.h"
> +#include "qemu/timer.h"
> +#include "net/net.h"
> +#include "hw/boards.h"
> +#include "qemu/log.h"
> +#include "exec/address-spaces.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/char/pl011.h"
> +#include "hw/misc/unimp.h"
> +#include "hw/timer/kinetis_k64_flextimer.h"
> +
> +static const VMStateDescription vmstate_kinetis_k64_flextimer = {
> +    .name = TYPE_KINETIS_K64_FLEXTIMER,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(SC, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(CNT, kinetis_k64_flextimer_state),
> +/*        VMSTATE_UINT32(CONTROLS[0], kinetis_k64_flextimer_state),*/
> +        VMSTATE_UINT32(CNTIN, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(STATUS, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(MODE, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(SYNC, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(OUTINIT, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(OUTMASK, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(COMBINE, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(DEADTIME, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(EXTTRIG, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(POL, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(FMS, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(FILTER, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(FLTCTRL, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(QDCTRL, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(CONF, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(FLTPOL, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(SYNCONF, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(INVCTRL, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(SWOCTRL, kinetis_k64_flextimer_state),
> +        VMSTATE_UINT32(PWMLOAD, kinetis_k64_flextimer_state),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void kinetis_k64_flextimer_reset(DeviceState *dev)
> +{
> +    kinetis_k64_flextimer_state *s = KINETIS_K64_FLEXTIMER(dev);
> +
> +    s->CNT = 0x00;
> +}
> +
> +static void kinetis_k64_flextimer_write(void *opaque, hwaddr offset,
> +        uint64_t value, unsigned size)
> +{
> +/*    kinetis_k64_flextimer_state *s = (kinetis_k64_flextimer_state *)opaque;*/
> +
> +    value &= 0xFF;
> +
> +    switch (offset) {
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "kinetis_k64_flextimer: write at bad offset 0x%x\n",
> +                (int)offset);
> +    }
> +}
> +
> +static uint64_t kinetis_k64_flextimer_read(void *opaque, hwaddr offset,
> +        unsigned size)
> +{
> +/*    kinetis_k64_flextimer_state *s = (kinetis_k64_flextimer_state *)opaque;*/
> +
> +    switch (offset) {
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "kinetis_k64_flextimer: read at bad offset 0x%x\n",
> +                (int)offset);
> +    }
> +    return 0;
> +}

what not use create_unimplemented_device() directly?

> +
> +static const MemoryRegionOps kinetis_k64_flextimer_ops = {
> +    .read = kinetis_k64_flextimer_read,
> +    .write = kinetis_k64_flextimer_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void kinetis_k64_flextimer_init(Object *obj)
> +{
> +    kinetis_k64_flextimer_state *s = KINETIS_K64_FLEXTIMER(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &kinetis_k64_flextimer_ops, s,
> +            TYPE_KINETIS_K64_FLEXTIMER, 0x1000);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_irq(sbd, &s->irq);
> +}
> +
> +static void kinetis_k64_flextimer_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->vmsd = &vmstate_kinetis_k64_flextimer;
> +    dc->reset = kinetis_k64_flextimer_reset;
> +    dc->desc = "Kinetis K64 series FlexTimer";
> +}
> +
> +static const TypeInfo kinetis_k64_flextimer_info = {
> +    .name          = TYPE_KINETIS_K64_FLEXTIMER,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(kinetis_k64_flextimer_state),
> +    .instance_init = kinetis_k64_flextimer_init,
> +    .class_init    = kinetis_k64_flextimer_class_init,
> +};
> +
> +static void kinetis_k64_flextimer_register_types(void)
> +{
> +    type_register_static(&kinetis_k64_flextimer_info);
> +}
> +
> +type_init(kinetis_k64_flextimer_register_types)
> 
