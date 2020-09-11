Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E16AC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8A320575
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRNu77VD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8A320575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGiUA-0000cz-TP
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 08:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGiRm-00065c-RK; Fri, 11 Sep 2020 08:46:39 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGiRi-0002zR-JZ; Fri, 11 Sep 2020 08:46:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id b79so4666157wmb.4;
 Fri, 11 Sep 2020 05:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WNEP0Dkhm9Mta4bm2Ny3NiK7P3p0izl7GHQnuwmbPa8=;
 b=RRNu77VDC3L/TyUUnShvnQoGmYFzNGHfowlz+JG5MrBAVkUV4YV8ClmHSK+I/gJP0h
 f7fLwf8OzbTAtLNgp+fxRi7Nwh2aV6+V49d1yghD7+wTA6VIEEjb8ye36KtN49Shp5HE
 fTeHdthPmPxrp72ECxW63pZZbCPUQjr/Ilp2we67hj90jzr0DBkt1U/+3/MC0x1UvP2D
 bq5dtLbx7iS7lNAoOGBqMXLjF08KtWuRm0kgRYVStOpaCUXoKzcccKwn6QCMnizpaPxI
 K2+CJb4TOMW5jrnUiWXx4vMtWrulZ/ZlXznUDjF7Wr5MVY8TtIvPpNQ2Z223Mocz+Ajm
 fxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WNEP0Dkhm9Mta4bm2Ny3NiK7P3p0izl7GHQnuwmbPa8=;
 b=dWXua/VckIxVCtHAFyafGkYJsn7Ye/mxi+odwNClruxIkj2WGAB10YfQjhKVVLNsy2
 P/SQKxWVxGnOzenjCdARiIr0O2C+r9t1u5YjT4srGKW0m/N7SLY1uHtflANNkpa0EY5y
 8HUS/68mhCnECVgCy2Q2dJujsQj2qLbVPhiy808KHWETUwiMXoiFuUNvM65qlG9pIsCp
 7y2vfMfzqRoXVFApa4MNSHN0n554Hbx824Fe5ItIREmzN0fOJ+fA+7a6kHxt/OrKP066
 d4GoxyEa0fcXRM4JhddGz9TnR3h/9q0QjmnwBuQ3QFEi0uJC43veT/Ed9q+L379PVSWZ
 kKTw==
X-Gm-Message-State: AOAM533f2I+nx2KG8LUOeVUJaEv0IgpO5SE0RKBONowWeJeSYnwTdjUq
 rta1xaw3me0oMi24iYGDhRDfCrlhJrw=
X-Google-Smtp-Source: ABdhPJz9VxvTIu82y9BjdSJfVy+lHsvd8rVBtD9hQz+4Ec/UWwhCD1QFAWWicwtQryCCQnLi3rxK4w==
X-Received: by 2002:a1c:dd87:: with SMTP id u129mr2079807wmg.172.1599828388696; 
 Fri, 11 Sep 2020 05:46:28 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q186sm4226716wma.45.2020.09.11.05.46.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 05:46:28 -0700 (PDT)
Subject: Re: [PATCH v9 11/14] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200911052101.2602693-1-hskinnemoen@google.com>
 <20200911052101.2602693-12-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e852efda-b8d9-0e41-8b1b-ed7cb01e7f51@amsat.org>
Date: Fri, 11 Sep 2020 14:46:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911052101.2602693-12-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-2.469,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kfting@nuvoton.com, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/11/20 7:20 AM, Havard Skinnemoen via wrote:
> This allows these NPCM7xx-based boards to boot from a flash image, e.g.
> one built with OpenBMC. For example like this:
> 
> IMAGE=${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
> qemu-system-arm -machine quanta-gsj -nographic \
> 	-drive file=${IMAGE},if=mtd,bus=0,unit=0,format=raw,snapshot=on
> 
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Tested-by: Cédric Le Goater <clg@kaod.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>  hw/arm/npcm7xx_boards.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
> index b4c772d6b5..79e2e2744c 100644
> --- a/hw/arm/npcm7xx_boards.c
> +++ b/hw/arm/npcm7xx_boards.c
> @@ -20,6 +20,7 @@
>  #include "hw/arm/npcm7xx.h"
>  #include "hw/core/cpu.h"
>  #include "hw/loader.h"
> +#include "hw/qdev-properties.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "qemu/units.h"
> @@ -55,6 +56,22 @@ static void npcm7xx_load_bootrom(MachineState *machine, NPCM7xxState *soc)
>      }
>  }
>  
> +static void npcm7xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
> +                                  const char *flash_type, DriveInfo *dinfo)
> +{
> +    DeviceState *flash;
> +    qemu_irq flash_cs;
> +
> +    flash = qdev_new(flash_type);
> +    if (dinfo) {
> +        qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
> +    }
> +    qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);
> +
> +    flash_cs = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
> +    qdev_connect_gpio_out_named(DEVICE(fiu), "cs", cs_no, flash_cs);
> +}
> +
>  static void npcm7xx_connect_dram(NPCM7xxState *soc, MemoryRegion *dram)
>  {
>      memory_region_add_subregion(get_system_memory(), NPCM7XX_DRAM_BA, dram);
> @@ -92,6 +109,7 @@ static void npcm750_evb_init(MachineState *machine)
>      qdev_realize(DEVICE(soc), NULL, &error_fatal);
>  
>      npcm7xx_load_bootrom(machine, soc);
> +    npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));

Nitpicking: add definition for '0' magic number
(consider as future cleanup).

>      npcm7xx_load_kernel(machine, soc);
>  }
>  
> @@ -104,6 +122,8 @@ static void quanta_gsj_init(MachineState *machine)
>      qdev_realize(DEVICE(soc), NULL, &error_fatal);
>  
>      npcm7xx_load_bootrom(machine, soc);
> +    npcm7xx_connect_flash(&soc->fiu[0], 0, "mx25l25635e",
> +                          drive_get(IF_MTD, 0, 0));

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      npcm7xx_load_kernel(machine, soc);
>  }
>  
> 

