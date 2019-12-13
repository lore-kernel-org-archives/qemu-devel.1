Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE186C00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98D02073B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bslzZ8WJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98D02073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifYXN-0003Wx-RC
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 19:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifYWg-00030w-E4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 19:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifYWe-0007Fk-4p
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 19:09:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51104
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifYWd-0007DB-Uz
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 19:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576195782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PcjcNVS9ZiBh6x4p+XIweK4+ijawmCzEkyUTPVZLO1A=;
 b=bslzZ8WJ7dz6YYPgSnVzJjGX24b3zCqD41Aj71hpgm0a0Uo2S31LKTEukIOEMpZmAbI+6L
 w2GAF1J7hkgbI1lOYaOLu1BFZO6tYDi2444WUJ4XHt9qSEiy5QsOgHpAz57x/9m/eIfxmq
 QB72esqHLtGCGrjuAFiw7rnuZ5l8Ucs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-H1GB269sNEynsXggkAmkSQ-1; Thu, 12 Dec 2019 19:09:41 -0500
Received: by mail-wm1-f71.google.com with SMTP id q21so1436643wmc.7
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:09:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PcjcNVS9ZiBh6x4p+XIweK4+ijawmCzEkyUTPVZLO1A=;
 b=bAK3fQCZJFj5Y8YuXEOHuQDyStNq8r7Qr3Ar1ZGkZejSXhSqff/vG4K3ariQoZIMDN
 GYi68TrzPLiXKhH9fFAkqG2Oo8LlXVGGUiL7T3xtXfVhoNIM7zjTqGS1WGQkMPnTSh+n
 WJCTL91S8f+2AcifjA/Zu16q2hck2zZdl34t7siATxgVdb+fP6JhMaedPoRYoRuPFbJx
 ZaPRArvT64HfJPzb78BopZBEgaaqq45eezo61ffy1WTnWrGyg3rIVpLwkNo1gJf9cL0X
 M8flu9qodgbEMAE6s0rj52URKg0wmKclQCmqKftiYbkEPakNeJt/WP8wzLKbfJhCHyzK
 WGZg==
X-Gm-Message-State: APjAAAXtjoM0fL14m5vE71kT1+Kl1vnPmPRK7s0pnLT9PPJPJ9SbSrgA
 ztNPM2ZD9nrkwJSe80OHzKCkPdjco9sx5mNhhs42qcrDgvbfI6Vp/ufoZOxeZgkK4hasV64dA+p
 Uf+1y4YGHPeSVWvQ=
X-Received: by 2002:a05:600c:24b:: with SMTP id
 11mr9621018wmj.19.1576195779960; 
 Thu, 12 Dec 2019 16:09:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3bwsbp9ICSHCWan+IaghqeKC+bUxfNnO3oddaF6sMqZbKRMoHgAKFGe92ZJ1Byeu4AoXNXA==
X-Received: by 2002:a05:600c:24b:: with SMTP id
 11mr9620994wmj.19.1576195779650; 
 Thu, 12 Dec 2019 16:09:39 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id n16sm7941308wro.88.2019.12.12.16.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2019 16:09:39 -0800 (PST)
