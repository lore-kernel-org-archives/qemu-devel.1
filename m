Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DF6C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 22:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B843207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 22:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X85BKA1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B843207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir8fc-0007L1-5T
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 17:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ir8ec-0005W7-48
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 17:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ir8eZ-0005hO-5f
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 17:57:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59789
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ir8eZ-0005h5-1F
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 17:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578956266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gn9Iu6fGxnBgwQmzqtj7cOWHnnGrS5RAUseTtt7bK7c=;
 b=X85BKA1c5onexwNnGZRKTKcvFkpD+ui9oV1hhT4LgOvLSsgr4p4KfKKf5u9hNNFQAHrkGD
 8b3m9pXIp4hhjssMB5/fOetr1GH4Lp8V4x7Suim4zb6KOjRsEqjGJgpJMnZOdStAWM1Zwg
 qpmwVy+0mbvXl9lJ8iGDr/mtS5lCRWA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-YivFne5xP-abDBEBSKYf7g-1; Mon, 13 Jan 2020 17:57:42 -0500
Received: by mail-wm1-f70.google.com with SMTP id t16so2878905wmt.4
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 14:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Gn9Iu6fGxnBgwQmzqtj7cOWHnnGrS5RAUseTtt7bK7c=;
 b=Hjb34kKchtfy7Ps9qxVjLO/HFr7Zjg7O4Vt3PX66uQWRfixAESh9+tgalo53zUH1O7
 vOy20HDFmDSg/ideGHvrVHBA7bW5Adg5yYKXxkmlWQNCVJYU8gdYnDQsy3i5ZTfjcH7s
 FhKzp5aok1/4khcsFXn9r4qTuQt9BaaLMlcq13swGNyVI1wHvAWjMwgQ5Dfxnf2LohYe
 X7tudv6yfxvX39HuhfWYNNQIs0/aADebhg3b41L1dqyAA5a21sPFCGTGWPCIPlD8Im+c
 t8tydDo2a/flFIAD/Z9tnrwJlzZl/Y1buLaKiNcDaTSGBt1SvzAwa6LMsCfx3jwLQ2V2
 97JA==
X-Gm-Message-State: APjAAAXUYqqFzq13g2V0PNBrO1JdLAEz0JZol//PwXaVez1iFQQGg4Ui
 ZinsMm25pCwtDAIkhW6E1y6VcX9OeSkG26Sp6p2hFPKElnjBW1k4d6K+98jnvfHI34x1n6k3Vcz
 JS/w0EWi8kBYfp8Y=
X-Received: by 2002:a5d:4749:: with SMTP id o9mr20629375wrs.242.1578956261086; 
 Mon, 13 Jan 2020 14:57:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxtPxoPeMQ9BvwDym5V6t5H7j8Nvlytq81RcGye+JQlu+RcJtY0m1WlkPc80bOAVwnlYN+WcA==
X-Received: by 2002:a5d:4749:: with SMTP id o9mr20629331wrs.242.1578956260588; 
 Mon, 13 Jan 2020 14:57:40 -0800 (PST)
Received: from [192.168.1.24] (lfbn-mon-1-1519-115.w92-167.abo.wanadoo.fr.
 [92.167.83.115])
 by smtp.gmail.com with ESMTPSA id d8sm16519614wrx.71.2020.01.13.14.57.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2020 14:57:40 -0800 (PST)
