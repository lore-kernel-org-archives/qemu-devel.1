Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068C5C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 14:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B612820663
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 14:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRrTtwOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B612820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilwNd-0003SI-SK
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 09:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ilwMl-0002nH-W3
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 09:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ilwMi-0003IL-Eo
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 09:49:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46525
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ilwMi-0003Hz-2Z
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 09:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577717391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lrpu6V3wX71ICYQBEXZeC9yIM+STjVSVOoUxUHos4Gw=;
 b=LRrTtwORbMRlL+HuByeI1U1TMuDl2qCnsPojqWBOofpZktEdOuaUaroRqlfayQ7N9/Zpxh
 rCPT/vI+IgjdOTHOBBgsOccioeLg/DREQI+pw+P0OE/Eops6sX6dCFIylcnXi7cK+r3U4T
 V+9FEHnjU6WPBnYzYed3nbhQiWdGrCo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-s6caWFlvPpCreUvoWK_vEA-1; Mon, 30 Dec 2019 09:49:47 -0500
Received: by mail-wr1-f70.google.com with SMTP id w6so16583810wrm.16
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 06:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BZeMlQiIAONvIA8+KFCtML8THv8dGccbixbZz/14GKQ=;
 b=mcyGJzbUPHNncz5Lw50OenHRGfxjfQ/IZ71Tz4C/kbZQlWGGUGpL1lXKF0IoxM00xx
 erA6vZ1RDNpZhkwBQg1FSApbKSW2JexCTUnm9CKUDm/xKLXsRq4TS1xAAEFAksYSMqIZ
 Dw0AIDcBYM83DcTWxxpXWmvTYBkoz09GfiAEiAOfpMRMfkP+9XgGt4rBaGIRmEUH9r4G
 h5+zDS7pHi4EaIBU5FSw3GIfhMcUzkVwv9qUMX0OPwiPGadTe+hjc8dUTY9A43pBJCeJ
 CywzEDg4b58H1ToZ8o8VxADhjxjvdJHJmQdWmi+bH5y8HMJuF555Nb72/QlNlEzvJgeh
 ZefA==
X-Gm-Message-State: APjAAAWt99a4bdP1/ywJRrtjuJQwrOFW3XOKl6cvAqH+8Qt3ItsbxK8z
 eBqI+H+l+TCZwq0yqt6dueyC6GpDZRrMgiWlCuPb9lnIig/xH1Se9noKWSu4xp7LhDzqVF3+yzy
 XhY7rebTzhyxN2Cw=
X-Received: by 2002:a05:6000:149:: with SMTP id
 r9mr58817822wrx.147.1577717385987; 
 Mon, 30 Dec 2019 06:49:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqwoyCdJS9iCb7LWzNPNnx67VSQqhCv03xRq5fFJzhc/QHHr508jpNegf4aTX18joJxuxPlS0g==
X-Received: by 2002:a05:6000:149:: with SMTP id
 r9mr58817801wrx.147.1577717385596; 
 Mon, 30 Dec 2019 06:49:45 -0800 (PST)
Received: from [192.168.1.25] (abayonne-654-1-186-92.w92-134.abo.wanadoo.fr.
 [92.134.161.92])
 by smtp.gmail.com with ESMTPSA id p18sm21233033wmg.4.2019.12.30.06.49.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2019 06:49:45 -0800 (PST)
Subject: Re: [PATCH v2 08/10] arm: allwinner-h3: add Security Identifier device
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
 <20191216233519.29030-9-nieklinnenbank@gmail.com>
 <7153b766-4c3b-5272-3c3e-33e973e74e8f@redhat.com>
 <CAPan3Wob3Me-zbESYmFNQ4OczgLnxZZ0CtTxf8AHeRY4QyJ2+w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a1f0c5e1-36cd-126b-1fdf-22a641ab008a@redhat.com>
