Received: from eggs.gnu.org ([2001:4830:134:3::10]:51892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPT9E-0007jb-Ge
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 06:57:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPT9C-0001HJ-MA
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 06:57:28 -0500
Received: from mail-ua0-x22c.google.com ([2607:f8b0:400c:c08::22c]:34948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPT9C-0001G1-GO
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 06:57:26 -0500
Received: by mail-ua0-x22c.google.com with SMTP id y9so73772815uae.2
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 03:57:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b985247bfcb7375de984e801c4145fde931360bb.1482265908.git.alistair.francis@xilinx.com>
References: <cover.1482265908.git.alistair.francis@xilinx.com>
	<b985247bfcb7375de984e801c4145fde931360bb.1482265908.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 11:57:05 +0000
Message-ID: <CAFEAcA88=_J3==CJ3fy+jurM9APvRErYFhopuz-bJeML5mPSvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 1/3] arm_generic_timer: Add the ARM
 Generic Timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alistair Francis <alistair23@gmail.com>

On 20 December 2016 at 22:42, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> Add the ARM generic timer. This allows the guest to poll the timer for
> values and also supports secure writes only.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> V3:
>  - Use ARM ARM names
>  - Indicate that we don't support all of the registers
>  - Fixup the Makefile CONFIG
> V2:
>  - Fix couter/counter typo
>
>  hw/timer/Makefile.objs               |   1 +
>  hw/timer/arm_generic_timer.c         | 205 +++++++++++++++++++++++++++++++++++
>  include/hw/timer/arm_generic_timer.h |  62 +++++++++++
>  3 files changed, 268 insertions(+)
>  create mode 100644 hw/timer/arm_generic_timer.c
>  create mode 100644 include/hw/timer/arm_generic_timer.h
>
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 7ba8c23..bb203e2 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -17,6 +17,7 @@ common-obj-$(CONFIG_IMX) += imx_epit.o
>  common-obj-$(CONFIG_IMX) += imx_gpt.o
>  common-obj-$(CONFIG_LM32) += lm32_timer.o
>  common-obj-$(CONFIG_MILKYMIST) += milkymist-sysctl.o
> +common-obj-$(CONFIG_ARM_TIMER) += arm_generic_timer.o
>
>  obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
>  obj-$(CONFIG_EXYNOS4) += exynos4210_pwm.o
> diff --git a/hw/timer/arm_generic_timer.c b/hw/timer/arm_generic_timer.c
> new file mode 100644
> index 0000000..da434a7
> --- /dev/null
> +++ b/hw/timer/arm_generic_timer.c
> @@ -0,0 +1,205 @@
> +/*
> + * QEMU model of the ARM Generic Timer
> + *
> + * Copyright (c) 2016 Xilinx Inc.
> + * Written by Alistair Francis <alistair.francis@xilinx.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/timer/arm_generic_timer.h"
> +#include "qemu/timer.h"
> +#include "qemu/log.h"
> +
> +#ifndef ARM_GEN_TIMER_ERR_DEBUG
> +#define ARM_GEN_TIMER_ERR_DEBUG 0
> +#endif
> +
> +static void counter_control_postw(RegisterInfo *reg, uint64_t val64)
> +{
> +    ARMGenTimer *s = ARM_GEN_TIMER(reg->opaque);
> +    bool new_status = extract32(s->regs[R_CNTCR],
> +                                R_CNTCR_EN_SHIFT,
> +                                R_CNTCR_EN_LENGTH);
> +    uint64_t current_ticks;
> +
> +    current_ticks = muldiv64(qemu_clock_get_us(QEMU_CLOCK_VIRTUAL),
> +                             NANOSECONDS_PER_SECOND, 1000000);
> +
> +    if ((s->enabled && !new_status) ||
> +        (!s->enabled && new_status)) {

Since s->enabled and new_status are both bool, you can
write this as "if (s->enabled != new_status)".
(If they were ints you could use xor.)

> +        /* The timer is being disabled or enabled */
> +        s->tick_offset = current_ticks - s->tick_offset;
> +    }
> +
> +    s->enabled = new_status;
> +}
> +
> +static uint64_t counter_value_postr(RegisterInfo *reg)
> +{
> +    ARMGenTimer *s = ARM_GEN_TIMER(reg->opaque);
> +    uint64_t current_ticks, total_ticks;
> +
> +    if (s->enabled) {
> +        current_ticks = muldiv64(qemu_clock_get_us(QEMU_CLOCK_VIRTUAL),
> +                                 NANOSECONDS_PER_SECOND, 1000000);
> +        total_ticks = current_ticks - s->tick_offset;
> +    } else {
> +        /* Timer is disabled, return the time when it was disabled */
> +        total_ticks = s->tick_offset;
> +    }
> +
> +    return total_ticks;
> +}
> +
> +static uint64_t counter_low_value_postr(RegisterInfo *reg, uint64_t val64)
> +{
> +    return (uint32_t) counter_value_postr(reg);
> +}
> +
> +static uint64_t counter_high_value_postr(RegisterInfo *reg, uint64_t val64)
> +{
> +    return (uint32_t) (counter_value_postr(reg) >> 32);
> +}

