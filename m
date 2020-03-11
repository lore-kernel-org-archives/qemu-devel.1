Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFECC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 19:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826C420736
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 19:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX4HZeeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826C420736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC75M-0002AG-MP
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 15:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jC74G-0001K1-UN
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 15:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jC74E-00020o-Hz
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 15:31:00 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:39275)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jC74E-00020I-An; Wed, 11 Mar 2020 15:30:58 -0400
Received: by mail-io1-xd41.google.com with SMTP id c19so2108816ioo.6;
 Wed, 11 Mar 2020 12:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZRdMx1uQLpaW4YJMfE+7IyhquX3bamlActAxa6ZJMGI=;
 b=KX4HZeeINKci8g4fO3HnXGvmK+tlDSGy3oSzlAB81Ph8bedI9Fk0nfOHPK4wpOPhuM
 SCulfipFC4AQcd5ZroBC9iqo1YPGB1/t1vxQLtDl3ephz2PV5R+4RHmfkOtZ7km/hq0n
 /nC8Nc2SzUhpj/30hQA5aFY9wnh0OFVPZnjofnwBvW6V9CBXWIonDtliQaX38PmCUaKd
 d+EhRXrLKyW1WR0WLtZdkUe6SoSEUlJTJ4lzw18IcrBP0frlMr9czTfIHIwGkjzvI6qv
 nYs9oHhQQvE6Ub8dPLhjmtkwFL9vpsJJgld+M//0Jume/z8IpGTHdko+/qmFQ1zAuxwq
 n6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZRdMx1uQLpaW4YJMfE+7IyhquX3bamlActAxa6ZJMGI=;
 b=laCvGO6VQOoSZ9g2jNWl2vJhF8JoH/9RqMu65zYQEnYQm3IQ41kb9CiIBOWdneBpJi
 2XvPloR5F2B7tc+GMKmp0q5RhXabPZ6n3GZP4tnWu69Ihjf49FVmxOafGv/K/09EwTzH
 CGZATTwR6h7RL4inSB6bz4ibjLgaMHfEEhZVCscWhV0V4Sw2lkW6aoQGut+eYw1VCneC
 lfU1cZPC03BOSsxpD5TP9KayBqcMMvVnlKMn6uGsgv7guY9z+81sTKL+8Rj6Cr81009C
 4fOzKnxjJhTSEdg3lKSvEyRyK3+/TmrKAdmm0sMhD0CT4GHJC4QLBoJnjHoJtHS8OgIM
 7/yw==
X-Gm-Message-State: ANhLgQ3L1BpBxn9Hg0GFry3aLjojkqsxI9YBp0sFoYcQawIL5vphrypk
 B0vvMu68I8cSTZ3whaLFgUwPpo+sbyyroImigsM=
X-Google-Smtp-Source: ADFU+vvmZ2H2+BTFHXPC25SdxUtfqRO70iVNUbcFz32Nj9dF1kDhPLouUl6PV5GbIZ4IDMDg3NAjk4YmJVNsfRqASl0=
X-Received: by 2002:a02:700a:: with SMTP id f10mr4521668jac.120.1583955057214; 
 Wed, 11 Mar 2020 12:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
 <20200310213203.18730-8-nieklinnenbank@gmail.com> <87k13rgfqe.fsf@linaro.org>
