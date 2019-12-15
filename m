Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FE1C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 23:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB702467A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 23:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3cr7xJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB702467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igdJt-0005Qi-Nl
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 18:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igdJ1-0004rf-L1
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 18:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igdIy-0000aF-Me
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 18:28:07 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:38873)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1igdIy-0000Xi-Ey; Sun, 15 Dec 2019 18:28:04 -0500
Received: by mail-io1-xd44.google.com with SMTP id v3so5044319ioj.5;
 Sun, 15 Dec 2019 15:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oA2Ivm9eaXLbReqsxXidJF9bDvcq5VA7L4hHfyzovdI=;
 b=r3cr7xJojiTxOsL58FkGOObI6UTT6nFWUnyPfCmiFS1fq3VF32D6octGay2hS+eBK/
 iIKKZHpYSRH/eup7dhaEvfeBXrxmNObAozB29fULD8KtEK3o9wfXrtMTcF7A3hW4PMm/
 Yt6iBCZH/xWq4uny5uX35L3qGnzE1N0QdGB0UtPNk4tgWl5F3Yh0yUZ7Rsd8JVE+yBVZ
 9kYh3uAZ5nBNd1Gy2k/FPhWHEeHLH5+zkSaOS7nb3jjpYk1ocFEIB9YW08QZ7W/FxqMZ
 OllQwNnY3VLCxaBsa41V7gsGCFcFy+e/gYnMK3YCntXzBGHSDj2Q5U518bGEAJL0TDNF
 eb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oA2Ivm9eaXLbReqsxXidJF9bDvcq5VA7L4hHfyzovdI=;
 b=fdDWG2V3Sr1Kq325ONzyB+FNDxVnmIkIUX2XEX+NODJOJSTS/lpYk7sdYuqRFk+dnr
 F5BgSY3/vUKHWqCilxv5AHIjmZmFoN7qMYwxNjmFHnLcoEHAhfX4LLPsSgoq5I+gM1XQ
 U6Ev1zNqqdvBIqzst98rfh/QACfbqSuaRlgJ/TH6WEFKi0kyuX7lbEu5YfgzjRKjf8Up
 NJtixxInqJ5aqIT6pBMRrZsyhiAVcC3EGuOhk2QqX2DKJAXTh8/Y4Xm8HXVFytMrghKN
 8P3x+fRc+2vreEpfiB/Uz/K1Q01gf6YsOXPeC8IpzFShR6dRAbIiKEXgC4FxhYwkaaBL
 Wiyg==
X-Gm-Message-State: APjAAAWbQ08q6TKwcqgE3iQtX5hPpqiLUm8OYGo/KzQs13E1P3XvMULE
 YoXwj9kRPWOvmhGlQCLNlrxo9Fg6oEOx+iv+lXA=
X-Google-Smtp-Source: APXvYqz7NdngzUgR30WdjkmcruivVdsxWTGJh9Fx6NIOax0xmO+L2GRSic5Xa6MFkKZoIxuzwC++Ot+eAtvB1lSuJN8=
X-Received: by 2002:a6b:6f01:: with SMTP id k1mr16609529ioc.28.1576452483417; 
 Sun, 15 Dec 2019 15:28:03 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-6-nieklinnenbank@gmail.com>
 <949aec5f-fd92-9fb2-25f4-803cd1bbf601@redhat.com>