The spec says that a write to the CNTCV should cause changes
to each CPU's CNTPCT/CNTPCT_EL0 register -- how do we plan to implement this?

(v8 ARM ARM section D6.1 is the clearest description of the
relationship between the system counter and the per-CPU timers.)

> +
> +static RegisterAccessInfo arm_gen_timer_regs_info[] = {
> +    {   .name = "CNTCR",
> +        .addr = A_CNTCR,
> +        .rsvd = 0xfffffffc,

Spec says bits [17:8] are FCREQ field ?

> +        .post_write = counter_control_postw,
> +    },{ .name = "CNTSR",
> +        .addr = A_CNTSR,
> +        .rsvd = 0xfffffffd, .ro = 0x2,

Spec says bits [31:8] are FCACK ?

> +    },{ .name = "CNTCV_LOWER",
> +        .addr = A_CNTCV_LOWER,
> +        .post_read = counter_low_value_postr,
> +    },{ .name = "CNTCV_UPPER",
> +        .addr = A_CNTCV_UPPER,
> +        .post_read = counter_high_value_postr,

Spec says that you should also be able to access the whole
64-bit counter value with a 64-bit access -- is this reginfo
sufficient to make that work?

> +    },{ .name = "CNTFID0",
> +        .addr = A_CNTFID0,
> +    }
> +    /* We don't model CNTFIDn */
> +    /* We don't model the CounterID registers either */
> +};
> +
> +static void arm_gen_timer_reset(DeviceState *dev)
> +{
> +    ARMGenTimer *s = ARM_GEN_TIMER(dev);
> +    unsigned int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
> +        register_reset(&s->regs_info[i]);
> +    }
> +
> +    s->tick_offset = 0;
> +    s->enabled = false;
> +}
> +
> +static MemTxResult arm_gen_timer_read(void *opaque,  hwaddr addr,
> +                                      uint64_t *data, unsigned size,
> +                                      MemTxAttrs attrs)
> +{
> +    /* Reads are always supported, just blindly pass them through */
> +    *data = register_read_memory(opaque, addr, size);
> +
> +    return MEMTX_OK;
> +}
> +
> +static MemTxResult arm_gen_timer_write(void *opaque, hwaddr addr,
> +                                       uint64_t data, unsigned size,
> +                                       MemTxAttrs attrs)
> +{
> +    /* Block insecure writes */
> +    if (!attrs.secure) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Non secure writes to the system timestamp generator " \
> +                      "are invalid\n");
> +        return MEMTX_ERROR;
> +    }

This means you can't use this device in a system which
doesn't implement TrustZone. I think this would be better
handled by just having the board map the memory region
in to only the Secure address space if it is a TZ-aware board.

This also gets handling of NS reads correct (your code
allows them).

