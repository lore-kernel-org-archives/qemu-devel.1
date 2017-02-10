Received: from eggs.gnu.org ([2001:4830:134:3::10]:55614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cc55H-0007pQ-Bb
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 01:53:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cc55E-00017y-4r
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 01:53:31 -0500
Received: from greensocs.com ([193.104.36.180]:47787)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cc55D-00017P-K1
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 01:53:28 -0500
References: <1486666321-21536-1-git-send-email-juro.bystricky@intel.com>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <301d03bb-8352-95ad-80c7-638e5ea7a4f5@greensocs.com>
Date: Fri, 10 Feb 2017 07:53:21 +0100
MIME-Version: 1.0
In-Reply-To: <1486666321-21536-1-git-send-email-juro.bystricky@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] nios2: Add Altera JTAG UART emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juro Bystricky <juro.bystricky@intel.com>
Cc: qemu-devel@nongnu.org, marex@denx.de, jurobystricky@hotmail.com, crwulff@gmail.com

Hi,

On 02/09/2017 07:52 PM, Juro Bystricky wrote:
> JTAG UART core eliminates the need for a separate RS-232 serial
> connection to a host PC for character I/O.
>=20
> Hardware emulation based on:
> https://www.altera.com/en_US/pdfs/literature/ug/ug_embedded_ip.pdf
> (Please see "Register Map" on page 65)
>=20
> Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
> ---
>  default-configs/nios2-softmmu.mak |   1 +
>  hw/char/Makefile.objs             |   1 +
>  hw/char/altera_juart.c            | 288 ++++++++++++++++++++++++++++++=
++++++++
>  include/hw/char/altera_juart.h    |  46 ++++++
>  4 files changed, 336 insertions(+)
>  create mode 100644 hw/char/altera_juart.c
>  create mode 100644 include/hw/char/altera_juart.h
>=20
> diff --git a/default-configs/nios2-softmmu.mak b/default-configs/nios2-=
softmmu.mak
> index 74dc70c..6159846 100644
> --- a/default-configs/nios2-softmmu.mak
> +++ b/default-configs/nios2-softmmu.mak
> @@ -4,3 +4,4 @@ CONFIG_NIOS2=3Dy
>  CONFIG_SERIAL=3Dy
>  CONFIG_PTIMER=3Dy
>  CONFIG_ALTERA_TIMER=3Dy
> +CONFIG_ALTERA_JUART=3Dy
> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> index 6ea76fe..f0d0e25 100644
> --- a/hw/char/Makefile.objs
> +++ b/hw/char/Makefile.objs
> @@ -27,5 +27,6 @@ common-obj-$(CONFIG_LM32) +=3D lm32_juart.o
>  common-obj-$(CONFIG_LM32) +=3D lm32_uart.o
>  common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-uart.o
>  common-obj-$(CONFIG_SCLPCONSOLE) +=3D sclpconsole.o sclpconsole-lm.o
> +common-obj-$(CONFIG_ALTERA_JUART) +=3D altera_juart.o
> =20
>  obj-$(CONFIG_VIRTIO) +=3D virtio-serial-bus.o
> diff --git a/hw/char/altera_juart.c b/hw/char/altera_juart.c
> new file mode 100644
> index 0000000..0325ddc
> --- /dev/null
> +++ b/hw/char/altera_juart.c
> @@ -0,0 +1,288 @@
> +/*
> + * QEMU model of the Altera JTAG UART.
> + *
> + * Copyright (c) 2016-2017 Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + * You should have received a copy of the GNU General Public License a=
long
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * The Altera JTAG UART hardware registers are described in:
> + * https://www.altera.com/en_US/pdfs/literature/ug/ug_embedded_ip.pdf
> + * (In particular "Register Map" on page 65)
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/char/altera_juart.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/error-report.h"
> +
> +/* Data register */
> +#define OFFSET_R_DATA   0
> +#define DATA_RVALID     BIT(15)
> +#define DATA_RAVAIL     0xFFFF0000
> +
> +/* Control register */
> +#define OFFSET_R_CONTROL 4
> +#define CONTROL_RE      BIT(0)
> +#define CONTROL_WE      BIT(1)
> +#define CONTROL_RI      BIT(8)
> +#define CONTROL_WI      BIT(9)
> +#define CONTROL_AC      BIT(10)
> +#define CONTROL_WSPACE  0xFFFF0000
> +
> +#define CONTROL_WMASK (CONTROL_RE | CONTROL_WE | CONTROL_AC)
> +
> +#define TYPE_ALTERA_JUART "altera-juart"
> +#define ALTERA_JUART(obj) \
> +    OBJECT_CHECK(AlteraJUARTState, (obj), TYPE_ALTERA_JUART)
> +
> +/*
> + * The JTAG UART core generates an interrupt when either of the indivi=
dual
> + * interrupt conditions is pending and enabled.
> + */
> +static void altera_juart_update_irq(AlteraJUARTState *s)
> +{
> +    unsigned int irq;
> +
> +    irq =3D ((s->jcontrol & CONTROL_WE) && (s->jcontrol & CONTROL_WI))=
 ||
> +          ((s->jcontrol & CONTROL_RE) && (s->jcontrol & CONTROL_RI));
> +
> +    qemu_set_irq(s->irq, irq);
> +}
> +
> +static uint64_t altera_juart_read(void *opaque, hwaddr addr, unsigned =
int size)
> +{
> +    AlteraJUARTState *s =3D opaque;
> +    uint32_t r;
> +
> +    switch (addr) {
> +    case OFFSET_R_DATA:
> +        r =3D s->rx_fifo[(s->rx_fifo_pos - s->rx_fifo_len) & (s->rx_fi=
fo_size - 1)];
> +        if (s->rx_fifo_len) {
> +            s->rx_fifo_len--;
> +            qemu_chr_fe_accept_input(&s->chr);
> +            s->jdata =3D r | DATA_RVALID | (s->rx_fifo_len << 16);
> +            s->jcontrol |=3D CONTROL_RI;
> +        } else {
> +            s->jdata =3D 0;
> +            s->jcontrol &=3D ~CONTROL_RI;
> +        }
> +
> +        altera_juart_update_irq(s);
> +        return s->jdata;
> +
> +    case OFFSET_R_CONTROL:
> +        return s->jcontrol;
> +    }
> +
> +    return 0;
> +}
> +
> +static void altera_juart_write(void *opaque, hwaddr addr,
> +                       uint64_t value, unsigned int size)
> +{
> +    AlteraJUARTState *s =3D opaque;
> +    unsigned char c;
> +
> +    switch (addr) {
> +    case OFFSET_R_DATA:
> +        c =3D value & 0xFF;
> +        /*
> +         * We do not decrement the write fifo,
> +         * we "tranmsmit" instanteniously, CONTROL_WI always asserted
> +         */
> +        s->jcontrol |=3D CONTROL_WI;
> +        s->jdata =3D c;
> +        qemu_chr_fe_write(&s->chr, &c, 1);
> +        altera_juart_update_irq(s);
> +        break;
> +
> +    case OFFSET_R_CONTROL:
> +        /* Only RE and WE are writable */
> +        value &=3D CONTROL_WMASK;
> +        s->jcontrol &=3D ~CONTROL_WMASK;
> +        s->jcontrol |=3D value;
> +
> +        /* Writing 1 to AC clears it to 0 */
> +        if (value & CONTROL_AC) {
> +            s->jcontrol &=3D ~CONTROL_AC;
> +        }
> +        altera_juart_update_irq(s);
> +        break;
> +    }
> +}
> +
> +static void altera_juart_receive(void *opaque, const uint8_t *buf, int=
 size)
