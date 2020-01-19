Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57019C33CAF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 18:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AAD020684
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 18:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2JEX/vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAD020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itFRI-0005AK-5k
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 13:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itFPF-0004HI-HQ
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 13:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itFPD-00014d-6g
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 13:34:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40667
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itFPD-00014I-30
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 13:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579458878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IDuuGhYRYJeFZ9wYSvdey+hYELWm5z/pDvJcvqRDZSs=;
 b=P2JEX/vviC5DCfO2DtMuPcdH1Ic2mDZ5JDKoL1Rm16TO2x38Xf1du+/6+8nJ7ECHdFSI5N
 ijb9UKo0qdlVCnlT9CJp0tmfnbyyU1Vy9ma3QP8K2bGLHqUONdkfsMrDk7/4m1QGvj/Ewb
 lMqDD/drOXMgJdxs0Ix7TnYwWnB0NmY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-dMIJRHqqMEezT3bgO-eDJQ-1; Sun, 19 Jan 2020 13:34:32 -0500
Received: by mail-wr1-f69.google.com with SMTP id f17so13073182wrt.19
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2020 10:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G4XAHPxE0SdbEc8U4C9qLDfRa6QonEL6ZmguPIP+1EE=;
 b=aaOVOgWfWg3jBjpfLoK2AJjioWCwNvdPnyUm4EjtsQaTdt1Vo8d3RJ+TBdQvEuK6O0
 ihsX1JTJOYM0+1LIzHxj5UxCoyVr3VeBaKtmoU+iclVBC2exxMV9ARhS3CwtK5kuXeCP
 Cgbu7kmAXMkZ1WkRTWwSvBmz1vUlifb4lum5Ed/TSZTc4xfFD0ZnbM3ax0VCnyYnJNQT
 muJnhkYIDMvN4MMSwW3HIrBJfv5cSBAe7hO+8BQF6iB+D7pbxpLXlwyM4yly6Bu5Irvd
 8zswwGFekS5dYR6RKxUzabQ0sWcQT/TJ512IDAVBqWIUCncNcgHGpQTK5avj1UnQhECu
 oGGQ==
X-Gm-Message-State: APjAAAWtR7ekc7RvsIBB7kPoQfGG1Xt2qzG8Il6myAR9wP/6HHO23iBc
 bAcEw+tXEMdQS78EXoMn2qv3qlHIyIf/k5r01r2z5zbeh1qLcS59mjA+PB26DmUr84oeEUMzvzn
 /DKzo9c+5KhGjNHo=
X-Received: by 2002:a05:6000:11c5:: with SMTP id
 i5mr14489881wrx.102.1579458871297; 
 Sun, 19 Jan 2020 10:34:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYt0zgtAFTuRcReSqSQNBVpbi1iOePcjPgWSqX7umRET3AhxCK4yV+T4me21vF+YERmGJjIQ==
X-Received: by 2002:a05:6000:11c5:: with SMTP id
 i5mr14489857wrx.102.1579458870879; 
 Sun, 19 Jan 2020 10:34:30 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id y6sm42961947wrl.17.2020.01.19.10.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jan 2020 10:34:30 -0800 (PST)
