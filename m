Received: from eggs.gnu.org ([2001:4830:134:3::10]:40132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fERZX-0005XB-N6
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fERZV-0001HO-LT
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:39:51 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fERZV-0001GK-8q
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:39:49 -0400
Received: by mail-lf0-f67.google.com with SMTP id b23-v6so28925816lfg.4
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 20:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1519856998.git.alistair.francis@xilinx.com>
	<000b7176df121bd34c3329c45b93dc79d5f4f3ff.1519856998.git.alistair.francis@xilinx.com>
	<a7c53011-5689-3cbf-09e1-ee466511467d@amsat.org>
In-Reply-To: <a7c53011-5689-3cbf-09e1-ee466511467d@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 04 May 2018 03:39:21 +0000
Message-ID: <CAKmqyKM=LELWW9DrQRhqsBeURA3g8acoRVfBLsN-HUx0Ku1TpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/5] timer: Initial commit of
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

On Thu, Mar 1, 2018 at 10:21 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> On 02/28/2018 07:31 PM, Alistair Francis wrote:
> > Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> > ---
> > V2:
> >  - Use UINT32_MAX and uint64_t in xlnx_iomod_pit_ctr_pr()
> >  - Name frequency varaible frequency_hz
> >  - Shorten R_MAX #define
> >
> >  include/hw/timer/xlnx-pmu-iomod-pit.h |  58 ++++++++
> >  hw/timer/xlnx-pmu-iomod-pit.c         | 241
++++++++++++++++++++++++++++++++++
> >  hw/timer/Makefile.objs                |   2 +
> >  3 files changed, 301 insertions(+)
> >  create mode 100644 include/hw/timer/xlnx-pmu-iomod-pit.h
> >  create mode 100644 hw/timer/xlnx-pmu-iomod-pit.c
> >
> > diff --git a/include/hw/timer/xlnx-pmu-iomod-pit.h
b/include/hw/timer/xlnx-pmu-iomod-pit.h
> > new file mode 100644
> > index 0000000000..75cac6bedd
> > --- /dev/null
> > +++ b/include/hw/timer/xlnx-pmu-iomod-pit.h
> > @@ -0,0 +1,58 @@
> > +/*
> > + * QEMU model of Xilinx I/O Module PIT
> > + *
> > + * Copyright (c) 2013 Xilinx Inc
> > + * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > + *
> > + * Permission is hereby granted, free of charge, to any person
obtaining a copy
> > + * of this software and associated documentation files (the
"Software"), to deal
> > + * in the Software without restriction, including without limitation
the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell
> > + * copies of the Software, and to permit persons to whom the Software
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/ptimer.h"
> > +
> > +#define TYPE_XLNX_ZYNQMP_IOMODULE_PIT "xlnx.pmu_iomodule_pit"
> > +
> > +#define XLNX_ZYNQMP_IOMODULE_PIT(obj) \
> > +     OBJECT_CHECK(XlnxPMUPIT, (obj), TYPE_XLNX_ZYNQMP_IOMODULE_PIT)
> > +
> > +#define XLNX_ZYNQMP_IOMOD_PIT_R_MAX (0x08 + 1)

> 0x04?

No, 0x08 is right.


> > +
> > +typedef struct XlnxPMUPIT {
> > +    SysBusDevice parent_obj;
> > +    MemoryRegion iomem;
> > +
> > +    QEMUBH *bh;
> > +    ptimer_state *ptimer;
> > +
> > +    qemu_irq irq;
> > +    /* IRQ to pulse out when present timer hits zero */
> > +    qemu_irq hit_out;
> > +
> > +    /* Counter in Pre-Scalar(ps) Mode */
> > +    uint32_t ps_counter;
> > +    /* ps_mode irq-in to enable/disable pre-scalar */
> > +    bool ps_enable;
> > +    /* State var to remember hit_in level */
> > +    bool ps_level;
> > +
> > +    uint32_t frequency_hz;
> > +
> > +    uint32_t regs[XLNX_ZYNQMP_IOMOD_PIT_R_MAX];
> > +    RegisterInfo regs_info[XLNX_ZYNQMP_IOMOD_PIT_R_MAX];
> > +} XlnxPMUPIT;
> > diff --git a/hw/timer/xlnx-pmu-iomod-pit.c
b/hw/timer/xlnx-pmu-iomod-pit.c
> > new file mode 100644
> > index 0000000000..a6bdc5211d
> > --- /dev/null
> > +++ b/hw/timer/xlnx-pmu-iomod-pit.c
> > @@ -0,0 +1,241 @@
> > +/*
> > + * QEMU model of Xilinx I/O Module PIT
> > + *
> > + * Copyright (c) 2013 Xilinx Inc
> > + * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > + *
> > + * Permission is hereby granted, free of charge, to any person
obtaining a copy
> > + * of this software and associated documentation files (the
"Software"), to deal
> > + * in the Software without restriction, including without limitation
the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell
> > + * copies of the Software, and to permit persons to whom the Software
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/sysbus.h"
> > +#include "hw/ptimer.h"
> > +#include "hw/register.h"
> > +#include "qemu/main-loop.h"
> > +#include "qemu/log.h"
> > +#include "qapi/error.h"
> > +#include "hw/timer/xlnx-pmu-iomod-pit.h"
> > +
> > +#ifndef XLNX_ZYNQMP_IOMODULE_PIT_ERR_DEBUG
> > +#define XLNX_ZYNQMP_IOMODULE_PIT_ERR_DEBUG 0
> > +#endif
> > +
> > +REG32(PIT_PRELOAD, 0x00)
> > +REG32(PIT_COUNTER, 0x04)
> > +REG32(PIT_CONTROL, 0x08)
> > +    FIELD(PIT_CONTROL, PRELOAD, 1, 1)
> > +    FIELD(PIT_CONTROL, EN, 0, 1)
> > +
> > +static uint64_t xlnx_iomod_pit_ctr_pr(RegisterInfo *reg, uint64_t val)
> > +{
> > +    XlnxPMUPIT *s =3D XLNX_ZYNQMP_IOMODULE_PIT(reg->opaque);
> > +    uint64_t ret;
> > +
> > +    if (s->ps_enable) {
> > +        ret =3D s->ps_counter;
> > +    } else {
> > +        ret =3D ptimer_get_count(s->ptimer);
> > +    }
> > +
> > +    return ret & UINT32_MAX;
> > +}
> > +
> > +static void xlnx_iomod_pit_control_pw(RegisterInfo *reg, uint64_t val)
> > +{
> > +    XlnxPMUPIT *s =3D XLNX_ZYNQMP_IOMODULE_PIT(reg->opaque);
> > +
> > +    ptimer_stop(s->ptimer);
> > +
> > +    if (val & R_PIT_CONTROL_EN_MASK) {
> > +        if (s->ps_enable) {
> > +            /* pre-scalar mode do-Nothing here */
> > +            s->ps_counter =3D s->regs[R_PIT_PRELOAD];
> > +        } else {
> > +            ptimer_set_limit(s->ptimer, s->regs[R_PIT_PRELOAD], 1);
> > +            ptimer_run(s->ptimer, !(val & R_PIT_CONTROL_PRELOAD_MASK))=
;
> > +

> blank line

Fixed.


> > +        }
> > +    }
> > +}
> > +
> > +static const RegisterAccessInfo xlnx_iomod_pit_regs_info[] =3D {
> > +    { .name =3D "PIT_PRELOAD",  .addr =3D A_PIT_PRELOAD,
> > +        .ro =3D 0xffffffff,

> Or UINT32_MAX

Fixed.


> > +    },{ .name =3D "PIT_COUNTER",  .addr =3D A_PIT_COUNTER,
> > +        .ro =3D 0xffffffff,
> > +        .post_read =3D xlnx_iomod_pit_ctr_pr,
> > +    },{ .name =3D "PIT_CONTROL",  .addr =3D A_PIT_CONTROL,
> > +        .rsvd =3D 0xfffffffc,

> Or        =3D ~(R_PIT_CONTROL_PRELOAD_MASK | R_PIT_CONTROL_EN_MASK),

Fixed.


> and I always forgot this is mostly generated.

> > +        .post_write =3D xlnx_iomod_pit_control_pw,
> > +    }
> > +};
> > +
> > +static void xlnx_iomod_pit_timer_hit(void *opaque)
> > +{
> > +    XlnxPMUPIT *s =3D XLNX_ZYNQMP_IOMODULE_PIT(opaque);
> > +
> > +    qemu_irq_pulse(s->irq);
> > +
> > +    /* hit_out to make another pit move it's counter in pre-scalar
mode. */
> > +    qemu_irq_pulse(s->hit_out);
> > +}
> > +
> > +static void xlnx_iomod_pit_ps_config(void *opaque, int n, int level)
> > +{
> > +    XlnxPMUPIT *s =3D XLNX_ZYNQMP_IOMODULE_PIT(opaque);
> > +
> > +    s->ps_enable =3D level;
> > +}
> > +
> > +static void xlnx_iomod_pit_ps_hit_in(void *opaque, int n, int level)
> > +{
> > +    XlnxPMUPIT *s =3D XLNX_ZYNQMP_IOMODULE_PIT(opaque);
> > +
> > +    if (!ARRAY_FIELD_EX32(s->regs, PIT_CONTROL, EN)) {
> > +        /* PIT disabled */
> > +        return;
> > +    }
> > +
> > +    /* Count only on positive edge */
> > +    if (!s->ps_level && level) {
> > +        if (s->ps_counter) {
> > +            s->ps_counter--;
> > +        }
> > +        s->ps_level =3D level;
> > +    } else {
> > +        /* Not on positive edge */
> > +        s->ps_level =3D level;
> > +        return;
> > +    }

> Inverting this

> if (C) {A} else {B return}

> as

> if (!C) {B return}
> A

> is a bit easier to read.

Fixed.


> > +
> > +    /* If timer expires, try to preload or stop */
> > +    if (s->ps_counter =3D=3D 0) {
> > +        xlnx_iomod_pit_timer_hit(opaque);
> > +
> > +        /* Check for pit preload/one-shot mode */
> > +        if (ARRAY_FIELD_EX32(s->regs, PIT_CONTROL, PRELOAD)) {
> > +            /* Preload Mode, Reload the ps_counter */
> > +            s->ps_counter =3D s->regs[R_PIT_PRELOAD];
> > +        } else {
> > +            /* One-Shot mode, turn off the timer */
> > +            s->regs[R_PIT_CONTROL] &=3D ~R_PIT_CONTROL_PRELOAD_MASK;
> > +        }
> > +    }

> Ditto, if (!s->ps_counter) return;

> Anyway this is fine,
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks :)

