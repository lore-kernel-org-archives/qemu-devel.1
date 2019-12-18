Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DDEC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 04:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3066D20715
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 04:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGDg11vw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3066D20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihQan-0000vh-DL
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 23:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1ihQZm-0008Nz-0Y
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 23:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1ihQZk-0007vo-2J
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 23:04:41 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:39504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1ihQZj-0007sJ-Jz; Tue, 17 Dec 2019 23:04:40 -0500
Received: by mail-lf1-x142.google.com with SMTP id y1so610410lfb.6;
 Tue, 17 Dec 2019 20:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Gn5u53AcHsOLz5ep22Df1IpTEhdGFxnRJsa3OabeLBc=;
 b=YGDg11vwcL+UhzjCHOiuSKvx265s/lEQvYo3cIesUfstc1TMTDUMkMiWmpyTz7Mele
 hKSFvocS2uhzd2UCm6SS7bD2P7QETvd9rruaqSM8iKWYGzOLE+jTnwTBNPzWI1BegX5g
 wFsLyUtzckrxrCx9pYYAxGDens6LyE5zJkCF4unfe0hcyeVWuRxEYm2N17Bu5E/8OieJ
 Emlaiog6kkWMXwHYXxlIttymvudvvr8eL/t85T4+kW4ZeEFcXXaGIitO4w1zdMqIhurM
 znxRssPERJMwK3Q9wVznR1b9u8uKHCcr9xzP9NZW+/Q/X4LhWZKSblXAA58ABDEaasVG
 F9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Gn5u53AcHsOLz5ep22Df1IpTEhdGFxnRJsa3OabeLBc=;
 b=LkE2LZqrClCQzHwV5sBPGzRYDuDO6yUvctZjQPaZS92MFiYp+D4wY4Y4uu2wqvIa8N
 Q1Wd7828k+4jUimF423U+5gV8gb6ZUq1DBhdSFUGac+vE2vzsYvE18EDVN37zW6NMZaA
 n9F44z/f3ihmXDFS5eKvrZwdR54YUa6wGXC+Pc1xwHj7mset8se9nQWovydJs0C+qGs2
 Sd5jA0MdHTTGY6R1cIFpn2XB4BH87q/48vWob0MXn1606+wR99AHRL0Mx05+5Pm+rmc1
 ycnQIZrQi+EU90+oVVI04NU+H6g+D37/2zGw86R8TzhZgGP7qu+xGpfujRs2gR1jgEHr
 iD8Q==
X-Gm-Message-State: APjAAAV+LAyRrXRRPXBelHa8q2iE6MupwpEnEtjbHjg8MwOK2AvpKBsN
 68qtWNt/pCDlez/IWp+vN6EhpWeQ5z2sand/eOo=
X-Google-Smtp-Source: APXvYqyiYBUqf1sj2C46JhJxggWvBzGTc0kaZPa4soYBZ1TLz+J5BgHio6D7yQ6P0oN3g4BPYKjCtBPztq9+oisj+gc=
X-Received: by 2002:a19:8a41:: with SMTP id m62mr270749lfd.5.1576641877204;
 Tue, 17 Dec 2019 20:04:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576227325.git.alistair@alistair23.me>
 <717e76b6d41e09c352d98a83708c3e3c9fe5d63b.1576227325.git.alistair@alistair23.me>
 <13f8810e-fb67-24c8-fecf-72f48ac5c7db@redhat.com>
