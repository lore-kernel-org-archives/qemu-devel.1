Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08659C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 00:04:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3FB8206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 00:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNJX5A81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FB8206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifYR4-0001i8-Rt
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 19:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifYQK-0001AZ-Fw
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 19:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifYQG-0004A6-1y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 19:03:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38149
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifYQF-00046w-KU
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 19:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576195386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8TpwVKN1DBYnKX/E4NCbS/KvamUOsZgi5iIcOG9naA=;
 b=fNJX5A81F+ZZY1PldVHoH+uqxOX4dAXTULXlSt3TlKjIDfR0spxIGMrfKcltfv7em3tMge
 qB4xi1r1TE0tl0nJvMJtNVfIagC3XB/mBMSgfzGJIHLlUn2ZzQmEIrJcOpPeMHCAJ+WjhW
 8lyJ7YrIoiHLpBwPhoDfHCYh6W21RX4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-v9XmeSpBOcyLsxT4dJnkvQ-1; Thu, 12 Dec 2019 19:03:05 -0500
Received: by mail-wm1-f72.google.com with SMTP id q26so1011666wmq.8
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R8TpwVKN1DBYnKX/E4NCbS/KvamUOsZgi5iIcOG9naA=;
 b=Z6RARPYoHixsXpady5oKXJd5FwAjxdw+q2ANvz2BIn+W3DN+b3pJndqDbsLbyYpg1H
 8bLYQwedPWCRxNO3IYiLgPmYTMD5Eh/KtDZQSvfTJVv6S3Q4SZdqLluE0tKHXe3eRflW
 tggxkgTQ5aJo8eCGs/SkIuxVgL7WojZr29Gq+xncgdVfoR1Q90RPxYhfqvGVLNw6/MNq
 +Y8WYPZfgsCOMcB1YBMu0NjubgQSZXKFb+kZ8cNZmi22zLPrYkQtmyicfOx5UKJA/6bB
 OBhjK/ZtRfnbjLfvCRNxk4xuA2AJ++HeSdNDoougkrH8uNVIRSSDfkzowcU+C4XtMmX1
 oU4A==
X-Gm-Message-State: APjAAAXmYwZ1e1A+gtfKjCPQJxxet/xEWeoFGMwxGEXU+NkE53HiMwfv
 CKBWaGWjzzl7/NYdKyloId/s3FVXTIwhWKqCsi23nJYyhtSv4FojFjb76Tm0oIPIoqmNS9focHJ
 tiUQono4YBKbFsfU=
X-Received: by 2002:a05:600c:108a:: with SMTP id
 e10mr9261784wmd.38.1576195383339; 
 Thu, 12 Dec 2019 16:03:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCtHEJKGJZTBLoJCuNBiTzmx/JGsT5klBGAQoaBmCSQWD2p0NzzcEMaaFQgQXkSHv1/f70HA==
X-Received: by 2002:a05:600c:108a:: with SMTP id
 e10mr9261764wmd.38.1576195383015; 
 Thu, 12 Dec 2019 16:03:03 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id k13sm8074902wrx.59.2019.12.12.16.03.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2019 16:03:02 -0800 (PST)
