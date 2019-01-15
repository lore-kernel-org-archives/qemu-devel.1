Received: from eggs.gnu.org ([209.51.188.92]:47756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gjWiJ-0006jQ-C6
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:57:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gjWiE-0001Iv-AK
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:57:36 -0500
MIME-Version: 1.0
References: <20181226190702.403-1-plaes@plaes.org>
	<CAKmqyKMBwBjV-8b=kNjqqWkG08a-dnLPLUxwCNw73q7TpOjEgA@mail.gmail.com>
	<20190106210327.rbuob5kz2ezxxi7q@plaes.org>
In-Reply-To: <20190106210327.rbuob5kz2ezxxi7q@plaes.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 15 Jan 2019 13:56:51 -0800
Message-ID: <CAKmqyKMDqqBVx58zLE09SPOWFLtBB_bOfBkCvUUQxRxZ4OzRdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH] stm32f103: Add initial skeleton of
 STM32 F103 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Priit Laes <plaes@plaes.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Sun, Jan 6, 2019 at 1:03 PM Priit Laes <plaes@plaes.org> wrote:
>
> On Thu, Jan 03, 2019 at 01:33:08PM -0800, Alistair Francis wrote:
> > On Wed, Dec 26, 2018 at 11:08 AM Priit Laes <plaes@plaes.org> wrote:
> > >
> > > Initial barebone SoC implementation for STM32F103
> > > with "Blue Pill" board source for testing.
> > >
> > > Code is based on both nrf51/microbit and stm32f205.
> > >
> > > Although code loads and seems to be at the right
> > > addresses it does not yet run:
> > >
> > > ./arm-softmmu/qemu-system-arm -nographic \
> > >         -machine stm32bluepill \
> > >         -kernel \
> > >         libopencm3-miniblink/bin/stm32/bluepill.bin
> > > QEMU 3.1.50 monitor - type 'help' for more information
> > > (qemu) QEMU 3.1.50 monitor - type 'help' for more information
> > > (qemu) gdbserver
> > > Waiting for gdb connection on device 'tcp::1234'
> > >
> > > $ arm-none-eabi-gdb \
> > >         libopencm3-miniblink/bin/stm32/bluepill.elf
> > > (gdb) target remote tcp::1234
> > > Remote debugging using tcp::1234
> > > blocking_handler () at ../../cm3/vector.c:103
> > > 103     {
> > > (gdb) bt
> > > Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> > > (gdb) info line
> > > Line 103 of "../../cm3/vector.c" starts at address 0x8000380 \
> > >         <blocking_handler> and ends at 0x8000382 <null_handler>.
> > >
> > > Any ideas?
> >
> > Have you tried running QEMU with the -d option (-d in_asm is a good
> > place to start)? Does that shed any light on what is happening?
>
> Thanks for the tips, it actually was working, but just went into
> infinite loop (which is probably caused by unimplemented peripheral
> register access, or something else).
>
> Also, what helped in addition to (-d in_asm):
> -S freezes CPU at startup (so one can singlestep with gdb)
> -s starts gdbserver on tcp::1234

Great! I'm glad it's working.

Make sure you send a patch once you have it working and it can be
merged into mainline QEMU. Looking at your code it looks like you are
on the right track :)

Alistair

