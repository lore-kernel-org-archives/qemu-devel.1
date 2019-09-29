Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D50C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 14:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5A1217F5
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 14:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tpw5Owz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5A1217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEaBp-0001jl-Ki
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 10:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iEaAz-00018h-8E
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 10:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iEaAy-0006VG-1Y
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 10:27:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iEaAx-0006TG-Q7; Sun, 29 Sep 2019 10:27:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id b9so8156232wrs.0;
 Sun, 29 Sep 2019 07:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=ic0DT++CDTEFfWN0dREva0EauIA/wv5K764o5Cro5E0=;
 b=tpw5Owz7XQtujeFt7/RnrmOPpwMhkCNuzOlw32acaWSFfXOF2GWNRlnUtXRKRqtaTB
 AOom2n5GywBUEUXYh9TkwlPchffdgZeLhlTbsXVjR0J1vigd29HD7nyQjSdn8K9ZsZGR
 D5WaS0rQSBywftH5pS5bXA17itDQ6hqxSXaIur1CVgwq8t3f62TlxeZZiznME9YWyKGs
 DzOXNStft63z/oac6aoIrTPBLNRmv3DdCGLcXXhy/n+/kVQabu8WfylijD1BHYrJA+rW
 iyGF3tZ/SilVM+8SzG5q0GoVJLBqCTj7Vp2kDWGEhTVYde3lLIhz8AvDSnDPxlX7K9M6
 9Mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=ic0DT++CDTEFfWN0dREva0EauIA/wv5K764o5Cro5E0=;
 b=hwV/b8mPTYutKYoZ01M5xpW6OJmXnkLX5LMLqsPahE/kkf4vxIae2uGF9bnEgbwJg1
 kVFUxFUsDSRv4GyItEUhNZBCi4pZj/sJqGlzXgSX0nNyPOi7OCzQhPHKOgu3uU+WYR2e
 x1qY/pgyw+quZWpL4l2O+czGtzJCtrkZ0zwtNxazoocbohAaXueWb7xkGvRqT1xhfecb
 kM+kh6MIGeIfjjNCobionGEBaXRox2Qq8K2rjZY9+YCrZt8a14/Fi0Gvlt+A8k0YF/GR
 qWLtnCm4GuDp8pNeBLpujoGL/I0CMa4ARwxHqH/yaP5DD2DF0bSqFeNVY2QOgFhHQAJL
 VgFw==
X-Gm-Message-State: APjAAAVuyf8rVOX73qY74FoaLfhWaJ55jrwJwy7XKXXAYJeKlmFid88t
 x9A1JW0vpRGW8pu3Nq6WM8Q=
X-Google-Smtp-Source: APXvYqyRE1XfE+VcpXAYJk2rC0fy/ih9VfcENHurN3hpiIKmU1rl74Zcf+86GF3Vfxsb/gflUJtRDw==
X-Received: by 2002:a5d:4102:: with SMTP id l2mr10410078wrp.348.1569767270193; 
 Sun, 29 Sep 2019 07:27:50 -0700 (PDT)
Received: from ?IPv6:2a01:c22:b04f:b200:7a70:bbc8:8101:45be?
 ([2a01:c22:b04f:b200:7a70:bbc8:8101:45be])
 by smtp.gmail.com with ESMTPSA id a7sm20286889wra.43.2019.09.29.07.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2019 07:27:49 -0700 (PDT)
Message-ID: <e5306439b3a7e77dc114e62b9083785a01f081a0.camel@gmail.com>
Subject: Re: [PATCH 06/14] hw/arm/bcm2835: Rename some definitions
From: Esteban Bosse <estebanbosse@gmail.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter
 Maydell <peter.maydell@linaro.org>, Andrew Baumann
 <Andrew.Baumann@microsoft.com>,  qemu-devel@nongnu.org, Pekka Enberg
 <penberg@iki.fi>,  =?ISO-8859-1?Q?Zolt=E1n?= Baldaszti <bztemail@gmail.com>
Date: Sun, 29 Sep 2019 16:27:39 +0200
In-Reply-To: <20190904171315.8354-7-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-7-f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

El mié, 04-09-2019 a las 19:13 +0200, Philippe Mathieu-Daudé escribió:
> The UART1 is part of the AUX peripheral,
> the PCM_CLOCK (yet unimplemented) is part of the CPRMAN.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/arm/bcm2835_peripherals.c    | 4 ++--
>  include/hw/arm/raspi_platform.h | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/bcm2835_peripherals.c
> b/hw/arm/bcm2835_peripherals.c
> index 8984e2e91f..270357b5a8 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -175,7 +175,7 @@ static void
> bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    memory_region_add_subregion(&s->peri_mr, UART1_OFFSET,
> +    memory_region_add_subregion(&s->peri_mr, AUX_OFFSET,
>                  sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->aux), 0));
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->aux), 0,
>          qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
> @@ -268,7 +268,7 @@ static void
> bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    memory_region_add_subregion(&s->peri_mr, EMMC_OFFSET,
> +    memory_region_add_subregion(&s->peri_mr, EMMC1_OFFSET,
>                  sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->sdhci),
> 0));
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
>          qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
> diff --git a/include/hw/arm/raspi_platform.h
> b/include/hw/arm/raspi_platform.h
> index 10083d33df..6f7db85bab 100644
> --- a/include/hw/arm/raspi_platform.h
> +++ b/include/hw/arm/raspi_platform.h
> @@ -39,7 +39,7 @@
>                                                        * Doorbells &
> Mailboxes */
>  #define PM_OFFSET               0x100000 /* Power Management, Reset
> controller
>                                            * and Watchdog registers
> */
> -#define PCM_CLOCK_OFFSET        0x101098
> +#define CPRMAN_OFFSET           0x101000 /* Clock Management */
>  #define RNG_OFFSET              0x104000
>  #define GPIO_OFFSET             0x200000
>  #define UART0_OFFSET            0x201000
> @@ -47,11 +47,11 @@
>  #define I2S_OFFSET              0x203000
>  #define SPI0_OFFSET             0x204000
>  #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
> -#define UART1_OFFSET            0x215000
> -#define EMMC_OFFSET             0x300000
> +#define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
> +#define EMMC1_OFFSET            0x300000
>  #define SMI_OFFSET              0x600000
>  #define BSC1_OFFSET             0x804000 /* BSC1 I2C/TWI */
> -#define USB_OFFSET              0x980000 /* DTC_OTG USB controller
> */
> +#define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller
> */
>  #define DMA15_OFFSET            0xE05000 /* DMA controller, channel
> 15 */
>  
>  /* GPU interrupts */
Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>


