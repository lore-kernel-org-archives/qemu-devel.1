Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9760C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 21:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501F92067C
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 21:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwFULLgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501F92067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyMnY-0002fU-Hu
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 16:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iyMmj-0001nk-AB
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 16:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iyMmf-0004Nh-P2
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 16:28:05 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:44164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iyMmf-0004M9-Fv; Sun, 02 Feb 2020 16:28:01 -0500
Received: by mail-io1-xd44.google.com with SMTP id z16so9745610iod.11;
 Sun, 02 Feb 2020 13:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gkqxyJQ65eTWn/Yt5fczrQDu/EuyokK44pE8f220aHw=;
 b=cwFULLgDMl/nQC0TX2N2Mjjz14TMdTvsvZa+dqbCaN4m1+PQwkVFjxETbAYKbQiHu+
 3jnfcTXLAjOSwWcbJl2H2AeHvVn707cRR1WsPzCvl2z2d/t6TkeXAaczWI8iwwC/jYhO
 9+Sa280hpt7huzp/1cG24ChNKxzuFJ9Ryp936osP4vvpBGXPzxBLgN1iCgc84KXSnOPw
 34wAZVomjdLdJ5tP6FWgoD4n7BiGyOCoBMaPpOQSPjcWBGoVrAoGmt5ZNkCoR3wla+Ew
 RpFMrvY8KuHScke7d3mTZmRf4e3z26xh83jS1RnhoL48rfgQzW8jN472bdWz2hokh1jg
 ij5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gkqxyJQ65eTWn/Yt5fczrQDu/EuyokK44pE8f220aHw=;
 b=OAGPouT30CfjqfsTzh8T/QG1QO8O9z4vorM+PGXKhS1crWqFucqTE3DOiuyYHYHKOy
 kTzwgFrgt+Anu1U+ut/YounhhJSBmryPGVa5XUnmVwgjPRBl5+DqAcvc+7BfsFhWL88e
 cJ/Ww7YuxOyULNgVpAy1QnpeWj0hifebJyaRGAkzRuU4uVuYc2AAamFHCjNFFAvWqlSK
 8KaeeaMDU6i0bzEFG0TUc4Pj7mEb7V9en26gIj7RmKlkDZXTdy2AhevEPlRAHj8HwpJc
 TgWvCtErF0mx7AyT7hJCs46mrbTgn3x5qIuPU3ZSMAv2vQAImOG9Fek/wWBDHFGCNQ/+
 ftJw==
X-Gm-Message-State: APjAAAWWjzciEIPcAF+2/cSLgEcQwjQmZU2wgo3BR1yi0fhiBh4IzRN1
 CGKWmLr+EZvuzsB9LfDD1hVHuo400WOWcbnV3YY=
X-Google-Smtp-Source: APXvYqz9U3cSjPy2z/buH0g5MrldxinRta4ygUenhWb2UX4oXB78rp3VBNrFxnpIw6Y2hieHayxGvVsj+QzTwi09Tbk=
X-Received: by 2002:a6b:7902:: with SMTP id i2mr15781528iop.67.1580678880661; 
 Sun, 02 Feb 2020 13:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-8-nieklinnenbank@gmail.com>
 <8be03fbb-74f2-e688-76b1-ab504f25f8e4@redhat.com>
 <20200120175918.GA2949@minyard.net>
In-Reply-To: <20200120175918.GA2949@minyard.net>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 2 Feb 2020 22:27:49 +0100
Message-ID: <CAPan3WpJ_L7OyiC0hod0e436xOUZ2sHCfQqRmAsvD7hTPrBsDg@mail.gmail.com>
Subject: Re: [PATCH v3 07/17] hw/arm/allwinner: add Security Identifier device
To: cminyard@mvista.com
Content-Type: multipart/alternative; boundary="0000000000002f94bc059d9e7bb2"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002f94bc059d9e7bb2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Corey,

Thanks for reviewing!

On Mon, Jan 20, 2020 at 6:59 PM Corey Minyard <cminyard@mvista.com> wrote:

> On Sat, Jan 18, 2020 at 04:25:08PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Cc'ing Corey/David for good advices about using UUID.
>
> Is there any reason you didn't use the built-in qemu UUID for this?  It
> would simplify things in general.
>

Currently the Allwinner SID device is using the QemuUUID type from
include/qemu/uuid.h.
Is that the build-in UUID you are referring to or should I use something
else?


> Also, in case no one else say, you have tabs in your code that you need
> to get rid of.
>
>
If there are any tabs in the code, it was not intended. I re-checked this
patch and others
again but found no tabs in the code.
Could you please point out where you found the extra tabs?

Regards,
Niek


