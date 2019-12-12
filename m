Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B11C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 23:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF38F206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 23:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2PLqyFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF38F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifYLE-0007dA-1F
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 18:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifYK7-0006iB-6i
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifYK0-0002ej-Fu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:56:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43181
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifYK0-0002cH-8b
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576194999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CJPa9AQr5Qkt1HBH8pTks8XrKcLWox/hWmcu+vSRJ+U=;
 b=G2PLqyFWsGlQyZY2eFQYak08us2YuCeqW9ZFXsTNUjnR8xZCXTHXGIchohQPQZXAYvMP5g
 zH6FXhbOmCVN9GDW1ibirm+EKAz/iN+l7CjHeZcjx/qvwumsCYa6m9Nv5W9vRDkdXllclF
 L9kgaY4CXWpH+MeYczBBeIARM8HF0n0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-0_K3zL0FOeO1M4AUO61N-g-1; Thu, 12 Dec 2019 18:56:37 -0500
Received: by mail-wr1-f70.google.com with SMTP id k18so1648877wrw.9
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 15:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PR737s4Q8yWxu6WkWx+coGUZJ7eb4AmfCR+hVn5wWN8=;
 b=lBWuApusFcamt5VuTKT20wtG5qQJauiXhoN5LuKFxRYazqu5VvVRHfCLXM7CXwx3kq
 HYGwfoq1t8sFwKEbHs51rFdehPMr0lK8nsxUomBClsf+ZixX3Rm/EXLDbYKMUeWC/W39
 KZdnwtRkKhEG/wvyJNVjf2TEjW/iRSQF0LDM1LYF3rFcXrORRdEBIT4+7mcA/B8jzgvC
 ZbXsZneqArTkpDcK0vLev95Ga3EnKFthQtqyltrl23LTjlWUODoxaAXWyNrt7fT48gD3
 kmc28vKc6oZKv8xNO85kjJ6nwfmuCtYDtLmPMPdt1/rfBcOyqDadU0z8YHZoc4APbMlD
 xAdw==
X-Gm-Message-State: APjAAAUxkZGnHy7hWp8C1gD45AYoiROOoUvbIzvGGRj2W1zDXBr3vPbQ
 vlIf03ArxegkId5l1E+20unIkaJeeovHh2oSkA1hXXOumMvnT4YAf7m2C/ntBwsSuHRFcO3pjib
 2zKior2kg8Mx6rSE=
X-Received: by 2002:a05:600c:23c9:: with SMTP id
 p9mr1351829wmb.160.1576194995604; 
 Thu, 12 Dec 2019 15:56:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxb2qr2YofGbEw2rE0wKxY/gDMZiqV4K9J+b+Qg9WH4KUheucdsfZ2yNIiRHZNTgLluHoAeYQ==
X-Received: by 2002:a05:600c:23c9:: with SMTP id
 p9mr1351784wmb.160.1576194994943; 
 Thu, 12 Dec 2019 15:56:34 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id m7sm7980773wma.39.2019.12.12.15.56.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2019 15:56:34 -0800 (PST)
Subject: Re: [PATCH 09/10] arm: allwinner-h3: add SD/MMC host controller
To: Niek Linnenbank <nieklinnenbank@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-10-nieklinnenbank@gmail.com>
 <CAPan3WrRKnu5vFz=JvrnD8tewUk7SdwFVYx4xVL353AnfPDgHQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6bee15d7-7d80-0709-ac90-ef2052b39329@redhat.com>
Date: Fri, 13 Dec 2019 00:56:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3WrRKnu5vFz=JvrnD8tewUk7SdwFVYx4xVL353AnfPDgHQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 0_K3zL0FOeO1M4AUO61N-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Niek,

On 12/11/19 11:34 PM, Niek Linnenbank wrote:
> Ping!
>=20
> Anyone would like to comment on this driver?
>=20
> I finished the rework on all previous comments in this series.
>=20
> Currently debugging the hflags error reported by Philippe.
> After that, I'm ready to send out v2 of these patches.
>=20
> Regards,
> Niek
>=20
> On Mon, Dec 2, 2019 at 10:10 PM Niek Linnenbank=20
> <nieklinnenbank@gmail.com <mailto:nieklinnenbank@gmail.com>> wrote:
>=20
>     The Allwinner H3 System on Chip contains an integrated storage
>     controller for Secure Digital (SD) and Multi Media Card (MMC)
>     interfaces. This commit adds support for the Allwinner H3
>     SD/MMC storage controller with the following emulated features:
>=20
>      =C2=A0* DMA transfers
>      =C2=A0* Direct FIFO I/O
>      =C2=A0* Short/Long format command responses
>      =C2=A0* Auto-Stop command (CMD12)
>      =C2=A0* Insert & remove card detection
>=20
>     Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com
>     <mailto:nieklinnenbank@gmail.com>>
>     ---
>      =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 20 +
>      =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 17 +
>      =C2=A0hw/sd/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +
>      =C2=A0hw/sd/allwinner-h3-sdhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 791 ++++++++++++++++++++++++++++
>      =C2=A0hw/sd/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +
>      =C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A02 +
>      =C2=A0include/hw/sd/allwinner-h3-sdhost.h |=C2=A0 73 +++
>      =C2=A07 files changed, 911 insertions(+)
>      =C2=A0create mode 100644 hw/sd/allwinner-h3-sdhost.c
>      =C2=A0create mode 100644 include/hw/sd/allwinner-h3-sdhost.h
>=20
>     diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
>     index 4fc4c8c725..c2972caf88 100644
>     --- a/hw/arm/allwinner-h3.c
>     +++ b/hw/arm/allwinner-h3.c
>     @@ -50,6 +50,9 @@ static void aw_h3_init(Object *obj)
>=20
>      =C2=A0 =C2=A0 =C2=A0sysbus_init_child_obj(obj, "sid", &s->sid, sizeo=
f(s->sid),
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_AW_H3_SID);
>     +
>     +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, "mmc0", &s->mmc0, sizeof(s-=
>mmc0),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_H3_SDHOST);
>      =C2=A0}
>=20
>      =C2=A0static void aw_h3_realize(DeviceState *dev, Error **errp)
>     @@ -217,6 +220,23 @@ static void aw_h3_realize(DeviceState *dev,
>     Error **errp)
>      =C2=A0 =C2=A0 =C2=A0}
>      =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, AW_H=
3_SID_BASE);
>=20
>     +=C2=A0 =C2=A0 /* SD/MMC */
>     +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(&s->mmc0), true, "real=
ized", &err);
>     +=C2=A0 =C2=A0 if (err !=3D NULL) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     +=C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 sysbusdev =3D SYS_BUS_DEVICE(&s->mmc0);
>     +=C2=A0 =C2=A0 sysbus_mmio_map(sysbusdev, 0, AW_H3_MMC0_BASE);
>     +=C2=A0 =C2=A0 sysbus_connect_irq(sysbusdev, 0, s->irq[AW_H3_GIC_SPI_=
MMC0]);
>     +
>     +=C2=A0 =C2=A0 object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(=
&s->mmc0),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "sd-bus", &err);
>     +=C2=A0 =C2=A0 if (err) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     +=C2=A0 =C2=A0 }
>     +
>      =C2=A0 =C2=A0 =C2=A0/* Universal Serial Bus */
>      =C2=A0 =C2=A0 =C2=A0sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI=
0_BASE,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 s->irq[AW_H3_GIC_SPI_EHCI0]);
>     diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
>     index 5ef2735f81..dee3efaf08 100644
>     --- a/hw/arm/orangepi.c
>     +++ b/hw/arm/orangepi.c
>     @@ -39,6 +39,10 @@ typedef struct OrangePiState {
>      =C2=A0static void orangepi_init(MachineState *machine)
>      =C2=A0{
>      =C2=A0 =C2=A0 =C2=A0OrangePiState *s =3D g_new(OrangePiState, 1);
>     +=C2=A0 =C2=A0 DriveInfo *di;
>     +=C2=A0 =C2=A0 BlockBackend *blk;
>     +=C2=A0 =C2=A0 BusState *bus;
>     +=C2=A0 =C2=A0 DeviceState *carddev;
>      =C2=A0 =C2=A0 =C2=A0Error *err =3D NULL;
>=20
>      =C2=A0 =C2=A0 =C2=A0s->h3 =3D AW_H3(object_new(TYPE_AW_H3));
>     @@ -64,6 +68,18 @@ static void orangepi_init(MachineState *machine)
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);
>      =C2=A0 =C2=A0 =C2=A0}
>=20
>     +=C2=A0 =C2=A0 /* Create and plug in the SD card */
>     +=C2=A0 =C2=A0 di =3D drive_get_next(IF_SD);
>     +=C2=A0 =C2=A0 blk =3D di ? blk_by_legacy_dinfo(di) : NULL;
>     +=C2=A0 =C2=A0 bus =3D qdev_get_child_bus(DEVICE(s->h3), "sd-bus");
>     +=C2=A0 =C2=A0 if (bus =3D=3D NULL) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report("No SD/MMC found in H3 obje=
ct");
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);
>     +=C2=A0 =C2=A0 }

