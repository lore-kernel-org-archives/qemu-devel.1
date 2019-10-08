Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98206C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:35:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2121120659
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYdITWk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2121120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHrWa-0002yL-Ik
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHrTd-0001lm-36
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHrTb-0001Bb-AR
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:32:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43675)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHrTb-0001Ar-1W
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:32:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id j18so19137045wrq.10
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ebEuqSTBgMhTLEqAbtmBLq4tne6wZQyy3PK4RtADlTs=;
 b=ZYdITWk08XxOog5BvyQTY9j/mo+9GqY+0iOQvQLSgIhGp9PxwvOLMEos3mg3Rbny0Z
 v/W6Yx+o/cROhLb0itJ5SaHn0BVQod1T8ZBTzJ3E2t9tRN0j6EbNTNSz903ECkVa+s/Y
 68wDG/zCXXAt7fVXbT2WZcqH0p/izwWcXkd/Isd9vGBv2CUBq8mn7oWUYM8XFlHUorBT
 Qz57yLKPkq6oH1edH0t0/sR0912JDwIar0Pm5CR8p2v3q5Xr4ju5Dp0oI4sByUIONOZq
 rlquXkU0/ao6GZsr56Use8id60olg2znMabfUKsatwV0FUakKXdUcR+1BTFFzdYKGhDk
 5jvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ebEuqSTBgMhTLEqAbtmBLq4tne6wZQyy3PK4RtADlTs=;
 b=Qhyx+io6q3h3pC320NZm/dzvHEgs8ULU512w80yuHxDCaFcUYS22YK41XbQApb1Yb/
 dBe5MJ9b0hQANKLo+m9V4A2gjoVSPdIJKH0Oe1FJ5dmJQQr/mnWG48Zu671DoD414vxp
 sD99CDnJqLvjEdd+5Opn9CsIefhBAg2MXltidgQhgxr81yELSobkTBUkS/9XPOSc5WK7
 SspTgBRa7b/ZbHu1ssb9aK0JfhXhQuk4OtjkJoSvShubpmxnRRlZ/1v7YeJOu/v5hTeC
 Pk6PmHYQST1RkENkFPncHW2ORkANbVYi8s3UK8y6au9Oka4MNAKQ9dO8FtiBZUndM3vC
 XERg==
X-Gm-Message-State: APjAAAUZZa7DyihPeE3SLGY9e3CD7cXr0C7QlD26KrMqQAbeunuiqz2C
 J01zxQxs47b2+jfNfDhbJTXtLA==
X-Google-Smtp-Source: APXvYqy+9AfVEuHtmVh96EAb/ntFH653LU5oFQ1O1RlN9tVDwQ8bsmxr8/VPWMGfiDnHNmJpcQ9c0g==
X-Received: by 2002:adf:fe4c:: with SMTP id m12mr22760499wrs.150.1570548757328; 
 Tue, 08 Oct 2019 08:32:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j11sm24033886wrw.86.2019.10.08.08.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 08:32:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 11AF71FF87;
 Tue,  8 Oct 2019 16:32:36 +0100 (BST)
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-14-f4bug@amsat.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 13/19] hw/arm/raspi: Define various blocks base addresses
In-reply-to: <20190926173428.10713-14-f4bug@amsat.org>
Date: Tue, 08 Oct 2019 16:32:36 +0100
Message-ID: <87pnj7i76z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Zolt=C3=A1n?= Baldaszti <bztemail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> The Raspberry firmware is closed-source. While running it, it
> accesses various I/O registers. Logging these accesses as UNIMP
> (unimplemented) help to understand what the firmware is doing
> (ideally we want it able to boot a Linux kernel).
>
> Document various blocks we might use later.
>
> Adresses and names based on:
> https://github.com/hermanhermitage/videocoreiv/wiki/MMIO-Register-map

I'd put this link in the header as well to save diving into the git
record to find this out.

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Now the header is incorrect, should I add that in another file or
> update the header?
>
>  * These definitions are derived from those in Raspbian Linux at
>  * arch/arm/mach-{bcm2708,bcm2709}/include/mach/platform.h
>  * where they carry the following notice:

"Some of these definitions..."

"additional definitions from..."

