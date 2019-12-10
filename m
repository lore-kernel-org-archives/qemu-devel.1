Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A04FC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4588E20663
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByJixM8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4588E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieaO9-0005Ty-GL
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 02:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieaNO-0004w6-MY
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:56:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieaNN-0008H2-5x
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:56:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38487
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieaNN-0008Gs-30
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575964568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLmwHHyHcbG03UjZlQhw3ftszHY2lolMAFMILWOXSaI=;
 b=ByJixM8ZLV/mD8n0mv0hecao7d2MBrjklwo8AfsqZ002VnlFa1BrsXlRQ/vRpYnitlOUhW
 uadIsQ5mYyKHRDXe5FysenQz8czcKhO7/j688gAS4ArM564j7QanGyx9GMMuERY8vYKmg3
 8n/yce30jV3WO95fspD8koVM1SBwB60=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-Z0mvdxtZPRGijalvowmR5Q-1; Tue, 10 Dec 2019 02:56:05 -0500
Received: by mail-wm1-f72.google.com with SMTP id g1so686941wmg.4
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 23:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7lKFvmIk1ckH9ho4BOT62MUH7tKFHMTUn/IZ+AcP/SE=;
 b=h/O/g4d2Fnu56rXszL0oHN2mLg3Y7T4D40J4XPmBBEoYpIQ2F+/z+29iE6N/jqX0Rk
 1WguhVqf6x8wnEu6oxYZYgQAwzREc89f5VW520aJAkHu3wW2fqzISWaEramkgp/1UaRt
 mo8EpZCGmCNuRt9QZ9rfi1RsHYMjHyN5rgK9y/R/XyRl0btnhoxyqPrWsMw26WUCT+uZ
 btpGELc+8t4t8r0gJVxahImbIxkokNVXK7SrHMAP9Lvgl/R2Fshyo1OYPOWPKzTF8+fN
 oX4HcbOAElYtCvrn+MECiUO5ycFmRv+MPv2stE5PdNCn3jst4ykr+0k/wEPvFF7vx6ET
 tCeg==
X-Gm-Message-State: APjAAAU3aI00cTmumSVp3LBvVQaTBj+Ao9XFkOLUgq3Ff2JOL2dEI7Hy
 nhnmiYMLdcIZoJBsejcreZopOSX3AYaDJ4gbUbI8AzmCsQtAOwmtAQEfsVULxdSkhYhvW3h73Ep
 PH5h89HwuLUwku9I=
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr3594421wmg.38.1575964563899; 
 Mon, 09 Dec 2019 23:56:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzpuD27zieSAWnmK5k7ErZ7Gf8lH2qXwKSBhTNv5mTzYEYTN7YvYLy+bt2UXvFMiX9hDPsXZQ==
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr3594407wmg.38.1575964563677; 
 Mon, 09 Dec 2019 23:56:03 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id g69sm2283097wmg.13.2019.12.09.23.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 23:56:03 -0800 (PST)
Subject: Re: [PATCH 04/10] arm: allwinner-h3: add USB host controller
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-5-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4a900e8d-d803-5c58-5a4b-879cce5970b4@redhat.com>
Date: Tue, 10 Dec 2019 08:56:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191202210947.3603-5-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: Z0mvdxtZPRGijalvowmR5Q-1
X-Mimecast-Spam-Score: 0
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/2/19 10:09 PM, Niek Linnenbank wrote:
> The Allwinner H3 System on Chip contains multiple USB 2.0 bus
> connections which provide software access using the Enhanced
> Host Controller Interface (EHCI) and Open Host Controller
> Interface (OHCI) interfaces. This commit adds support for
> both interfaces in the Allwinner H3 System on Chip.
>=20
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>   hw/arm/allwinner-h3.c    | 20 ++++++++++++++++++++
>   hw/usb/hcd-ehci-sysbus.c | 17 +++++++++++++++++
>   hw/usb/hcd-ehci.h        |  1 +

Cc'ing Gerd, the maintainer of these files.

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>   3 files changed, 38 insertions(+)
>=20
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index 5566e979ec..afeb49c0ac 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -26,6 +26,7 @@
>   #include "hw/sysbus.h"
>   #include "hw/arm/allwinner-h3.h"
>   #include "hw/misc/unimp.h"
> +#include "hw/usb/hcd-ehci.h"
>   #include "sysemu/sysemu.h"
>  =20
>   static void aw_h3_init(Object *obj)
> @@ -183,6 +184,25 @@ static void aw_h3_realize(DeviceState *dev, Error **=
errp)
>       }
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, AW_H3_CCU_BASE);
>  =20
> +    /* Universal Serial Bus */
> +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_BASE,
> +                         s->irq[AW_H3_GIC_SPI_EHCI0]);
> +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI1_BASE,
> +                         s->irq[AW_H3_GIC_SPI_EHCI1]);
> +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI2_BASE,
> +                         s->irq[AW_H3_GIC_SPI_EHCI2]);
> +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI3_BASE,
> +                         s->irq[AW_H3_GIC_SPI_EHCI3]);
> +
> +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI0_BASE,
> +                         s->irq[AW_H3_GIC_SPI_OHCI0]);
> +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI1_BASE,
> +                         s->irq[AW_H3_GIC_SPI_OHCI1]);
> +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI2_BASE,
> +                         s->irq[AW_H3_GIC_SPI_OHCI2]);
> +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI3_BASE,
> +                         s->irq[AW_H3_GIC_SPI_OHCI3]);
> +
>       /* UART */
>       if (serial_hd(0)) {
>           serial_mm_init(get_system_memory(), AW_H3_UART0_REG_BASE, 2,
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
>=20


