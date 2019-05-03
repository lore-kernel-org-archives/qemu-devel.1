Received: from eggs.gnu.org ([209.51.188.92]:34261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMaGq-0004ae-NQ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMaGo-00007V-G9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:38:44 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMaGo-000066-6S
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:38:42 -0400
Received: by mail-wr1-x444.google.com with SMTP id s15so8387689wra.12
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:38:41 -0700 (PDT)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-10-ysato@users.sourceforge.jp>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190502143409.59600-10-ysato@users.sourceforge.jp>
Date: Fri, 03 May 2019 16:38:38 +0100
Message-ID: <87lfzn4kg1.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v8 09/12] hw/rx: RX Target hardware
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>


Yoshinori Sato <ysato@users.sourceforge.jp> writes:

> rx62n - RX62N cpu.
> rxqemu - QEMU virtual target.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/rx/rx.h    |   7 ++
>  include/hw/rx/rx62n.h |  54 ++++++++++++
>  hw/rx/rx62n.c         | 226 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/rx/rxqemu.c        | 100 ++++++++++++++++++++++
>  hw/rx/Kconfig         |   2 +
>  hw/rx/Makefile.objs   |   1 +
>  6 files changed, 390 insertions(+)
>  create mode 100644 include/hw/rx/rx.h
>  create mode 100644 include/hw/rx/rx62n.h
>  create mode 100644 hw/rx/rx62n.c
>  create mode 100644 hw/rx/rxqemu.c
>  create mode 100644 hw/rx/Kconfig
>  create mode 100644 hw/rx/Makefile.objs
>
> diff --git a/include/hw/rx/rx.h b/include/hw/rx/rx.h
> new file mode 100644
> index 0000000000..ff5924b81f
> --- /dev/null
> +++ b/include/hw/rx/rx.h
> @@ -0,0 +1,7 @@
> +#ifndef QEMU_RX_H
> +#define QEMU_RX_H
> +/* Definitions for RX board emulation.  */
> +
> +#include "target/rx/cpu-qom.h"
> +
> +#endif
> diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
> new file mode 100644
> index 0000000000..8c15399ce0
> --- /dev/null
> +++ b/include/hw/rx/rx62n.h
> @@ -0,0 +1,54 @@
> +/*
> + * RX62N Object
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_RX_RX62N_H
> +#define HW_RX_RX62N_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/rx/rx.h"
> +#include "hw/intc/rx_icu.h"
> +#include "hw/timer/renesas_tmr.h"
> +#include "hw/timer/renesas_cmt.h"
> +#include "hw/char/renesas_sci.h"
> +
> +#define TYPE_RX62N "rx62n"
> +#define TYPE_RX62N_CPU RX_CPU_TYPE_NAME(TYPE_RX62N)
> +#define RX62N(obj) OBJECT_CHECK(RX62NState, (obj), TYPE_RX62N)
> +
> +typedef struct RX62NState {
> +    SysBusDevice parent_obj;
> +
> +    RXCPU *cpu;
> +    RXICUState *icu;
> +    RTMRState *tmr[2];
> +    RCMTState *cmt[2];
> +    RSCIState *sci[6];
> +
> +    MemoryRegion *sysmem;
> +    bool kernel;
> +
> +    MemoryRegion iram;
> +    MemoryRegion iomem1;
> +    MemoryRegion d_flash;
> +    MemoryRegion iomem2;
> +    MemoryRegion iomem3;
> +    MemoryRegion c_flash;
> +    qemu_irq irq[256];
> +} RX62NState;
> +
> +#endif
> diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
> new file mode 100644
> index 0000000000..b303aefe8c
> --- /dev/null
> +++ b/hw/rx/rx62n.c
> @@ -0,0 +1,226 @@
> +/*
> + * RX62N device
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/hw.h"
> +#include "hw/rx/rx62n.h"
> +#include "hw/loader.h"
> +#include "hw/sysbus.h"
> +#include "sysemu/sysemu.h"
> +#include "cpu.h"
> +#include "exec/exec-all.h"
> +#include "exec/address-spaces.h"
> +
> +static const int ipr_table[] =3D {

This could probably do with a little comment above explaining what the
magic table is and where the data in it is referenced.

Is there any particular reason this is exposed as a property? That could
be explained as well.

> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 15 */
> +    0x00, 0xff, 0xff, 0xff, 0xff, 0x01, 0xff, 0x02,
> +    0xff, 0xff, 0xff, 0x03, 0x04, 0x05, 0x06, 0x07, /* 31 */
> +    0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> +    0x10, 0x11, 0x12, 0x13, 0x14, 0x14, 0x14, 0x14, /* 47 */
> +    0x15, 0x15, 0x15, 0x15, 0xff, 0xff, 0xff, 0xff,
> +    0x18, 0x18, 0x18, 0x18, 0x18, 0x1d, 0x1e, 0x1f, /* 63 */
> +    0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
> +    0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, /* 79 */
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0x3a, 0x3b, 0x3c, 0xff, 0xff, 0xff, /* 95 */
> +    0x40, 0xff, 0x44, 0x45, 0xff, 0xff, 0x48, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 111 */
> +    0xff, 0xff, 0x51, 0x51, 0x51, 0x51, 0x52, 0x52,
> +    0x52, 0x53, 0x53, 0x54, 0x54, 0x55, 0x55, 0x56, /* 127 */
> +    0x56, 0x57, 0x57, 0x57, 0x57, 0x58, 0x59, 0x59,
> +    0x59, 0x59, 0x5a, 0x5b, 0x5b, 0x5b, 0x5c, 0x5c, /* 143 */
> +    0x5c, 0x5c, 0x5d, 0x5d, 0x5d, 0x5e, 0x5e, 0x5f,
> +    0x5f, 0x60, 0x60, 0x61, 0x61, 0x62, 0x62, 0x62, /* 159 */
> +    0x62, 0x63, 0x64, 0x64, 0x64, 0x64, 0x65, 0x66,
> +    0x66, 0x66, 0x67, 0x67, 0x67, 0x67, 0x68, 0x68, /* 175 */
> +    0x68, 0x69, 0x69, 0x69, 0x6a, 0x6a, 0x6a, 0x6b,
> +    0x6b, 0x6b, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 191 */
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x70, 0x71,
> +    0x72, 0x73, 0x74, 0x75, 0xff, 0xff, 0xff, 0xff, /* 207 */
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x80, 0x80,
> +    0x80, 0x80, 0x81, 0x81, 0x81, 0x81, 0x82, 0x82, /* 223 */
> +    0x82, 0x82, 0x83, 0x83, 0x83, 0x83, 0xff, 0xff,
> +    0xff, 0xff, 0x85, 0x85, 0x85, 0x85, 0x86, 0x86, /* 239 */
> +    0x86, 0x86, 0xff, 0xff, 0xff, 0xff, 0x88, 0x89,
> +    0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, 0x90, 0x91, /* 255 */
> +};
> +
> +static const uint32_t levelirq[] =3D {
> +     16,  21,  32,  44,  47,  48,  51,  64,  65,  66,
> +     67,  68,  69,  70,  71,  72,  73,  74,  75,  76,
> +     77,  78,  79,  90,  91, 170, 171, 172, 173, 214,
> +    217, 218, 221, 222, 225, 226, 229, 234, 237, 238,
> +    241, 246, 249, 250, 253,
> +};
> +
> +static RXICUState *register_icu(RX62NState *s)
> +{
> +    SysBusDevice *icu;
> +    int i;
> +
> +    icu =3D SYS_BUS_DEVICE(qdev_create(NULL, TYPE_RXICU));
> +    sysbus_mmio_map(icu, 0, 0x00087000);
> +    qdev_prop_set_uint32(DEVICE(icu), "len-ipr-map", 256);
> +    for (i =3D 0; i < 256; i++) {
> +        char propname[32];
> +        snprintf(propname, sizeof(propname), "ipr-map[%d]", i);
> +        qdev_prop_set_uint32(DEVICE(icu), propname, ipr_table[i]);
> +    }
> +    qdev_prop_set_uint32(DEVICE(icu), "len-trigger-level", 256);
> +    for (i =3D 0; i < ARRAY_SIZE(levelirq); i++) {
> +        char propname[32];
> +        snprintf(propname, sizeof(propname), "trigger-level[%d]", i);
> +        qdev_prop_set_uint32(DEVICE(icu), propname, levelirq[i]);
> +    }
> +    for (i =3D 0; i < 256; i++) {
> +        s->irq[i] =3D qdev_get_gpio_in(DEVICE(icu), i);
> +    }
> +
> +    qdev_init_nofail(DEVICE(icu));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(icu), 0,
> +                       qdev_get_gpio_in(DEVICE(s->cpu), RX_CPU_IRQ));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(icu), 1,
> +                       qdev_get_gpio_in(DEVICE(s->cpu), RX_CPU_FIR));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(icu), 2, s->irq[SWI]);
> +
> +    return RXICU(icu);
> +}
> +
> +static RTMRState *register_tmr(RX62NState *s, int unit)
> +{
> +    SysBusDevice *tmr;
> +    int i, irqbase;
> +
> +    tmr =3D SYS_BUS_DEVICE(qdev_create(NULL, TYPE_RENESAS_TMR));
> +    sysbus_mmio_map(tmr, 0, 0x00088200 + unit * 0x10);
> +    qdev_prop_set_uint64(DEVICE(tmr), "input-freq", 48000000);
> +
> +    qdev_init_nofail(DEVICE(tmr));
> +    irqbase =3D 174 + 6 * unit;
> +    for (i =3D 0; i < 6; i++) {
> +        sysbus_connect_irq(tmr, i, s->irq[irqbase + i]);
> +    }
> +
> +    return RTMR(tmr);
> +}
> +
> +static RCMTState *register_cmt(RX62NState *s, int unit)
> +{
> +    SysBusDevice *cmt;
> +    int i, irqbase;
> +
> +    cmt =3D SYS_BUS_DEVICE(qdev_create(NULL, TYPE_RENESAS_CMT));
> +    sysbus_mmio_map(cmt, 0, 0x00088000 + unit * 0x10);
> +    qdev_prop_set_uint64(DEVICE(cmt), "input-freq", 48000000);
> +
> +    qdev_init_nofail(DEVICE(cmt));
> +    irqbase =3D 28 + 2 * unit;
> +    for (i =3D 0; i < 1; i++) {
> +        sysbus_connect_irq(cmt, i, s->irq[irqbase + i]);
> +    }
> +
> +    return RCMT(cmt);
> +}
> +
> +static RSCIState *register_sci(RX62NState *s, int unit)
> +{
> +    SysBusDevice *sci;
> +    int i, irqbase;
> +
> +    sci =3D SYS_BUS_DEVICE(qdev_create(NULL, TYPE_RENESAS_SCI));
> +    qdev_prop_set_chr(DEVICE(sci), "chardev", serial_hd(unit));
> +    qdev_prop_set_uint64(DEVICE(sci), "input-freq", 48000000);
> +    qdev_init_nofail(DEVICE(sci));
> +    sysbus_mmio_map(sci, 0, 0x00088240 + unit * 0x08);
> +    irqbase =3D 214 + 4 * unit;
> +    for (i =3D 0; i < 4; i++) {
> +        sysbus_connect_irq(sci, i, s->irq[irqbase + i]);
> +    }
> +
> +    object_property_set_bool(OBJECT(sci), true, "realized", NULL);
> +    return RSCI(sci);
> +}
> +
> +static void rx62n_realize(DeviceState *dev, Error **errp)
> +{
> +    RX62NState *s =3D RX62N(dev);
> +    Error *err =3D NULL;
> +
> +    memory_region_init_ram(&s->iram, NULL, "iram", 0x18000, NULL);
> +    memory_region_add_subregion(s->sysmem, 0x00000000, &s->iram);
> +    memory_region_init_rom(&s->d_flash, NULL, "dataflash", 0x8000, NULL);
> +    memory_region_add_subregion(s->sysmem, 0x00100000, &s->d_flash);
> +    memory_region_init_rom(&s->c_flash, NULL, "codeflash", 0x80000, NULL=
);
> +    memory_region_add_subregion(s->sysmem, 0xfff80000, &s->c_flash);
> +
> +    s->cpu =3D RXCPU(object_new(TYPE_RXCPU));
> +
> +    if (!s->kernel) {
> +        rom_add_file_fixed(bios_name, 0xfff80000, 0);
> +    }
> +
> +    object_property_set_bool(OBJECT(s->cpu), true, "realized", &err);
> +    if (err !=3D NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    s->icu =3D register_icu(s);
> +    s->cpu->env.ack =3D qdev_get_gpio_in_named(DEVICE(s->icu), "ack", 0);
> +    s->tmr[0] =3D register_tmr(s, 0);
> +    s->tmr[1] =3D register_tmr(s, 1);
> +    s->cmt[0] =3D register_cmt(s, 0);
> +    s->cmt[1] =3D register_cmt(s, 1);
> +    s->sci[0] =3D register_sci(s, 0);
> +}
> +
> +static void rx62n_init(Object *obj)
> +{
> +}
> +
> +static Property rx62n_properties[] =3D {
> +    DEFINE_PROP_LINK("memory", RX62NState, sysmem, TYPE_MEMORY_REGION,
> +                     MemoryRegion *),
> +    DEFINE_PROP_BOOL("load-kernel", RX62NState, kernel, false),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void rx62n_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D rx62n_realize;
> +    dc->props =3D rx62n_properties;
> +}
> +
> +static const TypeInfo rx62n_info =3D {
> +    .name =3D TYPE_RX62N,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(RX62NState),
> +    .instance_init =3D rx62n_init,
> +    .class_init =3D rx62n_class_init,
> +};
> +
> +static void rx62n_register_types(void)
> +{
> +    type_register_static(&rx62n_info);
> +}
> +
> +type_init(rx62n_register_types)
> diff --git a/hw/rx/rxqemu.c b/hw/rx/rxqemu.c
> new file mode 100644
> index 0000000000..87cd30b2f1
> --- /dev/null
> +++ b/hw/rx/rxqemu.c
> @@ -0,0 +1,100 @@
> +/*
> + * RX QEMU virtual target
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "hw/sysbus.h"
> +#include "hw/loader.h"
> +#include "hw/rx/rx62n.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/qtest.h"
> +#include "sysemu/device_tree.h"
> +#include "hw/boards.h"
> +#include "exec/address-spaces.h"
> +#include "exec/cpu-all.h"
> +
> +static void rxqemu_init(MachineState *machine)
> +{
> +    DeviceState *cpu;
> +    MemoryRegion *sysmem =3D get_system_memory();
> +    MemoryRegion *sdram =3D g_new(MemoryRegion, 1);
> +    const char *kernel_filename =3D machine->kernel_filename;
> +    const char *dtb_filename =3D machine->dtb;
> +    void *dtb =3D NULL;
> +    int dtb_size;
> +
> +    /* Allocate memory space */
> +    memory_region_init_ram(sdram, NULL, "rxqemu.sdram", 0x01000000,
> +                           &error_fatal);
> +    memory_region_add_subregion(sysmem, 0x01000000, sdram);
> +
> +    cpu =3D qdev_create(NULL, TYPE_RX62N);
> +    object_property_set_link(OBJECT(cpu), OBJECT(get_system_memory()),
> +                             "memory", &error_abort);
> +    object_property_set_bool(OBJECT(cpu), kernel_filename !=3D NULL,
> +                             "load-kernel", &error_abort);
> +    /* This will exit with an error if the user passed us a bad cpu_type=
 */
> +    qdev_init_nofail(cpu);
> +
> +    if (kernel_filename) {
> +        rx_load_image(RXCPU(first_cpu), kernel_filename,
> +                      0x01800000, 0x00800000);
> +    }
> +    if (dtb_filename) {
> +        dtb =3D load_device_tree(dtb_filename, &dtb_size);
> +        if (dtb =3D=3D NULL) {
> +            fprintf(stderr, "Couldn't open dtb file %s\n", dtb_filename);
> +            exit(1);
> +        }
> +        if (machine->kernel_cmdline &&
> +            qemu_fdt_setprop_string(dtb, "/chosen", "bootargs",
> +                                    machine->kernel_cmdline) < 0) {
> +            fprintf(stderr, "couldn't set /chosen/bootargs\n");
> +            exit(1);
> +        }
> +        rom_add_blob_fixed("dtb", dtb, dtb_size, 0x02000000 - dtb_size);
> +        /* Set dtb address to R1 */
> +        RXCPU(first_cpu)->env.regs[1] =3D 0x02000000 - dtb_size;
> +    }
> +}
> +
> +static void rxqemu_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->desc =3D "RX QEMU Virtual Target";
> +    mc->init =3D rxqemu_init;
> +    mc->is_default =3D 1;
> +    mc->default_cpu_type =3D TYPE_RXCPU;
> +}
> +
> +static const TypeInfo rxqemu_type =3D {
> +    .name =3D MACHINE_TYPE_NAME("rx-qemu"),
> +    .parent =3D TYPE_MACHINE,
> +    .class_init =3D rxqemu_class_init,
> +};
> +
> +static void rxqemu_machine_init(void)
> +{
> +    type_register_static(&rxqemu_type);
> +}
> +
> +type_init(rxqemu_machine_init)
> diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
> new file mode 100644
> index 0000000000..4e39638cb5
> --- /dev/null
> +++ b/hw/rx/Kconfig
> @@ -0,0 +1,2 @@
> +config RX
> +       bool
> diff --git a/hw/rx/Makefile.objs b/hw/rx/Makefile.objs
> new file mode 100644
> index 0000000000..e2edbb527e
> --- /dev/null
> +++ b/hw/rx/Makefile.objs
> @@ -0,0 +1 @@
> +obj-y +=3D rx62n.o rxqemu.o


--
Alex Benn=C3=A9e
