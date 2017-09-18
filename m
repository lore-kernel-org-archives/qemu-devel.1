Received: from eggs.gnu.org ([2001:4830:134:3::10]:33802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dtsgG-00034A-G6
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dtsgC-0008AL-RD
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:49:32 -0400
MIME-Version: 1.0
In-Reply-To: <9d3d6ffd-bf3b-8102-8a08-beee28656a54@amsat.org>
References: <1505494753-10837-1-git-send-email-sundeep.lkml@gmail.com>
	<1505494753-10837-5-git-send-email-sundeep.lkml@gmail.com>
	<9d3d6ffd-bf3b-8102-8a08-beee28656a54@amsat.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Mon, 18 Sep 2017 15:19:27 +0530
Message-ID: <CALHRZurrbATjkAbBc-RJBH-+nX8jA4WcV2tqS+CNw8VaKEEkjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu devel v9 PATCH 4/5] msf2: Add Smartfusion2
 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>

Hi Philippe,

On Mon, Sep 18, 2017 at 6:38 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> On 09/15/2017 01:59 PM, Subbaraya Sundeep wrote:
>
>> Smartfusion2 SoC has hardened Microcontroller subsystem
>> and flash based FPGA fabric. This patch adds support for
>> Microcontroller subsystem in the SoC.
>>
>> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>   default-configs/arm-softmmu.mak |   1 +
>>   hw/arm/Makefile.objs            |   1 +
>>   hw/arm/msf2-soc.c               | 232 ++++++++++++++++++++++++++++++
>> ++++++++++
>>   include/hw/arm/msf2-soc.h       |  66 ++++++++++++
>>   4 files changed, 300 insertions(+)
>>   create mode 100644 hw/arm/msf2-soc.c
>>   create mode 100644 include/hw/arm/msf2-soc.h
>>
>> diff --git a/default-configs/arm-softmmu.mak
>> b/default-configs/arm-softmmu.mak
>> index bbdd3c1..5059d13 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -129,3 +129,4 @@ CONFIG_ACPI=3Dy
>>   CONFIG_SMBIOS=3Dy
>>   CONFIG_ASPEED_SOC=3Dy
>>   CONFIG_GPIO_KEY=3Dy
>> +CONFIG_MSF2=3Dy
>> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
>> index a2e56ec..df36a03 100644
>> --- a/hw/arm/Makefile.objs
>> +++ b/hw/arm/Makefile.objs
>> @@ -19,3 +19,4 @@ obj-$(CONFIG_FSL_IMX31) +=3D fsl-imx31.o kzm.o
>>   obj-$(CONFIG_FSL_IMX6) +=3D fsl-imx6.o sabrelite.o
>>   obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_soc.o aspeed.o
>>   obj-$(CONFIG_MPS2) +=3D mps2.o
>> +obj-$(CONFIG_MSF2) +=3D msf2-soc.o
>> diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
>> new file mode 100644
>> index 0000000..5c0a2ea
>> --- /dev/null
>> +++ b/hw/arm/msf2-soc.c
>> @@ -0,0 +1,232 @@
>> +/*
>> + * SmartFusion2 SoC emulation.
>> + *
>> + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtainin=
g
>> a copy
>> + * of this software and associated documentation files (the "Software")=
,
>> to deal
>> + * in the Software without restriction, including without limitation th=
e
>> rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
>> sell
>> + * copies of the Software, and to permit persons to whom the Software i=
s
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
>> SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qemu-common.h"
>> +#include "hw/arm/arm.h"
>> +#include "exec/address-spaces.h"
>> +#include "hw/char/serial.h"
>> +#include "hw/boards.h"
>> +#include "sysemu/block-backend.h"
>> +#include "qemu/cutils.h"
>> +#include "hw/arm/msf2-soc.h"
>> +#include "hw/misc/unimp.h"
>> +
>> +#define MSF2_TIMER_BASE       0x40004000
>> +#define MSF2_SYSREG_BASE      0x40038000
>> +
>> +#define ENVM_BASE_ADDRESS     0x60000000
>> +
>> +#define SRAM_BASE_ADDRESS     0x20000000
>> +
>> +#define MSF2_ENVM_MAX_SIZE    (512 * K_BYTE)
>> +
>> +/*
>> + * eSRAM max size is 80k without SECDED(Single error correction and
>> + * dual error detection) feature and 64k with SECDED.
>> + * We do not support SECDED now.
>> + */
>> +#define MSF2_ESRAM_MAX_SIZE       (80 * K_BYTE)
>> +
>> +static const uint32_t spi_addr[MSF2_NUM_SPIS] =3D { 0x40001000 ,
>> 0x40011000 };
>> +static const uint32_t uart_addr[MSF2_NUM_UARTS] =3D { 0x40000000 ,
>> 0x40010000 };
>> +
>> +static const int spi_irq[MSF2_NUM_SPIS] =3D { 2, 3 };
>> +static const int uart_irq[MSF2_NUM_UARTS] =3D { 10, 11 };
>> +static const int timer_irq[MSF2_NUM_TIMERS] =3D { 14, 15 };
>> +
>> +static void m2sxxx_soc_initfn(Object *obj)
>> +{
>> +    MSF2State *s =3D MSF2_SOC(obj);
>> +    int i;
>> +
>> +    object_initialize(&s->armv7m, sizeof(s->armv7m), TYPE_ARMV7M);
>> +    qdev_set_parent_bus(DEVICE(&s->armv7m), sysbus_get_default());
>> +
>> +    object_initialize(&s->sysreg, sizeof(s->sysreg), TYPE_MSF2_SYSREG);
>> +    qdev_set_parent_bus(DEVICE(&s->sysreg), sysbus_get_default());
>> +
>> +    object_initialize(&s->timer, sizeof(s->timer), TYPE_MSS_TIMER);
>> +    qdev_set_parent_bus(DEVICE(&s->timer), sysbus_get_default());
>> +
>> +    for (i =3D 0; i < MSF2_NUM_SPIS; i++) {
>> +        object_initialize(&s->spi[i], sizeof(s->spi[i]),
>> +                          TYPE_MSS_SPI);
>> +        qdev_set_parent_bus(DEVICE(&s->spi[i]), sysbus_get_default());
>> +    }
>> +}
>> +
>> +static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
>> +{
>> +    MSF2State *s =3D MSF2_SOC(dev_soc);
>> +    DeviceState *dev, *armv7m;
>> +    SysBusDevice *busdev;
>> +    Error *err =3D NULL;
>> +    int i;
>> +
>> +    MemoryRegion *system_memory =3D get_system_memory();
>> +    MemoryRegion *nvm =3D g_new(MemoryRegion, 1);
>> +    MemoryRegion *nvm_alias =3D g_new(MemoryRegion, 1);
>> +    MemoryRegion *sram =3D g_new(MemoryRegion, 1);
>> +
>> +    memory_region_init_rom(nvm, NULL, "MSF2.eNVM", s->envm_size,
>> +                           &error_fatal);
>> +    /*
>> +     * On power-on, the eNVM region 0x60000000 is automatically
>> +     * remapped to the Cortex-M3 processor executable region
>> +     * start address (0x0). We do not support remapping other eNVM,
>> +     * eSRAM and DDR regions by guest(via Sysreg) currently.
>> +     */
>> +    memory_region_init_alias(nvm_alias, NULL, "MSF2.eNVM",
>> +                             nvm, 0, s->envm_size);
>> +
>> +    memory_region_add_subregion(system_memory, ENVM_BASE_ADDRESS, nvm);
>> +    memory_region_add_subregion(system_memory, 0, nvm_alias);
>> +
>> +    memory_region_init_ram(sram, NULL, "MSF2.eSRAM", s->esram_size,
>> +                           &error_fatal);
>> +    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram)=
;
>> +
>> +    armv7m =3D DEVICE(&s->armv7m);
>> +    qdev_prop_set_uint32(armv7m, "num-irq", 81);
>> +    qdev_prop_set_string(armv7m, "cpu-model", "cortex-m3");
>> +    object_property_set_link(OBJECT(&s->armv7m),
>> OBJECT(get_system_memory()),
>> +                                     "memory", &error_abort);
>> +    object_property_set_bool(OBJECT(&s->armv7m), true, "realized",
>> &err);
>> +    if (err !=3D NULL) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +
>> +    system_clock_scale =3D NANOSECONDS_PER_SECOND / s->m3clk;
>> +
>> +    for (i =3D 0; i < MSF2_NUM_UARTS; i++) {
>> +        if (serial_hds[i]) {
>> +            serial_mm_init(get_system_memory(), uart_addr[i], 2,
>> +                           qdev_get_gpio_in(armv7m, uart_irq[i]),
>> +                           115200, serial_hds[i], DEVICE_NATIVE_ENDIAN)=
;
>> +        }
>> +    }
>> +
>> +    dev =3D DEVICE(&s->timer);
>> +    /* APB0 clock is the timer input clock */
>> +    qdev_prop_set_uint32(dev, "clock-frequency", s->m3clk / s->apb0div)=
;
>> +    object_property_set_bool(OBJECT(&s->timer), true, "realized", &err)=
;
>> +    if (err !=3D NULL) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +    busdev =3D SYS_BUS_DEVICE(dev);
>> +    sysbus_mmio_map(busdev, 0, MSF2_TIMER_BASE);
>> +    sysbus_connect_irq(busdev, 0,
>> +                           qdev_get_gpio_in(armv7m, timer_irq[0]));
>> +    sysbus_connect_irq(busdev, 1,
>> +                           qdev_get_gpio_in(armv7m, timer_irq[1]));
>> +
>> +    dev =3D DEVICE(&s->sysreg);
>> +    qdev_prop_set_uint32(dev, "apb0divisor", s->apb0div);
>> +    qdev_prop_set_uint32(dev, "apb1divisor", s->apb1div);
>> +    object_property_set_bool(OBJECT(&s->sysreg), true, "realized",
>> &err);
>> +    if (err !=3D NULL) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +    busdev =3D SYS_BUS_DEVICE(dev);
>> +    sysbus_mmio_map(busdev, 0, MSF2_SYSREG_BASE);
>> +
>> +    for (i =3D 0; i < MSF2_NUM_SPIS; i++) {
>> +        gchar *bus_name;
>> +
>> +        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",
>> &err);
>> +        if (err !=3D NULL) {
>> +            error_propagate(errp, err);
>> +            return;
>> +        }
>> +
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_addr[i]);
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
>> +                           qdev_get_gpio_in(armv7m, spi_irq[i]));
>> +
>> +        /* Alias controller SPI bus to the SoC itself */
>> +        bus_name =3D g_strdup_printf("spi%d", i);
>> +        object_property_add_alias(OBJECT(s), bus_name,
>> +                                  OBJECT(&s->spi[i]), "spi",
>> +                                  &error_abort);
>> +        g_free(bus_name);
>> +    }
>> +
>> +    /* Below devices are not modelled yet. */
>> +    create_unimplemented_device("i2c_0", 0x40002000, 0x1000);
>> +    create_unimplemented_device("pdma", 0x40003000, 0x1000);
>>
>
> name it "dma" only.