will be fine I think. The links are out of date w.r.t. current kernel
master anyway so they could do with being fixed up.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>  *
>  * Copyright (C) 2010 Broadcom
> ---
>  include/hw/arm/raspi_platform.h | 47 +++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platf=
orm.h
> index 61b04a1bd4..8bcf1c7c93 100644
> --- a/include/hw/arm/raspi_platform.h
> +++ b/include/hw/arm/raspi_platform.h
> @@ -26,14 +26,19 @@
>  #define HW_ARM_RASPI_PLATFORM_H
>
>  #define MSYNC_OFFSET            0x0000   /* Multicore Sync Block */
> -#define IC0_OFFSET              0x2000
> +#define CCPT_OFFSET             0x1000   /* Compact Camera Port 2 TX */
> +#define INTE_OFFSET             0x2000   /* VC Interrupt controller */
>  #define ST_OFFSET               0x3000   /* System Timer */
> +#define TXP_OFFSET              0x4000
> +#define JPEG_OFFSET             0x5000
>  #define MPHI_OFFSET             0x6000   /* Message-based Parallel Host =
Intf. */
>  #define DMA_OFFSET              0x7000   /* DMA controller, channels 0-1=
4 */
> -#define ARM_OFFSET              0xB000   /* BCM2708 ARM control block */
> +#define ARBA_OFFSET             0x9000
> +#define BRDG_OFFSET             0xa000
> +#define ARM_OFFSET              0xB000   /* ARM control block */
>  #define ARMCTRL_OFFSET          (ARM_OFFSET + 0x000)
>  #define ARMCTRL_IC_OFFSET       (ARM_OFFSET + 0x200) /* Interrupt contro=
ller */
> -#define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0 and 1 */
> +#define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0 and 1 (S=
P804) */
>  #define ARMCTRL_0_SBM_OFFSET    (ARM_OFFSET + 0x800) /* User 0 (ARM) Sem=
aphores
>                                                        * Doorbells & Mail=
boxes */
>  #define CPRMAN_OFFSET           0x100000 /* Power Management, Watchdog */
> @@ -42,24 +47,50 @@
>  #define AVS_OFFSET              0x103000 /* Audio Video Standard */
>  #define RNG_OFFSET              0x104000
>  #define GPIO_OFFSET             0x200000
> -#define UART0_OFFSET            0x201000
> -#define MMCI0_OFFSET            0x202000
> -#define I2S_OFFSET              0x203000
> -#define SPI0_OFFSET             0x204000
> +#define UART0_OFFSET            0x201000 /* PL011 */
> +#define MMCI0_OFFSET            0x202000 /* Legacy MMC */
> +#define I2S_OFFSET              0x203000 /* PCM */
> +#define SPI0_OFFSET             0x204000 /* SPI master */
>  #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
> +#define PIXV0_OFFSET            0x206000
> +#define PIXV1_OFFSET            0x207000
> +#define DPI_OFFSET              0x208000
> +#define DSI0_OFFSET             0x209000 /* Display Serial Interface */
> +#define PWM_OFFSET              0x20c000
> +#define PERM_OFFSET             0x20d000
> +#define TEC_OFFSET              0x20e000
>  #define OTP_OFFSET              0x20f000
> +#define SLIM_OFFSET             0x210000 /* SLIMbus */
> +#define CPG_OFFSET              0x211000
>  #define THERMAL_OFFSET          0x212000
> -#define BSC_SL_OFFSET           0x214000 /* SPI slave */
> +#define AVSP_OFFSET             0x213000
> +#define BSC_SL_OFFSET           0x214000 /* SPI slave (bootrom) */
>  #define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
>  #define EMMC1_OFFSET            0x300000
> +#define EMMC2_OFFSET            0x340000
> +#define HVS_OFFSET              0x400000
>  #define SMI_OFFSET              0x600000
> +#define DSI1_OFFSET             0x700000
> +#define UCAM_OFFSET             0x800000
> +#define CMI_OFFSET              0x802000
>  #define BSC1_OFFSET             0x804000 /* BSC1 I2C/TWI */
>  #define BSC2_OFFSET             0x805000 /* BSC2 I2C/TWI */
> +#define VECA_OFFSET             0x806000
> +#define PIXV2_OFFSET            0x807000
> +#define HDMI_OFFSET             0x808000
> +#define HDCP_OFFSET             0x809000
> +#define ARBR0_OFFSET            0x80a000
>  #define DBUS_OFFSET             0x900000
>  #define AVE0_OFFSET             0x910000
>  #define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller */
> +#define V3D_OFFSET              0xc00000
>  #define SDRAMC_OFFSET           0xe00000
> +#define L2CC_OFFSET             0xe01000 /* Level 2 Cache controller */
> +#define L1CC_OFFSET             0xe02000 /* Level 1 Cache controller */
> +#define ARBR1_OFFSET            0xe04000
>  #define DMA15_OFFSET            0xE05000 /* DMA controller, channel 15 */
> +#define DCRC_OFFSET             0xe07000
> +#define AXIP_OFFSET             0xe08000
>
>  /* GPU interrupts */
>  #define INTERRUPT_TIMER0               0


--
Alex Benn=C3=A9e