In-Reply-To: <87k13rgfqe.fsf@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 20:30:46 +0100
Message-ID: <CAPan3WrXM=bc33rEndzYeN5-xX7WpR1D5wbVBf8Yx=P3cTx5tA@mail.gmail.com>
Subject: Re: [PATCH v7 07/18] hw/arm/allwinner: add Security Identifier device
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000868c7b05a0994663"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000868c7b05a0994663
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 2:53 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Niek Linnenbank <nieklinnenbank@gmail.com> writes:
>
> > The Security Identifier device found in various Allwinner System on Chi=
p
> > designs gives applications a per-board unique identifier. This commit
> > adds support for the Allwinner Security Identifier using a 128-bit
> > UUID value as input.
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >  include/hw/arm/allwinner-h3.h   |   3 +
> >  include/hw/misc/allwinner-sid.h |  60 ++++++++++++
> >  hw/arm/allwinner-h3.c           |  11 ++-
> >  hw/arm/orangepi.c               |   9 ++
> >  hw/misc/allwinner-sid.c         | 168 ++++++++++++++++++++++++++++++++
> >  hw/misc/Makefile.objs           |   1 +
> >  hw/misc/trace-events            |   4 +
> >  7 files changed, 255 insertions(+), 1 deletion(-)
> >  create mode 100644 include/hw/misc/allwinner-sid.h
> >  create mode 100644 hw/misc/allwinner-sid.c
> >
> > diff --git a/include/hw/arm/allwinner-h3.h
> b/include/hw/arm/allwinner-h3.h
> > index dc729176ab..85416d9d64 100644
> > --- a/include/hw/arm/allwinner-h3.h
> > +++ b/include/hw/arm/allwinner-h3.h
> > @@ -42,6 +42,7 @@
> >  #include "hw/misc/allwinner-h3-ccu.h"
> >  #include "hw/misc/allwinner-cpucfg.h"
> >  #include "hw/misc/allwinner-h3-sysctrl.h"
> > +#include "hw/misc/allwinner-sid.h"
> >  #include "target/arm/cpu.h"
> >
> >  /**
> > @@ -59,6 +60,7 @@ enum {
> >      AW_H3_SRAM_A2,
> >      AW_H3_SRAM_C,
> >      AW_H3_SYSCTRL,
> > +    AW_H3_SID,
> >      AW_H3_EHCI0,
> >      AW_H3_OHCI0,
> >      AW_H3_EHCI1,
> > @@ -114,6 +116,7 @@ typedef struct AwH3State {
> >      AwH3ClockCtlState ccu;
> >      AwCpuCfgState cpucfg;
> >      AwH3SysCtrlState sysctrl;
> > +    AwSidState sid;
> >      GICState gic;
> >      MemoryRegion sram_a1;
> >      MemoryRegion sram_a2;
> > diff --git a/include/hw/misc/allwinner-sid.h
> b/include/hw/misc/allwinner-sid.h
> > new file mode 100644
> > index 0000000000..4c1fa4762b
> > --- /dev/null
> > +++ b/include/hw/misc/allwinner-sid.h
> > @@ -0,0 +1,60 @@
> > +/*
> > + * Allwinner Security ID emulation
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
> > +#ifndef HW_MISC_ALLWINNER_SID_H
> > +#define HW_MISC_ALLWINNER_SID_H
> > +
> > +#include "qom/object.h"
> > +#include "hw/sysbus.h"
> > +#include "qemu/uuid.h"
> > +
> > +/**
> > + * Object model
> > + * @{
> > + */
> > +
> > +#define TYPE_AW_SID    "allwinner-sid"
> > +#define AW_SID(obj) \
> > +    OBJECT_CHECK(AwSidState, (obj), TYPE_AW_SID)
> > +
> > +/** @} */
> > +
> > +/**
> > + * Allwinner Security ID object instance state
> > + */
> > +typedef struct AwSidState {
> > +    /*< private >*/
> > +    SysBusDevice parent_obj;
> > +    /*< public >*/
> > +
> > +    /** Maps I/O registers in physical memory */
> > +    MemoryRegion iomem;
> > +
> > +    /** Control register defines how and what to read */
> > +    uint32_t control;
> > +
> > +    /** RdKey register contains the data retrieved by the device */
> > +    uint32_t rdkey;
> > +
> > +    /** Stores the emulated device identifier */
> > +    QemuUUID identifier;
> > +
> > +} AwSidState;
> > +
> > +#endif /* HW_MISC_ALLWINNER_SID_H */
> > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> > index b9a5597f2a..deeea63f5f 100644
> > --- a/hw/arm/allwinner-h3.c
> > +++ b/hw/arm/allwinner-h3.c
> > @@ -38,6 +38,7 @@ const hwaddr allwinner_h3_memmap[] =3D {
> >      [AW_H3_SRAM_A2]    =3D 0x00044000,
> >      [AW_H3_SRAM_C]     =3D 0x00010000,
> >      [AW_H3_SYSCTRL]    =3D 0x01c00000,
> > +    [AW_H3_SID]        =3D 0x01c14000,
> >      [AW_H3_EHCI0]      =3D 0x01c1a000,
> >      [AW_H3_OHCI0]      =3D 0x01c1a400,
> >      [AW_H3_EHCI1]      =3D 0x01c1b000,
> > @@ -78,7 +79,6 @@ struct AwH3Unimplemented {
> >      { "mmc0",      0x01c0f000, 4 * KiB },
> >      { "mmc1",      0x01c10000, 4 * KiB },
> >      { "mmc2",      0x01c11000, 4 * KiB },
> > -    { "sid",       0x01c14000, 1 * KiB },
> >      { "crypto",    0x01c15000, 4 * KiB },
> >      { "msgbox",    0x01c17000, 4 * KiB },
> >      { "spinlock",  0x01c18000, 4 * KiB },
> > @@ -198,6 +198,11 @@ static void allwinner_h3_init(Object *obj)
> >
> >      sysbus_init_child_obj(obj, "cpucfg", &s->cpucfg, sizeof(s->cpucfg)=
,
> >                            TYPE_AW_CPUCFG);
> > +
> > +    sysbus_init_child_obj(obj, "sid", &s->sid, sizeof(s->sid),
> > +                          TYPE_AW_SID);
> > +    object_property_add_alias(obj, "identifier", OBJECT(&s->sid),
> > +                              "identifier", &error_abort);
> >  }
> >
> >  static void allwinner_h3_realize(DeviceState *dev, Error **errp)
> > @@ -315,6 +320,10 @@ static void allwinner_h3_realize(DeviceState *dev,
> Error **errp)
> >      qdev_init_nofail(DEVICE(&s->cpucfg));
> >      sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0,
> s->memmap[AW_H3_CPUCFG]);
> >
> > +    /* Security Identifier */
> > +    qdev_init_nofail(DEVICE(&s->sid));
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H3_SID]);
> > +
> >      /* Universal Serial Bus */
> >      sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
> >                           qdev_get_gpio_in(DEVICE(&s->gic),
> > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> > index 3fcec1944e..c92fab3eac 100644
> > --- a/hw/arm/orangepi.c
> > +++ b/hw/arm/orangepi.c
> > @@ -65,6 +65,15 @@ static void orangepi_init(MachineState *machine)
> >      object_property_set_int(OBJECT(h3), 24 * 1000 * 1000, "clk1-freq",
> >                              &error_abort);
> >
> > +    /* Setup SID properties. Currently using a default fixed SID
> identifier. */
> > +    if (qemu_uuid_is_null(&h3->sid.identifier)) {
> > +        qdev_prop_set_string(DEVICE(h3), "identifier",
> > +                             "02c00081-1111-2222-3333-000044556677");
> > +    } else if (ldl_be_p(&h3->sid.identifier.data[0]) !=3D 0x02c00081) =
{
> > +        fprintf(stderr, "WARNING: Security Identifier value does "
> > +                        "not include H3 prefix\n");
> > +    }
> > +
>
> Should this be a LOG_GUEST_ERROR?
>

Hi Alex,

This warning is basically to inform the user when overriding the SID
identifier manually with -global,
that the identifier specified by the user does not contain the H3 SoC
prefix. Real hardware always has
that particular prefix in its identifier value, and it might be so that
software running on the emulated hardware
depends on it. So its basically a proactive warning to inform the user, and
not an error of wrong behavior caused by the guest software.


>
> Otherwise:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>

Assuming the above explanation is sufficient, I'll add your review tag,
thanks!


>
> --
> Alex Benn=C3=A9e
>


--=20
Niek Linnenbank

--000000000000868c7b05a0994663
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 11, 2020 at 2:53 PM Alex =
Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><br>
Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_=
blank">nieklinnenbank@gmail.com</a>&gt; writes:<br>
<br>
&gt; The Security Identifier device found in various Allwinner System on Ch=
ip<br>
&gt; designs gives applications a per-board unique identifier. This commit<=
br>
&gt; adds support for the Allwinner Security Identifier using a 128-bit<br>
&gt; UUID value as input.<br>
&gt;<br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 include/hw/misc/allwinner-sid.h |=C2=A0 60 ++++++++++++<br>
&gt;=C2=A0 hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 11 ++-<br>
&gt;=C2=A0 hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A09 ++<br>
&gt;=C2=A0 hw/misc/allwinner-sid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 168 +=
+++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/misc/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 7 files changed, 255 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 create mode 100644 include/hw/misc/allwinner-sid.h<br>
&gt;=C2=A0 create mode 100644 hw/misc/allwinner-sid.c<br>
&gt;<br>
&gt; diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-=
h3.h<br>
&gt; index dc729176ab..85416d9d64 100644<br>
&gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt; @@ -42,6 +42,7 @@<br>
&gt;=C2=A0 #include &quot;hw/misc/allwinner-h3-ccu.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/misc/allwinner-cpucfg.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/misc/allwinner-h3-sysctrl.h&quot;<br>
&gt; +#include &quot;hw/misc/allwinner-sid.h&quot;<br>
&gt;=C2=A0 #include &quot;target/arm/cpu.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /**<br>
&gt; @@ -59,6 +60,7 @@ enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AW_H3_SRAM_A2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AW_H3_SRAM_C,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AW_H3_SYSCTRL,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_SID,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AW_H3_EHCI0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AW_H3_OHCI0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AW_H3_EHCI1,<br>
&gt; @@ -114,6 +116,7 @@ typedef struct AwH3State {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AwH3ClockCtlState ccu;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AwCpuCfgState cpucfg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AwH3SysCtrlState sysctrl;<br>
&gt; +=C2=A0 =C2=A0 AwSidState sid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 GICState gic;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemoryRegion sram_a1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemoryRegion sram_a2;<br>
&gt; diff --git a/include/hw/misc/allwinner-sid.h b/include/hw/misc/allwinn=
er-sid.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..4c1fa4762b<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/misc/allwinner-sid.h<br>
&gt; @@ -0,0 +1,60 @@<br>
&gt; +/*<br>
&gt; + * Allwinner Security ID emulation<br>
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
&gt; +#ifndef HW_MISC_ALLWINNER_SID_H<br>
&gt; +#define HW_MISC_ALLWINNER_SID_H<br>
&gt; +<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;qemu/uuid.h&quot;<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Object model<br>
&gt; + * @{<br>
&gt; + */<br>
&gt; +<br>
&gt; +#define TYPE_AW_SID=C2=A0 =C2=A0 &quot;allwinner-sid&quot;<br>
&gt; +#define AW_SID(obj) \<br>
&gt; +=C2=A0 =C2=A0 OBJECT_CHECK(AwSidState, (obj), TYPE_AW_SID)<br>
&gt; +<br>
&gt; +/** @} */<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Allwinner Security ID object instance state<br>
&gt; + */<br>
&gt; +typedef struct AwSidState {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** Maps I/O registers in physical memory */<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion iomem;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** Control register defines how and what to read */<br=
>
&gt; +=C2=A0 =C2=A0 uint32_t control;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** RdKey register contains the data retrieved by the d=
evice */<br>
&gt; +=C2=A0 =C2=A0 uint32_t rdkey;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** Stores the emulated device identifier */<br>
&gt; +=C2=A0 =C2=A0 QemuUUID identifier;<br>
&gt; +<br>
&gt; +} AwSidState;<br>
&gt; +<br>
&gt; +#endif /* HW_MISC_ALLWINNER_SID_H */<br>
&gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
&gt; index b9a5597f2a..deeea63f5f 100644<br>
&gt; --- a/hw/arm/allwinner-h3.c<br>
&gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; @@ -38,6 +38,7 @@ const hwaddr allwinner_h3_memmap[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [AW_H3_SRAM_A2]=C2=A0 =C2=A0 =3D 0x00044000,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [AW_H3_SRAM_C]=C2=A0 =C2=A0 =C2=A0=3D 0x00010000,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 [AW_H3_SYSCTRL]=C2=A0 =C2=A0 =3D 0x01c00000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_SID]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c14000,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 [AW_H3_EHCI0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1a000,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 [AW_H3_OHCI0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1a400,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 [AW_H3_EHCI1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1b000,<=
br>
&gt; @@ -78,7 +79,6 @@ struct AwH3Unimplemented {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 { &quot;mmc0&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c0f000=
, 4 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 { &quot;mmc1&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c10000=
, 4 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 { &quot;mmc2&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c11000=
, 4 * KiB },<br>
&gt; -=C2=A0 =C2=A0 { &quot;sid&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c14000=
, 1 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 { &quot;crypto&quot;,=C2=A0 =C2=A0 0x01c15000, 4 *=
 KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 { &quot;msgbox&quot;,=C2=A0 =C2=A0 0x01c17000, 4 *=
 KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 { &quot;spinlock&quot;,=C2=A0 0x01c18000, 4 * KiB =
},<br>
&gt; @@ -198,6 +198,11 @@ static void allwinner_h3_init(Object *obj)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;cpucfg&quot;, &am=
p;s-&gt;cpucfg, sizeof(s-&gt;cpucfg),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_CPUCFG);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;sid&quot;, &amp;s-&gt;=
sid, sizeof(s-&gt;sid),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_SID);<br>
&gt; +=C2=A0 =C2=A0 object_property_add_alias(obj, &quot;identifier&quot;, =
OBJECT(&amp;s-&gt;sid),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;identifier&quot;, &amp;error_abor=
t);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void allwinner_h3_realize(DeviceState *dev, Error **errp)=
<br>
&gt; @@ -315,6 +320,10 @@ static void allwinner_h3_realize(DeviceState *dev=
, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qdev_init_nofail(DEVICE(&amp;s-&gt;cpucfg));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;cpucfg),=
 0, s-&gt;memmap[AW_H3_CPUCFG]);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 /* Security Identifier */<br>
&gt; +=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(&amp;s-&gt;sid));<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;sid), 0, s-&g=
t;memmap[AW_H3_SID]);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Universal Serial Bus */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap=
[AW_H3_EHCI0],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt; diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c<br>
&gt; index 3fcec1944e..c92fab3eac 100644<br>
&gt; --- a/hw/arm/orangepi.c<br>
&gt; +++ b/hw/arm/orangepi.c<br>
&gt; @@ -65,6 +65,15 @@ static void orangepi_init(MachineState *machine)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 object_property_set_int(OBJECT(h3), 24 * 1000 * 10=
00, &quot;clk1-freq&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_abort);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 /* Setup SID properties. Currently using a default fixe=
d SID identifier. */<br>
&gt; +=C2=A0 =C2=A0 if (qemu_uuid_is_null(&amp;h3-&gt;sid.identifier)) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_string(DEVICE(h3), &quot;id=
entifier&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;02c00081-1111-2222-3333-0000445566=
77&quot;);<br>
&gt; +=C2=A0 =C2=A0 } else if (ldl_be_p(&amp;h3-&gt;sid.identifier.data[0])=
 !=3D 0x02c00081) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;WARNING: Security I=
dentifier value does &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;not include H3 prefix\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
<br>
Should this be a LOG_GUEST_ERROR?<br></blockquote><div><br></div><div>Hi Al=
ex,</div><div><br></div><div>This warning is basically to inform the user w=
hen overriding the SID identifier manually with -global,</div><div>that the=
 identifier specified by the user does not contain the H3 SoC prefix. Real =
hardware always has</div><div>that particular prefix in its identifier valu=
e, and it might be so that software running on the emulated hardware</div><=
div>depends on it. So its basically a proactive warning to inform the user,=
 and not an error of wrong behavior caused by the guest software.<br></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Otherwise:<br>
<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br></blockquote><div><br>=
</div><div>Assuming the above explanation is sufficient, I&#39;ll add your =
review tag, thanks!<br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000868c7b05a0994663--