Date: Mon, 30 Dec 2019 15:49:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3Wob3Me-zbESYmFNQ4OczgLnxZZ0CtTxf8AHeRY4QyJ2+w@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: s6caWFlvPpCreUvoWK_vEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 12/18/19 9:49 PM, Niek Linnenbank wrote:
> Hi Philippe,
>=20
> On Tue, Dec 17, 2019 at 8:45 AM Philippe Mathieu-Daud=C3=A9=20
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>     Hi Niek,
>=20
>     On 12/17/19 12:35 AM, Niek Linnenbank wrote:
>      > The Security Identifier device in Allwinner H3 System on Chip
>      > gives applications a per-board unique identifier. This commit
>      > adds support for the Allwinner H3 Security Identifier using
>      > a 128-bit UUID value as input.
>      >
>      > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com
>     <mailto:nieklinnenbank@gmail.com>>
>      > ---
>      >=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A02 +
>      >=C2=A0 =C2=A0include/hw/misc/allwinner-h3-sid.h |=C2=A0 40 +++++++
>      >=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 ++
>      >=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +
>      >=C2=A0 =C2=A0hw/misc/allwinner-h3-sid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 179
>     +++++++++++++++++++++++++++++
>      >=C2=A0 =C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +
>      >=C2=A0 =C2=A0hw/misc/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +
>      >=C2=A0 =C2=A07 files changed, 237 insertions(+)
>      >=C2=A0 =C2=A0create mode 100644 include/hw/misc/allwinner-h3-sid.h
>      >=C2=A0 =C2=A0create mode 100644 hw/misc/allwinner-h3-sid.c
>      >
>      > diff --git a/include/hw/arm/allwinner-h3.h
>     b/include/hw/arm/allwinner-h3.h
>      > index 8128ae6131..c98c1972a6 100644
>      > --- a/include/hw/arm/allwinner-h3.h
>      > +++ b/include/hw/arm/allwinner-h3.h
>      > @@ -29,6 +29,7 @@
>      >=C2=A0 =C2=A0#include "hw/misc/allwinner-h3-clk.h"
>      >=C2=A0 =C2=A0#include "hw/misc/allwinner-h3-cpucfg.h"
>      >=C2=A0 =C2=A0#include "hw/misc/allwinner-h3-syscon.h"
>      > +#include "hw/misc/allwinner-h3-sid.h"
>      >=C2=A0 =C2=A0#include "target/arm/cpu.h"
>      >
>      >=C2=A0 =C2=A0enum {
>      > @@ -77,6 +78,7 @@ typedef struct AwH3State {
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3ClockState ccu;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3CpuCfgState cpucfg;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3SysconState syscon;
>      > +=C2=A0 =C2=A0 AwH3SidState sid;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0GICState gic;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a1;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a2;
>      > diff --git a/include/hw/misc/allwinner-h3-sid.h
>     b/include/hw/misc/allwinner-h3-sid.h
>      > new file mode 100644
>      > index 0000000000..79c9a24459
>      > --- /dev/null
>      > +++ b/include/hw/misc/allwinner-h3-sid.h
>      > @@ -0,0 +1,40 @@
>      > +/*
>      > + * Allwinner H3 Security ID emulation
>      > + *
>      > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com
>     <mailto:nieklinnenbank@gmail.com>>
>      > + *
>      > + * This program is free software: you can redistribute it and/or
>     modify
>      > + * it under the terms of the GNU General Public License as
>     published by
>      > + * the Free Software Foundation, either version 2 of the License,=
 or
>      > + * (at your option) any later version.
>      > + *
>      > + * This program is distributed in the hope that it will be useful=
,
>      > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>      > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See=
 the
>      > + * GNU General Public License for more details.
>      > + *
>      > + * You should have received a copy of the GNU General Public Lice=
nse
>      > + * along with this program.=C2=A0 If not, see
>     <http://www.gnu.org/licenses/>.
>      > + */
>      > +
>      > +#ifndef HW_MISC_ALLWINNER_H3_SID_H
>      > +#define HW_MISC_ALLWINNER_H3_SID_H
>      > +
>      > +#include "hw/sysbus.h"
>      > +#include "qemu/uuid.h"
>      > +
>      > +#define TYPE_AW_H3_SID=C2=A0 =C2=A0 "allwinner-h3-sid"
>      > +#define AW_H3_SID(obj)=C2=A0 =C2=A0 OBJECT_CHECK(AwH3SidState, (o=
bj),
>     TYPE_AW_H3_SID)
>      > +
>      > +typedef struct AwH3SidState {
>      > +=C2=A0 =C2=A0 /*< private >*/
>      > +=C2=A0 =C2=A0 SysBusDevice parent_obj;
>      > +=C2=A0 =C2=A0 /*< public >*/
>      > +
>      > +=C2=A0 =C2=A0 MemoryRegion iomem;
>      > +=C2=A0 =C2=A0 uint32_t control;
>      > +=C2=A0 =C2=A0 uint32_t rdkey;
>      > +=C2=A0 =C2=A0 QemuUUID identifier;
>      > +} AwH3SidState;
>      > +
>      > +#endif
>      > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
>      > index 1a9748ab2e..ba34f905cd 100644
>      > --- a/hw/arm/allwinner-h3.c
>      > +++ b/hw/arm/allwinner-h3.c
>      > @@ -196,6 +196,9 @@ static void aw_h3_init(Object *obj)
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_init_child_obj(obj, "cpucfg", &s-=
>cpucfg,
>     sizeof(s->cpucfg),
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_AW_H3_CPUCFG);
>      > +
>      > +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, "sid", &s->sid, sizeof(s=
->sid),
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_H3_SID);
>=20
>     Here add a property alias:
>=20
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_add_alias(obj, "identifi=
er", OBJECT(&s->sid),
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "identifier", &error_a=
bort);
>=20
>      >=C2=A0 =C2=A0}
>      >
>      >=C2=A0 =C2=A0static void aw_h3_realize(DeviceState *dev, Error **er=
rp)
>      > @@ -332,6 +335,10 @@ static void aw_h3_realize(DeviceState *dev,
>     Error **errp)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_init_nofail(DEVICE(&s->cpucfg));
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucf=
g), 0,
>     s->memmap[AW_H3_CPUCFG]);
>      >
>      > +=C2=A0 =C2=A0 /* Security Identifier */
>      > +=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(&s->sid));
>      > +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0,
>     s->memmap[AW_H3_SID]);
>      > +
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Universal Serial Bus */
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_create_simple(TYPE_AW_H3_EHCI, s-=
>memmap[AW_H3_EHCI0],
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&s->gic),
>      > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
>      > index 62cefc8c06..b01c4b4f01 100644
>      > --- a/hw/arm/orangepi.c
>      > +++ b/hw/arm/orangepi.c
>      > @@ -62,6 +62,10 @@ static void orangepi_init(MachineState *machine=
)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>      >
>      > +=C2=A0 =C2=A0 /* Setup SID properties */
>      > +=C2=A0 =C2=A0 qdev_prop_set_string(DEVICE(&s->h3->sid), "identifi=
er",
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0"8100c002-0001-0002-0003-000044556677");
>=20
>     And here use the alias:
>=20
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_string(DEVICE(&s->h3), "id=
entifier",
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"8100c002-0001-0002-0003-000044556677=
");
>=20
>=20
> Ah OK, I see what you mean. The boards should be using the SoC object=20
> only and
> not directly any of its sub devices, correct?
>=20
>=20
>     What means this value? Don't you want to be able to set it from comma=
nd
>     line?
>=20
> The first word 0x02c00081 is the identifying word for the H3 SoC in the=
=20
> SID data.
> After that come the per-device unique specific bytes. This is documented=
=20
> at the end of this page in 'Currently known SID's' on the=20
> linux-sunxi.org <http://linux-sunxi.org> Wiki:
> https://linux-sunxi.org/SID_Register_Guide
>=20
> The remaining parts of this value I simply made up without any real meani=
ng.
> And yes, it would in fact make sense to have the user be able to=20
> override it from the command line.
> It is used by U-boot as an input for generating the MAC address. Linux=20
> also reads it, but I did not investigate
> how it us used there. I think I did make a TODO of using a cmdline=20
> argument, but later forgot to actually implement it.
>=20
> Do you have a suggestion how to best provide the command line argument?=
=20
> I do see '-device driver[,prop=3Dvalue]'
> is there in the --help for qemu-system-arm, but it looks like that=20
> should be used by the user for adding PCI / USB devices?

Look for '-global' in the manpage:


   -global driver.prop=3Dvalue
   -global driver=3Ddriver,property=3Dproperty,value=3Dvalue

     Set default value of driver's property prop to value.

     In particular, you can use this to set driver properties
     for devices which are created automatically by the machine
     model. To create a device which is not created automatically
     and set properties on it, use -device.

     -global driver.prop=3Dvalue is shorthand for
     -global driver=3Ddriver,property=3Dprop,value=3Dvalue.

So this should work for your device:

     -global=20
allwinner-h3-sid.identifier=3D8100c002-0001-0002-0003-000044556677

>=20
>=20
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Mark H3 object realized */
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_bool(OBJECT(s->h3), =
true, "realized",
>     &error_abort);
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0if (error_abort !=3D NULL) {
>      > diff --git a/hw/misc/allwinner-h3-sid.c b/hw/misc/allwinner-h3-sid=
.c
>      > new file mode 100644
>      > index 0000000000..c472f2bcc6
>      > --- /dev/null
>      > +++ b/hw/misc/allwinner-h3-sid.c
>      > @@ -0,0 +1,179 @@
>      > +/*
>      > + * Allwinner H3 Security ID emulation
>      > + *
>      > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com
>     <mailto:nieklinnenbank@gmail.com>>
>      > + *
>      > + * This program is free software: you can redistribute it and/or
>     modify
>      > + * it under the terms of the GNU General Public License as
>     published by
>      > + * the Free Software Foundation, either version 2 of the License,=
 or
>      > + * (at your option) any later version.
>      > + *
>      > + * This program is distributed in the hope that it will be useful=
,
>      > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>      > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See=
 the
>      > + * GNU General Public License for more details.
>      > + *
>      > + * You should have received a copy of the GNU General Public Lice=
nse
>      > + * along with this program.=C2=A0 If not, see
>     <http://www.gnu.org/licenses/>.
>      > + */
>      > +
>      > +#include "qemu/osdep.h"
>      > +#include "qemu/units.h"
>      > +#include "hw/sysbus.h"
>      > +#include "migration/vmstate.h"
>      > +#include "qemu/log.h"
>      > +#include "qemu/module.h"
>      > +#include "qemu/guest-random.h"
>      > +#include "qapi/error.h"
>      > +#include "hw/qdev-properties.h"
>      > +#include "hw/misc/allwinner-h3-sid.h"
>      > +#include "trace.h"
>      > +
>      > +/* SID register offsets */
>      > +enum {
>      > +=C2=A0 =C2=A0 REG_PRCTL =3D 0x40,=C2=A0 =C2=A0/* Control */
>      > +=C2=A0 =C2=A0 REG_RDKEY =3D 0x60,=C2=A0 =C2=A0/* Read Key */
>      > +};
>      > +
>      > +/* SID register flags */
>      > +enum {
>      > +=C2=A0 =C2=A0 REG_PRCTL_WRITE=C2=A0 =C2=A0=3D 0x0002, /* Unknown =
write flag */
>      > +=C2=A0 =C2=A0 REG_PRCTL_OP_LOCK =3D 0xAC00, /* Lock operation */
>      > +};
>      > +
>      > +static uint64_t allwinner_h3_sid_read(void *opaque, hwaddr offset=
,
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsig=
ned size)
>      > +{
>      > +=C2=A0 =C2=A0 const AwH3SidState *s =3D (AwH3SidState *)opaque;
>      > +=C2=A0 =C2=A0 uint64_t val =3D 0;
>      > +
>      > +=C2=A0 =C2=A0 switch (offset) {
>      > +=C2=A0 =C2=A0 case REG_PRCTL:=C2=A0 =C2=A0 /* Control */
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s->control;
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>      > +=C2=A0 =C2=A0 case REG_RDKEY:=C2=A0 =C2=A0 /* Read Key */
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s->rdkey;
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>      > +=C2=A0 =C2=A0 default:
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, "%s: b=
ad read offset
>     0x%04x\n",
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 __func__, (uint32_t)offset);
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>      > +=C2=A0 =C2=A0 }
>      > +
>      > +=C2=A0 =C2=A0 trace_allwinner_h3_sid_read(offset, val, size);
>      > +
>      > +=C2=A0 =C2=A0 return val;
>      > +}
>      > +
>      > +static void allwinner_h3_sid_write(void *opaque, hwaddr offset,
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t val,=
 unsigned size)
>      > +{
>      > +=C2=A0 =C2=A0 AwH3SidState *s =3D (AwH3SidState *)opaque;
>      > +
>      > +=C2=A0 =C2=A0 trace_allwinner_h3_sid_write(offset, val, size);
>      > +
>      > +=C2=A0 =C2=A0 switch (offset) {
>      > +=C2=A0 =C2=A0 case REG_PRCTL:=C2=A0 =C2=A0 /* Control */
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->control =3D val;
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((s->control & REG_PRCTL_OP_LOCK) =
&&
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (s->control & REG_PRCTL=
_WRITE)) {
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t id =3D s->cont=
rol >> 16;
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (id < sizeof(QemuUUI=
D)) {
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s->rdkey =
=3D (s->identifier.data[id]) |
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s->identifier.data[id + 1] << 8) |
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s->identifier.data[id + 2] << 16) |
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s->identifier.data[id + 3] << 24);
>=20
>     This is:
>=20
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 s->rdkey =3D ldl_le_p(&s->identifier.data[id]);
>=20
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->control &=3D ~REG_PRCTL_WRITE;
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>      > +=C2=A0 =C2=A0 case REG_RDKEY:=C2=A0 =C2=A0 /* Read Key */
>=20
>     Read in a write()?
>=20
>     Maybe we can simply /* fall through */ LOG_GUEST_ERROR?
>=20
>=20
> When writing this module, I looked at how U-Boot is using the SID=20
> registers and simply
> named the registers after the names used by U-Boot. You can find this=20
> part in arch/arm/mach-sunxi/cpu_info.c:111,
> functions sun8i_efuse_read() and sunxi_get_sid(). U-Boot defines=20
> SIDC_RDKEY, so I named the register also rdkey.
> I used the U-Boot source because the Allwinner H3 datasheet does not=20
> document the registers. Later I
> found the SID page on the linux-sunxi wiki that I mentioned earlier, and=
=20
> they also describe the same register names:
>=20
> https://linux-sunxi.org/SID_Register_Guide

Hmm this page describe this register as RW, odd. I think this is wrong=20
because we deal with a fuse, and we program it via the REG_PRKEY=20
register. Does Linux/U-Boot do write access to this register?
We can start logging LOG_GUEST_ERROR, and correct it if we notice this=20
register is really writable (which I doubt).

>=20
> I suspect the information on this page is written based on the source=20
> code from the original SDK (which I did not study btw)
[...]


