Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C2CC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F229F21D82
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkpJ9TZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F229F21D82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTsC4-0005Xy-Gx
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 15:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jTsA1-00040T-DX
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jTs9w-0005DW-29
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:14:20 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:43943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jTs9u-0005Cb-HU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:14:15 -0400
Received: by mail-io1-xd43.google.com with SMTP id 19so3453904ioz.10
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 12:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F3Uj8NYvbKVQOGRc4G/gk2DIE8ze9Dqd3vOMeHS0KE0=;
 b=UkpJ9TZR5NCKAPQpeqrSDkcKHJ2TbaSWuDdVJAF1/QDzzjnTgc3tTwHTT/IPSfBIze
 aTVYHS7OLCEGwaWmxpuu+ZFn4ytNy79NfhnHTexTLZ9/d1Ff3rw9upl9pPE7M57Eyy9X
 IepGXD58qgMCn/4mpKaSu42j58LmQNczFS3k34IbJK8lZk6qcXpPPxCoc5wRs31biiFU
 LkhzfJSPf9Z1e2jht3CpNfQFk2+ueYj1ywIn0qn0s6IyhxN8OuOYTqRMYjZWKBP+td7t
 d9FAvRgtJRqqvs7ZFWu7mYytlDAfHkc0McOkpG0SNYjzlJ47GT2IaOLFuamxGQz2i/vd
 TCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F3Uj8NYvbKVQOGRc4G/gk2DIE8ze9Dqd3vOMeHS0KE0=;
 b=udf0c62f5w9bgR4c4QrjGEUmcXup0M0HBgY1A5kE4ITOVbwvf8nNntyTSdfAhgcegU
 inLOkEjRvti0VScbw8yHYNcQvIZ7gvu9M/WKgnFbhGWJ6d64NhM2ckdWQM2ABKHWzEzA
 +2P0ETs54CdGWcRi+y/WHVKo6+k2QSWUYkqzPGdm8XNSB0UEmXyWmdSZNh421Z6hQwtm
 GzemFAGKZgAYjZOXoD8HKdS8TvPgqACP5e1UVTKNXECcI5C3eIaCVeHhta95f8QU1l+v
 sZfUAOaIf5R35jtbCjIAB9gG2tqdL9Y7mtC7J68ra8XEbgptYoCZRw4lHq9TIJfutOOS
 9M5w==
X-Gm-Message-State: AGi0Pua3o5/yhGbv7rlRTjSIEbsBQkXAektBtih8PR4raENEwB9dITyl
 +G7syWU/I0YbF6zrtfmVBfQJNVjnX7Gv2QeuW9A=
X-Google-Smtp-Source: APiQypJADtqa3gVdZ/Ws5ibwMsoiFTIBcN53sUVZKAaazn2pua/qKDaEv1G2BwY7iIJ1as3I5Kxqe7r4UBW/PeLPyYQ=
X-Received: by 2002:a02:9f13:: with SMTP id z19mr30836563jal.29.1588187650260; 
 Wed, 29 Apr 2020 12:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200428022232.18875-1-pauldzim@gmail.com>
 <20200428022232.18875-2-pauldzim@gmail.com>
 <b7d780c2-d79b-dc72-b277-60aab1cb9c7a@amsat.org>
In-Reply-To: <b7d780c2-d79b-dc72-b277-60aab1cb9c7a@amsat.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Wed, 29 Apr 2020 12:13:43 -0700
Message-ID: <CADBGO7_mR0urRMOPx1ZY4foOE34en7bd3eBXy-RAH737RsDAjg@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] raspi: add BCM2835 SOC MPHI emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000bb06f805a472c0b7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=pauldzim@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bb06f805a472c0b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phil,

