Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB823C33CAF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 18:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0E7206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 18:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBf0d4bG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0E7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itFZb-0000W4-RG
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 13:45:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itFYn-0008Ss-Ac
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 13:44:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itFYl-00083A-C2
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 13:44:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32522
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itFYl-00081z-7V
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 13:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579459470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P1Do3fehiU5YLb3JcweKxgKgiUuvDvmxETHnDMh9EaI=;
 b=OBf0d4bGHApdM9Tb4clifSrIHDuSXigijreU6WZX7OKlmrPvpzZs67JrPBFy+UrO5PGGtn
 nY1FACgU+K74StEnqrXAIhs7fOm4xrdfHfBpTGOlncW3zflWuEvwhVDAoro6zYWO+CyJuZ
 zTUYY0kudf+Ui94nD1A6cUxT9miHvJc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-1EthxtZ3Pmq5mIxGYpP93Q-1; Sun, 19 Jan 2020 13:44:29 -0500
Received: by mail-wr1-f72.google.com with SMTP id u18so12982881wrn.11
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2020 10:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qtuBjOvsDm0iD4q3HPN9A6dD6GUaj932MEe1Kfvvi0g=;
 b=jt51iUWbRGoIlOs4tPjWkpdcB1wU3EdMMzPIxcAGzWgGuP+HCrcN2sjTaHI36KDToS
 SROn3jTVAE/6xxWAsmnR0NaFBv50nWQOHavPhSzM6r2bss+3L9m8dDU4rpCY4v0yha3T
 dAC71mKXoGkSeeLR1u3zRIIe6nv+f2nJWFeP3lVf+IY3I9HdqQUEE+Q1Z1R/CScRABJy
 +Jh1QlMd5a0xK5SL9oMBl0KmM86UeiZw9EqlAgC26bQXqgKlR6BeoREk6lK36trkg+0n
 MCcUgJyNU9QYogyb1Zjs0CnArRYEYIYqZoz47Q9eoW0FWJILv4jt4nrCqDiySkz1EG39
 a+Qw==
X-Gm-Message-State: APjAAAVbHloipxUKtucczvOdunAXKZF/6F8AvFCT9puwLiNJNEICyVgD
 YCQKgcXQIq5AXXs9yEVeRflagAzjnnD8//iZWbJZJYtZEkEr+6rUybuf8ooopDXFIfHmMFFWdAL
 /2sRoBxTFPSUwEHM=
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr15621656wma.32.1579459468160; 
 Sun, 19 Jan 2020 10:44:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIG8IA7JB7kKIb5fLr27Ga6DPW6MA+HTYVTkZSyBf6MHEgkzQHgdwncpr/2Q7xXuH7RzwP7A==
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr15621642wma.32.1579459467896; 
 Sun, 19 Jan 2020 10:44:27 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id t125sm20251103wmf.17.2020.01.19.10.44.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jan 2020 10:44:27 -0800 (PST)
Subject: Re: [PATCH v4 04/20] hw/arm/allwinner-h3: add USB host controller
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-5-nieklinnenbank@gmail.com>
 <39b5cc92-df42-50a4-72ba-10850aa00b04@redhat.com>