>
> Thanks! :)
> >
> > Alistair
> >
> > >
> > > Signed-off-by: Priit Laes <plaes@plaes.org>
> > > ---
> > >  default-configs/arm-softmmu.mak |  1 +
> > >  hw/arm/Makefile.objs            |  1 +
> > >  hw/arm/stm32f103_blue_pill.c    | 78 ++++++++++++++++++++++++++++
> > >  hw/arm/stm32f103_soc.c          | 92 +++++++++++++++++++++++++++++++++
> > >  include/hw/arm/stm32f103_soc.h  | 54 +++++++++++++++++++
> > >  5 files changed, 226 insertions(+)
> > >  create mode 100644 hw/arm/stm32f103_blue_pill.c
> > >  create mode 100644 hw/arm/stm32f103_soc.c
> > >  create mode 100644 include/hw/arm/stm32f103_soc.h
> > >
> > > diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> > > index 2420491aac..7a55e523e1 100644
> > > --- a/default-configs/arm-softmmu.mak
> > > +++ b/default-configs/arm-softmmu.mak
> > > @@ -95,6 +95,7 @@ CONFIG_RASPI=y
> > >  CONFIG_REALVIEW=y
> > >  CONFIG_ZAURUS=y
> > >  CONFIG_ZYNQ=y
> > > +CONFIG_STM32F103_SOC=y
> > >  CONFIG_STM32F2XX_TIMER=y
> > >  CONFIG_STM32F2XX_USART=y
> > >  CONFIG_STM32F2XX_SYSCFG=y
> > > diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> > > index 50c7b4a927..7f59a9349d 100644
> > > --- a/hw/arm/Makefile.objs
> > > +++ b/hw/arm/Makefile.objs
> > > @@ -24,6 +24,7 @@ obj-$(CONFIG_OMAP) += omap1.o omap2.o
> > >  obj-$(CONFIG_STRONGARM) += strongarm.o
> > >  obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
> > >  obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
> > > +obj-$(CONFIG_STM32F103_SOC) += stm32f103_soc.o stm32f103_blue_pill.o
> > >  obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
> > >  obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
> > >  obj-$(CONFIG_XLNX_VERSAL) += xlnx-versal.o xlnx-versal-virt.o
> > > diff --git a/hw/arm/stm32f103_blue_pill.c b/hw/arm/stm32f103_blue_pill.c
> > > new file mode 100644
> > > index 0000000000..09dd69aa71
> > > --- /dev/null
> > > +++ b/hw/arm/stm32f103_blue_pill.c
> > > @@ -0,0 +1,78 @@
> > > +/*
> > > + * STM32F103C8 Blue Pill development board Machine Model
> > > + *
> > > + * Copyright (c) 2018 Priit Laes <plaes@plaes.org>
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > > + * of this software and associated documentation files (the "Software"), to deal
> > > + * in the Software without restriction, including without limitation the rights
> > > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > > + * copies of the Software, and to permit persons to whom the Software is
> > > + * furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice shall be included in
> > > + * all copies or substantial portions of the Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > > + * THE SOFTWARE.
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "qapi/error.h"
> > > +#include "hw/boards.h"
> > > +#include "hw/arm/arm.h"
> > > +#include "exec/address-spaces.h"
> > > +
> > > +#include "hw/arm/stm32f103_soc.h"
> > > +
> > > +typedef struct {
> > > +    MachineState parent;
> > > +
> > > +    STM32F103State stm32f103;
> > > +} STM32BluePillMachineState;
> > > +
> > > +#define TYPE_STM32BLUEPILL_MACHINE MACHINE_TYPE_NAME("stm32bluepill")
> > > +
> > > +#define STM32BLUEPILL_MACHINE(obj) \
> > > +    OBJECT_CHECK(STM32BluePillMachineState, obj, TYPE_STM32BLUEPILL_MACHINE)
> > > +
> > > +static void stm32bluepill_init(MachineState *machine)
> > > +{
> > > +    STM32BluePillMachineState *s = STM32BLUEPILL_MACHINE(machine);
> > > +    Object *soc = OBJECT(&s->stm32f103);
> > > +
> > > +    sysbus_init_child_obj(OBJECT(machine), "stm32f103-soc", soc,
> > > +                          sizeof(s->stm32f103), TYPE_STM32F103_SOC);
> > > +    object_property_set_bool(soc, true, "realized", &error_fatal);
> > > +
> > > +    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> > > +                       FLASH_SIZE);
> > > +}
> > > +
> > > +static void stm32bluepill_machine_class_init(ObjectClass *oc, void *data)
> > > +{
> > > +    MachineClass *mc = MACHINE_CLASS(oc);
> > > +
> > > +    mc->desc = "STM32F103 Blue Pill development board";
> > > +    mc->init = stm32bluepill_init;
> > > +    mc->max_cpus = 1;
> > > +}
> > > +
> > > +static const TypeInfo stm32bluepill_info = {
> > > +    .name = TYPE_STM32BLUEPILL_MACHINE,
> > > +    .parent = TYPE_MACHINE,
> > > +    .instance_size = sizeof(STM32BluePillMachineState),
> > > +    .class_init = stm32bluepill_machine_class_init,
> > > +};
> > > +
> > > +static void stm32bluepill_machine_init(void)
> > > +{
> > > +    type_register_static(&stm32bluepill_info);
> > > +}
> > > +
> > > +type_init(stm32bluepill_machine_init);
> > > diff --git a/hw/arm/stm32f103_soc.c b/hw/arm/stm32f103_soc.c
> > > new file mode 100644
> > > index 0000000000..3093bce4ea
> > > --- /dev/null
> > > +++ b/hw/arm/stm32f103_soc.c
> > > @@ -0,0 +1,92 @@
> > > +/*
> > > + * STM32 F103 SoC (or MCU)
> > > + *
> > > + * Copyright 2018 Priit Laes <plaes@plaes.org>
> > > + *
> > > + * This code is licensed under the GPL version 2 or later.  See
> > > + * the COPYING file in the top-level directory.
> > > + */
> > > +#include "qemu/osdep.h"
> > > +#include "qapi/error.h"
> > > +#include "hw/sysbus.h"
> > > +#include "exec/address-spaces.h"
> > > +
> > > +#include "hw/arm/stm32f103_soc.h"
> > > +
> > > +#define FLASH_BASE      0x08000000
> > > +#define SRAM_BASE       0x20000000
> > > +
> > > +static void stm32f103_soc_init(Object *obj)
> > > +{
> > > +    STM32F103State *s = STM32F103_SOC(obj);
> > > +
> > > +    sysbus_init_child_obj(obj, "armv7m", &s->cpu, sizeof(s->cpu),
> > > +                      TYPE_ARMV7M);
> > > +}
> > > +
> > > +static void stm32f103_soc_realize(DeviceState *dev_soc, Error **errp)
> > > +{
> > > +    STM32F103State *s = STM32F103_SOC(dev_soc);
> > > +    Error *err = NULL;
> > > +
> > > +    /*
> > > +     * XXX: Region 0x1FFF F000 - 0x1FFF F7FF is called "System Memory"
> > > +     * containing boot loader used to reprogram flash by using USART1.
> > > +     */
> > > +    MemoryRegion *system_memory = get_system_memory();
> > > +
> > > +    memory_region_init_rom(&s->flash, NULL, "stm32.flash", FLASH_SIZE,
> > > +                           &error_fatal);
> > > +    memory_region_add_subregion(system_memory, FLASH_BASE, &s->flash);
> > > +    /*
> > > +     * TODO: based on BOOT pin, 0x00000000 - 0x0007FFFF is aliased to
> > > +     * either Flash or system memory. We currently hardcode it to flash.
> > > +     */
> > > +    memory_region_init_alias(&s->flash_alias, NULL, "stm32.flash_alias",
> > > +                             &s->flash, 0, FLASH_SIZE);
> > > +    memory_region_add_subregion(system_memory, 0, &s->flash_alias);
> > > +
> > > +    memory_region_init_ram(&s->sram, NULL, "stm32.sram", SRAM_SIZE,
> > > +                           &error_fatal);
> > > +    memory_region_add_subregion(system_memory, SRAM_BASE, &s->sram);
> > > +
> > > +    qdev_prop_set_bit(DEVICE(&s->cpu), "enable-bitband", true);
> > > +    qdev_prop_set_uint32(DEVICE(&s->cpu), "num-irq", 80);
> > > +    qdev_prop_set_string(DEVICE(&s->cpu), "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
> > > +
> > > +    object_property_set_link(OBJECT(&s->cpu), OBJECT(system_memory),
> > > +                                    "memory", &error_abort);
> > > +    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
> > > +    if (err != NULL) {
> > > +        error_propagate(errp, err);
> > > +        return;
> > > +    }
> > > +}
> > > +
> > > +static Property stm32f103_soc_properties[] = {
> > > +    DEFINE_PROP_UINT32("flash-size", STM32F103State, flash_size, FLASH_SIZE),
> > > +    DEFINE_PROP_UINT32("sram-size", STM32F103State, sram_size, SRAM_SIZE),
> > > +    DEFINE_PROP_END_OF_LIST(),
> > > +};
> > > +
> > > +static void stm32f103_soc_class_init(ObjectClass *klass, void *data)
> > > +{
> > > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > > +
> > > +    dc->props   = stm32f103_soc_properties;
> > > +    dc->realize = stm32f103_soc_realize;
> > > +}
> > > +
> > > +static const TypeInfo stm32f103_soc_info = {
> > > +    .name          = TYPE_STM32F103_SOC,
> > > +    .parent        = TYPE_SYS_BUS_DEVICE,
> > > +    .instance_size = sizeof(STM32F103State),
> > > +    .instance_init = stm32f103_soc_init,
> > > +    .class_init    = stm32f103_soc_class_init,
> > > +};
> > > +
> > > +static void stm32f103_soc_types(void)
> > > +{
> > > +    type_register_static(&stm32f103_soc_info);
> > > +}
> > > +type_init(stm32f103_soc_types)
> > > diff --git a/include/hw/arm/stm32f103_soc.h b/include/hw/arm/stm32f103_soc.h
> > > new file mode 100644
> > > index 0000000000..d6b2eb9c57
> > > --- /dev/null
> > > +++ b/include/hw/arm/stm32f103_soc.h
> > > @@ -0,0 +1,54 @@
> > > +/*
> > > + * STM32 F103 SoC (or MCU)
> > > + *
> > > + * Copyright (c) 2018 Priit Laes <plaes@plaes.org>
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > > + * of this software and associated documentation files (the "Software"), to deal
> > > + * in the Software without restriction, including without limitation the rights
> > > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > > + * copies of the Software, and to permit persons to whom the Software is
> > > + * furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice shall be included in
> > > + * all copies or substantial portions of the Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > > + * THE SOFTWARE.
> > > + */
> > > +
> > > +#ifndef HW_ARM_STM32F103_SOC_H
> > > +#define HW_ARM_STM32F103_SOC_H
> > > +
> > > +#include "hw/arm/armv7m.h"
> > > +
> > > +#define TYPE_STM32F103_SOC "stm32f103-soc"
> > > +#define STM32F103_SOC(obj) \
> > > +    OBJECT_CHECK(STM32F103State, (obj), TYPE_STM32F103_SOC)
> > > +
> > > +/* TODO: flash/sram sizes are for STM32F103C8 part. */
> > > +#define FLASH_SIZE     (64 * 1024)
> > > +#define SRAM_SIZE      (20 * 1024)
> > > +
> > > +typedef struct STM32F103State {
> > > +    SysBusDevice parent_obj;
> > > +
> > > +    ARMv7MState cpu;
> > > +
> > > +    uint32_t sram_size;
> > > +    uint32_t flash_size;
> > > +    MemoryRegion sram;
> > > +    MemoryRegion flash;
> > > +    /* XXX: find better name */
> > > +    MemoryRegion flash_alias;
> > > +
> > > +    /* TODO: Peripherals */
> > > +
> > > +} STM32F103State;
> > > +
> > > +#endif /* HW_ARM_STM32F103_SOC_H */
> > > --
> > > 2.20.1
> > >
> > >
>