In-Reply-To: <949aec5f-fd92-9fb2-25f4-803cd1bbf601@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 16 Dec 2019 00:27:52 +0100
Message-ID: <CAPan3WpC2AiSGJsMmbQgJkucEDRg_os418rY_B6B8b8D2WM31A@mail.gmail.com>
Subject: Re: [PATCH 05/10] arm: allwinner-h3: add System Control module
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000478d8a0599c67208"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000478d8a0599c67208
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2019 at 1:09 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 12/2/19 10:09 PM, Niek Linnenbank wrote:
> > The Allwinner H3 System on Chip has an System Control
> > module that provides system wide generic controls and
> > device information. This commit adds support for the
> > Allwinner H3 System Control module.
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >   hw/arm/allwinner-h3.c                 |  11 ++
> >   hw/misc/Makefile.objs                 |   1 +
> >   hw/misc/allwinner-h3-syscon.c         | 139 +++++++++++++++++++++++++=
+
> >   include/hw/arm/allwinner-h3.h         |   2 +
> >   include/hw/misc/allwinner-h3-syscon.h |  43 ++++++++
> >   5 files changed, 196 insertions(+)
> >   create mode 100644 hw/misc/allwinner-h3-syscon.c
> >   create mode 100644 include/hw/misc/allwinner-h3-syscon.h
> >
> > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> > index afeb49c0ac..ebd8fde412 100644
> > --- a/hw/arm/allwinner-h3.c
> > +++ b/hw/arm/allwinner-h3.c
> > @@ -41,6 +41,9 @@ static void aw_h3_init(Object *obj)
> >
> >       sysbus_init_child_obj(obj, "ccu", &s->ccu, sizeof(s->ccu),
> >                             TYPE_AW_H3_CLK);
> > +
> > +    sysbus_init_child_obj(obj, "syscon", &s->syscon, sizeof(s->syscon)=
,
> > +                          TYPE_AW_H3_SYSCON);
> >   }
> >
> >   static void aw_h3_realize(DeviceState *dev, Error **errp)
> > @@ -184,6 +187,14 @@ static void aw_h3_realize(DeviceState *dev, Error
> **errp)
> >       }
> >       sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, AW_H3_CCU_BASE);
> >
> > +    /* System Control */
> > +    object_property_set_bool(OBJECT(&s->syscon), true, "realized",
> &err);
> > +    if (err) {
> > +        error_propagate(errp, err);
> > +        return;
> > +    }
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->syscon), 0, AW_H3_SYSCON_BASE);
> > +
> >       /* Universal Serial Bus */
> >       sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_BASE,
> >                            s->irq[AW_H3_GIC_SPI_EHCI0]);
> > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> > index 200ed44ce1..b234aefba5 100644
> > --- a/hw/misc/Makefile.objs
> > +++ b/hw/misc/Makefile.objs
> > @@ -29,6 +29,7 @@ common-obj-$(CONFIG_MACIO) +=3D macio/
> >   common-obj-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem.o
> >
> >   common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-clk.o
> > +common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-syscon.o
> >   common-obj-$(CONFIG_REALVIEW) +=3D arm_sysctl.o
> >   common-obj-$(CONFIG_NSERIES) +=3D cbus.o
> >   common-obj-$(CONFIG_ECCMEMCTL) +=3D eccmemctl.o
> > diff --git a/hw/misc/allwinner-h3-syscon.c
> b/hw/misc/allwinner-h3-syscon.c
> > new file mode 100644
> > index 0000000000..66bd518a05
> > --- /dev/null
> > +++ b/hw/misc/allwinner-h3-syscon.c
> > @@ -0,0 +1,139 @@
> > +/*
> > + * Allwinner H3 System Control emulation
> > + *
> > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> > + *
> > + * This program is free software: you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/
> >.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/sysbus.h"
> > +#include "migration/vmstate.h"
> > +#include "qemu/log.h"
> > +#include "qemu/module.h"
> > +#include "hw/misc/allwinner-h3-syscon.h"
> > +
> > +/* SYSCON register offsets */
> > +#define REG_VER                 (0x24)  /* Version */
> > +#define REG_EMAC_PHY_CLK        (0x30)  /* EMAC PHY Clock */
> > +#define REG_INDEX(offset)       (offset / sizeof(uint32_t))
> > +
> > +/* SYSCON register reset values */
> > +#define REG_VER_RST             (0x0)
> > +#define REG_EMAC_PHY_CLK_RST    (0x58000)
> > +
> > +static uint64_t allwinner_h3_syscon_read(void *opaque, hwaddr offset,
> > +                                         unsigned size)
> > +{
> > +    const AwH3SysconState *s =3D (AwH3SysconState *)opaque;
> > +    const uint32_t idx =3D REG_INDEX(offset);
> > +
> > +    if (idx >=3D AW_H3_SYSCON_REGS_NUM) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read offset 0x%04x\n",
> > +                      __func__, (uint32_t)offset);
> > +        return 0;
> > +    }
> > +
> > +    return s->regs[idx];
> > +}
> > +
> > +static void allwinner_h3_syscon_write(void *opaque, hwaddr offset,
> > +                                      uint64_t val, unsigned size)
> > +{
> > +    AwH3SysconState *s =3D (AwH3SysconState *)opaque;
> > +    const uint32_t idx =3D REG_INDEX(offset);
> > +
> > +    if (idx >=3D AW_H3_SYSCON_REGS_NUM) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write offset 0x%04x\n"=
,
> > +                      __func__, (uint32_t)offset);
> > +        return;
> > +    }
> > +
> > +    switch (offset) {
> > +    case REG_VER:       /* Version */
> > +        break;
> > +    default:
> > +        s->regs[idx] =3D (uint32_t) val;
> > +        break;
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps allwinner_h3_syscon_ops =3D {
> > +    .read =3D allwinner_h3_syscon_read,
> > +    .write =3D allwinner_h3_syscon_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
>
> Can you point me to the datasheet page that says this region is
> restricted to 32-bit accesses? Maybe you want .valid -> .impl instead?
>
> Hehe well here I can only give the same answer as for the SD/MMC driver:
the datasheet
only provides the base address and register offsets, but nothing
explicitely mentioned about alignment.
I do see that also for this device the registers are 32-bit aligned.

Does that mean I should change MemoryRegionOps to . impl instead?


> > +        .unaligned =3D false
> > +    }
> > +};
> > +
> > +static void allwinner_h3_syscon_reset(DeviceState *dev)
> > +{
> > +    AwH3SysconState *s =3D AW_H3_SYSCON(dev);
> > +
> > +    /* Set default values for registers */
> > +    s->regs[REG_INDEX(REG_VER)] =3D REG_VER_RST;
> > +    s->regs[REG_INDEX(REG_EMAC_PHY_CLK)] =3D REG_EMAC_PHY_CLK_RST;
> > +}
> > +
> > +static void allwinner_h3_syscon_realize(DeviceState *dev, Error **errp=
)
> > +{
> > +}
> > +
> > +static void allwinner_h3_syscon_init(Object *obj)
> > +{
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> > +    AwH3SysconState *s =3D AW_H3_SYSCON(obj);
> > +
> > +    /* Memory mapping */
> > +    memory_region_init_io(&s->iomem, OBJECT(s),
> &allwinner_h3_syscon_ops, s,
> > +                          TYPE_AW_H3_SYSCON,
> AW_H3_SYSCON_REGS_MEM_SIZE);
>
> This definition isn't very helpful IMO, I'd use the value in place: '4 *
> KiB'.
>
OK, I'll apply that too in the other drivers.


>
> > +    sysbus_init_mmio(sbd, &s->iomem);
> > +}
> > +
> > +static const VMStateDescription allwinner_h3_syscon_vmstate =3D {
> > +    .name =3D TYPE_AW_H3_SYSCON,
>
> Plain name.
>
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT32_ARRAY(regs, AwH3SysconState,
> AW_H3_SYSCON_REGS_NUM),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static void allwinner_h3_syscon_class_init(ObjectClass *klass, void
> *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->reset =3D allwinner_h3_syscon_reset;
> > +    dc->realize =3D allwinner_h3_syscon_realize;
> > +    dc->vmsd =3D &allwinner_h3_syscon_vmstate;
> > +}
> > +
> > +static const TypeInfo allwinner_h3_syscon_info =3D {
> > +    .name          =3D TYPE_AW_H3_SYSCON,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_init =3D allwinner_h3_syscon_init,
> > +    .instance_size =3D sizeof(AwH3SysconState),
> > +    .class_init    =3D allwinner_h3_syscon_class_init,
> > +};
> > +
> > +static void allwinner_h3_syscon_register(void)
> > +{
> > +    type_register_static(&allwinner_h3_syscon_info);
> > +}
> > +
> > +type_init(allwinner_h3_syscon_register)
> > diff --git a/include/hw/arm/allwinner-h3.h
> b/include/hw/arm/allwinner-h3.h
> > index e596516c5c..2bc526b77b 100644
> > --- a/include/hw/arm/allwinner-h3.h
> > +++ b/include/hw/arm/allwinner-h3.h
> > @@ -27,6 +27,7 @@
> >   #include "hw/timer/allwinner-a10-pit.h"
> >   #include "hw/intc/arm_gic.h"
> >   #include "hw/misc/allwinner-h3-clk.h"
> > +#include "hw/misc/allwinner-h3-syscon.h"
> >   #include "target/arm/cpu.h"
> >
> >   #define AW_H3_SRAM_A1_BASE     (0x00000000)
> > @@ -111,6 +112,7 @@ typedef struct AwH3State {
> >       qemu_irq irq[AW_H3_GIC_NUM_SPI];
> >       AwA10PITState timer;
> >       AwH3ClockState ccu;
> > +    AwH3SysconState syscon;
> >       GICState gic;
> >       MemoryRegion sram_a1;
> >       MemoryRegion sram_a2;
> > diff --git a/include/hw/misc/allwinner-h3-syscon.h
> b/include/hw/misc/allwinner-h3-syscon.h
> > new file mode 100644
> > index 0000000000..22a2f2a11b
> > --- /dev/null
> > +++ b/include/hw/misc/allwinner-h3-syscon.h
> > @@ -0,0 +1,43 @@
> > +/*
> > + * Allwinner H3 System Control emulation
> > + *
> > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> > + *
> > + * This program is free software: you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/
> >.
> > + */
> > +
> > +#ifndef HW_MISC_ALLWINNER_H3_SYSCON_H
> > +#define HW_MISC_ALLWINNER_H3_SYSCON_H
> > +
> > +#include "hw/sysbus.h"
> > +
> > +#define AW_H3_SYSCON_REGS_MAX_ADDR  (0x30)
> > +#define AW_H3_SYSCON_REGS_NUM       ((AW_H3_SYSCON_REGS_MAX_ADDR / \
> > +                                      sizeof(uint32_t)) + 1)
> > +#define AW_H3_SYSCON_REGS_MEM_SIZE  (1024)
>
> "4.1. Memory Mapping" the System Control is 4KiB, isn't it?
>