> -corey
>
> >
> > On 1/8/20 9:00 PM, Niek Linnenbank wrote:
> > > The Security Identifier device found in various Allwinner System on
> Chip
> > > designs gives applications a per-board unique identifier. This commit
> > > adds support for the Allwinner Security Identifier using a 128-bit
> > > UUID value as input.
> > >
> > > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > > ---
> > >   include/hw/arm/allwinner-h3.h   |   3 +
> > >   include/hw/misc/allwinner-sid.h |  61 ++++++++++++
> > >   hw/arm/allwinner-h3.c           |  11 ++-
> > >   hw/arm/orangepi.c               |   4 +
> > >   hw/misc/allwinner-sid.c         | 170
> ++++++++++++++++++++++++++++++++
> > >   hw/misc/Makefile.objs           |   1 +
> > >   hw/misc/trace-events            |   4 +
> > >   7 files changed, 253 insertions(+), 1 deletion(-)
> > >   create mode 100644 include/hw/misc/allwinner-sid.h
> > >   create mode 100644 hw/misc/allwinner-sid.c
> > >
> > > diff --git a/include/hw/arm/allwinner-h3.h
> b/include/hw/arm/allwinner-h3.h
> > > index 5a25a92eae..9ed365507c 100644
> > > --- a/include/hw/arm/allwinner-h3.h
> > > +++ b/include/hw/arm/allwinner-h3.h
> > > @@ -46,6 +46,7 @@
> > >   #include "hw/misc/allwinner-h3-ccu.h"
> > >   #include "hw/misc/allwinner-cpucfg.h"
> > >   #include "hw/misc/allwinner-h3-sysctrl.h"
> > > +#include "hw/misc/allwinner-sid.h"
> > >   #include "target/arm/cpu.h"
> > >   /**
> > > @@ -63,6 +64,7 @@ enum {
> > >       AW_H3_SRAM_A2,
> > >       AW_H3_SRAM_C,
> > >       AW_H3_SYSCTRL,
> > > +    AW_H3_SID,
> > >       AW_H3_EHCI0,
> > >       AW_H3_OHCI0,
> > >       AW_H3_EHCI1,
> > > @@ -115,6 +117,7 @@ typedef struct AwH3State {
> > >       AwH3ClockCtlState ccu;
> > >       AwCpuCfgState cpucfg;
> > >       AwH3SysCtrlState sysctrl;
> > > +    AwSidState sid;
> > >       GICState gic;
> > >       MemoryRegion sram_a1;
> > >       MemoryRegion sram_a2;
> > > diff --git a/include/hw/misc/allwinner-sid.h
> b/include/hw/misc/allwinner-sid.h
> > > new file mode 100644
> > > index 0000000000..41189967e2
> > > --- /dev/null
> > > +++ b/include/hw/misc/allwinner-sid.h
> > > @@ -0,0 +1,61 @@
> > > +/*
> > > + * Allwinner Security ID emulation
> > > + *
> > > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> > > + *
> > > + * This program is free software: you can redistribute it and/or
> modify
> > > + * it under the terms of the GNU General Public License as published
> by
> > > + * the Free Software Foundation, either version 2 of the License, or
> > > + * (at your option) any later version.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > + *
> > > + * You should have received a copy of the GNU General Public License
> > > + * along with this program.  If not, see <
> http://www.gnu.org/licenses/>.
> > > + */
> > > +
> > > +#ifndef HW_MISC_ALLWINNER_SID_H
> > > +#define HW_MISC_ALLWINNER_SID_H
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "qom/object.h"
> > > +#include "hw/sysbus.h"
> > > +#include "qemu/uuid.h"
> > > +
> > > +/**
> > > + * Object model
> > > + * @{
> > > + */
> > > +
> > > +#define TYPE_AW_SID    "allwinner-sid"
> > > +#define AW_SID(obj) \
> > > +    OBJECT_CHECK(AwSidState, (obj), TYPE_AW_SID)
> > > +
> > > +/** @} */
> > > +
> > > +/**
> > > + * Allwinner Security ID object instance state
> > > + */
> > > +typedef struct AwSidState {
> > > +    /*< private >*/
> > > +    SysBusDevice parent_obj;
> > > +    /*< public >*/
> > > +
> > > +    /** Maps I/O registers in physical memory */
> > > +    MemoryRegion iomem;
> > > +
> > > +    /** Control register defines how and what to read */
> > > +    uint32_t control;
> > > +
> > > +    /** RdKey register contains the data retrieved by the device */
> > > +    uint32_t rdkey;
> > > +
> > > +    /** Stores the emulated device identifier */
> > > +    QemuUUID identifier;
> > > +
> > > +} AwSidState;
> > > +
> > > +#endif /* HW_MISC_ALLWINNER_SID_H */
> > > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> > > index e9ad6d23df..af7317e86a 100644
> > > --- a/hw/arm/allwinner-h3.c
> > > +++ b/hw/arm/allwinner-h3.c
> > > @@ -36,6 +36,7 @@ const hwaddr allwinner_h3_memmap[] =3D {
> > >       [AW_H3_SRAM_A2]    =3D 0x00044000,
> > >       [AW_H3_SRAM_C]     =3D 0x00010000,
> > >       [AW_H3_SYSCTRL]    =3D 0x01c00000,
> > > +    [AW_H3_SID]        =3D 0x01c14000,
> > >       [AW_H3_EHCI0]      =3D 0x01c1a000,
> > >       [AW_H3_OHCI0]      =3D 0x01c1a400,
> > >       [AW_H3_EHCI1]      =3D 0x01c1b000,
> > > @@ -76,7 +77,6 @@ struct AwH3Unimplemented {
> > >       { "mmc0",      0x01c0f000, 4 * KiB },
> > >       { "mmc1",      0x01c10000, 4 * KiB },
> > >       { "mmc2",      0x01c11000, 4 * KiB },
> > > -    { "sid",       0x01c14000, 1 * KiB },
> > >       { "crypto",    0x01c15000, 4 * KiB },
> > >       { "msgbox",    0x01c17000, 4 * KiB },
> > >       { "spinlock",  0x01c18000, 4 * KiB },
> > > @@ -196,6 +196,11 @@ static void allwinner_h3_init(Object *obj)
> > >       sysbus_init_child_obj(obj, "cpucfg", &s->cpucfg,
> sizeof(s->cpucfg),
> > >                             TYPE_AW_CPUCFG);
> > > +
> > > +    sysbus_init_child_obj(obj, "sid", &s->sid, sizeof(s->sid),
> > > +                          TYPE_AW_SID);
> > > +    object_property_add_alias(obj, "identifier", OBJECT(&s->sid),
> > > +                              "identifier", &error_abort);
> > >   }
> > >   static void allwinner_h3_realize(DeviceState *dev, Error **errp)
> > > @@ -316,6 +321,10 @@ static void allwinner_h3_realize(DeviceState
> *dev, Error **errp)
> > >       qdev_init_nofail(DEVICE(&s->cpucfg));
> > >       sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0,
> s->memmap[AW_H3_CPUCFG]);
> > > +    /* Security Identifier */
> > > +    qdev_init_nofail(DEVICE(&s->sid));
> > > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H3_SID]=
);
> > > +
> > >       /* Universal Serial Bus */
> > >       sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
> > >                            qdev_get_gpio_in(DEVICE(&s->gic),
> > > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> > > index 051184f14f..a7f870c88b 100644
> > > --- a/hw/arm/orangepi.c
> > > +++ b/hw/arm/orangepi.c
> > > @@ -54,6 +54,10 @@ static void orangepi_init(MachineState *machine)
> > >       object_property_set_int(OBJECT(s->h3), 24000000, "clk1-freq",
> > >                               &error_abort);
> > > +    /* Setup SID properties */
> > > +    qdev_prop_set_string(DEVICE(s->h3), "identifier",
> > > +                         "8100c002-0001-0002-0003-000044556677");
> > > +
> > >       /* Mark H3 object realized */
> > >       object_property_set_bool(OBJECT(s->h3), true, "realized",
> &error_abort);
> > > diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c
> > > new file mode 100644
> > > index 0000000000..954de935bc
> > > --- /dev/null
> > > +++ b/hw/misc/allwinner-sid.c
> > > @@ -0,0 +1,170 @@
> > > +/*
> > > + * Allwinner Security ID emulation
> > > + *
> > > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> > > + *
> > > + * This program is free software: you can redistribute it and/or
> modify
> > > + * it under the terms of the GNU General Public License as published
> by
> > > + * the Free Software Foundation, either version 2 of the License, or
> > > + * (at your option) any later version.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > + *
> > > + * You should have received a copy of the GNU General Public License
> > > + * along with this program.  If not, see <
> http://www.gnu.org/licenses/>.
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "qemu/units.h"
> > > +#include "hw/sysbus.h"
> > > +#include "migration/vmstate.h"
> > > +#include "qemu/log.h"
> > > +#include "qemu/module.h"
> > > +#include "qemu/guest-random.h"
> > > +#include "qapi/error.h"
> > > +#include "hw/qdev-properties.h"
> > > +#include "hw/misc/allwinner-sid.h"
> > > +#include "trace.h"
> > > +
> > > +/* SID register offsets */
> > > +enum {
> > > +    REG_PRCTL =3D 0x40,   /* Control */
> > > +    REG_RDKEY =3D 0x60,   /* Read Key */
> > > +};
> > > +
> > > +/* SID register flags */
> > > +enum {
> > > +    REG_PRCTL_WRITE   =3D 0x0002, /* Unknown write flag */
> > > +    REG_PRCTL_OP_LOCK =3D 0xAC00, /* Lock operation */
> > > +};
> > > +
> > > +static uint64_t allwinner_sid_read(void *opaque, hwaddr offset,
> > > +                                   unsigned size)
> > > +{
> > > +    const AwSidState *s =3D AW_SID(opaque);
> > > +    uint64_t val =3D 0;
> > > +
> > > +    switch (offset) {
> > > +    case REG_PRCTL:    /* Control */
> > > +        val =3D s->control;
> > > +        break;
> > > +    case REG_RDKEY:    /* Read Key */
> > > +        val =3D s->rdkey;
> > > +        break;
> > > +    default:
> > > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> 0x%04x\n",
> > > +                      __func__, (uint32_t)offset);
> > > +        return 0;
> > > +    }
> > > +
> > > +    trace_allwinner_sid_read(offset, val, size);
> > > +
> > > +    return val;
> > > +}
> > > +
> > > +static void allwinner_sid_write(void *opaque, hwaddr offset,
> > > +                                uint64_t val, unsigned size)
> > > +{
> > > +    AwSidState *s =3D AW_SID(opaque);
> > > +
> > > +    trace_allwinner_sid_write(offset, val, size);
> > > +
> > > +    switch (offset) {
> > > +    case REG_PRCTL:    /* Control */
> > > +        s->control =3D val;
> > > +
> > > +        if ((s->control & REG_PRCTL_OP_LOCK) &&
> > > +            (s->control & REG_PRCTL_WRITE)) {
> > > +            uint32_t id =3D s->control >> 16;
> > > +
> > > +            if (id < sizeof(QemuUUID)) {
> > > +                s->rdkey =3D (s->identifier.data[id]) |
> > > +                           (s->identifier.data[id + 1] << 8) |
> > > +                           (s->identifier.data[id + 2] << 16) |
> > > +                           (s->identifier.data[id + 3] << 24);
> > > +            }
> > > +        }
> > > +        s->control &=3D ~REG_PRCTL_WRITE;
> > > +        break;
> > > +    case REG_RDKEY:    /* Read Key */
> > > +        break;
> > > +    default:
> > > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> 0x%04x\n",
> > > +                      __func__, (uint32_t)offset);
> > > +        break;
> > > +    }
> > > +}
> > > +
> > > +static const MemoryRegionOps allwinner_sid_ops =3D {
> > > +    .read =3D allwinner_sid_read,
> > > +    .write =3D allwinner_sid_write,
> > > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > > +    .valid =3D {
> > > +        .min_access_size =3D 4,
> > > +        .max_access_size =3D 4,
> > > +    },
> > > +    .impl.min_access_size =3D 4,
> > > +};
> > > +
> > > +static void allwinner_sid_reset(DeviceState *dev)
> > > +{
> > > +    AwSidState *s =3D AW_SID(dev);
> > > +
> > > +    /* Set default values for registers */
> > > +    s->control =3D 0;
> > > +    s->rdkey =3D 0;
> > > +}
> > > +
> > > +static void allwinner_sid_init(Object *obj)
> > > +{
> > > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> > > +    AwSidState *s =3D AW_SID(obj);
> > > +
> > > +    /* Memory mapping */
> > > +    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_sid_ops, =
s,
> > > +                           TYPE_AW_SID, 1 * KiB);
> > > +    sysbus_init_mmio(sbd, &s->iomem);
> > > +}
> > > +
> > > +static Property allwinner_sid_properties[] =3D {
> > > +    DEFINE_PROP_UUID_NODEFAULT("identifier", AwSidState, identifier)=
,
> > > +    DEFINE_PROP_END_OF_LIST()
> > > +};
> > > +
> > > +static const VMStateDescription allwinner_sid_vmstate =3D {
> > > +    .name =3D "allwinner-sid",
> > > +    .version_id =3D 1,
> > > +    .minimum_version_id =3D 1,
> > > +    .fields =3D (VMStateField[]) {
> > > +        VMSTATE_UINT32(control, AwSidState),
> > > +        VMSTATE_UINT32(rdkey, AwSidState),
> > > +        VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > > +
> > > +static void allwinner_sid_class_init(ObjectClass *klass, void *data)
> > > +{
> > > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > > +
> > > +    dc->reset =3D allwinner_sid_reset;
> > > +    dc->vmsd =3D &allwinner_sid_vmstate;
> > > +    dc->props =3D allwinner_sid_properties;
> > > +}
> > > +
> > > +static const TypeInfo allwinner_sid_info =3D {
> > > +    .name          =3D TYPE_AW_SID,
> > > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > > +    .instance_init =3D allwinner_sid_init,
> > > +    .instance_size =3D sizeof(AwSidState),
> > > +    .class_init    =3D allwinner_sid_class_init,
> > > +};
> > > +
> > > +static void allwinner_sid_register(void)
> > > +{
> > > +    type_register_static(&allwinner_sid_info);
> > > +}
> > > +
> > > +type_init(allwinner_sid_register)
> > > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> > > index 12c2c306b5..59500d5681 100644
> > > --- a/hw/misc/Makefile.objs
> > > +++ b/hw/misc/Makefile.objs
> > > @@ -31,6 +31,7 @@ common-obj-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem.o
> > >   common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-ccu.o
> > >   obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-cpucfg.o
> > >   common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-sysctrl.o
> > > +common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-sid.o
> > >   common-obj-$(CONFIG_REALVIEW) +=3D arm_sysctl.o
> > >   common-obj-$(CONFIG_NSERIES) +=3D cbus.o
> > >   common-obj-$(CONFIG_ECCMEMCTL) +=3D eccmemctl.o
> > > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> > > index d3e0952429..67d8bf493c 100644
> > > --- a/hw/misc/trace-events
> > > +++ b/hw/misc/trace-events
> > > @@ -5,6 +5,10 @@ allwinner_cpucfg_cpu_reset(uint8_t cpu_id, uint32_t
> reset_addr) "id %u, reset_ad
> > >   allwinner_cpucfg_read(uint64_t offset, uint64_t data, unsigned size=
)
> "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> > >   allwinner_cpucfg_write(uint64_t offset, uint64_t data, unsigned
> size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> > > +# allwinner-sid.c
> > > +allwinner_sid_read(uint64_t offset, uint64_t data, unsigned size)
> "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> > > +allwinner_sid_write(uint64_t offset, uint64_t data, unsigned size)
> "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> > > +
> > >   # eccmemctl.c
> > >   ecc_mem_writel_mer(uint32_t val) "Write memory enable 0x%08x"
> > >   ecc_mem_writel_mdr(uint32_t val) "Write memory delay 0x%08x"
> > >
> >
>


--=20
Niek Linnenbank

--0000000000002f94bc059d9e7bb2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Corey,</div><div><br></div><div>Thanks for reviewi=
ng!<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Mon, Jan 20, 2020 at 6:59 PM Corey Minyard &lt;<a href=3D"mailto:=
cminyard@mvista.com">cminyard@mvista.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On Sat, Jan 18, 2020 at 04:25:08PM =
+0100, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; Cc&#39;ing Corey/David for good advices about using UUID.<br>
<br>
Is there any reason you didn&#39;t use the built-in qemu UUID for this?=C2=
=A0 It<br>
would simplify things in general.<br></blockquote><div><br></div><div>Curre=
ntly the Allwinner SID device is using the QemuUUID type from include/qemu/=
uuid.h.</div><div>Is that the build-in UUID you are referring to or should =
I use something else?</div><div><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
Also, in case no one else say, you have tabs in your code that you need<br>
to get rid of.<br>
<br></blockquote><div><br></div><div>If there are any tabs in the code, it =
was not intended. I re-checked this patch and others</div><div>again but fo=
und no tabs in the code.<br></div><div>Could you please point out where you=
 found the extra tabs?<br></div><div><br></div><div>Regards,</div><div>Niek=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
-corey<br>
<br>
&gt; <br>
&gt; On 1/8/20 9:00 PM, Niek Linnenbank wrote:<br>
&gt; &gt; The Security Identifier device found in various Allwinner System =
on Chip<br>
&gt; &gt; designs gives applications a per-board unique identifier. This co=
mmit<br>
&gt; &gt; adds support for the Allwinner Security Identifier using a 128-bi=
t<br>
&gt; &gt; UUID value as input.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenba=
nk@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0|=C2=A0 =C2=
=A03 +<br>
&gt; &gt;=C2=A0 =C2=A0include/hw/misc/allwinner-sid.h |=C2=A0 61 ++++++++++=
++<br>
&gt; &gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 11 ++-<br>
&gt; &gt;=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt; &gt;=C2=A0 =C2=A0hw/misc/allwinner-sid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 170 ++++++++++++++++++++++++++++++++<br>
&gt; &gt;=C2=A0 =C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt; &gt;=C2=A0 =C2=A0hw/misc/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt; &gt;=C2=A0 =C2=A07 files changed, 253 insertions(+), 1 deletion(-)<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 include/hw/misc/allwinner-sid.h<br=
>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 hw/misc/allwinner-sid.c<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwi=
nner-h3.h<br>
&gt; &gt; index 5a25a92eae..9ed365507c 100644<br>
&gt; &gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt; &gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt; &gt; @@ -46,6 +46,7 @@<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-h3-ccu.h&quot;<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-cpucfg.h&quot;<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-h3-sysctrl.h&quot;<b=
r>
&gt; &gt; +#include &quot;hw/misc/allwinner-sid.h&quot;<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;target/arm/cpu.h&quot;<br>
&gt; &gt;=C2=A0 =C2=A0/**<br>
&gt; &gt; @@ -63,6 +64,7 @@ enum {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_SRAM_A2,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_SRAM_C,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_SYSCTRL,<br>
&gt; &gt; +=C2=A0 =C2=A0 AW_H3_SID,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_EHCI0,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_OHCI0,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_EHCI1,<br>
&gt; &gt; @@ -115,6 +117,7 @@ typedef struct AwH3State {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3ClockCtlState ccu;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwCpuCfgState cpucfg;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3SysCtrlState sysctrl;<br>
&gt; &gt; +=C2=A0 =C2=A0 AwSidState sid;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GICState gic;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a1;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a2;<br>
&gt; &gt; diff --git a/include/hw/misc/allwinner-sid.h b/include/hw/misc/al=
lwinner-sid.h<br>
&gt; &gt; new file mode 100644<br>
&gt; &gt; index 0000000000..41189967e2<br>
&gt; &gt; --- /dev/null<br>
&gt; &gt; +++ b/include/hw/misc/allwinner-sid.h<br>
&gt; &gt; @@ -0,0 +1,61 @@<br>
&gt; &gt; +/*<br>
&gt; &gt; + * Allwinner Security ID emulation<br>
&gt; &gt; + *<br>
&gt; &gt; + * Copyright (C) 2019 Niek Linnenbank &lt;<a href=3D"mailto:niek=
linnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br=
>
&gt; &gt; + *<br>
&gt; &gt; + * This program is free software: you can redistribute it and/or=
 modify<br>
&gt; &gt; + * it under the terms of the GNU General Public License as publi=
shed by<br>
&gt; &gt; + * the Free Software Foundation, either version 2 of the License=
, or<br>
&gt; &gt; + * (at your option) any later version.<br>
&gt; &gt; + *<br>
&gt; &gt; + * This program is distributed in the hope that it will be usefu=
l,<br>
&gt; &gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty o=
f<br>
&gt; &gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 Se=
e the<br>
&gt; &gt; + * GNU General Public License for more details.<br>
&gt; &gt; + *<br>
&gt; &gt; + * You should have received a copy of the GNU General Public Lic=
ense<br>
&gt; &gt; + * along with this program.=C2=A0 If not, see &lt;<a href=3D"htt=
p://www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.=
gnu.org/licenses/</a>&gt;.<br>
&gt; &gt; + */<br>
&gt; &gt; +<br>
&gt; &gt; +#ifndef HW_MISC_ALLWINNER_SID_H<br>
&gt; &gt; +#define HW_MISC_ALLWINNER_SID_H<br>
&gt; &gt; +<br>
&gt; &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; &gt; +#include &quot;qom/object.h&quot;<br>
&gt; &gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; &gt; +#include &quot;qemu/uuid.h&quot;<br>
&gt; &gt; +<br>
&gt; &gt; +/**<br>
&gt; &gt; + * Object model<br>
&gt; &gt; + * @{<br>
&gt; &gt; + */<br>
&gt; &gt; +<br>
&gt; &gt; +#define TYPE_AW_SID=C2=A0 =C2=A0 &quot;allwinner-sid&quot;<br>
&gt; &gt; +#define AW_SID(obj) \<br>
&gt; &gt; +=C2=A0 =C2=A0 OBJECT_CHECK(AwSidState, (obj), TYPE_AW_SID)<br>
&gt; &gt; +<br>
&gt; &gt; +/** @} */<br>
&gt; &gt; +<br>
&gt; &gt; +/**<br>
&gt; &gt; + * Allwinner Security ID object instance state<br>
&gt; &gt; + */<br>
&gt; &gt; +typedef struct AwSidState {<br>
&gt; &gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; &gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; &gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 /** Maps I/O registers in physical memory */<br>
&gt; &gt; +=C2=A0 =C2=A0 MemoryRegion iomem;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 /** Control register defines how and what to read =
*/<br>
&gt; &gt; +=C2=A0 =C2=A0 uint32_t control;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 /** RdKey register contains the data retrieved by =
the device */<br>
&gt; &gt; +=C2=A0 =C2=A0 uint32_t rdkey;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 /** Stores the emulated device identifier */<br>
&gt; &gt; +=C2=A0 =C2=A0 QemuUUID identifier;<br>
&gt; &gt; +<br>
&gt; &gt; +} AwSidState;<br>
&gt; &gt; +<br>
&gt; &gt; +#endif /* HW_MISC_ALLWINNER_SID_H */<br>
&gt; &gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
&gt; &gt; index e9ad6d23df..af7317e86a 100644<br>
&gt; &gt; --- a/hw/arm/allwinner-h3.c<br>
&gt; &gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; &gt; @@ -36,6 +36,7 @@ const hwaddr allwinner_h3_memmap[] =3D {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_SRAM_A2]=C2=A0 =C2=A0 =3D 0x0004=
4000,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_SRAM_C]=C2=A0 =C2=A0 =C2=A0=3D 0=
x00010000,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_SYSCTRL]=C2=A0 =C2=A0 =3D 0x01c0=
0000,<br>
&gt; &gt; +=C2=A0 =C2=A0 [AW_H3_SID]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c14=
000,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_EHCI0]=C2=A0 =C2=A0 =C2=A0 =3D 0=
x01c1a000,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_OHCI0]=C2=A0 =C2=A0 =C2=A0 =3D 0=
x01c1a400,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_EHCI1]=C2=A0 =C2=A0 =C2=A0 =3D 0=
x01c1b000,<br>
&gt; &gt; @@ -76,7 +77,6 @@ struct AwH3Unimplemented {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;mmc0&quot;,=C2=A0 =C2=A0 =C2=A0=
 0x01c0f000, 4 * KiB },<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;mmc1&quot;,=C2=A0 =C2=A0 =C2=A0=
 0x01c10000, 4 * KiB },<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;mmc2&quot;,=C2=A0 =C2=A0 =C2=A0=
 0x01c11000, 4 * KiB },<br>