Subject: Re: [PATCH v3 12/17] hw/arm/allwinner: add RTC device support
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-13-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cca7b552-ed09-fdc4-e80e-fc172e30e9bf@redhat.com>
Date: Mon, 13 Jan 2020 23:57:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108200020.4745-13-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: YivFne5xP-abDBEBSKYf7g-1
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 9:00 PM, Niek Linnenbank wrote:
> Allwinner System-on-Chips usually contain a Real Time Clock (RTC)
> for non-volatile system date and time keeping. This commit adds a generic
> Allwinner RTC device that supports the RTC devices found in Allwinner SoC
> family sun4i (A10), sun7i (A20) and sun6i and newer (A31, H2+, H3, etc).
> The following RTC functionality and features are implemented:
> 
>   * Year-Month-Day read/write
>   * Hour-Minute-Second read/write
>   * General Purpose storage
> 
> The following boards are extended with the RTC device:
> 
>   * Cubieboard (hw/arm/cubieboard.c)
>   * Orange Pi PC (hw/arm/orangepi.c)
> 
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>   include/hw/arm/allwinner-a10.h |   4 +-
>   include/hw/arm/allwinner-h3.h  |   3 +
>   include/hw/rtc/allwinner-rtc.h | 129 +++++++++++
>   hw/arm/allwinner-a10.c         |   7 +
>   hw/arm/allwinner-h3.c          |   9 +-
>   hw/rtc/allwinner-rtc.c         | 386 +++++++++++++++++++++++++++++++++
>   hw/rtc/Makefile.objs           |   1 +
>   hw/rtc/trace-events            |   4 +
>   8 files changed, 541 insertions(+), 2 deletions(-)
>   create mode 100644 include/hw/rtc/allwinner-rtc.h
>   create mode 100644 hw/rtc/allwinner-rtc.c
> 
> diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
> index 0e8250b244..81a16092e7 100644
> --- a/include/hw/arm/allwinner-a10.h
> +++ b/include/hw/arm/allwinner-a10.h
> @@ -9,6 +9,7 @@
>   #include "hw/net/allwinner_emac.h"
>   #include "hw/sd/allwinner-sdhost.h"
>   #include "hw/ide/ahci.h"
> +#include "hw/rtc/allwinner-rtc.h"
>   
>   #include "target/arm/cpu.h"
>   
> @@ -18,7 +19,7 @@
>   #define AW_A10_UART0_REG_BASE   0x01c28000
>   #define AW_A10_EMAC_BASE        0x01c0b000
>   #define AW_A10_SATA_BASE        0x01c18000
> -
> +#define AW_A10_RTC_BASE         0x01c20d00
>   #define AW_A10_SDRAM_BASE       0x40000000
>   
>   #define TYPE_AW_A10 "allwinner-a10"
> @@ -36,6 +37,7 @@ typedef struct AwA10State {
>       AwEmacState emac;
>       AllwinnerAHCIState sata;
>       AwSdHostState mmc0;
> +    AwRtcState rtc;
>       MemoryRegion sram_a;
>   } AwA10State;
>   
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
> index d1b3d7ca67..1c275a34ed 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -50,6 +50,7 @@
>   #include "hw/misc/allwinner-sid.h"
>   #include "hw/sd/allwinner-sdhost.h"
>   #include "hw/net/allwinner-sun8i-emac.h"
> +#include "hw/rtc/allwinner-rtc.h"
>   #include "target/arm/cpu.h"
>   #include "sysemu/block-backend.h"
>   
> @@ -92,6 +93,7 @@ enum {
>       AW_H3_GIC_CPU,
>       AW_H3_GIC_HYP,
>       AW_H3_GIC_VCPU,
> +    AW_H3_RTC,
>       AW_H3_CPUCFG,
>       AW_H3_SDRAM
>   };
> @@ -130,6 +132,7 @@ typedef struct AwH3State {
>       AwSidState sid;
>       AwSdHostState mmc0;
>       AwSun8iEmacState emac;
> +    AwRtcState rtc;
>       GICState gic;
>       MemoryRegion sram_a1;
>       MemoryRegion sram_a2;
> diff --git a/include/hw/rtc/allwinner-rtc.h b/include/hw/rtc/allwinner-rtc.h
> new file mode 100644
> index 0000000000..e29dfc775f
> --- /dev/null
> +++ b/include/hw/rtc/allwinner-rtc.h
> @@ -0,0 +1,129 @@
> +/*
> + * Allwinner Real Time Clock emulation
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
> +#ifndef HW_MISC_ALLWINNER_RTC_H
> +#define HW_MISC_ALLWINNER_RTC_H
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +#include "hw/sysbus.h"
> +
> +/**
> + * Constants
> + * @{
> + */
> +
> +/** Highest register address used by RTC device */
> +#define AW_RTC_REGS_MAXADDR     (0x1F4)

I'd start using 0x200 here so in case new SoC use registers in this 
block range (or undocumented reg) so we don't have to modify 
allwinner_rtc_vmstate.

> +
> +/** Total number of known registers */
> +#define AW_RTC_REGS_NUM         (AW_RTC_REGS_MAXADDR / sizeof(uint32_t))
> +
> +/** @} */
> +
> +/**
> + * Object model types
> + * @{
> + */
> +
> +/** Generic Allwinner RTC device (abstract) */
> +#define TYPE_AW_RTC          "allwinner-rtc"
> +
> +/** Allwinner RTC sun4i family (A10, A12) */
> +#define TYPE_AW_RTC_SUN4I    TYPE_AW_RTC "-sun4i"
> +
> +/** Allwinner RTC sun6i family and newer (A31, H2+, H3, etc) */
> +#define TYPE_AW_RTC_SUN6I    TYPE_AW_RTC "-sun6i"
> +
> +/** Allwinner RTC sun7i family (A20) */
> +#define TYPE_AW_RTC_SUN7I    TYPE_AW_RTC "-sun7i"
> +
> +/** @} */
> +
> +/**
> + * Object model macros
> + * @{
> + */
> +
> +#define AW_RTC(obj) \
> +    OBJECT_CHECK(AwRtcState, (obj), TYPE_AW_RTC)
> +#define AW_RTC_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(AwRtcClass, (klass), TYPE_AW_RTC)
> +#define AW_RTC_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(AwRtcClass, (obj), TYPE_AW_RTC)
> +
> +/** @} */
> +
> +/**
> + * Allwinner RTC per-object instance state.
> + */
> +typedef struct AwRtcState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    /** Maps I/O registers in physical memory */
> +    MemoryRegion iomem;
> +
> +    /** Array of hardware registers */
> +    uint32_t regs[AW_RTC_REGS_NUM];
> +
> +} AwRtcState;
> +
> +/**
> + * Allwinner RTC class-level struct.
> + *
> + * This struct is filled by each sunxi device specific code
> + * such that the generic code can use this struct to support
> + * all devices.
> + */
> +typedef struct AwRtcClass {
> +    /*< private >*/
> +    SysBusDeviceClass parent_class;
> +    /*< public >*/
> +
> +    /** Defines device specific register map */
> +    const uint8_t *regmap;
> +
> +    /** Number of entries in regmap */
> +    size_t regmap_size;

I'd rather call this 'regmap_count'.
If you don't use this field, can we remove it?

> +
> +    /** Device offset in years to 1900, for struct tm.tm_year */
> +    uint8_t year_offset;

struct tm uses 'int' for this field.

> +
> +    /**
> +     * Read device specific register
> +     *
> +     * @offset: register offset to read
> +     * @return true if register read successful, false otherwise
> +     */
> +    bool (*read)(AwRtcState *s, uint32_t offset);
> +
> +    /**
> +     * Write device specific register
> +     *
> +     * @offset: register offset to write
> +     * @data: value to set in register
> +     * @return true if register write successful, false otherwise
> +     */
> +    bool (*write)(AwRtcState *s, uint32_t offset, uint32_t data);
> +
> +} AwRtcClass;
> +
> +#endif /* HW_MISC_ALLWINNER_RTC_H */
> diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
> index 61cf3550a6..3f8f9d0d19 100644
> --- a/hw/arm/allwinner-a10.c
> +++ b/hw/arm/allwinner-a10.c
> @@ -46,6 +46,9 @@ static void aw_a10_init(Object *obj)
>   
>       sysbus_init_child_obj(obj, "mmc0", &s->mmc0, sizeof(s->mmc0),
>                             TYPE_AW_SDHOST_SUN4I);
> +
> +    sysbus_init_child_obj(obj, "rtc", &s->rtc, sizeof(s->rtc),
> +                          TYPE_AW_RTC_SUN4I);
>   }
>   
>   static void aw_a10_realize(DeviceState *dev, Error **errp)
> @@ -128,6 +131,10 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0, s->irq[32]);
>       object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->mmc0),
>                                 "sd-bus", &error_abort);
> +
> +    /* RTC */
> +    qdev_init_nofail(DEVICE(&s->rtc));
> +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->rtc), 0, AW_A10_RTC_BASE, 10);
>   }
>   
>   static void aw_a10_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index 77b823e7d8..caa4d8b196 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -61,6 +61,7 @@ const hwaddr allwinner_h3_memmap[] = {
>       [AW_H3_GIC_CPU]    = 0x01c82000,
>       [AW_H3_GIC_HYP]    = 0x01c84000,
>       [AW_H3_GIC_VCPU]   = 0x01c86000,
> +    [AW_H3_RTC]        = 0x01f00000,
>       [AW_H3_CPUCFG]     = 0x01f01c00,
>       [AW_H3_SDRAM]      = 0x40000000
>   };
> @@ -116,7 +117,6 @@ struct AwH3Unimplemented {
>       { "csi",       0x01cb0000, 320 * KiB },
>       { "tve",       0x01e00000, 64 * KiB },
>       { "hdmi",      0x01ee0000, 128 * KiB },
> -    { "rtc",       0x01f00000, 1 * KiB },
>       { "r_timer",   0x01f00800, 1 * KiB },
>       { "r_intc",    0x01f00c00, 1 * KiB },
>       { "r_wdog",    0x01f01000, 1 * KiB },
> @@ -244,6 +244,9 @@ static void allwinner_h3_init(Object *obj)
>                                "ram-addr", &error_abort);
>       object_property_add_alias(obj, "ram-size", OBJECT(&s->dramc),
>                                 "ram-size", &error_abort);
> +
> +    sysbus_init_child_obj(obj, "rtc", &s->rtc, sizeof(s->rtc),
> +                          TYPE_AW_RTC_SUN6I);
>   }
>   
>   static void allwinner_h3_realize(DeviceState *dev, Error **errp)
> @@ -437,6 +440,10 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 1, s->memmap[AW_H3_DRAMCTL]);
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 2, s->memmap[AW_H3_DRAMPHY]);
>   
> +    /* RTC */
> +    qdev_init_nofail(DEVICE(&s->rtc));
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, s->memmap[AW_H3_RTC]);
> +
>       /* Unimplemented devices */
>       for (int i = 0; i < ARRAY_SIZE(unimplemented); i++) {
>           create_unimplemented_device(unimplemented[i].device_name,
> diff --git a/hw/rtc/allwinner-rtc.c b/hw/rtc/allwinner-rtc.c
> new file mode 100644
> index 0000000000..812fe7f10b
> --- /dev/null
> +++ b/hw/rtc/allwinner-rtc.c
> @@ -0,0 +1,386 @@
> +/*
> + * Allwinner Real Time Clock emulation
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
> +#include "qemu/units.h"
> +#include "hw/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu-common.h"
> +#include "hw/rtc/allwinner-rtc.h"
> +#include "trace.h"
> +
> +/* RTC registers */
> +enum {
> +    REG_LOSC = 1,        /* Low Oscillator Control */
> +    REG_YYMMDD,          /* RTC Year-Month-Day */
> +    REG_HHMMSS,          /* RTC Hour-Minute-Second */
> +    REG_ALARM1_WKHHMMSS, /* Alarm1 Week Hour-Minute-Second */
> +    REG_ALARM1_EN,       /* Alarm1 Enable */
> +    REG_ALARM1_IRQ_EN,   /* Alarm1 IRQ Enable */
> +    REG_ALARM1_IRQ_STA,  /* Alarm1 IRQ Status */
> +    REG_GP0,             /* General Purpose Register 0 */
> +    REG_GP1,             /* General Purpose Register 1 */
> +    REG_GP2,             /* General Purpose Register 2 */
> +    REG_GP3,             /* General Purpose Register 3 */
> +
> +    /* sun4i registers */
> +    REG_ALARM1_DDHHMMSS, /* Alarm1 Day Hour-Minute-Second */
> +    REG_CPUCFG,          /* CPU Configuration Register */
> +
> +    /* sun6i registers */
> +    REG_LOSC_AUTOSTA,    /* LOSC Auto Switch Status */
> +    REG_INT_OSC_PRE,     /* Internal OSC Clock Prescaler */
> +    REG_ALARM0_COUNTER,  /* Alarm0 Counter */
> +    REG_ALARM0_CUR_VLU,  /* Alarm0 Counter Current Value */
> +    REG_ALARM0_ENABLE,   /* Alarm0 Enable */
> +    REG_ALARM0_IRQ_EN,   /* Alarm0 IRQ Enable */
> +    REG_ALARM0_IRQ_STA,  /* Alarm0 IRQ Status */
> +    REG_ALARM_CONFIG,    /* Alarm Config */
> +    REG_LOSC_OUT_GATING, /* LOSC Output Gating Register */
> +    REG_GP4,             /* General Purpose Register 4 */
> +    REG_GP5,             /* General Purpose Register 5 */
> +    REG_GP6,             /* General Purpose Register 6 */
> +    REG_GP7,             /* General Purpose Register 7 */
> +    REG_RTC_DBG,         /* RTC Debug Register */
> +    REG_GPL_HOLD_OUT,    /* GPL Hold Output Register */
> +    REG_VDD_RTC,         /* VDD RTC Regulate Register */
> +    REG_IC_CHARA,        /* IC Characteristics Register */
> +};
> +
> +/* RTC register flags */
> +enum {
> +    REG_LOSC_YMD   = (1 << 7),
> +    REG_LOSC_HMS   = (1 << 8),
> +};
> +
> +/* RTC sun4i register map (offset to name) */
> +const uint8_t allwinner_rtc_sun4i_regmap[] = {
> +    [0x0000] = REG_LOSC,
> +    [0x0004] = REG_YYMMDD,
> +    [0x0008] = REG_HHMMSS,
> +    [0x000C] = REG_ALARM1_DDHHMMSS,
> +    [0x0010] = REG_ALARM1_WKHHMMSS,
> +    [0x0014] = REG_ALARM1_EN,
> +    [0x0018] = REG_ALARM1_IRQ_EN,
> +    [0x001C] = REG_ALARM1_IRQ_STA,
> +    [0x0020] = REG_GP0,
> +    [0x0024] = REG_GP1,
> +    [0x0028] = REG_GP2,
> +    [0x002C] = REG_GP3,
> +    [0x003C] = REG_CPUCFG,
> +};
> +
> +/* RTC sun6i register map (offset to name) */
> +const uint8_t allwinner_rtc_sun6i_regmap[] = {
> +    [0x0000] = REG_LOSC,
> +    [0x0004] = REG_LOSC_AUTOSTA,
> +    [0x0008] = REG_INT_OSC_PRE,
> +    [0x0010] = REG_YYMMDD,
> +    [0x0014] = REG_HHMMSS,
> +    [0x0020] = REG_ALARM0_COUNTER,
> +    [0x0024] = REG_ALARM0_CUR_VLU,
> +    [0x0028] = REG_ALARM0_ENABLE,
> +    [0x002C] = REG_ALARM0_IRQ_EN,
> +    [0x0030] = REG_ALARM0_IRQ_STA,
> +    [0x0040] = REG_ALARM1_WKHHMMSS,
> +    [0x0044] = REG_ALARM1_EN,
> +    [0x0048] = REG_ALARM1_IRQ_EN,
> +    [0x004C] = REG_ALARM1_IRQ_STA,
> +    [0x0050] = REG_ALARM_CONFIG,
> +    [0x0060] = REG_LOSC_OUT_GATING,
> +    [0x0100] = REG_GP0,
> +    [0x0104] = REG_GP1,
> +    [0x0108] = REG_GP2,
> +    [0x010C] = REG_GP3,
> +    [0x0110] = REG_GP4,
> +    [0x0114] = REG_GP5,
> +    [0x0118] = REG_GP6,
> +    [0x011C] = REG_GP7,
> +    [0x0170] = REG_RTC_DBG,
> +    [0x0180] = REG_GPL_HOLD_OUT,
> +    [0x0190] = REG_VDD_RTC,
> +    [0x01F0] = REG_IC_CHARA,
> +};
> +
> +static bool allwinner_rtc_sun4i_read(AwRtcState *s, uint32_t offset)
> +{
> +    /* no sun4i specific registers currently implemented */
> +    return false;
> +}
> +
> +static bool allwinner_rtc_sun4i_write(AwRtcState *s, uint32_t offset,
> +                                      uint32_t data)
> +{
> +    /* no sun4i specific registers currently implemented */
> +    return false;
> +}
> +
> +static bool allwinner_rtc_sun6i_read(AwRtcState *s, uint32_t offset)
> +{
> +    const AwRtcClass *c = AW_RTC_GET_CLASS(s);
> +
> +    switch (c->regmap[offset]) {
> +    case REG_GP4:             /* General Purpose Register 4 */
> +    case REG_GP5:             /* General Purpose Register 5 */
> +    case REG_GP6:             /* General Purpose Register 6 */
> +    case REG_GP7:             /* General Purpose Register 7 */
> +        return true;
> +    default:
> +        break;
> +    }
> +    return false;
> +}
> +
> +static bool allwinner_rtc_sun6i_write(AwRtcState *s, uint32_t offset,
> +                                      uint32_t data)
> +{
> +    const AwRtcClass *c = AW_RTC_GET_CLASS(s);
> +
> +    switch (c->regmap[offset]) {
> +    case REG_GP4:             /* General Purpose Register 4 */
> +    case REG_GP5:             /* General Purpose Register 5 */
> +    case REG_GP6:             /* General Purpose Register 6 */
> +    case REG_GP7:             /* General Purpose Register 7 */
> +        return true;
> +    default:
> +        break;
> +    }
> +    return false;
> +}
> +
> +static uint64_t allwinner_rtc_read(void *opaque, hwaddr offset,
> +                                   unsigned size)
> +{
> +    AwRtcState *s = AW_RTC(opaque);
> +    const AwRtcClass *c = AW_RTC_GET_CLASS(s);
> +    uint64_t val = 0;
> +
> +    if (offset >= AW_RTC_REGS_MAXADDR) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
> +                      __func__, (uint32_t)offset);
> +        return 0;
> +    }
> +
> +    if (!c->regmap[offset]) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid register 0x%04x\n",
> +                          __func__, (uint32_t)offset);
> +        return 0;
> +    }
> +
> +    switch (c->regmap[offset]) {
> +    case REG_LOSC:       /* Low Oscillator Control */
> +        val = s->regs[REG_LOSC];
> +        s->regs[REG_LOSC] &= ~(REG_LOSC_YMD | REG_LOSC_HMS);
> +        break;
> +    case REG_YYMMDD:     /* RTC Year-Month-Day */
> +    case REG_HHMMSS:     /* RTC Hour-Minute-Second */
> +    case REG_GP0:        /* General Purpose Register 0 */
> +    case REG_GP1:        /* General Purpose Register 1 */
> +    case REG_GP2:        /* General Purpose Register 2 */
> +    case REG_GP3:        /* General Purpose Register 3 */
> +        val = s->regs[c->regmap[offset]];
> +        break;
> +    default:
> +        if (!c->read(s, offset)) {
> +            qemu_log_mask(LOG_UNIMP, "%s: unimplemented register 0x%04x\n",
> +                          __func__, (uint32_t)offset);
> +        }
> +        val = s->regs[c->regmap[offset]];
> +        break;
> +    }
> +
> +    trace_allwinner_rtc_read(offset, val);
> +    return val;
> +}
> +
> +static void allwinner_rtc_write(void *opaque, hwaddr offset,
> +                                uint64_t val, unsigned size)
> +{
> +    AwRtcState *s = AW_RTC(opaque);
> +    const AwRtcClass *c = AW_RTC_GET_CLASS(s);
> +
> +    if (offset >= AW_RTC_REGS_MAXADDR) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
> +                      __func__, (uint32_t)offset);
> +        return;
> +    }
> +
> +    if (!c->regmap[offset]) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid register 0x%04x\n",
> +                          __func__, (uint32_t)offset);
> +        return;
> +    }
> +
> +    trace_allwinner_rtc_write(offset, val);
> +
> +    switch (c->regmap[offset]) {
> +    case REG_YYMMDD:     /* RTC Year-Month-Day */
> +        s->regs[REG_YYMMDD] = val;
> +        s->regs[REG_LOSC]  |= REG_LOSC_YMD;
> +        break;
> +    case REG_HHMMSS:     /* RTC Hour-Minute-Second */
> +        s->regs[REG_HHMMSS] = val;
> +        s->regs[REG_LOSC]  |= REG_LOSC_HMS;
> +        break;
> +    case REG_GP0:        /* General Purpose Register 0 */
> +    case REG_GP1:        /* General Purpose Register 1 */
> +    case REG_GP2:        /* General Purpose Register 2 */
> +    case REG_GP3:        /* General Purpose Register 3 */
> +        s->regs[c->regmap[offset]] = val;
> +        break;
> +    default:
> +        if (!c->write(s, offset, val)) {
> +            qemu_log_mask(LOG_UNIMP, "%s: unimplemented register 0x%04x\n",
> +                          __func__, (uint32_t)offset);
> +        }
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps allwinner_rtc_ops = {
> +    .read = allwinner_rtc_read,
> +    .write = allwinner_rtc_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +    .impl.min_access_size = 4,
> +};
> +
> +static void allwinner_rtc_reset(DeviceState *dev)
> +{
> +    AwRtcState *s = AW_RTC(dev);
> +    const AwRtcClass *c = AW_RTC_GET_CLASS(dev);
> +    struct tm now;
> +
> +    /* Clear registers */
> +    memset(s->regs, 0, sizeof(s->regs));
> +
> +    /* Get current datetime */
> +    qemu_get_timedate(&now, 0);
> +
> +    /* Set RTC with current datetime */
> +    s->regs[REG_YYMMDD] =  ((now.tm_year - c->year_offset) << 16) |
> +                           ((now.tm_mon + 1) << 8) |
> +                             now.tm_mday;
> +    s->regs[REG_HHMMSS] = (((now.tm_wday + 6) % 7) << 29) |
> +                              (now.tm_hour << 16) |
> +                              (now.tm_min << 8) |
> +                               now.tm_sec;

This doesn't look correct.

 From H3 Datasheet (Rev1.2):
   4.8.3.4. RTC YY-MM-DD Register (Default Value: 0x00000000)
   4.8.3.5. RTC HH-MM-SS Register (Default Value: 0x00000000)

I'm not sure what is the proper to model this, maybe set this value in 
init()? If we suspend a machine, migrate it, and resume it, what RTC are 
we expecting?

Rest of the patch looks good.

> +}
> +
> +static void allwinner_rtc_init(Object *obj)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    AwRtcState *s = AW_RTC(obj);
> +
> +    /* Memory mapping */
> +    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_rtc_ops, s,
> +                          TYPE_AW_RTC, 1 * KiB);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static const VMStateDescription allwinner_rtc_vmstate = {
> +    .name = "allwinner-rtc",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, AwRtcState, AW_RTC_REGS_NUM),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void allwinner_rtc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = allwinner_rtc_reset;
> +    dc->vmsd = &allwinner_rtc_vmstate;
> +}
> +
> +static void allwinner_rtc_sun4i_class_init(ObjectClass *klass, void *data)
> +{
> +    AwRtcClass *arc = AW_RTC_CLASS(klass);
> +
> +    arc->regmap = allwinner_rtc_sun4i_regmap;
> +    arc->regmap_size = ARRAY_SIZE(allwinner_rtc_sun4i_regmap);
> +    arc->year_offset = 110;
> +    arc->read = allwinner_rtc_sun4i_read;
> +    arc->write = allwinner_rtc_sun4i_write;
> +}
> +
> +static void allwinner_rtc_sun6i_class_init(ObjectClass *klass, void *data)
> +{
> +    AwRtcClass *arc = AW_RTC_CLASS(klass);
> +
> +    arc->regmap = allwinner_rtc_sun6i_regmap;
> +    arc->regmap_size = ARRAY_SIZE(allwinner_rtc_sun6i_regmap);
> +    arc->year_offset = 70;
> +    arc->read = allwinner_rtc_sun6i_read;
> +    arc->write = allwinner_rtc_sun6i_write;
> +}
> +
> +static void allwinner_rtc_sun7i_class_init(ObjectClass *klass, void *data)
> +{
> +    AwRtcClass *arc = AW_RTC_CLASS(klass);
> +
> +    allwinner_rtc_sun4i_class_init(klass, arc);
> +    arc->year_offset = 70;
> +}
> +
> +static const TypeInfo allwinner_rtc_info = {
> +    .name          = TYPE_AW_RTC,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_init = allwinner_rtc_init,
> +    .instance_size = sizeof(AwRtcState),
> +    .class_init    = allwinner_rtc_class_init,
> +    .class_size    = sizeof(AwRtcClass),
> +    .abstract      = true,
> +};
> +
> +static const TypeInfo allwinner_rtc_sun4i_info = {
> +    .name          = TYPE_AW_RTC_SUN4I,
> +    .parent        = TYPE_AW_RTC,
> +    .class_init    = allwinner_rtc_sun4i_class_init,
> +};
> +
> +static const TypeInfo allwinner_rtc_sun6i_info = {
> +    .name          = TYPE_AW_RTC_SUN6I,
> +    .parent        = TYPE_AW_RTC,
> +    .class_init    = allwinner_rtc_sun6i_class_init,
> +};
> +
> +static const TypeInfo allwinner_rtc_sun7i_info = {
> +    .name          = TYPE_AW_RTC_SUN7I,
> +    .parent        = TYPE_AW_RTC,
> +    .class_init    = allwinner_rtc_sun7i_class_init,
> +};
> +
> +static void allwinner_rtc_register(void)
> +{
> +    type_register_static(&allwinner_rtc_info);
> +    type_register_static(&allwinner_rtc_sun4i_info);
> +    type_register_static(&allwinner_rtc_sun6i_info);
> +    type_register_static(&allwinner_rtc_sun7i_info);
> +}
> +
> +type_init(allwinner_rtc_register)
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 8dc9fcd3a9..12d92feebf 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -11,3 +11,4 @@ common-obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
>   obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
>   common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
>   common-obj-$(CONFIG_ASPEED_SOC) += aspeed_rtc.o
> +common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-rtc.o
> diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
> index d6749f4616..eb57de3bd6 100644
> --- a/hw/rtc/trace-events
> +++ b/hw/rtc/trace-events
> @@ -1,5 +1,9 @@
>   # See docs/devel/tracing.txt for syntax documentation.
>   
> +# allwinner-rtc.c
> +allwinner_rtc_read(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
> +allwinner_rtc_write(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
> +
>   # sun4v-rtc.c
>   sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 " value 0x%" PRIx64
>   sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 " value 0x%" PRIx64
> 


