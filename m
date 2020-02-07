Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF67AC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA4F921775
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQXXSZit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4F921775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j03tH-0002WV-W6
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 08:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j03sU-0001U2-6y
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j03sS-0007aP-AB
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:41:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32964
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j03sR-0007Y0-93
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581082858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vq/WHv9rsrgZFCCngOGb0Smg/2lD0d4tiEbgqBwORmk=;
 b=KQXXSZit7u66w0SdGHRZ5Cjk77sr1oVzO7Oy8QAcDypRGBc/PBQpEDYP2wIVLWY9y/U4Yn
 jg2HxyGpwxqC/qbxcea3dkZTLvuGSx0bPfY0oAQJa2dsOYxHWvuzslqQFeOQrqcg40QR9J
 B8TfZp//IN66ucy5Bc0x1bW4QWB4Es0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-gb1VCDnfOTK64638h5C6Ew-1; Fri, 07 Feb 2020 08:40:55 -0500
Received: by mail-wm1-f72.google.com with SMTP id 205so751634wmc.6
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 05:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=icvCLwP5xvkeg9X7jv+3GbM5xpcVQFPo59uqDlBOmcs=;
 b=T9W/LhdUlx2dDqnFCL+hLCCPc3gOc78qpUHefIWO79U8ri6dal9hwOgwHdXCnyhUNq
 tPEZ0O3qYOrY+259WwpOhiKJjD+CVqXlbpHqtnmJGzvwJQsKLBCW5ZT8DNbYlKjpq6tl
 RMeVFK01gLXA/Bjdi9j6JBHAU0icsq2Uf8ZiZnNjmnQvGZtOQpeLjrrR7XgKh5h9QaIt
 S5eazsWDFqPTZLEXme5eG/EMjzUUREVXmUrFc0nOMGgKsB62ApJc34m/Dh67bJsbU4+3
 8SXEPnAKrIVxDsPk2rgBuh1pQA+4nhoTUE1JovkADUOMDC9JoqYyqKjY1FC05DlcTza+
 8Wyw==
X-Gm-Message-State: APjAAAXwFN1Jt/frxq3FCT4dQkB6tSJkHKYombypG1GHR109t4RleNrq
 QG61jrKQcVDAYMWY6ZU/d8U4P/MbPWfdmms6rP+IUCbC23qp1vwgWvq6KTP9EjGbjMAy//4G7dU
 EySHa4DtD5QGuDxQ=
X-Received: by 2002:adf:e984:: with SMTP id h4mr4856767wrm.275.1581082854405; 
 Fri, 07 Feb 2020 05:40:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfhrNAZFbDPe/6lWMat8Z2APhu3LfeN7+XrwhIyE5rmYFg51qvX6wQ5IqICbw8AveQF+coiA==
X-Received: by 2002:adf:e984:: with SMTP id h4mr4856741wrm.275.1581082854118; 
 Fri, 07 Feb 2020 05:40:54 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s22sm3307171wmh.4.2020.02.07.05.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 05:40:53 -0800 (PST)
