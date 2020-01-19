Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2853CC33CAF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 18:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB17E20684
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 18:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJvJ7vC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB17E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itFSd-0006NL-10
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 13:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itFRo-0005eb-8c
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 13:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itFRm-0003L7-QS
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 13:37:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36726
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itFRm-0003K2-NV
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 13:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579459038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i9BA6WfuNXBnAmfDFj6OaOwiRAD9bLAoawJ1Gl2h1X0=;
 b=FJvJ7vC+ZIHe1mwrHdNJpfWmHahc1L7EdZcwTF1d3b62KFg8wqPsQBDMYc9iVld1FTB4wE
 OVPRxlrJmrdm3oZkDOx9OWDgmGBnV7NjTZ3AII54+NmCVYnr/BfQWbOQyPR1wn5Va355nM
 A6sp+2GrGP9VLaiWoiKm6SGmwpOSybk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-dLcdeWi4OAiduNwPg0vIwA-1; Sun, 19 Jan 2020 13:37:14 -0500
Received: by mail-wr1-f69.google.com with SMTP id v17so12976984wrm.17
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2020 10:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vyYCYGhWY+uHqUwx5Yr6FOLUl6dwICFChgYumkulRhM=;
 b=Yyu5Idec6sbPFherHE1RpB0AQHtkgT1BrAfZZQEEya8iqLOuQfOABHenFtbUbyrUaE
 lUXQKnJrsHa22gEWEwG7D+tv0XWp401CPg382/pbZvMNzIEDl4cduxVmXNbr17aYrSKx
 HZe8xhHGY5E/iekxPFpVc+agDmsTDEo1RSnQOftKNso0EnHfl2awylqUWQIXljZJ5EoR
 Amff9BN2lhRehYk5ruBYVSucdyaacQIzcus5aAQF86MQn5FB1zWNxBhySoVj0BLA+9dG
 1gm7vu/Du5KLK6EtGBQU81+04UshfPhFWJnqtZr4UHOWhUaoCHS0WT/433MmjpCVWrJJ
 AMlg==
X-Gm-Message-State: APjAAAVsO6kjr/fmQz3IdHLyFcJhcxmxvqmAGLiembFueRZ5XLlgVXMQ
 Mgw+EjT/cIAlY/qVIkCpIdBkLmQ0sp/y1rG6j4KRUSweDCL5AP3EvFD/QEk1cyHV1j+twJ4Se7l
 5sKXgLPLP/yHBywc=
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr14839142wre.390.1579459033513; 
 Sun, 19 Jan 2020 10:37:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqx2f5gFsNXj9rRXirvYdftDh4OioF3ynSTgL+GHtVY67CZHbLffnM1RRxMBwAyvwcoXr/11yw==
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr14839132wre.390.1579459033254; 
 Sun, 19 Jan 2020 10:37:13 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id x18sm44638962wrr.75.2020.01.19.10.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jan 2020 10:37:12 -0800 (PST)
