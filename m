Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948DEC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 23:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C30920678
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 23:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6O0yQ2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C30920678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir98b-0004AD-G6
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 18:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ir97w-0003ck-PF
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 18:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ir97u-0007f1-V5
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 18:28:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22526
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ir97u-0007e7-R3
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 18:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578958085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCtqXFuC/9lliiVZPeVqVVNvjp9NJJrmS/KqAIpLcT4=;
 b=i6O0yQ2r6PNqwEpUB68vi45bQONgbj90Tqlq0XBgDRO62rJfxJzynX4pRkYjbAFOpSgM6r
 6+ox0DDH+kh8a6BLYnz1Dyx2sa8NNrdESgbdAIpylCXzKwWUU+Wim5quZWsUUXxQDw8q7X
 N2I0ZsbmIzJnrZCEYVdgEx2CAVetOgI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-mM8mkCJpN4-xG5grpsgt2Q-1; Mon, 13 Jan 2020 18:28:04 -0500
Received: by mail-wr1-f70.google.com with SMTP id b13so5664449wrx.22
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 15:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FCtqXFuC/9lliiVZPeVqVVNvjp9NJJrmS/KqAIpLcT4=;
 b=ncEMSGPgrwH2dfZpYucrigZoK5sl/qxkt42CYV7ktvP8Hjgsi1XBz9ynEW5FDBeKqO
 ob9gEdjUzlCUAgZIm8lk0GQqA1GKOMdfC9aiP5ByWLzIlTt+BNbXvR4qABAc9GQ8MrVT
 UHFOXshKW4RQ8ij8/RR+SeRFk0jWCtPO+gtFi+zO1/U4i+zj7YSghjrqYPFxLFvLgBAT
 Nxtg+jDWmUXGMhzLseN5SGzxtM4l3kNEu3WGxUa7chLhB+EGVoF1tGHbFruXqrWhg18y
 16ef0ZyajEFBjVdM0FYHcoZx5PA73belflxoXzXGU0Lx6xx+lPZq6DLfmiy0m+uuqYHu
 o/rg==
X-Gm-Message-State: APjAAAULBqxi9UkKD+OGJRqPPp5gv9du14/vG7rFyX7UgJKbUErUdPGz
 H2tv8MAOVxvPGnKbs9j4kbvjTZegc6f9XM6wWEfE5QgdoQrxqLHllu/WdLT8WD9rV/5sfxi42/M
 d7bTQbjTTNUkpwYU=
X-Received: by 2002:a05:6000:1288:: with SMTP id
 f8mr21364017wrx.66.1578958083507; 
 Mon, 13 Jan 2020 15:28:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLrvUc0xNp4Yo96FcxXV0gxq68N8miSDDViELH1xmqfSVaJYDUA+qYdtz8RFbPbPhegbYxjg==
X-Received: by 2002:a05:6000:1288:: with SMTP id
 f8mr21363995wrx.66.1578958083250; 
 Mon, 13 Jan 2020 15:28:03 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id n14sm15546902wmi.26.2020.01.13.15.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2020 15:28:02 -0800 (PST)