> +{
> +    int i;
> +    AlteraJUARTState *s =3D opaque;
> +
> +    for (i =3D 0; i < size; i++) {
> +        s->rx_fifo[s->rx_fifo_pos] =3D buf[i];
> +        s->rx_fifo_pos++;
> +        s->rx_fifo_pos &=3D (s->rx_fifo_size - 1);
> +        s->rx_fifo_len++;
> +    }
> +    s->jcontrol |=3D CONTROL_RI;
> +    altera_juart_update_irq(s);
> +}
> +
> +static int altera_juart_can_receive(void *opaque)
> +{
> +    AlteraJUARTState *s =3D opaque;
> +    return s->rx_fifo_size - s->rx_fifo_len;
> +}
> +
> +static void altera_juart_reset(DeviceState *d)
> +{
> +    AlteraJUARTState *s =3D ALTERA_JUART(d);
> +
> +    s->jdata =3D 0;
> +
> +    /* The number of spaces available in the write FIFO */
> +    s->jcontrol =3D s->rx_fifo_size << 16;
> +    s->rx_fifo_pos =3D 0;
> +    s->rx_fifo_len =3D 0;
> +}
> +
> +static const MemoryRegionOps juart_ops =3D {
> +    .read =3D altera_juart_read,
> +    .write =3D altera_juart_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4
> +    }
> +};
> +
> +static void altera_juart_init(Object *obj)
> +{
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    AlteraJUARTState *s =3D ALTERA_JUART(obj);
> +
> +    memory_region_init_io(&s->mmio,  OBJECT(s), &juart_ops, s,
> +                          TYPE_ALTERA_JUART, 2 * 4);

What's this 2 * 4?
I'd suggest you use a #define for that.

> +    sysbus_init_mmio(sbd, &s->mmio);
> +    sysbus_init_irq(sbd, &s->irq);
> +}
> +
> +void altera_juart_create(int channel, const hwaddr addr, qemu_irq irq,=
 uint32_t fifo_size)