Just named so that it matches documentation. No strong feelings regd. names=
.
I will change to dma and hs-dma .

>
>
> +    create_unimplemented_device("watchdog", 0x40005000, 0x1000);
>> +    create_unimplemented_device("i2c_1", 0x40012000, 0x1000);
>> +    create_unimplemented_device("gpio", 0x40013000, 0x1000);
>> +    create_unimplemented_device("hpdma", 0x40014000, 0x1000);
>>
>
> "hs-dma" ?


Ok

>
>
> +    create_unimplemented_device("can", 0x40015000, 0x1000);
>> +    create_unimplemented_device("rtc", 0x40017000, 0x1000);
>> +    create_unimplemented_device("apb_config", 0x40020000, 0x10000);
>>
>
> hmm ok.
>
> +    create_unimplemented_device("emac", 0x40041000, 0x1000);
>> +    create_unimplemented_device("usb", 0x40043000, 0x1000);
>> +}
>>
>
> now the cpu memory tree looks:
>
> (qemu) info mtree
> address-space: cpu-memory
>   0000000000000000-ffffffffffffffff (prio 0, i/o): armv7m-container
>     0000000000000000-ffffffffffffffff (prio -1, i/o): system
>       0000000000000000-000000000003ffff (prio 0, i/o): alias MSF2.eNVM
> @MSF2.eNVM 0000000000000000-000000000003ffff
>       0000000020000000-000000002000ffff (prio 0, ram): MSF2.eSRAM
>       0000000040000000-000000004000001f (prio 0, i/o): serial
>       0000000040001000-000000004000103f (prio 0, i/o): mss-spi
>       0000000040002000-0000000040002fff (prio -1000, i/o): i2c_0
>       0000000040003000-0000000040003fff (prio -1000, i/o): pdma
>       0000000040004000-000000004000402f (prio 0, i/o): mss-timer
>       0000000040005000-0000000040005fff (prio -1000, i/o): watchdog
>       0000000040011000-000000004001103f (prio 0, i/o): mss-spi
>       0000000040012000-0000000040012fff (prio -1000, i/o): i2c_1
>       0000000040013000-0000000040013fff (prio -1000, i/o): gpio
>       0000000040014000-0000000040014fff (prio -1000, i/o): hpdma
>       0000000040015000-0000000040015fff (prio -1000, i/o): can
>       0000000040017000-0000000040017fff (prio -1000, i/o): rtc
>       0000000040020000-000000004002ffff (prio -1000, i/o): apb_config
>       0000000040038000-00000000400382ff (prio 0, i/o): msf2-sysreg
>       0000000040041000-0000000040041fff (prio -1000, i/o): emac
>       0000000040043000-0000000040043fff (prio -1000, i/o): usb
>       0000000060000000-000000006003ffff (prio 0, rom): MSF2.eNVM
>       00000000a0000000-00000000a3ffffff (prio 0, ram): ddr-ram
>     0000000022000000-0000000023ffffff (prio 0, i/o): bitband
>     0000000042000000-0000000043ffffff (prio 0, i/o): bitband
>     00000000e000e000-00000000e000efff (prio 0, i/o): nvic
>       00000000e000e000-00000000e000efff (prio 0, i/o): nvic_sysregs
>       00000000e000e010-00000000e000e0ef (prio 1, i/o): systick
>
> +
>> +static Property m2sxxx_soc_properties[] =3D {
>> +    /*
>> +     * part name specifies the type of SmartFusion2 device variant(this
>> +     * property is for information purpose only.
>> +     */
>> +    DEFINE_PROP_STRING("part-name", MSF2State, part_name),
>> +    DEFINE_PROP_UINT64("eNVM-size", MSF2State, envm_size,
>> MSF2_ENVM_MAX_SIZE),
>> +    DEFINE_PROP_UINT64("eSRAM-size", MSF2State, esram_size,
>> +                        MSF2_ESRAM_MAX_SIZE),
>> +    /* Libero GUI shows 100Mhz as default for clocks */
>> +    DEFINE_PROP_UINT32("m3clk", MSF2State, m3clk, 100 * 1000000),
>> +    /* default divisors in Libero GUI */
>> +    DEFINE_PROP_UINT32("apb0div", MSF2State, apb0div, 2),
>> +    DEFINE_PROP_UINT32("apb1div", MSF2State, apb1div, 2),
>>
>
> DEFINE_PROP_UINT8 ?
>
>
> Ok


> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void m2sxxx_soc_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->realize =3D m2sxxx_soc_realize;
>> +    dc->props =3D m2sxxx_soc_properties;
>> +}
>> +
>> +static const TypeInfo m2sxxx_soc_info =3D {
>> +    .name          =3D TYPE_MSF2_SOC,
>> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(MSF2State),
>> +    .instance_init =3D m2sxxx_soc_initfn,
>> +    .class_init    =3D m2sxxx_soc_class_init,
>> +};
>> +
>> +static void m2sxxx_soc_types(void)
>> +{
>> +    type_register_static(&m2sxxx_soc_info);
>> +}
>> +
>> +type_init(m2sxxx_soc_types)
>> diff --git a/include/hw/arm/msf2-soc.h b/include/hw/arm/msf2-soc.h
>> new file mode 100644
>> index 0000000..eb239fa
>> --- /dev/null
>> +++ b/include/hw/arm/msf2-soc.h
>> @@ -0,0 +1,66 @@
>> +/*
>> + * Microsemi Smartfusion2 SoC
>> + *
>> + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtainin=
g
>> a copy
>> + * of this software and associated documentation files (the "Software")=
,
>> to deal
>> + * in the Software without restriction, including without limitation th=
e
>> rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
>> sell
>> + * copies of the Software, and to permit persons to whom the Software i=
s
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
>> SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#ifndef HW_ARM_MSF2_SOC_H
>> +#define HW_ARM_MSF2_SOC_H
>> +
>> +#include "hw/arm/armv7m.h"
>> +#include "hw/timer/mss-timer.h"
>> +#include "hw/misc/msf2-sysreg.h"
>> +#include "hw/ssi/mss-spi.h"
>> +
>> +#define TYPE_MSF2_SOC     "msf2-soc"
>> +#define MSF2_SOC(obj)     OBJECT_CHECK(MSF2State, (obj), TYPE_MSF2_SOC)
>> +
>> +#define MSF2_NUM_SPIS         2
>> +#define MSF2_NUM_UARTS        2
>> +
>> +/*
>> + * System timer consists of two programmable 32-bit
>> + * decrementing counters that generate individual interrupts to
>> + * the Cortex-M3 processor
>> + */
>> +#define MSF2_NUM_TIMERS       2
>> +
>> +typedef struct MSF2State {
>> +    /*< private >*/
>> +    SysBusDevice parent_obj;
>> +    /*< public >*/
>> +
>> +    ARMv7MState armv7m;
>> +
>> +    char *part_name;
>> +    uint64_t envm_size;
>> +    uint64_t esram_size;
>> +
>> +    uint32_t m3clk;
>> +    uint32_t apb0div;
>> +    uint32_t apb1div;
>>
>
> uint8_t ?


Ok

>
>
> +
>> +    MSF2SysregState sysreg;
>> +    MSSTimerState timer;
>> +    MSSSpiState spi[MSF2_NUM_SPIS];
>> +} MSF2State;
>> +
>> +#endif
>>
>>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>

Thank you,
Sundeep
