Received: from eggs.gnu.org ([2001:4830:134:3::10]:59935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1ffHHS-0007qe-98
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 00:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1ffHHO-0006Fb-Ub
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 00:08:06 -0400
Sender: Guenter Roeck <groeck7@gmail.com>
References: <1531692369-1511-1-git-send-email-linux@roeck-us.net>
	<a98fbbe0-ead2-b32a-54ee-8aacc08ed7a6@amsat.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2955b0dc-9730-4d54-5c26-bcb18002373e@roeck-us.net>
Date: Mon, 16 Jul 2018 21:07:59 -0700
MIME-Version: 1.0
In-Reply-To: <a98fbbe0-ead2-b32a-54ee-8aacc08ed7a6@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [RFC PATCH] hw: arm: Add basic support
 for cprman (clock subsystem)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Pekka Enberg <penberg@iki.fi>, Clement Deschamps <clement.deschamps@antfield.fr>, Luc Michel <luc.michel@git.antfield.fr>

On 07/16/2018 06:53 PM, Philippe Mathieu-Daudé wrote:
> Hi Guenter,
> 
> On 07/15/2018 07:06 PM, Guenter Roeck wrote:
>> Add basic support for BCM283x CPRMAN. Provide support for reading and
>> writing CPRMAN registers and initialize registers with sensible default
>> values. During runtime retain any written values.
>>
>> Basic CPRMAN support is necessary and sufficient to boot Linux on raspi2
>> and raspi3 systems.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> I don't seriously expect this patch to get accepted, but I thought
>> it might be valuable enough for others to use it when playing with
>> raspi2 and raspi3 emulations.
> 
> I've been working on a very similar patch... But due to soft-freeze I
> postponed it.
> 

> I don't feel very confident with my local work, as you, it is based on
> looking at the Broadcom firmware [1] and how the Linux kernel initialize
> the devices. I'll however compare with your work.
> 

I'll be more than happy to drop my patch and go with yours instead.
Let's just do that - it looks like it is much more comprehensive.

> [1]: https://github.com/raspberrypi/firmware/tree/master/boot
> 
>>
>>   hw/arm/bcm2835_peripherals.c         |  15 +++++
>>   hw/misc/Makefile.objs                |   1 +
>>   hw/misc/bcm2835_cprman.c             | 126 +++++++++++++++++++++++++++++++++++
>>   include/hw/arm/bcm2835_peripherals.h |   2 +
>>   include/hw/arm/raspi_platform.h      |   1 +
>>   include/hw/misc/bcm2835_cprman.h     |  28 ++++++++
>>   6 files changed, 173 insertions(+)
>>   create mode 100644 hw/misc/bcm2835_cprman.c
>>   create mode 100644 include/hw/misc/bcm2835_cprman.h
>>
>> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
>> index 6be7660..1a8993f 100644
>> --- a/hw/arm/bcm2835_peripherals.c
>> +++ b/hw/arm/bcm2835_peripherals.c
>> @@ -85,6 +85,11 @@ static void bcm2835_peripherals_init(Object *obj)
>>       object_property_add_const_link(OBJECT(&s->property), "dma-mr",
>>                                      OBJECT(&s->gpu_bus_mr), &error_abort);
>>   
>> +    /* Clock subsystem */
>> +    object_initialize(&s->cprman, sizeof(s->cprman), TYPE_BCM2835_CPRMAN);
>> +    object_property_add_child(obj, "cprman", OBJECT(&s->cprman), NULL);
>> +    qdev_set_parent_bus(DEVICE(&s->cprman), sysbus_get_default());
>> +
>>       /* Random Number Generator */
>>       object_initialize(&s->rng, sizeof(s->rng), TYPE_BCM2835_RNG);
>>       object_property_add_child(obj, "rng", OBJECT(&s->rng), NULL);
>> @@ -244,6 +249,13 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->property), 0,
>>                         qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_PROPERTY));
>>   
>> +    /* Clock subsystem */
>> +    object_property_set_bool(OBJECT(&s->cprman), true, "realized", &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +
>>       /* Random Number Generator */
>>       object_property_set_bool(OBJECT(&s->rng), true, "realized", &err);
>>       if (err) {
>> @@ -251,6 +263,9 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>>           return;
>>       }
>>   
>> +    memory_region_add_subregion(&s->peri_mr, CPRMAN_OFFSET,
>> +                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cprman), 0));
>> +
>>       memory_region_add_subregion(&s->peri_mr, RNG_OFFSET,
>>                   sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng), 0));
>>   
>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> index 9350900..ae5fc8a 100644
>> --- a/hw/misc/Makefile.objs
>> +++ b/hw/misc/Makefile.objs
>> @@ -52,6 +52,7 @@ obj-$(CONFIG_OMAP) += omap_tap.o
>>   obj-$(CONFIG_RASPI) += bcm2835_mbox.o
>>   obj-$(CONFIG_RASPI) += bcm2835_property.o
>>   obj-$(CONFIG_RASPI) += bcm2835_rng.o
>> +obj-$(CONFIG_RASPI) += bcm2835_cprman.o
>>   obj-$(CONFIG_SLAVIO) += slavio_misc.o
>>   obj-$(CONFIG_ZYNQ) += zynq_slcr.o
>>   obj-$(CONFIG_ZYNQ) += zynq-xadc.o
>> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
>> new file mode 100644
>> index 0000000..4051f2b
>> --- /dev/null
>> +++ b/hw/misc/bcm2835_cprman.c
>> @@ -0,0 +1,126 @@
>> +/*
>> + * BCM2835 Clock subsystem (poor man's version)
>> + *
>> + * Copyright (C) 2018 Guenter Roeck <linux@roeck-us.net>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "qapi/error.h"
>> +#include "crypto/random.h"
>> +#include "hw/misc/bcm2835_cprman.h"
>> +
>> +static uint64_t bcm2835_cprman_read(void *opaque, hwaddr offset,
>> +                                 unsigned size)
>> +{
>> +    BCM2835CprmanState *s = (BCM2835CprmanState *)opaque;
>> +    uint32_t res = 0;
>> +
>> +    assert(size == 4);
>> +
>> +    if (offset / 4 < CPRMAN_NUM_REGS) {
>> +        res = s->regs[offset / 4];
>> +    }
>> +
>> +    return res;
>> +}
> 
> Yes, this read() works.
> 
> A bit more verbose:
> 
> static const char *names[64] = {
>      [0] = "GNRIC",
>      [1] = "VPU",
>      [2] = "SYS",
>      [3] = "PERIA",
>      [4] = "PERII",
>      [5] = "H264",
>      [6] = "ISP",
>      [7] = "V3D",
>      [8] = "CAM0",
>      [9] = "CAM1",
>      [10] = "CCP2",
>      [11] = "DSI0E",
>      [12] = "DSI0P",
>      [13] = "DPI",
>      [14] = "GP0",
>      [15] = "GP1",
>      [16] = "GP2",
>      [17] = "HSM",
>      [18] = "OTP",
>      [19] = "PCM",
>      [20] = "PWM",
>      [21] = "SLIM",
>      [22] = "SMI",
>      [24] = "TCNT",
>      [25] = "TEC",
>      [26] = "TD0",
>      [27] = "TD1",
>      [28] = "TSENS",
>      [29] = "TIMER",
>      [30] = "UART",
>      [31] = "VEC",
>      [50] = "PULSE",
>      [53] = "SDC",
>      [54] = "ARM",
>      [55] = "AVEO",
>      [56] = "EMMC",
> };
> 
> static uint64_t bcm2835_cprman_read(void *opaque, hwaddr offset,
>                                      unsigned size)
> {
>      BCM2835CprmanState *s = (BCM2835CprmanState *)opaque;
>      int idx = addr / 8;
>      bool div = addr % 8;
>      const char *name = names[idx] ? names[idx] : "UNKN";
>      uint64_t value = s->regs[addr >> 2];
> 
>      switch (addr) {
>      case 0 ... 0x100:
>          qemu_log_mask(LOG_UNIMP, "[CM]: %s unimp r%02d  0x%04"
> HWADDR_PRIx " = 0x%"PRIx64 " (%s)\n",
>                        div ? "DIV" : "CTL", size << 3, addr, value, name);
>          break;
>      case 0x104 ... 0x114:
>          qemu_log_mask(LOG_UNIMP, "[CM]: PLL? unimp r%02d  0x%04"
> HWADDR_PRIx " = 0x%"PRIx64 "\n",
>                        size << 3, addr, value);
>          value = -1; /* FIXME PLL lock? */
>          break;
>      }
>      return value;
> }
> 
>> +
>> +#define CM_PASSWORD             0x5a000000
>> +#define CM_PASSWORD_MASK        0xff000000
>> +
>> +static void bcm2835_cprman_write(void *opaque, hwaddr offset,
>> +                              uint64_t value, unsigned size)
>> +{
>> +    BCM2835CprmanState *s = (BCM2835CprmanState *)opaque;
>> +
>> +    assert(size == 4);
> 
> Instead of this assert() ...
> 
>> +
>> +    if ((value & 0xff000000) == CM_PASSWORD &&
>> +        offset / 4 < CPRMAN_NUM_REGS)
>> +            s->regs[offset / 4] = value & ~CM_PASSWORD_MASK;
>> +}
>> +
>> +static const MemoryRegionOps bcm2835_cprman_ops = {
>> +    .read = bcm2835_cprman_read,
>> +    .write = bcm2835_cprman_write,
> 
> ... I used:
> 
>         .impl.min_access_size = 4,
>         .valid.min_access_size = 4,
> 
>> +    .endianness = DEVICE_NATIVE_ENDIAN,
>> +};
> 
> Same verbose write():
> 
> static void bcm2835_cprman_write(void *opaque, hwaddr offset,
>                                   uint64_t value, unsigned size)
> {
>      BCM2835CprmanState *s = (BCM2835CprmanState *)opaque;
>      int idx = addr / 8;
>      bool div = addr % 8;
>      const char *name = names[idx] ? names[idx] : "UNKN";
> 
>      if (extract64(value, 24, 8) != CM_KEY) {
>          qemu_log_mask(LOG_GUEST_ERROR, "[CM]: %s error w%02d *0x%04"
> HWADDR_PRIx " = 0x%" PRIx64 " (%s)\n",
>                        div ? "DIV" : "CTL", size << 3, addr, value, name);
>          return;
>      }
>      s->regs[addr >> 2] = extract64(value, 0, 24);
>      switch (addr) {
>      case 0 ... 0x100:
>          if (div) {
>              qemu_log_mask(LOG_UNIMP, "[CM]: DIV unimp w%02d *0x%04"
> HWADDR_PRIx " = 0x%" PRIx64 " (%s) %" PRIu64 ".%" PRIu64 "\n",
>                            size << 3, addr, value, name, extract64(value,
> 12, 12), 1000 * extract64(value, 0, 12) / 1024);
>          } else {
>              qemu_log_mask(LOG_UNIMP, "[CM]: CTL unimp w%02d *0x%04"
> HWADDR_PRIx " = 0x%" PRIx64 " (%s) src=%" PRIu64 " ena:%u\n",
>                            size << 3, addr, value, name, value & 0xf,
> !!(value & (1 << 4)));
>          }
>          break;
>      case 0x104 ... 0x114:
>          qemu_log_mask(LOG_UNIMP, "[CM]: PLL? unimp w%02d *0x%04"
> HWADDR_PRIx " = 0x%" PRIx64 "\n",
>                        size << 3, addr, value);
>          break;
>      }
> }
> 
>> +
>> +static const VMStateDescription vmstate_bcm2835_cprman = {
>> +    .name = TYPE_BCM2835_CPRMAN,
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT32_ARRAY(regs, BCM2835CprmanState, CPRMAN_NUM_REGS),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static void bcm2835_cprman_init(Object *obj)
>> +{
>> +    BCM2835CprmanState *s = BCM2835_CPRMAN(obj);
>> +
>> +    memory_region_init_io(&s->iomem, obj, &bcm2835_cprman_ops, s,
>> +                          TYPE_BCM2835_CPRMAN, 0x2000);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
>> +}
>> +
>> +#define CM_GNRICCTL        (0x000 / 4)
>> +#define CM_VECCTL        (0x0f8 / 4)
>> +#define CM_DFTCTL        (0x168 / 4)
>> +#define CM_EMMCCTL        (0x1c0 / 4)
> 
>> +#define A2W_PLLA_CTRL        (0x1100 / 4)
>> +#define A2W_PLLB_CTRL        (0x11e0 / 4)
> 
> The A2W is another device you don't need to worry about, just use add a
> 0x1000 UNIMP device.
> 

I thought it was needed to get a non-zero divider, but my memory may defeat me.

Guenter

>> +
>> +static void bcm2835_cprman_reset(DeviceState *dev)
>> +{
>> +    BCM2835CprmanState *s = BCM2835_CPRMAN(dev);
>> +    int i;
>> +
>> +    /*
>> +     * Available information suggests that CPRMAN registers have default
>> +     * values which are not overwritten by ROMMON (u-boot). The hardware
>> +     * default values are unknown at this time.
>> +     * The default values selected here are necessary and sufficient
>> +     * to boot Linux directly (on raspi2 and raspi3). The selected
>> +     * values enable all clocks and set clock rates to match their
>> +     * parent rates.
>> +     */
> 
> Lucky you...
> 
>> +    for (i = CM_GNRICCTL; i <= CM_VECCTL; i += 2) {
>> +        s->regs[i] = 0x11;
>> +        s->regs[i + 1] = 0x1000;
>> +    }
>> +    for (i = CM_DFTCTL; i <= CM_EMMCCTL; i += 2) {
>> +        s->regs[i] = 0x11;
>> +        s->regs[i + 1] = 0x1000;
>> +    }
>> +    for (i = A2W_PLLA_CTRL; i <= A2W_PLLB_CTRL; i += 8) {
>> +        s->regs[i] = 0x10001;
>> +    }
>> +}
> 
> ... I remember having headaches with this CRAP reset():
> 
> static void bcm2836_enable_clk(BCM2835ClockState *s, int clk_id, int
> clk_src, int div_int, int div_frac)
> {
>      s->regs[2 * clk_id + 0] = (/* MASH */1 << 9) | (1 << 4) | (clk_src
> << 0);
>      s->regs[2 * clk_id + 1] = (div_int << 12) | (div_frac << 0);
> }
> 
> static void bcm2836_cm_reset(DeviceState *d)
> {
>      BCM2835ClockState *s = BCM2835_CLOCK(d);
> 
>      int osc_freq_hz = 2400000; /* TODO property */
>      int baudrate = 115200; /* TODO property */
>      int vpu_fracbits = 12; /* TODO property */
>      div_t qi = div(osc_freq_hz, baudrate);
>      div_t qf = div(qi.rem << vpu_fracbits, baudrate);
> 
>      bcm2836_enable_clk(s, 1 /* VPU */, 1 /* OSC */, qi.quot, qf.quot);
>      bcm2836_enable_clk(s, 1 /* VPU */, 1 /* OSC */, 1, 0);
> }
> 
> I can't say it is correct until I reopen this branch (September?).
> 
>> +
>> +static void bcm2835_cprman_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->reset = bcm2835_cprman_reset;
>> +    dc->vmsd = &vmstate_bcm2835_cprman;
>> +}
>> +
>> +static TypeInfo bcm2835_cprman_info = {
>> +    .name          = TYPE_BCM2835_CPRMAN,
>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(BCM2835CprmanState),
>> +    .class_init    = bcm2835_cprman_class_init,
>> +    .instance_init = bcm2835_cprman_init,
>> +};
>> +
>> +static void bcm2835_cprman_register_types(void)
>> +{
>> +    type_register_static(&bcm2835_cprman_info);
>> +}
>> +
>> +type_init(bcm2835_cprman_register_types)
>> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
>> index f5b193f..f9f53e3 100644
>> --- a/include/hw/arm/bcm2835_peripherals.h
>> +++ b/include/hw/arm/bcm2835_peripherals.h
>> @@ -19,6 +19,7 @@
>>   #include "hw/intc/bcm2835_ic.h"
>>   #include "hw/misc/bcm2835_property.h"
>>   #include "hw/misc/bcm2835_rng.h"
>> +#include "hw/misc/bcm2835_cprman.h"
>>   #include "hw/misc/bcm2835_mbox.h"
>>   #include "hw/sd/sdhci.h"
>>   #include "hw/sd/bcm2835_sdhost.h"
>> @@ -44,6 +45,7 @@ typedef struct BCM2835PeripheralState {
>>       BCM2835ICState ic;
>>       BCM2835PropertyState property;
>>       BCM2835RngState rng;
>> +    BCM2835CprmanState cprman;
>>       BCM2835MboxState mboxes;
>>       SDHCIState sdhci;
>>       BCM2835SDHostState sdhost;
>> diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
>> index 6467e88..412d010 100644
>> --- a/include/hw/arm/raspi_platform.h
>> +++ b/include/hw/arm/raspi_platform.h
>> @@ -36,6 +36,7 @@
>>                                                         * Doorbells & Mailboxes */
>>   #define PM_OFFSET               0x100000 /* Power Management, Reset controller
>>                                             * and Watchdog registers */
>> +#define CPRMAN_OFFSET           0x101000
>>   #define PCM_CLOCK_OFFSET        0x101098
>>   #define RNG_OFFSET              0x104000
>>   #define GPIO_OFFSET             0x200000
>> diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835_cprman.h
>> new file mode 100644
>> index 0000000..db250b3
>> --- /dev/null
>> +++ b/include/hw/misc/bcm2835_cprman.h
>> @@ -0,0 +1,28 @@
>> +/*
>> + * BCM2835 Poor-man's version of CPRMAN
>> + *
>> + * Copyright (C) 2018 Guenter Roeck <linux@roeck-us.net>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef BCM2835_CPRMAN_H
>> +#define BCM2835_CPRMAN_H
>> +
>> +#include "hw/sysbus.h"
>> +
>> +#define TYPE_BCM2835_CPRMAN "bcm2835-cprman"
>> +#define BCM2835_CPRMAN(obj) \
>> +        OBJECT_CHECK(BCM2835CprmanState, (obj), TYPE_BCM2835_CPRMAN)
>> +
>> +#define CPRMAN_NUM_REGS         (0x1200 / 4)
> 
> I have 64 registers (64-bit wide, see below), so the region is 0x200 B.
> 
>> +
>> +typedef struct {
>> +    SysBusDevice busdev;
>> +    MemoryRegion iomem;
>> +
>> +    uint32_t regs[CPRMAN_NUM_REGS];
> 
> I used uint64_t for registers.
> 
>> +} BCM2835CprmanState;
>> +
>> +#endif
>>
> 
> Regards,
> 
> Phil.
> 