Subject: Re: [PATCH 03/10] arm: allwinner-h3: add Clock Control Unit
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-4-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7465e284-b8d8-db2b-f59b-4385ed06919b@redhat.com>
Date: Fri, 13 Dec 2019 01:03:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191202210947.3603-4-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: v9XmeSpBOcyLsxT4dJnkvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/2/19 10:09 PM, Niek Linnenbank wrote:
> The Clock Control Unit is responsible for clock signal generation,
> configuration and distribution in the Allwinner H3 System on Chip.
> This commit adds support for the Clock Control Unit which emulates
> a simple read/write register interface.
> 
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>   hw/arm/allwinner-h3.c              |  11 ++
>   hw/misc/Makefile.objs              |   1 +
>   hw/misc/allwinner-h3-clk.c         | 227 +++++++++++++++++++++++++++++
>   include/hw/arm/allwinner-h3.h      |   2 +
>   include/hw/misc/allwinner-h3-clk.h |  41 ++++++
>   5 files changed, 282 insertions(+)
>   create mode 100644 hw/misc/allwinner-h3-clk.c
>   create mode 100644 include/hw/misc/allwinner-h3-clk.h
> 
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index 470fdfebef..5566e979ec 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -37,6 +37,9 @@ static void aw_h3_init(Object *obj)
>   
>       sysbus_init_child_obj(obj, "timer", &s->timer, sizeof(s->timer),
>                             TYPE_AW_A10_PIT);
> +
> +    sysbus_init_child_obj(obj, "ccu", &s->ccu, sizeof(s->ccu),
> +                          TYPE_AW_H3_CLK);
>   }
>   
>   static void aw_h3_realize(DeviceState *dev, Error **errp)
> @@ -172,6 +175,14 @@ static void aw_h3_realize(DeviceState *dev, Error **errp)
>       memory_region_add_subregion(get_system_memory(), AW_H3_SRAM_C_BASE,
>                                   &s->sram_c);
>   
> +    /* Clock Control Unit */
> +    object_property_set_bool(OBJECT(&s->ccu), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, AW_H3_CCU_BASE);
> +
>       /* UART */
>       if (serial_hd(0)) {
>           serial_mm_init(get_system_memory(), AW_H3_UART0_REG_BASE, 2,
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index ba898a5781..200ed44ce1 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -28,6 +28,7 @@ common-obj-$(CONFIG_MACIO) += macio/
>   
>   common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
>   
> +common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-clk.o
>   common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
>   common-obj-$(CONFIG_NSERIES) += cbus.o
>   common-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
> diff --git a/hw/misc/allwinner-h3-clk.c b/hw/misc/allwinner-h3-clk.c
> new file mode 100644
> index 0000000000..77c55b4f92
> --- /dev/null
> +++ b/hw/misc/allwinner-h3-clk.c
> @@ -0,0 +1,227 @@
> +/*
> + * Allwinner H3 Clock Control Unit emulation
> + *
> + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "hw/misc/allwinner-h3-clk.h"
> +
> +/* CCU register offsets */
> +#define REG_PLL_CPUX             (0x0000) /* PLL CPUX Control */
> +#define REG_PLL_AUDIO            (0x0008) /* PLL Audio Control */
> +#define REG_PLL_VIDEO            (0x0010) /* PLL Video Control */
> +#define REG_PLL_VE               (0x0018) /* PLL VE Control */
> +#define REG_PLL_DDR              (0x0020) /* PLL DDR Control */
> +#define REG_PLL_PERIPH0          (0x0028) /* PLL Peripherals 0 Control */
> +#define REG_PLL_GPU              (0x0038) /* PLL GPU Control */
> +#define REG_PLL_PERIPH1          (0x0044) /* PLL Peripherals 1 Control */
> +#define REG_PLL_DE               (0x0048) /* PLL Display Engine Control */
> +#define REG_CPUX_AXI             (0x0050) /* CPUX/AXI Configuration */
> +#define REG_APB1                 (0x0054) /* ARM Peripheral Bus 1 Config */
> +#define REG_APB2                 (0x0058) /* ARM Peripheral Bus 2 Config */
> +#define REG_MBUS                 (0x00FC) /* MBUS Reset */
> +#define REG_PLL_TIME0            (0x0200) /* PLL Stable Time 0 */
> +#define REG_PLL_TIME1            (0x0204) /* PLL Stable Time 1 */
> +#define REG_PLL_CPUX_BIAS        (0x0220) /* PLL CPUX Bias */
> +#define REG_PLL_AUDIO_BIAS       (0x0224) /* PLL Audio Bias */
> +#define REG_PLL_VIDEO_BIAS       (0x0228) /* PLL Video Bias */
> +#define REG_PLL_VE_BIAS          (0x022C) /* PLL VE Bias */
> +#define REG_PLL_DDR_BIAS         (0x0230) /* PLL DDR Bias */
> +#define REG_PLL_PERIPH0_BIAS     (0x0234) /* PLL Peripherals 0 Bias */
> +#define REG_PLL_GPU_BIAS         (0x023C) /* PLL GPU Bias */
> +#define REG_PLL_PERIPH1_BIAS     (0x0244) /* PLL Peripherals 1 Bias */
> +#define REG_PLL_DE_BIAS          (0x0248) /* PLL Display Engine Bias */
> +#define REG_PLL_CPUX_TUNING      (0x0250) /* PLL CPUX Tuning */
> +#define REG_PLL_DDR_TUNING       (0x0260) /* PLL DDR Tuning */
> +#define REG_INDEX(offset)        (offset / sizeof(uint32_t))

You might want to have a look at the macros from "hw/registerfields.h".

> +
> +/* CCU register flags */
> +#define REG_PLL_ENABLE           (1 << 31)
> +#define REG_PLL_LOCK             (1 << 28)
> +
> +/* CCU register reset values */
> +#define REG_PLL_CPUX_RST         (0x00001000)
> +#define REG_PLL_AUDIO_RST        (0x00035514)
> +#define REG_PLL_VIDEO_RST        (0x03006207)
> +#define REG_PLL_VE_RST           (0x03006207)
> +#define REG_PLL_DDR_RST          (0x00001000)
> +#define REG_PLL_PERIPH0_RST      (0x00041811)
> +#define REG_PLL_GPU_RST          (0x03006207)
> +#define REG_PLL_PERIPH1_RST      (0x00041811)
> +#define REG_PLL_DE_RST           (0x03006207)
> +#define REG_CPUX_AXI_RST         (0x00010000)
> +#define REG_APB1_RST             (0x00001010)
> +#define REG_APB2_RST             (0x01000000)
> +#define REG_MBUS_RST             (0x80000000)
> +#define REG_PLL_TIME0_RST        (0x000000FF)
> +#define REG_PLL_TIME1_RST        (0x000000FF)
> +#define REG_PLL_CPUX_BIAS_RST    (0x08100200)
> +#define REG_PLL_AUDIO_BIAS_RST   (0x10100000)
> +#define REG_PLL_VIDEO_BIAS_RST   (0x10100000)
> +#define REG_PLL_VE_BIAS_RST      (0x10100000)
> +#define REG_PLL_DDR_BIAS_RST     (0x81104000)
> +#define REG_PLL_PERIPH0_BIAS_RST (0x10100010)
> +#define REG_PLL_GPU_BIAS_RST     (0x10100000)
> +#define REG_PLL_PERIPH1_BIAS_RST (0x10100010)
> +#define REG_PLL_DE_BIAS_RST      (0x10100000)
> +#define REG_PLL_CPUX_TUNING_RST  (0x0A101000)
> +#define REG_PLL_DDR_TUNING_RST   (0x14880000)
> +
> +static uint64_t allwinner_h3_clk_read(void *opaque, hwaddr offset,
> +                                      unsigned size)
> +{
> +    const AwH3ClockState *s = (AwH3ClockState *)opaque;
> +    const uint32_t idx = REG_INDEX(offset);
> +
> +    if (idx >= AW_H3_CLK_REGS_NUM) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read offset 0x%04x\n",
> +                      __func__, (uint32_t)offset);
> +        return 0;
> +    }
> +
> +    return s->regs[idx];
> +}
> +
> +static void allwinner_h3_clk_write(void *opaque, hwaddr offset,
> +                                   uint64_t val, unsigned size)
> +{
> +    AwH3ClockState *s = (AwH3ClockState *)opaque;
> +    const uint32_t idx = REG_INDEX(offset);
> +
> +    if (idx >= AW_H3_CLK_REGS_NUM) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write offset 0x%04x\n",
> +                      __func__, (uint32_t)offset);
> +        return;
> +    }
> +
> +    switch (offset) {
> +    case REG_PLL_CPUX:    /* PLL CPUX Control */
> +    case REG_PLL_AUDIO:   /* PLL Audio Control */
> +    case REG_PLL_VIDEO:   /* PLL Video Control */
> +    case REG_PLL_VE:      /* PLL VE Control */
> +    case REG_PLL_DDR:     /* PLL DDR Control */
> +    case REG_PLL_PERIPH0: /* PLL Peripherals 0 Control */
> +    case REG_PLL_GPU:     /* PLL GPU Control */
> +    case REG_PLL_PERIPH1: /* PLL Peripherals 1 Control */
> +    case REG_PLL_DE:      /* PLL Display Engine Control */
> +        if (val & REG_PLL_ENABLE) {
> +            val |= REG_PLL_LOCK;
> +        }
> +        break;
> +    default:

Maybe:

            qemu_log_mask(LOG_UNIMP, ...

> +        break;
> +    }
> +
> +    s->regs[idx] = (uint32_t) val;
> +}
> +
> +static const MemoryRegionOps allwinner_h3_clk_ops = {
> +    .read = allwinner_h3_clk_read,
> +    .write = allwinner_h3_clk_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false
> +    }
> +};
> +
> +static void allwinner_h3_clk_reset(DeviceState *dev)
> +{
> +    AwH3ClockState *s = AW_H3_CLK(dev);
> +
> +    /* Set default values for registers */
> +    s->regs[REG_INDEX(REG_PLL_CPUX)] = REG_PLL_CPUX_RST;
> +    s->regs[REG_INDEX(REG_PLL_AUDIO)] = REG_PLL_AUDIO_RST;
> +    s->regs[REG_INDEX(REG_PLL_VIDEO)] = REG_PLL_VIDEO_RST;
> +    s->regs[REG_INDEX(REG_PLL_VE)] = REG_PLL_VE_RST;
> +    s->regs[REG_INDEX(REG_PLL_DDR)] = REG_PLL_DDR_RST;
> +    s->regs[REG_INDEX(REG_PLL_PERIPH0)] = REG_PLL_PERIPH0_RST;
> +    s->regs[REG_INDEX(REG_PLL_GPU)] = REG_PLL_GPU_RST;
> +    s->regs[REG_INDEX(REG_PLL_PERIPH1)] = REG_PLL_PERIPH1_RST;
> +    s->regs[REG_INDEX(REG_PLL_DE)] = REG_PLL_DE_RST;
> +    s->regs[REG_INDEX(REG_CPUX_AXI)] = REG_CPUX_AXI_RST;
> +    s->regs[REG_INDEX(REG_APB1)] = REG_APB1_RST;
> +    s->regs[REG_INDEX(REG_APB2)] = REG_APB2_RST;
> +    s->regs[REG_INDEX(REG_MBUS)] = REG_MBUS_RST;
> +    s->regs[REG_INDEX(REG_PLL_TIME0)] = REG_PLL_TIME0_RST;
> +    s->regs[REG_INDEX(REG_PLL_TIME1)] = REG_PLL_TIME1_RST;
> +    s->regs[REG_INDEX(REG_PLL_CPUX_BIAS)] = REG_PLL_CPUX_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_AUDIO_BIAS)] = REG_PLL_AUDIO_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_VIDEO_BIAS)] = REG_PLL_VIDEO_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_VE_BIAS)] = REG_PLL_VE_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_DDR_BIAS)] = REG_PLL_DDR_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_PERIPH0_BIAS)] = REG_PLL_PERIPH0_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_GPU_BIAS)] = REG_PLL_GPU_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_PERIPH1_BIAS)] = REG_PLL_PERIPH1_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_DE_BIAS)] = REG_PLL_DE_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_CPUX_TUNING)] = REG_PLL_CPUX_TUNING_RST;
> +    s->regs[REG_INDEX(REG_PLL_DDR_TUNING)] = REG_PLL_DDR_TUNING_RST;
> +}
> +
> +static void allwinner_h3_clk_realize(DeviceState *dev, Error **errp)
> +{
> +}
> +
> +static void allwinner_h3_clk_init(Object *obj)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    AwH3ClockState *s = AW_H3_CLK(obj);
> +
> +    /* Memory mapping */
> +    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_h3_clk_ops, s,
> +                          TYPE_AW_H3_CLK, AW_H3_CLK_REGS_MEM_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static const VMStateDescription allwinner_h3_clk_vmstate = {
> +    .name = TYPE_AW_H3_CLK,

Use plain name, not TYPE_NAME.

> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, AwH3ClockState, AW_H3_CLK_REGS_NUM),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void allwinner_h3_clk_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = allwinner_h3_clk_reset;
> +    dc->realize = allwinner_h3_clk_realize;
> +    dc->vmsd = &allwinner_h3_clk_vmstate;
> +}
> +
> +static const TypeInfo allwinner_h3_clk_info = {
> +    .name          = TYPE_AW_H3_CLK,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_init = allwinner_h3_clk_init,
> +    .instance_size = sizeof(AwH3ClockState),
> +    .class_init    = allwinner_h3_clk_class_init,
> +};
> +
> +static void allwinner_h3_clk_register(void)
> +{
> +    type_register_static(&allwinner_h3_clk_info);
> +}
> +
> +type_init(allwinner_h3_clk_register)
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
> index af368c2254..e596516c5c 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -26,6 +26,7 @@
>   #include "hw/arm/boot.h"
>   #include "hw/timer/allwinner-a10-pit.h"
>   #include "hw/intc/arm_gic.h"
> +#include "hw/misc/allwinner-h3-clk.h"
>   #include "target/arm/cpu.h"
>   
>   #define AW_H3_SRAM_A1_BASE     (0x00000000)
> @@ -109,6 +110,7 @@ typedef struct AwH3State {
>   
>       qemu_irq irq[AW_H3_GIC_NUM_SPI];
>       AwA10PITState timer;
> +    AwH3ClockState ccu;
>       GICState gic;
>       MemoryRegion sram_a1;
>       MemoryRegion sram_a2;
> diff --git a/include/hw/misc/allwinner-h3-clk.h b/include/hw/misc/allwinner-h3-clk.h
> new file mode 100644
> index 0000000000..69ea559db1
> --- /dev/null
> +++ b/include/hw/misc/allwinner-h3-clk.h
> @@ -0,0 +1,41 @@
> +/*
> + * Allwinner H3 Clock Control Unit emulation
> + *
> + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_MISC_ALLWINNER_H3_CLK_H
> +#define HW_MISC_ALLWINNER_H3_CLK_H
> +
> +#include "hw/sysbus.h"
> +
> +#define AW_H3_CLK_REGS_MAX_ADDR (0x304)
> +#define AW_H3_CLK_REGS_NUM      (AW_H3_CLK_REGS_MAX_ADDR / sizeof(uint32_t))
> +#define AW_H3_CLK_REGS_MEM_SIZE (1024)

Move AW_H3_CLK_REGS_MEM_SIZE to source.

> +
> +#define TYPE_AW_H3_CLK    "allwinner-h3-clk"
> +#define AW_H3_CLK(obj)    OBJECT_CHECK(AwH3ClockState, (obj), TYPE_AW_H3_CLK)
> +
> +typedef struct AwH3ClockState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    MemoryRegion iomem;
> +    uint32_t regs[AW_H3_CLK_REGS_NUM];
> +} AwH3ClockState;
> +
> +#endif
> 

Patch looks good.