In-Reply-To: <13f8810e-fb67-24c8-fecf-72f48ac5c7db@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 17 Dec 2019 20:04:07 -0800
Message-ID: <CAKmqyKPQbLp+SAeUMQt5MThu=ekgpJCuM-=LoydqBF4xfyefxA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] hw/misc: Add the STM32F4xx EXTI device
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Dec 14, 2019 at 5:49 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Alistair,
>
> On 12/14/19 3:44 AM, Alistair Francis wrote:
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/arm/Kconfig                   |   1 +
> >   hw/misc/Kconfig                  |   3 +
> >   hw/misc/Makefile.objs            |   1 +
> >   hw/misc/stm32f4xx_exti.c         | 189 ++++++++++++++++++++++++++++++=
+
> >   hw/misc/trace-events             |   5 +
> >   include/hw/misc/stm32f4xx_exti.h |  60 ++++++++++
> >   6 files changed, 259 insertions(+)
> >   create mode 100644 hw/misc/stm32f4xx_exti.c
> >   create mode 100644 include/hw/misc/stm32f4xx_exti.h
> >
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index 4660d14715..3d86691ae0 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -315,6 +315,7 @@ config STM32F405_SOC
> >       bool
> >       select ARM_V7M
> >       select STM32F4XX_SYSCFG
> > +    select STM32F4XX_EXTI
> >
> >   config XLNX_ZYNQMP_ARM
> >       bool
> > diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> > index 72609650b7..bdd77d8020 100644
> > --- a/hw/misc/Kconfig
> > +++ b/hw/misc/Kconfig
> > @@ -85,6 +85,9 @@ config STM32F2XX_SYSCFG
> >   config STM32F4XX_SYSCFG
> >       bool
> >
> > +config STM32F4XX_EXTI
> > +    bool
> > +
> >   config MIPS_ITU
> >       bool
> >
> > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> > index ea8025e0bb..c6ecbdd7b0 100644
> > --- a/hw/misc/Makefile.objs
> > +++ b/hw/misc/Makefile.objs
> > @@ -59,6 +59,7 @@ common-obj-$(CONFIG_ZYNQ) +=3D zynq_slcr.o
> >   common-obj-$(CONFIG_ZYNQ) +=3D zynq-xadc.o
> >   common-obj-$(CONFIG_STM32F2XX_SYSCFG) +=3D stm32f2xx_syscfg.o
> >   common-obj-$(CONFIG_STM32F4XX_SYSCFG) +=3D stm32f4xx_syscfg.o
> > +common-obj-$(CONFIG_STM32F4XX_EXTI) +=3D stm32f4xx_exti.o
> >   obj-$(CONFIG_MIPS_CPS) +=3D mips_cmgcr.o
> >   obj-$(CONFIG_MIPS_CPS) +=3D mips_cpc.o
> >   obj-$(CONFIG_MIPS_ITU) +=3D mips_itu.o
> > diff --git a/hw/misc/stm32f4xx_exti.c b/hw/misc/stm32f4xx_exti.c
> > new file mode 100644
> > index 0000000000..7f87a885aa
> > --- /dev/null
> > +++ b/hw/misc/stm32f4xx_exti.c
> > @@ -0,0 +1,189 @@
> > +/*
> > + * STM32F4XX EXTI
> > + *
> > + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> > + * of this software and associated documentation files (the "Software"=
), to deal
> > + * in the Software without restriction, including without limitation t=
he rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/log.h"
> > +#include "trace.h"
> > +#include "hw/irq.h"
> > +#include "migration/vmstate.h"
> > +#include "hw/misc/stm32f4xx_exti.h"
> > +
> > +static void stm32f4xx_exti_reset(DeviceState *dev)
> > +{
> > +    STM32F4xxExtiState *s =3D STM32F4XX_EXTI(dev);
> > +
> > +    s->exti_imr =3D 0x00000000;
> > +    s->exti_emr =3D 0x00000000;
> > +    s->exti_rtsr =3D 0x00000000;
> > +    s->exti_ftsr =3D 0x00000000;
> > +    s->exti_swier =3D 0x00000000;
> > +    s->exti_pr =3D 0x00000000;
> > +}
> > +
> > +static void stm32f4xx_exti_set_irq(void *opaque, int irq, int level)
> > +{
> > +    STM32F4xxExtiState *s =3D opaque;
> > +
> > +    if (!((1 << irq) & s->exti_imr)) {
> > +        /* Interrupt is masked */
> > +        return;
>
> I'm not sure this is correct, don't you need to set the bit in the
> exti_pr register regardless it is masked? Else in masked polling mode
> the guest will never see IRQ delivered.
>
> So I'd drop this if statement, ...
>
> > +    }
> > +
> > +    trace_stm32f4xx_exti_set_irq(irq, level);
> > +
> > +    if (((1 << irq) & s->exti_rtsr) && level) {
> > +        /* Rising Edge */
> > +        qemu_irq_pulse(s->irq[irq]);
>
> ... do not pulse here, ...
>
> > +        s->exti_pr |=3D 1 << irq;
> > +    }
> > +
> > +    if (((1 << irq) & s->exti_ftsr) && !level) {
> > +        /* Falling Edge */
> > +        qemu_irq_pulse(s->irq[irq]);
>
> ... do not pulse here, ...
>
> > +        s->exti_pr |=3D 1 << irq;
> > +    }
>
> ... and here pulse if not masked:
>
>         if (!((1 << irq) & s->exti_imr)) {
>             /* Interrupt is masked */
>             return;
>         }
>         qemu_irq_pulse(s->irq[irq]);
>
> (Or invert the if condition).

