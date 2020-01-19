Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18A4C33CAF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 19:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45AFE206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 19:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVHEQPR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AFE206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itG2T-0000E5-66
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 14:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itG1k-0007qZ-WD
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 14:14:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itG1i-0007CT-5x
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 14:14:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40920
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itG1h-0007C2-Rl
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 14:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579461264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nm9lhLKyp10b9IzN5PS5J2MlVlNwY1BeCm+X3CH8Rxw=;
 b=VVHEQPR2qGnhg8nRhjyLTUqThCe5NjEax9BWFIN8sWenJlQBHq2zSQ9m0/nYj9vrCDhlSJ
 b9987LAFG2iYBkQZ3hC7nfO1pvsMW7e9P+itUWVdidCaRZN11afZLXdziYDn9MfIW5Yjf6
 Ja18svcs8VzvX5KN44sVWojG/KUrtgk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-PMW_yoeLNVWsWLPAQL6UMg-1; Sun, 19 Jan 2020 14:14:21 -0500
Received: by mail-wr1-f70.google.com with SMTP id k18so13121126wrw.9
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2020 11:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Nm9lhLKyp10b9IzN5PS5J2MlVlNwY1BeCm+X3CH8Rxw=;
 b=a7jtRpsR+Xc+pX3t2+iP2BgwmAC78vUgk1dmro7+ih2va/YFw2DNul7B4Kkaqmh7+a
 V5Gx5MCrk5KbhtBPzv6gkwOr46IRT1pD2Uz+WTLgeM31JT6qE25c7ggucLbYvu9WGVmJ
 sh8uJT2SatrH9jpd/+VnI/dhms76eaPdVomyUrIK79gYrtMqdOJfHdCrkTWOiX+Q60Gm
 9Ydhu7A3wR7AF46pOf21p4ye859Z7ZX4/mHiqxQgDaSBOotMYdDRFLlJ0G2mtbPbXjF/
 RIqgiknCYo4st+aG1GytaTYrYiX8cQ70ZX+ua7JieNoOlztJHLhILnxLmQY8wQij3cpp
 PMSQ==
X-Gm-Message-State: APjAAAUgafUrC4HuaDMpzjs5a5yrfshTY8ZKtykyKwGiGzpvMO7fESXa
 PHUU+0AnWXTD3ssDFmcOdgJ35Qgi0wN6gte2qPjXt5u6ZvZWQViq5iDMJqhHKJE2yPN3I8Ufma0
 u389X0eCTeQB/z/I=
X-Received: by 2002:adf:e641:: with SMTP id b1mr14518314wrn.34.1579461260415; 
 Sun, 19 Jan 2020 11:14:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqyKZnSnDgiKfYy2dnA4jSvdWWbF1s5hpLO/9iyEy0JrIm9LPmArzOydLVravqjpfkrOV35YzA==
X-Received: by 2002:adf:e641:: with SMTP id b1mr14518297wrn.34.1579461260149; 
 Sun, 19 Jan 2020 11:14:20 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id t25sm19443880wmj.19.2020.01.19.11.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jan 2020 11:14:19 -0800 (PST)
Subject: Re: [PATCH v4 10/20] hw/arm/allwinner-h3: add Boot ROM support
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-11-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1179d8a3-e61d-ad1f-bde9-3a73fde766a8@redhat.com>
Date: Sun, 19 Jan 2020 20:14:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200119005102.3847-11-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: PMW_yoeLNVWsWLPAQL6UMg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, b.galvani@gmail.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/19/20 1:50 AM, Niek Linnenbank wrote:
> A real Allwinner H3 SoC contains a Boot ROM which is the
> first code that runs right after the SoC is powered on.
> The Boot ROM is responsible for loading user code (e.g. a bootloader)
> from any of the supported external devices and writing the downloaded
> code to internal SRAM. After loading the SoC begins executing the code
> written to SRAM.
> 
> This commits adds emulation of the Boot ROM firmware setup functionality
> by loading user code from SD card in the A1 SRAM. While the A1 SRAM is
> 64KiB, we limit the size to 32KiB because the real H3 Boot ROM also rejects
> sizes larger than 32KiB. For reference, this behaviour is documented
> by the Linux Sunxi project wiki at:
> 
>    https://linux-sunxi.org/BROM#U-Boot_SPL_limitations
> 
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>   include/hw/arm/allwinner-h3.h | 23 +++++++++++++++++++++++
>   hw/arm/allwinner-h3.c         | 28 ++++++++++++++++++++++++++++
>   hw/arm/orangepi.c             |  5 +++++
>   3 files changed, 56 insertions(+)
> 
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
> index f9b9a02373..f5e16266cd 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -46,6 +46,7 @@
>   #include "hw/sd/allwinner-sdhost.h"
>   #include "hw/net/allwinner-sun8i-emac.h"
>   #include "target/arm/cpu.h"
> +#include "sysemu/block-backend.h"
>   
>   /**
>    * Allwinner H3 device list
> @@ -129,4 +130,26 @@ typedef struct AwH3State {
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
> index 1085223812..3d0470825a 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -29,6 +29,7 @@
>   #include "hw/char/serial.h"
>   #include "hw/misc/unimp.h"
>   #include "hw/usb/hcd-ehci.h"
> +#include "hw/loader.h"
>   #include "sysemu/sysemu.h"
>   #include "hw/arm/allwinner-h3.h"
>   
> @@ -170,6 +171,33 @@ enum {
>       AW_H3_GIC_NUM_SPI       = 128
>   };
>   
> +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk, Error **errp)
> +{
> +    uint8_t *buffer;
> +    int64_t rom_size = 32 * KiB;
> +
> +    int64_t blk_size = blk_getlength(blk);
> +    if (blk_size <= 0) {
> +        error_setg(errp, "%s: failed to get BlockBackend size", __func__);
> +        return;
> +    }
> +
> +    if (rom_size > blk_size) {
> +        rom_size = blk_size;

This doesn't seem correct, have you tried to use a 1MB file?

This can't be bigger than the SRAM size, 64KB.

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
> index 25bf85f8fc..9d4c79885e 100644
> --- a/hw/arm/orangepi.c
> +++ b/hw/arm/orangepi.c
> @@ -95,6 +95,11 @@ static void orangepi_init(MachineState *machine)
>       memory_region_add_subregion(get_system_memory(), s->h3->memmap[AW_H3_SDRAM],
>                                   &s->sdram);
>   
> +    /* Load target kernel or start using BootROM */
> +    if (!machine->kernel_filename && blk_is_available(blk)) {
> +        /* Use Boot ROM to copy data from SD card to SRAM */
> +        allwinner_h3_bootrom_setup(s->h3, blk, &error_fatal);
allwinner_h3_bootrom_setup() doesn't need the errp argument, you can use 
error_fatal directly there.

> +    }
>       orangepi_binfo.loader_start = s->h3->memmap[AW_H3_SDRAM];
>       orangepi_binfo.ram_size = machine->ram_size;
>       arm_load_kernel(ARM_CPU(first_cpu), machine, &orangepi_binfo);
> 


