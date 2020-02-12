Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A59EC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD6821734
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdKlepXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD6821734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j20QO-0006Wu-5p
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 17:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j20Ph-0005zM-Mn
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j20Pf-0004mK-8T
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:23:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53722
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j20Pf-0004ls-4a
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581546198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmONONmIzvyz1sX4qporTHqmAAEnRWbKBVxy8HzX9fE=;
 b=KdKlepXhsnqcpaOsQV98VwygMsy6tGXqvrNQ2E0urpNiDwU+mSQNzZiLX6/rndEPzaX6Lz
 ZqCDLuyqyoB5rpWeI3smDxJu4EaWek8NTa6N9YL13vTxpy/60uIyt3sApUks9pcWPZhcHT
 dXOEzl79L7cdDIT/0FcSlDrfbnhI3h4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-Hpy_kUsONUqEjKVmVyECoA-1; Wed, 12 Feb 2020 17:23:13 -0500
Received: by mail-wm1-f69.google.com with SMTP id y24so1521868wmj.8
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 14:23:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Juo60NxFwNcwOYj8cAHnsnsJENPQ91B29FvAwEZvxNM=;
 b=AyWzd5Y4Vi1ShqIgzBEIPP9CQAD3Ah6zlBrZKICzdaAbtAHOIsVTuJyCEjYB+PC78Q
 eOIkFnH61vZajltEAzTxqaLwoTBRb8ZxtV50YWBSkWs2Ujj9gI3QzL/V43zxzvH5kGMI
 hGrYqzqKoOHAnHVJBYE1HFI+fb9kbNb2FqXrj6o1bRpu8jCVC/eASYXffC0MBiQs9UDk
 XZbUhRxcQH/28S41FxH5P31bITB5PaMThIQY1DiQRkEhlENK65osvvBJK8BJnweP2F5K
 sLbcAnjRQi8JyUf1L7t4uGBXmLB/HqgbjCgnhk5fictjSLyUUBZx/n5mUTdopYtWGQ+M
 RBpg==
X-Gm-Message-State: APjAAAWLaqRvQvkutMSRjPmWqj0bLpOUd6ybNaulvKkScRTVlKw9oWt3
 KPuf9hUT0MkzV3Mmn1Bn49kMGfim5rLrYW0ctVzfgacGqR+UDvXiFAnktZYwQRih7G7+AKQuruq
 4XsJ6NlCAdxgyyos=
X-Received: by 2002:a5d:488c:: with SMTP id g12mr17685934wrq.67.1581546192210; 
 Wed, 12 Feb 2020 14:23:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqzApF5dAiMhcTvIqwO5wuEpkHDonKgOBT+kI6iDHbkDZmkPq1LJa3+OS8gls9BxWXoyP/6lhA==
X-Received: by 2002:a5d:488c:: with SMTP id g12mr17685904wrq.67.1581546191897; 
 Wed, 12 Feb 2020 14:23:11 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a8sm278364wmc.20.2020.02.12.14.23.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 14:23:11 -0800 (PST)
Subject: Re: [PATCH v4 04/20] hw/arm/allwinner-h3: add USB host controller
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-5-nieklinnenbank@gmail.com>
 <39b5cc92-df42-50a4-72ba-10850aa00b04@redhat.com>
 <851e2620-82f8-b911-7641-f1690238cc2a@redhat.com>
 <CAPan3WqamSU7GdTQ5q-Z2KqBpZBTy3CE0p0MUW2zWOe7dKseTA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <61567d70-bb80-045b-0500-01158487f83e@redhat.com>
