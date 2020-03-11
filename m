Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D4FC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B3B2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7Fqnz4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B3B2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0x9-0005zR-5l
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jC0wT-0005NF-G1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jC0wQ-000565-UK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:58:33 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33817)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jC0wQ-00054s-KF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:58:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id z15so2503962wrl.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 05:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8EVA9e+go9x0pgf8nCgEplYmU+rNcvOc+tKCqeIPWlo=;
 b=B7Fqnz4m1MJyVl6bzX9l0fwXur8mAGAQh2ih2yPfPkA2z5c+g79el3Syly04uEDzG5
 Bzj0SCDpVUVt+OzNFdtNSIuvMHxKsT1+RKlNTYQ3ds8dmy8L+HBdUFnnbdfUw1aKSptk
 M2eVep5VDBwbvCrF7JXGCDEiMUQhtLY4BBLtmaZhK3L1gD+6WFqDHJc9Z0wOfC9JZKzq
 LQf814sWgOS5lDIJmAc72p1rq3Squk3FXSUKNObNGUXxpaej80Rx2WD8tJ43rn0/VBM2
 WnTKTnI/lZPBL6XU3XZ9sFgbcCshXiSlZG0/PT7txeYWvrMbRaA066TLkX+NAGW1S4Wq
 xbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8EVA9e+go9x0pgf8nCgEplYmU+rNcvOc+tKCqeIPWlo=;
 b=ACVaZo4dIoVUV1hVNY5+VvTijSg3kiXTlXqngBGyatb0Csjhmj8fRDoJru7tNqUlkr
 fNKM3DoWkVrlErqoB15eUIaNjzh2G1JbTl85orcgCyDrO+3RrAbt3CZWqYLbg5Kbs4Uq
 Sn0lkzfFv7+M7YZOu+D4/sIg7QqGXifzT00FCxJkAtOCjOn/rhL0wK/PGn99w1Nyf13V
 O1BuMJtzYv6pjJztClfo88riBq6Z95V5he/7A3+EClESILcBDH6k7yE3RdyXRFLJwCqQ
 TQF/o4gbDjWz6YFbzkq04LEMKzYq+He2A8k1HbmEmxMiUrJsmnFadQrgjAvURPOWDw3q
 hqkA==
X-Gm-Message-State: ANhLgQ1Wgt+I7CqDXR11RjqIivZlEutr+Cscfg44id1w0ply9ZFRXWyJ
 mk2gcaOyJUUm7yfOo7Ktpt/9oA==
X-Google-Smtp-Source: ADFU+vuvc7HJBGG8hMUCmIR5LfULXqYLE+1GkB8QP6lbczZIV6cS++cbkAEFznbOsun+eznuKExhYQ==
X-Received: by 2002:a5d:62c9:: with SMTP id o9mr4571813wrv.2.1583931509173;
 Wed, 11 Mar 2020 05:58:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i7sm55644958wro.87.2020.03.11.05.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 05:58:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 270541FF7E;
 Wed, 11 Mar 2020 12:58:27 +0000 (GMT)
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
 <20200310213203.18730-7-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v7 06/18] hw/arm/allwinner: add CPU Configuration module
In-reply-to: <20200310213203.18730-7-nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 12:58:27 +0000
Message-ID: <87mu8ngia4.fsf@linaro.org>
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 b.galvani@gmail.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Niek Linnenbank <nieklinnenbank@gmail.com> writes:

