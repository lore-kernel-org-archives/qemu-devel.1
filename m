Received: from eggs.gnu.org ([2001:4830:134:3::10]:56649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejVpu-0000JP-QJ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejVpq-0002GM-Rn
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:56:54 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:39177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejVpq-0002G2-Lq
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:56:50 -0500
Received: by mail-qt0-x244.google.com with SMTP id f4so3267749qtj.6
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 11:56:50 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1517955702.git.alistair.francis@xilinx.com>
	<378759b13cf65246de7ce565045f877e4a224aa0.1517955702.git.alistair.francis@xilinx.com>
	<8dead98d-dd14-6019-74f4-fee860b16410@amsat.org>
	<CAKmqyKNobAkr9NNc5rBZC1rsXD=x7F_0UUwQfff7dyHCGAkESQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6984448e-4c83-ccfa-06f7-51dae01cabc0@amsat.org>
Date: Wed, 7 Feb 2018 16:56:46 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNobAkr9NNc5rBZC1rsXD=x7F_0UUwQfff7dyHCGAkESQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/2] timer: Initial commit of
 xlnx-pmu-iomod-pit device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Edgar Iglesias <edgar.iglesias@gmail.com>

On 02/07/2018 04:49 PM, Alistair Francis wrote:
> On Tue, Feb 6, 2018 at 6:18 PM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Hi Alistair,
>>
>> On 02/06/2018 07:23 PM, Alistair Francis wrote:
>>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>>> ---
>>>
>>>  include/hw/timer/xlnx-pmu-iomod-pit.h |  58 ++++++++
>>>  hw/timer/xlnx-pmu-iomod-pit.c         | 241 ++++++++++++++++++++++++++++++++++
>>>  hw/timer/Makefile.objs                |   2 +
>>>  3 files changed, 301 insertions(+)
>>>  create mode 100644 include/hw/timer/xlnx-pmu-iomod-pit.h
>>>  create mode 100644 hw/timer/xlnx-pmu-iomod-pit.c
>>>
>>> diff --git a/include/hw/timer/xlnx-pmu-iomod-pit.h b/include/hw/timer/xlnx-pmu-iomod-pit.h
>>> new file mode 100644
>>> index 0000000000..15f9f0dee5
>>> --- /dev/null
>>> +++ b/include/hw/timer/xlnx-pmu-iomod-pit.h
>>> @@ -0,0 +1,58 @@
>>> +/*
>>> + * QEMU model of Xilinx I/O Module PIT
>>> + *
>>> + * Copyright (c) 2013 Xilinx Inc
>>
>> I'm glad you upstream this :)
>>
>>> + * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>>> + * of this software and associated documentation files (the "Software"), to deal
>>> + * in the Software without restriction, including without limitation the rights
>>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>>> + * copies of the Software, and to permit persons to whom the Software is
>>> + * furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>>> + * THE SOFTWARE.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "hw/ptimer.h"
>>> +
>>> +#define TYPE_XLNX_ZYNQMP_IOMODULE_PIT "xlnx.pmu_iomodule"
>>> +
>>> +#define XLNX_ZYNQMP_IOMODULE_PIT(obj) \
>>> +     OBJECT_CHECK(XlnxPMUPIT, (obj), TYPE_XLNX_ZYNQMP_IOMODULE_PIT)
>>> +
>>> +#define XLNX_ZYNQMP_IOMODULE_PIT_R_MAX (0x08 + 1)
>>
>> I assume this part is generated, removing 'XLNX_' shortens a bit.
> 
> I don't want to remove XLNX_ as this is a public macro. I'll shorten
> the IOMODULE to IOMOD though.

Not sure this is a big win ;)

Just after sending this I realized this tag can be useful for you when
using 'git grep XLNX'

> 
>>
>>> +
>>> +typedef struct XlnxPMUPIT {
>>> +    SysBusDevice parent_obj;
>>> +    MemoryRegion iomem;
>>> +
>>> +    QEMUBH *bh;
>>> +    ptimer_state *ptimer;
>>> +
>>> +    qemu_irq irq;
>>> +    /* IRQ to pulse out when present timer hits zero */
>>> +    qemu_irq hit_out;
>>> +
>>> +    /* Counter in Pre-Scalar(ps) Mode */
>>> +    uint32_t ps_counter;
>>> +    /* ps_mode irq-in to enable/disable pre-scalar */
>>> +    bool ps_enable;
>>> +    /* State var to remember hit_in level */
>>> +    bool ps_level;
>>> +
>>> +    uint32_t frequency;
>>
>> I personally prefer explicit that kind of unit when possible:
>> "frequency_hz".
> 
> Good point, will fix
> 
>>
>>> +
>>> +    uint32_t regs[XLNX_ZYNQMP_IOMODULE_PIT_R_MAX];
>>> +    RegisterInfo regs_info[XLNX_ZYNQMP_IOMODULE_PIT_R_MAX];
>>> +} XlnxPMUPIT;
>>> diff --git a/hw/timer/xlnx-pmu-iomod-pit.c b/hw/timer/xlnx-pmu-iomod-pit.c
>>> new file mode 100644
>>> index 0000000000..cdfef1a440
>>> --- /dev/null
>>> +++ b/hw/timer/xlnx-pmu-iomod-pit.c
>>> @@ -0,0 +1,241 @@
>>> +/*
>>> + * QEMU model of Xilinx I/O Module PIT
>>> + *
>>> + * Copyright (c) 2013 Xilinx Inc
>>> + * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>>> + * of this software and associated documentation files (the "Software"), to deal
>>> + * in the Software without restriction, including without limitation the rights
>>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>>> + * copies of the Software, and to permit persons to whom the Software is
>>> + * furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>>> + * THE SOFTWARE.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "hw/sysbus.h"
>>> +#include "hw/ptimer.h"
>>> +#include "hw/register.h"
>>> +#include "qemu/main-loop.h"
>>> +#include "qemu/log.h"
>>> +#include "qapi/error.h"
>>> +#include "hw/timer/xlnx-pmu-iomod-pit.h"
>>> +
>>> +#ifndef XLNX_ZYNQMP_IOMODULE_PIT_ERR_DEBUG
>>> +#define XLNX_ZYNQMP_IOMODULE_PIT_ERR_DEBUG 0
>>> +#endif
>>> +
>>> +REG32(PIT_PRELOAD, 0x00)
>>> +REG32(PIT_COUNTER, 0x04)
>>> +REG32(PIT_CONTROL, 0x08)
>>> +    FIELD(PIT_CONTROL, PRELOAD, 1, 1)
>>> +    FIELD(PIT_CONTROL, EN, 0, 1)
>>> +
>>> +static uint64_t xlnx_iomod_pit_ctr_pr(RegisterInfo *reg, uint64_t val)
>>> +{
>>> +    XlnxPMUPIT *s = XLNX_ZYNQMP_IOMODULE_PIT(reg->opaque);
>>> +    uint32_t ret;
>>
>> Can you use uint64_t and return explicitly masking with UINT32_MAX?
> 
> Yep
> 
> Alistair
> 
>>
>>> +
>>> +    if (s->ps_enable) {
>>> +        ret = s->ps_counter;
>>> +    } else {
>>> +        ret = ptimer_get_count(s->ptimer);
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static void xlnx_iomod_pit_control_pw(RegisterInfo *reg, uint64_t val)
>>> +{
>>> +    XlnxPMUPIT *s = XLNX_ZYNQMP_IOMODULE_PIT(reg->opaque);
>>> +
>>> +    ptimer_stop(s->ptimer);
>>> +
>>> +    if (val & R_PIT_CONTROL_EN_MASK) {
>>> +        if (s->ps_enable) {
>>> +            /* pre-scalar mode do-Nothing here */
>>> +            s->ps_counter = s->regs[R_PIT_PRELOAD];
>>> +        } else {
>>> +            ptimer_set_limit(s->ptimer, s->regs[R_PIT_PRELOAD], 1);
>>> +            ptimer_run(s->ptimer, !(val & R_PIT_CONTROL_PRELOAD_MASK));
>>> +
>>
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +static const RegisterAccessInfo xlnx_iomod_pit_regs_info[] = {
>>> +    { .name = "PIT_PRELOAD",  .addr = A_PIT_PRELOAD,
>>> +        .ro = 0xffffffff,
>>> +    },{ .name = "PIT_COUNTER",  .addr = A_PIT_COUNTER,
>>> +        .ro = 0xffffffff,
>>> +        .post_read = xlnx_iomod_pit_ctr_pr,
>>> +    },{ .name = "PIT_CONTROL",  .addr = A_PIT_CONTROL,
>>> +        .rsvd = 0xfffffffc,
>>> +        .post_write = xlnx_iomod_pit_control_pw,
>>> +    }
>>> +};
>>> +
>>> +static void xlnx_iomod_pit_timer_hit(void *opaque)
>>> +{
>>> +    XlnxPMUPIT *s = XLNX_ZYNQMP_IOMODULE_PIT(opaque);
>>> +
>>> +    qemu_irq_pulse(s->irq);
>>> +
>>> +    /* hit_out to make another pit move it's counter in pre-scalar mode. */
>>> +    qemu_irq_pulse(s->hit_out);
>>> +}
>>> +
>>> +static void xlnx_iomod_pit_ps_config(void *opaque, int n, int level)
>>> +{
>>> +    XlnxPMUPIT *s = XLNX_ZYNQMP_IOMODULE_PIT(opaque);
>>> +
>>> +    s->ps_enable = level;
>>> +}
>>> +
>>> +static void xlnx_iomod_pit_ps_hit_in(void *opaque, int n, int level)
>>> +{
>>> +    XlnxPMUPIT *s = XLNX_ZYNQMP_IOMODULE_PIT(opaque);
>>> +
>>> +    if (!ARRAY_FIELD_EX32(s->regs, PIT_CONTROL, EN)) {
>>> +        /* PIT disabled */
>>> +        return;
>>> +    }
>>> +
>>> +    /* Count only on positive edge */
>>> +    if (!s->ps_level && level) {
>>> +        if (s->ps_counter) {
>>> +            s->ps_counter--;
>>> +        }
>>> +        s->ps_level = level;
>>> +    } else {
>>> +        /* Not on positive edge */
>>> +        s->ps_level = level;
>>> +        return;
>>> +    }
>>> +
>>> +    /* If timer expires, try to preload or stop */
>>> +    if (s->ps_counter == 0) {
>>> +        xlnx_iomod_pit_timer_hit(opaque);
>>> +
>>> +        /* Check for pit preload/one-shot mode */
>>> +        if (ARRAY_FIELD_EX32(s->regs, PIT_CONTROL, PRELOAD)) {
>>> +            /* Preload Mode, Reload the ps_counter */
>>> +            s->ps_counter = s->regs[R_PIT_PRELOAD];
>>> +        } else {
>>> +            /* One-Shot mode, turn off the timer */
>>> +            s->regs[R_PIT_CONTROL] &= ~R_PIT_CONTROL_PRELOAD_MASK;
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +static void xlnx_iomod_pit_reset(DeviceState *dev)
>>> +{
>>> +    XlnxPMUPIT *s = XLNX_ZYNQMP_IOMODULE_PIT(dev);
>>> +    unsigned int i;
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
>>> +        register_reset(&s->regs_info[i]);
>>> +    }
>>> +
>>> +    s->ps_level = false;
>>> +}
>>> +
>>> +static const MemoryRegionOps xlnx_iomod_pit_ops = {
>>> +    .read = register_read_memory,
>>> +    .write = register_write_memory,
>>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>>> +    .valid = {
>>> +        .min_access_size = 4,
>>> +        .max_access_size = 4,
>>> +    },
>>> +};
>>> +
>>> +static void xlnx_iomod_pit_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    XlnxPMUPIT *s = XLNX_ZYNQMP_IOMODULE_PIT(dev);
>>> +
>>> +    s->bh = qemu_bh_new(xlnx_iomod_pit_timer_hit, s);
>>> +    s->ptimer = ptimer_init(s->bh, PTIMER_POLICY_DEFAULT);
>>> +    ptimer_set_freq(s->ptimer, s->frequency);
>>> +
>>> +    /* IRQ out to pulse when present timer expires/reloads */
>>> +    qdev_init_gpio_out_named(dev, &s->hit_out, "ps_hit_out", 1);
>>> +
>>> +    /* IRQ in to enable pre-scalar mode. Routed from gpo1 */
>>> +    qdev_init_gpio_in_named(dev, xlnx_iomod_pit_ps_config, "ps_config", 1);
>>> +
>>> +    /* hit_out of neighbouring PIT is received as hit_in */
>>> +    qdev_init_gpio_in_named(dev, xlnx_iomod_pit_ps_hit_in, "ps_hit_in", 1);
>>> +}
>>> +
>>> +static void xlnx_iomod_pit_init(Object *obj)
>>> +{
>>> +    XlnxPMUPIT *s = XLNX_ZYNQMP_IOMODULE_PIT(obj);
>>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>>> +    RegisterInfoArray *reg_array;
>>> +
>>> +    memory_region_init(&s->iomem, obj, TYPE_XLNX_ZYNQMP_IOMODULE_PIT,
>>> +                       XLNX_ZYNQMP_IOMODULE_PIT_R_MAX * 4);
>>> +    reg_array =
>>> +        register_init_block32(DEVICE(obj), xlnx_iomod_pit_regs_info,
>>> +                              ARRAY_SIZE(xlnx_iomod_pit_regs_info),
>>> +                              s->regs_info, s->regs,
>>> +                              &xlnx_iomod_pit_ops,
>>> +                              XLNX_ZYNQMP_IOMODULE_PIT_ERR_DEBUG,
>>> +                              XLNX_ZYNQMP_IOMODULE_PIT_R_MAX * 4);
>>> +    memory_region_add_subregion(&s->iomem,
>>> +                                0x0,
>>> +                                &reg_array->mem);
>>> +    sysbus_init_mmio(sbd, &s->iomem);
>>> +    sysbus_init_irq(sbd, &s->irq);
>>> +}
>>> +
>>> +static const VMStateDescription vmstate_xlnx_iomod_pit = {
>>> +    .name = TYPE_XLNX_ZYNQMP_IOMODULE_PIT,
>>> +    .version_id = 1,
>>> +    .minimum_version_id = 1,
>>> +    .fields = (VMStateField[]) {
>>> +        VMSTATE_END_OF_LIST(),
>>> +    }
>>> +};
>>> +
>>> +static Property xlnx_iomod_pit_properties[] = {
>>> +    DEFINE_PROP_UINT32("frequency", XlnxPMUPIT, frequency, 66000000),
>>> +    DEFINE_PROP_END_OF_LIST(),
>>> +};
>>> +
>>> +static void xlnx_iomod_pit_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>> +
>>> +    dc->reset = xlnx_iomod_pit_reset;
>>> +    dc->realize = xlnx_iomod_pit_realize;
>>> +    dc->props = xlnx_iomod_pit_properties;
>>> +    dc->vmsd = &vmstate_xlnx_iomod_pit;
>>> +}
>>> +
>>> +static const TypeInfo xlnx_iomod_pit_info = {
>>> +    .name          = TYPE_XLNX_ZYNQMP_IOMODULE_PIT,
>>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>>> +    .instance_size = sizeof(XlnxPMUPIT),
>>> +    .class_init    = xlnx_iomod_pit_class_init,
>>> +    .instance_init = xlnx_iomod_pit_init,
>>> +};
>>> +
>>> +static void xlnx_iomod_pit_register_types(void)
>>> +{
>>> +    type_register_static(&xlnx_iomod_pit_info);
>>> +}
>>> +
>>> +type_init(xlnx_iomod_pit_register_types)
>>> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
>>> index 8c19eac3b6..805c480cad 100644
>>> --- a/hw/timer/Makefile.objs
>>> +++ b/hw/timer/Makefile.objs
>>> @@ -43,3 +43,5 @@ common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o
>>>  common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
>>>  common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
>>>  common-obj-$(CONFIG_MSF2) += mss-timer.o
>>> +
>>> +common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-pmu-iomod-pit.o
>>>
>>
>> Patch looks good to me but I'm not confident with ptimers to add a R-b.
>>
>> Regards,
>>
>> Phil.