Subject: Re: [PATCH v4 04/20] hw/arm/allwinner-h3: add USB host controller
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-5-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <39b5cc92-df42-50a4-72ba-10850aa00b04@redhat.com>
Date: Sun, 19 Jan 2020 19:37:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200119005102.3847-5-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: dLcdeWi4OAiduNwPg0vIwA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, b.galvani@gmail.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/19/20 1:50 AM, Niek Linnenbank wrote:
> The Allwinner H3 System on Chip contains multiple USB 2.0 bus
> connections which provide software access using the Enhanced
> Host Controller Interface (EHCI) and Open Host Controller
> Interface (OHCI) interfaces. This commit adds support for
> both interfaces in the Allwinner H3 System on Chip.
>=20
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/usb/hcd-ehci.h             |  1 +
>   include/hw/arm/allwinner-h3.h |  8 ++++++
>   hw/arm/allwinner-h3.c         | 52 ++++++++++++++++++++++++++++++++---
>   hw/usb/hcd-ehci-sysbus.c      | 17 ++++++++++++
>   4 files changed, 74 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index 0298238f0b..edb59311c4 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -342,6 +342,7 @@ typedef struct EHCIPCIState {
>   #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
>   #define TYPE_PLATFORM_EHCI "platform-ehci-usb"
>   #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
> +#define TYPE_AW_H3_EHCI "aw-h3-ehci-usb"
>   #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
>   #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
>   #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.=
h
> index abdc20871a..4f4dcbcd17 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -56,6 +56,14 @@ enum {
>       AW_H3_SRAM_A1,
>       AW_H3_SRAM_A2,
>       AW_H3_SRAM_C,
> +    AW_H3_EHCI0,
> +    AW_H3_OHCI0,
> +    AW_H3_EHCI1,
> +    AW_H3_OHCI1,
> +    AW_H3_EHCI2,
> +    AW_H3_OHCI2,
> +    AW_H3_EHCI3,
> +    AW_H3_OHCI3,
>       AW_H3_CCU,
>       AW_H3_PIT,
>       AW_H3_UART0,
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index 8df8e3e05e..f360625ee9 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -28,6 +28,7 @@
>   #include "hw/sysbus.h"
>   #include "hw/char/serial.h"
>   #include "hw/misc/unimp.h"
> +#include "hw/usb/hcd-ehci.h"
>   #include "sysemu/sysemu.h"
>   #include "hw/arm/allwinner-h3.h"
>  =20
> @@ -36,6 +37,14 @@ const hwaddr allwinner_h3_memmap[] =3D {
>       [AW_H3_SRAM_A1]    =3D 0x00000000,
>       [AW_H3_SRAM_A2]    =3D 0x00044000,
>       [AW_H3_SRAM_C]     =3D 0x00010000,
> +    [AW_H3_EHCI0]      =3D 0x01c1a000,
> +    [AW_H3_OHCI0]      =3D 0x01c1a400,
> +    [AW_H3_EHCI1]      =3D 0x01c1b000,
> +    [AW_H3_OHCI1]      =3D 0x01c1b400,
> +    [AW_H3_EHCI2]      =3D 0x01c1c000,
> +    [AW_H3_OHCI2]      =3D 0x01c1c400,
> +    [AW_H3_EHCI3]      =3D 0x01c1d000,
> +    [AW_H3_OHCI3]      =3D 0x01c1d400,
>       [AW_H3_CCU]        =3D 0x01c20000,
>       [AW_H3_PIT]        =3D 0x01c20c00,
>       [AW_H3_UART0]      =3D 0x01c28000,
> @@ -73,10 +82,10 @@ struct AwH3Unimplemented {
>       { "msgbox",    0x01c17000, 4 * KiB },
>       { "spinlock",  0x01c18000, 4 * KiB },
>       { "usb0-otg",  0x01c19000, 4 * KiB },
> -    { "usb0",      0x01c1a000, 4 * KiB },
> -    { "usb1",      0x01c1b000, 4 * KiB },
> -    { "usb2",      0x01c1c000, 4 * KiB },
> -    { "usb3",      0x01c1d000, 4 * KiB },
> +    { "usb0-phy",  0x01c1a000, 4 * KiB },
> +    { "usb1-phy",  0x01c1b000, 4 * KiB },
> +    { "usb2-phy",  0x01c1c000, 4 * KiB },
> +    { "usb3-phy",  0x01c1d000, 4 * KiB },

As in v3 comment, this can be done in patch #1.

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>       { "smc",       0x01c1e000, 4 * KiB },
>       { "pio",       0x01c20800, 1 * KiB },
>       { "owa",       0x01c21000, 1 * KiB },
> @@ -144,6 +153,14 @@ enum {
>       AW_H3_GIC_SPI_UART3     =3D  3,
>       AW_H3_GIC_SPI_TIMER0    =3D 18,
>       AW_H3_GIC_SPI_TIMER1    =3D 19,
> +    AW_H3_GIC_SPI_EHCI0     =3D 72,
> +    AW_H3_GIC_SPI_OHCI0     =3D 73,
> +    AW_H3_GIC_SPI_EHCI1     =3D 74,
> +    AW_H3_GIC_SPI_OHCI1     =3D 75,
> +    AW_H3_GIC_SPI_EHCI2     =3D 76,
> +    AW_H3_GIC_SPI_OHCI2     =3D 77,
> +    AW_H3_GIC_SPI_EHCI3     =3D 78,
> +    AW_H3_GIC_SPI_OHCI3     =3D 79,
>   };
>  =20
>   /* Allwinner H3 general constants */
> @@ -284,6 +301,33 @@ static void allwinner_h3_realize(DeviceState *dev, E=
rror **errp)
>       qdev_init_nofail(DEVICE(&s->ccu));
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_CCU]);
>  =20
> +    /* Universal Serial Bus */
> +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
> +                         qdev_get_gpio_in(DEVICE(&s->gic),
> +                                          AW_H3_GIC_SPI_EHCI0));
> +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI1],
> +                         qdev_get_gpio_in(DEVICE(&s->gic),
> +                                          AW_H3_GIC_SPI_EHCI1));
> +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI2],
> +                         qdev_get_gpio_in(DEVICE(&s->gic),
> +                                          AW_H3_GIC_SPI_EHCI2));
> +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI3],
> +                         qdev_get_gpio_in(DEVICE(&s->gic),
> +                                          AW_H3_GIC_SPI_EHCI3));
> +
> +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI0],
> +                         qdev_get_gpio_in(DEVICE(&s->gic),
> +                                          AW_H3_GIC_SPI_OHCI0));
> +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI1],
> +                         qdev_get_gpio_in(DEVICE(&s->gic),
> +                                          AW_H3_GIC_SPI_OHCI1));
> +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI2],
> +                         qdev_get_gpio_in(DEVICE(&s->gic),
> +                                          AW_H3_GIC_SPI_OHCI2));
> +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI3],
> +                         qdev_get_gpio_in(DEVICE(&s->gic),
> +                                          AW_H3_GIC_SPI_OHCI3));
> +
>       /* UART0. For future clocktree API: All UARTS are connected to APB2=
_CLK. */
>       serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART0], 2,
>                      qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART=
0),
> diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
> index 020211fd10..174c3446ef 100644
> --- a/hw/usb/hcd-ehci-sysbus.c
> +++ b/hw/usb/hcd-ehci-sysbus.c
> @@ -145,6 +145,22 @@ static const TypeInfo ehci_exynos4210_type_info =3D =
{
>       .class_init    =3D ehci_exynos4210_class_init,
>   };
>  =20
> +static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)
> +{
> +    SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +
> +    sec->capsbase =3D 0x0;
> +    sec->opregbase =3D 0x10;
> +    set_bit(DEVICE_CATEGORY_USB, dc->categories);
> +}
> +
> +static const TypeInfo ehci_aw_h3_type_info =3D {
> +    .name          =3D TYPE_AW_H3_EHCI,
> +    .parent        =3D TYPE_SYS_BUS_EHCI,
> +    .class_init    =3D ehci_aw_h3_class_init,
> +};
> +
>   static void ehci_tegra2_class_init(ObjectClass *oc, void *data)
>   {
>       SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);
> @@ -267,6 +283,7 @@ static void ehci_sysbus_register_types(void)
>       type_register_static(&ehci_platform_type_info);
>       type_register_static(&ehci_xlnx_type_info);
>       type_register_static(&ehci_exynos4210_type_info);
> +    type_register_static(&ehci_aw_h3_type_info);
>       type_register_static(&ehci_tegra2_type_info);
>       type_register_static(&ehci_ppc4xx_type_info);
>       type_register_static(&ehci_fusbh200_type_info);
>=20