Subject: Re: [PATCH v3 10/17] hw/arm/allwinner-h3: add Boot ROM support
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-11-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9c878f16-b18c-cc1a-9e82-40dbdd31b823@redhat.com>
Date: Tue, 14 Jan 2020 00:28:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108200020.4745-11-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: mM8mkCJpN4-xG5grpsgt2Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 9:00 PM, Niek Linnenbank wrote:
> A real Allwinner H3 SoC contains a Boot ROM which is the
> first code that runs right after the SoC is powered on.
> The Boot ROM is responsible for loading user code (e.g. a bootloader)
> from any of the supported external devices and writing the downloaded
> code to internal SRAM. After loading the SoC begins executing the code
> written to SRAM. This commits adds emulation of the Boot ROM firmware
> setup functionality by loading user code from SD card.
> 
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>   include/hw/arm/allwinner-h3.h | 23 +++++++++++++++++++++++
>   hw/arm/allwinner-h3.c         | 28 ++++++++++++++++++++++++++++
>   hw/arm/orangepi.c             |  3 +++
>   3 files changed, 54 insertions(+)
> 
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
> index 5d74cca28e..4b66227ac4 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -50,6 +50,7 @@
>   #include "hw/sd/allwinner-sdhost.h"
>   #include "hw/net/allwinner-sun8i-emac.h"
>   #include "target/arm/cpu.h"
> +#include "sysemu/block-backend.h"
>   
>   /**
>    * Allwinner H3 device list
> @@ -130,4 +131,26 @@ typedef struct AwH3State {
>       MemoryRegion sram_c;
>   } AwH3State;
>   
> +/**
> + * Emulate Boot ROM firmware setup functionality.
> + *
> + * A real Allwinner H3 SoC contains a Boot ROM
> + * which is the first code that runs right after
> + * the SoC is powered on. The Boot ROM is responsible
> + * for loading user code (e.g. a bootloader) from any
> + * of the supported external devices and writing the
> + * downloaded code to internal SRAM. After loading the SoC
> + * begins executing the code written to SRAM.
> + *
> + * This function emulates the Boot ROM by copying 32 KiB
> + * of data from the given block device and writes it to
> + * the start of the first internal SRAM memory.
> + *
> + * @s: Allwinner H3 state object pointer
> + * @blk: Block backend device object pointer
> + * @errp: Error object pointer for raising errors
> + */
> +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk,
> +                                Error **errp);
> +
>   #endif /* HW_ARM_ALLWINNER_H3_H */
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index e692432b4e..e7b768ad5b 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -27,6 +27,7 @@
>   #include "hw/char/serial.h"
>   #include "hw/misc/unimp.h"
>   #include "hw/usb/hcd-ehci.h"
> +#include "hw/loader.h"
>   #include "sysemu/sysemu.h"
>   #include "hw/arm/allwinner-h3.h"
>   
> @@ -168,6 +169,33 @@ enum {
>       AW_H3_GIC_NUM_SPI       = 128
>   };
>   
> +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk, Error **errp)
> +{
> +    uint8_t *buffer;
> +    int64_t rom_size = 32 * KiB;

Why restrict to 32K? The A1 SRAM is 64K.

> +
> +    int64_t blk_size = blk_getlength(blk);
> +    if (blk_size <= 0) {
> +        error_setg(errp, "%s: failed to get BlockBackend size", __func__);
> +        return;
> +    }
> +
> +    if (rom_size > blk_size) {
> +        rom_size = blk_size;
> +    }
> +
> +    buffer = g_new0(uint8_t, rom_size);
> +    if (blk_pread(blk, 8 * KiB, buffer, rom_size) < 0) {
> +        error_setg(errp, "%s: failed to read BlockBackend data", __func__);
> +        return;
> +    }
> +
> +    rom_add_blob("allwinner-h3.bootrom", buffer, rom_size,
> +                  rom_size, s->memmap[AW_H3_SRAM_A1],
> +                  NULL, NULL, NULL, NULL, false);
> +    g_free(buffer);
> +}
> +
>   static void allwinner_h3_init(Object *obj)
>   {
>       AwH3State *s = AW_H3(obj);
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> index 0eb52eb813..b722f49485 100644
> --- a/hw/arm/orangepi.c
> +++ b/hw/arm/orangepi.c
> @@ -93,6 +93,9 @@ static void orangepi_init(MachineState *machine)
>       if (bios_name) {
>           error_report("BIOS not supported for this machine");
>           exit(1);
> +    } else if (!machine->kernel_filename && blk_is_available(blk)) {
> +        /* Use Boot ROM to copy data from SD card to SRAM */
> +        allwinner_h3_bootrom_setup(s->h3, blk, &error_fatal);
>       }
>       orangepi_binfo.loader_start = s->h3->memmap[AW_H3_SDRAM];
>       orangepi_binfo.ram_size = machine->ram_size;
> 