Subject: Re: [PATCH v4 03/20] hw/arm/allwinner-h3: add Clock Control Unit
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-4-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <61914945-ab68-b47b-9d8d-3ed78c93640c@redhat.com>
Date: Sun, 19 Jan 2020 19:34:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200119005102.3847-4-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: dMIJRHqqMEezT3bgO-eDJQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
> The Clock Control Unit is responsible for clock signal generation,
> configuration and distribution in the Allwinner H3 System on Chip.
> This commit adds support for the Clock Control Unit which emulates
> a simple read/write register interface.
>=20
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>   include/hw/arm/allwinner-h3.h      |   3 +
>   include/hw/misc/allwinner-h3-ccu.h |  66 ++++++++
>   hw/arm/allwinner-h3.c              |   9 +-
>   hw/misc/allwinner-h3-ccu.c         | 243 +++++++++++++++++++++++++++++
>   hw/misc/Makefile.objs              |   1 +
>   5 files changed, 321 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/misc/allwinner-h3-ccu.h
>   create mode 100644 hw/misc/allwinner-h3-ccu.c
>=20
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.=
h
> index 2aac9b78ec..abdc20871a 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -39,6 +39,7 @@
>   #include "hw/arm/boot.h"
>   #include "hw/timer/allwinner-a10-pit.h"
>   #include "hw/intc/arm_gic.h"
> +#include "hw/misc/allwinner-h3-ccu.h"
>   #include "target/arm/cpu.h"
>  =20
>   /**
> @@ -55,6 +56,7 @@ enum {
>       AW_H3_SRAM_A1,
>       AW_H3_SRAM_A2,
>       AW_H3_SRAM_C,
> +    AW_H3_CCU,
>       AW_H3_PIT,
>       AW_H3_UART0,
>       AW_H3_UART1,
> @@ -97,6 +99,7 @@ typedef struct AwH3State {
>       ARMCPU cpus[AW_H3_NUM_CPUS];
>       const hwaddr *memmap;
>       AwA10PITState timer;
> +    AwH3ClockCtlState ccu;
>       GICState gic;
>       MemoryRegion sram_a1;
>       MemoryRegion sram_a2;
> diff --git a/include/hw/misc/allwinner-h3-ccu.h b/include/hw/misc/allwinn=
er-h3-ccu.h
> new file mode 100644
> index 0000000000..9c8a887782
> --- /dev/null
> +++ b/include/hw/misc/allwinner-h3-ccu.h
> @@ -0,0 +1,66 @@
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
> +#ifndef HW_MISC_ALLWINNER_H3_CCU_H
> +#define HW_MISC_ALLWINNER_H3_CCU_H
> +
> +#include "qom/object.h"
> +#include "hw/sysbus.h"
> +
> +/**
> + * @name Constants
> + * @{
> + */
> +
> +/** Highest register address used by CCU device */
> +#define AW_H3_CCU_REGS_MAXADDR  (0x304)

