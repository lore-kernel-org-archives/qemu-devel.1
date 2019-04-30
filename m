Received: from eggs.gnu.org ([209.51.188.92]:49656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLUwJ-0000zB-SN
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLUwI-00033O-At
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:45:03 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLUwI-00032k-3a
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:45:02 -0400
Received: by mail-oi1-x244.google.com with SMTP id v10so11650482oib.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 08:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB02776A12DAB1C4523F67837EDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB02776A12DAB1C4523F67837EDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 16:44:49 +0100
Message-ID: <CAFEAcA_GZKA4STSLGaOqPYBF7Fohj4+8Zf1MqqLmyB76imCtJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 2/5] hw/misc: Add the STM32F4xx
 Sysconfig device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>

On Mon, 29 Apr 2019 at 06:35, Alistair Francis <alistair@alistair23.me> wrote:
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  default-configs/arm-softmmu.mak    |   1 +
>  hw/misc/Kconfig                    |   3 +
>  hw/misc/Makefile.objs              |   1 +
>  hw/misc/stm32f4xx_syscfg.c         | 275 +++++++++++++++++++++++++++++
>  include/hw/misc/stm32f4xx_syscfg.h |  62 +++++++
>  5 files changed, 342 insertions(+)
>  create mode 100644 hw/misc/stm32f4xx_syscfg.c
>  create mode 100644 include/hw/misc/stm32f4xx_syscfg.h

> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/misc/stm32f4xx_syscfg.h"
> +
> +#ifndef STM_SYSCFG_ERR_DEBUG
> +#define STM_SYSCFG_ERR_DEBUG 0
> +#endif
> +
> +#define DB_PRINT_L(lvl, fmt, args...) do { \
> +    if (STM_SYSCFG_ERR_DEBUG >= lvl) { \
> +        qemu_log("%s: " fmt, __func__, ## args); \
> +    } \
> +} while (0)
> +
> +#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)

I think we should prefer to use a tracepoint rather than qemu_log here.