> +
> +    register_write_memory(opaque, addr, data, size);
> +
> +    return MEMTX_OK;
> +}
> +
> +static const MemoryRegionOps arm_gen_timer_ops = {
> +    .read_with_attrs = arm_gen_timer_read,
> +    .write_with_attrs = arm_gen_timer_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,

64-bit access is needed for the CNTCV.

> +    },
> +};
> +
> +static const VMStateDescription vmstate_arm_gen_timer = {
> +    .name = TYPE_ARM_GEN_TIMER,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, ARMGenTimer, R_ARM_GEN_TIMER_MAX),
> +        VMSTATE_END_OF_LIST(),
> +    }
> +};
> +
> +static void arm_gen_timer_init(Object *obj)
> +{
> +    ARMGenTimer *s = ARM_GEN_TIMER(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    RegisterInfoArray *reg_array;
> +
> +    memory_region_init_io(&s->iomem, obj, &arm_gen_timer_ops, s,
> +                          TYPE_ARM_GEN_TIMER, R_ARM_GEN_TIMER_MAX * 4);
> +    reg_array =
> +        register_init_block32(DEVICE(obj), arm_gen_timer_regs_info,
> +                              ARRAY_SIZE(arm_gen_timer_regs_info),
> +                              s->regs_info, s->regs,
> +                              &arm_gen_timer_ops,
> +                              ARM_GEN_TIMER_ERR_DEBUG,
> +                              R_ARM_GEN_TIMER_MAX * 4);
> +    memory_region_add_subregion(&s->iomem,
> +                                A_CNTCR,
> +                                &reg_array->mem);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static void arm_gen_timer_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = arm_gen_timer_reset;
> +    dc->vmsd = &vmstate_arm_gen_timer;
> +}
> +
> +static const TypeInfo arm_gen_timer_info = {
> +    .name          = TYPE_ARM_GEN_TIMER,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(ARMGenTimer),
> +    .class_init    = arm_gen_timer_class_init,
> +    .instance_init = arm_gen_timer_init,
> +};
> +
> +static void arm_gen_timer_register_types(void)
> +{
> +    type_register_static(&arm_gen_timer_info);
> +}
> +
> +type_init(arm_gen_timer_register_types)
> diff --git a/include/hw/timer/arm_generic_timer.h b/include/hw/timer/arm_generic_timer.h
> new file mode 100644
> index 0000000..ae4319c
> --- /dev/null
> +++ b/include/hw/timer/arm_generic_timer.h
> @@ -0,0 +1,62 @@
> +/*
> + * QEMU model of the ARM Generic Timer
> + *
> + * Copyright (c) 2016 Xilinx Inc.
> + * Written by Alistair Francis <alistair.francis@xilinx.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef ARM_GEN_TIMER_H
> +#define ARM_GEN_TIMER_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/register.h"
> +
> +#define TYPE_ARM_GEN_TIMER "arm.generic-timer"
> +#define ARM_GEN_TIMER(obj) \
> +            OBJECT_CHECK(ARMGenTimer, (obj), TYPE_ARM_GEN_TIMER)
> +
> +REG32(CNTCR, 0x00)
> +    FIELD(CNTCR, EN, 0, 1)
> +    FIELD(CNTCR, HDBG, 1, 1)
> +REG32(CNTSR, 0x04)
> +    FIELD(CNTSR, DBGH, 1, 1)
> +REG32(CNTCV_LOWER, 0x08)
> +REG32(CNTCV_UPPER, 0x0C)
> +REG32(CNTFID0, 0x20)
> +/* We don't model CNTFIDn */
> +/* We don't model the CounterID registers either */

Does the Xilinx h/w not implement them at all?
(ie do we need a property for "device has the ID regs" if we add them
later?)

The spec says it's mandatory to have at least the entry for
the counter base frequency plus end-of-table marker.
I would expect EL3 firmware to want to read this table in order
to write the correct values to CNTFRQ_EL0 for each CPU.

> +
> +#define R_ARM_GEN_TIMER_MAX (R_CNTFID0 + 1)
> +
> +typedef struct ARMGenTimer {
> +    /* <private> */
> +    SysBusDevice parent_obj;
> +    MemoryRegion iomem;
> +
> +    /* <public> */
> +    bool enabled;
> +    uint64_t tick_offset;
> +
> +    uint32_t regs[R_ARM_GEN_TIMER_MAX];
> +    RegisterInfo regs_info[R_ARM_GEN_TIMER_MAX];
> +} ARMGenTimer;
> +
> +#endif
> --
> 2.7.4
>

thanks
-- PMM
