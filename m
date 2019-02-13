Received: from eggs.gnu.org ([209.51.188.92]:45185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gti63-000346-Hb
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 19:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gti5s-0001kl-MO
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 19:08:09 -0500
MIME-Version: 1.0
References: <20190212173839.31587-1-chouteau@adacore.com>
In-Reply-To: <20190212173839.31587-1-chouteau@adacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 12 Feb 2019 16:06:41 -0800
Message-ID: <CAKmqyKOAVDbJQ6avwWgDHP1fHD_EXdZmi+Sjucm05ZqNkQoUog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] SiFive RISC-V GPIO Device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabien Chouteau <chouteau@adacore.com>
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

On Tue, Feb 12, 2019 at 9:39 AM Fabien Chouteau <chouteau@adacore.com> wrot=
e:
>
> QEMU model of the GPIO device on the SiFive E300 series SOCs.
>
> The pins are not used by a board definition yet, however this
> implementation can already be used to trigger GPIO interrupts from the
> software by configuring a pin as both output and input.
>
> Signed-off-by: Fabien Chouteau <chouteau@adacore.com>

Hey,

Thanks for the patch!

> ---
>  Makefile.objs                  |   1 +
>  hw/riscv/Makefile.objs         |   1 +
>  hw/riscv/sifive_e.c            |  28 ++-
>  hw/riscv/sifive_gpio.c         | 388 +++++++++++++++++++++++++++++++++
>  hw/riscv/trace-events          |   7 +
>  include/hw/riscv/sifive_e.h    |   8 +-
>  include/hw/riscv/sifive_gpio.h |  72 ++++++
>  7 files changed, 501 insertions(+), 4 deletions(-)
>  create mode 100644 hw/riscv/sifive_gpio.c
>  create mode 100644 hw/riscv/trace-events
>  create mode 100644 include/hw/riscv/sifive_gpio.h
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 67a054b08a..d40eb089ae 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -184,6 +184,7 @@ trace-events-subdirs +=3D hw/virtio
>  trace-events-subdirs +=3D hw/watchdog
>  trace-events-subdirs +=3D hw/xen
>  trace-events-subdirs +=3D hw/gpio
> +trace-events-subdirs +=3D hw/riscv
>  trace-events-subdirs +=3D io
>  trace-events-subdirs +=3D linux-user
>  trace-events-subdirs +=3D migration
> diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
> index 1dde01d39d..ced7935371 100644
> --- a/hw/riscv/Makefile.objs
> +++ b/hw/riscv/Makefile.objs
> @@ -7,5 +7,6 @@ obj-y +=3D sifive_plic.o
>  obj-y +=3D sifive_test.o
>  obj-y +=3D sifive_u.o
>  obj-y +=3D sifive_uart.o
> +obj-y +=3D sifive_gpio.o

I know the other RISC-V files don't do it, but this should go in the
hw/gpio directory instead of hw/riscv.

>  obj-y +=3D spike.o
>  obj-y +=3D virt.o
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 5d9d65ff29..49c1dd986c 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -146,11 +146,15 @@ static void riscv_sifive_e_soc_init(Object *obj)
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->cpus), smp_cpus, "num-harts",
>                              &error_abort);
> +    sysbus_init_child_obj(obj, "riscv.sifive.e.gpio0",
> +                          &s->gpio, sizeof(s->gpio),
> +                          TYPE_SIFIVE_GPIO);
>  }
>
>  static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>  {
>      const struct MemmapEntry *memmap =3D sifive_e_memmap;
> +    Error *err =3D NULL;
>
>      SiFiveESoCState *s =3D RISCV_E_SOC(dev);
>      MemoryRegion *sys_mem =3D get_system_memory();
> @@ -184,8 +188,28 @@ static void riscv_sifive_e_soc_realize(DeviceState *=
dev, Error **errp)
>      sifive_mmio_emulate(sys_mem, "riscv.sifive.e.aon",
>          memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
>      sifive_prci_create(memmap[SIFIVE_E_PRCI].base);
> -    sifive_mmio_emulate(sys_mem, "riscv.sifive.e.gpio0",
> -        memmap[SIFIVE_E_GPIO0].base, memmap[SIFIVE_E_GPIO0].size);
> +
> +    /* GPIO */
> +
> +    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    /* Map GPIO registers */
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_E_GPIO0].=
base);
> +
> +    /* Pass all GPIOs to the SOC layer so they are available to the boar=
d */
> +    qdev_pass_gpios(DEVICE(&s->gpio), dev, NULL);
> +
> +    /* Connect GPIO interrupts to the PLIC */
> +    for (int i =3D 0; i < 32; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), i,
> +                           qdev_get_gpio_in(DEVICE(s->plic),
> +                                            SIFIVE_E_GPIO0_IRQ0 + i));
> +    }
> +

