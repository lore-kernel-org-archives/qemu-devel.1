Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51167C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C74A20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="Assg89nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C74A20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybVb-00016c-9M
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1iybUh-0008Db-00
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:10:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1iybUd-0007mH-3r
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:10:25 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36941)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1iybUc-0007cI-Ff
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:10:23 -0500
Received: by mail-wr1-x441.google.com with SMTP id w15so18062611wru.4
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 05:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=QoNWt+nrbzCiWEjgFYJdkBuQpLlDHAWkKK+GrQ/dvkg=;
 b=Assg89nwJzz7nmT7zChEKCsFgWgrZSqT+doPefxjQE9ddUuSW4wlb/kidRXNuKzdGm
 DPfScho4eOHgxsgPTKZjMg5PrkN+11HyRqwPFi9c8suTLLxe3K7bViCzQDr2guEiprBy
 5YAnE3kMKZO9OKcpyKrDJrwm5JVL++qLEWPO6BmlF6zZOSV0uDsj8ecocK4jZHGiulJ4
 bmFB78FnzjY3NMNEytLi+qeVHHrY4H5jZqTU3fU/X/k6mhB1UJZ6kQtanKbODlCGqo59
 ngxgjtDYX142/YbZxRcL2DOL7zdHjXR26bNnpb85Tgbz3MPM5tOgMWubD9WAnwJrGw1Q
 owsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=QoNWt+nrbzCiWEjgFYJdkBuQpLlDHAWkKK+GrQ/dvkg=;
 b=cSjip3FyPeTPit/7674rQenpQP+OOEgLMqW1Bg2rLNRfE/ctoBv4FXLbkk2mfAmoWW
 35C6+RKlQIcKq9nwu9v37ma9SYuDLCqAe8z8Mv71T8lVe4QzrwHjhD3dJQGyxKJ1u97E
 nHRHeJf58FK14nEyCONmTtVoxTgip8z5O6geLntGwMSOZgydRV9A1FnUYXS5+NsycYwM
 6YgH4EcmiUuBzOW9QK/FZXtPxNExivIKlypCTdYBPCirJwqDEamxO+8kHNUfQeQqHhhr
 CwEU1RZxVlaZcZzPjXy6nQgarF89PYR2iM1K+esywnbsXRa09A/aqNCba//TTRq0oQae
 Mp9w==
X-Gm-Message-State: APjAAAWjoIyrVr6gGOFVtXQ8AVouAG9dPVhjM9zOMDckOeDrAdYvnFNc
 jLoyyrXTv5wZz+vYcaFFTsYWBA==
X-Google-Smtp-Source: APXvYqyftzg9il+g6pnxDT6LLz0bO3DMPVEhIu1+mi5Bo4WE1C2qYRLuhSuTC2rwlYjbl7FNO8gZRw==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr14925013wro.234.1580735420827; 
 Mon, 03 Feb 2020 05:10:20 -0800 (PST)
Received: from minyard.net ([81.145.206.46])
 by smtp.gmail.com with ESMTPSA id w26sm22645474wmi.8.2020.02.03.05.10.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Feb 2020 05:10:20 -0800 (PST)