Message-ID: <851e2620-82f8-b911-7641-f1690238cc2a@redhat.com>
Date: Sun, 19 Jan 2020 19:44:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <39b5cc92-df42-50a4-72ba-10850aa00b04@redhat.com>
Content-Language: en-US
X-MC-Unique: 1EthxtZ3Pmq5mIxGYpP93Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, b.galvani@gmail.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/19/20 7:37 PM, Philippe Mathieu-Daud=E9 wrote:
> On 1/19/20 1:50 AM, Niek Linnenbank wrote:
>> The Allwinner H3 System on Chip contains multiple USB 2.0 bus
>> connections which provide software access using the Enhanced
>> Host Controller Interface (EHCI) and Open Host Controller
>> Interface (OHCI) interfaces. This commit adds support for
>> both interfaces in the Allwinner H3 System on Chip.
>>
>> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>> =A0 hw/usb/hcd-ehci.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
>> =A0 include/hw/arm/allwinner-h3.h |=A0 8 ++++++
>> =A0 hw/arm/allwinner-h3.c=A0=A0=A0=A0=A0=A0=A0=A0 | 52 +++++++++++++++++=
+++++++++++++++---
>> =A0 hw/usb/hcd-ehci-sysbus.c=A0=A0=A0=A0=A0 | 17 ++++++++++++
>> =A0 4 files changed, 74 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
>> index 0298238f0b..edb59311c4 100644
>> --- a/hw/usb/hcd-ehci.h
>> +++ b/hw/usb/hcd-ehci.h
>> @@ -342,6 +342,7 @@ typedef struct EHCIPCIState {
>> =A0 #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
>> =A0 #define TYPE_PLATFORM_EHCI "platform-ehci-usb"
>> =A0 #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
>> +#define TYPE_AW_H3_EHCI "aw-h3-ehci-usb"
>> =A0 #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
>> =A0 #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
>> =A0 #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
>> diff --git a/include/hw/arm/allwinner-h3.h=20
>> b/include/hw/arm/allwinner-h3.h
>> index abdc20871a..4f4dcbcd17 100644
>> --- a/include/hw/arm/allwinner-h3.h
>> +++ b/include/hw/arm/allwinner-h3.h
>> @@ -56,6 +56,14 @@ enum {
>> =A0=A0=A0=A0=A0 AW_H3_SRAM_A1,
>> =A0=A0=A0=A0=A0 AW_H3_SRAM_A2,
>> =A0=A0=A0=A0=A0 AW_H3_SRAM_C,
>> +=A0=A0=A0 AW_H3_EHCI0,
>> +=A0=A0=A0 AW_H3_OHCI0,
>> +=A0=A0=A0 AW_H3_EHCI1,
>> +=A0=A0=A0 AW_H3_OHCI1,
>> +=A0=A0=A0 AW_H3_EHCI2,
>> +=A0=A0=A0 AW_H3_OHCI2,
>> +=A0=A0=A0 AW_H3_EHCI3,
>> +=A0=A0=A0 AW_H3_OHCI3,
>> =A0=A0=A0=A0=A0 AW_H3_CCU,
>> =A0=A0=A0=A0=A0 AW_H3_PIT,
>> =A0=A0=A0=A0=A0 AW_H3_UART0,
>> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
>> index 8df8e3e05e..f360625ee9 100644
>> --- a/hw/arm/allwinner-h3.c
>> +++ b/hw/arm/allwinner-h3.c
>> @@ -28,6 +28,7 @@
>> =A0 #include "hw/sysbus.h"
>> =A0 #include "hw/char/serial.h"
>> =A0 #include "hw/misc/unimp.h"
>> +#include "hw/usb/hcd-ehci.h"
>> =A0 #include "sysemu/sysemu.h"
>> =A0 #include "hw/arm/allwinner-h3.h"
>> @@ -36,6 +37,14 @@ const hwaddr allwinner_h3_memmap[] =3D {
>> =A0=A0=A0=A0=A0 [AW_H3_SRAM_A1]=A0=A0=A0 =3D 0x00000000,
>> =A0=A0=A0=A0=A0 [AW_H3_SRAM_A2]=A0=A0=A0 =3D 0x00044000,
>> =A0=A0=A0=A0=A0 [AW_H3_SRAM_C]=A0=A0=A0=A0 =3D 0x00010000,
>> +=A0=A0=A0 [AW_H3_EHCI0]=A0=A0=A0=A0=A0 =3D 0x01c1a000,
>> +=A0=A0=A0 [AW_H3_OHCI0]=A0=A0=A0=A0=A0 =3D 0x01c1a400,
>> +=A0=A0=A0 [AW_H3_EHCI1]=A0=A0=A0=A0=A0 =3D 0x01c1b000,
>> +=A0=A0=A0 [AW_H3_OHCI1]=A0=A0=A0=A0=A0 =3D 0x01c1b400,
>> +=A0=A0=A0 [AW_H3_EHCI2]=A0=A0=A0=A0=A0 =3D 0x01c1c000,
>> +=A0=A0=A0 [AW_H3_OHCI2]=A0=A0=A0=A0=A0 =3D 0x01c1c400,
>> +=A0=A0=A0 [AW_H3_EHCI3]=A0=A0=A0=A0=A0 =3D 0x01c1d000,
>> +=A0=A0=A0 [AW_H3_OHCI3]=A0=A0=A0=A0=A0 =3D 0x01c1d400,
>> =A0=A0=A0=A0=A0 [AW_H3_CCU]=A0=A0=A0=A0=A0=A0=A0 =3D 0x01c20000,
>> =A0=A0=A0=A0=A0 [AW_H3_PIT]=A0=A0=A0=A0=A0=A0=A0 =3D 0x01c20c00,
>> =A0=A0=A0=A0=A0 [AW_H3_UART0]=A0=A0=A0=A0=A0 =3D 0x01c28000,
>> @@ -73,10 +82,10 @@ struct AwH3Unimplemented {
>> =A0=A0=A0=A0=A0 { "msgbox",=A0=A0=A0 0x01c17000, 4 * KiB },
>> =A0=A0=A0=A0=A0 { "spinlock",=A0 0x01c18000, 4 * KiB },
>> =A0=A0=A0=A0=A0 { "usb0-otg",=A0 0x01c19000, 4 * KiB },
>> -=A0=A0=A0 { "usb0",=A0=A0=A0=A0=A0 0x01c1a000, 4 * KiB },
>> -=A0=A0=A0 { "usb1",=A0=A0=A0=A0=A0 0x01c1b000, 4 * KiB },
>> -=A0=A0=A0 { "usb2",=A0=A0=A0=A0=A0 0x01c1c000, 4 * KiB },
>> -=A0=A0=A0 { "usb3",=A0=A0=A0=A0=A0 0x01c1d000, 4 * KiB },
>> +=A0=A0=A0 { "usb0-phy",=A0 0x01c1a000, 4 * KiB },
>> +=A0=A0=A0 { "usb1-phy",=A0 0x01c1b000, 4 * KiB },
>> +=A0=A0=A0 { "usb2-phy",=A0 0x01c1c000, 4 * KiB },
>> +=A0=A0=A0 { "usb3-phy",=A0 0x01c1d000, 4 * KiB },
>=20
> As in v3 comment, this can be done in patch #1.
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Err, this patch is incomplete, when using ./configure=20
--without-default-devices:

$ qemu-system-arm -M orangepi-pc
qemu-system-arm: invalid accelerator kvm
qemu-system-arm: falling back to tcg
qemu-system-arm: Unknown device 'aw-h3-ehci-usb' for default sysbus
qemu-system-arm: Unknown device 'sysbus-ohci' for default sysbus
Aborted (core dumped)

You need to amend:

-- >8 --
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index bb75c1de17..57b29cc522 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -302,6 +302,8 @@ config ALLWINNER_H3
      select ARM_TIMER
      select ARM_GIC
      select UNIMP
+    select USB_OHCI
+    select USB_EHCI_SYSBUS

  config RASPI
      bool
---

R/T-b tags can stay with this amended.

>> =A0=A0=A0=A0=A0 { "smc",=A0=A0=A0=A0=A0=A0 0x01c1e000, 4 * KiB },
>> =A0=A0=A0=A0=A0 { "pio",=A0=A0=A0=A0=A0=A0 0x01c20800, 1 * KiB },
>> =A0=A0=A0=A0=A0 { "owa",=A0=A0=A0=A0=A0=A0 0x01c21000, 1 * KiB },
>> @@ -144,6 +153,14 @@ enum {
>> =A0=A0=A0=A0=A0 AW_H3_GIC_SPI_UART3=A0=A0=A0=A0 =3D=A0 3,
>> =A0=A0=A0=A0=A0 AW_H3_GIC_SPI_TIMER0=A0=A0=A0 =3D 18,
>> =A0=A0=A0=A0=A0 AW_H3_GIC_SPI_TIMER1=A0=A0=A0 =3D 19,
>> +=A0=A0=A0 AW_H3_GIC_SPI_EHCI0=A0=A0=A0=A0 =3D 72,
>> +=A0=A0=A0 AW_H3_GIC_SPI_OHCI0=A0=A0=A0=A0 =3D 73,
>> +=A0=A0=A0 AW_H3_GIC_SPI_EHCI1=A0=A0=A0=A0 =3D 74,
>> +=A0=A0=A0 AW_H3_GIC_SPI_OHCI1=A0=A0=A0=A0 =3D 75,
>> +=A0=A0=A0 AW_H3_GIC_SPI_EHCI2=A0=A0=A0=A0 =3D 76,
>> +=A0=A0=A0 AW_H3_GIC_SPI_OHCI2=A0=A0=A0=A0 =3D 77,
>> +=A0=A0=A0 AW_H3_GIC_SPI_EHCI3=A0=A0=A0=A0 =3D 78,
>> +=A0=A0=A0 AW_H3_GIC_SPI_OHCI3=A0=A0=A0=A0 =3D 79,
>> =A0 };
>> =A0 /* Allwinner H3 general constants */
>> @@ -284,6 +301,33 @@ static void allwinner_h3_realize(DeviceState=20
>> *dev, Error **errp)
>> =A0=A0=A0=A0=A0 qdev_init_nofail(DEVICE(&s->ccu));
>> =A0=A0=A0=A0=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW=
_H3_CCU]);
>> +=A0=A0=A0 /* Universal Serial Bus */
>> +=A0=A0=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 qdev_get_gpio_in(DEVICE(&s->gic),
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AW_H3_GIC_SPI_EHCI0)=
);
>> +=A0=A0=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI1],
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 qdev_get_gpio_in(DEVICE(&s->gic),
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AW_H3_GIC_SPI_EHCI1)=
);
>> +=A0=A0=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI2],
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 qdev_get_gpio_in(DEVICE(&s->gic),
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AW_H3_GIC_SPI_EHCI2)=
);
>> +=A0=A0=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI3],
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 qdev_get_gpio_in(DEVICE(&s->gic),
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AW_H3_GIC_SPI_EHCI3)=
);
>> +
>> +=A0=A0=A0 sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI0],
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 qdev_get_gpio_in(DEVICE(&s->gic),
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AW_H3_GIC_SPI_OHCI0)=
);
>> +=A0=A0=A0 sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI1],
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 qdev_get_gpio_in(DEVICE(&s->gic),
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AW_H3_GIC_SPI_OHCI1)=
);
>> +=A0=A0=A0 sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI2],
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 qdev_get_gpio_in(DEVICE(&s->gic),
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AW_H3_GIC_SPI_OHCI2)=
);
>> +=A0=A0=A0 sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI3],
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 qdev_get_gpio_in(DEVICE(&s->gic),
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AW_H3_GIC_SPI_OHCI3)=
);
>> +
>> =A0=A0=A0=A0=A0 /* UART0. For future clocktree API: All UARTS are connec=
ted to=20
>> APB2_CLK. */
>> =A0=A0=A0=A0=A0 serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART=
0], 2,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qdev_get_gp=
io_in(DEVICE(&s->gic),=20
>> AW_H3_GIC_SPI_UART0),
>> diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
>> index 020211fd10..174c3446ef 100644
>> --- a/hw/usb/hcd-ehci-sysbus.c
>> +++ b/hw/usb/hcd-ehci-sysbus.c
>> @@ -145,6 +145,22 @@ static const TypeInfo ehci_exynos4210_type_info =3D=
 {
>> =A0=A0=A0=A0=A0 .class_init=A0=A0=A0 =3D ehci_exynos4210_class_init,
>> =A0 };
>> +static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)
>> +{
>> +=A0=A0=A0 SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);
>> +=A0=A0=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);
>> +
>> +=A0=A0=A0 sec->capsbase =3D 0x0;
>> +=A0=A0=A0 sec->opregbase =3D 0x10;
>> +=A0=A0=A0 set_bit(DEVICE_CATEGORY_USB, dc->categories);
>> +}
>> +
>> +static const TypeInfo ehci_aw_h3_type_info =3D {
>> +=A0=A0=A0 .name=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D TYPE_AW_H3_EHCI,
>> +=A0=A0=A0 .parent=A0=A0=A0=A0=A0=A0=A0 =3D TYPE_SYS_BUS_EHCI,
>> +=A0=A0=A0 .class_init=A0=A0=A0 =3D ehci_aw_h3_class_init,
>> +};
>> +
>> =A0 static void ehci_tegra2_class_init(ObjectClass *oc, void *data)
>> =A0 {
>> =A0=A0=A0=A0=A0 SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);
>> @@ -267,6 +283,7 @@ static void ehci_sysbus_register_types(void)
>> =A0=A0=A0=A0=A0 type_register_static(&ehci_platform_type_info);
>> =A0=A0=A0=A0=A0 type_register_static(&ehci_xlnx_type_info);
>> =A0=A0=A0=A0=A0 type_register_static(&ehci_exynos4210_type_info);
>> +=A0=A0=A0 type_register_static(&ehci_aw_h3_type_info);
>> =A0=A0=A0=A0=A0 type_register_static(&ehci_tegra2_type_info);
>> =A0=A0=A0=A0=A0 type_register_static(&ehci_ppc4xx_type_info);
>> =A0=A0=A0=A0=A0 type_register_static(&ehci_fusbh200_type_info);
>>