Your device always creates a bus, so I don't think the if(bus) check is=20
worthwhile. Eventually use an assert(bus)?

>     +=C2=A0 =C2=A0 carddev =3D qdev_create(bus, TYPE_SD_CARD);
>     +=C2=A0 =C2=A0 qdev_prop_set_drive(carddev, "drive", blk, &error_fata=
l);
>     +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(carddev), true, "reali=
zed",
>     &error_fatal);
>     +
>      =C2=A0 =C2=A0 =C2=A0/* RAM */
>      =C2=A0 =C2=A0 =C2=A0memory_region_allocate_system_memory(&s->sdram, =
NULL,
>     "orangepi.ram",
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 machine->ram_size);
>     @@ -80,6 +96,7 @@ static void orangepi_machine_init(MachineClass *mc)
>      =C2=A0{
>      =C2=A0 =C2=A0 =C2=A0mc->desc =3D "Orange Pi PC";
>      =C2=A0 =C2=A0 =C2=A0mc->init =3D orangepi_init;
>     +=C2=A0 =C2=A0 mc->block_default_type =3D IF_SD;
>      =C2=A0 =C2=A0 =C2=A0mc->units_per_default_bus =3D 1;
>      =C2=A0 =C2=A0 =C2=A0mc->min_cpus =3D AW_H3_NUM_CPUS;
>      =C2=A0 =C2=A0 =C2=A0mc->max_cpus =3D AW_H3_NUM_CPUS;
>     diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
>     index a884c238df..e7cc5ab739 100644
>     --- a/hw/sd/Makefile.objs
>     +++ b/hw/sd/Makefile.objs
>     @@ -4,6 +4,7 @@ common-obj-$(CONFIG_SD) +=3D sd.o core.o sdmmc-intern=
al.o
>      =C2=A0common-obj-$(CONFIG_SDHCI) +=3D sdhci.o
>      =C2=A0common-obj-$(CONFIG_SDHCI_PCI) +=3D sdhci-pci.o
>=20
>     +obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-sdhost.o
>      =C2=A0obj-$(CONFIG_MILKYMIST) +=3D milkymist-memcard.o
>      =C2=A0obj-$(CONFIG_OMAP) +=3D omap_mmc.o
>      =C2=A0obj-$(CONFIG_PXA2XX) +=3D pxa2xx_mmci.o
>     diff --git a/hw/sd/allwinner-h3-sdhost.c b/hw/sd/allwinner-h3-sdhost.=
c
>     new file mode 100644
>     index 0000000000..26e113a144
>     --- /dev/null
>     +++ b/hw/sd/allwinner-h3-sdhost.c
>     @@ -0,0 +1,791 @@
>     +/*
>     + * Allwinner H3 SD Host Controller emulation
>     + *
>     + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com
>     <mailto:nieklinnenbank@gmail.com>>
>     + *
>     + * This program is free software: you can redistribute it and/or mod=
ify
>     + * it under the terms of the GNU General Public License as published=
 by
>     + * the Free Software Foundation, either version 2 of the License, or
>     + * (at your option) any later version.
>     + *
>     + * This program is distributed in the hope that it will be useful,
>     + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>     + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See th=
e
>     + * GNU General Public License for more details.
>     + *
>     + * You should have received a copy of the GNU General Public License
>     + * along with this program.=C2=A0 If not, see
>     <http://www.gnu.org/licenses/>.
>     + */
>     +
>     +#include "qemu/osdep.h"
>     +#include "qemu/log.h"
>     +#include "qemu/module.h"
>     +#include "sysemu/blockdev.h"
>     +#include "hw/irq.h"
>     +#include "hw/sd/allwinner-h3-sdhost.h"
>     +#include "migration/vmstate.h"
>     +#include "trace.h"
>     +
>     +#define TYPE_AW_H3_SDHOST_BUS "allwinner-h3-sdhost-bus"
>     +#define AW_H3_SDHOST_BUS(obj) \
>     +=C2=A0 =C2=A0 OBJECT_CHECK(SDBus, (obj), TYPE_AW_H3_SDHOST_BUS)
>     +
>     +/* SD Host register offsets */
>     +#define REG_SD_GCTL=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x00)=C2=A0 /* Globa=
l Control */
>     +#define REG_SD_CKCR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x04)=C2=A0 /* Clock=
 Control */
>     +#define REG_SD_TMOR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x08)=C2=A0 /* Timeo=
ut */
>     +#define REG_SD_BWDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0C)=C2=A0 /* Bus W=
idth */
>     +#define REG_SD_BKSR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x10)=C2=A0 /* Block=
 Size */
>     +#define REG_SD_BYCR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x14)=C2=A0 /* Byte =
Count */
>     +#define REG_SD_CMDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x18)=C2=A0 /* Comma=
nd */
>     +#define REG_SD_CAGR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x1C)=C2=A0 /* Comma=
nd Argument */
>     +#define REG_SD_RESP0=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x20)=C2=A0 /* Respo=
nse Zero */
>     +#define REG_SD_RESP1=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x24)=C2=A0 /* Respo=
nse One */
>     +#define REG_SD_RESP2=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x28)=C2=A0 /* Respo=
nse Two */
>     +#define REG_SD_RESP3=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x2C)=C2=A0 /* Respo=
nse Three */
>     +#define REG_SD_IMKR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x30)=C2=A0 /* Inter=
rupt Mask */
>     +#define REG_SD_MISR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x34)=C2=A0 /* Maske=
d Interrupt Status */
>     +#define REG_SD_RISR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x38)=C2=A0 /* Raw I=
nterrupt Status */
>     +#define REG_SD_STAR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x3C)=C2=A0 /* Statu=
s */
>     +#define REG_SD_FWLR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x40)=C2=A0 /* FIFO =
Water Level */
>     +#define REG_SD_FUNS=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x44)=C2=A0 /* FIFO =
Function Select */
>     +#define REG_SD_DBGC=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x50)=C2=A0 /* Debug=
 Enable */
>     +#define REG_SD_A12A=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x58)=C2=A0 /* Auto =
command 12 argument */
>     +#define REG_SD_NTSR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x5C)=C2=A0 /* SD Ne=
wTiming Set */
>     +#define REG_SD_SDBG=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x60)=C2=A0 /* SD ne=
wTiming Set Debug */
>     +#define REG_SD_HWRST=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x78)=C2=A0 /* Hardw=
are Reset Register */
>     +#define REG_SD_DMAC=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x80)=C2=A0 /* Inter=
nal DMA Controller
>     Control */
>     +#define REG_SD_DLBA=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x84)=C2=A0 /* Descr=
iptor List Base Address */
>     +#define REG_SD_IDST=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x88)=C2=A0 /* Inter=
nal DMA Controller Status */
>     +#define REG_SD_IDIE=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x8C)=C2=A0 /* Inter=
nal DMA Controller IRQ
>     Enable */
>     +#define REG_SD_THLDC=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x100) /* Card Thres=
hold Control */
>     +#define REG_SD_DSBD=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x10C) /* eMMC DDR S=
tart Bit Detection
>     Control */
>     +#define REG_SD_RES_CRC=C2=A0 =C2=A0 =C2=A0(0x110) /* Response CRC fr=
om card/eMMC */
>     +#define REG_SD_DATA7_CRC=C2=A0 =C2=A0(0x114) /* CRC Data 7 from card=
/eMMC */
>     +#define REG_SD_DATA6_CRC=C2=A0 =C2=A0(0x118) /* CRC Data 6 from card=
/eMMC */
>     +#define REG_SD_DATA5_CRC=C2=A0 =C2=A0(0x11C) /* CRC Data 5 from card=
/eMMC */
>     +#define REG_SD_DATA4_CRC=C2=A0 =C2=A0(0x120) /* CRC Data 4 from card=
/eMMC */
>     +#define REG_SD_DATA3_CRC=C2=A0 =C2=A0(0x124) /* CRC Data 3 from card=
/eMMC */
>     +#define REG_SD_DATA2_CRC=C2=A0 =C2=A0(0x128) /* CRC Data 2 from card=
/eMMC */
>     +#define REG_SD_DATA1_CRC=C2=A0 =C2=A0(0x12C) /* CRC Data 1 from card=
/eMMC */
>     +#define REG_SD_DATA0_CRC=C2=A0 =C2=A0(0x130) /* CRC Data 0 from card=
/eMMC */
>     +#define REG_SD_CRC_STA=C2=A0 =C2=A0 =C2=A0(0x134) /* CRC status from=
 card/eMMC
>     during write */
>     +#define REG_SD_FIFO=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x200) /* Read/Write=
 FIFO */
>     +
>     +/* SD Host register flags */
>     +#define SD_GCTL_FIFO_AC_MOD=C2=A0 =C2=A0 =C2=A0(1 << 31)
>     +#define SD_GCTL_DDR_MOD_SEL=C2=A0 =C2=A0 =C2=A0(1 << 10)
>     +#define SD_GCTL_CD_DBC_ENB=C2=A0 =C2=A0 =C2=A0 (1 << 8)
>     +#define SD_GCTL_DMA_ENB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 << 5)
>     +#define SD_GCTL_INT_ENB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 << 4)
>     +#define SD_GCTL_DMA_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 << 2)
>     +#define SD_GCTL_FIFO_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 << 1)
>     +#define SD_GCTL_SOFT_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 << 0)
>     +
>     +#define SD_CMDR_LOAD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 << =
31)
>     +#define SD_CMDR_CLKCHANGE=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 << 21)
>     +#define SD_CMDR_WRITE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 << =
10)
>     +#define SD_CMDR_AUTOSTOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 << 12)
>     +#define SD_CMDR_DATA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 << =
9)
>     +#define SD_CMDR_RESPONSE_LONG=C2=A0 =C2=A0(1 << 7)
>     +#define SD_CMDR_RESPONSE=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 << 6)
>     +#define SD_CMDR_CMDID_MASK=C2=A0 =C2=A0 =C2=A0 (0x3f)
>     +
>     +#define SD_RISR_CARD_REMOVE=C2=A0 =C2=A0 =C2=A0(1 << 31)
>     +#define SD_RISR_CARD_INSERT=C2=A0 =C2=A0 =C2=A0(1 << 30)
>     +#define SD_RISR_AUTOCMD_DONE=C2=A0 =C2=A0 (1 << 14)
>     +#define SD_RISR_DATA_COMPLETE=C2=A0 =C2=A0(1 << 3)
>     +#define SD_RISR_CMD_COMPLETE=C2=A0 =C2=A0 (1 << 2)
>     +#define SD_RISR_NO_RESPONSE=C2=A0 =C2=A0 =C2=A0(1 << 1)
>     +
>     +#define SD_STAR_CARD_PRESENT=C2=A0 =C2=A0 (1 << 8)
>     +
>     +#define SD_IDST_SUM_RECEIVE_IRQ (1 << 8)
>     +#define SD_IDST_RECEIVE_IRQ=C2=A0 =C2=A0 =C2=A0(1 << 1)
>     +#define SD_IDST_TRANSMIT_IRQ=C2=A0 =C2=A0 (1 << 0)
>     +#define SD_IDST_IRQ_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 (SD_IDST_RECEIVE=
_IRQ |
>     SD_IDST_TRANSMIT_IRQ | \
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SD_IDST_SUM_RECEIVE_IRQ=
)
>     +#define SD_IDST_WR_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x3ff)
>     +
>     +/* SD Host register reset values */
>     +#define REG_SD_GCTL_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00000300=
)
>     +#define REG_SD_CKCR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_TMOR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0xFFFFFF40=
)
>     +#define REG_SD_BWDR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_BKSR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00000200=
)
>     +#define REG_SD_BYCR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00000200=
)
>     +#define REG_SD_CMDR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_CAGR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_RESP_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_IMKR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_MISR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_RISR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_STAR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00000100=
)
>     +#define REG_SD_FWLR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x000F0000=
)
>     +#define REG_SD_FUNS_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_DBGC_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_A12A_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0000FFFF=
)
>     +#define REG_SD_NTSR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00000001=
)
>     +#define REG_SD_SDBG_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_HWRST_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x00000001)
>     +#define REG_SD_DMAC_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_DLBA_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_IDST_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_IDIE_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_THLDC_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0)
>     +#define REG_SD_DSBD_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_RES_CRC_RST=C2=A0 =C2=A0 =C2=A0 (0x0)
>     +#define REG_SD_DATA_CRC_RST=C2=A0 =C2=A0 =C2=A0(0x0)
>     +#define REG_SD_CRC_STA_RST=C2=A0 =C2=A0 =C2=A0 (0x0)
>     +#define REG_SD_FIFO_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)
>     +
>     +/* Data transfer descriptor for DMA */
>     +typedef struct TransferDescriptor {
>     +=C2=A0 =C2=A0 uint32_t status; /* Status flags */
>     +=C2=A0 =C2=A0 uint32_t size;=C2=A0 =C2=A0/* Data buffer size */
>     +=C2=A0 =C2=A0 uint32_t addr;=C2=A0 =C2=A0/* Data buffer address */
>     +=C2=A0 =C2=A0 uint32_t next;=C2=A0 =C2=A0/* Physical address of next=
 descriptor */
>     +} TransferDescriptor;
>     +
>     +/* Data transfer descriptor flags */
>     +#define DESC_STATUS_HOLD=C2=A0 =C2=A0(1 << 31) /* Set when descripto=
r is in
>     use by DMA */
>     +#define DESC_STATUS_ERROR=C2=A0 (1 << 30) /* Set when DMA transfer e=
rror
>     occurred */
>     +#define DESC_STATUS_CHAIN=C2=A0 (1 << 4)=C2=A0 /* Indicates chained
>     descriptor. */
>     +#define DESC_STATUS_FIRST=C2=A0 (1 << 3)=C2=A0 /* Set on the first d=
escriptor */
>     +#define DESC_STATUS_LAST=C2=A0 =C2=A0(1 << 2)=C2=A0 /* Set on the la=
st descriptor */
>     +#define DESC_STATUS_NOIRQ=C2=A0 (1 << 1)=C2=A0 /* Skip raising inter=
rupt
>     after transfer */
>     +
>     +#define DESC_SIZE_MASK=C2=A0 =C2=A0 =C2=A0(0xfffffffc)
>     +
>     +static void aw_h3_sdhost_update_irq(AwH3SDHostState *s)
>     +{
>     +=C2=A0 =C2=A0 uint32_t irq_en =3D s->global_ctl & SD_GCTL_INT_ENB;
>     +=C2=A0 =C2=A0 uint32_t irq =3D irq_en ? s->irq_status & s->irq_mask =
: 0;

The previous line is confuse, either use parenthesis or a if statement.

     uint32_t irq =3D irq_en ? (s->irq_status & s->irq_mask) : 0;

>     +
>     +=C2=A0 =C2=A0 trace_aw_h3_sdhost_update_irq(irq);
>     +=C2=A0 =C2=A0 qemu_set_irq(s->irq, irq);
>     +}
>     +
>     +static void aw_h3_sdhost_update_transfer_cnt(AwH3SDHostState *s,
>     uint32_t bytes)
>     +{
>     +=C2=A0 =C2=A0 if (s->transfer_cnt > bytes) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->transfer_cnt -=3D bytes;
>     +=C2=A0 =C2=A0 } else {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->transfer_cnt =3D 0;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 if (!s->transfer_cnt) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->irq_status |=3D SD_RISR_DATA_COMPLETE=
 | SD_RISR_AUTOCMD_DONE;
>     +=C2=A0 =C2=A0 }
>     +}
>     +
>     +static void aw_h3_sdhost_set_inserted(DeviceState *dev, bool inserte=
d)
>     +{
>     +=C2=A0 =C2=A0 AwH3SDHostState *s =3D AW_H3_SDHOST(dev);
>     +
>     +=C2=A0 =C2=A0 trace_aw_h3_sdhost_set_inserted(inserted);
>     +
>     +=C2=A0 =C2=A0 if (inserted) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->irq_status |=3D SD_RISR_CARD_INSERT;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->irq_status &=3D ~SD_RISR_CARD_REMOVE;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->status |=3D SD_STAR_CARD_PRESENT;
>     +=C2=A0 =C2=A0 } else {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->irq_status &=3D ~SD_RISR_CARD_INSERT;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->irq_status |=3D SD_RISR_CARD_REMOVE;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->status &=3D ~SD_STAR_CARD_PRESENT;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);
>     +}
>     +
>     +static void aw_h3_sdhost_send_command(AwH3SDHostState *s)
>     +{
>     +=C2=A0 =C2=A0 SDRequest request;
>     +=C2=A0 =C2=A0 uint8_t resp[16];
>     +=C2=A0 =C2=A0 int rlen;
>     +
>     +=C2=A0 =C2=A0 /* Auto clear load flag */
>     +=C2=A0 =C2=A0 s->command &=3D ~SD_CMDR_LOAD;
>     +
>     +=C2=A0 =C2=A0 /* Clock change does not actually interact with the SD=
 bus */
>     +=C2=A0 =C2=A0 if (!(s->command & SD_CMDR_CLKCHANGE)) {
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Prepare request */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 request.cmd =3D s->command & SD_CMDR_CMD=
ID_MASK;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 request.arg =3D s->command_arg;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Send request to SD bus */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rlen =3D sdbus_do_command(&s->sdbus, &re=
quest, resp);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rlen < 0) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If the command has a response, store =
it in the response
>     registers */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((s->command & SD_CMDR_RESPONSE)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rlen =3D=3D 0 ||
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rlen =3D=3D =
4 && (s->command & SD_CMDR_RESPONSE_LONG))) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rlen !=3D 4 && rlen !=
=3D 16) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }

Maybe remove previous if...

>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rlen =3D=3D 4) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s->response[=
0] =3D ldl_be_p(&resp[0]);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s->response[=
1] =3D s->response[2] =3D s->response[3] =3D 0;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {

...

                    } else if (rlen =3D=3D 16) { ...

>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s->response[=
0] =3D ldl_be_p(&resp[12]);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s->response[=
1] =3D ldl_be_p(&resp[8]);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s->response[=
2] =3D ldl_be_p(&resp[4]);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s->response[=
3] =3D ldl_be_p(&resp[0]);

...

                    } else {
                        goto error;

>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 /* Set interrupt status bits */
>     +=C2=A0 =C2=A0 s->irq_status |=3D SD_RISR_CMD_COMPLETE;
>     +=C2=A0 =C2=A0 return;
>     +
>     +error:
>     +=C2=A0 =C2=A0 s->irq_status |=3D SD_RISR_NO_RESPONSE;
>     +}
>     +
>     +static void aw_h3_sdhost_auto_stop(AwH3SDHostState *s)
>     +{
>     +=C2=A0 =C2=A0 /*
>     +=C2=A0 =C2=A0 =C2=A0* The stop command (CMD12) ensures the SD bus
>     +=C2=A0 =C2=A0 =C2=A0* returns to the transfer state.
>     +=C2=A0 =C2=A0 =C2=A0*/
>     +=C2=A0 =C2=A0 if ((s->command & SD_CMDR_AUTOSTOP) && (s->transfer_cn=
t =3D=3D 0)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* First save current command registers =
*/
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t saved_cmd =3D s->command;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t saved_arg =3D s->command_arg;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Prepare stop command (CMD12) */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->command &=3D ~SD_CMDR_CMDID_MASK;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->command |=3D 12; /* CMD12 */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->command_arg =3D 0;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Put the command on SD bus */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_send_command(s);
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Restore command values */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->command =3D saved_cmd;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->command_arg =3D saved_arg;
>     +=C2=A0 =C2=A0 }
>     +}
>     +
>     +static uint32_t aw_h3_sdhost_process_desc(AwH3SDHostState *s,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 hwaddr desc_addr,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 TransferDescriptor *desc,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 bool is_write, uint32_t
>     max_bytes)
>     +{
>     +=C2=A0 =C2=A0 uint32_t num_done =3D 0;
>     +=C2=A0 =C2=A0 uint32_t num_bytes =3D max_bytes;
>     +=C2=A0 =C2=A0 uint8_t buf[1024];
>     +
>     +=C2=A0 =C2=A0 /* Read descriptor */
>     +=C2=A0 =C2=A0 cpu_physical_memory_read(desc_addr, desc, sizeof(*desc=
));

Should we worry about endianess here?

>     +=C2=A0 =C2=A0 if (desc->size =3D=3D 0) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->size =3D 0xffff + 1;

Why not write '64 * KiB'?

>     +=C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 if (desc->size < num_bytes) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 num_bytes =3D desc->size;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 trace_aw_h3_sdhost_process_desc(desc_addr, desc->size,
>     is_write, max_bytes);
>     +
>     +=C2=A0 =C2=A0 while (num_done < num_bytes) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Try to completely fill the local buff=
er */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t buf_bytes =3D num_bytes - num_d=
one;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (buf_bytes > sizeof(buf)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_bytes =3D sizeof(buf);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Write to SD bus */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_write) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_read((=
desc->addr & DESC_SIZE_MASK)
>     + num_done,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf, buf=
_bytes);
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (uint32_t i =3D 0; i <=
 buf_bytes; i++) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sdbus_write_=
data(&s->sdbus, buf[i]);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Read from SD bus */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (uint32_t i =3D 0; i <=
 buf_bytes; i++) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[i] =3D s=
dbus_read_data(&s->sdbus);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_write(=
(desc->addr & DESC_SIZE_MASK)
>     + num_done,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bu=
f, buf_bytes);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 num_done +=3D buf_bytes;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 /* Clear hold flag and flush descriptor */
>     +=C2=A0 =C2=A0 desc->status &=3D ~DESC_STATUS_HOLD;
>     +=C2=A0 =C2=A0 cpu_physical_memory_write(desc_addr, desc, sizeof(*des=
c));

(Related to previous endianess question).

>     +
>     +=C2=A0 =C2=A0 return num_done;
>     +}
>     +
>     +static void aw_h3_sdhost_dma(AwH3SDHostState *s)
>     +{
>     +=C2=A0 =C2=A0 TransferDescriptor desc;
>     +=C2=A0 =C2=A0 hwaddr desc_addr =3D s->desc_base;
>     +=C2=A0 =C2=A0 bool is_write =3D (s->command & SD_CMDR_WRITE);
>     +=C2=A0 =C2=A0 uint32_t bytes_done =3D 0;
>     +
>     +=C2=A0 =C2=A0 /* Check if DMA can be performed */
>     +=C2=A0 =C2=A0 if (s->byte_count =3D=3D 0 || s->block_size =3D=3D 0 |=
|
>     +=C2=A0 =C2=A0 =C2=A0 !(s->global_ctl & SD_GCTL_DMA_ENB)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 /*
>     +=C2=A0 =C2=A0 =C2=A0* For read operations, data must be available on=
 the SD bus
>     +=C2=A0 =C2=A0 =C2=A0* If not, it is an error and we should not act a=
t all
>     +=C2=A0 =C2=A0 =C2=A0*/
>     +=C2=A0 =C2=A0 if (!is_write && !sdbus_data_ready(&s->sdbus)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 /* Process the DMA descriptors until all data is copie=
d */
>     +=C2=A0 =C2=A0 while (s->byte_count > 0) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_done =3D aw_h3_sdhost_process_desc=
(s, desc_addr, &desc,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0is_write,
>     s->byte_count);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_transfer_cnt(s, byte=
s_done);
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes_done <=3D s->byte_count) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s->byte_count -=3D bytes_d=
one;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s->byte_count =3D 0;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (desc.status & DESC_STATUS_LAST) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc_addr =3D desc.next;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 /* Raise IRQ to signal DMA is completed */
>     +=C2=A0 =C2=A0 s->irq_status |=3D SD_RISR_DATA_COMPLETE | SD_RISR_AUT=
OCMD_DONE;
>     +
>     +=C2=A0 =C2=A0 /* Update DMAC bits */
>     +=C2=A0 =C2=A0 if (is_write) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->dmac_status |=3D SD_IDST_TRANSMIT_IRQ=
;
>     +=C2=A0 =C2=A0 } else {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->dmac_status |=3D (SD_IDST_SUM_RECEIVE=
_IRQ |
>     SD_IDST_RECEIVE_IRQ);
>     +=C2=A0 =C2=A0 }
>     +}
>     +
>     +static uint64_t aw_h3_sdhost_read(void *opaque, hwaddr offset,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned size)
>     +{
>     +=C2=A0 =C2=A0 AwH3SDHostState *s =3D (AwH3SDHostState *)opaque;
>     +=C2=A0 =C2=A0 uint32_t res =3D 0;
>     +
>     +=C2=A0 =C2=A0 switch (offset) {
>     +=C2=A0 =C2=A0 case REG_SD_GCTL:=C2=A0 =C2=A0 =C2=A0 /* Global Contro=
l */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->global_ctl;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_CKCR:=C2=A0 =C2=A0 =C2=A0 /* Clock Control=
 */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->clock_ctl;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_TMOR:=C2=A0 =C2=A0 =C2=A0 /* Timeout */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->timeout;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_BWDR:=C2=A0 =C2=A0 =C2=A0 /* Bus Width */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->bus_width;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_BKSR:=C2=A0 =C2=A0 =C2=A0 /* Block Size */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->block_size;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_BYCR:=C2=A0 =C2=A0 =C2=A0 /* Byte Count */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->byte_count;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_CMDR:=C2=A0 =C2=A0 =C2=A0 /* Command */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->command;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_CAGR:=C2=A0 =C2=A0 =C2=A0 /* Command Argum=
ent */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->command_arg;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_RESP0:=C2=A0 =C2=A0 =C2=A0/* Response Zero=
 */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->response[0];
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_RESP1:=C2=A0 =C2=A0 =C2=A0/* Response One =
*/
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->response[1];
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_RESP2:=C2=A0 =C2=A0 =C2=A0/* Response Two =
*/
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->response[2];
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_RESP3:=C2=A0 =C2=A0 =C2=A0/* Response Thre=
e */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->response[3];
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_IMKR:=C2=A0 =C2=A0 =C2=A0 /* Interrupt Mas=
k */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->irq_mask;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_MISR:=C2=A0 =C2=A0 =C2=A0 /* Masked Interr=
upt Status */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->irq_status & s->irq_mask;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_RISR:=C2=A0 =C2=A0 =C2=A0 /* Raw Interrupt=
 Status */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->irq_status;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_STAR:=C2=A0 =C2=A0 =C2=A0 /* Status */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->status;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_FWLR:=C2=A0 =C2=A0 =C2=A0 /* FIFO Water Le=
vel */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->fifo_wlevel;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_FUNS:=C2=A0 =C2=A0 =C2=A0 /* FIFO Function=
 Select */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->fifo_func_sel;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_DBGC:=C2=A0 =C2=A0 =C2=A0 /* Debug Enable =
*/
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->debug_enable;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_A12A:=C2=A0 =C2=A0 =C2=A0 /* Auto command =
12 argument */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->auto12_arg;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_NTSR:=C2=A0 =C2=A0 =C2=A0 /* SD NewTiming =
Set */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->newtiming_set;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_SDBG:=C2=A0 =C2=A0 =C2=A0 /* SD newTiming =
Set Debug */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->newtiming_debug;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_HWRST:=C2=A0 =C2=A0 =C2=A0/* Hardware Rese=
t Register */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->hardware_rst;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_DMAC:=C2=A0 =C2=A0 =C2=A0 /* Internal DMA =
Controller Control */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->dmac;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_DLBA:=C2=A0 =C2=A0 =C2=A0 /* Descriptor Li=
st Base Address */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->desc_base;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_IDST:=C2=A0 =C2=A0 =C2=A0 /* Internal DMA =
Controller Status */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->dmac_status;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_IDIE:=C2=A0 =C2=A0 =C2=A0 /* Internal DMA =
Controller Interrupt
>     Enable */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->dmac_irq;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_THLDC:=C2=A0 =C2=A0 =C2=A0/* Card Threshol=
d Control */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->card_threshold;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_DSBD:=C2=A0 =C2=A0 =C2=A0 /* eMMC DDR Star=
t Bit Detection Control */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->startbit_detect;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_RES_CRC:=C2=A0 =C2=A0/* Response CRC from =
card/eMMC */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->response_crc;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_DATA7_CRC: /* CRC Data 7 from card/eMMC */
>     +=C2=A0 =C2=A0 case REG_SD_DATA6_CRC: /* CRC Data 6 from card/eMMC */
>     +=C2=A0 =C2=A0 case REG_SD_DATA5_CRC: /* CRC Data 5 from card/eMMC */
>     +=C2=A0 =C2=A0 case REG_SD_DATA4_CRC: /* CRC Data 4 from card/eMMC */
>     +=C2=A0 =C2=A0 case REG_SD_DATA3_CRC: /* CRC Data 3 from card/eMMC */
>     +=C2=A0 =C2=A0 case REG_SD_DATA2_CRC: /* CRC Data 2 from card/eMMC */
>     +=C2=A0 =C2=A0 case REG_SD_DATA1_CRC: /* CRC Data 1 from card/eMMC */
>     +=C2=A0 =C2=A0 case REG_SD_DATA0_CRC: /* CRC Data 0 from card/eMMC */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->data_crc[((offset - REG_SD_DA=
TA7_CRC) /
>     sizeof(uint32_t))];
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_CRC_STA:=C2=A0 =C2=A0/* CRC status from ca=
rd/eMMC in write
>     operation */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s->status_crc;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_FIFO:=C2=A0 =C2=A0 =C2=A0 /* Read/Write FI=
FO */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sdbus_data_ready(&s->sdbus)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D sdbus_read_data(&s=
->sdbus);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res |=3D sdbus_read_data(&=
s->sdbus) << 8;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res |=3D sdbus_read_data(&=
s->sdbus) << 16;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res |=3D sdbus_read_data(&=
s->sdbus) << 24;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_transf=
er_cnt(s, sizeof(uint32_t));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_auto_stop(s);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s)=
;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ER=
ROR, "%s: no data ready on SD
>     bus\n",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 __func__);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 default:
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad =
offset
>     %"HWADDR_PRIx"\n",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 __func__, offset);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D 0;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 trace_aw_h3_sdhost_read(offset, res, size);
>     +=C2=A0 =C2=A0 return res;
>     +}
>     +
>     +static void aw_h3_sdhost_write(void *opaque, hwaddr offset,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t value, unsigned size)
>     +{
>     +=C2=A0 =C2=A0 AwH3SDHostState *s =3D (AwH3SDHostState *)opaque;
>     +
>     +=C2=A0 =C2=A0 trace_aw_h3_sdhost_write(offset, value, size);
>     +
>     +=C2=A0 =C2=A0 switch (offset) {
>     +=C2=A0 =C2=A0 case REG_SD_GCTL:=C2=A0 =C2=A0 =C2=A0 /* Global Contro=
l */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->global_ctl =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->global_ctl &=3D ~(SD_GCTL_DMA_RST | S=
D_GCTL_FIFO_RST |
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SD_GCTL_SOFT_RST);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_CKCR:=C2=A0 =C2=A0 =C2=A0 /* Clock Control=
 */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->clock_ctl =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_TMOR:=C2=A0 =C2=A0 =C2=A0 /* Timeout */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->timeout =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_BWDR:=C2=A0 =C2=A0 =C2=A0 /* Bus Width */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->bus_width =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_BKSR:=C2=A0 =C2=A0 =C2=A0 /* Block Size */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->block_size =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_BYCR:=C2=A0 =C2=A0 =C2=A0 /* Byte Count */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->byte_count =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->transfer_cnt =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_CMDR:=C2=A0 =C2=A0 =C2=A0 /* Command */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->command =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value & SD_CMDR_LOAD) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_send_command(=
s);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_dma(s);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_auto_stop(s);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_CAGR:=C2=A0 =C2=A0 =C2=A0 /* Command Argum=
ent */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->command_arg =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_RESP0:=C2=A0 =C2=A0 =C2=A0/* Response Zero=
 */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->response[0] =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_RESP1:=C2=A0 =C2=A0 =C2=A0/* Response One =
*/
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->response[1] =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_RESP2:=C2=A0 =C2=A0 =C2=A0/* Response Two =
*/
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->response[2] =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_RESP3:=C2=A0 =C2=A0 =C2=A0/* Response Thre=
e */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->response[3] =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_IMKR:=C2=A0 =C2=A0 =C2=A0 /* Interrupt Mas=
k */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->irq_mask =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_MISR:=C2=A0 =C2=A0 =C2=A0 /* Masked Interr=
upt Status */
>     +=C2=A0 =C2=A0 case REG_SD_RISR:=C2=A0 =C2=A0 =C2=A0 /* Raw Interrupt=
 Status */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->irq_status &=3D ~value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_STAR:=C2=A0 =C2=A0 =C2=A0 /* Status */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->status &=3D ~value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_FWLR:=C2=A0 =C2=A0 =C2=A0 /* FIFO Water Le=
vel */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->fifo_wlevel =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_FUNS:=C2=A0 =C2=A0 =C2=A0 /* FIFO Function=
 Select */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->fifo_func_sel =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_DBGC:=C2=A0 =C2=A0 =C2=A0 /* Debug Enable =
*/
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->debug_enable =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_A12A:=C2=A0 =C2=A0 =C2=A0 /* Auto command =
12 argument */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->auto12_arg =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_NTSR:=C2=A0 =C2=A0 =C2=A0 /* SD NewTiming =
Set */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->newtiming_set =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_SDBG:=C2=A0 =C2=A0 =C2=A0 /* SD newTiming =
Set Debug */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->newtiming_debug =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_HWRST:=C2=A0 =C2=A0 =C2=A0/* Hardware Rese=
t Register */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->hardware_rst =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_DMAC:=C2=A0 =C2=A0 =C2=A0 /* Internal DMA =
Controller Control */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->dmac =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_DLBA:=C2=A0 =C2=A0 =C2=A0 /* Descriptor Li=
st Base Address */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->desc_base =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_IDST:=C2=A0 =C2=A0 =C2=A0 /* Internal DMA =
Controller Status */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->dmac_status &=3D (~SD_IDST_WR_MASK) |=
 (~value &
>     SD_IDST_WR_MASK);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_IDIE:=C2=A0 =C2=A0 =C2=A0 /* Internal DMA =
Controller Interrupt
>     Enable */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->dmac_irq =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_THLDC:=C2=A0 =C2=A0 =C2=A0/* Card Threshol=
d Control */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->card_threshold =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_DSBD:=C2=A0 =C2=A0 =C2=A0 /* eMMC DDR Star=
t Bit Detection Control */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->startbit_detect =3D value;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_FIFO:=C2=A0 =C2=A0 =C2=A0 /* Read/Write FI=
FO */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sdbus_write_data(&s->sdbus, value & 0xff=
);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sdbus_write_data(&s->sdbus, (value >> 8)=
 & 0xff);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sdbus_write_data(&s->sdbus, (value >> 16=
) & 0xff);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sdbus_write_data(&s->sdbus, (value >> 24=
) & 0xff);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_transfer_cnt(s, size=
of(uint32_t));
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_auto_stop(s);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 case REG_SD_RES_CRC:=C2=A0 =C2=A0/* Response CRC from =
card/eMMC */
>     +=C2=A0 =C2=A0 case REG_SD_DATA7_CRC: /* CRC Data 7 from card/eMMC */
>     +=C2=A0 =C2=A0 case REG_SD_DATA6_CRC: /* CRC Data 6 from card/eMMC */
>     +=C2=A0 =C2=A0 case REG_SD_DATA5_CRC: /* CRC Data 5 from card/eMMC */
>     +=C2=A0 =C2=A0 case REG_SD_DATA4_CRC: /* CRC Data 4 from card/eMMC */
>     +=C2=A0 =C2=A0 case REG_SD_DATA3_CRC: /* CRC Data 3 from card/eMMC */
>     +=C2=A0 =C2=A0 case REG_SD_DATA2_CRC: /* CRC Data 2 from card/eMMC */
>     +=C2=A0 =C2=A0 case REG_SD_DATA1_CRC: /* CRC Data 1 from card/eMMC */
>     +=C2=A0 =C2=A0 case REG_SD_DATA0_CRC: /* CRC Data 0 from card/eMMC */
>     +=C2=A0 =C2=A0 case REG_SD_CRC_STA:=C2=A0 =C2=A0/* CRC status from ca=
rd/eMMC in write
>     operation */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 default:
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad =
offset
>     %"HWADDR_PRIx"\n",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 __func__, offset);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>     +=C2=A0 =C2=A0 }
>     +}
>     +
>     +static const MemoryRegionOps aw_h3_sdhost_ops =3D {
>     +=C2=A0 =C2=A0 .read =3D aw_h3_sdhost_read,
>     +=C2=A0 =C2=A0 .write =3D aw_h3_sdhost_write,
>     +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,

I haven't checked .valid accesses from the datasheet.

However due to:

   res =3D s->data_crc[((offset - REG_SD_DATA7_CRC) / sizeof(uint32_t))];

You seem to expect:

            .impl.min_access_size =3D 4,

.impl.max_access_size unset is 8, which should works.

>     +};
>     +
>     +static const VMStateDescription vmstate_aw_h3_sdhost =3D {
>     +=C2=A0 =C2=A0 .name =3D TYPE_AW_H3_SDHOST,

Do not use TYPE name in VMStateDescription.name, because we might change=20
the value of TYPE, but the migration state has to keep the same name.

>     +=C2=A0 =C2=A0 .version_id =3D 1,
>     +=C2=A0 =C2=A0 .minimum_version_id =3D 1,
>     +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(global_ctl, AwH3SDHostSta=
te),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(clock_ctl, AwH3SDHostStat=
e),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(timeout, AwH3SDHostState)=
,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(bus_width, AwH3SDHostStat=
e),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(block_size, AwH3SDHostSta=
te),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(byte_count, AwH3SDHostSta=
te),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(transfer_cnt, AwH3SDHostS=
tate),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(command, AwH3SDHostState)=
,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(command_arg, AwH3SDHostSt=
ate),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(response, AwH3SDHos=
tState, 4),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(irq_mask, AwH3SDHostState=
),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(irq_status, AwH3SDHostSta=
te),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(status, AwH3SDHostState),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(fifo_wlevel, AwH3SDHostSt=
ate),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(fifo_func_sel, AwH3SDHost=
State),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(debug_enable, AwH3SDHostS=
tate),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(auto12_arg, AwH3SDHostSta=
te),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(newtiming_set, AwH3SDHost=
State),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(newtiming_debug, AwH3SDHo=
stState),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(hardware_rst, AwH3SDHostS=
tate),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(dmac, AwH3SDHostState),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(desc_base, AwH3SDHostStat=
e),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(dmac_status, AwH3SDHostSt=
ate),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(dmac_irq, AwH3SDHostState=
),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(card_threshold, AwH3SDHos=
tState),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(startbit_detect, AwH3SDHo=
stState),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(response_crc, AwH3SDHostS=
tate),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(data_crc, AwH3SDHos=
tState, 8),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(status_crc, AwH3SDHostSta=
te),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()
>     +=C2=A0 =C2=A0 }
>     +};
>     +
>     +static void aw_h3_sdhost_init(Object *obj)
>     +{
>     +=C2=A0 =C2=A0 AwH3SDHostState *s =3D AW_H3_SDHOST(obj);
>     +
>     +=C2=A0 =C2=A0 qbus_create_inplace(&s->sdbus, sizeof(s->sdbus),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TYPE_AW_H3_SDHOST_BUS, DEVICE(s), "sd-bus");
>     +
>     +=C2=A0 =C2=A0 memory_region_init_io(&s->iomem, obj, &aw_h3_sdhost_op=
s, s,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_H3_SDHOST,
>     AW_H3_SDHOST_REGS_MEM_SIZE);
>     +=C2=A0 =C2=A0 sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
>     +=C2=A0 =C2=A0 sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
>     +}
>     +
>     +static void aw_h3_sdhost_reset(DeviceState *dev)
>     +{
>     +=C2=A0 =C2=A0 AwH3SDHostState *s =3D AW_H3_SDHOST(dev);
>     +
>     +=C2=A0 =C2=A0 s->global_ctl =3D REG_SD_GCTL_RST;
>     +=C2=A0 =C2=A0 s->clock_ctl =3D REG_SD_CKCR_RST;
>     +=C2=A0 =C2=A0 s->timeout =3D REG_SD_TMOR_RST;
>     +=C2=A0 =C2=A0 s->bus_width =3D REG_SD_BWDR_RST;
>     +=C2=A0 =C2=A0 s->block_size =3D REG_SD_BKSR_RST;
>     +=C2=A0 =C2=A0 s->byte_count =3D REG_SD_BYCR_RST;
>     +=C2=A0 =C2=A0 s->transfer_cnt =3D 0;
>     +
>     +=C2=A0 =C2=A0 s->command =3D REG_SD_CMDR_RST;
>     +=C2=A0 =C2=A0 s->command_arg =3D REG_SD_CAGR_RST;
>     +
>     +=C2=A0 =C2=A0 for (int i =3D 0; i < sizeof(s->response) /
>     sizeof(s->response[0]); i++) {

Please use ARRAY_SIZE(s->response).

>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->response[i] =3D REG_SD_RESP_RST;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 s->irq_mask =3D REG_SD_IMKR_RST;
>     +=C2=A0 =C2=A0 s->irq_status =3D REG_SD_RISR_RST;
>     +=C2=A0 =C2=A0 s->status =3D REG_SD_STAR_RST;
>     +
>     +=C2=A0 =C2=A0 s->fifo_wlevel =3D REG_SD_FWLR_RST;
>     +=C2=A0 =C2=A0 s->fifo_func_sel =3D REG_SD_FUNS_RST;
>     +=C2=A0 =C2=A0 s->debug_enable =3D REG_SD_DBGC_RST;
>     +=C2=A0 =C2=A0 s->auto12_arg =3D REG_SD_A12A_RST;
>     +=C2=A0 =C2=A0 s->newtiming_set =3D REG_SD_NTSR_RST;
>     +=C2=A0 =C2=A0 s->newtiming_debug =3D REG_SD_SDBG_RST;
>     +=C2=A0 =C2=A0 s->hardware_rst =3D REG_SD_HWRST_RST;
>     +=C2=A0 =C2=A0 s->dmac =3D REG_SD_DMAC_RST;
>     +=C2=A0 =C2=A0 s->desc_base =3D REG_SD_DLBA_RST;
>     +=C2=A0 =C2=A0 s->dmac_status =3D REG_SD_IDST_RST;
>     +=C2=A0 =C2=A0 s->dmac_irq =3D REG_SD_IDIE_RST;
>     +=C2=A0 =C2=A0 s->card_threshold =3D REG_SD_THLDC_RST;
>     +=C2=A0 =C2=A0 s->startbit_detect =3D REG_SD_DSBD_RST;
>     +=C2=A0 =C2=A0 s->response_crc =3D REG_SD_RES_CRC_RST;
>     +
>     +=C2=A0 =C2=A0 for (int i =3D 0; i < sizeof(s->data_crc) /
>     sizeof(s->data_crc[0]); i++) {

ARRAY_SIZE

>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->data_crc[i] =3D REG_SD_DATA_CRC_RST;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 s->status_crc =3D REG_SD_CRC_STA_RST;
>     +}
>     +
>     +static void aw_h3_sdhost_bus_class_init(ObjectClass *klass, void *da=
ta)
>     +{
>     +=C2=A0 =C2=A0 SDBusClass *sbc =3D SD_BUS_CLASS(klass);
>     +
>     +=C2=A0 =C2=A0 sbc->set_inserted =3D aw_h3_sdhost_set_inserted;
>     +}
>     +
>     +static void aw_h3_sdhost_class_init(ObjectClass *klass, void *data)
>     +{
>     +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
>     +
>     +=C2=A0 =C2=A0 dc->reset =3D aw_h3_sdhost_reset;
>     +=C2=A0 =C2=A0 dc->vmsd =3D &vmstate_aw_h3_sdhost;
>     +}
>     +
>     +static TypeInfo aw_h3_sdhost_info =3D {
>     +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_H3=
_SDHOST,
>     +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DE=
VICE,
>     +=C2=A0 =C2=A0 .instance_size =3D sizeof(AwH3SDHostState),
>     +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D aw_h3_sdhost_class_init,
>     +=C2=A0 =C2=A0 .instance_init =3D aw_h3_sdhost_init,
>     +};
>     +
>     +static const TypeInfo aw_h3_sdhost_bus_info =3D {
>     +=C2=A0 =C2=A0 .name =3D TYPE_AW_H3_SDHOST_BUS,
>     +=C2=A0 =C2=A0 .parent =3D TYPE_SD_BUS,
>     +=C2=A0 =C2=A0 .instance_size =3D sizeof(SDBus),
>     +=C2=A0 =C2=A0 .class_init =3D aw_h3_sdhost_bus_class_init,
>     +};
>     +
>     +static void aw_h3_sdhost_register_types(void)
>     +{
>     +=C2=A0 =C2=A0 type_register_static(&aw_h3_sdhost_info);
>     +=C2=A0 =C2=A0 type_register_static(&aw_h3_sdhost_bus_info);
>     +}
>     +
>     +type_init(aw_h3_sdhost_register_types)
>     diff --git a/hw/sd/trace-events b/hw/sd/trace-events
>     index efcff666a2..c672a201b5 100644
>     --- a/hw/sd/trace-events
>     +++ b/hw/sd/trace-events
>     @@ -1,5 +1,12 @@
>      =C2=A0# See docs/devel/tracing.txt for syntax documentation.
>=20
>     +# allwinner-h3-sdhost.c
>     +aw_h3_sdhost_set_inserted(bool inserted) "inserted %u"
>     +aw_h3_sdhost_process_desc(uint64_t desc_addr, uint32_t desc_size,
>     bool is_write, uint32_t max_bytes) "desc_addr 0x%" PRIx64 "
>     desc_size %u is_write %u max_bytes %u"

Please also use PRIu32 for desc_size/max_bytes.

>     +aw_h3_sdhost_read(uint64_t offset, uint64_t data, unsigned size)
>     "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>     +aw_h3_sdhost_write(uint64_t offset, uint64_t data, unsigned size)
>     "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>     +aw_h3_sdhost_update_irq(uint32_t irq) "IRQ bits 0x%x"

PRIx32

>     +
>      =C2=A0# bcm2835_sdhost.c
>      =C2=A0bcm2835_sdhost_read(uint64_t offset, uint64_t data, unsigned s=
ize)
>     "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>      =C2=A0bcm2835_sdhost_write(uint64_t offset, uint64_t data, unsigned
>     size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>     diff --git a/include/hw/arm/allwinner-h3.h
>     b/include/hw/arm/allwinner-h3.h
>     index 33602599eb..7aff4ebbd2 100644
>     --- a/include/hw/arm/allwinner-h3.h
>     +++ b/include/hw/arm/allwinner-h3.h
>     @@ -30,6 +30,7 @@
>      =C2=A0#include "hw/misc/allwinner-h3-cpucfg.h"
>      =C2=A0#include "hw/misc/allwinner-h3-syscon.h"
>      =C2=A0#include "hw/misc/allwinner-h3-sid.h"
>     +#include "hw/sd/allwinner-h3-sdhost.h"
>      =C2=A0#include "target/arm/cpu.h"
>=20
>      =C2=A0#define AW_H3_SRAM_A1_BASE=C2=A0 =C2=A0 =C2=A0(0x00000000)
>     @@ -117,6 +118,7 @@ typedef struct AwH3State {
>      =C2=A0 =C2=A0 =C2=A0AwH3CpuCfgState cpucfg;
>      =C2=A0 =C2=A0 =C2=A0AwH3SysconState syscon;
>      =C2=A0 =C2=A0 =C2=A0AwH3SidState sid;
>     +=C2=A0 =C2=A0 AwH3SDHostState mmc0;
>      =C2=A0 =C2=A0 =C2=A0GICState gic;
>      =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a1;
>      =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a2;
>     diff --git a/include/hw/sd/allwinner-h3-sdhost.h
>     b/include/hw/sd/allwinner-h3-sdhost.h
>     new file mode 100644
>     index 0000000000..6c898a3c84
>     --- /dev/null
>     +++ b/include/hw/sd/allwinner-h3-sdhost.h
>     @@ -0,0 +1,73 @@
>     +/*
>     + * Allwinner H3 SD Host Controller emulation
>     + *
>     + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com
>     <mailto:nieklinnenbank@gmail.com>>
>     + *
>     + * This program is free software: you can redistribute it and/or mod=
ify
>     + * it under the terms of the GNU General Public License as published=
 by
>     + * the Free Software Foundation, either version 2 of the License, or
>     + * (at your option) any later version.
>     + *
>     + * This program is distributed in the hope that it will be useful,
>     + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>     + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See th=
e
>     + * GNU General Public License for more details.
>     + *
>     + * You should have received a copy of the GNU General Public License
>     + * along with this program.=C2=A0 If not, see
>     <http://www.gnu.org/licenses/>.
>     + */
>     +
>     +#ifndef ALLWINNER_H3_SDHOST_H
>     +#define ALLWINNER_H3_SDHOST_H
>     +
>     +#include "hw/sysbus.h"
>     +#include "hw/sd/sd.h"
>     +
>     +#define AW_H3_SDHOST_REGS_MEM_SIZE=C2=A0 (1024)

Move this definition to the source file.

>     +
>     +#define TYPE_AW_H3_SDHOST "allwinner-h3-sdhost"
>     +#define AW_H3_SDHOST(obj) \
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 OBJECT_CHECK(AwH3SDHostState, (obj), TYP=
E_AW_H3_SDHOST)
>     +
>     +typedef struct {
>     +=C2=A0 =C2=A0 SysBusDevice busdev;
>     +=C2=A0 =C2=A0 SDBus sdbus;
>     +=C2=A0 =C2=A0 MemoryRegion iomem;
>     +
>     +=C2=A0 =C2=A0 uint32_t global_ctl;
>     +=C2=A0 =C2=A0 uint32_t clock_ctl;
>     +=C2=A0 =C2=A0 uint32_t timeout;
>     +=C2=A0 =C2=A0 uint32_t bus_width;
>     +=C2=A0 =C2=A0 uint32_t block_size;
>     +=C2=A0 =C2=A0 uint32_t byte_count;
>     +=C2=A0 =C2=A0 uint32_t transfer_cnt;
>     +
>     +=C2=A0 =C2=A0 uint32_t command;
>     +=C2=A0 =C2=A0 uint32_t command_arg;
>     +=C2=A0 =C2=A0 uint32_t response[4];
>     +
>     +=C2=A0 =C2=A0 uint32_t irq_mask;
>     +=C2=A0 =C2=A0 uint32_t irq_status;
>     +=C2=A0 =C2=A0 uint32_t status;
>     +
>     +=C2=A0 =C2=A0 uint32_t fifo_wlevel;
>     +=C2=A0 =C2=A0 uint32_t fifo_func_sel;
>     +=C2=A0 =C2=A0 uint32_t debug_enable;
>     +=C2=A0 =C2=A0 uint32_t auto12_arg;
>     +=C2=A0 =C2=A0 uint32_t newtiming_set;
>     +=C2=A0 =C2=A0 uint32_t newtiming_debug;
>     +=C2=A0 =C2=A0 uint32_t hardware_rst;
>     +=C2=A0 =C2=A0 uint32_t dmac;
>     +=C2=A0 =C2=A0 uint32_t desc_base;
>     +=C2=A0 =C2=A0 uint32_t dmac_status;
>     +=C2=A0 =C2=A0 uint32_t dmac_irq;
>     +=C2=A0 =C2=A0 uint32_t card_threshold;
>     +=C2=A0 =C2=A0 uint32_t startbit_detect;
>     +=C2=A0 =C2=A0 uint32_t response_crc;
>     +=C2=A0 =C2=A0 uint32_t data_crc[8];
>     +=C2=A0 =C2=A0 uint32_t status_crc;
>     +
>     +=C2=A0 =C2=A0 qemu_irq irq;
>     +} AwH3SDHostState;
>     +
>     +#endif
>     --=20
>     2.17.1

I haven't checked the datasheet for all the registers/bits.

Patch very clean, chapeau!

Regards,

Phil.