Date: Mon, 3 Feb 2020 07:10:17 -0600
From: Corey Minyard <cminyard@mvista.com>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v3 07/17] hw/arm/allwinner: add Security Identifier device
Message-ID: <20200203131017.GE2626@minyard.net>
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-8-nieklinnenbank@gmail.com>
 <8be03fbb-74f2-e688-76b1-ab504f25f8e4@redhat.com>
 <20200120175918.GA2949@minyard.net>
 <CAPan3WpJ_L7OyiC0hod0e436xOUZ2sHCfQqRmAsvD7hTPrBsDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPan3WpJ_L7OyiC0hod0e436xOUZ2sHCfQqRmAsvD7hTPrBsDg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Reply-To: cminyard@mvista.com
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, qemu-arm <qemu-arm@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Feb 02, 2020 at 10:27:49PM +0100, Niek Linnenbank wrote:
> Hi Corey,
> 
> Thanks for reviewing!
> 
> On Mon, Jan 20, 2020 at 6:59 PM Corey Minyard <cminyard@mvista.com> wrote:
> 
> > On Sat, Jan 18, 2020 at 04:25:08PM +0100, Philippe Mathieu-Daudé wrote:
> > > Cc'ing Corey/David for good advices about using UUID.
> >
> > Is there any reason you didn't use the built-in qemu UUID for this?  It
> > would simplify things in general.
> >
> 
> Currently the Allwinner SID device is using the QemuUUID type from
> include/qemu/uuid.h.
> Is that the build-in UUID you are referring to or should I use something
> else?

You are using the QemuUUID type, which is of course what you should do,
but you aren't using the UUID generated by qemu (at least that I can find).
That in include/sysemu/sysemu.h and is named qemu_uuid.  Whether you
should use that or not depends on your needs.  If you just need some
uuid, then that's what you should probably use.  If you need something
the user can individually control for this device, for instance, then
that probably won't do.

> 
> 
> > Also, in case no one else say, you have tabs in your code that you need
> > to get rid of.
> >
> >
> If there are any tabs in the code, it was not intended. I re-checked this
> patch and others
> again but found no tabs in the code.
> Could you please point out where you found the extra tabs?

My apologies, I saw 1-character misalignments, and that usually means
that there's a tab.  But it looks like it has something to do with the
way it was forwarded.  I didn't get the original email.

-corey

