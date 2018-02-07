Received: from eggs.gnu.org ([2001:4830:134:3::10]:54588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ejVj6-0003LH-7z
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ejVj4-0002PO-Gk
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:49:52 -0500
Received: from mail-lf0-x22f.google.com ([2a00:1450:4010:c07::22f]:34796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ejVj4-0002NB-4a
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:49:50 -0500
Received: by mail-lf0-x22f.google.com with SMTP id k19so3073794lfj.1
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 11:49:49 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <8dead98d-dd14-6019-74f4-fee860b16410@amsat.org>
References: <cover.1517955702.git.alistair.francis@xilinx.com>
	<378759b13cf65246de7ce565045f877e4a224aa0.1517955702.git.alistair.francis@xilinx.com>
	<8dead98d-dd14-6019-74f4-fee860b16410@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 7 Feb 2018 11:49:17 -0800
Message-ID: <CAKmqyKNobAkr9NNc5rBZC1rsXD=x7F_0UUwQfff7dyHCGAkESQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Edgar Iglesias <edgar.iglesias@gmail.com>

On Tue, Feb 6, 2018 at 6:18 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Hi Alistair,
>
> On 02/06/2018 07:23 PM, Alistair Francis wrote:
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>  include/hw/timer/xlnx-pmu-iomod-pit.h |  58 ++++++++
>>  hw/timer/xlnx-pmu-iomod-pit.c         | 241 +++++++++++++++++++++++++++=
+++++++
>>  hw/timer/Makefile.objs                |   2 +
>>  3 files changed, 301 insertions(+)
>>  create mode 100644 include/hw/timer/xlnx-pmu-iomod-pit.h
>>  create mode 100644 hw/timer/xlnx-pmu-iomod-pit.c
>>
>> diff --git a/include/hw/timer/xlnx-pmu-iomod-pit.h b/include/hw/timer/xl=
nx-pmu-iomod-pit.h
>> new file mode 100644
>> index 0000000000..15f9f0dee5
>> --- /dev/null
>> +++ b/include/hw/timer/xlnx-pmu-iomod-pit.h
>> @@ -0,0 +1,58 @@
>> +/*
>> + * QEMU model of Xilinx I/O Module PIT
>> + *
>> + * Copyright (c) 2013 Xilinx Inc
>
> I'm glad you upstream this :)
>
>> + * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtainin=
g a copy
>> + * of this software and associated documentation files (the "Software")=
, to deal
>> + * in the Software without restriction, including without limitation th=
e rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or=
 sell
>> + * copies of the Software, and to permit persons to whom the Software i=
s
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be inclu=
ded in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPR=
ESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL=
ITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SH=
ALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR=
 OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARIS=
ING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALIN=
GS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/ptimer.h"
>> +
>> +#define TYPE_XLNX_ZYNQMP_IOMODULE_PIT "xlnx.pmu_iomodule"
>> +
>> +#define XLNX_ZYNQMP_IOMODULE_PIT(obj) \
>> +     OBJECT_CHECK(XlnxPMUPIT, (obj), TYPE_XLNX_ZYNQMP_IOMODULE_PIT)
>> +
>> +#define XLNX_ZYNQMP_IOMODULE_PIT_R_MAX (0x08 + 1)
>
> I assume this part is generated, removing 'XLNX_' shortens a bit.

I don't want to remove XLNX_ as this is a public macro. I'll shorten
the IOMODULE to IOMOD though.

>
>> +
>> +typedef struct XlnxPMUPIT {
>> +    SysBusDevice parent_obj;
>> +    MemoryRegion iomem;
>> +
>> +    QEMUBH *bh;
>> +    ptimer_state *ptimer;
>> +
>> +    qemu_irq irq;
>> +    /* IRQ to pulse out when present timer hits zero */
>> +    qemu_irq hit_out;
>> +
>> +    /* Counter in Pre-Scalar(ps) Mode */
>> +    uint32_t ps_counter;
>> +    /* ps_mode irq-in to enable/disable pre-scalar */
>> +    bool ps_enable;
>> +    /* State var to remember hit_in level */
>> +    bool ps_level;
>> +
>> +    uint32_t frequency;
>
> I personally prefer explicit that kind of unit when possible:
> "frequency_hz".

Good point, will fix

>
>> +
>> +    uint32_t regs[XLNX_ZYNQMP_IOMODULE_PIT_R_MAX];
>> +    RegisterInfo regs_info[XLNX_ZYNQMP_IOMODULE_PIT_R_MAX];
>> +} XlnxPMUPIT;
>> diff --git a/hw/timer/xlnx-pmu-iomod-pit.c b/hw/timer/xlnx-pmu-iomod-pit=
.c
>> new file mode 100644
>> index 0000000000..cdfef1a440
>> --- /dev/null
>> +++ b/hw/timer/xlnx-pmu-iomod-pit.c
>> @@ -0,0 +1,241 @@
>> +/*
>> + * QEMU model of Xilinx I/O Module PIT
>> + *
>> + * Copyright (c) 2013 Xilinx Inc
>> + * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtainin=
g a copy
>> + * of this software and associated documentation files (the "Software")=
, to deal
>> + * in the Software without restriction, including without limitation th=
e rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or=
 sell
>> + * copies of the Software, and to permit persons to whom the Software i=
s
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be inclu=
ded in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPR=
ESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL=
ITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SH=
ALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR=
 OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARIS=
ING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALIN=
GS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/ptimer.h"
>> +#include "hw/register.h"
>> +#include "qemu/main-loop.h"
>> +#include "qemu/log.h"
>> +#include "qapi/error.h"
>> +#include "hw/timer/xlnx-pmu-iomod-pit.h"
>> +
>> +#ifndef XLNX_ZYNQMP_IOMODULE_PIT_ERR_DEBUG
>> +#define XLNX_ZYNQMP_IOMODULE_PIT_ERR_DEBUG 0
>> +#endif
>> +
>> +REG32(PIT_PRELOAD, 0x00)
>> +REG32(PIT_COUNTER, 0x04)
>> +REG32(PIT_CONTROL, 0x08)
>> +    FIELD(PIT_CONTROL, PRELOAD, 1, 1)
>> +    FIELD(PIT_CONTROL, EN, 0, 1)
>> +
>> +static uint64_t xlnx_iomod_pit_ctr_pr(RegisterInfo *reg, uint64_t val)
>> +{
>> +    XlnxPMUPIT *s =3D XLNX_ZYNQMP_IOMODULE_PIT(reg->opaque);
>> +    uint32_t ret;
>
> Can you use uint64_t and return explicitly masking with UINT32_MAX?

Yep

Alistair

>
>> +
>> +    if (s->ps_enable) {
>> +        ret =3D s->ps_counter;
>> +    } else {
>> +        ret =3D ptimer_get_count(s->ptimer);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static void xlnx_iomod_pit_control_pw(RegisterInfo *reg, uint64_t val)
>> +{
>> +    XlnxPMUPIT *s =3D XLNX_ZYNQMP_IOMODULE_PIT(reg->opaque);
>> +
>> +    ptimer_stop(s->ptimer);
>> +
>> +    if (val & R_PIT_CONTROL_EN_MASK) {
>> +        if (s->ps_enable) {
>> +            /* pre-scalar mode do-Nothing here */
>> +            s->ps_counter =3D s->regs[R_PIT_PRELOAD];
>> +        } else {
>> +            ptimer_set_limit(s->ptimer, s->regs[R_PIT_PRELOAD], 1);
>> +            ptimer_run(s->ptimer, !(val & R_PIT_CONTROL_PRELOAD_MASK));
>> +
>
>> +        }
>> +    }
>> +}
>> +
>> +static const RegisterAccessInfo xlnx_iomod_pit_regs_info[] =3D {
>> +    { .name =3D "PIT_PRELOAD",  .addr =3D A_PIT_PRELOAD,
>> +        .ro =3D 0xffffffff,
>> +    },{ .name =3D "PIT_COUNTER",  .addr =3D A_PIT_COUNTER,
>> +        .ro =3D 0xffffffff,
>> +        .post_read =3D xlnx_iomod_pit_ctr_pr,
>> +    },{ .name =3D "PIT_CONTROL",  .addr =3D A_PIT_CONTROL,
>> +        .rsvd =3D 0xfffffffc,
>> +        .post_write =3D xlnx_iomod_pit_control_pw,
>> +    }
>> +};
>> +
>> +static void xlnx_iomod_pit_timer_hit(void *opaque)
>> +{
>> +    XlnxPMUPIT *s =3D XLNX_ZYNQMP_IOMODULE_PIT(opaque);
>> +
>> +    qemu_irq_pulse(s->irq);
>> +
>> +    /* hit_out to make another pit move it's counter in pre-scalar mode=
. */
>> +    qemu_irq_pulse(s->hit_out);
>> +}
>> +
>> +static void xlnx_iomod_pit_ps_config(void *opaque, int n, int level)
>> +{
>> +    XlnxPMUPIT *s =3D XLNX_ZYNQMP_IOMODULE_PIT(opaque);
>> +
>> +    s->ps_enable =3D level;
>> +}
>> +
>> +static void xlnx_iomod_pit_ps_hit_in(void *opaque, int n, int level)
>> +{
>> +    XlnxPMUPIT *s =3D XLNX_ZYNQMP_IOMODULE_PIT(opaque);
>> +
>> +    if (!ARRAY_FIELD_EX32(s->regs, PIT_CONTROL, EN)) {
>> +        /* PIT disabled */
>> +        return;
>> +    }
>> +
>> +    /* Count only on positive edge */
>> +    if (!s->ps_level && level) {
>> +        if (s->ps_counter) {
>> +            s->ps_counter--;
>> +        }
>> +        s->ps_level =3D level;
>> +    } else {
>> +        /* Not on positive edge */
>> +        s->ps_level =3D level;
>> +        return;
>> +    }
>> +
>> +    /* If timer expires, try to preload or stop */
>> +    if (s->ps_counter =3D=3D 0) {
>> +        xlnx_iomod_pit_timer_hit(opaque);
>> +
>> +        /* Check for pit preload/one-shot mode */
>> +        if (ARRAY_FIELD_EX32(s->regs, PIT_CONTROL, PRELOAD)) {
>> +            /* Preload Mode, Reload the ps_counter */
>> +            s->ps_counter =3D s->regs[R_PIT_PRELOAD];
>> +        } else {
>> +            /* One-Shot mode, turn off the timer */
>> +            s->regs[R_PIT_CONTROL] &=3D ~R_PIT_CONTROL_PRELOAD_MASK;
>> +        }
>> +    }
>> +}
>> +
>> +static void xlnx_iomod_pit_reset(DeviceState *dev)
>> +{
>> +    XlnxPMUPIT *s =3D XLNX_ZYNQMP_IOMODULE_PIT(dev);
>> +    unsigned int i;
>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(s->regs_info); ++i) {
>> +        register_reset(&s->regs_info[i]);
>> +    }
>> +
>> +    s->ps_level =3D false;
>> +}
>> +
>> +static const MemoryRegionOps xlnx_iomod_pit_ops =3D {
>> +    .read =3D register_read_memory,
>> +    .write =3D register_write_memory,
>> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>> +    .valid =3D {
>> +        .min_access_size =3D 4,
>> +        .max_access_size =3D 4,
>> +    },
>> +};
>> +
>> +static void xlnx_iomod_pit_realize(DeviceState *dev, Error **errp)
>> +{
>> +    XlnxPMUPIT *s =3D XLNX_ZYNQMP_IOMODULE_PIT(dev);
>> +
>> +    s->bh =3D qemu_bh_new(xlnx_iomod_pit_timer_hit, s);
>> +    s->ptimer =3D ptimer_init(s->bh, PTIMER_POLICY_DEFAULT);
>> +    ptimer_set_freq(s->ptimer, s->frequency);
>> +
>> +    /* IRQ out to pulse when present timer expires/reloads */
>> +    qdev_init_gpio_out_named(dev, &s->hit_out, "ps_hit_out", 1);
>> +
>> +    /* IRQ in to enable pre-scalar mode. Routed from gpo1 */
>> +    qdev_init_gpio_in_named(dev, xlnx_iomod_pit_ps_config, "ps_config",=
 1);
>> +
>> +    /* hit_out of neighbouring PIT is received as hit_in */
>> +    qdev_init_gpio_in_named(dev, xlnx_iomod_pit_ps_hit_in, "ps_hit_in",=
 1);
>> +}
>> +
>> +static void xlnx_iomod_pit_init(Object *obj)
>> +{
>> +    XlnxPMUPIT *s =3D XLNX_ZYNQMP_IOMODULE_PIT(obj);
>> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>> +    RegisterInfoArray *reg_array;
>> +
>> +    memory_region_init(&s->iomem, obj, TYPE_XLNX_ZYNQMP_IOMODULE_PIT,
>> +                       XLNX_ZYNQMP_IOMODULE_PIT_R_MAX * 4);
>> +    reg_array =3D
>> +        register_init_block32(DEVICE(obj), xlnx_iomod_pit_regs_info,
>> +                              ARRAY_SIZE(xlnx_iomod_pit_regs_info),
>> +                              s->regs_info, s->regs,
>> +                              &xlnx_iomod_pit_ops,
>> +                              XLNX_ZYNQMP_IOMODULE_PIT_ERR_DEBUG,
>> +                              XLNX_ZYNQMP_IOMODULE_PIT_R_MAX * 4);
>> +    memory_region_add_subregion(&s->iomem,
>> +                                0x0,
>> +                                &reg_array->mem);
>> +    sysbus_init_mmio(sbd, &s->iomem);
>> +    sysbus_init_irq(sbd, &s->irq);
>> +}
>> +
>> +static const VMStateDescription vmstate_xlnx_iomod_pit =3D {
>> +    .name =3D TYPE_XLNX_ZYNQMP_IOMODULE_PIT,
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_END_OF_LIST(),
>> +    }
>> +};
>> +
>> +static Property xlnx_iomod_pit_properties[] =3D {
>> +    DEFINE_PROP_UINT32("frequency", XlnxPMUPIT, frequency, 66000000),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void xlnx_iomod_pit_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->reset =3D xlnx_iomod_pit_reset;
>> +    dc->realize =3D xlnx_iomod_pit_realize;
>> +    dc->props =3D xlnx_iomod_pit_properties;
>> +    dc->vmsd =3D &vmstate_xlnx_iomod_pit;
>> +}
>> +
>> +static const TypeInfo xlnx_iomod_pit_info =3D {
>> +    .name          =3D TYPE_XLNX_ZYNQMP_IOMODULE_PIT,
>> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(XlnxPMUPIT),
>> +    .class_init    =3D xlnx_iomod_pit_class_init,
>> +    .instance_init =3D xlnx_iomod_pit_init,
>> +};
>> +
>> +static void xlnx_iomod_pit_register_types(void)
>> +{
>> +    type_register_static(&xlnx_iomod_pit_info);
>> +}
>> +
>> +type_init(xlnx_iomod_pit_register_types)
>> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
>> index 8c19eac3b6..805c480cad 100644
>> --- a/hw/timer/Makefile.objs
>> +++ b/hw/timer/Makefile.objs
>> @@ -43,3 +43,5 @@ common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o
>>  common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
>>  common-obj-$(CONFIG_CMSDK_APB_TIMER) +=3D cmsdk-apb-timer.o
>>  common-obj-$(CONFIG_MSF2) +=3D mss-timer.o
>> +
>> +common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-pmu-iomod-pit.o
>>
>
> Patch looks good to me but I'm not confident with ptimers to add a R-b.
>
> Regards,
>
> Phil.