Alistair


> > +}
> > +
> > +static void xlnx_iomod_pit_reset(DeviceState *dev)
> > +{
> > +    XlnxPMUPIT *s =3D XLNX_ZYNQMP_IOMODULE_PIT(dev);
> > +    unsigned int i;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(s->regs_info); ++i) {
> > +        register_reset(&s->regs_info[i]);
> > +    }
> > +
> > +    s->ps_level =3D false;
> > +}
> > +
> > +static const MemoryRegionOps xlnx_iomod_pit_ops =3D {
> > +    .read =3D register_read_memory,
> > +    .write =3D register_write_memory,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static void xlnx_iomod_pit_realize(DeviceState *dev, Error **errp)
> > +{
> > +    XlnxPMUPIT *s =3D XLNX_ZYNQMP_IOMODULE_PIT(dev);
> > +
> > +    s->bh =3D qemu_bh_new(xlnx_iomod_pit_timer_hit, s);
> > +    s->ptimer =3D ptimer_init(s->bh, PTIMER_POLICY_DEFAULT);
> > +    ptimer_set_freq(s->ptimer, s->frequency_hz);
> > +
> > +    /* IRQ out to pulse when present timer expires/reloads */
> > +    qdev_init_gpio_out_named(dev, &s->hit_out, "ps_hit_out", 1);
> > +
> > +    /* IRQ in to enable pre-scalar mode. Routed from gpo1 */
> > +    qdev_init_gpio_in_named(dev, xlnx_iomod_pit_ps_config,
"ps_config", 1);
> > +
> > +    /* hit_out of neighbouring PIT is received as hit_in */
> > +    qdev_init_gpio_in_named(dev, xlnx_iomod_pit_ps_hit_in,
"ps_hit_in", 1);
> > +}
> > +
> > +static void xlnx_iomod_pit_init(Object *obj)
> > +{
> > +    XlnxPMUPIT *s =3D XLNX_ZYNQMP_IOMODULE_PIT(obj);
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> > +    RegisterInfoArray *reg_array;
> > +
> > +    memory_region_init(&s->iomem, obj, TYPE_XLNX_ZYNQMP_IOMODULE_PIT,
> > +                       XLNX_ZYNQMP_IOMOD_PIT_R_MAX * 4);
> > +    reg_array =3D
> > +        register_init_block32(DEVICE(obj), xlnx_iomod_pit_regs_info,
> > +                              ARRAY_SIZE(xlnx_iomod_pit_regs_info),
> > +                              s->regs_info, s->regs,
> > +                              &xlnx_iomod_pit_ops,
> > +                              XLNX_ZYNQMP_IOMODULE_PIT_ERR_DEBUG,
> > +                              XLNX_ZYNQMP_IOMOD_PIT_R_MAX * 4);
> > +    memory_region_add_subregion(&s->iomem,
> > +                                0x0,
> > +                                &reg_array->mem);
> > +    sysbus_init_mmio(sbd, &s->iomem);
> > +    sysbus_init_irq(sbd, &s->irq);
> > +}
> > +
> > +static const VMStateDescription vmstate_xlnx_iomod_pit =3D {
> > +    .name =3D TYPE_XLNX_ZYNQMP_IOMODULE_PIT,
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_END_OF_LIST(),
> > +    }
> > +};
> > +
> > +static Property xlnx_iomod_pit_properties[] =3D {
> > +    DEFINE_PROP_UINT32("frequency", XlnxPMUPIT, frequency_hz,
66000000),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void xlnx_iomod_pit_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->reset =3D xlnx_iomod_pit_reset;
> > +    dc->realize =3D xlnx_iomod_pit_realize;
> > +    dc->props =3D xlnx_iomod_pit_properties;
> > +    dc->vmsd =3D &vmstate_xlnx_iomod_pit;
> > +}
> > +
> > +static const TypeInfo xlnx_iomod_pit_info =3D {
> > +    .name          =3D TYPE_XLNX_ZYNQMP_IOMODULE_PIT,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(XlnxPMUPIT),
> > +    .class_init    =3D xlnx_iomod_pit_class_init,
> > +    .instance_init =3D xlnx_iomod_pit_init,
> > +};
> > +
> > +static void xlnx_iomod_pit_register_types(void)
> > +{
> > +    type_register_static(&xlnx_iomod_pit_info);
> > +}
> > +
> > +type_init(xlnx_iomod_pit_register_types)
> > diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> > index 8c19eac3b6..805c480cad 100644
> > --- a/hw/timer/Makefile.objs
> > +++ b/hw/timer/Makefile.objs
> > @@ -43,3 +43,5 @@ common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o
> >  common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
> >  common-obj-$(CONFIG_CMSDK_APB_TIMER) +=3D cmsdk-apb-timer.o
> >  common-obj-$(CONFIG_MSF2) +=3D mss-timer.o
> > +
> > +common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-pmu-iomod-pit.o
> >
