Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A614AC282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 21:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496892072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 21:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUh75nzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496892072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iownz-0004Vw-BW
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 16:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iowmt-0003Fk-PZ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 16:53:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iowmq-0002Ro-1v
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 16:53:19 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:42593)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iowmp-0002Qy-Og; Tue, 07 Jan 2020 16:53:16 -0500
Received: by mail-io1-xd44.google.com with SMTP id n11so955741iom.9;
 Tue, 07 Jan 2020 13:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lJFdr2Sc/74r7tYRGOB3RaqpgBcnvqe0WbiMGNijbZY=;
 b=aUh75nzzkusq8UNWxmAnMcvMiddaShaZJi9h9+bO3citk1a0NyI7XpZgVNBMMTGbA5
 EXFbFCX1dtcBIg950ibQluTp0uC9kgercUKNe21cYFfvHxuzCBCajq/GhecDXOWxYgwI
 /HPXmvkRy66wPETLpGY5y92r1PM0LRV7Lo/Ygts8woWEJEjCHozB0pROlQLwgsub7h5j
 MQtAshroGsESEixdcL43wu/LCsTMumOF3/qzUGl4OlRc71GR9/lS+HsqJ51UaNxJ3KKL
 66QNiyuOpkyY7nodzyaO1uUNOl+9msQ+aWaT0dIBxIcK4gcXJQcLiuyvyGVJD2YxzhJn
 N0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lJFdr2Sc/74r7tYRGOB3RaqpgBcnvqe0WbiMGNijbZY=;
 b=r+tgy7V5UyYhkxAm9HnhUIIQH0OnWTY7wyVTFJTg7G4/uHpcPDTLNzTSEyLFV9Lx8/
 cnrI4r2JZggTV7nNwPWuhSWqwXZr6pKDIBL7qKk2Szh8zks//L5/0B4/qiOE5e85Aa/j
 kvupBfk1vlkVu0OjgK+uE0GWtKu8XwDhW/cVTh1WtAig1YEbjGrJLotpgD0cpFsLCOzk
 VZY0KEQ0uiHV6YEzlC93h8YsEB7FYfHA+k9eauaNiEHcUmf+ECqGl4PwYKTy/5bNb7QK
 L9qdfw8fqZamTAnDdHCk2OCs8fpchMVt0H+JlAKIqWvj42TgjWtFvaMohaJU75KjRsyY
 3qJg==
X-Gm-Message-State: APjAAAXc8BZOxoovDPwVTjco+gezDzJdFregmhzv78S1zZl/C62fUtCx
 IWCWmf97MLIKHaxAGfzF+2eACaSPMltg98qWpOY=
X-Google-Smtp-Source: APXvYqzaTWxtc8kiM8dFRwFr7yTAMoOQ6Tkus3qIU4HrtazZVvDo7Z0YdugsOEZ6Sx/SXuqHVmIBs0ZEP3YLbGvNVwA=
X-Received: by 2002:a05:6602:25d3:: with SMTP id
 d19mr852182iop.217.1578433994558; 
 Tue, 07 Jan 2020 13:53:14 -0800 (PST)
MIME-Version: 1.0
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
 <20191216233519.29030-9-nieklinnenbank@gmail.com>
 <7153b766-4c3b-5272-3c3e-33e973e74e8f@redhat.com>
 <CAPan3Wob3Me-zbESYmFNQ4OczgLnxZZ0CtTxf8AHeRY4QyJ2+w@mail.gmail.com>
 <a1f0c5e1-36cd-126b-1fdf-22a641ab008a@redhat.com>