There might be a migration issue if one day we see some firmware=20
accessing some undocumented register > 0x304 (you'd need to migrate more=20
than 0x304/4 registers, so increase allwinner_h3_ccu_vmstate.version_id.

I'd simply replace this definition by

   #define AW_H3_CCU_IOSIZE 0x400

And see comment in write().

> +
> +/** Total number of known registers */
> +#define AW_H3_CCU_REGS_NUM      (AW_H3_CCU_REGS_MAXADDR / sizeof(uint32_=
t))
> +
> +/** @} */
> +
> +/**
> + * @name Object model
> + * @{
> + */
> +
> +#define TYPE_AW_H3_CCU    "allwinner-h3-ccu"
> +#define AW_H3_CCU(obj) \
> +    OBJECT_CHECK(AwH3ClockCtlState, (obj), TYPE_AW_H3_CCU)
> +
> +/** @} */
> +
> +/**
> + * Allwinner H3 CCU object instance state.
> + */
> +typedef struct AwH3ClockCtlState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    /** Maps I/O registers in physical memory */
> +    MemoryRegion iomem;
> +
> +    /** Array of hardware registers */
> +    uint32_t regs[AW_H3_CCU_REGS_NUM];
> +
> +} AwH3ClockCtlState;
> +
> +#endif /* HW_MISC_ALLWINNER_H3_CCU_H */
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index efe6042af3..8df8e3e05e 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -36,6 +36,7 @@ const hwaddr allwinner_h3_memmap[] =3D {
>       [AW_H3_SRAM_A1]    =3D 0x00000000,
>       [AW_H3_SRAM_A2]    =3D 0x00044000,
>       [AW_H3_SRAM_C]     =3D 0x00010000,
> +    [AW_H3_CCU]        =3D 0x01c20000,
>       [AW_H3_PIT]        =3D 0x01c20c00,
>       [AW_H3_UART0]      =3D 0x01c28000,
>       [AW_H3_UART1]      =3D 0x01c28400,
> @@ -77,7 +78,6 @@ struct AwH3Unimplemented {
>       { "usb2",      0x01c1c000, 4 * KiB },
>       { "usb3",      0x01c1d000, 4 * KiB },
>       { "smc",       0x01c1e000, 4 * KiB },
> -    { "ccu",       0x01c20000, 1 * KiB },
>       { "pio",       0x01c20800, 1 * KiB },
>       { "owa",       0x01c21000, 1 * KiB },
>       { "pwm",       0x01c21400, 1 * KiB },
> @@ -172,6 +172,9 @@ static void allwinner_h3_init(Object *obj)
>                                 "clk0-freq", &error_abort);
>       object_property_add_alias(obj, "clk1-freq", OBJECT(&s->timer),
>                                 "clk1-freq", &error_abort);
> +
> +    sysbus_init_child_obj(obj, "ccu", &s->ccu, sizeof(s->ccu),
> +                          TYPE_AW_H3_CCU);
>   }
>  =20
>   static void allwinner_h3_realize(DeviceState *dev, Error **errp)
> @@ -277,6 +280,10 @@ static void allwinner_h3_realize(DeviceState *dev, E=
rror **errp)
>       memory_region_add_subregion(get_system_memory(), s->memmap[AW_H3_SR=
AM_C],
>                                   &s->sram_c);
>  =20
> +    /* Clock Control Unit */
> +    qdev_init_nofail(DEVICE(&s->ccu));
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_CCU]);
> +
>       /* UART0. For future clocktree API: All UARTS are connected to APB2=
_CLK. */
>       serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART0], 2,
>                      qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART=
0),
> diff --git a/hw/misc/allwinner-h3-ccu.c b/hw/misc/allwinner-h3-ccu.c
> new file mode 100644
> index 0000000000..ccf58ccdf2
> --- /dev/null
> +++ b/hw/misc/allwinner-h3-ccu.c
> @@ -0,0 +1,243 @@
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
> +#include "qemu/units.h"
> +#include "hw/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "hw/misc/allwinner-h3-ccu.h"
> +
> +/* CCU register offsets */
> +enum {
> +    REG_PLL_CPUX             =3D 0x0000, /* PLL CPUX Control */
> +    REG_PLL_AUDIO            =3D 0x0008, /* PLL Audio Control */
> +    REG_PLL_VIDEO            =3D 0x0010, /* PLL Video Control */
> +    REG_PLL_VE               =3D 0x0018, /* PLL VE Control */
> +    REG_PLL_DDR              =3D 0x0020, /* PLL DDR Control */
> +    REG_PLL_PERIPH0          =3D 0x0028, /* PLL Peripherals 0 Control */
> +    REG_PLL_GPU              =3D 0x0038, /* PLL GPU Control */
> +    REG_PLL_PERIPH1          =3D 0x0044, /* PLL Peripherals 1 Control */
> +    REG_PLL_DE               =3D 0x0048, /* PLL Display Engine Control *=
/
> +    REG_CPUX_AXI             =3D 0x0050, /* CPUX/AXI Configuration */
> +    REG_APB1                 =3D 0x0054, /* ARM Peripheral Bus 1 Config =
*/
> +    REG_APB2                 =3D 0x0058, /* ARM Peripheral Bus 2 Config =
*/
> +    REG_DRAM_CFG             =3D 0x00F4, /* DRAM Configuration */
> +    REG_MBUS                 =3D 0x00FC, /* MBUS Reset */
> +    REG_PLL_TIME0            =3D 0x0200, /* PLL Stable Time 0 */
> +    REG_PLL_TIME1            =3D 0x0204, /* PLL Stable Time 1 */
> +    REG_PLL_CPUX_BIAS        =3D 0x0220, /* PLL CPUX Bias */
> +    REG_PLL_AUDIO_BIAS       =3D 0x0224, /* PLL Audio Bias */
> +    REG_PLL_VIDEO_BIAS       =3D 0x0228, /* PLL Video Bias */
> +    REG_PLL_VE_BIAS          =3D 0x022C, /* PLL VE Bias */
> +    REG_PLL_DDR_BIAS         =3D 0x0230, /* PLL DDR Bias */
> +    REG_PLL_PERIPH0_BIAS     =3D 0x0234, /* PLL Peripherals 0 Bias */
> +    REG_PLL_GPU_BIAS         =3D 0x023C, /* PLL GPU Bias */
> +    REG_PLL_PERIPH1_BIAS     =3D 0x0244, /* PLL Peripherals 1 Bias */
> +    REG_PLL_DE_BIAS          =3D 0x0248, /* PLL Display Engine Bias */
> +    REG_PLL_CPUX_TUNING      =3D 0x0250, /* PLL CPUX Tuning */
> +    REG_PLL_DDR_TUNING       =3D 0x0260, /* PLL DDR Tuning */
> +};
> +
> +#define REG_INDEX(offset)    (offset / sizeof(uint32_t))
> +
> +/* CCU register flags */
> +enum {
> +    REG_DRAM_CFG_UPDATE      =3D (1 << 16),
> +};
> +
> +enum {
> +    REG_PLL_ENABLE           =3D (1 << 31),
> +    REG_PLL_LOCK             =3D (1 << 28),
> +};
> +
> +
> +/* CCU register reset values */
> +enum {
> +    REG_PLL_CPUX_RST         =3D 0x00001000,
> +    REG_PLL_AUDIO_RST        =3D 0x00035514,
> +    REG_PLL_VIDEO_RST        =3D 0x03006207,
> +    REG_PLL_VE_RST           =3D 0x03006207,
> +    REG_PLL_DDR_RST          =3D 0x00001000,
> +    REG_PLL_PERIPH0_RST      =3D 0x00041811,
> +    REG_PLL_GPU_RST          =3D 0x03006207,
> +    REG_PLL_PERIPH1_RST      =3D 0x00041811,
> +    REG_PLL_DE_RST           =3D 0x03006207,
> +    REG_CPUX_AXI_RST         =3D 0x00010000,
> +    REG_APB1_RST             =3D 0x00001010,
> +    REG_APB2_RST             =3D 0x01000000,
> +    REG_DRAM_CFG_RST         =3D 0x00000000,
> +    REG_MBUS_RST             =3D 0x80000000,
> +    REG_PLL_TIME0_RST        =3D 0x000000FF,
> +    REG_PLL_TIME1_RST        =3D 0x000000FF,
> +    REG_PLL_CPUX_BIAS_RST    =3D 0x08100200,
> +    REG_PLL_AUDIO_BIAS_RST   =3D 0x10100000,
> +    REG_PLL_VIDEO_BIAS_RST   =3D 0x10100000,
> +    REG_PLL_VE_BIAS_RST      =3D 0x10100000,
> +    REG_PLL_DDR_BIAS_RST     =3D 0x81104000,
> +    REG_PLL_PERIPH0_BIAS_RST =3D 0x10100010,
> +    REG_PLL_GPU_BIAS_RST     =3D 0x10100000,
> +    REG_PLL_PERIPH1_BIAS_RST =3D 0x10100010,
> +    REG_PLL_DE_BIAS_RST      =3D 0x10100000,
> +    REG_PLL_CPUX_TUNING_RST  =3D 0x0A101000,
> +    REG_PLL_DDR_TUNING_RST   =3D 0x14880000,
> +};
> +
> +static uint64_t allwinner_h3_ccu_read(void *opaque, hwaddr offset,
> +                                      unsigned size)
> +{
> +    const AwH3ClockCtlState *s =3D AW_H3_CCU(opaque);
> +    const uint32_t idx =3D REG_INDEX(offset);
> +
> +    if (idx >=3D AW_H3_CCU_REGS_NUM) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\=
n",
> +                      __func__, (uint32_t)offset);