> 
> Regards,
> Niek
> 
> 
> > -corey
> >
> > >
> > > On 1/8/20 9:00 PM, Niek Linnenbank wrote:
> > > > The Security Identifier device found in various Allwinner System on
> > Chip
> > > > designs gives applications a per-board unique identifier. This commit
> > > > adds support for the Allwinner Security Identifier using a 128-bit
> > > > UUID value as input.
> > > >
> > > > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > > > ---
> > > >   include/hw/arm/allwinner-h3.h   |   3 +
> > > >   include/hw/misc/allwinner-sid.h |  61 ++++++++++++
> > > >   hw/arm/allwinner-h3.c           |  11 ++-
> > > >   hw/arm/orangepi.c               |   4 +
> > > >   hw/misc/allwinner-sid.c         | 170
> > ++++++++++++++++++++++++++++++++
> > > >   hw/misc/Makefile.objs           |   1 +
> > > >   hw/misc/trace-events            |   4 +
> > > >   7 files changed, 253 insertions(+), 1 deletion(-)
> > > >   create mode 100644 include/hw/misc/allwinner-sid.h
> > > >   create mode 100644 hw/misc/allwinner-sid.c
> > > >
> > > > diff --git a/include/hw/arm/allwinner-h3.h
> > b/include/hw/arm/allwinner-h3.h
> > > > index 5a25a92eae..9ed365507c 100644
> > > > --- a/include/hw/arm/allwinner-h3.h
> > > > +++ b/include/hw/arm/allwinner-h3.h
> > > > @@ -46,6 +46,7 @@
> > > >   #include "hw/misc/allwinner-h3-ccu.h"
> > > >   #include "hw/misc/allwinner-cpucfg.h"
> > > >   #include "hw/misc/allwinner-h3-sysctrl.h"
> > > > +#include "hw/misc/allwinner-sid.h"
> > > >   #include "target/arm/cpu.h"
> > > >   /**
> > > > @@ -63,6 +64,7 @@ enum {
> > > >       AW_H3_SRAM_A2,
> > > >       AW_H3_SRAM_C,
> > > >       AW_H3_SYSCTRL,
> > > > +    AW_H3_SID,
> > > >       AW_H3_EHCI0,
> > > >       AW_H3_OHCI0,
> > > >       AW_H3_EHCI1,
> > > > @@ -115,6 +117,7 @@ typedef struct AwH3State {
> > > >       AwH3ClockCtlState ccu;
> > > >       AwCpuCfgState cpucfg;
> > > >       AwH3SysCtrlState sysctrl;
> > > > +    AwSidState sid;
> > > >       GICState gic;
> > > >       MemoryRegion sram_a1;
> > > >       MemoryRegion sram_a2;
> > > > diff --git a/include/hw/misc/allwinner-sid.h
> > b/include/hw/misc/allwinner-sid.h
> > > > new file mode 100644
> > > > index 0000000000..41189967e2
> > > > --- /dev/null
> > > > +++ b/include/hw/misc/allwinner-sid.h
> > > > @@ -0,0 +1,61 @@
> > > > +/*
> > > > + * Allwinner Security ID emulation
> > > > + *
> > > > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> > > > + *
> > > > + * This program is free software: you can redistribute it and/or
> > modify
> > > > + * it under the terms of the GNU General Public License as published
> > by
> > > > + * the Free Software Foundation, either version 2 of the License, or
> > > > + * (at your option) any later version.
> > > > + *
> > > > + * This program is distributed in the hope that it will be useful,
> > > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > > + * GNU General Public License for more details.
> > > > + *
> > > > + * You should have received a copy of the GNU General Public License
> > > > + * along with this program.  If not, see <
> > http://www.gnu.org/licenses/>.
> > > > + */
> > > > +
> > > > +#ifndef HW_MISC_ALLWINNER_SID_H
> > > > +#define HW_MISC_ALLWINNER_SID_H
> > > > +
> > > > +#include "qemu/osdep.h"
> > > > +#include "qom/object.h"
> > > > +#include "hw/sysbus.h"
> > > > +#include "qemu/uuid.h"
> > > > +
> > > > +/**
> > > > + * Object model
> > > > + * @{
> > > > + */
> > > > +
> > > > +#define TYPE_AW_SID    "allwinner-sid"
> > > > +#define AW_SID(obj) \
> > > > +    OBJECT_CHECK(AwSidState, (obj), TYPE_AW_SID)
> > > > +
> > > > +/** @} */
> > > > +
> > > > +/**
> > > > + * Allwinner Security ID object instance state
> > > > + */
> > > > +typedef struct AwSidState {
> > > > +    /*< private >*/
> > > > +    SysBusDevice parent_obj;
> > > > +    /*< public >*/
> > > > +
> > > > +    /** Maps I/O registers in physical memory */
> > > > +    MemoryRegion iomem;
> > > > +
> > > > +    /** Control register defines how and what to read */
> > > > +    uint32_t control;
> > > > +
> > > > +    /** RdKey register contains the data retrieved by the device */
> > > > +    uint32_t rdkey;
> > > > +
> > > > +    /** Stores the emulated device identifier */
> > > > +    QemuUUID identifier;
> > > > +
> > > > +} AwSidState;
> > > > +
> > > > +#endif /* HW_MISC_ALLWINNER_SID_H */
> > > > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> > > > index e9ad6d23df..af7317e86a 100644
> > > > --- a/hw/arm/allwinner-h3.c
> > > > +++ b/hw/arm/allwinner-h3.c
> > > > @@ -36,6 +36,7 @@ const hwaddr allwinner_h3_memmap[] = {
> > > >       [AW_H3_SRAM_A2]    = 0x00044000,
> > > >       [AW_H3_SRAM_C]     = 0x00010000,
> > > >       [AW_H3_SYSCTRL]    = 0x01c00000,
> > > > +    [AW_H3_SID]        = 0x01c14000,
> > > >       [AW_H3_EHCI0]      = 0x01c1a000,
> > > >       [AW_H3_OHCI0]      = 0x01c1a400,
> > > >       [AW_H3_EHCI1]      = 0x01c1b000,
> > > > @@ -76,7 +77,6 @@ struct AwH3Unimplemented {
> > > >       { "mmc0",      0x01c0f000, 4 * KiB },
> > > >       { "mmc1",      0x01c10000, 4 * KiB },
> > > >       { "mmc2",      0x01c11000, 4 * KiB },
> > > > -    { "sid",       0x01c14000, 1 * KiB },
> > > >       { "crypto",    0x01c15000, 4 * KiB },
> > > >       { "msgbox",    0x01c17000, 4 * KiB },
> > > >       { "spinlock",  0x01c18000, 4 * KiB },
> > > > @@ -196,6 +196,11 @@ static void allwinner_h3_init(Object *obj)
> > > >       sysbus_init_child_obj(obj, "cpucfg", &s->cpucfg,
> > sizeof(s->cpucfg),
> > > >                             TYPE_AW_CPUCFG);
> > > > +
> > > > +    sysbus_init_child_obj(obj, "sid", &s->sid, sizeof(s->sid),
> > > > +                          TYPE_AW_SID);
> > > > +    object_property_add_alias(obj, "identifier", OBJECT(&s->sid),
> > > > +                              "identifier", &error_abort);
> > > >   }
> > > >   static void allwinner_h3_realize(DeviceState *dev, Error **errp)
> > > > @@ -316,6 +321,10 @@ static void allwinner_h3_realize(DeviceState
> > *dev, Error **errp)
> > > >       qdev_init_nofail(DEVICE(&s->cpucfg));
> > > >       sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0,
> > s->memmap[AW_H3_CPUCFG]);
> > > > +    /* Security Identifier */
> > > > +    qdev_init_nofail(DEVICE(&s->sid));
> > > > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H3_SID]);
> > > > +
> > > >       /* Universal Serial Bus */
> > > >       sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
> > > >                            qdev_get_gpio_in(DEVICE(&s->gic),
> > > > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> > > > index 051184f14f..a7f870c88b 100644
> > > > --- a/hw/arm/orangepi.c
> > > > +++ b/hw/arm/orangepi.c
> > > > @@ -54,6 +54,10 @@ static void orangepi_init(MachineState *machine)
> > > >       object_property_set_int(OBJECT(s->h3), 24000000, "clk1-freq",
> > > >                               &error_abort);
> > > > +    /* Setup SID properties */
> > > > +    qdev_prop_set_string(DEVICE(s->h3), "identifier",
> > > > +                         "8100c002-0001-0002-0003-000044556677");
> > > > +
> > > >       /* Mark H3 object realized */
> > > >       object_property_set_bool(OBJECT(s->h3), true, "realized",
> > &error_abort);
> > > > diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c
> > > > new file mode 100644
> > > > index 0000000000..954de935bc
> > > > --- /dev/null
> > > > +++ b/hw/misc/allwinner-sid.c
> > > > @@ -0,0 +1,170 @@
> > > > +/*
> > > > + * Allwinner Security ID emulation
> > > > + *
> > > > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> > > > + *
> > > > + * This program is free software: you can redistribute it and/or
> > modify
> > > > + * it under the terms of the GNU General Public License as published
> > by
> > > > + * the Free Software Foundation, either version 2 of the License, or
> > > > + * (at your option) any later version.
> > > > + *
> > > > + * This program is distributed in the hope that it will be useful,
> > > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > > + * GNU General Public License for more details.
> > > > + *
> > > > + * You should have received a copy of the GNU General Public License
> > > > + * along with this program.  If not, see <
> > http://www.gnu.org/licenses/>.
> > > > + */
> > > > +
> > > > +#include "qemu/osdep.h"
> > > > +#include "qemu/units.h"
> > > > +#include "hw/sysbus.h"
> > > > +#include "migration/vmstate.h"
> > > > +#include "qemu/log.h"
> > > > +#include "qemu/module.h"
> > > > +#include "qemu/guest-random.h"
> > > > +#include "qapi/error.h"
> > > > +#include "hw/qdev-properties.h"
> > > > +#include "hw/misc/allwinner-sid.h"
> > > > +#include "trace.h"
> > > > +
> > > > +/* SID register offsets */
> > > > +enum {
> > > > +    REG_PRCTL = 0x40,   /* Control */
> > > > +    REG_RDKEY = 0x60,   /* Read Key */
> > > > +};
> > > > +
> > > > +/* SID register flags */
> > > > +enum {
> > > > +    REG_PRCTL_WRITE   = 0x0002, /* Unknown write flag */
> > > > +    REG_PRCTL_OP_LOCK = 0xAC00, /* Lock operation */
> > > > +};
> > > > +
> > > > +static uint64_t allwinner_sid_read(void *opaque, hwaddr offset,
> > > > +                                   unsigned size)
> > > > +{
> > > > +    const AwSidState *s = AW_SID(opaque);
> > > > +    uint64_t val = 0;
> > > > +
> > > > +    switch (offset) {
> > > > +    case REG_PRCTL:    /* Control */
> > > > +        val = s->control;
> > > > +        break;
> > > > +    case REG_RDKEY:    /* Read Key */
> > > > +        val = s->rdkey;
> > > > +        break;
> > > > +    default:
> > > > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> > 0x%04x\n",
> > > > +                      __func__, (uint32_t)offset);
> > > > +        return 0;
> > > > +    }
> > > > +
> > > > +    trace_allwinner_sid_read(offset, val, size);
> > > > +
> > > > +    return val;
> > > > +}
> > > > +
> > > > +static void allwinner_sid_write(void *opaque, hwaddr offset,
> > > > +                                uint64_t val, unsigned size)
> > > > +{
> > > > +    AwSidState *s = AW_SID(opaque);
> > > > +
> > > > +    trace_allwinner_sid_write(offset, val, size);
> > > > +
> > > > +    switch (offset) {
> > > > +    case REG_PRCTL:    /* Control */
> > > > +        s->control = val;
> > > > +
> > > > +        if ((s->control & REG_PRCTL_OP_LOCK) &&
> > > > +            (s->control & REG_PRCTL_WRITE)) {
> > > > +            uint32_t id = s->control >> 16;
> > > > +
> > > > +            if (id < sizeof(QemuUUID)) {
> > > > +                s->rdkey = (s->identifier.data[id]) |
> > > > +                           (s->identifier.data[id + 1] << 8) |
> > > > +                           (s->identifier.data[id + 2] << 16) |
> > > > +                           (s->identifier.data[id + 3] << 24);
> > > > +            }
> > > > +        }
> > > > +        s->control &= ~REG_PRCTL_WRITE;
> > > > +        break;
> > > > +    case REG_RDKEY:    /* Read Key */
> > > > +        break;
> > > > +    default:
> > > > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> > 0x%04x\n",
> > > > +                      __func__, (uint32_t)offset);
> > > > +        break;
> > > > +    }
> > > > +}
> > > > +
> > > > +static const MemoryRegionOps allwinner_sid_ops = {
> > > > +    .read = allwinner_sid_read,
> > > > +    .write = allwinner_sid_write,
> > > > +    .endianness = DEVICE_NATIVE_ENDIAN,
> > > > +    .valid = {
> > > > +        .min_access_size = 4,
> > > > +        .max_access_size = 4,
> > > > +    },
> > > > +    .impl.min_access_size = 4,
> > > > +};
> > > > +
> > > > +static void allwinner_sid_reset(DeviceState *dev)
> > > > +{
> > > > +    AwSidState *s = AW_SID(dev);
> > > > +
> > > > +    /* Set default values for registers */
> > > > +    s->control = 0;
> > > > +    s->rdkey = 0;
> > > > +}
> > > > +
> > > > +static void allwinner_sid_init(Object *obj)
> > > > +{
> > > > +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> > > > +    AwSidState *s = AW_SID(obj);
> > > > +
> > > > +    /* Memory mapping */
> > > > +    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_sid_ops, s,
> > > > +                           TYPE_AW_SID, 1 * KiB);
> > > > +    sysbus_init_mmio(sbd, &s->iomem);
> > > > +}
> > > > +
> > > > +static Property allwinner_sid_properties[] = {
> > > > +    DEFINE_PROP_UUID_NODEFAULT("identifier", AwSidState, identifier),
> > > > +    DEFINE_PROP_END_OF_LIST()
> > > > +};
> > > > +
> > > > +static const VMStateDescription allwinner_sid_vmstate = {
> > > > +    .name = "allwinner-sid",
> > > > +    .version_id = 1,
> > > > +    .minimum_version_id = 1,
> > > > +    .fields = (VMStateField[]) {
> > > > +        VMSTATE_UINT32(control, AwSidState),
> > > > +        VMSTATE_UINT32(rdkey, AwSidState),
> > > > +        VMSTATE_END_OF_LIST()
> > > > +    }
> > > > +};
> > > > +
> > > > +static void allwinner_sid_class_init(ObjectClass *klass, void *data)
> > > > +{
> > > > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > > > +
> > > > +    dc->reset = allwinner_sid_reset;
> > > > +    dc->vmsd = &allwinner_sid_vmstate;
> > > > +    dc->props = allwinner_sid_properties;
> > > > +}
> > > > +
> > > > +static const TypeInfo allwinner_sid_info = {
> > > > +    .name          = TYPE_AW_SID,
> > > > +    .parent        = TYPE_SYS_BUS_DEVICE,
> > > > +    .instance_init = allwinner_sid_init,
> > > > +    .instance_size = sizeof(AwSidState),
> > > > +    .class_init    = allwinner_sid_class_init,
> > > > +};
> > > > +
> > > > +static void allwinner_sid_register(void)
> > > > +{
> > > > +    type_register_static(&allwinner_sid_info);
> > > > +}
> > > > +
> > > > +type_init(allwinner_sid_register)
> > > > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> > > > index 12c2c306b5..59500d5681 100644
> > > > --- a/hw/misc/Makefile.objs
> > > > +++ b/hw/misc/Makefile.objs
> > > > @@ -31,6 +31,7 @@ common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
> > > >   common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-ccu.o
> > > >   obj-$(CONFIG_ALLWINNER_H3) += allwinner-cpucfg.o
> > > >   common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-sysctrl.o
> > > > +common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-sid.o
> > > >   common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
> > > >   common-obj-$(CONFIG_NSERIES) += cbus.o
> > > >   common-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
> > > > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> > > > index d3e0952429..67d8bf493c 100644
> > > > --- a/hw/misc/trace-events
> > > > +++ b/hw/misc/trace-events
> > > > @@ -5,6 +5,10 @@ allwinner_cpucfg_cpu_reset(uint8_t cpu_id, uint32_t
> > reset_addr) "id %u, reset_ad
> > > >   allwinner_cpucfg_read(uint64_t offset, uint64_t data, unsigned size)
> > "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> > > >   allwinner_cpucfg_write(uint64_t offset, uint64_t data, unsigned
> > size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> > > > +# allwinner-sid.c
> > > > +allwinner_sid_read(uint64_t offset, uint64_t data, unsigned size)
> > "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> > > > +allwinner_sid_write(uint64_t offset, uint64_t data, unsigned size)
> > "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> > > > +
> > > >   # eccmemctl.c
> > > >   ecc_mem_writel_mer(uint32_t val) "Write memory enable 0x%08x"
> > > >   ecc_mem_writel_mdr(uint32_t val) "Write memory delay 0x%08x"
> > > >
> > >
> >
> 
> 
> -- 
> Niek Linnenbank