In-Reply-To: <a1f0c5e1-36cd-126b-1fdf-22a641ab008a@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 7 Jan 2020 22:53:03 +0100
Message-ID: <CAPan3Wo2+7UxaKZYt69hF9tppq48SP9a9p2+_m=tCDuzLdQSJA@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] arm: allwinner-h3: add Security Identifier device
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008c3b1e059b93cdb7"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008c3b1e059b93cdb7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2019 at 3:49 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 12/18/19 9:49 PM, Niek Linnenbank wrote:
> > Hi Philippe,
> >
> > On Tue, Dec 17, 2019 at 8:45 AM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> >
> >     Hi Niek,
> >
> >     On 12/17/19 12:35 AM, Niek Linnenbank wrote:
> >      > The Security Identifier device in Allwinner H3 System on Chip
> >      > gives applications a per-board unique identifier. This commit
> >      > adds support for the Allwinner H3 Security Identifier using
> >      > a 128-bit UUID value as input.
> >      >
> >      > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com
> >     <mailto:nieklinnenbank@gmail.com>>
> >      > ---
> >      >   include/hw/arm/allwinner-h3.h      |   2 +
> >      >   include/hw/misc/allwinner-h3-sid.h |  40 +++++++
> >      >   hw/arm/allwinner-h3.c              |   7 ++
> >      >   hw/arm/orangepi.c                  |   4 +
> >      >   hw/misc/allwinner-h3-sid.c         | 179
> >     +++++++++++++++++++++++++++++
> >      >   hw/misc/Makefile.objs              |   1 +
> >      >   hw/misc/trace-events               |   4 +
> >      >   7 files changed, 237 insertions(+)
> >      >   create mode 100644 include/hw/misc/allwinner-h3-sid.h
> >      >   create mode 100644 hw/misc/allwinner-h3-sid.c
> >      >
> >      > diff --git a/include/hw/arm/allwinner-h3.h
> >     b/include/hw/arm/allwinner-h3.h
> >      > index 8128ae6131..c98c1972a6 100644
> >      > --- a/include/hw/arm/allwinner-h3.h
> >      > +++ b/include/hw/arm/allwinner-h3.h
> >      > @@ -29,6 +29,7 @@
> >      >   #include "hw/misc/allwinner-h3-clk.h"
> >      >   #include "hw/misc/allwinner-h3-cpucfg.h"
> >      >   #include "hw/misc/allwinner-h3-syscon.h"
> >      > +#include "hw/misc/allwinner-h3-sid.h"
> >      >   #include "target/arm/cpu.h"
> >      >
> >      >   enum {
> >      > @@ -77,6 +78,7 @@ typedef struct AwH3State {
> >      >       AwH3ClockState ccu;
> >      >       AwH3CpuCfgState cpucfg;
> >      >       AwH3SysconState syscon;
> >      > +    AwH3SidState sid;
> >      >       GICState gic;
> >      >       MemoryRegion sram_a1;
> >      >       MemoryRegion sram_a2;
> >      > diff --git a/include/hw/misc/allwinner-h3-sid.h
> >     b/include/hw/misc/allwinner-h3-sid.h
> >      > new file mode 100644
> >      > index 0000000000..79c9a24459
> >      > --- /dev/null
> >      > +++ b/include/hw/misc/allwinner-h3-sid.h
> >      > @@ -0,0 +1,40 @@
> >      > +/*
> >      > + * Allwinner H3 Security ID emulation
> >      > + *
> >      > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com
> >     <mailto:nieklinnenbank@gmail.com>>
> >      > + *
> >      > + * This program is free software: you can redistribute it and/o=
r
> >     modify
> >      > + * it under the terms of the GNU General Public License as
> >     published by
> >      > + * the Free Software Foundation, either version 2 of the
> License, or
> >      > + * (at your option) any later version.
> >      > + *
> >      > + * This program is distributed in the hope that it will be
> useful,
> >      > + * but WITHOUT ANY WARRANTY; without even the implied warranty =
of
> >      > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See th=
e
> >      > + * GNU General Public License for more details.
> >      > + *
> >      > + * You should have received a copy of the GNU General Public
> License
> >      > + * along with this program.  If not, see
> >     <http://www.gnu.org/licenses/>.
> >      > + */
> >      > +
> >      > +#ifndef HW_MISC_ALLWINNER_H3_SID_H
> >      > +#define HW_MISC_ALLWINNER_H3_SID_H
> >      > +
> >      > +#include "hw/sysbus.h"
> >      > +#include "qemu/uuid.h"
> >      > +
> >      > +#define TYPE_AW_H3_SID    "allwinner-h3-sid"
> >      > +#define AW_H3_SID(obj)    OBJECT_CHECK(AwH3SidState, (obj),
> >     TYPE_AW_H3_SID)
> >      > +
> >      > +typedef struct AwH3SidState {
> >      > +    /*< private >*/
> >      > +    SysBusDevice parent_obj;
> >      > +    /*< public >*/
> >      > +
> >      > +    MemoryRegion iomem;
> >      > +    uint32_t control;
> >      > +    uint32_t rdkey;
> >      > +    QemuUUID identifier;
> >      > +} AwH3SidState;
> >      > +
> >      > +#endif
> >      > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> >      > index 1a9748ab2e..ba34f905cd 100644
> >      > --- a/hw/arm/allwinner-h3.c
> >      > +++ b/hw/arm/allwinner-h3.c
> >      > @@ -196,6 +196,9 @@ static void aw_h3_init(Object *obj)
> >      >
> >      >       sysbus_init_child_obj(obj, "cpucfg", &s->cpucfg,
> >     sizeof(s->cpucfg),
> >      >                             TYPE_AW_H3_CPUCFG);
> >      > +
> >      > +    sysbus_init_child_obj(obj, "sid", &s->sid, sizeof(s->sid),
> >      > +                          TYPE_AW_H3_SID);
> >
> >     Here add a property alias:
> >
> >              object_property_add_alias(obj, "identifier",
> OBJECT(&s->sid),
> >                                        "identifier", &error_abort);
> >
> >      >   }
> >      >
> >      >   static void aw_h3_realize(DeviceState *dev, Error **errp)
> >      > @@ -332,6 +335,10 @@ static void aw_h3_realize(DeviceState *dev,
> >     Error **errp)
> >      >       qdev_init_nofail(DEVICE(&s->cpucfg));
> >      >       sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0,
> >     s->memmap[AW_H3_CPUCFG]);
> >      >
> >      > +    /* Security Identifier */
> >      > +    qdev_init_nofail(DEVICE(&s->sid));
> >      > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0,
> >     s->memmap[AW_H3_SID]);
> >      > +
> >      >       /* Universal Serial Bus */
> >      >       sysbus_create_simple(TYPE_AW_H3_EHCI,
> s->memmap[AW_H3_EHCI0],
> >      >                            qdev_get_gpio_in(DEVICE(&s->gic),
> >      > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> >      > index 62cefc8c06..b01c4b4f01 100644
> >      > --- a/hw/arm/orangepi.c
> >      > +++ b/hw/arm/orangepi.c
> >      > @@ -62,6 +62,10 @@ static void orangepi_init(MachineState
> *machine)
> >      >           exit(1);
> >      >       }
> >      >
> >      > +    /* Setup SID properties */
> >      > +    qdev_prop_set_string(DEVICE(&s->h3->sid), "identifier",
> >      > +                         "8100c002-0001-0002-0003-000044556677"=
);
> >
> >     And here use the alias:
> >
> >              qdev_prop_set_string(DEVICE(&s->h3), "identifier",
> >
>  "8100c002-0001-0002-0003-000044556677");
> >
> >
> > Ah OK, I see what you mean. The boards should be using the SoC object
> > only and
> > not directly any of its sub devices, correct?
> >
> >
> >     What means this value? Don't you want to be able to set it from
> command
> >     line?
> >
> > The first word 0x02c00081 is the identifying word for the H3 SoC in the
> > SID data.
> > After that come the per-device unique specific bytes. This is documente=
d
> > at the end of this page in 'Currently known SID's' on the
> > linux-sunxi.org <http://linux-sunxi.org> Wiki:
> > https://linux-sunxi.org/SID_Register_Guide
> >
> > The remaining parts of this value I simply made up without any real
> meaning.
> > And yes, it would in fact make sense to have the user be able to
> > override it from the command line.
> > It is used by U-boot as an input for generating the MAC address. Linux
> > also reads it, but I did not investigate
> > how it us used there. I think I did make a TODO of using a cmdline
> > argument, but later forgot to actually implement it.
> >
> > Do you have a suggestion how to best provide the command line argument?
> > I do see '-device driver[,prop=3Dvalue]'
> > is there in the --help for qemu-system-arm, but it looks like that
> > should be used by the user for adding PCI / USB devices?
>
> Look for '-global' in the manpage:
>
>
>    -global driver.prop=3Dvalue
>    -global driver=3Ddriver,property=3Dproperty,value=3Dvalue
>
>      Set default value of driver's property prop to value.
>
>      In particular, you can use this to set driver properties
>      for devices which are created automatically by the machine
>      model. To create a device which is not created automatically
>      and set properties on it, use -device.
>
>      -global driver.prop=3Dvalue is shorthand for
>      -global driver=3Ddriver,property=3Dprop,value=3Dvalue.
>
> So this should work for your device:
>
>      -global
> allwinner-h3-sid.identifier=3D8100c002-0001-0002-0003-000044556677
>

Thanks, I tried this, however currently its not applied when used.
I think its because the orangepi.c file sets the property as well.

Its not a blocking problem if the user can't override the SID value, but it
would be a nice-to-have.
U-Boot uses its value for MAC generation and that can be overridden as well
by U-Boot itself.



> >
> >
> >      >       /* Mark H3 object realized */
> >      >       object_property_set_bool(OBJECT(s->h3), true, "realized",
> >     &error_abort);
> >      >       if (error_abort !=3D NULL) {
> >      > diff --git a/hw/misc/allwinner-h3-sid.c
> b/hw/misc/allwinner-h3-sid.c
> >      > new file mode 100644
> >      > index 0000000000..c472f2bcc6
> >      > --- /dev/null
> >      > +++ b/hw/misc/allwinner-h3-sid.c
> >      > @@ -0,0 +1,179 @@
> >      > +/*
> >      > + * Allwinner H3 Security ID emulation
> >      > + *
> >      > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com
> >     <mailto:nieklinnenbank@gmail.com>>
> >      > + *
> >      > + * This program is free software: you can redistribute it and/o=
r
> >     modify
> >      > + * it under the terms of the GNU General Public License as
> >     published by
> >      > + * the Free Software Foundation, either version 2 of the
> License, or
> >      > + * (at your option) any later version.
> >      > + *
> >      > + * This program is distributed in the hope that it will be
> useful,
> >      > + * but WITHOUT ANY WARRANTY; without even the implied warranty =
of
> >      > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See th=
e
> >      > + * GNU General Public License for more details.
> >      > + *
> >      > + * You should have received a copy of the GNU General Public
> License
> >      > + * along with this program.  If not, see
> >     <http://www.gnu.org/licenses/>.
> >      > + */
> >      > +
> >      > +#include "qemu/osdep.h"
> >      > +#include "qemu/units.h"
> >      > +#include "hw/sysbus.h"
> >      > +#include "migration/vmstate.h"
> >      > +#include "qemu/log.h"
> >      > +#include "qemu/module.h"
> >      > +#include "qemu/guest-random.h"
> >      > +#include "qapi/error.h"
> >      > +#include "hw/qdev-properties.h"
> >      > +#include "hw/misc/allwinner-h3-sid.h"
> >      > +#include "trace.h"
> >      > +
> >      > +/* SID register offsets */
> >      > +enum {
> >      > +    REG_PRCTL =3D 0x40,   /* Control */
> >      > +    REG_RDKEY =3D 0x60,   /* Read Key */
> >      > +};
> >      > +
> >      > +/* SID register flags */
> >      > +enum {
> >      > +    REG_PRCTL_WRITE   =3D 0x0002, /* Unknown write flag */
> >      > +    REG_PRCTL_OP_LOCK =3D 0xAC00, /* Lock operation */
> >      > +};
> >      > +
> >      > +static uint64_t allwinner_h3_sid_read(void *opaque, hwaddr
> offset,
> >      > +                                      unsigned size)
> >      > +{
> >      > +    const AwH3SidState *s =3D (AwH3SidState *)opaque;
> >      > +    uint64_t val =3D 0;
> >      > +
> >      > +    switch (offset) {
> >      > +    case REG_PRCTL:    /* Control */
> >      > +        val =3D s->control;
> >      > +        break;
> >      > +    case REG_RDKEY:    /* Read Key */
> >      > +        val =3D s->rdkey;
> >      > +        break;
> >      > +    default:
> >      > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read offset
> >     0x%04x\n",
> >      > +                      __func__, (uint32_t)offset);
> >      > +        return 0;
> >      > +    }
> >      > +
> >      > +    trace_allwinner_h3_sid_read(offset, val, size);
> >      > +
> >      > +    return val;
> >      > +}
> >      > +
> >      > +static void allwinner_h3_sid_write(void *opaque, hwaddr offset,
> >      > +                                   uint64_t val, unsigned size)
> >      > +{
> >      > +    AwH3SidState *s =3D (AwH3SidState *)opaque;
> >      > +
> >      > +    trace_allwinner_h3_sid_write(offset, val, size);
> >      > +
> >      > +    switch (offset) {
> >      > +    case REG_PRCTL:    /* Control */
> >      > +        s->control =3D val;
> >      > +
> >      > +        if ((s->control & REG_PRCTL_OP_LOCK) &&
> >      > +            (s->control & REG_PRCTL_WRITE)) {
> >      > +            uint32_t id =3D s->control >> 16;
> >      > +
> >      > +            if (id < sizeof(QemuUUID)) {
> >      > +                s->rdkey =3D (s->identifier.data[id]) |
> >      > +                           (s->identifier.data[id + 1] << 8) |
> >      > +                           (s->identifier.data[id + 2] << 16) |
> >      > +                           (s->identifier.data[id + 3] << 24);
> >
> >     This is:
> >
> >                          s->rdkey =3D ldl_le_p(&s->identifier.data[id])=
;
> >
> >      > +            }
> >      > +        }
> >      > +        s->control &=3D ~REG_PRCTL_WRITE;
> >      > +        break;
> >      > +    case REG_RDKEY:    /* Read Key */
> >
> >     Read in a write()?
> >
> >     Maybe we can simply /* fall through */ LOG_GUEST_ERROR?
> >
> >
> > When writing this module, I looked at how U-Boot is using the SID
> > registers and simply
> > named the registers after the names used by U-Boot. You can find this
> > part in arch/arm/mach-sunxi/cpu_info.c:111,
> > functions sun8i_efuse_read() and sunxi_get_sid(). U-Boot defines
> > SIDC_RDKEY, so I named the register also rdkey.
> > I used the U-Boot source because the Allwinner H3 datasheet does not
> > document the registers. Later I
> > found the SID page on the linux-sunxi wiki that I mentioned earlier, an=
d
> > they also describe the same register names:
> >
> > https://linux-sunxi.org/SID_Register_Guide
>
> Hmm this page describe this register as RW, odd. I think this is wrong
> because we deal with a fuse, and we program it via the REG_PRKEY
> register. Does Linux/U-Boot do write access to this register?
> We can start logging LOG_GUEST_ERROR, and correct it if we notice this
> register is really writable (which I doubt).
>
>
Yes it seems so. The PRCTL is the "Control" register (R/W) and the RDKEY
the "Data" register (RO).
You can see the Linux implementation in drivers/nvmem/sunxi_sid.c
For U-Boot the file is in arch/arm/mach-sunxi/cpu_info.c, functions
sunxi_get_sid and sun8i_efuse_read.

Regards,
Niek


> >
> > I suspect the information on this page is written based on the source
> > code from the original SDK (which I did not study btw)
> [...]
>
>

--=20
Niek Linnenbank

--0000000000008c3b1e059b93cdb7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 30, 2019 at 3:49 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 12/18/19 9:49 PM, Niek Linnenbank wrote:<br>
&gt; Hi Philippe,<br>
&gt; <br>
&gt; On Tue, Dec 17, 2019 at 8:45 AM Philippe Mathieu-Daud=C3=A9 <br>
&gt; &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redh=
at.com</a> &lt;mailto:<a href=3D"mailto:philmd@redhat.com" target=3D"_blank=
">philmd@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Niek,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 12/17/19 12:35 AM, Niek Linnenbank wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; The Security Identifier device in Allwinner H=
3 System on Chip<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; gives applications a per-board unique identif=
ier. This commit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; adds support for the Allwinner H3 Security Id=
entifier using<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; a 128-bit UUID value as input.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D=
"mailto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.co=
m</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:nieklinnenbank@gmail.c=
om" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h=C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0include/hw/misc/allwinner-h3-sid.=
h |=C2=A0 40 +++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/misc/allwinner-h3-sid.c=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 179<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/misc/Makefile.objs=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/misc/trace-events=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A07 files changed, 237 insertions(+=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0create mode 100644 include/hw/mis=
c/allwinner-h3-sid.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0create mode 100644 hw/misc/allwin=
ner-h3-sid.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/include/hw/arm/allwinner-h3.h<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0b/include/hw/arm/allwinner-h3.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 8128ae6131..c98c1972a6 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -29,6 +29,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-=
h3-clk.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-=
h3-cpucfg.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-=
h3-syscon.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/misc/allwinner-h3-sid.h&qu=
ot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;target/arm/cpu.h&q=
uot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -77,6 +78,7 @@ typedef struct AwH3State {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3ClockState ccu;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3CpuCfgState cpu=
cfg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3SysconState sys=
con;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AwH3SidState sid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GICState gic;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a=
1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a=
2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/include/hw/misc/allwinner-h3-sid=
.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0b/include/hw/misc/allwinner-h3-sid.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 0000000000..79c9a24459<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/include/hw/misc/allwinner-h3-sid.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,40 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Allwinner H3 Security ID emulation<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Copyright (C) 2019 Niek Linnenbank &lt;<a=
 href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@=
gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:nieklinnenbank@gmail.c=
om" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * This program is free software: you can re=
distribute it and/or<br>
&gt;=C2=A0 =C2=A0 =C2=A0modify<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * it under the terms of the GNU General Pub=
lic License as<br>
&gt;=C2=A0 =C2=A0 =C2=A0published by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * the Free Software Foundation, either vers=
ion 2 of the License, or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * (at your option) any later version.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * This program is distributed in the hope t=
hat it will be useful,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * but WITHOUT ANY WARRANTY; without even th=
e implied warranty of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * MERCHANTABILITY or FITNESS FOR A PARTICUL=
AR PURPOSE.=C2=A0 See the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * GNU General Public License for more detai=
ls.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * You should have received a copy of the GN=
U General Public License<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * along with this program.=C2=A0 If not, se=
e<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://www.gnu.org/licenses/" rel=3D=
"noreferrer" target=3D"_blank">http://www.gnu.org/licenses/</a>&gt;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#ifndef HW_MISC_ALLWINNER_H3_SID_H<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define HW_MISC_ALLWINNER_H3_SID_H<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/uuid.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define TYPE_AW_H3_SID=C2=A0 =C2=A0 &quot;al=
lwinner-h3-sid&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define AW_H3_SID(obj)=C2=A0 =C2=A0 OBJECT_C=
HECK(AwH3SidState, (obj),<br>
&gt;=C2=A0 =C2=A0 =C2=A0TYPE_AW_H3_SID)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +typedef struct AwH3SidState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MemoryRegion iomem;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t control;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t rdkey;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 QemuUUID identifier;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +} AwH3SidState;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/a=
llwinner-h3.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 1a9748ab2e..ba34f905cd 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/arm/allwinner-h3.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -196,6 +196,9 @@ static void aw_h3_init(Ob=
ject *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_init_child_o=
bj(obj, &quot;cpucfg&quot;, &amp;s-&gt;cpucfg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0sizeof(s-&gt;cpucfg),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_AW_H3_CPUCF=
G);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &qu=
ot;sid&quot;, &amp;s-&gt;sid, sizeof(s-&gt;sid),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_H3_SID);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Here add a property alias:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_add_al=
ias(obj, &quot;identifier&quot;, OBJECT(&amp;s-&gt;sid),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;identifier&quot;, &amp;error_abort);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0static void aw_h3_realize(DeviceS=
tate *dev, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -332,6 +335,10 @@ static void aw_h3_realiz=
e(DeviceState *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_init_nofail(DE=
VICE(&amp;s-&gt;cpucfg));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS=
_BUS_DEVICE(&amp;s-&gt;cpucfg), 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0s-&gt;memmap[AW_H3_CPUCFG]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Security Identifier */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(&amp;s=
-&gt;sid));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE=
(&amp;s-&gt;sid), 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0s-&gt;memmap[AW_H3_SID]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Universal Serial=
 Bus */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_create_simpl=
e(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H3_EHCI0],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVIC=
E(&amp;s-&gt;gic),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/arm/orangepi.c b/hw/arm/orang=
epi.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 62cefc8c06..b01c4b4f01 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/arm/orangepi.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/arm/orangepi.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -62,6 +62,10 @@ static void orangepi_init(=
MachineState *machine)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(=
1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Setup SID properties */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_string(DEVICE(&a=
mp;s-&gt;h3-&gt;sid), &quot;identifier&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;8100c002-0001-0002-00=
03-000044556677&quot;);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0And here use the alias:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_string(D=
EVICE(&amp;s-&gt;h3), &quot;identifier&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;8100c002-0001-=
0002-0003-000044556677&quot;);<br>
&gt; <br>
&gt; <br>
&gt; Ah OK, I see what you mean. The boards should be using the SoC object =
<br>
&gt; only and<br>
&gt; not directly any of its sub devices, correct?<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0What means this value? Don&#39;t you want to be abl=
e to set it from command<br>
&gt;=C2=A0 =C2=A0 =C2=A0line?<br>
&gt; <br>
&gt; The first word 0x02c00081 is the identifying word for the H3 SoC in th=
e <br>
&gt; SID data.<br>
&gt; After that come the per-device unique specific bytes. This is document=
ed <br>
&gt; at the end of this page in &#39;Currently known SID&#39;s&#39; on the =
<br>
&gt; <a href=3D"http://linux-sunxi.org" rel=3D"noreferrer" target=3D"_blank=
">linux-sunxi.org</a> &lt;<a href=3D"http://linux-sunxi.org" rel=3D"norefer=
rer" target=3D"_blank">http://linux-sunxi.org</a>&gt; Wiki:<br>
&gt; <a href=3D"https://linux-sunxi.org/SID_Register_Guide" rel=3D"noreferr=
er" target=3D"_blank">https://linux-sunxi.org/SID_Register_Guide</a><br>
&gt; <br>
&gt; The remaining parts of this value I simply made up without any real me=
aning.<br>
&gt; And yes, it would in fact make sense to have the user be able to <br>
&gt; override it from the command line.<br>
&gt; It is used by U-boot as an input for generating the MAC address. Linux=
 <br>
&gt; also reads it, but I did not investigate<br>
&gt; how it us used there. I think I did make a TODO of using a cmdline <br=
>
&gt; argument, but later forgot to actually implement it.<br>
&gt; <br>
&gt; Do you have a suggestion how to best provide the command line argument=
? <br>
&gt; I do see &#39;-device driver[,prop=3Dvalue]&#39;<br>
&gt; is there in the --help for qemu-system-arm, but it looks like that <br=
>
&gt; should be used by the user for adding PCI / USB devices?<br>
<br>
Look for &#39;-global&#39; in the manpage:<br>
<br>
<br>
=C2=A0 =C2=A0-global driver.prop=3Dvalue<br>
=C2=A0 =C2=A0-global driver=3Ddriver,property=3Dproperty,value=3Dvalue<br>
<br>
=C2=A0 =C2=A0 =C2=A0Set default value of driver&#39;s property prop to valu=
e.<br>
<br>
=C2=A0 =C2=A0 =C2=A0In particular, you can use this to set driver propertie=
s<br>
=C2=A0 =C2=A0 =C2=A0for devices which are created automatically by the mach=
ine<br>
=C2=A0 =C2=A0 =C2=A0model. To create a device which is not created automati=
cally<br>
=C2=A0 =C2=A0 =C2=A0and set properties on it, use -device.<br>
<br>
=C2=A0 =C2=A0 =C2=A0-global driver.prop=3Dvalue is shorthand for<br>
=C2=A0 =C2=A0 =C2=A0-global driver=3Ddriver,property=3Dprop,value=3Dvalue.<=
br>
<br>
So this should work for your device:<br>
<br>
=C2=A0 =C2=A0 =C2=A0-global <br>
allwinner-h3-sid.identifier=3D8100c002-0001-0002-0003-000044556677<br></blo=
ckquote><div><br></div><div>Thanks, I tried this, however currently its not=
 applied when used.</div><div>I think its because the orangepi.c file sets =
the property as well. <br></div><div><br></div><div>Its not a blocking prob=
lem if the user can&#39;t override the SID value, but it would be a nice-to=
-have.<br></div><div>U-Boot uses its value for MAC generation and that can =
be overridden as well by U-Boot itself. <br></div><div><br></div><div><br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Mark H3 object r=
ealized */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set=
_bool(OBJECT(s-&gt;h3), true, &quot;realized&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (error_abort !=
=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/misc/allwinner-h3-sid.c b/hw/=
misc/allwinner-h3-sid.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 0000000000..c472f2bcc6<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/misc/allwinner-h3-sid.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,179 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Allwinner H3 Security ID emulation<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Copyright (C) 2019 Niek Linnenbank &lt;<a=
 href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@=
gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:nieklinnenbank@gmail.c=
om" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * This program is free software: you can re=
distribute it and/or<br>
&gt;=C2=A0 =C2=A0 =C2=A0modify<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * it under the terms of the GNU General Pub=
lic License as<br>
&gt;=C2=A0 =C2=A0 =C2=A0published by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * the Free Software Foundation, either vers=
ion 2 of the License, or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * (at your option) any later version.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * This program is distributed in the hope t=
hat it will be useful,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * but WITHOUT ANY WARRANTY; without even th=
e implied warranty of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * MERCHANTABILITY or FITNESS FOR A PARTICUL=
AR PURPOSE.=C2=A0 See the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * GNU General Public License for more detai=
ls.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * You should have received a copy of the GN=
U General Public License<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * along with this program.=C2=A0 If not, se=
e<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://www.gnu.org/licenses/" rel=3D=
"noreferrer" target=3D"_blank">http://www.gnu.org/licenses/</a>&gt;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/units.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;migration/vmstate.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/log.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/module.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/guest-random.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/qdev-properties.h&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/misc/allwinner-h3-sid.h&qu=
ot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;trace.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/* SID register offsets */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 REG_PRCTL =3D 0x40,=C2=A0 =C2=
=A0/* Control */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 REG_RDKEY =3D 0x60,=C2=A0 =C2=
=A0/* Read Key */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/* SID register flags */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 REG_PRCTL_WRITE=C2=A0 =C2=A0=
=3D 0x0002, /* Unknown write flag */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 REG_PRCTL_OP_LOCK =3D 0xAC00, =
/* Lock operation */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static uint64_t allwinner_h3_sid_read(void *=
opaque, hwaddr offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 unsigned size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 const AwH3SidState *s =3D (AwH=
3SidState *)opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint64_t val =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_PRCTL:=C2=A0 =C2=A0 /=
* Control */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;co=
ntrol;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_RDKEY:=C2=A0 =C2=A0 /=
* Read Key */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;rd=
key;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LO=
G_GUEST_ERROR, &quot;%s: bad read offset<br>
&gt;=C2=A0 =C2=A0 =C2=A00x%04x\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 trace_allwinner_h3_sid_read(of=
fset, val, size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void allwinner_h3_sid_write(void *opa=
que, hwaddr offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint64_t val, unsigned size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AwH3SidState *s =3D (AwH3SidSt=
ate *)opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 trace_allwinner_h3_sid_write(o=
ffset, val, size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_PRCTL:=C2=A0 =C2=A0 /=
* Control */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;control =
=3D val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((s-&gt;contr=
ol &amp; REG_PRCTL_OP_LOCK) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (s=
-&gt;control &amp; REG_PRCTL_WRITE)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ui=
nt32_t id =3D s-&gt;control &gt;&gt; 16;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (id &lt; sizeof(QemuUUID)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 s-&gt;rdkey =3D (s-&gt;identifier.data[id]) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;identifier.da=
ta[id + 1] &lt;&lt; 8) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;identifier.da=
ta[id + 2] &lt;&lt; 16) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;identifier.da=
ta[id + 3] &lt;&lt; 24);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This is:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 s-&gt;rdkey =3D ldl_le_p(&amp;s-&gt;identifier.data[id=
]);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;control &a=
mp;=3D ~REG_PRCTL_WRITE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_RDKEY:=C2=A0 =C2=A0 /=
* Read Key */<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Read in a write()?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Maybe we can simply /* fall through */ LOG_GUEST_ER=
ROR?<br>
&gt; <br>
&gt; <br>
&gt; When writing this module, I looked at how U-Boot is using the SID <br>
&gt; registers and simply<br>
&gt; named the registers after the names used by U-Boot. You can find this =
<br>
&gt; part in arch/arm/mach-sunxi/cpu_info.c:111,<br>
&gt; functions sun8i_efuse_read() and sunxi_get_sid(). U-Boot defines <br>
&gt; SIDC_RDKEY, so I named the register also rdkey.<br>
&gt; I used the U-Boot source because the Allwinner H3 datasheet does not <=
br>
&gt; document the registers. Later I<br>
&gt; found the SID page on the linux-sunxi wiki that I mentioned earlier, a=
nd <br>
&gt; they also describe the same register names:<br>
&gt; <br>
&gt; <a href=3D"https://linux-sunxi.org/SID_Register_Guide" rel=3D"noreferr=
er" target=3D"_blank">https://linux-sunxi.org/SID_Register_Guide</a><br>
<br>
Hmm this page describe this register as RW, odd. I think this is wrong <br>
because we deal with a fuse, and we program it via the REG_PRKEY <br>
register. Does Linux/U-Boot do write access to this register?<br>
We can start logging LOG_GUEST_ERROR, and correct it if we notice this <br>
register is really writable (which I doubt).<br>
<br></blockquote><div><br></div><div>Yes it seems so. The PRCTL is the &quo=
t;Control&quot; register (R/W) and the RDKEY the &quot;Data&quot; register =
(RO).</div><div>You can see the Linux implementation in drivers/nvmem/sunxi=
_sid.c</div><div>For U-Boot the file is in arch/arm/mach-sunxi/cpu_info.c, =
functions sunxi_get_sid and sun8i_efuse_read.<br></div><div><br></div><div>=
Regards,</div><div>Niek<br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
&gt; <br>
&gt; I suspect the information on this page is written based on the source =
<br>
&gt; code from the original SDK (which I did not study btw)<br>
[...]<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000008c3b1e059b93cdb7--