> +{
> +    DeviceState *dev;
> +    SysBusDevice *bus;
> +    Chardev *chr;
> +    const char chr_name[] =3D "juart";
> +    char label[ARRAY_SIZE(chr_name) + 1];
> +    bool fifo_size_ok;
> +    uint32_t size;
> +
> +    dev =3D qdev_create(NULL, TYPE_ALTERA_JUART);
> +
> +    if (channel >=3D MAX_SERIAL_PORTS) {
> +        error_report("Only %d serial ports are supported by QEMU",
> +                     MAX_SERIAL_PORTS);
> +        exit(1);
> +    }
> +
> +    chr =3D serial_hds[channel];
> +    if (!chr) {
> +        snprintf(label, ARRAY_SIZE(label), "%s%d", chr_name, channel);
> +        chr =3D qemu_chr_new(label, "null");
> +        if (!chr) {
> +            error_report("Can't assign serial port to altera juart%d",=
 channel);

Can't you reuse label?

> +            exit(1);
> +        }
> +    }
> +    qdev_prop_set_chr(dev, "chardev", chr);
> +
> +    /*
> +     * FIFO size can be set from 8 to 32,768 bytes.
> +     * Only powers of two are allowed.
> +     */
> +    fifo_size_ok =3D false;
> +    for (size =3D 8; size <=3D 32768; size *=3D 2) {
> +        if (size =3D=3D fifo_size) {
> +            fifo_size_ok =3D true;
> +            break;
> +        }
> +    }
> +
> +    if (!fifo_size_ok) {
> +        error_report("Invalid FIFO size: %u for juart%d", fifo_size, c=
hannel);
> +        exit(1);
> +    }
> +
> +    qdev_prop_set_uint32(dev, "fifo-size", fifo_size);
> +    bus =3D SYS_BUS_DEVICE(dev);
> +    qdev_init_nofail(dev);
> +
> +    if (addr !=3D (hwaddr)-1) {
> +        sysbus_mmio_map(bus, 0, addr);
> +    }
> +
> +    sysbus_connect_irq(bus, 0, irq);
> +}
> +
> +static const VMStateDescription vmstate_altera_juart =3D {
> +    .name =3D "altera-juart" ,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(jdata, AlteraJUARTState),
> +        VMSTATE_UINT32(jcontrol, AlteraJUARTState),
> +        VMSTATE_VBUFFER_UINT32(rx_fifo, AlteraJUARTState, 1, NULL, 0, =
rx_fifo_size),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void altera_juart_realize(DeviceState *dev, Error **errp)
> +{
> +    AlteraJUARTState *s =3D ALTERA_JUART(dev);
> +    qemu_chr_fe_set_handlers(&s->chr, altera_juart_can_receive,
> +                             altera_juart_receive, NULL, s, NULL, true=
);
> +    s->rx_fifo =3D g_malloc(s->rx_fifo_size);
> +}
> +
> +static void altera_juart_unrealize(DeviceState *dev, Error **errp)
> +{
> +    AlteraJUARTState *s =3D ALTERA_JUART(dev);
> +    g_free(s->rx_fifo);
> +}
> +
> +static Property altera_juart_props[] =3D {
> +    DEFINE_PROP_CHR("chardev", AlteraJUARTState, chr),
> +    DEFINE_PROP_UINT32("fifo-size", AlteraJUARTState, rx_fifo_size, DE=
FAULT_FIFO_SIZE),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void altera_juart_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +
> +    dc->realize =3D altera_juart_realize;
> +    dc->unrealize =3D altera_juart_unrealize;
> +    dc->props =3D altera_juart_props;
> +    dc->vmsd =3D &vmstate_altera_juart;
> +    dc->reset =3D altera_juart_reset;
> +    dc->desc =3D "Altera JTAG UART";
> +}
> +
> +static const TypeInfo altera_juart_info =3D {
> +    .name          =3D TYPE_ALTERA_JUART,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(AlteraJUARTState),
> +    .instance_init =3D altera_juart_init,
> +    .class_init    =3D altera_juart_class_init,
> +};
> +
> +static void altera_juart_register(void)
> +{
> +    type_register_static(&altera_juart_info);
> +}
> +
> +type_init(altera_juart_register)
> diff --git a/include/hw/char/altera_juart.h b/include/hw/char/altera_ju=
art.h
> new file mode 100644
> index 0000000..8b0a4a6
> --- /dev/null
> +++ b/include/hw/char/altera_juart.h
> @@ -0,0 +1,46 @@
> +/*
> + * Altera JTAG UART emulation
> + *
> + * Copyright (c) 2016-2017 Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + * You should have received a copy of the GNU General Public License a=
long
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef ALTERA_JUART_H
> +#define ALTERA_JUART_H
> +
> +#include "hw/sysbus.h"
> +#include "sysemu/char.h"
> +
> +/*
> + * The read and write FIFO depths can be set from 8 to 32,768 bytes.
> + * Only powers of two are allowed. A depth of 64 is generally optimal =
for
> + * performance, and larger values are rarely necessary.
> + */
> +
> +#define DEFAULT_FIFO_SIZE 64

The name here might conflict with other thing.
I'd change that by ALTERA_JUART_DEFAULT_FIFO_SZ or something.


> +
> +typedef struct AlteraJUARTState {
> +    SysBusDevice busdev;
> +    MemoryRegion mmio;
> +    CharBackend chr;
> +    qemu_irq irq;
> +
> +    unsigned int rx_fifo_size;
> +    unsigned int rx_fifo_pos;
> +    unsigned int rx_fifo_len;
> +    uint32_t jdata;
> +    uint32_t jcontrol;
> +    uint8_t *rx_fifo;
> +} AlteraJUARTState;
> +
> +void altera_juart_create(int channel, const hwaddr addr, qemu_irq irq,
> +                                                        uint32_t fifo_=
size);
> +
> +#endif /* ALTERA_JUART_H */
>=20

The rest seems ok to me.

Thanks,
Fred