> Various Allwinner System on Chip designs contain multiple processors
> that can be configured and reset using the generic CPU Configuration
> module interface. This commit adds support for the Allwinner CPU
> configuration interface which emulates the following features:
>
>  * CPU reset
>  * CPU status
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/hw/arm/allwinner-h3.h      |   3 +
>  include/hw/misc/allwinner-cpucfg.h |  52 ++++++
>  hw/arm/allwinner-h3.c              |   9 +-
>  hw/misc/allwinner-cpucfg.c         | 282 +++++++++++++++++++++++++++++
>  hw/misc/Makefile.objs              |   1 +
>  hw/misc/trace-events               |   5 +
>  6 files changed, 351 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/misc/allwinner-cpucfg.h
>  create mode 100644 hw/misc/allwinner-cpucfg.c
>
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
> index 43500c4262..dc729176ab 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -40,6 +40,7 @@
>  #include "hw/timer/allwinner-a10-pit.h"
>  #include "hw/intc/arm_gic.h"
>  #include "hw/misc/allwinner-h3-ccu.h"
> +#include "hw/misc/allwinner-cpucfg.h"
>  #include "hw/misc/allwinner-h3-sysctrl.h"
>  #include "target/arm/cpu.h"
>=20=20
> @@ -76,6 +77,7 @@ enum {
>      AW_H3_GIC_CPU,
>      AW_H3_GIC_HYP,
>      AW_H3_GIC_VCPU,
> +    AW_H3_CPUCFG,
>      AW_H3_SDRAM
>  };
>=20=20
> @@ -110,6 +112,7 @@ typedef struct AwH3State {
>      const hwaddr *memmap;
>      AwA10PITState timer;
>      AwH3ClockCtlState ccu;
> +    AwCpuCfgState cpucfg;
>      AwH3SysCtrlState sysctrl;
>      GICState gic;
>      MemoryRegion sram_a1;
> diff --git a/include/hw/misc/allwinner-cpucfg.h b/include/hw/misc/allwinn=
er-cpucfg.h
> new file mode 100644
> index 0000000000..2c3693a8be
> --- /dev/null
> +++ b/include/hw/misc/allwinner-cpucfg.h
> @@ -0,0 +1,52 @@
> +/*
> + * Allwinner CPU Configuration Module emulation
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
> +#ifndef HW_MISC_ALLWINNER_CPUCFG_H
> +#define HW_MISC_ALLWINNER_CPUCFG_H
> +
> +#include "qom/object.h"
> +#include "hw/sysbus.h"
> +
> +/**
> + * Object model
> + * @{
> + */
> +
> +#define TYPE_AW_CPUCFG   "allwinner-cpucfg"
> +#define AW_CPUCFG(obj) \
> +    OBJECT_CHECK(AwCpuCfgState, (obj), TYPE_AW_CPUCFG)
> +
> +/** @} */
> +
> +/**
> + * Allwinner CPU Configuration Module instance state
> + */
> +typedef struct AwCpuCfgState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    MemoryRegion iomem;
> +    uint32_t gen_ctrl;
> +    uint32_t super_standby;
> +    uint32_t entry_addr;
> +
> +} AwCpuCfgState;
> +
> +#endif /* HW_MISC_ALLWINNER_CPUCFG_H */
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index 0aa46712db..b9a5597f2a 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -56,6 +56,7 @@ const hwaddr allwinner_h3_memmap[] =3D {
>      [AW_H3_GIC_CPU]    =3D 0x01c82000,
>      [AW_H3_GIC_HYP]    =3D 0x01c84000,
>      [AW_H3_GIC_VCPU]   =3D 0x01c86000,
> +    [AW_H3_CPUCFG]     =3D 0x01f01c00,
>      [AW_H3_SDRAM]      =3D 0x40000000
>  };
>=20=20
> @@ -122,7 +123,6 @@ struct AwH3Unimplemented {
>      { "r_wdog",    0x01f01000, 1 * KiB },
>      { "r_prcm",    0x01f01400, 1 * KiB },
>      { "r_twd",     0x01f01800, 1 * KiB },
> -    { "r_cpucfg",  0x01f01c00, 1 * KiB },
>      { "r_cir-rx",  0x01f02000, 1 * KiB },
>      { "r_twi",     0x01f02400, 1 * KiB },
>      { "r_uart",    0x01f02800, 1 * KiB },
> @@ -195,6 +195,9 @@ static void allwinner_h3_init(Object *obj)
>=20=20
>      sysbus_init_child_obj(obj, "sysctrl", &s->sysctrl, sizeof(s->sysctrl=
),
>                            TYPE_AW_H3_SYSCTRL);
> +
> +    sysbus_init_child_obj(obj, "cpucfg", &s->cpucfg, sizeof(s->cpucfg),
> +                          TYPE_AW_CPUCFG);
>  }
>=20=20
>  static void allwinner_h3_realize(DeviceState *dev, Error **errp)
> @@ -308,6 +311,10 @@ static void allwinner_h3_realize(DeviceState *dev, E=
rror **errp)
>      qdev_init_nofail(DEVICE(&s->sysctrl));
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysctrl), 0, s->memmap[AW_H3_SYSC=
TRL]);
>=20=20
> +    /* CPU Configuration */
> +    qdev_init_nofail(DEVICE(&s->cpucfg));
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0, s->memmap[AW_H3_CPUCF=
G]);
> +
>      /* Universal Serial Bus */
>      sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
>                           qdev_get_gpio_in(DEVICE(&s->gic),
> diff --git a/hw/misc/allwinner-cpucfg.c b/hw/misc/allwinner-cpucfg.c
> new file mode 100644
> index 0000000000..bbd33a7dac
> --- /dev/null
> +++ b/hw/misc/allwinner-cpucfg.c
> @@ -0,0 +1,282 @@
> +/*
> + * Allwinner CPU Configuration Module emulation
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
> +#include "qemu/error-report.h"
> +#include "qemu/timer.h"
> +#include "hw/core/cpu.h"
> +#include "target/arm/arm-powerctl.h"
> +#include "target/arm/cpu.h"
> +#include "hw/misc/allwinner-cpucfg.h"
> +#include "trace.h"
> +
> +/* CPUCFG register offsets */
> +enum {
> +    REG_CPUS_RST_CTRL       =3D 0x0000, /* CPUs Reset Control */
> +    REG_CPU0_RST_CTRL       =3D 0x0040, /* CPU#0 Reset Control */
> +    REG_CPU0_CTRL           =3D 0x0044, /* CPU#0 Control */
> +    REG_CPU0_STATUS         =3D 0x0048, /* CPU#0 Status */
> +    REG_CPU1_RST_CTRL       =3D 0x0080, /* CPU#1 Reset Control */
> +    REG_CPU1_CTRL           =3D 0x0084, /* CPU#1 Control */
> +    REG_CPU1_STATUS         =3D 0x0088, /* CPU#1 Status */
> +    REG_CPU2_RST_CTRL       =3D 0x00C0, /* CPU#2 Reset Control */
> +    REG_CPU2_CTRL           =3D 0x00C4, /* CPU#2 Control */
> +    REG_CPU2_STATUS         =3D 0x00C8, /* CPU#2 Status */
> +    REG_CPU3_RST_CTRL       =3D 0x0100, /* CPU#3 Reset Control */
> +    REG_CPU3_CTRL           =3D 0x0104, /* CPU#3 Control */
> +    REG_CPU3_STATUS         =3D 0x0108, /* CPU#3 Status */
> +    REG_CPU_SYS_RST         =3D 0x0140, /* CPU System Reset */
> +    REG_CLK_GATING          =3D 0x0144, /* CPU Clock Gating */
> +    REG_GEN_CTRL            =3D 0x0184, /* General Control */
> +    REG_SUPER_STANDBY       =3D 0x01A0, /* Super Standby Flag */
> +    REG_ENTRY_ADDR          =3D 0x01A4, /* Reset Entry Address */
> +    REG_DBG_EXTERN          =3D 0x01E4, /* Debug External */
> +    REG_CNT64_CTRL          =3D 0x0280, /* 64-bit Counter Control */
> +    REG_CNT64_LOW           =3D 0x0284, /* 64-bit Counter Low */
> +    REG_CNT64_HIGH          =3D 0x0288, /* 64-bit Counter High */
> +};
> +
> +/* CPUCFG register flags */
> +enum {
> +    CPUX_RESET_RELEASED     =3D ((1 << 1) | (1 << 0)),
> +    CPUX_STATUS_SMP         =3D (1 << 0),
> +    CPU_SYS_RESET_RELEASED  =3D (1 << 0),
> +    CLK_GATING_ENABLE       =3D ((1 << 8) | 0xF),
> +};
> +
> +/* CPUCFG register reset values */
> +enum {
> +    REG_CLK_GATING_RST      =3D 0x0000010F,
> +    REG_GEN_CTRL_RST        =3D 0x00000020,
> +    REG_SUPER_STANDBY_RST   =3D 0x0,
> +    REG_CNT64_CTRL_RST      =3D 0x0,
> +};
> +
> +/* CPUCFG constants */
> +enum {
> +    CPU_EXCEPTION_LEVEL_ON_RESET =3D 3, /* EL3 */
> +};
> +
> +static void allwinner_cpucfg_cpu_reset(AwCpuCfgState *s, uint8_t cpu_id)
> +{
> +    int ret;
> +
> +    trace_allwinner_cpucfg_cpu_reset(cpu_id, s->entry_addr);
> +
> +    ARMCPU *target_cpu =3D ARM_CPU(arm_get_cpu_by_id(cpu_id));
> +    if (!target_cpu) {
> +        /*
> +         * Called with a bogus value for cpu_id. Guest error will
> +         * already have been logged, we can simply return here.
> +         */
> +        return;
> +    }
> +    bool target_aa64 =3D arm_feature(&target_cpu->env, ARM_FEATURE_AARCH=
64);
> +
> +    ret =3D arm_set_cpu_on(cpu_id, s->entry_addr, 0,
> +                         CPU_EXCEPTION_LEVEL_ON_RESET, target_aa64);
> +    if (ret !=3D QEMU_ARM_POWERCTL_RET_SUCCESS) {
> +        error_report("%s: failed to bring up CPU %d: err %d",
> +                     __func__, cpu_id, ret);
> +        return;
> +    }
> +}
> +
> +static uint64_t allwinner_cpucfg_read(void *opaque, hwaddr offset,
> +                                      unsigned size)
> +{
> +    const AwCpuCfgState *s =3D AW_CPUCFG(opaque);
> +    uint64_t val =3D 0;
> +
> +    switch (offset) {
> +    case REG_CPUS_RST_CTRL:     /* CPUs Reset Control */
> +    case REG_CPU_SYS_RST:       /* CPU System Reset */
> +        val =3D CPU_SYS_RESET_RELEASED;
> +        break;
> +    case REG_CPU0_RST_CTRL:     /* CPU#0 Reset Control */
> +    case REG_CPU1_RST_CTRL:     /* CPU#1 Reset Control */
> +    case REG_CPU2_RST_CTRL:     /* CPU#2 Reset Control */
> +    case REG_CPU3_RST_CTRL:     /* CPU#3 Reset Control */
> +        val =3D CPUX_RESET_RELEASED;
> +        break;
> +    case REG_CPU0_CTRL:         /* CPU#0 Control */
> +    case REG_CPU1_CTRL:         /* CPU#1 Control */
> +    case REG_CPU2_CTRL:         /* CPU#2 Control */
> +    case REG_CPU3_CTRL:         /* CPU#3 Control */
> +        val =3D 0;
> +        break;
> +    case REG_CPU0_STATUS:       /* CPU#0 Status */
> +    case REG_CPU1_STATUS:       /* CPU#1 Status */
> +    case REG_CPU2_STATUS:       /* CPU#2 Status */
> +    case REG_CPU3_STATUS:       /* CPU#3 Status */
> +        val =3D CPUX_STATUS_SMP;
> +        break;
> +    case REG_CLK_GATING:        /* CPU Clock Gating */
> +        val =3D CLK_GATING_ENABLE;
> +        break;
> +    case REG_GEN_CTRL:          /* General Control */
> +        val =3D s->gen_ctrl;
> +        break;
> +    case REG_SUPER_STANDBY:     /* Super Standby Flag */
> +        val =3D s->super_standby;
> +        break;
> +    case REG_ENTRY_ADDR:        /* Reset Entry Address */
> +        val =3D s->entry_addr;
> +        break;
> +    case REG_DBG_EXTERN:        /* Debug External */
> +    case REG_CNT64_CTRL:        /* 64-bit Counter Control */
> +    case REG_CNT64_LOW:         /* 64-bit Counter Low */
> +    case REG_CNT64_HIGH:        /* 64-bit Counter High */
> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented register at 0x%04x\n=
",
> +                      __func__, (uint32_t)offset);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\=
n",
> +                      __func__, (uint32_t)offset);
> +        break;
> +    }
> +
> +    trace_allwinner_cpucfg_read(offset, val, size);
> +
> +    return val;
> +}
> +
> +static void allwinner_cpucfg_write(void *opaque, hwaddr offset,
> +                                   uint64_t val, unsigned size)
> +{
> +    AwCpuCfgState *s =3D AW_CPUCFG(opaque);
> +
> +    trace_allwinner_cpucfg_write(offset, val, size);
> +
> +    switch (offset) {
> +    case REG_CPUS_RST_CTRL:     /* CPUs Reset Control */
> +    case REG_CPU_SYS_RST:       /* CPU System Reset */
> +        break;
> +    case REG_CPU0_RST_CTRL:     /* CPU#0 Reset Control */
> +    case REG_CPU1_RST_CTRL:     /* CPU#1 Reset Control */
> +    case REG_CPU2_RST_CTRL:     /* CPU#2 Reset Control */
> +    case REG_CPU3_RST_CTRL:     /* CPU#3 Reset Control */
> +        if (val) {
> +            allwinner_cpucfg_cpu_reset(s, (offset - REG_CPU0_RST_CTRL) >=
> 6);
> +        }
> +        break;
> +    case REG_CPU0_CTRL:         /* CPU#0 Control */
> +    case REG_CPU1_CTRL:         /* CPU#1 Control */
> +    case REG_CPU2_CTRL:         /* CPU#2 Control */
> +    case REG_CPU3_CTRL:         /* CPU#3 Control */
> +    case REG_CPU0_STATUS:       /* CPU#0 Status */
> +    case REG_CPU1_STATUS:       /* CPU#1 Status */
> +    case REG_CPU2_STATUS:       /* CPU#2 Status */
> +    case REG_CPU3_STATUS:       /* CPU#3 Status */
> +    case REG_CLK_GATING:        /* CPU Clock Gating */
> +        break;
> +    case REG_GEN_CTRL:          /* General Control */
> +        s->gen_ctrl =3D val;
> +        break;
> +    case REG_SUPER_STANDBY:     /* Super Standby Flag */
> +        s->super_standby =3D val;
> +        break;
> +    case REG_ENTRY_ADDR:        /* Reset Entry Address */
> +        s->entry_addr =3D val;
> +        break;
> +    case REG_DBG_EXTERN:        /* Debug External */
> +    case REG_CNT64_CTRL:        /* 64-bit Counter Control */
> +    case REG_CNT64_LOW:         /* 64-bit Counter Low */
> +    case REG_CNT64_HIGH:        /* 64-bit Counter High */
> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented register at 0x%04x\n=
",
> +                      __func__, (uint32_t)offset);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\=
n",
> +                      __func__, (uint32_t)offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps allwinner_cpucfg_ops =3D {
> +    .read =3D allwinner_cpucfg_read,
> +    .write =3D allwinner_cpucfg_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +    .impl.min_access_size =3D 4,
> +};
> +
> +static void allwinner_cpucfg_reset(DeviceState *dev)
> +{
> +    AwCpuCfgState *s =3D AW_CPUCFG(dev);
> +
> +    /* Set default values for registers */
> +    s->gen_ctrl =3D REG_GEN_CTRL_RST;
> +    s->super_standby =3D REG_SUPER_STANDBY_RST;
> +    s->entry_addr =3D 0;
> +}
> +
> +static void allwinner_cpucfg_init(Object *obj)
> +{
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    AwCpuCfgState *s =3D AW_CPUCFG(obj);
> +
> +    /* Memory mapping */
> +    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_cpucfg_ops, s,
> +                          TYPE_AW_CPUCFG, 1 * KiB);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static const VMStateDescription allwinner_cpucfg_vmstate =3D {
> +    .name =3D "allwinner-cpucfg",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(gen_ctrl, AwCpuCfgState),
> +        VMSTATE_UINT32(super_standby, AwCpuCfgState),
> +        VMSTATE_UINT32(entry_addr, AwCpuCfgState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void allwinner_cpucfg_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->reset =3D allwinner_cpucfg_reset;
> +    dc->vmsd =3D &allwinner_cpucfg_vmstate;
> +}
> +
> +static const TypeInfo allwinner_cpucfg_info =3D {
> +    .name          =3D TYPE_AW_CPUCFG,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_init =3D allwinner_cpucfg_init,
> +    .instance_size =3D sizeof(AwCpuCfgState),
> +    .class_init    =3D allwinner_cpucfg_class_init,
> +};
> +
> +static void allwinner_cpucfg_register(void)
> +{
> +    type_register_static(&allwinner_cpucfg_info);
> +}
> +
> +type_init(allwinner_cpucfg_register)
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 63b2e528f9..f3788a5903 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -29,6 +29,7 @@ common-obj-$(CONFIG_MACIO) +=3D macio/
>  common-obj-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem.o
>=20=20
>  common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-ccu.o
> +obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-cpucfg.o
>  common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-sysctrl.o
>  common-obj-$(CONFIG_REALVIEW) +=3D arm_sysctl.o
>  common-obj-$(CONFIG_NSERIES) +=3D cbus.o
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 7f0f5dff3a..ede1650672 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -1,5 +1,10 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>=20=20
> +# allwinner-cpucfg.c
> +allwinner_cpucfg_cpu_reset(uint8_t cpu_id, uint32_t reset_addr) "id %u, =
reset_addr 0x%" PRIu32
> +allwinner_cpucfg_read(uint64_t offset, uint64_t data, unsigned size) "of=
fset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> +allwinner_cpucfg_write(uint64_t offset, uint64_t data, unsigned size) "o=
ffset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> +
>  # eccmemctl.c
>  ecc_mem_writel_mer(uint32_t val) "Write memory enable 0x%08x"
>  ecc_mem_writel_mdr(uint32_t val) "Write memory delay 0x%08x"


--=20
Alex Benn=C3=A9e