Subject: Re: [PATCH 05/10] arm: allwinner-h3: add System Control module
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-6-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <949aec5f-fd92-9fb2-25f4-803cd1bbf601@redhat.com>
Date: Fri, 13 Dec 2019 01:09:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191202210947.3603-6-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: H1GB269sNEynsXggkAmkSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
> The Allwinner H3 System on Chip has an System Control
> module that provides system wide generic controls and
> device information. This commit adds support for the
> Allwinner H3 System Control module.
> 
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>   hw/arm/allwinner-h3.c                 |  11 ++
>   hw/misc/Makefile.objs                 |   1 +
>   hw/misc/allwinner-h3-syscon.c         | 139 ++++++++++++++++++++++++++
>   include/hw/arm/allwinner-h3.h         |   2 +
>   include/hw/misc/allwinner-h3-syscon.h |  43 ++++++++
>   5 files changed, 196 insertions(+)
>   create mode 100644 hw/misc/allwinner-h3-syscon.c
>   create mode 100644 include/hw/misc/allwinner-h3-syscon.h
> 
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index afeb49c0ac..ebd8fde412 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -41,6 +41,9 @@ static void aw_h3_init(Object *obj)
>   
>       sysbus_init_child_obj(obj, "ccu", &s->ccu, sizeof(s->ccu),
>                             TYPE_AW_H3_CLK);
> +
> +    sysbus_init_child_obj(obj, "syscon", &s->syscon, sizeof(s->syscon),
> +                          TYPE_AW_H3_SYSCON);
>   }
>   
>   static void aw_h3_realize(DeviceState *dev, Error **errp)
> @@ -184,6 +187,14 @@ static void aw_h3_realize(DeviceState *dev, Error **errp)
>       }
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, AW_H3_CCU_BASE);
>   
> +    /* System Control */
> +    object_property_set_bool(OBJECT(&s->syscon), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->syscon), 0, AW_H3_SYSCON_BASE);
> +
>       /* Universal Serial Bus */
>       sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_BASE,
>                            s->irq[AW_H3_GIC_SPI_EHCI0]);
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 200ed44ce1..b234aefba5 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -29,6 +29,7 @@ common-obj-$(CONFIG_MACIO) += macio/
>   common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
>   
>   common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-clk.o
> +common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-syscon.o
>   common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
>   common-obj-$(CONFIG_NSERIES) += cbus.o
>   common-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
> diff --git a/hw/misc/allwinner-h3-syscon.c b/hw/misc/allwinner-h3-syscon.c
> new file mode 100644
> index 0000000000..66bd518a05
> --- /dev/null
> +++ b/hw/misc/allwinner-h3-syscon.c
> @@ -0,0 +1,139 @@
> +/*
> + * Allwinner H3 System Control emulation
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
> +#include "hw/misc/allwinner-h3-syscon.h"
> +
> +/* SYSCON register offsets */
> +#define REG_VER                 (0x24)  /* Version */
> +#define REG_EMAC_PHY_CLK        (0x30)  /* EMAC PHY Clock */
> +#define REG_INDEX(offset)       (offset / sizeof(uint32_t))
> +
> +/* SYSCON register reset values */
> +#define REG_VER_RST             (0x0)
> +#define REG_EMAC_PHY_CLK_RST    (0x58000)
> +
> +static uint64_t allwinner_h3_syscon_read(void *opaque, hwaddr offset,
> +                                         unsigned size)
> +{
> +    const AwH3SysconState *s = (AwH3SysconState *)opaque;
> +    const uint32_t idx = REG_INDEX(offset);
> +
> +    if (idx >= AW_H3_SYSCON_REGS_NUM) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read offset 0x%04x\n",
> +                      __func__, (uint32_t)offset);
> +        return 0;
> +    }
> +
> +    return s->regs[idx];
> +}
> +
> +static void allwinner_h3_syscon_write(void *opaque, hwaddr offset,
> +                                      uint64_t val, unsigned size)
> +{
> +    AwH3SysconState *s = (AwH3SysconState *)opaque;
> +    const uint32_t idx = REG_INDEX(offset);
> +
> +    if (idx >= AW_H3_SYSCON_REGS_NUM) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write offset 0x%04x\n",
> +                      __func__, (uint32_t)offset);
> +        return;
> +    }
> +
> +    switch (offset) {
> +    case REG_VER:       /* Version */
> +        break;
> +    default:
> +        s->regs[idx] = (uint32_t) val;
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps allwinner_h3_syscon_ops = {
> +    .read = allwinner_h3_syscon_read,
> +    .write = allwinner_h3_syscon_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,

Can you point me to the datasheet page that says this region is 
restricted to 32-bit accesses? Maybe you want .valid -> .impl instead?

> +        .unaligned = false
> +    }
> +};
> +
> +static void allwinner_h3_syscon_reset(DeviceState *dev)
> +{
> +    AwH3SysconState *s = AW_H3_SYSCON(dev);
> +
> +    /* Set default values for registers */
> +    s->regs[REG_INDEX(REG_VER)] = REG_VER_RST;
> +    s->regs[REG_INDEX(REG_EMAC_PHY_CLK)] = REG_EMAC_PHY_CLK_RST;
> +}
> +
> +static void allwinner_h3_syscon_realize(DeviceState *dev, Error **errp)
> +{
> +}
> +
> +static void allwinner_h3_syscon_init(Object *obj)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    AwH3SysconState *s = AW_H3_SYSCON(obj);
> +
> +    /* Memory mapping */
> +    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_h3_syscon_ops, s,
> +                          TYPE_AW_H3_SYSCON, AW_H3_SYSCON_REGS_MEM_SIZE);