Correct, I made a mistake there. Thanks, I'll change it and re-check the
other files as well.


>
> > +
> > +#define TYPE_AW_H3_SYSCON    "allwinner-h3-syscon"
> > +#define AW_H3_SYSCON(obj)    OBJECT_CHECK(AwH3SysconState, (obj), \
> > +                                          TYPE_AW_H3_SYSCON)
> > +
> > +typedef struct AwH3SysconState {
> > +    /*< private >*/
> > +    SysBusDevice parent_obj;
> > +    /*< public >*/
> > +
> > +    MemoryRegion iomem;
> > +    uint32_t regs[AW_H3_SYSCON_REGS_NUM];
> > +} AwH3SysconState;
> > +
> > +#endif
> >
>
>

--=20
Niek Linnenbank

--000000000000478d8a0599c67208
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 13, 2019 at 1:09 AM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 12/2/19 10:09 PM, Niek Linnenbank wrote:<br>
&gt; The Allwinner H3 System on Chip has an System Control<br>
&gt; module that provides system wide generic controls and<br>
&gt; device information. This commit adds support for the<br>
&gt; Allwinner H3 System Control module.<br>
&gt; <br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 11 ++<br>
&gt;=C2=A0 =C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/misc/allwinner-h3-syscon.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 139 ++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0include/hw/misc/allwinner-h3-syscon.h |=C2=A0 43 ++++++++<=
br>
&gt;=C2=A0 =C2=A05 files changed, 196 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/misc/allwinner-h3-syscon.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/misc/allwinner-h3-syscon.h<b=
r>
&gt; <br>
&gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
&gt; index afeb49c0ac..ebd8fde412 100644<br>
&gt; --- a/hw/arm/allwinner-h3.c<br>
&gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; @@ -41,6 +41,9 @@ static void aw_h3_init(Object *obj)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_init_child_obj(obj, &quot;ccu&quot;, =
&amp;s-&gt;ccu, sizeof(s-&gt;ccu),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_AW_H3_CLK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;syscon&quot;, &amp;s-&=
gt;syscon, sizeof(s-&gt;syscon),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_H3_SYSCON);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void aw_h3_realize(DeviceState *dev, Error **errp)<=
br>
&gt; @@ -184,6 +187,14 @@ static void aw_h3_realize(DeviceState *dev, Error=
 **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;cc=
u), 0, AW_H3_CCU_BASE);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /* System Control */<br>
&gt; +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp;s-&gt;syscon), tru=
e, &quot;realized&quot;, &amp;err);<br>
&gt; +=C2=A0 =C2=A0 if (err) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;syscon), 0, A=
W_H3_SYSCON_BASE);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Universal Serial Bus */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_=
EHCI0_BASE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq[AW_H3_GIC_SPI_EHCI0]);<br>
&gt; diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs<br>
&gt; index 200ed44ce1..b234aefba5 100644<br>
&gt; --- a/hw/misc/Makefile.objs<br>
&gt; +++ b/hw/misc/Makefile.objs<br>
&gt; @@ -29,6 +29,7 @@ common-obj-$(CONFIG_MACIO) +=3D macio/<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem.o<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-clk.o<=
br>
&gt; +common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-syscon.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_REALVIEW) +=3D arm_sysctl.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_NSERIES) +=3D cbus.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ECCMEMCTL) +=3D eccmemctl.o<br>
&gt; diff --git a/hw/misc/allwinner-h3-syscon.c b/hw/misc/allwinner-h3-sysc=
on.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..66bd518a05<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/misc/allwinner-h3-syscon.c<br>
&gt; @@ -0,0 +1,139 @@<br>
&gt; +/*<br>
&gt; + * Allwinner H3 System Control emulation<br>
&gt; + *<br>
&gt; + * Copyright (C) 2019 Niek Linnenbank &lt;<a href=3D"mailto:nieklinne=
nbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software: you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation, either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License<=
br>
&gt; + * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;migration/vmstate.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;hw/misc/allwinner-h3-syscon.h&quot;<br>
&gt; +<br>
&gt; +/* SYSCON register offsets */<br>
&gt; +#define REG_VER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(0x24)=C2=A0 /* Version */<br>
&gt; +#define REG_EMAC_PHY_CLK=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x30)=C2=A0 /* E=
MAC PHY Clock */<br>
&gt; +#define REG_INDEX(offset)=C2=A0 =C2=A0 =C2=A0 =C2=A0(offset / sizeof(=
uint32_t))<br>
&gt; +<br>
&gt; +/* SYSCON register reset values */<br>
&gt; +#define REG_VER_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0=
x0)<br>
&gt; +#define REG_EMAC_PHY_CLK_RST=C2=A0 =C2=A0 (0x58000)<br>
&gt; +<br>
&gt; +static uint64_t allwinner_h3_syscon_read(void *opaque, hwaddr offset,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0unsigned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const AwH3SysconState *s =3D (AwH3SysconState *)opaque;=
<br>
&gt; +=C2=A0 =C2=A0 const uint32_t idx =3D REG_INDEX(offset);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (idx &gt;=3D AW_H3_SYSCON_REGS_NUM) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
bad read offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return s-&gt;regs[idx];<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_h3_syscon_write(void *opaque, hwaddr offset,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t va=
l, unsigned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3SysconState *s =3D (AwH3SysconState *)opaque;<br>
&gt; +=C2=A0 =C2=A0 const uint32_t idx =3D REG_INDEX(offset);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (idx &gt;=3D AW_H3_SYSCON_REGS_NUM) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
bad write offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case REG_VER:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Version */<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[idx] =3D (uint32_t) val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps allwinner_h3_syscon_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D allwinner_h3_syscon_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D allwinner_h3_syscon_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
<br>
Can you point me to the datasheet page that says this region is <br>
restricted to 32-bit accesses? Maybe you want .valid -&gt; .impl instead?<b=
r>
<br></blockquote><div>Hehe well here I can only give the same answer as for=
 the SD/MMC driver: the datasheet</div><div>only provides the base address =
and register offsets, but nothing explicitely mentioned about alignment.</d=
iv><div>I do see that also for this device the registers are 32-bit aligned=
.</div><div><br></div><div>Does that mean I should change MemoryRegionOps t=
o . impl instead?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .unaligned =3D false<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_h3_syscon_reset(DeviceState *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3SysconState *s =3D AW_H3_SYSCON(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Set default values for registers */<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_VER)] =3D REG_VER_RST;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_EMAC_PHY_CLK)] =3D REG_EMAC_PH=
Y_CLK_RST;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_h3_syscon_realize(DeviceState *dev, Error **err=
p)<br>
&gt; +{<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_h3_syscon_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);<br>
&gt; +=C2=A0 =C2=A0 AwH3SysconState *s =3D AW_H3_SYSCON(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Memory mapping */<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem, OBJECT(s), &amp=
;allwinner_h3_syscon_ops, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_H3_SYSCON, AW_H3_SYSCON_REGS_MEM_SIZE);<br>
<br>
This definition isn&#39;t very helpful IMO, I&#39;d use the value in place:=
 &#39;4 * <br>
