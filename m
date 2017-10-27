Received: from eggs.gnu.org ([2001:4830:134:3::10]:49135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1e84fF-0000dx-Ct
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1e84f9-0008LI-08
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:27:09 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:48900
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1e84f8-0008Jv-Lj
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:27:02 -0400
References: <1509014053-28134-1-git-send-email-costa@advantech.ca>
	<1509014053-28134-5-git-send-email-costa@advantech.ca>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <ce594dce-2671-3d52-97c7-a96273da01c1@adacore.com>
Date: Fri, 27 Oct 2017 15:26:58 +0200
MIME-Version: 1.0
In-Reply-To: <1509014053-28134-5-git-send-email-costa@advantech.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/5]arm: kinetis_k64_uart
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gabriel Costa <gabriel291075@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org, f4bug@amsat.org



On 10/26/2017 12:34 PM, Gabriel Costa wrote:
> From: Gabriel Augusto Costa <gabriel291075@gmail.com>
> 
> This Patch include kinetis_k64_uart.c and .h
> uart means Universal Asynchronous Receiver/Transmitter (UART)
> More information about this peripheral can be found at:
> pag 1529, K64P144M120SF5RM.pdf.
> 
> Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
> ---
>   hw/char/kinetis_k64_uart.c         | 342 +++++++++++++++++++++++++++++++++++++
>   include/hw/char/kinetis_k64_uart.h |  79 +++++++++
>   2 files changed, 421 insertions(+)
>   create mode 100644 hw/char/kinetis_k64_uart.c
>   create mode 100644 include/hw/char/kinetis_k64_uart.h
> 
> diff --git a/hw/char/kinetis_k64_uart.c b/hw/char/kinetis_k64_uart.c
> new file mode 100644
> index 0000000..fc9327d
> --- /dev/null
> +++ b/hw/char/kinetis_k64_uart.c
> @@ -0,0 +1,342 @@
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
> +#include "hw/char/kinetis_k64_uart.h"
> +
> +static const VMStateDescription vmstate_kinetis_k64_uart = {
> +    .name = TYPE_KINETIS_K64_UART,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(BDH, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(BDL, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(C1, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(C2, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(S1, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(S2, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(C3, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(D, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(MA1, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(MA2, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(C4, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(C5, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(ED, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(MODEM, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(IR, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(PFIFO, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(CFIFO, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(SFIFO, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(TWFIFO, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(TCFIFO, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(RWFIFO, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(RCFIFO, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(C7816, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(IE7816, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(IS7816, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(WP7816Tx, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(WN7816, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(WF7816, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(ET7816, kinetis_k64_uart_state),
> +        VMSTATE_UINT8(TL7816, kinetis_k64_uart_state),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void kinetis_k64_uart_reset(DeviceState *dev)
> +{
> +    kinetis_k64_uart_state *s = KINETIS_K64_UART(dev);
> +
> +    s->BDH = 0x00;
> +    s->BDL = 0x04;
> +    s->C1 = 0x00;
> +    s->C2 = 0x00;
> +    s->S1 = 0xC0;
> +    s->S2 = 0x00;
> +    s->C3 = 0x00;
> +    s->D = 0x00;
> +    s->MA1 = 0x00;
> +    s->MA2 = 0x00;
> +    s->C4 = 0x00;
> +    s->C5 = 0x00;
> +    s->ED = 0x00;
> +    s->MODEM = 0x00;
> +    s->IR = 0x00;
> +    s->PFIFO = 0x00;
> +    s->CFIFO = 0x00;
> +    s->SFIFO = 0xC0;
> +    s->TWFIFO = 0x00;
> +    s->TCFIFO = 0x00;
> +    s->RWFIFO = 0x01;
> +    s->RCFIFO = 0x00;
> +    s->C7816 = 0x00;
> +    s->IE7816 = 0x00;
> +    s->IS7816 = 0x00;
> +    s->WP7816Tx = 0x0A;
> +    s->WN7816 = 0x00;
> +    s->WF7816 = 0x01;
> +    s->ET7816 = 0x00;
> +    s->TL7816 = 0x00;

Same as previous patch. One array + offset defined will simplify
all of that in a memset and five affectations.

> +
> +    qemu_set_irq(s->irq, 0);
> +}
> +
> +static void kinetis_k64_uart_write(void *opaque, hwaddr offset, uint64_t value,
> +        unsigned size)
> +{
> +    kinetis_k64_uart_state *s = (kinetis_k64_uart_state *)opaque;
> +
> +    value &= 0xFF;
> +
> +    switch (offset) {
> +    case 0x00:
> +        s->BDH = value;
> +        break;
> +    case 0x01:
> +        s->BDL = value;
> +        break;
> +    case 0x02:
> +        s->C1 = value;
> +        break;
> +    case 0x03:
> +        s->C2 = value;
> +        break;
> +    case 0x05:
> +        s->S2 = value;
> +        break;
> +    case 0x06:
> +        s->C3 = value;
> +        break;
> +    case 0x07:
> +        s->D = value;
> +        qemu_chr_fe_write_all(&s->chr, &s->D, 1);
> +        break;
> +    case 0x08:
> +        s->MA1 = value;
> +        break;
> +    case 0x09:
> +        s->MA2 = value;
> +        break;
> +    case 0x0A:
> +        s->C4 = value;
> +        break;
> +    case 0x0B:
> +        s->C5 = value;
> +        break;
> +    case 0x0D:
> +        s->MODEM = value;
> +        break;
> +    case 0x0E:
> +        s->IR = value;
> +        break;
> +    case 0x10:
> +        s->PFIFO = value;
> +        break;
> +    case 0x11:
> +        s->CFIFO = value;
> +        break;
> +    case 0x12:
> +        s->SFIFO = value;
> +        break;
> +    case 0x13:
> +        s->TWFIFO = value;
> +        break;
> +    case 0x15:
> +        s->RWFIFO = value;
> +        break;
> +    case 0x18:
> +        s->C7816 = value;
> +        break;
> +    case 0x19:
> +        s->IE7816 = value;
> +        break;
> +    case 0x1A:
> +        s->IS7816 = value;
> +        break;
> +    case 0x1B:
> +        s->WP7816Tx = value;
> +        break;
> +    case 0x1C:
> +        s->WN7816 = value;
> +        break;
> +    case 0x1D:
> +        s->WF7816 = value;
> +        break;
> +    case 0x1E:
> +        s->ET7816 = value;
> +        break;
> +    case 0x1F:
> +        s->TL7816 = value;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "kinetis_k64_uart: write at bad offset 0x%x\n",
> +                (int)offset);
> +    }
> +}
> +
> +static uint64_t kinetis_k64_uart_read(void *opaque, hwaddr offset,
> +        unsigned size)
> +{
> +    kinetis_k64_uart_state *s = (kinetis_k64_uart_state *)opaque;
> +
> +    switch (offset) {
> +    case 0x00:
> +        return s->BDH;
> +    case 0x01:
> +        return s->BDL;
> +    case 0x02:
> +        return s->C1;
> +    case 0x03:
> +        return s->C2;
> +    case 0x04:
> +        return s->S1;
> +    case 0x05:
> +        return s->S2;
> +    case 0x06:
> +        return s->C3;
> +    case 0x07:
> +        s->RCFIFO = 0;
> +        qemu_chr_fe_accept_input(&s->chr);
> +        return s->D;
> +    case 0x08:
> +        return s->MA1;
> +    case 0x09:
> +        return s->MA2;
> +    case 0x0A:
> +        return s->C4;
> +    case 0x0B:
> +        return s->C5;
> +    case 0x0C:
> +        return s->ED;
> +    case 0x0D:
> +        return s->MODEM;
> +    case 0x0E:
> +        return s->IR;
> +    case 0x10:
> +        return s->PFIFO;
> +    case 0x11:
> +        return s->CFIFO;
> +    case 0x12:
> +        return s->SFIFO;
> +    case 0x13:
> +        return s->TWFIFO;
> +    case 0x14:
> +        return s->TCFIFO;
> +    case 0x15:
> +        return s->RWFIFO;
> +    case 0x16:
> +        return s->RCFIFO;
> +    case 0x18:
> +        return s->C7816;
> +    case 0x19:
> +        return s->IE7816;
> +    case 0x1A:
> +        return s->IS7816;
> +    case 0x1B:
> +        return s->WP7816Tx;
> +    case 0x1C:
> +        return s->WN7816;
> +    case 0x1D:
> +        return s->WF7816;
> +    case 0x1E:
> +        return s->ET7816;
> +    case 0x1F:
> +        return s->TL7816;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "kinetis_k64_uart: read at bad offset 0x%x\n", (int)offset);
> +        return 0;
> +    }
> +}
> +
> +static const MemoryRegionOps kinetis_k64_uart_ops = {
> +    .read = kinetis_k64_uart_read,
> +    .write = kinetis_k64_uart_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,

You're missing the .valid, .impl field?
eg:
What shoud happen if the CPU does a 32bits r/w on this area?

Fred

> +};
> +
> +static int kinetis_k64_uart_can_receive(void *opaque)
> +{
> +    kinetis_k64_uart_state *s = (kinetis_k64_uart_state *)opaque;
> +
> +    if (s->RCFIFO == 0) {
> +        return 1; /*Can read a byte*/
> +    } else {
> +        return 0; /*Cannot read a byte*/
> +    }
> +}
> +
> +static void kinetis_k64_uart_receive(void *opaque, const uint8_t *buf, int size)
> +{
> +    kinetis_k64_uart_state *s = (kinetis_k64_uart_state *)opaque;
> +
> +    if (size > 0) {
> +        if (buf != NULL) {
> +            s->D = buf[0];
> +            s->RCFIFO = 1;
> +        }
> +    }
> +}
> +
> +static void kinetis_k64_uart_realize(DeviceState *dev, Error **errp)
> +{
> +    kinetis_k64_uart_state *s = KINETIS_K64_UART(dev);
> +
> +    qemu_chr_fe_set_handlers(&s->chr, kinetis_k64_uart_can_receive,
> +                             kinetis_k64_uart_receive, NULL, NULL,
> +                             s, NULL, true);
> +}
> +
> +static Property kinetis_k64_uart_properties[] = {
> +    DEFINE_PROP_CHR("chardev", kinetis_k64_uart_state, chr),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void kinetis_k64_uart_init(Object *obj)
> +{
> +    kinetis_k64_uart_state *s = KINETIS_K64_UART(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &kinetis_k64_uart_ops, s,
> +            TYPE_KINETIS_K64_UART, 0x1000);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_irq(sbd, &s->irq);
> +}
> +
> +static void kinetis_k64_uart_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->vmsd = &vmstate_kinetis_k64_uart;
> +    dc->reset = kinetis_k64_uart_reset;
> +    dc->desc = "Kinetis K64 series UART";
> +    dc->hotpluggable = false;
> +    dc->props = kinetis_k64_uart_properties;
> +    dc->realize = kinetis_k64_uart_realize;
> +}
> +
> +static const TypeInfo kinetis_k64_uart_info = {
> +    .name          = TYPE_KINETIS_K64_UART,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(kinetis_k64_uart_state),
> +    .instance_init = kinetis_k64_uart_init,
> +    .class_init    = kinetis_k64_uart_class_init,
> +};
> +
> +static void kinetis_k64_uart_register_types(void)
> +{
> +    type_register_static(&kinetis_k64_uart_info);
> +}
> +
> +type_init(kinetis_k64_uart_register_types)
> diff --git a/include/hw/char/kinetis_k64_uart.h b/include/hw/char/kinetis_k64_uart.h
> new file mode 100644
> index 0000000..5b57d0d
> --- /dev/null
> +++ b/include/hw/char/kinetis_k64_uart.h
> @@ -0,0 +1,79 @@
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
> +#ifndef KINETIS_UART_H
> +#define KINETIS_UART_H
> +
> +#include "hw/sysbus.h"
> +#include "chardev/char-fe.h"
> +#include "hw/hw.h"
> +
> +#define TYPE_KINETIS_K64_UART "kinetis_k64_uart"
> +#define KINETIS_K64_UART(obj) \
> +    OBJECT_CHECK(kinetis_k64_uart_state, (obj), TYPE_KINETIS_K64_UART)
> +
> +typedef struct {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +
> +    uint8_t BDH;
> +    uint8_t BDL;
> +    uint8_t C1;
> +    uint8_t C2;
> +    uint8_t S1;
> +    uint8_t S2;
> +    uint8_t C3;
> +    uint8_t D;
> +    uint8_t MA1;
> +    uint8_t MA2;
> +    uint8_t C4;
> +    uint8_t C5;
> +    uint8_t ED;
> +    uint8_t MODEM;
> +    uint8_t IR;
> +    uint8_t PFIFO;
> +    uint8_t CFIFO;
> +    uint8_t SFIFO;
> +    uint8_t TWFIFO;
> +    uint8_t TCFIFO;
> +    uint8_t RWFIFO;
> +    uint8_t RCFIFO;
> +    uint8_t C7816;
> +    uint8_t IE7816;
> +    uint8_t IS7816;
> +    uint8_t WP7816Tx;
> +    uint8_t WN7816;
> +    uint8_t WF7816;
> +    uint8_t ET7816;
> +    uint8_t TL7816;
> +
> +    qemu_irq irq;
> +    CharBackend chr;
> +} kinetis_k64_uart_state;
> +
> +static inline DeviceState *kinetis_k64_uart_create(hwaddr addr, qemu_irq irq,
> +        Chardev *chr)
> +{
> +    DeviceState *dev;
> +    SysBusDevice *s;
> +
> +    dev = qdev_create(NULL, TYPE_KINETIS_K64_UART);
> +    qdev_prop_set_chr(dev, "chardev", chr);
> +    qdev_init_nofail(dev);
> +    s = SYS_BUS_DEVICE(dev);
> +    sysbus_mmio_map(s, 0, addr);
> +    sysbus_connect_irq(s, 0, irq);
> +
> +    return dev;
> +}
> +
> +#endif
> 