Good point. I have updated this.

Alistair

>
> > +}
> > +
> > +static uint64_t stm32f4xx_exti_read(void *opaque, hwaddr addr,
> > +                                     unsigned int size)
> > +{
> > +    STM32F4xxExtiState *s =3D opaque;
> > +
> > +    trace_stm32f4xx_exti_read(addr);
> > +
> > +    switch (addr) {
> > +    case EXTI_IMR:
> > +        return s->exti_imr;
> > +    case EXTI_EMR:
> > +        return s->exti_emr;
> > +    case EXTI_RTSR:
> > +        return s->exti_rtsr;
> > +    case EXTI_FTSR:
> > +        return s->exti_ftsr;
> > +    case EXTI_SWIER:
> > +        return s->exti_swier;
> > +    case EXTI_PR:
> > +        return s->exti_pr;
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "STM32F4XX_exti_read: Bad offset %x\n", (int)add=
r);
> > +        return 0;
> > +    }
> > +    return 0;
> > +}
> > +
> > +static void stm32f4xx_exti_write(void *opaque, hwaddr addr,
> > +                       uint64_t val64, unsigned int size)
> > +{
> > +    STM32F4xxExtiState *s =3D opaque;
> > +    uint32_t value =3D (uint32_t) val64;
> > +
> > +    trace_stm32f4xx_exti_write(addr, value);
> > +
> > +    switch (addr) {
> > +    case EXTI_IMR:
> > +        s->exti_imr =3D value;
> > +        return;
> > +    case EXTI_EMR:
> > +        s->exti_emr =3D value;
> > +        return;
> > +    case EXTI_RTSR:
> > +        s->exti_rtsr =3D value;
> > +        return;
> > +    case EXTI_FTSR:
> > +        s->exti_ftsr =3D value;
> > +        return;
> > +    case EXTI_SWIER:
> > +        s->exti_swier =3D value;
> > +        return;
> > +    case EXTI_PR:
> > +        /* This bit is cleared by writing a 1 to it */
> > +        s->exti_pr &=3D ~value;
> > +        return;
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "STM32F4XX_exti_write: Bad offset %x\n", (int)ad=
dr);
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps stm32f4xx_exti_ops =3D {
> > +    .read =3D stm32f4xx_exti_read,
> > +    .write =3D stm32f4xx_exti_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +};
> > +
> > +static void stm32f4xx_exti_init(Object *obj)
> > +{
> > +    STM32F4xxExtiState *s =3D STM32F4XX_EXTI(obj);
> > +    int i;
> > +
> > +    for (i =3D 0; i < NUM_INTERRUPT_OUT_LINES; i++) {
> > +        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
> > +    }
> > +
> > +    memory_region_init_io(&s->mmio, obj, &stm32f4xx_exti_ops, s,
> > +                          TYPE_STM32F4XX_EXTI, 0x400);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> > +
> > +    qdev_init_gpio_in(DEVICE(obj), stm32f4xx_exti_set_irq,
> > +                      NUM_GPIO_EVENT_IN_LINES);
> > +}
> > +
> > +static const VMStateDescription vmstate_stm32f4xx_exti =3D {
> > +    .name =3D TYPE_STM32F4XX_EXTI,
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT32(exti_imr, STM32F4xxExtiState),
> > +        VMSTATE_UINT32(exti_emr, STM32F4xxExtiState),
> > +        VMSTATE_UINT32(exti_rtsr, STM32F4xxExtiState),
> > +        VMSTATE_UINT32(exti_ftsr, STM32F4xxExtiState),
> > +        VMSTATE_UINT32(exti_swier, STM32F4xxExtiState),
> > +        VMSTATE_UINT32(exti_pr, STM32F4xxExtiState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static void stm32f4xx_exti_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->reset =3D stm32f4xx_exti_reset;
> > +    dc->vmsd =3D &vmstate_stm32f4xx_exti;
> > +}
> > +
> > +static const TypeInfo stm32f4xx_exti_info =3D {
> > +    .name          =3D TYPE_STM32F4XX_EXTI,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(STM32F4xxExtiState),
> > +    .instance_init =3D stm32f4xx_exti_init,
> > +    .class_init    =3D stm32f4xx_exti_class_init,
> > +};
> > +
> > +static void stm32f4xx_exti_register_types(void)
> > +{
> > +    type_register_static(&stm32f4xx_exti_info);
> > +}
> > +
> > +type_init(stm32f4xx_exti_register_types)
> > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> > index 02327562bc..91a3794d68 100644
> > --- a/hw/misc/trace-events
> > +++ b/hw/misc/trace-events
> > @@ -90,6 +90,11 @@ stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
> >   stm32f4xx_syscfg_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
> >   stm32f4xx_syscfg_write(uint64_t addr, uint64_t data) "reg write: addr=
: 0x%" PRIx64 " val: 0x%" PRIx64 ""
> >
> > +# stm32f4xx_exti
> > +stm32f4xx_exti_set_irq(int irq, int leve) "Set EXTI: %d to %d"
> > +stm32f4xx_exti_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
> > +stm32f4xx_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0=
x%" PRIx64 " val: 0x%" PRIx64 ""
> > +
> >   # tz-mpc.c
> >   tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MP=
C regs read: offset 0x%x data 0x%" PRIx64 " size %u"
> >   tz_mpc_reg_write(uint32_t offset, uint64_t data, unsigned size) "TZ M=
PC regs write: offset 0x%x data 0x%" PRIx64 " size %u"
> > diff --git a/include/hw/misc/stm32f4xx_exti.h b/include/hw/misc/stm32f4=
xx_exti.h
> > new file mode 100644
> > index 0000000000..707036a41b
> > --- /dev/null
> > +++ b/include/hw/misc/stm32f4xx_exti.h
> > @@ -0,0 +1,60 @@
> > +/*
> > + * STM32F4XX EXTI
> > + *
> > + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> > + * of this software and associated documentation files (the "Software"=
), to deal
> > + * in the Software without restriction, including without limitation t=
he rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#ifndef HW_STM_EXTI_H
> > +#define HW_STM_EXTI_H
> > +
> > +#include "hw/sysbus.h"
> > +#include "hw/hw.h"
> > +
> > +#define EXTI_IMR   0x00
> > +#define EXTI_EMR   0x04
> > +#define EXTI_RTSR  0x08
> > +#define EXTI_FTSR  0x0C
> > +#define EXTI_SWIER 0x10
> > +#define EXTI_PR    0x14
> > +
> > +#define TYPE_STM32F4XX_EXTI "stm32f4xx-exti"
> > +#define STM32F4XX_EXTI(obj) \
> > +    OBJECT_CHECK(STM32F4xxExtiState, (obj), TYPE_STM32F4XX_EXTI)
> > +
> > +#define NUM_GPIO_EVENT_IN_LINES 16
> > +#define NUM_INTERRUPT_OUT_LINES 16
> > +
> > +typedef struct {
> > +    SysBusDevice parent_obj;
> > +
> > +    MemoryRegion mmio;
> > +
> > +    uint32_t exti_imr;
> > +    uint32_t exti_emr;
> > +    uint32_t exti_rtsr;
> > +    uint32_t exti_ftsr;
> > +    uint32_t exti_swier;
> > +    uint32_t exti_pr;
> > +
> > +    qemu_irq irq[NUM_INTERRUPT_OUT_LINES];
> > +} STM32F4xxExtiState;
> > +
> > +#endif
> >
>