It's common in QEMU world to split your patch in two. One that adds
the device and then one that connects it.

In this case the patch isn't too complex so it's fine, just for future
reference.

>      sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART0].base,
>          serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_E_UART0_I=
RQ));
>      sifive_mmio_emulate(sys_mem, "riscv.sifive.e.qspi0",
> diff --git a/hw/riscv/sifive_gpio.c b/hw/riscv/sifive_gpio.c
> new file mode 100644
> index 0000000000..06bd8112d7
> --- /dev/null
> +++ b/hw/riscv/sifive_gpio.c
> @@ -0,0 +1,388 @@
> +/*
> + * sifive System-on-Chip general purpose input/output register definitio=
n
> + *
> + * Copyright 2019 AdaCore
> + *
> + * Base on nrf51_gpio.c:
> + *
> + * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/riscv/sifive_gpio.h"
> +#include "trace.h"
> +
> +static void update_output_irq(SIFIVEGPIOState *s)
> +{
> +

Remove the new line.

> +    uint32_t pending;
> +    uint32_t pin;
> +
> +    pending =3D s->high_ip & s->high_ie;
> +    pending |=3D s->low_ip & s->low_ie;
> +    pending |=3D s->rise_ip & s->rise_ie;
> +    pending |=3D s->fall_ip & s->fall_ie;
> +
> +    for (int i =3D 0; i < SIFIVE_GPIO_PINS; i++) {
> +        pin =3D 1 << i;
> +        qemu_set_irq(s->irq[i], (pending & pin) !=3D 0);
> +        trace_sifive_gpio_update_output_irq(i, (pending & pin) !=3D 0);
> +    }
> +}
> +
> +static void update_state(SIFIVEGPIOState *s)
> +{
> +    size_t i;
> +    bool prev_ival, in, in_mask, port, out_xor, pull, output_en, input_e=
n,
> +        rise_ip, fall_ip, low_ip, high_ip, oval, actual_value, ival;
> +
> +    for (i =3D 0; i < SIFIVE_GPIO_PINS; i++) {
> +
> +        prev_ival =3D extract32(s->value, i, 1);
> +        in        =3D extract32(s->in, i, 1);
> +        in_mask   =3D extract32(s->in_mask, i, 1);
> +        port      =3D extract32(s->port, i, 1);
> +        out_xor   =3D extract32(s->out_xor, i, 1);
> +        pull      =3D extract32(s->pue, i, 1);
> +        output_en =3D extract32(s->output_en, i, 1);
> +        input_en  =3D extract32(s->input_en, i, 1);
> +        rise_ip   =3D extract32(s->rise_ip, i, 1);
> +        fall_ip   =3D extract32(s->fall_ip, i, 1);
> +        low_ip    =3D extract32(s->low_ip, i, 1);
> +        high_ip   =3D extract32(s->high_ip, i, 1);
> +
> +        /* Output value (IOF not supported) */
> +        oval =3D output_en && (port ^ out_xor);
> +
> +        /* Pin both driven externally and internally */
> +        if (output_en && in_mask) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "GPIO pin %zu short circuited=
\n", i);
> +        }
> +
> +        if (in_mask) {
> +            /* The pin is driven by external device */
> +            actual_value =3D in;
> +        } else if (output_en) {
> +            /* The pin is driven by internal circuit */
> +            actual_value =3D oval;
> +        } else {
> +            /* Floating? Apply pull-up resistor */
> +            actual_value =3D pull;
> +        }
> +
> +        qemu_set_irq(s->output[i], actual_value);
> +
> +        /* Input value */
> +        ival =3D input_en && actual_value;
> +
> +        /* Interrupts */
> +        high_ip =3D high_ip || ival;
> +        s->high_ip =3D deposit32(s->high_ip, i, 1, high_ip);
> +
> +        low_ip =3D low_ip || !ival;
> +        s->low_ip =3D deposit32(s->low_ip,  i, 1, low_ip);
> +
> +        rise_ip =3D rise_ip || (ival && !prev_ival);
> +        s->rise_ip =3D deposit32(s->rise_ip, i, 1, rise_ip);
> +
> +        fall_ip =3D fall_ip || (!ival && prev_ival);
> +        s->fall_ip =3D deposit32(s->fall_ip, i, 1, fall_ip);
> +
> +        /* Update value */
> +        s->value =3D deposit32(s->value, i, 1, ival);
> +    }
> +    update_output_irq(s);
> +}
> +
> +static uint64_t sifive_gpio_read(void *opaque, hwaddr offset, unsigned i=
nt size)
> +{
> +    SIFIVEGPIOState *s =3D SIFIVE_GPIO(opaque);
> +    uint64_t r =3D 0;
> +
> +    switch (offset) {
> +    case SIFIVE_GPIO_REG_VALUE:
> +        r =3D s->value;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_INPUT_EN:
> +        r =3D s->input_en;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_OUTPUT_EN:
> +        r =3D s->output_en;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_PORT:
> +        r =3D s->port;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_PUE:
> +        r =3D s->pue;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_DS:
> +        r =3D s->ds;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_RISE_IE:
> +        r =3D s->rise_ie;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_RISE_IP:
> +        r =3D s->rise_ip;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_FALL_IE:
> +        r =3D s->fall_ie;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_FALL_IP:
> +        r =3D s->fall_ip;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_HIGH_IE:
> +        r =3D s->high_ie;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_HIGH_IP:
> +        r =3D s->high_ip;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_LOW_IE:
> +        r =3D s->low_ie;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_LOW_IP:
> +        r =3D s->low_ip;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_IOF_EN:
> +        r =3D s->iof_en;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_IOF_SEL:
> +        r =3D s->iof_sel;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_OUT_XOR:
> +        r =3D s->out_xor;
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "%s: bad read offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, offset);
> +    }
> +
> +    trace_sifive_gpio_read(offset, r);
> +
> +    return r;
> +}
> +
> +static void sifive_gpio_write(void *opaque, hwaddr offset,
> +                       uint64_t value, unsigned int size)
> +{
> +    SIFIVEGPIOState *s =3D SIFIVE_GPIO(opaque);
> +
> +    trace_sifive_gpio_write(offset, value);
> +
> +    switch (offset) {
> +

No newline here as well

> +    case SIFIVE_GPIO_REG_INPUT_EN:
> +        s->input_en =3D value;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_OUTPUT_EN:
> +        s->output_en =3D value;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_PORT:
> +        s->port =3D value;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_PUE:
> +        s->pue =3D value;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_DS:
> +        s->ds =3D value;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_RISE_IE:
> +        s->rise_ie =3D value;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_RISE_IP:
> +         /* Write 1 to clear */
> +        s->rise_ip &=3D ~value;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_FALL_IE:
> +        s->fall_ie =3D value;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_FALL_IP:
> +         /* Write 1 to clear */
> +        s->fall_ip &=3D ~value;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_HIGH_IE:
> +        s->high_ie =3D value;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_HIGH_IP:
> +         /* Write 1 to clear */
> +        s->high_ip &=3D ~value;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_LOW_IE:
> +        s->low_ie =3D value;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_LOW_IP:
> +         /* Write 1 to clear */
> +        s->low_ip &=3D ~value;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_IOF_EN:
> +        s->iof_en =3D value;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_IOF_SEL:
> +        s->iof_sel =3D value;
> +        break;
> +
> +    case SIFIVE_GPIO_REG_OUT_XOR:
> +        s->out_xor =3D value;
> +        break;

You don't have to hand write these all out most other devices use
arrays to simplfy this. There is also the register API, which is
pretty cool (hw/intc/xlnx-zynqmp-ipi.c).

Now that you have already done it this is fine.

> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: bad write offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, offset);
> +    }
> +
> +    update_state(s);
> +}
> +
> +static const MemoryRegionOps gpio_ops =3D {
> +    .read =3D  sifive_gpio_read,
> +    .write =3D sifive_gpio_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .impl.min_access_size =3D 4,
> +    .impl.max_access_size =3D 4,
> +};
> +
> +static void sifive_gpio_set(void *opaque, int line, int value)
> +{
> +    SIFIVEGPIOState *s =3D SIFIVE_GPIO(opaque);
> +
> +    trace_sifive_gpio_set(line, value);
> +
> +    assert(line >=3D 0 && line < SIFIVE_GPIO_PINS);

g_assert() instead of assert()

> +
> +    s->in_mask =3D deposit32(s->in_mask, line, 1, value >=3D 0);
> +    if (value >=3D 0) {
> +        s->in =3D deposit32(s->in, line, 1, value !=3D 0);
> +    }
> +
> +    update_state(s);
> +}
> +
> +static void sifive_gpio_reset(DeviceState *dev)
> +{
> +    SIFIVEGPIOState *s =3D SIFIVE_GPIO(dev);
> +
> +    s->value =3D 0;
> +    s->input_en =3D 0;
> +    s->output_en =3D 0;
> +    s->port =3D 0;
> +    s->pue =3D 0;
> +    s->ds =3D 0;
> +    s->rise_ie =3D 0;
> +    s->rise_ip =3D 0;
> +    s->fall_ie =3D 0;
> +    s->fall_ip =3D 0;
> +    s->high_ie =3D 0;
> +    s->high_ip =3D 0;
> +    s->low_ie =3D 0;
> +    s->low_ip =3D 0;
> +    s->iof_en =3D 0;
> +    s->iof_sel =3D 0;
> +    s->out_xor =3D 0;
> +    s->in =3D 0;
> +    s->in_mask =3D 0;

Maybe a memset is better here?

> +
> +}
> +
> +static const VMStateDescription vmstate_sifive_gpio =3D {
> +    .name =3D TYPE_SIFIVE_GPIO,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(value,     SIFIVEGPIOState),
> +        VMSTATE_UINT32(input_en,  SIFIVEGPIOState),
> +        VMSTATE_UINT32(output_en, SIFIVEGPIOState),
> +        VMSTATE_UINT32(port,      SIFIVEGPIOState),
> +        VMSTATE_UINT32(pue,       SIFIVEGPIOState),
> +        VMSTATE_UINT32(rise_ie,   SIFIVEGPIOState),
> +        VMSTATE_UINT32(rise_ip,   SIFIVEGPIOState),
> +        VMSTATE_UINT32(fall_ie,   SIFIVEGPIOState),
> +        VMSTATE_UINT32(fall_ip,   SIFIVEGPIOState),
> +        VMSTATE_UINT32(high_ie,   SIFIVEGPIOState),
> +        VMSTATE_UINT32(high_ip,   SIFIVEGPIOState),
> +        VMSTATE_UINT32(low_ie,    SIFIVEGPIOState),
> +        VMSTATE_UINT32(low_ip,    SIFIVEGPIOState),
> +        VMSTATE_UINT32(iof_en,    SIFIVEGPIOState),
> +        VMSTATE_UINT32(iof_sel,   SIFIVEGPIOState),
> +        VMSTATE_UINT32(out_xor,   SIFIVEGPIOState),
> +        VMSTATE_UINT32(in, SIFIVEGPIOState),
> +        VMSTATE_UINT32(in_mask, SIFIVEGPIOState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void sifive_gpio_init(Object *obj)
> +{
> +    SIFIVEGPIOState *s =3D SIFIVE_GPIO(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &gpio_ops, s,
> +            TYPE_SIFIVE_GPIO, SIFIVE_GPIO_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +
> +

Remove new line.

> +    for (int i =3D 0; i < SIFIVE_GPIO_PINS; i++) {
> +        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
> +    }
> +
> +    qdev_init_gpio_in(DEVICE(s), sifive_gpio_set, SIFIVE_GPIO_PINS);
> +    qdev_init_gpio_out(DEVICE(s), s->output, SIFIVE_GPIO_PINS);
> +}
> +
> +static void sifive_gpio_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->vmsd =3D &vmstate_sifive_gpio;
> +    dc->reset =3D sifive_gpio_reset;
> +    dc->desc =3D "sifive GPIO";
> +}
> +
> +static const TypeInfo sifive_gpio_info =3D {
> +    .name =3D TYPE_SIFIVE_GPIO,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(SIFIVEGPIOState),
> +    .instance_init =3D sifive_gpio_init,
> +    .class_init =3D sifive_gpio_class_init
> +};
> +
> +static void sifive_gpio_register_types(void)
> +{
> +    type_register_static(&sifive_gpio_info);
> +}
> +
> +type_init(sifive_gpio_register_types)
> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
> new file mode 100644
> index 0000000000..6d59233e23
> --- /dev/null
> +++ b/hw/riscv/trace-events
> @@ -0,0 +1,7 @@
> +# See docs/devel/tracing.txt for syntax documentation.
> +
> +# hw/gpio/sifive_gpio.c
> +sifive_gpio_read(uint64_t offset, uint64_t r) "offset 0x%" PRIx64 " valu=
e 0x%" PRIx64
> +sifive_gpio_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 "=
 value 0x%" PRIx64
> +sifive_gpio_set(int64_t line, int64_t value) "line %" PRIi64 " value %" =
PRIi64
> +sifive_gpio_update_output_irq(int64_t line, int64_t value) "line %" PRIi=
64 " value %" PRIi64
> diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
> index 7b6d8aed96..6852bc36c6 100644
> --- a/include/hw/riscv/sifive_e.h
> +++ b/include/hw/riscv/sifive_e.h
> @@ -19,6 +19,8 @@
>  #ifndef HW_SIFIVE_E_H
>  #define HW_SIFIVE_E_H
>
> +#include "hw/riscv/sifive_gpio.h"
> +
>  #define TYPE_RISCV_E_SOC "riscv.sifive.e.soc"
>  #define RISCV_E_SOC(obj) \
>      OBJECT_CHECK(SiFiveESoCState, (obj), TYPE_RISCV_E_SOC)
> @@ -30,6 +32,7 @@ typedef struct SiFiveESoCState {
>      /*< public >*/
>      RISCVHartArrayState cpus;
>      DeviceState *plic;
> +    SIFIVEGPIOState gpio;
>  } SiFiveESoCState;
>
>  typedef struct SiFiveEState {
> @@ -63,8 +66,9 @@ enum {
>  };
>
>  enum {
> -    SIFIVE_E_UART0_IRQ =3D 3,
> -    SIFIVE_E_UART1_IRQ =3D 4
> +    SIFIVE_E_UART0_IRQ  =3D 3,

Why is this line changing?

Besides the few comments it looks good to me.

Alistair

> +    SIFIVE_E_UART1_IRQ  =3D 4,
> +    SIFIVE_E_GPIO0_IRQ0 =3D 8
>  };
>
>  #define SIFIVE_E_PLIC_HART_CONFIG "M"
> diff --git a/include/hw/riscv/sifive_gpio.h b/include/hw/riscv/sifive_gpi=
o.h
> new file mode 100644
> index 0000000000..fce03d6c41
> --- /dev/null
> +++ b/include/hw/riscv/sifive_gpio.h
> @@ -0,0 +1,72 @@
> +/*
> + * sifive System-on-Chip general purpose input/output register definitio=
n
> + *
> + * Copyright 2019 AdaCore
> + *
> + * Base on nrf51_gpio.c:
> + *
> + * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +#ifndef SIFIVE_GPIO_H
> +#define SIFIVE_GPIO_H
> +
> +#include "hw/sysbus.h"
> +#define TYPE_SIFIVE_GPIO "sifive_soc.gpio"
> +#define SIFIVE_GPIO(obj) OBJECT_CHECK(SIFIVEGPIOState, (obj), TYPE_SIFIV=
E_GPIO)
> +
> +#define SIFIVE_GPIO_PINS 32
> +
> +#define SIFIVE_GPIO_SIZE 0x100
> +
> +#define SIFIVE_GPIO_REG_VALUE      0x000
> +#define SIFIVE_GPIO_REG_INPUT_EN   0x004
> +#define SIFIVE_GPIO_REG_OUTPUT_EN  0x008
> +#define SIFIVE_GPIO_REG_PORT       0x00C
> +#define SIFIVE_GPIO_REG_PUE        0x010
> +#define SIFIVE_GPIO_REG_DS         0x014
> +#define SIFIVE_GPIO_REG_RISE_IE    0x018
> +#define SIFIVE_GPIO_REG_RISE_IP    0x01C
> +#define SIFIVE_GPIO_REG_FALL_IE    0x020
> +#define SIFIVE_GPIO_REG_FALL_IP    0x024
> +#define SIFIVE_GPIO_REG_HIGH_IE    0x028
> +#define SIFIVE_GPIO_REG_HIGH_IP    0x02C
> +#define SIFIVE_GPIO_REG_LOW_IE     0x030
> +#define SIFIVE_GPIO_REG_LOW_IP     0x034
> +#define SIFIVE_GPIO_REG_IOF_EN     0x038
> +#define SIFIVE_GPIO_REG_IOF_SEL    0x03C
> +#define SIFIVE_GPIO_REG_OUT_XOR    0x040
> +
> +typedef struct SIFIVEGPIOState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +
> +    qemu_irq irq[SIFIVE_GPIO_PINS];
> +    qemu_irq output[SIFIVE_GPIO_PINS];
> +
> +    uint32_t value;             /* Actual value of the pin */
> +    uint32_t input_en;
> +    uint32_t output_en;
> +    uint32_t port;              /* Pin value requested by the user */
> +    uint32_t pue;
> +    uint32_t ds;
> +    uint32_t rise_ie;
> +    uint32_t rise_ip;
> +    uint32_t fall_ie;
> +    uint32_t fall_ip;
> +    uint32_t high_ie;
> +    uint32_t high_ip;
> +    uint32_t low_ie;
> +    uint32_t low_ip;
> +    uint32_t iof_en;
> +    uint32_t iof_sel;
> +    uint32_t out_xor;
> +    uint32_t in;
> +    uint32_t in_mask;
> +
> +} SIFIVEGPIOState;
> +
> +#endif
> --
> 2.17.1
>
>