Subject: Re: [PATCH] hw/arm: ast2400/ast2500: Wire up EHCI controllers
To: Guenter Roeck <linux@roeck-us.net>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>
References: <20200206183437.3979-1-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9aa0cb6e-a06a-7086-5846-e34233c54b74@redhat.com>
Date: Fri, 7 Feb 2020 14:40:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206183437.3979-1-linux@roeck-us.net>
Content-Language: en-US
X-MC-Unique: gb1VCDnfOTK64638h5C6Ew-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 7:34 PM, Guenter Roeck wrote:
> Initialize EHCI controllers on AST2400 and AST2500 using the existing
> TYPE_PLATFORM_EHCI. After this change, booting ast2500-evb into Linux
> successfully instantiates a USB interface.
>=20
> ehci-platform 1e6a3000.usb: EHCI Host Controller
> ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus number 1
> ehci-platform 1e6a3000.usb: irq 21, io mem 0x1e6a3000
> ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
> usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002, bcdDev=
ice=3D 5.05
> usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> usb usb1: Product: EHCI Host Controller
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   hw/arm/aspeed_soc.c         | 25 +++++++++++++++++++++++++
>   include/hw/arm/aspeed_soc.h |  6 ++++++
>   2 files changed, 31 insertions(+)
>=20
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index b5e809a1d3..696c7fda14 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -30,6 +30,7 @@ static const hwaddr aspeed_soc_ast2400_memmap[] =3D {
>       [ASPEED_IOMEM]  =3D 0x1E600000,
>       [ASPEED_FMC]    =3D 0x1E620000,
>       [ASPEED_SPI1]   =3D 0x1E630000,
> +    [ASPEED_EHCI1]  =3D 0x1E6A1000,
>       [ASPEED_VIC]    =3D 0x1E6C0000,
>       [ASPEED_SDMC]   =3D 0x1E6E0000,
>       [ASPEED_SCU]    =3D 0x1E6E2000,
> @@ -59,6 +60,8 @@ static const hwaddr aspeed_soc_ast2500_memmap[] =3D {
>       [ASPEED_FMC]    =3D 0x1E620000,
>       [ASPEED_SPI1]   =3D 0x1E630000,
>       [ASPEED_SPI2]   =3D 0x1E631000,
> +    [ASPEED_EHCI1]  =3D 0x1E6A1000,
> +    [ASPEED_EHCI2]  =3D 0x1E6A3000,
>       [ASPEED_VIC]    =3D 0x1E6C0000,
>       [ASPEED_SDMC]   =3D 0x1E6E0000,
>       [ASPEED_SCU]    =3D 0x1E6E2000,
> @@ -91,6 +94,8 @@ static const int aspeed_soc_ast2400_irqmap[] =3D {
>       [ASPEED_UART5]  =3D 10,
>       [ASPEED_VUART]  =3D 8,
>       [ASPEED_FMC]    =3D 19,
> +    [ASPEED_EHCI1]  =3D 5,
> +    [ASPEED_EHCI2]  =3D 13,
>       [ASPEED_SDMC]   =3D 0,
>       [ASPEED_SCU]    =3D 21,
>       [ASPEED_ADC]    =3D 31,
> @@ -180,6 +185,11 @@ static void aspeed_soc_init(Object *obj)
>                                 sizeof(s->spi[i]), typename);
>       }
>  =20
> +    for (i =3D 0; i < sc->ehcis_num; i++) {
> +        sysbus_init_child_obj(obj, "ehci[*]", OBJECT(&s->ehci[i]),
> +                              sizeof(s->ehci[i]), TYPE_PLATFORM_EHCI);
> +    }
> +
>       snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
>       sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sdmc=
),
>                             typename);
> @@ -364,6 +374,19 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
>                           s->spi[i].ctrl->flash_window_base);
>       }
>  =20
> +    /* EHCI */
> +    for (i =3D 0; i < sc->ehcis_num; i++) {
> +        object_property_set_bool(OBJECT(&s->ehci[i]), true, "realized", =
&err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
> +                        sc->memmap[ASPEED_EHCI1 + i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
> +                           aspeed_soc_get_irq(s, ASPEED_EHCI1 + i));
> +    }
> +
>       /* SDMC - SDRAM Memory Controller */
>       object_property_set_bool(OBJECT(&s->sdmc), true, "realized", &err);
>       if (err) {
> @@ -472,6 +495,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass=
 *oc, void *data)
>       sc->silicon_rev  =3D AST2400_A1_SILICON_REV;
>       sc->sram_size    =3D 0x8000;
>       sc->spis_num     =3D 1;
> +    sc->ehcis_num    =3D 1;
>       sc->wdts_num     =3D 2;
>       sc->macs_num     =3D 2;
>       sc->irqmap       =3D aspeed_soc_ast2400_irqmap;
> @@ -496,6 +520,7 @@ static void aspeed_soc_ast2500_class_init(ObjectClass=
 *oc, void *data)
>       sc->silicon_rev  =3D AST2500_A1_SILICON_REV;
>       sc->sram_size    =3D 0x9000;
>       sc->spis_num     =3D 2;
> +    sc->ehcis_num    =3D 2;
>       sc->wdts_num     =3D 3;
>       sc->macs_num     =3D 2;
>       sc->irqmap       =3D aspeed_soc_ast2500_irqmap;
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 90ac7f7ffa..78b9f6ae53 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -26,8 +26,10 @@
>   #include "target/arm/cpu.h"
>   #include "hw/gpio/aspeed_gpio.h"
>   #include "hw/sd/aspeed_sdhci.h"
> +#include "hw/usb/hcd-ehci.h"
>  =20
>   #define ASPEED_SPIS_NUM  2
> +#define ASPEED_EHCIS_NUM 2
>   #define ASPEED_WDTS_NUM  4
>   #define ASPEED_CPUS_NUM  2
>   #define ASPEED_MACS_NUM  4
> @@ -50,6 +52,7 @@ typedef struct AspeedSoCState {
>       AspeedXDMAState xdma;
>       AspeedSMCState fmc;
>       AspeedSMCState spi[ASPEED_SPIS_NUM];
> +    EHCISysBusState ehci[ASPEED_EHCIS_NUM];
>       AspeedSDMCState sdmc;
>       AspeedWDTState wdt[ASPEED_WDTS_NUM];
>       FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
> @@ -71,6 +74,7 @@ typedef struct AspeedSoCClass {
>       uint32_t silicon_rev;
>       uint64_t sram_size;
>       int spis_num;
> +    int ehcis_num;
>       int wdts_num;
>       int macs_num;
>       const int *irqmap;
> @@ -94,6 +98,8 @@ enum {
>       ASPEED_FMC,
>       ASPEED_SPI1,
>       ASPEED_SPI2,
> +    ASPEED_EHCI1,
> +    ASPEED_EHCI2,
>       ASPEED_VIC,
>       ASPEED_SDMC,
>       ASPEED_SCU,
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