See comment in write().

> +        return 0;
> +    }
> +
> +    return s->regs[idx];
> +}
> +
> +static void allwinner_h3_ccu_write(void *opaque, hwaddr offset,
> +                                   uint64_t val, unsigned size)
> +{
> +    AwH3ClockCtlState *s =3D AW_H3_CCU(opaque);
> +    const uint32_t idx =3D REG_INDEX(offset);
> +
> +    if (idx >=3D AW_H3_CCU_REGS_NUM) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\=
n",
> +                      __func__, (uint32_t)offset);

I'd replace this check by ...

> +        return;
> +    }
> +
> +    switch (offset) {
> +    case REG_DRAM_CFG:    /* DRAM Configuration */
> +        val &=3D ~REG_DRAM_CFG_UPDATE;
> +        break;
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
> +            val |=3D REG_PLL_LOCK;
> +        }
> +        break;

        case 0x304 ... AW_H3_CCU_IOSIZE:
            qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset=20
0x%04x\n",
                          __func__, (uint32_t)offset);
            break;

> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented write offset 0x%04x\=
n",
> +                      __func__, (uint32_t)offset);
> +        break;
> +    }
> +
> +    s->regs[idx] =3D (uint32_t) val;
> +}

That said,
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> +
> +static const MemoryRegionOps allwinner_h3_ccu_ops =3D {
> +    .read =3D allwinner_h3_ccu_read,
> +    .write =3D allwinner_h3_ccu_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +    .impl.min_access_size =3D 4,
> +};
> +
> +static void allwinner_h3_ccu_reset(DeviceState *dev)
> +{
> +    AwH3ClockCtlState *s =3D AW_H3_CCU(dev);
> +
> +    /* Set default values for registers */
> +    s->regs[REG_INDEX(REG_PLL_CPUX)] =3D REG_PLL_CPUX_RST;
> +    s->regs[REG_INDEX(REG_PLL_AUDIO)] =3D REG_PLL_AUDIO_RST;
> +    s->regs[REG_INDEX(REG_PLL_VIDEO)] =3D REG_PLL_VIDEO_RST;
> +    s->regs[REG_INDEX(REG_PLL_VE)] =3D REG_PLL_VE_RST;
> +    s->regs[REG_INDEX(REG_PLL_DDR)] =3D REG_PLL_DDR_RST;
> +    s->regs[REG_INDEX(REG_PLL_PERIPH0)] =3D REG_PLL_PERIPH0_RST;
> +    s->regs[REG_INDEX(REG_PLL_GPU)] =3D REG_PLL_GPU_RST;
> +    s->regs[REG_INDEX(REG_PLL_PERIPH1)] =3D REG_PLL_PERIPH1_RST;
> +    s->regs[REG_INDEX(REG_PLL_DE)] =3D REG_PLL_DE_RST;
> +    s->regs[REG_INDEX(REG_CPUX_AXI)] =3D REG_CPUX_AXI_RST;
> +    s->regs[REG_INDEX(REG_APB1)] =3D REG_APB1_RST;
> +    s->regs[REG_INDEX(REG_APB2)] =3D REG_APB2_RST;
> +    s->regs[REG_INDEX(REG_DRAM_CFG)] =3D REG_DRAM_CFG_RST;
> +    s->regs[REG_INDEX(REG_MBUS)] =3D REG_MBUS_RST;
> +    s->regs[REG_INDEX(REG_PLL_TIME0)] =3D REG_PLL_TIME0_RST;
> +    s->regs[REG_INDEX(REG_PLL_TIME1)] =3D REG_PLL_TIME1_RST;
> +    s->regs[REG_INDEX(REG_PLL_CPUX_BIAS)] =3D REG_PLL_CPUX_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_AUDIO_BIAS)] =3D REG_PLL_AUDIO_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_VIDEO_BIAS)] =3D REG_PLL_VIDEO_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_VE_BIAS)] =3D REG_PLL_VE_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_DDR_BIAS)] =3D REG_PLL_DDR_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_PERIPH0_BIAS)] =3D REG_PLL_PERIPH0_BIAS_RS=
T;
> +    s->regs[REG_INDEX(REG_PLL_GPU_BIAS)] =3D REG_PLL_GPU_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_PERIPH1_BIAS)] =3D REG_PLL_PERIPH1_BIAS_RS=
T;
> +    s->regs[REG_INDEX(REG_PLL_DE_BIAS)] =3D REG_PLL_DE_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_CPUX_TUNING)] =3D REG_PLL_CPUX_TUNING_RST;
> +    s->regs[REG_INDEX(REG_PLL_DDR_TUNING)] =3D REG_PLL_DDR_TUNING_RST;
> +}
> +
> +static void allwinner_h3_ccu_init(Object *obj)
> +{
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    AwH3ClockCtlState *s =3D AW_H3_CCU(obj);
> +
> +    /* Memory mapping */
> +    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_h3_ccu_ops, s=
,
> +                          TYPE_AW_H3_CCU, 1 * KiB);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static const VMStateDescription allwinner_h3_ccu_vmstate =3D {
> +    .name =3D "allwinner-h3-ccu",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, AwH3ClockCtlState, AW_H3_CCU_REGS_NUM=
),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void allwinner_h3_ccu_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->reset =3D allwinner_h3_ccu_reset;
> +    dc->vmsd =3D &allwinner_h3_ccu_vmstate;
> +}
> +
> +static const TypeInfo allwinner_h3_ccu_info =3D {
> +    .name          =3D TYPE_AW_H3_CCU,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_init =3D allwinner_h3_ccu_init,
> +    .instance_size =3D sizeof(AwH3ClockCtlState),
> +    .class_init    =3D allwinner_h3_ccu_class_init,
> +};
> +
> +static void allwinner_h3_ccu_register(void)
> +{
> +    type_register_static(&allwinner_h3_ccu_info);
> +}
> +
> +type_init(allwinner_h3_ccu_register)
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index da993f45b7..5e635b74d5 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -28,6 +28,7 @@ common-obj-$(CONFIG_MACIO) +=3D macio/
>  =20
>   common-obj-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem.o
>  =20
> +common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-ccu.o
>   common-obj-$(CONFIG_REALVIEW) +=3D arm_sysctl.o
>   common-obj-$(CONFIG_NSERIES) +=3D cbus.o
>   common-obj-$(CONFIG_ECCMEMCTL) +=3D eccmemctl.o
>=20