This definition isn't very helpful IMO, I'd use the value in place: '4 * 
KiB'.

> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static const VMStateDescription allwinner_h3_syscon_vmstate = {
> +    .name = TYPE_AW_H3_SYSCON,

Plain name.

> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, AwH3SysconState, AW_H3_SYSCON_REGS_NUM),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void allwinner_h3_syscon_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = allwinner_h3_syscon_reset;
> +    dc->realize = allwinner_h3_syscon_realize;
> +    dc->vmsd = &allwinner_h3_syscon_vmstate;
> +}
> +
> +static const TypeInfo allwinner_h3_syscon_info = {
> +    .name          = TYPE_AW_H3_SYSCON,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_init = allwinner_h3_syscon_init,
> +    .instance_size = sizeof(AwH3SysconState),
> +    .class_init    = allwinner_h3_syscon_class_init,
> +};
> +
> +static void allwinner_h3_syscon_register(void)
> +{
> +    type_register_static(&allwinner_h3_syscon_info);
> +}
> +
> +type_init(allwinner_h3_syscon_register)
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
> index e596516c5c..2bc526b77b 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -27,6 +27,7 @@
>   #include "hw/timer/allwinner-a10-pit.h"
>   #include "hw/intc/arm_gic.h"
>   #include "hw/misc/allwinner-h3-clk.h"
> +#include "hw/misc/allwinner-h3-syscon.h"
>   #include "target/arm/cpu.h"
>   
>   #define AW_H3_SRAM_A1_BASE     (0x00000000)
> @@ -111,6 +112,7 @@ typedef struct AwH3State {
>       qemu_irq irq[AW_H3_GIC_NUM_SPI];
>       AwA10PITState timer;
>       AwH3ClockState ccu;
> +    AwH3SysconState syscon;
>       GICState gic;
>       MemoryRegion sram_a1;
>       MemoryRegion sram_a2;
> diff --git a/include/hw/misc/allwinner-h3-syscon.h b/include/hw/misc/allwinner-h3-syscon.h
> new file mode 100644
> index 0000000000..22a2f2a11b
> --- /dev/null
> +++ b/include/hw/misc/allwinner-h3-syscon.h
> @@ -0,0 +1,43 @@
> +/*
> + * Allwinner H3 System Control emulation
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
> +#ifndef HW_MISC_ALLWINNER_H3_SYSCON_H
> +#define HW_MISC_ALLWINNER_H3_SYSCON_H
> +
> +#include "hw/sysbus.h"
> +
> +#define AW_H3_SYSCON_REGS_MAX_ADDR  (0x30)
> +#define AW_H3_SYSCON_REGS_NUM       ((AW_H3_SYSCON_REGS_MAX_ADDR / \
> +                                      sizeof(uint32_t)) + 1)
> +#define AW_H3_SYSCON_REGS_MEM_SIZE  (1024)

"4.1. Memory Mapping" the System Control is 4KiB, isn't it?

> +
> +#define TYPE_AW_H3_SYSCON    "allwinner-h3-syscon"
> +#define AW_H3_SYSCON(obj)    OBJECT_CHECK(AwH3SysconState, (obj), \
> +                                          TYPE_AW_H3_SYSCON)
> +
> +typedef struct AwH3SysconState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    MemoryRegion iomem;
> +    uint32_t regs[AW_H3_SYSCON_REGS_NUM];
> +} AwH3SysconState;
> +
> +#endif
> 