KiB&#39;.<br></blockquote><div>OK, I&#39;ll apply that too in the other dri=
vers.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;s-&gt;iomem);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const VMStateDescription allwinner_h3_syscon_vmstate =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D TYPE_AW_H3_SYSCON,<br>
<br>
Plain name.<br>
<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(regs, AwH3SysconStat=
e, AW_H3_SYSCON_REGS_NUM),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_h3_syscon_class_init(ObjectClass *klass, void *=
data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;reset =3D allwinner_h3_syscon_reset;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D allwinner_h3_syscon_realize;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;allwinner_h3_syscon_vmstate;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo allwinner_h3_syscon_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_H3_=
SYSCON,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEV=
ICE,<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D allwinner_h3_syscon_init,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(AwH3SysconState),<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D allwinner_h3_syscon_class_=
init,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_h3_syscon_register(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;allwinner_h3_syscon_info);<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(allwinner_h3_syscon_register)<br>
&gt; diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-=
h3.h<br>
&gt; index e596516c5c..2bc526b77b 100644<br>
&gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt; @@ -27,6 +27,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/timer/allwinner-a10-pit.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/intc/arm_gic.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-h3-clk.h&quot;<br>
&gt; +#include &quot;hw/misc/allwinner-h3-syscon.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;target/arm/cpu.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define AW_H3_SRAM_A1_BASE=C2=A0 =C2=A0 =C2=A0(0x00000000)=
<br>
&gt; @@ -111,6 +112,7 @@ typedef struct AwH3State {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_irq irq[AW_H3_GIC_NUM_SPI];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwA10PITState timer;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3ClockState ccu;<br>
&gt; +=C2=A0 =C2=A0 AwH3SysconState syscon;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GICState gic;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a2;<br>
&gt; diff --git a/include/hw/misc/allwinner-h3-syscon.h b/include/hw/misc/a=
llwinner-h3-syscon.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..22a2f2a11b<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/misc/allwinner-h3-syscon.h<br>
&gt; @@ -0,0 +1,43 @@<br>
&gt; +/*<br>
&gt; + * Allwinner H3 System Control emulation<br>
&gt; + *<br>
&gt; + * Copyright (C) 2019 Niek Linnenbank &lt;<a href=3D"mailto:nieklinne=
nbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software: you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation, either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License<=
br>
&gt; + * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef HW_MISC_ALLWINNER_H3_SYSCON_H<br>
&gt; +#define HW_MISC_ALLWINNER_H3_SYSCON_H<br>
&gt; +<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +<br>
&gt; +#define AW_H3_SYSCON_REGS_MAX_ADDR=C2=A0 (0x30)<br>
&gt; +#define AW_H3_SYSCON_REGS_NUM=C2=A0 =C2=A0 =C2=A0 =C2=A0((AW_H3_SYSCO=
N_REGS_MAX_ADDR / \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(uint=
32_t)) + 1)<br>
&gt; +#define AW_H3_SYSCON_REGS_MEM_SIZE=C2=A0 (1024)<br>
<br>
&quot;4.1. Memory Mapping&quot; the System Control is 4KiB, isn&#39;t it?<b=
r></blockquote><div><br></div><div>Correct, I made a mistake there. Thanks,=
 I&#39;ll change it and re-check the other files as well.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +#define TYPE_AW_H3_SYSCON=C2=A0 =C2=A0 &quot;allwinner-h3-syscon&quot=
;<br>
&gt; +#define AW_H3_SYSCON(obj)=C2=A0 =C2=A0 OBJECT_CHECK(AwH3SysconState, =
(obj), \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 TYPE_AW_H3_SYSCON)<br>
&gt; +<br>
&gt; +typedef struct AwH3SysconState {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion iomem;<br>
&gt; +=C2=A0 =C2=A0 uint32_t regs[AW_H3_SYSCON_REGS_NUM];<br>
&gt; +} AwH3SysconState;<br>
&gt; +<br>
&gt; +#endif<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000478d8a0599c67208--