&gt; &gt; -=C2=A0 =C2=A0 { &quot;sid&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c=
14000, 1 * KiB },<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;crypto&quot;,=C2=A0 =C2=A0 0x01=
c15000, 4 * KiB },<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;msgbox&quot;,=C2=A0 =C2=A0 0x01=
c17000, 4 * KiB },<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;spinlock&quot;,=C2=A0 0x01c1800=
0, 4 * KiB },<br>
&gt; &gt; @@ -196,6 +196,11 @@ static void allwinner_h3_init(Object *obj)<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_init_child_obj(obj, &quot;cpucfg=
&quot;, &amp;s-&gt;cpucfg, sizeof(s-&gt;cpucfg),<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_AW_CPUCFG);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;sid&quot;, &amp;s=
-&gt;sid, sizeof(s-&gt;sid),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_SID);<br>
&gt; &gt; +=C2=A0 =C2=A0 object_property_add_alias(obj, &quot;identifier&qu=
ot;, OBJECT(&amp;s-&gt;sid),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;identifier&quot;, &amp;erro=
r_abort);<br>
&gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0static void allwinner_h3_realize(DeviceState *dev, Er=
ror **errp)<br>
&gt; &gt; @@ -316,6 +321,10 @@ static void allwinner_h3_realize(DeviceState=
 *dev, Error **errp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_init_nofail(DEVICE(&amp;s-&gt;cpuc=
fg));<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&=
gt;cpucfg), 0, s-&gt;memmap[AW_H3_CPUCFG]);<br>
&gt; &gt; +=C2=A0 =C2=A0 /* Security Identifier */<br>
&gt; &gt; +=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(&amp;s-&gt;sid));<br>
&gt; &gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;sid), 0,=
 s-&gt;memmap[AW_H3_SID]);<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Universal Serial Bus */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_create_simple(TYPE_AW_H3_EHCI, s=
-&gt;memmap[AW_H3_EHCI0],<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br=
>
&gt; &gt; diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c<br>
&gt; &gt; index 051184f14f..a7f870c88b 100644<br>
&gt; &gt; --- a/hw/arm/orangepi.c<br>
&gt; &gt; +++ b/hw/arm/orangepi.c<br>
&gt; &gt; @@ -54,6 +54,10 @@ static void orangepi_init(MachineState *machin=
e)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(s-&gt;h3=
), 24000000, &quot;clk1-freq&quot;,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
&gt; &gt; +=C2=A0 =C2=A0 /* Setup SID properties */<br>
&gt; &gt; +=C2=A0 =C2=A0 qdev_prop_set_string(DEVICE(s-&gt;h3), &quot;ident=
ifier&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;8100c002-0001-0002-0003-000044556677&quot;=
);<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Mark H3 object realized */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_bool(OBJECT(s-&gt;h=
3), true, &quot;realized&quot;, &amp;error_abort);<br>
&gt; &gt; diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c<br=
>
&gt; &gt; new file mode 100644<br>
&gt; &gt; index 0000000000..954de935bc<br>
&gt; &gt; --- /dev/null<br>
&gt; &gt; +++ b/hw/misc/allwinner-sid.c<br>
&gt; &gt; @@ -0,0 +1,170 @@<br>
&gt; &gt; +/*<br>
&gt; &gt; + * Allwinner Security ID emulation<br>
&gt; &gt; + *<br>
&gt; &gt; + * Copyright (C) 2019 Niek Linnenbank &lt;<a href=3D"mailto:niek=
linnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br=
>
&gt; &gt; + *<br>
&gt; &gt; + * This program is free software: you can redistribute it and/or=
 modify<br>
&gt; &gt; + * it under the terms of the GNU General Public License as publi=
shed by<br>
&gt; &gt; + * the Free Software Foundation, either version 2 of the License=
, or<br>
&gt; &gt; + * (at your option) any later version.<br>
&gt; &gt; + *<br>
&gt; &gt; + * This program is distributed in the hope that it will be usefu=
l,<br>
&gt; &gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty o=
f<br>
&gt; &gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 Se=
e the<br>
&gt; &gt; + * GNU General Public License for more details.<br>
&gt; &gt; + *<br>
&gt; &gt; + * You should have received a copy of the GNU General Public Lic=
ense<br>
&gt; &gt; + * along with this program.=C2=A0 If not, see &lt;<a href=3D"htt=
p://www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.=
gnu.org/licenses/</a>&gt;.<br>
&gt; &gt; + */<br>
&gt; &gt; +<br>
&gt; &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; &gt; +#include &quot;qemu/units.h&quot;<br>
&gt; &gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; &gt; +#include &quot;migration/vmstate.h&quot;<br>
&gt; &gt; +#include &quot;qemu/log.h&quot;<br>
&gt; &gt; +#include &quot;qemu/module.h&quot;<br>
&gt; &gt; +#include &quot;qemu/guest-random.h&quot;<br>
&gt; &gt; +#include &quot;qapi/error.h&quot;<br>
&gt; &gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; &gt; +#include &quot;hw/misc/allwinner-sid.h&quot;<br>
&gt; &gt; +#include &quot;trace.h&quot;<br>
&gt; &gt; +<br>
&gt; &gt; +/* SID register offsets */<br>
&gt; &gt; +enum {<br>
&gt; &gt; +=C2=A0 =C2=A0 REG_PRCTL =3D 0x40,=C2=A0 =C2=A0/* Control */<br>
&gt; &gt; +=C2=A0 =C2=A0 REG_RDKEY =3D 0x60,=C2=A0 =C2=A0/* Read Key */<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; +/* SID register flags */<br>
&gt; &gt; +enum {<br>
&gt; &gt; +=C2=A0 =C2=A0 REG_PRCTL_WRITE=C2=A0 =C2=A0=3D 0x0002, /* Unknown=
 write flag */<br>
&gt; &gt; +=C2=A0 =C2=A0 REG_PRCTL_OP_LOCK =3D 0xAC00, /* Lock operation */=
<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; +static uint64_t allwinner_sid_read(void *opaque, hwaddr offset,<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned size=
)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 const AwSidState *s =3D AW_SID(opaque);<br>
&gt; &gt; +=C2=A0 =C2=A0 uint64_t val =3D 0;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; &gt; +=C2=A0 =C2=A0 case REG_PRCTL:=C2=A0 =C2=A0 /* Control */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;control;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; +=C2=A0 =C2=A0 case REG_RDKEY:=C2=A0 =C2=A0 /* Read Key */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;rdkey;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; +=C2=A0 =C2=A0 default:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot=
;%s: out-of-bounds offset 0x%04x\n&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 trace_allwinner_sid_read(offset, val, size);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 return val;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void allwinner_sid_write(void *opaque, hwaddr offset,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val, unsigned siz=
e)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AwSidState *s =3D AW_SID(opaque);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 trace_allwinner_sid_write(offset, val, size);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; &gt; +=C2=A0 =C2=A0 case REG_PRCTL:=C2=A0 =C2=A0 /* Control */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;control =3D val;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((s-&gt;control &amp; REG_PRCTL_O=
P_LOCK) &amp;&amp;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;control &amp; R=
EG_PRCTL_WRITE)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t id =3D s-&gt;=
control &gt;&gt; 16;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (id &lt; sizeof(Qem=
uUUID)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;rd=
key =3D (s-&gt;identifier.data[id]) |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;identifier.data[id + 1] &lt;&lt; 8=
) |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;identifier.data[id + 2] &lt;&lt; 1=
6) |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;identifier.data[id + 3] &lt;&lt; 2=
4);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;control &amp;=3D ~REG_PRCTL_WR=
ITE;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; +=C2=A0 =C2=A0 case REG_RDKEY:=C2=A0 =C2=A0 /* Read Key */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; +=C2=A0 =C2=A0 default:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot=
;%s: out-of-bounds offset 0x%04x\n&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static const MemoryRegionOps allwinner_sid_ops =3D {<br>
&gt; &gt; +=C2=A0 =C2=A0 .read =3D allwinner_sid_read,<br>
&gt; &gt; +=C2=A0 =C2=A0 .write =3D allwinner_sid_write,<br>
&gt; &gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
&gt; &gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
&gt; &gt; +=C2=A0 =C2=A0 },<br>
&gt; &gt; +=C2=A0 =C2=A0 .impl.min_access_size =3D 4,<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; +static void allwinner_sid_reset(DeviceState *dev)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AwSidState *s =3D AW_SID(dev);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 /* Set default values for registers */<br>
&gt; &gt; +=C2=A0 =C2=A0 s-&gt;control =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 s-&gt;rdkey =3D 0;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void allwinner_sid_init(Object *obj)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);<br>
&gt; &gt; +=C2=A0 =C2=A0 AwSidState *s =3D AW_SID(obj);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 /* Memory mapping */<br>
&gt; &gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem, OBJECT(s),=
 &amp;allwinner_sid_ops, s,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_AW_SID, 1 * KiB);<br>