> +
> +static void stm32f4xx_syscfg_reset(DeviceState *dev)
> +{
> +    STM32F4xxSyscfgState *s = STM32F4XX_SYSCFG(dev);
> +
> +    s->syscfg_memrmp = 0x00000000;
> +    s->syscfg_pmc = 0x00000000;
> +    s->syscfg_exticr1 = 0x00000000;
> +    s->syscfg_exticr2 = 0x00000000;
> +    s->syscfg_exticr3 = 0x00000000;
> +    s->syscfg_exticr4 = 0x00000000;
> +    s->syscfg_cmpcr = 0x00000000;
> +}
> +
> +static void stm32f4xx_syscfg_set_irq(void *opaque, int irq, int level)
> +{
> +    STM32F4xxSyscfgState *s = opaque;
> +    uint8_t config;
> +
> +    DB_PRINT("Interupt: GPIO: %d, Line: %d; Level: %d\n", irq / 16,
> +             irq % 16, level);
> +
> +    config = irq / 16;
> +
> +    switch (irq % 16) {
> +    case 0:
> +        if ((s->syscfg_exticr1 & 0xF) == config) {
> +            qemu_set_irq(s->gpio_out[0], level);
> +            DB_PRINT("Pulse EXTI: 0\n");
> +        }
> +        break;
> +    case 1:
> +        if (((s->syscfg_exticr1 & 0xF0) >> 4) == config) {
> +            qemu_set_irq(s->gpio_out[1], level);
> +            DB_PRINT("Pulse EXTI: 1\n");
> +        }
> +        break;

This seems all rather repetitive. If you use an
array syscfg_exticr[] rather than 4 separate fields you
can replace this whole switch with something like:

    int icrreg = irq / 4;
    int startbit = (irq & 3) * 4;
    if (extract32(s->syscfg_exticr[icrreg], startbit, 4) == config) {
       qemu_set_irq(s->gpio_out[irq], level);
       DB_PRINT("Pulse EXTI: %d\n", irq);
    }

> +    case 2:
> +        if (((s->syscfg_exticr1 & 0xF00) >> 8) == config) {
> +            qemu_set_irq(s->gpio_out[2], level);
> +            DB_PRINT("Pulse EXTI: 2\n");
> +        }
> +        break;
> +    case 3:
> +        if (((s->syscfg_exticr1 & 0xF000) >> 12) == config) {
> +            qemu_set_irq(s->gpio_out[3], level);
> +            DB_PRINT("Pulse EXTI: 3\n");
> +        }
> +        break;
> +    case 4:
> +        if ((s->syscfg_exticr2 & 0xF) == config) {
> +            qemu_set_irq(s->gpio_out[4], level);
> +            DB_PRINT("Pulse EXTI: 4\n");
> +        }
> +        break;
> +    case 5:
> +        if (((s->syscfg_exticr2 & 0xF0) >> 4) == config) {
> +            qemu_set_irq(s->gpio_out[5], level);
> +            DB_PRINT("Pulse EXTI: 5\n");
> +        }
> +        break;
> +    case 6:
> +        if (((s->syscfg_exticr2 & 0xF00) >> 8) == config) {
> +            qemu_set_irq(s->gpio_out[6], level);
> +            DB_PRINT("Pulse EXTI: 6\n");
> +        }
> +        break;
> +    case 7:
> +        if (((s->syscfg_exticr2 & 0xF000) >> 12) == config) {
> +            qemu_set_irq(s->gpio_out[7], level);
> +            DB_PRINT("Pulse EXTI: 7\n");
> +        }
> +        break;
> +    case 8:
> +        if ((s->syscfg_exticr3 & 0xF) == config) {
> +            qemu_set_irq(s->gpio_out[8], level);
> +            DB_PRINT("Pulse EXTI: 8\n");
> +        }
> +        break;
> +    case 9:
> +        if (((s->syscfg_exticr3 & 0xF0) >> 4) == config) {
> +            qemu_set_irq(s->gpio_out[9], level);
> +            DB_PRINT("Pulse EXTI: 9\n");
> +        }
> +        break;
> +    case 10:
> +        if (((s->syscfg_exticr3 & 0xF00) >> 8) == config) {
> +            qemu_set_irq(s->gpio_out[10], level);
> +            DB_PRINT("Pulse EXTI: 10\n");
> +        }
> +        break;
> +    case 11:
> +        if (((s->syscfg_exticr3 & 0xF000) >> 12) == config) {
> +            qemu_set_irq(s->gpio_out[11], level);
> +            DB_PRINT("Pulse EXTI: 11\n");
> +        }
> +        break;
> +    case 12:
> +        if ((s->syscfg_exticr4 & 0xF) == config) {
> +            qemu_set_irq(s->gpio_out[12], level);
> +            DB_PRINT("Pulse EXTI: 12\n");
> +        }
> +        break;
> +    case 13:
> +        if (((s->syscfg_exticr4 & 0xF0) >> 4) == config) {
> +            qemu_set_irq(s->gpio_out[13], level);
> +            DB_PRINT("Pulse EXTI: 13\n");
> +        }
> +        break;
> +    case 14:
> +        if (((s->syscfg_exticr4 & 0xF00) >> 8) == config) {
> +            qemu_set_irq(s->gpio_out[14], level);
> +            DB_PRINT("Pulse EXTI: 14\n");
> +        }
> +        break;
> +    case 15:
> +        if (((s->syscfg_exticr4 & 0xF000) >> 12) == config) {
> +            qemu_set_irq(s->gpio_out[15], level);
> +            DB_PRINT("Pulse EXTI: 15\n");
> +        }
> +        break;
> +    }
> +}
> +
> +static uint64_t stm32f4xx_syscfg_read(void *opaque, hwaddr addr,
> +                                     unsigned int size)
> +{
> +    STM32F4xxSyscfgState *s = opaque;
> +
> +    DB_PRINT("0x%"HWADDR_PRIx"\n", addr);
> +
> +    switch (addr) {
> +    case SYSCFG_MEMRMP:
> +        return s->syscfg_memrmp;
> +    case SYSCFG_PMC:
> +        return s->syscfg_pmc;
> +    case SYSCFG_EXTICR1:
> +        return s->syscfg_exticr1;
> +    case SYSCFG_EXTICR2:
> +        return s->syscfg_exticr2;
> +    case SYSCFG_EXTICR3:
> +        return s->syscfg_exticr3;
> +    case SYSCFG_EXTICR4:
> +        return s->syscfg_exticr4;
> +    case SYSCFG_CMPCR:
> +        return s->syscfg_cmpcr;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
> +        return 0;
> +    }
> +
> +    return 0;

This return statement is unreachable.

> +}
> +
> +static void stm32f4xx_syscfg_write(void *opaque, hwaddr addr,
> +                       uint64_t val64, unsigned int size)
> +{
> +    STM32F4xxSyscfgState *s = opaque;
> +    uint32_t value = val64;
> +
> +    DB_PRINT("0x%x, 0x%"HWADDR_PRIx"\n", value, addr);
> +
> +    switch (addr) {
> +    case SYSCFG_MEMRMP:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Changeing the memory mapping isn't supported " \
> +                      "in QEMU\n", __func__);
> +        return;
> +    case SYSCFG_PMC:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Changeing the memory mapping isn't supported " \
> +                      "in QEMU\n", __func__);

"Changing" in both these.

> +        return;
> +    case SYSCFG_EXTICR1:
> +        s->syscfg_exticr1 = (value & 0xFFFF);
> +        return;
> +    case SYSCFG_EXTICR2:
> +        s->syscfg_exticr2 = (value & 0xFFFF);
> +        return;
> +    case SYSCFG_EXTICR3:
> +        s->syscfg_exticr3 = (value & 0xFFFF);
> +        return;
> +    case SYSCFG_EXTICR4:
> +        s->syscfg_exticr4 = (value & 0xFFFF);
> +        return;
> +    case SYSCFG_CMPCR:
> +        s->syscfg_cmpcr = value;
> +        return;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
> +    }
> +}
> +
> +static const MemoryRegionOps stm32f4xx_syscfg_ops = {
> +    .read = stm32f4xx_syscfg_read,
> +    .write = stm32f4xx_syscfg_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void stm32f4xx_syscfg_init(Object *obj)
> +{
> +    STM32F4xxSyscfgState *s = STM32F4XX_SYSCFG(obj);
> +
> +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
> +
> +    memory_region_init_io(&s->mmio, obj, &stm32f4xx_syscfg_ops, s,
> +                          TYPE_STM32F4XX_SYSCFG, 0x400);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +
> +    qdev_init_gpio_in(DEVICE(obj), stm32f4xx_syscfg_set_irq, 16 * 9);
> +    qdev_init_gpio_out(DEVICE(obj), s->gpio_out, 16);
> +}
> +
> +static void stm32f4xx_syscfg_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = stm32f4xx_syscfg_reset;

This is missing the vmstate for migration.

> +}
> +
> +static const TypeInfo stm32f4xx_syscfg_info = {
> +    .name          = TYPE_STM32F4XX_SYSCFG,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(STM32F4xxSyscfgState),
> +    .instance_init = stm32f4xx_syscfg_init,
> +    .class_init    = stm32f4xx_syscfg_class_init,
> +};
> +
> +static void stm32f4xx_syscfg_register_types(void)
> +{
> +    type_register_static(&stm32f4xx_syscfg_info);
> +}

thanks
-- PMM