On Tue, Apr 28, 2020 at 12:06 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> Hi Paul,
>
> On 4/28/20 4:22 AM, Paul Zimmerman wrote:
> > Add BCM2835 SOC MPHI (Message-based Parallel Host Interface)
> > emulation. It is very basic, only providing the FIQ interrupt
> > needed to allow the dwc-otg USB host controller driver in the
> > Raspbian kernel to function.
> >
> > Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
> > ---
> >  hw/arm/bcm2835_peripherals.c         |  17 +++
> >  hw/misc/Makefile.objs                |   1 +
> >  hw/misc/bcm2835_mphi.c               | 190 +++++++++++++++++++++++++++
> >  include/hw/arm/bcm2835_peripherals.h |   2 +
> >  include/hw/misc/bcm2835_mphi.h       |  48 +++++++
> >  5 files changed, 258 insertions(+)
> >  create mode 100644 hw/misc/bcm2835_mphi.c
> >  create mode 100644 include/hw/misc/bcm2835_mphi.h
> >
> > diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.=
c
> > index edcaa4916d..5e2c832d95 100644
> > --- a/hw/arm/bcm2835_peripherals.c
> > +++ b/hw/arm/bcm2835_peripherals.c
> > @@ -124,6 +124,10 @@ static void bcm2835_peripherals_init(Object *obj)
> >      sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
> >                            TYPE_BCM2835_GPIO);
> >
> > +    /* Mphi */
> > +    sysbus_init_child_obj(obj, "mphi", &s->mphi, sizeof(s->mphi),
> > +                          TYPE_BCM2835_MPHI);
> > +
> >      object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
> >                                     OBJECT(&s->sdhci.sdbus),
> &error_abort);
> >      object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
> > @@ -368,6 +372,19 @@ static void bcm2835_peripherals_realize(DeviceStat=
e
> *dev, Error **errp)
> >          return;
> >      }
> >
> > +    /* Mphi */
> > +    object_property_set_bool(OBJECT(&s->mphi), true, "realized", &err)=
;
> > +    if (err) {
> > +        error_propagate(errp, err);
> > +        return;
> > +    }
> > +
> > +    memory_region_add_subregion(&s->peri_mr, MPHI_OFFSET,
> > +                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mphi), 0));
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->mphi), 0,
> > +        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
> > +                               INTERRUPT_HOSTPORT));
> > +
> >      create_unimp(s, &s->armtmr, "bcm2835-sp804",
> ARMCTRL_TIMER0_1_OFFSET, 0x40);
> >      create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET,
> 0x1000);
> >      create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
> > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> > index 68aae2eabb..91085cc21b 100644
> > --- a/hw/misc/Makefile.objs
> > +++ b/hw/misc/Makefile.objs
> > @@ -57,6 +57,7 @@ common-obj-$(CONFIG_OMAP) +=3D omap_l4.o
> >  common-obj-$(CONFIG_OMAP) +=3D omap_sdrc.o
> >  common-obj-$(CONFIG_OMAP) +=3D omap_tap.o
> >  common-obj-$(CONFIG_RASPI) +=3D bcm2835_mbox.o
> > +common-obj-$(CONFIG_RASPI) +=3D bcm2835_mphi.o
> >  common-obj-$(CONFIG_RASPI) +=3D bcm2835_property.o
> >  common-obj-$(CONFIG_RASPI) +=3D bcm2835_rng.o
> >  common-obj-$(CONFIG_RASPI) +=3D bcm2835_thermal.o
> > diff --git a/hw/misc/bcm2835_mphi.c b/hw/misc/bcm2835_mphi.c
> > new file mode 100644
> > index 0000000000..66fc4a9cd3
> > --- /dev/null
> > +++ b/hw/misc/bcm2835_mphi.c
> > @@ -0,0 +1,190 @@
> > +/*
> > + * BCM2835 SOC MPHI emulation
> > + *
> > + * Very basic emulation, only providing the FIQ interrupt needed to
> > + * allow the dwc-otg USB host controller driver in the Raspbian kernel
> > + * to function.
> > + *
> > + * Copyright (c) 2020 Paul Zimmerman <pauldzim@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "hw/misc/bcm2835_mphi.h"
> > +#include "migration/vmstate.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/main-loop.h"
> > +
> > +static inline void mphi_raise_irq(BCM2835MphiState *s)
> > +{
> > +    qemu_set_irq(s->irq, 1);
> > +}
> > +
> > +static inline void mphi_lower_irq(BCM2835MphiState *s)
> > +{
> > +    qemu_set_irq(s->irq, 0);
> > +}
> > +
> > +static uint64_t mphi_reg_read(void *ptr, hwaddr addr, unsigned size)
> > +{
> > +    BCM2835MphiState *s =3D ptr;
> > +    uint32_t reg =3D s->regbase + addr;
> > +    uint32_t val =3D 0;
> > +
> > +    switch (reg) {
> > +    case 0x28:  /* outdda */
> > +        val =3D s->outdda;
> > +        break;
> > +    case 0x2c:  /* outddb */
> > +        val =3D s->outddb;
> > +        break;
> > +    case 0x4c:  /* ctrl */
> > +        val =3D s->ctrl;
> > +        val |=3D 1 << 17;
> > +        break;
> > +    case 0x50:  /* intstat */
> > +        val =3D s->intstat;
> > +        break;
> > +    case 0x1f0: /* swirq_set */
> > +        val =3D s->swirq_set;
> > +        break;
> > +    case 0x1f4: /* swirq_clr */
> > +        val =3D s->swirq_clr;
> > +        break;
>
> I'm surprised this register is read.
>