Date: Wed, 12 Feb 2020 23:23:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPan3WqamSU7GdTQ5q-Z2KqBpZBTy3CE0p0MUW2zWOe7dKseTA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: Hpy_kUsONUqEjKVmVyECoA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jasowang@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 imammedo@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/2/20 8:33 PM, Niek Linnenbank wrote:
> On Sun, Jan 19, 2020 at 7:44 PM Philippe Mathieu-Daud=C3=A9=20
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>     On 1/19/20 7:37 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>      > On 1/19/20 1:50 AM, Niek Linnenbank wrote:
>      >> The Allwinner H3 System on Chip contains multiple USB 2.0 bus
>      >> connections which provide software access using the Enhanced
>      >> Host Controller Interface (EHCI) and Open Host Controller
>      >> Interface (OHCI) interfaces. This commit adds support for
>      >> both interfaces in the Allwinner H3 System on Chip.
>      >>
>      >> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com
>     <mailto:nieklinnenbank@gmail.com>>
>      >> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com
>     <mailto:kraxel@redhat.com>>
>      >> ---
>      >> =C2=A0 hw/usb/hcd-ehci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>      >> =C2=A0 include/hw/arm/allwinner-h3.h |=C2=A0 8 ++++++
>      >> =C2=A0 hw/arm/allwinner-h3.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 52
>     ++++++++++++++++++++++++++++++++---
>      >> =C2=A0 hw/usb/hcd-ehci-sysbus.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1=
7 ++++++++++++
>      >> =C2=A0 4 files changed, 74 insertions(+), 4 deletions(-)
>      >>
>      >> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
>      >> index 0298238f0b..edb59311c4 100644
>      >> --- a/hw/usb/hcd-ehci.h
>      >> +++ b/hw/usb/hcd-ehci.h
>      >> @@ -342,6 +342,7 @@ typedef struct EHCIPCIState {
>      >> =C2=A0 #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
>      >> =C2=A0 #define TYPE_PLATFORM_EHCI "platform-ehci-usb"
>      >> =C2=A0 #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
>      >> +#define TYPE_AW_H3_EHCI "aw-h3-ehci-usb"
>      >> =C2=A0 #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
>      >> =C2=A0 #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
>      >> =C2=A0 #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
>      >> diff --git a/include/hw/arm/allwinner-h3.h
>      >> b/include/hw/arm/allwinner-h3.h
>      >> index abdc20871a..4f4dcbcd17 100644
>      >> --- a/include/hw/arm/allwinner-h3.h
>      >> +++ b/include/hw/arm/allwinner-h3.h
>      >> @@ -56,6 +56,14 @@ enum {
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_SRAM_A1,
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_SRAM_A2,
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_SRAM_C,
>      >> +=C2=A0=C2=A0=C2=A0 AW_H3_EHCI0,
>      >> +=C2=A0=C2=A0=C2=A0 AW_H3_OHCI0,
>      >> +=C2=A0=C2=A0=C2=A0 AW_H3_EHCI1,
>      >> +=C2=A0=C2=A0=C2=A0 AW_H3_OHCI1,
>      >> +=C2=A0=C2=A0=C2=A0 AW_H3_EHCI2,
>      >> +=C2=A0=C2=A0=C2=A0 AW_H3_OHCI2,
>      >> +=C2=A0=C2=A0=C2=A0 AW_H3_EHCI3,
>      >> +=C2=A0=C2=A0=C2=A0 AW_H3_OHCI3,
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_CCU,
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_PIT,
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AW_H3_UART0,
>      >> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
>      >> index 8df8e3e05e..f360625ee9 100644
>      >> --- a/hw/arm/allwinner-h3.c
>      >> +++ b/hw/arm/allwinner-h3.c
>      >> @@ -28,6 +28,7 @@
>      >> =C2=A0 #include "hw/sysbus.h"
>      >> =C2=A0 #include "hw/char/serial.h"
>      >> =C2=A0 #include "hw/misc/unimp.h"
>      >> +#include "hw/usb/hcd-ehci.h"
>      >> =C2=A0 #include "sysemu/sysemu.h"
>      >> =C2=A0 #include "hw/arm/allwinner-h3.h"
>      >> @@ -36,6 +37,14 @@ const hwaddr allwinner_h3_memmap[] =3D {
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [AW_H3_SRAM_A1]=C2=A0=C2=A0=C2=A0 =
=3D 0x00000000,
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [AW_H3_SRAM_A2]=C2=A0=C2=A0=C2=A0 =
=3D 0x00044000,
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [AW_H3_SRAM_C]=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 0x00010000,
>      >> +=C2=A0=C2=A0=C2=A0 [AW_H3_EHCI0]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x01c1a000,
>      >> +=C2=A0=C2=A0=C2=A0 [AW_H3_OHCI0]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x01c1a400,
>      >> +=C2=A0=C2=A0=C2=A0 [AW_H3_EHCI1]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x01c1b000,
>      >> +=C2=A0=C2=A0=C2=A0 [AW_H3_OHCI1]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x01c1b400,
>      >> +=C2=A0=C2=A0=C2=A0 [AW_H3_EHCI2]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x01c1c000,
>      >> +=C2=A0=C2=A0=C2=A0 [AW_H3_OHCI2]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x01c1c400,
>      >> +=C2=A0=C2=A0=C2=A0 [AW_H3_EHCI3]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x01c1d000,
>      >> +=C2=A0=C2=A0=C2=A0 [AW_H3_OHCI3]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x01c1d400,
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [AW_H3_CCU]=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D 0x01c20000,
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [AW_H3_PIT]=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D 0x01c20c00,
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [AW_H3_UART0]=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D 0x01c28000,
>      >> @@ -73,10 +82,10 @@ struct AwH3Unimplemented {
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "msgbox",=C2=A0=C2=A0=C2=A0 0x01=
c17000, 4 * KiB },
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "spinlock",=C2=A0 0x01c18000, 4 =
* KiB },
>      >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "usb0-otg",=C2=A0 0x01c19000, 4 =
* KiB },
>      >> -=C2=A0=C2=A0=C2=A0 { "usb0",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x01c=
1a000, 4 * KiB },
>      >> -=C2=A0=C2=A0=C2=A0 { "usb1",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x01c=
1b000, 4 * KiB },
>      >> -=C2=A0=C2=A0=C2=A0 { "usb2",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x01c=
1c000, 4 * KiB },
>      >> -=C2=A0=C2=A0=C2=A0 { "usb3",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x01c=
1d000, 4 * KiB },
>      >> +=C2=A0=C2=A0=C2=A0 { "usb0-phy",=C2=A0 0x01c1a000, 4 * KiB },
>      >> +=C2=A0=C2=A0=C2=A0 { "usb1-phy",=C2=A0 0x01c1b000, 4 * KiB },
>      >> +=C2=A0=C2=A0=C2=A0 { "usb2-phy",=C2=A0 0x01c1c000, 4 * KiB },
>      >> +=C2=A0=C2=A0=C2=A0 { "usb3-phy",=C2=A0 0x01c1d000, 4 * KiB },
>      >
>      > As in v3 comment, this can be done in patch #1.
>      >
>      > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>      > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>=20
>     Err, this patch is incomplete, when using ./configure
>     --without-default-devices:
>=20
>     $ qemu-system-arm -M orangepi-pc
>     qemu-system-arm: invalid accelerator kvm
>     qemu-system-arm: falling back to tcg
>     qemu-system-arm: Unknown device 'aw-h3-ehci-usb' for default sysbus
>     qemu-system-arm: Unknown device 'sysbus-ohci' for default sysbus
>     Aborted (core dumped)
>=20
>=20
> Thanks for pointing this out, I was not aware at all that the=20
> --without-default-devices option existed.
> It's not in the configure --help message also.

Indeed. This is https://bugs.launchpad.net/qemu/+bug/1836537

> I tried to re-produce the error by running:
> $ ./configure --target-list=3Darm-softmmu --without-default-devices; make=
 -j5
> $ ./arm-softmmu/qemu-system-arm -M orangepi-pc
>=20
> On my laptop it didn't give the error, I think because somehow the build=
=20
> system did select
> the USB config items (even tho they were missing for the ALLWINNER_H3=20
> item in hw/arm/Kconfig):
>=20
> $ grep USB arm-softmmu/config-devices.mak
> CONFIG_TUSB6010=3Dy
> CONFIG_USB=3Dy
> CONFIG_USB_EHCI=3Dy
> CONFIG_USB_EHCI_SYSBUS=3Dy
> CONFIG_USB_MUSB=3Dy
> CONFIG_USB_OHCI=3Dy
>=20
> Is there any other option you used in addition to=20
> --without-default-devices to trigger the error?

Uff this was 1 month ago... I might have done:

  $ echo CONFIG_ALLWINNER_H3=3Dy > arm-softmmu/config-devices.mak
  $ make arm-softmmu/all

> I also searched for something in configure to select/filter on machines=
=20
> to build, but I don't see that yet.
>=20
> Nevertheless I will surely add the fix below to the patch.
>=20
> Regards,
> Niek
>=20
>=20
>=20
>     You need to amend:
>=20
>     -- >8 --
>     diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>     index bb75c1de17..57b29cc522 100644
>     --- a/hw/arm/Kconfig
>     +++ b/hw/arm/Kconfig
>     @@ -302,6 +302,8 @@ config ALLWINNER_H3
>      =C2=A0 =C2=A0 =C2=A0 select ARM_TIMER
>      =C2=A0 =C2=A0 =C2=A0 select ARM_GIC
>      =C2=A0 =C2=A0 =C2=A0 select UNIMP
>     +=C2=A0 =C2=A0 select USB_OHCI
>     +=C2=A0 =C2=A0 select USB_EHCI_SYSBUS
>=20
>      =C2=A0 config RASPI
>      =C2=A0 =C2=A0 =C2=A0 bool
>     ---
>=20
>     R/T-b tags can stay with this amended.


