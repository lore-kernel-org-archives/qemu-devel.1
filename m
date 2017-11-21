Received: from eggs.gnu.org ([2001:4830:134:3::10]:57231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH9sp-0003Zi-LD
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:50:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH9so-0003SY-AA
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:50:43 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:46775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eH9so-0003S2-3s
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:50:42 -0500
Received: by mail-oi0-x244.google.com with SMTP id a81so8679151oii.13
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 06:50:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1509107055-21978-4-git-send-email-costa@advantech.ca>
References: <1509107055-21978-1-git-send-email-costa@advantech.ca>
	<1509107055-21978-4-git-send-email-costa@advantech.ca>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 14:50:20 +0000
Message-ID: <CAFEAcA-TBGRDXk=udVPxovMDCw+tC5YUbRzxBK4e1oyEwxoang@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 3/5] arm: kinetis_k64_pmux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gabriel Costa <gabriel291075@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 27 October 2017 at 13:24, Gabriel Costa <gabriel291075@gmail.com> wrote:
> This Patch include kinetis_k64_pmux.c/.h
> pmux is refered as Port Control and Interrupts (PORT)
> More information about this peripheral can be found at:
> pag 273, K64P144M120SF5RM.pdf.
>
> Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
> ---
>  hw/misc/kinetis_k64_pmux.c         | 158 +++++++++++++++++++++++++++++++++++++
>  include/hw/misc/kinetis_k64_pmux.h |  38 +++++++++
>  2 files changed, 196 insertions(+)
>  create mode 100644 hw/misc/kinetis_k64_pmux.c
>  create mode 100644 include/hw/misc/kinetis_k64_pmux.h
>
> diff --git a/hw/misc/kinetis_k64_pmux.c b/hw/misc/kinetis_k64_pmux.c
> new file mode 100644
> index 0000000..8346ef7
> --- /dev/null
> +++ b/hw/misc/kinetis_k64_pmux.c
> @@ -0,0 +1,158 @@
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
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "qemu/log.h"
> +#include "hw/misc/kinetis_k64_pmux.h"
> +
> +static const VMStateDescription vmstate_kinetis_k64_pmux = {
> +    .name = TYPE_KINETIS_K64_PMUX,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(PCR, kinetis_k64_pmux_state, 32),

Please #define a symbolic constant for the size of this array.

> +        VMSTATE_UINT32(GPCLR, kinetis_k64_pmux_state),
> +        VMSTATE_UINT32(GPCHR, kinetis_k64_pmux_state),
> +        VMSTATE_UINT32(ISFR, kinetis_k64_pmux_state),
> +        VMSTATE_UINT32(DFER, kinetis_k64_pmux_state),
> +        VMSTATE_UINT32(DFCR, kinetis_k64_pmux_state),
> +        VMSTATE_UINT32(DFWR, kinetis_k64_pmux_state),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void kinetis_k64_pmux_reset(DeviceState *dev)
> +{
> +    kinetis_k64_pmux_state *s = KINETIS_K64_PMUX(dev);
> +    uint8_t cnt;
> +
> +    for (cnt = 0; cnt < 32; cnt++) {

"cnt < ARRAY_SIZE(s->PCR)" makes it clear you have
the right loop bound to not overrun the array.

> +        s->PCR[cnt] = 0x00000000;

Just say "0".

> +    }
> +    s->GPCLR = 0x00000000;
> +    s->GPCHR = 0x00000000;
> +    s->ISFR = 0x00000000;
> +    s->DFER = 0x00000000;
> +    s->DFCR = 0x00000000;
> +    s->DFWR = 0x00000000;
> +}
> +
> +static void kinetis_k64_pmux_write(void *opaque, hwaddr offset, uint64_t value,
> +        unsigned size)
> +{
> +    kinetis_k64_pmux_state *s = (kinetis_k64_pmux_state *)opaque;
> +
> +    value &= 0xFFFFFFFF;

This mask is unnecessary, because you are using the default
max_access_size for your MemoryRegionOps, which is 4.

(You should check whether this device permits byte accesses;
if not, consider setting min_access_size.)

> +    switch (offset) {
> +    case 0x00 ... 0x7C:
> +        s->PCR[offset >> 2] = value;

Some of the bits in these registers are read-only.

> +        break;
> +    case 0x80:
> +        s->GPCLR = value;
> +        break;
> +    case 0x84:
> +        s->GPCHR = value;
> +        break;
> +    case 0xA0:
> +        s->ISFR = value;

ISFR is write-1-to-clear, not this behaviour.

(Also, actual implementation of the interrupts seems to be missing.)

> +        break;
> +    case 0xC0:
> +        s->DFER = value;
> +        break;
> +    case 0xC4:
> +        s->DFCR = value;
> +        break;
> +    case 0xC8:
> +        s->DFWR = value;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "kinetis_k64_pmux: write at bad offset %"HWADDR_PRIx"\n", offset);
> +    }
> +}
> +
> +static uint64_t kinetis_k64_pmux_read(void *opaque, hwaddr offset,
> +        unsigned size)
> +{
> +    kinetis_k64_pmux_state *s = (kinetis_k64_pmux_state *)opaque;
> +    uint8_t value;
> +
> +    switch (offset) {
> +    case 0x00 ... 0x7C:
> +        value = s->PCR[offset >> 2];
> +        break;
> +    case 0x80:
> +        value = s->GPCLR;

This register is write-only (reads return 0), as is GPCHR. Check
the data sheet.

> +        break;
> +    case 0x84:
> +        value = s->GPCHR;
> +        break;
> +    case 0xA0:
> +        value = s->ISFR;
> +        break;
> +    case 0xC0:
> +        value = s->DFER;
> +        break;
> +    case 0xC4:
> +        value = s->DFCR;
> +        break;
> +    case 0xC8:
> +        value = s->DFWR;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "kinetis_k64_pmux: read at bad offset %"HWADDR_PRIx"\n", offset);
> +        return 0;
> +    }
> +    return value;
> +}
> +
> +static const MemoryRegionOps kinetis_k64_pmux_ops = {
> +    .read = kinetis_k64_pmux_read,
> +    .write = kinetis_k64_pmux_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void kinetis_k64_pmux_init(Object *obj)
> +{
> +    kinetis_k64_pmux_state *s = KINETIS_K64_PMUX(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &kinetis_k64_pmux_ops, s,
> +            TYPE_KINETIS_K64_PMUX, 0x1000);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_irq(sbd, &s->irq);

Again, you've defined an interrupt and done nothing with it.

> +}
> +
> +static void kinetis_k64_pmux_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->vmsd = &vmstate_kinetis_k64_pmux;
> +    dc->reset = kinetis_k64_pmux_reset;
> +    dc->desc = "Kinetis K64 series PMUX";
> +}
> +
> +static const TypeInfo kinetis_k64_pmux_info = {
> +    .name          = TYPE_KINETIS_K64_PMUX,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(kinetis_k64_pmux_state),
> +    .instance_init = kinetis_k64_pmux_init,
> +    .class_init    = kinetis_k64_pmux_class_init,
> +};
> +
> +static void kinetis_k64_pmux_register_types(void)
> +{
> +    type_register_static(&kinetis_k64_pmux_info);
> +}
> +
> +type_init(kinetis_k64_pmux_register_types)
> diff --git a/include/hw/misc/kinetis_k64_pmux.h b/include/hw/misc/kinetis_k64_pmux.h
> new file mode 100644
> index 0000000..49359ac
> --- /dev/null
> +++ b/include/hw/misc/kinetis_k64_pmux.h
> @@ -0,0 +1,38 @@
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
> +#ifndef KINETIS_PMUX_H
> +#define KINETIS_PMUX_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/hw.h"
> +
> +#define TYPE_KINETIS_K64_PMUX "kinetis_k64_pmux"
> +#define KINETIS_K64_PMUX(obj) \
> +    OBJECT_CHECK(kinetis_k64_pmux_state, (obj), TYPE_KINETIS_K64_PMUX)
> +
> +typedef struct {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +
> +    uint32_t PCR[32];
> +    uint32_t GPCLR;
> +    uint32_t GPCHR;
> +    uint32_t ISFR;
> +    uint32_t DFER;
> +    uint32_t DFCR;
> +    uint32_t DFWR;
> +
> +    qemu_irq irq;
> +} kinetis_k64_pmux_state;

Same comments about coding style for struct and field names
as for other patches.

> +
> +#endif
> --
> 2.1.4
>

thanks
-- PMM