Maybe it=E2=80=99s not, I=E2=80=99ll check the driver code.


> > +    default:
> > +        break;
> > +    }
> > +
> > +    return val;
> > +}
> > +
> > +static void mphi_reg_write(void *ptr, hwaddr addr, uint64_t val,
> unsigned size)
> > +{
> > +    BCM2835MphiState *s =3D ptr;
> > +    uint32_t reg =3D s->regbase + addr;
> > +    int do_irq =3D 0;
> > +
> > +    val &=3D 0xffffffff;
>
> Using '.impl.max_access_size =3D 4' (see below) this line is not necessar=
y.
>

Ok. I just copied this code from one of the USB drivers, I=E2=80=99ll have =
a
look into this.


> > +
> > +    switch (reg) {
> > +    case 0x28:  /* outdda */
> > +        s->outdda =3D val;
> > +        break;
> > +    case 0x2c:  /* outddb */
> > +        s->outddb =3D val;
> > +        if (val & (1 << 29)) {
> > +            do_irq =3D 1;
> > +        }
>
> Any idea what outdda/b means?
>

The Raspbian driver has a comment about triggering a fake DMA transfer,
so something to do with DMA. I should say that this emulation was 100%
developed without any documentation, just reverse engineered from what
the driver does.


> > +        break;
> > +    case 0x4c:  /* ctrl */
> > +        s->ctrl =3D val;
> > +        if (val & (1 << 16)) {
>
> Any idea what are bits 16/17 for?
>
> > +            do_irq =3D -1;
> > +        }
>
> I suppose this register is INT_ENA (inverted?)
>
> > +        break;
> > +    case 0x50:  /* intstat */
> > +        s->intstat =3D val;
> > +        if (val & ((1 << 16) | (1 << 29))) {
> > +            do_irq =3D -1;
>
> I suppose writting INT_STAT acknowledges interrupts.
>
> > +        }
> > +        break;
>
> Here ...
>
> > +    case 0x1f0: /* swirq_set */
> > +        s->swirq_set =3D val;
> > +        do_irq =3D 1;
> > +        break;
> > +    case 0x1f4: /* swirq_clr */
> > +        s->swirq_clr =3D val;
> > +        do_irq =3D -1;
> > +        break;
>
> ... we access the same register, 's->swirq'.
>
> 0x1f0 sets the bits:
>
>   s->swirq =3D val;
>
> 0x1f4 clears the bits:
>
>   s->swirq &=3D ~val;
>
> Then you could simplify with qemu_set_irq(s->irq, ... && s->swirq);
>

Yep I think you=E2=80=99re right, I=E2=80=99ll do that.


> > +    default:
>
> Please log unimplemented accesses:
>
>        qemu_log_mask(LOG_UNIMP, ...);
>

Ah, I was wondering about the right way to do that, thanks.


> > +        break;
>
>            return?
>
> > +    }
> > +
> > +    if (do_irq > 0) {
> > +        mphi_raise_irq(s);
> > +    } else if (do_irq < 0) {
> > +        mphi_lower_irq(s);
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps mphi_mmio_ops =3D {
> > +    .read =3D mphi_reg_read,
> > +    .write =3D mphi_reg_write,
> > +    .valid.min_access_size =3D 4,
> > +    .valid.max_access_size =3D 4,
>
> I don't know what are the valid bus access sizes, but per your
> implementation you want:
>
>        .impl.min_access_size =3D 4,
>        .impl.max_access_size =3D 4,
>
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +};
> > +
> > +static void mphi_reset(DeviceState *dev)
> > +{
> > +}
> > +
> > +static void mphi_realize(DeviceState *dev, Error **errp)
> > +{
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> > +    BCM2835MphiState *s =3D BCM2835_MPHI(dev);
> > +
> > +    sysbus_init_irq(sbd, &s->irq);
> > +}
> > +
> > +static void mphi_init(Object *obj)
> > +{
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> > +    BCM2835MphiState *s =3D BCM2835_MPHI(obj);
> > +
> > +    s->regbase =3D 0;
> > +    memory_region_init(&s->mem, obj, "mphi", MPHI_MMIO_SIZE);
> > +    memory_region_init_io(&s->mem_reg, obj, &mphi_mmio_ops, s,
> "global", 0x200);
> > +    memory_region_add_subregion(&s->mem, s->regbase, &s->mem_reg);
>
> I'm not sure why you use a container. You can simplify using a single:
>
>        memory_region_init_io(&s->iomem, obj, &mphi_mmio_ops, s, "mphi",
> MPHI_MMIO_SIZE);


OK


> > +    sysbus_init_mmio(sbd, &s->mem);
> > +}
> > +
> > +const VMStateDescription vmstate_mphi_state =3D {
> > +    .name =3D "mphi",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT16(regbase, BCM2835MphiState),
> > +        VMSTATE_UINT32(outdda, BCM2835MphiState),
> > +        VMSTATE_UINT32(outddb, BCM2835MphiState),
> > +        VMSTATE_UINT32(ctrl, BCM2835MphiState),
> > +        VMSTATE_UINT32(intstat, BCM2835MphiState),
> > +        VMSTATE_UINT32(swirq_set, BCM2835MphiState),
> > +        VMSTATE_UINT32(swirq_clr, BCM2835MphiState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static void mphi_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->realize =3D mphi_realize;
> > +    dc->reset =3D mphi_reset;
> > +    dc->vmsd =3D &vmstate_mphi_state;
> > +}
> > +
> > +static const TypeInfo bcm2835_mphi_type_info =3D {
> > +    .name          =3D TYPE_BCM2835_MPHI,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(BCM2835MphiState),
> > +    .instance_init =3D mphi_init,
> > +    .class_init    =3D mphi_class_init,
> > +};
> > +
> > +static void bcm2835_mphi_register_types(void)
> > +{
> > +    type_register_static(&bcm2835_mphi_type_info);
> > +}
> > +
> > +type_init(bcm2835_mphi_register_types)
> > diff --git a/include/hw/arm/bcm2835_peripherals.h
> b/include/hw/arm/bcm2835_peripherals.h
> > index 2e8655a7c2..7a7a8f6141 100644
> > --- a/include/hw/arm/bcm2835_peripherals.h
> > +++ b/include/hw/arm/bcm2835_peripherals.h
> > @@ -21,6 +21,7 @@
> >  #include "hw/misc/bcm2835_property.h"
> >  #include "hw/misc/bcm2835_rng.h"
> >  #include "hw/misc/bcm2835_mbox.h"
> > +#include "hw/misc/bcm2835_mphi.h"
> >  #include "hw/misc/bcm2835_thermal.h"
> >  #include "hw/sd/sdhci.h"
> >  #include "hw/sd/bcm2835_sdhost.h"
> > @@ -42,6 +43,7 @@ typedef struct BCM2835PeripheralState {
> >      qemu_irq irq, fiq;
> >
> >      BCM2835SystemTimerState systmr;
> > +    BCM2835MphiState mphi;
> >      UnimplementedDeviceState armtmr;
> >      UnimplementedDeviceState cprman;
> >      UnimplementedDeviceState a2w;
> > diff --git a/include/hw/misc/bcm2835_mphi.h
> b/include/hw/misc/bcm2835_mphi.h
> > new file mode 100644
> > index 0000000000..6d070b04a5
> > --- /dev/null
> > +++ b/include/hw/misc/bcm2835_mphi.h
> > @@ -0,0 +1,48 @@
> > +/*
> > + * BCM2835 SOC MPHI state definitions
> > + *
> > + * Copyright (c) 2020 Paul Zimmerman <pauldzim@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#ifndef HW_MISC_BCM2835_MPHI_H
> > +#define HW_MISC_BCM2835_MPHI_H
> > +
> > +#include "hw/irq.h"
> > +#include "hw/sysbus.h"
> > +#include "sysemu/dma.h"
>
> sysemu/dma.h not used.
>

Will remove.

>
> > +
> > +#define MPHI_MMIO_SIZE      0x1000
> > +
> > +typedef struct BCM2835MphiState BCM2835MphiState;
> > +
> > +struct BCM2835MphiState {
> > +    SysBusDevice parent_obj;
> > +    qemu_irq irq;
> > +    MemoryRegion mem;
> > +    MemoryRegion mem_reg;
> > +    uint16_t regbase;
>
> You can remove regbase.
>

Right, thanks,


> > +
> > +    uint32_t outdda;
> > +    uint32_t outddb;
> > +    uint32_t ctrl;
> > +    uint32_t intstat;
> > +    uint32_t swirq_set;
> > +    uint32_t swirq_clr;
>
> As suggested previously, you can use a single 'swirq' register.
>
> > +};
> > +
> > +#define TYPE_BCM2835_MPHI   "bcm2835-mphi"
> > +
> > +#define BCM2835_MPHI(obj) \
> > +    OBJECT_CHECK(BCM2835MphiState, (obj), TYPE_BCM2835_MPHI)
> > +
> > +#endif
> >
>
> I made a lot of picky comments, mostly to simplify, but this patch is in
> good shape otherwise (being aware we have no documentation on this
> device). Maybe Peter/Gerd are OK to accept it as it (as it is your first
> contribution).
>
> Thanks for the review!

Paul


Regards,
>
> Phil.
>

--000000000000bb06f805a472c0b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace">Hi Phil,</div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 28, 2020 at 12:06 AM Philippe=
 Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-=
color:rgb(204,204,204);padding-left:1ex">Hi Paul,<br>
<br>
On 4/28/20 4:22 AM, Paul Zimmerman wrote:<br>
&gt; Add BCM2835 SOC MPHI (Message-based Parallel Host Interface)<br>
&gt; emulation. It is very basic, only providing the FIQ interrupt<br>
&gt; needed to allow the dwc-otg USB host controller driver in the<br>
&gt; Raspbian kernel to function.<br>
&gt; <br>
&gt; Signed-off-by: Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@gmail.com=
" target=3D"_blank">pauldzim@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/arm/bcm2835_peripherals.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 17 +++<br>
&gt;=C2=A0 hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/misc/bcm2835_mphi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 190 +++++++++++++++++++++++++++<br>
&gt;=C2=A0 include/hw/arm/bcm2835_peripherals.h |=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 include/hw/misc/bcm2835_mphi.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 48 +++++++<br>
&gt;=C2=A0 5 files changed, 258 insertions(+)<br>
&gt;=C2=A0 create mode 100644 hw/misc/bcm2835_mphi.c<br>
&gt;=C2=A0 create mode 100644 include/hw/misc/bcm2835_mphi.h<br>
&gt; <br>
&gt; diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals=
.c<br>
&gt; index edcaa4916d..5e2c832d95 100644<br>
&gt; --- a/hw/arm/bcm2835_peripherals.c<br>
&gt; +++ b/hw/arm/bcm2835_peripherals.c<br>
&gt; @@ -124,6 +124,10 @@ static void bcm2835_peripherals_init(Object *obj)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;gpio&quot;, &amp;=
s-&gt;gpio, sizeof(s-&gt;gpio),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_BCM2835_GPIO);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 /* Mphi */<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;mphi&quot;, &amp;s-&gt=
;mphi, sizeof(s-&gt;mphi),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_BCM2835_MPHI);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_property_add_const_link(OBJECT(&amp;s-&gt;g=
pio), &quot;sdbus-sdhci&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJECT(&amp;s=
-&gt;sdhci.sdbus), &amp;error_abort);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_property_add_const_link(OBJECT(&amp;s-&gt;g=
pio), &quot;sdbus-sdhost&quot;,<br>
&gt; @@ -368,6 +372,19 @@ static void bcm2835_peripherals_realize(DeviceSta=
te *dev, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 /* Mphi */<br>
&gt; +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp;s-&gt;mphi), true,=
 &quot;realized&quot;, &amp;err);<br>
&gt; +=C2=A0 =C2=A0 if (err) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(&amp;s-&gt;peri_mr, MPHI_OF=
FSET,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_g=
et_region(SYS_BUS_DEVICE(&amp;s-&gt;mphi), 0));<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;mphi), 0,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in_named(DEVICE(&amp;s-&gt;=
ic), BCM2835_IC_GPU_IRQ,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0INTERRUPT_HOSTPORT));<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 create_unimp(s, &amp;s-&gt;armtmr, &quot;bcm2835-s=
p804&quot;, ARMCTRL_TIMER0_1_OFFSET, 0x40);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 create_unimp(s, &amp;s-&gt;cprman, &quot;bcm2835-c=
prman&quot;, CPRMAN_OFFSET, 0x1000);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 create_unimp(s, &amp;s-&gt;a2w, &quot;bcm2835-a2w&=
quot;, A2W_OFFSET, 0x1000);<br>
&gt; diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs<br>
&gt; index 68aae2eabb..91085cc21b 100644<br>
&gt; --- a/hw/misc/Makefile.objs<br>
&gt; +++ b/hw/misc/Makefile.objs<br>
&gt; @@ -57,6 +57,7 @@ common-obj-$(CONFIG_OMAP) +=3D omap_l4.o<br>
&gt;=C2=A0 common-obj-$(CONFIG_OMAP) +=3D omap_sdrc.o<br>
&gt;=C2=A0 common-obj-$(CONFIG_OMAP) +=3D omap_tap.o<br>
&gt;=C2=A0 common-obj-$(CONFIG_RASPI) +=3D bcm2835_mbox.o<br>
&gt; +common-obj-$(CONFIG_RASPI) +=3D bcm2835_mphi.o<br>
&gt;=C2=A0 common-obj-$(CONFIG_RASPI) +=3D bcm2835_property.o<br>
&gt;=C2=A0 common-obj-$(CONFIG_RASPI) +=3D bcm2835_rng.o<br>
&gt;=C2=A0 common-obj-$(CONFIG_RASPI) +=3D bcm2835_thermal.o<br>
&gt; diff --git a/hw/misc/bcm2835_mphi.c b/hw/misc/bcm2835_mphi.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..66fc4a9cd3<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/misc/bcm2835_mphi.c<br>
&gt; @@ -0,0 +1,190 @@<br>
&gt; +/*<br>
&gt; + * BCM2835 SOC MPHI emulation<br>
&gt; + *<br>
&gt; + * Very basic emulation, only providing the FIQ interrupt needed to<b=
r>
&gt; + * allow the dwc-otg USB host controller driver in the Raspbian kerne=
l<br>
&gt; + * to function.<br>
&gt; + *<br>
&gt; + * Copyright (c) 2020 Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@g=
mail.com" target=3D"_blank">pauldzim@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation; either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;hw/misc/bcm2835_mphi.h&quot;<br>
&gt; +#include &quot;migration/vmstate.h&quot;<br>
&gt; +#include &quot;qemu/error-report.h&quot;<br>
&gt; +#include &quot;qemu/main-loop.h&quot;<br>
&gt; +<br>
&gt; +static inline void mphi_raise_irq(BCM2835MphiState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq, 1);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline void mphi_lower_irq(BCM2835MphiState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq, 0);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t mphi_reg_read(void *ptr, hwaddr addr, unsigned size)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 BCM2835MphiState *s =3D ptr;<br>
&gt; +=C2=A0 =C2=A0 uint32_t reg =3D s-&gt;regbase + addr;<br>
&gt; +=C2=A0 =C2=A0 uint32_t val =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (reg) {<br>
&gt; +=C2=A0 =C2=A0 case 0x28:=C2=A0 /* outdda */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;outdda;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 0x2c:=C2=A0 /* outddb */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;outddb;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 0x4c:=C2=A0 /* ctrl */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;ctrl;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D 1 &lt;&lt; 17;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 0x50:=C2=A0 /* intstat */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;intstat;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 0x1f0: /* swirq_set */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;swirq_set;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 0x1f4: /* swirq_clr */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;swirq_clr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
<br>
I&#39;m surprised this register is read.<br></blockquote><div><br></div><di=
v class=3D"gmail_default" style=3D"font-family:monospace">Maybe it=E2=80=99=
s not, I=E2=80=99ll check the driver code.</div><div class=3D"gmail_default=
" style=3D"font-family:monospace"><br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-styl=
e:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return val;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void mphi_reg_write(void *ptr, hwaddr addr, uint64_t val, unsi=
gned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 BCM2835MphiState *s =3D ptr;<br>
&gt; +=C2=A0 =C2=A0 uint32_t reg =3D s-&gt;regbase + addr;<br>
&gt; +=C2=A0 =C2=A0 int do_irq =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 val &amp;=3D 0xffffffff;<br>
<br>
Using &#39;.impl.max_access_size =3D 4&#39; (see below) this line is not ne=
cessary.<br></blockquote><div><br></div><div class=3D"gmail_default" style=
=3D"font-family:monospace">Ok. I just copied this code from one of the USB =
drivers, I=E2=80=99ll have a</div><div class=3D"gmail_default" style=3D"fon=
t-family:monospace">look into this.</div><div class=3D"gmail_default" style=
=3D"font-family:monospace"><br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid=
;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (reg) {<br>
&gt; +=C2=A0 =C2=A0 case 0x28:=C2=A0 /* outdda */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;outdda =3D val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 0x2c:=C2=A0 /* outddb */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;outddb =3D val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val &amp; (1 &lt;&lt; 29)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_irq =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Any idea what outdda/b means?<br></blockquote><div>=C2=A0</div><div class=
=3D"gmail_default" style=3D"font-family:monospace">The Raspbian driver has =
a comment about triggering a fake DMA transfer,</div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace">so something to do with DMA. I shoul=
d say that this emulation was 100%</div><div class=3D"gmail_default" style=
=3D"font-family:monospace">developed without any documentation, just revers=
e engineered from what</div><div class=3D"gmail_default" style=3D"font-fami=
ly:monospace">the driver does.</div><div class=3D"gmail_default" style=3D"f=
ont-family:monospace"><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;bord=
er-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 0x4c:=C2=A0 /* ctrl */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;ctrl =3D val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val &amp; (1 &lt;&lt; 16)) {<br>
<br>
Any idea what are bits 16/17 for?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_irq =3D -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
I suppose this register is INT_ENA (inverted?)<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 0x50:=C2=A0 /* intstat */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;intstat =3D val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val &amp; ((1 &lt;&lt; 16) | (1 &lt;&=
lt; 29))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_irq =3D -1;<br>
<br>
I suppose writting INT_STAT acknowledges interrupts.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
<br>
Here ...<br>
<br>
&gt; +=C2=A0 =C2=A0 case 0x1f0: /* swirq_set */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;swirq_set =3D val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_irq =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 0x1f4: /* swirq_clr */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;swirq_clr =3D val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_irq =3D -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
<br>
... we access the same register, &#39;s-&gt;swirq&#39;.<br>
<br>
0x1f0 sets the bits:<br>
<br>
=C2=A0 s-&gt;swirq =3D val;<br>
<br>
0x1f4 clears the bits:<br>
<br>
=C2=A0 s-&gt;swirq &amp;=3D ~val;<br>
<br>
Then you could simplify with qemu_set_irq(s-&gt;irq, ... &amp;&amp; s-&gt;s=
wirq);<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D=
"font-family:monospace">Yep I think you=E2=80=99re right, I=E2=80=99ll do t=
hat.</div><div class=3D"gmail_default" style=3D"font-family:monospace"><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,=
204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 default:<br>
<br>
Please log unimplemented accesses:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_UNIMP, ...);<br></blockquote><=
div><br></div><div class=3D"gmail_default" style=3D"font-family:monospace">=
Ah, I was wondering about the right way to do that, thanks.</div><div class=
=3D"gmail_default" style=3D"font-family:monospace"><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1e=
x">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return?<br>
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (do_irq &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mphi_raise_irq(s);<br>
&gt; +=C2=A0 =C2=A0 } else if (do_irq &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mphi_lower_irq(s);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps mphi_mmio_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D mphi_reg_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D mphi_reg_write,<br>
&gt; +=C2=A0 =C2=A0 .valid.min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 .valid.max_access_size =3D 4,<br>
<br>
I don&#39;t know what are the valid bus access sizes, but per your<br>
implementation you want:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0.impl.min_access_size =3D 4,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0.impl.max_access_size =3D 4,<br>
<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void mphi_reset(DeviceState *dev)<br>
&gt; +{<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void mphi_realize(DeviceState *dev, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);<br>
&gt; +=C2=A0 =C2=A0 BCM2835MphiState *s =3D BCM2835_MPHI(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_irq(sbd, &amp;s-&gt;irq);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void mphi_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);<br>
&gt; +=C2=A0 =C2=A0 BCM2835MphiState *s =3D BCM2835_MPHI(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regbase =3D 0;<br>
&gt; +=C2=A0 =C2=A0 memory_region_init(&amp;s-&gt;mem, obj, &quot;mphi&quot=
;, MPHI_MMIO_SIZE);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;mem_reg, obj, &amp;mph=
i_mmio_ops, s, &quot;global&quot;, 0x200);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(&amp;s-&gt;mem, s-&gt;regba=
se, &amp;s-&gt;mem_reg);<br>
<br>
I&#39;m not sure why you use a container. You can simplify using a single:<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_init_io(&amp;s-&gt;iomem, obj, &am=
p;mphi_mmio_ops, s, &quot;mphi&quot;,<br>
MPHI_MMIO_SIZE);</blockquote><div><br></div><div class=3D"gmail_default" st=
yle=3D"font-family:monospace">OK</div><div class=3D"gmail_default" style=3D=
"font-family:monospace"><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex"><span style=3D"font-fa=
mily:monospace"></span><br></blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:so=
lid;border-left-color:rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;s-&gt;mem);<br>
&gt; +}<br>
&gt; +<br>
&gt; +const VMStateDescription vmstate_mphi_state =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;mphi&quot;,<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT16(regbase, BCM2835MphiState)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(outdda, BCM2835MphiState),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(outddb, BCM2835MphiState),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(ctrl, BCM2835MphiState),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(intstat, BCM2835MphiState)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(swirq_set, BCM2835MphiStat=
e),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(swirq_clr, BCM2835MphiStat=
e),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void mphi_class_init(ObjectClass *klass, void *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D mphi_realize;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;reset =3D mphi_reset;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;vmstate_mphi_state;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo bcm2835_mphi_type_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_BCM283=
5_MPHI,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEV=
ICE,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(BCM2835MphiState),<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D mphi_init,<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D mphi_class_init,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void bcm2835_mphi_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;bcm2835_mphi_type_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(bcm2835_mphi_register_types)<br>
&gt; diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm=
2835_peripherals.h<br>
&gt; index 2e8655a7c2..7a7a8f6141 100644<br>
&gt; --- a/include/hw/arm/bcm2835_peripherals.h<br>
&gt; +++ b/include/hw/arm/bcm2835_peripherals.h<br>
&gt; @@ -21,6 +21,7 @@<br>
&gt;=C2=A0 #include &quot;hw/misc/bcm2835_property.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/misc/bcm2835_rng.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/misc/bcm2835_mbox.h&quot;<br>
&gt; +#include &quot;hw/misc/bcm2835_mphi.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/misc/bcm2835_thermal.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/sd/sdhci.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/sd/bcm2835_sdhost.h&quot;<br>
&gt; @@ -42,6 +43,7 @@ typedef struct BCM2835PeripheralState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_irq irq, fiq;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 BCM2835SystemTimerState systmr;<br>
&gt; +=C2=A0 =C2=A0 BCM2835MphiState mphi;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 UnimplementedDeviceState armtmr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 UnimplementedDeviceState cprman;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 UnimplementedDeviceState a2w;<br>
&gt; diff --git a/include/hw/misc/bcm2835_mphi.h b/include/hw/misc/bcm2835_=
mphi.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..6d070b04a5<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/misc/bcm2835_mphi.h<br>
&gt; @@ -0,0 +1,48 @@<br>
&gt; +/*<br>
&gt; + * BCM2835 SOC MPHI state definitions<br>
&gt; + *<br>
&gt; + * Copyright (c) 2020 Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@g=
mail.com" target=3D"_blank">pauldzim@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation; either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef HW_MISC_BCM2835_MPHI_H<br>
&gt; +#define HW_MISC_BCM2835_MPHI_H<br>
&gt; +<br>
&gt; +#include &quot;hw/irq.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;sysemu/dma.h&quot;<br>
<br>
sysemu/dma.h not used.<br></blockquote><div><br></div><div class=3D"gmail_d=
efault" style=3D"font-family:monospace">Will remove.</div><div class=3D"gma=
il_default" style=3D"font-family:monospace"></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-lef=
t-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +#define MPHI_MMIO_SIZE=C2=A0 =C2=A0 =C2=A0 0x1000<br>
&gt; +<br>
&gt; +typedef struct BCM2835MphiState BCM2835MphiState;<br>
&gt; +<br>
&gt; +struct BCM2835MphiState {<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; +=C2=A0 =C2=A0 qemu_irq irq;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion mem;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion mem_reg;<br>
&gt; +=C2=A0 =C2=A0 uint16_t regbase;<br>
<br>
You can remove regbase.<br></blockquote><div><br></div><div class=3D"gmail_=
default" style=3D"font-family:monospace">Right, thanks,</div><div class=3D"=
gmail_default" style=3D"font-family:monospace"><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t outdda;<br>
&gt; +=C2=A0 =C2=A0 uint32_t outddb;<br>
&gt; +=C2=A0 =C2=A0 uint32_t ctrl;<br>
&gt; +=C2=A0 =C2=A0 uint32_t intstat;<br>
&gt; +=C2=A0 =C2=A0 uint32_t swirq_set;<br>
&gt; +=C2=A0 =C2=A0 uint32_t swirq_clr;<br>
<br>
As suggested previously, you can use a single &#39;swirq&#39; register.<br>
<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define TYPE_BCM2835_MPHI=C2=A0 =C2=A0&quot;bcm2835-mphi&quot;<br>
&gt; +<br>
&gt; +#define BCM2835_MPHI(obj) \<br>
&gt; +=C2=A0 =C2=A0 OBJECT_CHECK(BCM2835MphiState, (obj), TYPE_BCM2835_MPHI=
)<br>
&gt; +<br>
&gt; +#endif<br>
&gt; <br>
<br>
I made a lot of picky comments, mostly to simplify, but this patch is in<br=
>
good shape otherwise (being aware we have no documentation on this<br>
device). Maybe Peter/Gerd are OK to accept it as it (as it is your first<br=
>
contribution).<br>
<br></blockquote><div class=3D"gmail_default" style=3D"font-family:monospac=
e"></div><div class=3D"gmail_default" style=3D"font-family:monospace">Thank=
s for the review!</div><div class=3D"gmail_default" style=3D"font-family:mo=
nospace"><br></div><div class=3D"gmail_default" style=3D"font-family:monosp=
ace">Paul</div><div class=3D"gmail_default" style=3D"font-family:monospace"=
><br></div><div class=3D"gmail_default" style=3D"font-family:monospace"><br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204=
,204);padding-left:1ex">
Regards,<br>
<br>
Phil.<br>
</blockquote></div></div>

--000000000000bb06f805a472c0b7--