&gt; &gt; +=C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;s-&gt;iomem);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static Property allwinner_sid_properties[] =3D {<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_PROP_UUID_NODEFAULT(&quot;identifier&quot;,=
 AwSidState, identifier),<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST()<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; +static const VMStateDescription allwinner_sid_vmstate =3D {<br>
&gt; &gt; +=C2=A0 =C2=A0 .name =3D &quot;allwinner-sid&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; &gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; &gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(control, AwSidState),=
<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rdkey, AwSidState),<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; +static void allwinner_sid_class_init(ObjectClass *klass, void *d=
ata)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 dc-&gt;reset =3D allwinner_sid_reset;<br>
&gt; &gt; +=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;allwinner_sid_vmstate;<br>
&gt; &gt; +=C2=A0 =C2=A0 dc-&gt;props =3D allwinner_sid_properties;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static const TypeInfo allwinner_sid_info =3D {<br>
&gt; &gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_A=
W_SID,<br>
&gt; &gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BU=
S_DEVICE,<br>
&gt; &gt; +=C2=A0 =C2=A0 .instance_init =3D allwinner_sid_init,<br>
&gt; &gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(AwSidState),<br>
&gt; &gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D allwinner_sid_class_i=
nit,<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; +static void allwinner_sid_register(void)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 type_register_static(&amp;allwinner_sid_info);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +type_init(allwinner_sid_register)<br>
&gt; &gt; diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs<br>
&gt; &gt; index 12c2c306b5..59500d5681 100644<br>
&gt; &gt; --- a/hw/misc/Makefile.objs<br>
&gt; &gt; +++ b/hw/misc/Makefile.objs<br>
&gt; &gt; @@ -31,6 +31,7 @@ common-obj-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshme=
m.o<br>
&gt; &gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-c=
cu.o<br>
&gt; &gt;=C2=A0 =C2=A0obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-cpucfg.o<br=
>
&gt; &gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-s=
ysctrl.o<br>
&gt; &gt; +common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-sid.o<br>
&gt; &gt;=C2=A0 =C2=A0common-obj-$(CONFIG_REALVIEW) +=3D arm_sysctl.o<br>
&gt; &gt;=C2=A0 =C2=A0common-obj-$(CONFIG_NSERIES) +=3D cbus.o<br>
&gt; &gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ECCMEMCTL) +=3D eccmemctl.o<br>
&gt; &gt; diff --git a/hw/misc/trace-events b/hw/misc/trace-events<br>
&gt; &gt; index d3e0952429..67d8bf493c 100644<br>
&gt; &gt; --- a/hw/misc/trace-events<br>
&gt; &gt; +++ b/hw/misc/trace-events<br>
&gt; &gt; @@ -5,6 +5,10 @@ allwinner_cpucfg_cpu_reset(uint8_t cpu_id, uint3=
2_t reset_addr) &quot;id %u, reset_ad<br>
&gt; &gt;=C2=A0 =C2=A0allwinner_cpucfg_read(uint64_t offset, uint64_t data,=
 unsigned size) &quot;offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 =
&quot; size %&quot; PRIu32<br>
&gt; &gt;=C2=A0 =C2=A0allwinner_cpucfg_write(uint64_t offset, uint64_t data=
, unsigned size) &quot;offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64=
 &quot; size %&quot; PRIu32<br>
&gt; &gt; +# allwinner-sid.c<br>
&gt; &gt; +allwinner_sid_read(uint64_t offset, uint64_t data, unsigned size=
) &quot;offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 &quot; size %&=
quot; PRIu32<br>
&gt; &gt; +allwinner_sid_write(uint64_t offset, uint64_t data, unsigned siz=
e) &quot;offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 &quot; size %=
&quot; PRIu32<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0# eccmemctl.c<br>
&gt; &gt;=C2=A0 =C2=A0ecc_mem_writel_mer(uint32_t val) &quot;Write memory e=
nable 0x%08x&quot;<br>
&gt; &gt;=C2=A0 =C2=A0ecc_mem_writel_mdr(uint32_t val) &quot;Write memory d=
elay 0x%08x&quot;<br>
&gt; &gt; <br>
&gt; <br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000002f94bc059d9e7bb2--

