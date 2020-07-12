Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FB6C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 05:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F10520720
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 05:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cg3gNGBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F10520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juUll-0000Rv-NI
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 01:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1juUl5-0008JY-BX
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 01:42:39 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:38581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1juUl1-0005eR-P1
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 01:42:39 -0400
Received: by mail-vk1-xa43.google.com with SMTP id t187so2106175vke.5
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 22:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=R7JGDNPgHQ8o8mMfuXeWhuvsU8Fy2T4/aEy75TyBRYY=;
 b=cg3gNGBPqZpPCKAfA8jpASwD0B2E0bTyJsDb+6IbwTAJ9LowJpNNJQ9nNwF8THV5w0
 IQQ+2I8NWfplCpydwkIrD+DR4nAqnd5RznUNwlJz2FiQCsOeD/B1wHcSIiW7wTcxdSOG
 LNpTyE1tsgfayqY9SbV7Lpk79DV9FNvZVFsoWuwrtg2j2xaU3h137OhrOnAHIcxu3VSK
 kipb9nQEf+DL2WMMUp7VR5MTm5DDY0/Ful/PE4+t03bydL2t5ysy2mLEDaLW4aQLFwYK
 PEzklb9xAdU1z+XhX+IOajuBgpGzq9b1PQc1WoJxQ35+mX2BJ404c1Bo9YZL0W64HM4D
 XlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=R7JGDNPgHQ8o8mMfuXeWhuvsU8Fy2T4/aEy75TyBRYY=;
 b=dbD0Wl50sRPy07CVtQ1KSS42oqwohZPh4wJ4x/4gmhn9YLK27rgSKcJq1Z8dkvthuY
 O2M8hjl2As4t0HmYNEnIVwF2oVKG4TZAe4Zd7FRDhLzkUfyWqhuqNEj5rW6LERlFPM2V
 b0TM6fmYAKKWU9j2he5Zl+TJxzD0rPHAlThyudzHl7CZD7mZZ3LVc3DsEqppKJT/b6sx
 +ExfcyEJR46XKpm4YLiwqUQseyevCKNr7fzxsGxgfNkZSb2BXuq8/0SfPliSOIkUAMRW
 P/fY7UTHgyZLFxyALm+M0LIqxpAqVhiDVgUur/hzDaE9X64urZAlJunCLBnMqZ6xAzA1
 L42g==
X-Gm-Message-State: AOAM533COk7ypF64p4/+U3j3MS0ajsTexDBpNeWHxr4wnE2CRg8s4THm
 TG6IokQc9a0XAwC280+QL6xyL4GSCB6n10yiyMHMpg==
X-Google-Smtp-Source: ABdhPJxd6WChkFqDhXT8QBqvmJneTyRMuhKZiTMsCN0q8IdZPP7/aFX20BYV+K8L8Rv+icdVHUTfF3xe10oVWPmamUs=
X-Received: by 2002:a1f:255:: with SMTP id 82mr56908326vkc.39.1594532554030;
 Sat, 11 Jul 2020 22:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-10-hskinnemoen@google.com>
 <189922e4-b53f-da64-5663-23b599294248@amsat.org>
In-Reply-To: <189922e4-b53f-da64-5663-23b599294248@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Sat, 11 Jul 2020 22:42:22 -0700
Message-ID: <CAFQmdRbY8DHYOOHPREHg63hgLVTVvyMbuMrdauctaBTzaB1=AA@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] hw/ssi: NPCM7xx Flash Interface Unit device model
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a43;
 envelope-from=hskinnemoen@google.com; helo=mail-vk1-xa43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 9, 2020 at 10:00 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
> > This implements a device model for the NPCM7xx SPI flash controller.
> >
> > Direct reads and writes, and user-mode transactions have been tested in
> > various modes. Protection features are not implemented yet.
> >
> > All the FIU instances are available in the SoC's address space,
> > regardless of whether or not they're connected to actual flash chips.
> >
> > Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> > Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> > ---
> >  include/hw/arm/npcm7xx.h     |   2 +
> >  include/hw/ssi/npcm7xx_fiu.h | 100 +++++++
> >  hw/arm/npcm7xx.c             |  53 ++++
> >  hw/ssi/npcm7xx_fiu.c         | 510 +++++++++++++++++++++++++++++++++++
> >  hw/arm/Kconfig               |   1 +
> >  hw/ssi/Makefile.objs         |   1 +
> >  hw/ssi/trace-events          |   9 +
> >  7 files changed, 676 insertions(+)
> >  create mode 100644 include/hw/ssi/npcm7xx_fiu.h
> >  create mode 100644 hw/ssi/npcm7xx_fiu.c
> >
> > diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
> > index 3ae9e5dca2..bc99f47286 100644
> > --- a/include/hw/arm/npcm7xx.h
> > +++ b/include/hw/arm/npcm7xx.h
> > @@ -23,6 +23,7 @@
> >  #include "hw/misc/npcm7xx_gcr.h"
> >  #include "hw/nvram/npcm7xx_otp.h"
> >  #include "hw/timer/npcm7xx_timer.h"
> > +#include "hw/ssi/npcm7xx_fiu.h"
> >  #include "target/arm/cpu.h"
> >
> >  #define NPCM7XX_MAX_NUM_CPUS    (2)
> > @@ -73,6 +74,7 @@ typedef struct NPCM7xxState {
> >      NPCM7xxOTPState     key_storage;
> >      NPCM7xxOTPState     fuse_array;
> >      NPCM7xxMCState      mc;
> > +    NPCM7xxFIUState     fiu[2];
> >  } NPCM7xxState;
> >
> >  #define TYPE_NPCM7XX    "npcm7xx"
> > diff --git a/include/hw/ssi/npcm7xx_fiu.h b/include/hw/ssi/npcm7xx_fiu.=
h
> > new file mode 100644
> > index 0000000000..b867bd0429
> > --- /dev/null
> > +++ b/include/hw/ssi/npcm7xx_fiu.h
> > @@ -0,0 +1,100 @@
> > +/*
> > + * Nuvoton NPCM7xx Flash Interface Unit (FIU)
> > + *
> > + * Copyright 2020 Google LLC
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License as published by t=
he
> > + * Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful, but=
 WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Licens=
e
> > + * for more details.
> > + */
> > +#ifndef NPCM7XX_FIU_H
> > +#define NPCM7XX_FIU_H
> > +
> > +#include "hw/ssi/ssi.h"
> > +#include "hw/sysbus.h"
> > +
> > +/**
> > + * enum NPCM7xxFIURegister - 32-bit FIU register indices.
> > + */
> > +enum NPCM7xxFIURegister {
> > +    NPCM7XX_FIU_DRD_CFG,
> > +    NPCM7XX_FIU_DWR_CFG,
> > +    NPCM7XX_FIU_UMA_CFG,
> > +    NPCM7XX_FIU_UMA_CTS,
> > +    NPCM7XX_FIU_UMA_CMD,
> > +    NPCM7XX_FIU_UMA_ADDR,
> > +    NPCM7XX_FIU_PRT_CFG,
> > +    NPCM7XX_FIU_UMA_DW0 =3D 0x0020 / sizeof(uint32_t),
> > +    NPCM7XX_FIU_UMA_DW1,
> > +    NPCM7XX_FIU_UMA_DW2,
> > +    NPCM7XX_FIU_UMA_DW3,
> > +    NPCM7XX_FIU_UMA_DR0,
> > +    NPCM7XX_FIU_UMA_DR1,
> > +    NPCM7XX_FIU_UMA_DR2,
> > +    NPCM7XX_FIU_UMA_DR3,
> > +    NPCM7XX_FIU_PRT_CMD0,
> > +    NPCM7XX_FIU_PRT_CMD1,
> > +    NPCM7XX_FIU_PRT_CMD2,
> > +    NPCM7XX_FIU_PRT_CMD3,
> > +    NPCM7XX_FIU_PRT_CMD4,
> > +    NPCM7XX_FIU_PRT_CMD5,
> > +    NPCM7XX_FIU_PRT_CMD6,
> > +    NPCM7XX_FIU_PRT_CMD7,
> > +    NPCM7XX_FIU_PRT_CMD8,
> > +    NPCM7XX_FIU_PRT_CMD9,
> > +    NPCM7XX_FIU_CFG =3D 0x78 / sizeof(uint32_t),
> > +    NPCM7XX_FIU_NR_REGS,
> > +};
> > +
> > +typedef struct NPCM7xxFIUState NPCM7xxFIUState;
> > +
> > +/**
> > + * struct NPCM7xxFIUFlash - Per-chipselect flash controller state.
> > + * @direct_access: Memory region for direct flash access.
> > + * @fiu: Pointer to flash controller shared state.
> > + */
> > +typedef struct NPCM7xxFIUFlash {
> > +    MemoryRegion direct_access;
> > +    NPCM7xxFIUState *fiu;
> > +} NPCM7xxFIUFlash;
> > +
> > +/**
> > + * NPCM7xxFIUState - Device state for one Flash Interface Unit.
> > + * @parent: System bus device.
> > + * @mmio: Memory region for register access.
> > + * @cs_count: Number of flash chips that may be connected to this modu=
le.
> > + * @active_cs: Currently active chip select, or -1 if no chip is selec=
ted.
> > + * @cs_lines: GPIO lines that may be wired to flash chips.
> > + * @flash: Array of @cs_count per-flash-chip state objects.
> > + * @spi: The SPI bus mastered by this controller.
> > + * @regs: Register contents.
> > + *
> > + * Each FIU has a shared bank of registers, and controls up to four ch=
ip
> > + * selects. Each chip select has a dedicated memory region which may b=
e used to
> > + * read and write the flash connected to that chip select as if it wer=
e memory.
> > + */
> > +struct NPCM7xxFIUState {
> > +    SysBusDevice parent;
> > +
> > +    MemoryRegion mmio;
> > +
> > +    int32_t cs_count;
> > +    int32_t active_cs;
> > +    qemu_irq *cs_lines;
> > +    NPCM7xxFIUFlash *flash;
> > +
> > +    SSIBus *spi;
> > +
> > +    uint32_t regs[NPCM7XX_FIU_NR_REGS];
> > +};
> > +
> > +#define TYPE_NPCM7XX_FIU "npcm7xx-fiu"
> > +#define NPCM7XX_FIU(obj) OBJECT_CHECK(NPCM7xxFIUState, (obj), TYPE_NPC=
M7XX_FIU)
> > +
> > +#endif /* NPCM7XX_FIU_H */
> > diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> > index 4d227bb74b..c9ff3dab25 100644
> > --- a/hw/arm/npcm7xx.c
> > +++ b/hw/arm/npcm7xx.c
> > @@ -98,6 +98,37 @@ static const hwaddr npcm7xx_uart_addr[] =3D {
> >      0xf0004000,
> >  };
> >
> > +static const hwaddr npcm7xx_fiu0_flash_addr[] =3D {
>
> So per
> https://github.com/Nuvoton-Israel/bootblock/blob/master/SWC_HAL/Chips/npc=
m750/npcm750.h
> this is SPI0 on AHB18,
>
> > +    0x80000000,
> > +    0x88000000,
>
> CS0 & CS1,
>
> also listed:
>
> 0x90000000, // CS2
> 0x98000000, // CS3

Confirmed with Nuvoton off-list that these do not exist. SPI0 only
supports two chip-selects for direct access.

I'll add comments.

> > +};
> > +
> > +static const hwaddr npcm7xx_fiu3_flash_addr[] =3D {
>
> Ditto SPI3 on AHB3, and CS0 to CS3.
>
> > +    0xa0000000,
> > +    0xa8000000,
> > +    0xb0000000,
> > +    0xb8000000,
> > +};
> > +
> > +static const struct {
> > +    const char *name;
> > +    hwaddr regs_addr;
> > +    int cs_count;
> > +    const hwaddr *flash_addr;
> > +} npcm7xx_fiu[] =3D {
> > +    {
> > +        .name =3D "fiu0",
> > +        .regs_addr =3D 0xfb000000,
> > +        .cs_count =3D ARRAY_SIZE(npcm7xx_fiu0_flash_addr),
>
> Hmm without the datasheet, can't tell, but I'd expect 4 CS
> regardless.

FIU0/SPI0 only has 2 chip selects.

> > +        .flash_addr =3D npcm7xx_fiu0_flash_addr,
> > +    }, {
> > +        .name =3D "fiu3",
> > +        .regs_addr =3D 0xc0000000,
> > +        .cs_count =3D ARRAY_SIZE(npcm7xx_fiu3_flash_addr),
> > +        .flash_addr =3D npcm7xx_fiu3_flash_addr,
> > +    },
> > +};
> > +
> >  void npcm7xx_write_secondary_boot(ARMCPU *cpu, const struct arm_boot_i=
nfo *info)
> >  {
> >      /*
> > @@ -171,6 +202,12 @@ static void npcm7xx_init(Object *obj)
> >      for (i =3D 0; i < ARRAY_SIZE(s->tim); i++) {
> >          object_initialize_child(obj, "tim[*]", &s->tim[i], TYPE_NPCM7X=
X_TIMER);
> >      }
> > +
> > +    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_fiu) !=3D ARRAY_SIZE(s->fiu))=
;
> > +    for (i =3D 0; i < ARRAY_SIZE(s->fiu); i++) {
> > +        object_initialize_child(obj, npcm7xx_fiu[i].name, &s->fiu[i],
> > +                                TYPE_NPCM7XX_FIU);
> > +    }
> >  }
> >
> >  static void npcm7xx_realize(DeviceState *dev, Error **errp)
> > @@ -260,6 +297,22 @@ static void npcm7xx_realize(DeviceState *dev, Erro=
r **errp)
> >                         serial_hd(i), DEVICE_LITTLE_ENDIAN);
> >      }
> >
> > +    /* Flash Interface Unit (FIU) */
> > +    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_fiu) !=3D ARRAY_SIZE(s->fiu))=
;
> > +    for (i =3D 0; i < ARRAY_SIZE(s->fiu); i++) {
> > +        SysBusDevice *sbd =3D SYS_BUS_DEVICE(&s->fiu[i]);
> > +        int j;
> > +
> > +        object_property_set_int(OBJECT(sbd), npcm7xx_fiu[i].cs_count,
> > +                                "cs-count", &error_abort);
> > +        sysbus_realize(sbd, &error_abort);
> > +
> > +        sysbus_mmio_map(sbd, 0, npcm7xx_fiu[i].regs_addr);
> > +        for (j =3D 0; j < npcm7xx_fiu[i].cs_count; j++) {
> > +            sysbus_mmio_map(sbd, j + 1, npcm7xx_fiu[i].flash_addr[j]);
> > +        }
> > +    }
> > +
> >      /* RAM2 (SRAM) */
> >      memory_region_init_ram(&s->sram, OBJECT(dev), "ram2",
> >                             NPCM7XX_RAM2_SZ, &error_abort);
> > diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
> > new file mode 100644
> > index 0000000000..92ade709e8
> > --- /dev/null
> > +++ b/hw/ssi/npcm7xx_fiu.c
> > @@ -0,0 +1,510 @@
> > +/*
> > + * Nuvoton NPCM7xx Flash Interface Unit (FIU)
> > + *
> > + * Copyright 2020 Google LLC
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License as published by t=
he
> > + * Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful, but=
 WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Licens=
e
> > + * for more details.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "hw/irq.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/ssi/npcm7xx_fiu.h"
> > +#include "migration/vmstate.h"
> > +#include "qapi/error.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/log.h"
> > +#include "qemu/module.h"
> > +#include "qemu/units.h"
> > +
> > +#include "trace.h"
> > +
> > +/* Up to 128 MiB of flash may be accessed directly as memory. */
> > +#define NPCM7XX_FIU_FLASH_WINDOW_SIZE (128 * MiB)
> > +
> > +/* Each module has 4 KiB of register space. Only a fraction of it is u=
sed. */
> > +#define NPCM7XX_FIU_CTRL_REGS_SIZE (4 * KiB)
> > +
> > +/* FIU_{DRD,DWR,UMA,PTR}_CFG cannot be written when this bit is set. *=
/
> > +#define NPCM7XX_FIU_CFG_LCK BIT(31)
> > +
> > +/* Direct Read configuration register fields. */
> > +#define FIU_DRD_CFG_ADDSIZ(rv) extract32(rv, 16, 2)
> > +#define FIU_ADDSIZ_3BYTES 0
> > +#define FIU_ADDSIZ_4BYTES 1
> > +#define FIU_DRD_CFG_DBW(rv) extract32(rv, 12, 2)
> > +#define FIU_DRD_CFG_ACCTYPE(rv) extract32(rv, 8, 2)
> > +#define FIU_DRD_CFG_RDCMD(rv) extract32(rv, 0, 8)
> > +
> > +/* Direct Write configuration register fields. */
> > +#define FIU_DWR_CFG_ADDSIZ(rv) extract32(rv, 16, 2)
> > +#define FIU_DWR_CFG_WRCMD(rv) extract32(rv, 0, 8)
> > +
> > +/* User-Mode Access register fields. */
> > +
> > +/* Command Mode Lock and the bits protected by it. */
> > +#define FIU_UMA_CFG_CMMLCK BIT(30)
> > +#define FIU_UMA_CFG_CMMLCK_MASK 0x00000403
> > +
> > +#define FIU_UMA_CFG_RDATSIZ(rv) extract32(rv, 24, 5)
> > +#define FIU_UMA_CFG_DBSIZ(rv) extract32(rv, 21, 3)
> > +#define FIU_UMA_CFG_WDATSIZ(rv) extract32(rv, 16, 5)
> > +#define FIU_UMA_CFG_ADDSIZ(rv) extract32(rv, 11, 3)
> > +#define FIU_UMA_CFG_CMDSIZ(rv) extract32(rv, 10, 1)
> > +#define FIU_UMA_CFG_DBPCK(rv) extract32(rv, 6, 2)
> > +
> > +#define FIU_UMA_CTS_RDYIE BIT(25)
> > +#define FIU_UMA_CTS_RDYST BIT(24)
> > +#define FIU_UMA_CTS_SW_CS BIT(16)
> > +#define FIU_UMA_CTS_DEV_NUM(rv) extract32(rv, 8, 2)
> > +#define FIU_UMA_CTS_EXEC_DONE BIT(0)
> > +
> > +/* Direct flash memory read handler. */
> > +static uint64_t npcm7xx_fiu_flash_read(void *opaque, hwaddr addr,
> > +                                       unsigned int size)
> > +{
> > +    NPCM7xxFIUFlash *f =3D opaque;
> > +    NPCM7xxFIUState *fiu =3D f->fiu;
> > +    int cs_id =3D f - fiu->flash;
>
> Hmmm? Not obvious.

I'll add a helper function.


> > +    uint64_t value =3D 0;
> > +    uint32_t drd_cfg;
> > +    int dummy_cycles;
> > +    int i;
> > +
> > +    drd_cfg =3D fiu->regs[NPCM7XX_FIU_DRD_CFG];
> > +
> > +    qemu_irq_lower(fiu->cs_lines[cs_id]);
>
> Isn't it cleaner to use npcm7xx_fiu_select() here?

Yes, you're right.

> When can we have 'fio->active_cs !=3D cs_id'?

There's a set of user-mode registers that also control CS. I'll log an
error if CS is already active when we get here (indicating a guest
software error).

> BTW I'd add a trace event in select/deselect().

Will do.

> > +    ssi_transfer(fiu->spi, FIU_DRD_CFG_RDCMD(drd_cfg));
> > +
> > +    switch (FIU_DRD_CFG_ADDSIZ(drd_cfg)) {
> > +    case FIU_ADDSIZ_4BYTES:
> > +        ssi_transfer(fiu->spi, extract32(addr, 24, 8));
> > +        /* fall through */
> > +    case FIU_ADDSIZ_3BYTES:
> > +        ssi_transfer(fiu->spi, extract32(addr, 16, 8));
> > +        ssi_transfer(fiu->spi, extract32(addr, 8, 8));
> > +        ssi_transfer(fiu->spi, extract32(addr, 0, 8));
> > +        break;
> > +
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad address size %d\n",
> > +                      DEVICE(fiu)->canonical_path, FIU_DRD_CFG_ADDSIZ(=
drd_cfg));
> > +        break;
> > +    }
> > +
> > +    /* Flash chip model expects one transfer per dummy bit, not byte *=
/
> > +    dummy_cycles =3D
> > +        (FIU_DRD_CFG_DBW(drd_cfg) * 8) >> FIU_DRD_CFG_ACCTYPE(drd_cfg)=
;
> > +    for (i =3D 0; i < dummy_cycles; i++) {
> > +        ssi_transfer(fiu->spi, 0);
>
> Note to self, might worth a ssi_shift_dummy(count) generic method.

I'm not a huge fan of this interface to be honest. It requires the
flash controller to have intimate knowledge of the flash chip, and if
it doesn't predict the dummy phase correctly, or the guest programs
the wrong number of dummy cycles, the end result is very different
from what you'll see on a real system. I'd love to see something like
a number-of-bits parameter to ssi_transfer instead.

> > +    }
> > +
> > +    for (i =3D 0; i < size; i++) {
> > +        value |=3D ssi_transfer(fiu->spi, 0) << (8 * i);
> > +    }
> > +
>
> Ditto npcm7xx_fiu_deselect().

Will do.

> > +    qemu_irq_raise(fiu->cs_lines[cs_id]);
> > +
> > +    trace_npcm7xx_fiu_flash_read(DEVICE(fiu)->canonical_path, cs_id, a=
ddr, size,
> > +                                 value);
> > +
> > +    return value;
> > +}
> > +
> > +/* Direct flash memory write handler. */
> > +static void npcm7xx_fiu_flash_write(void *opaque, hwaddr addr, uint64_=
t v,
> > +                                    unsigned int size)
> > +{
> > +    NPCM7xxFIUFlash *f =3D opaque;
> > +    NPCM7xxFIUState *fiu =3D f->fiu;
> > +    int cs_id =3D f - fiu->flash;
> > +    uint32_t dwr_cfg;
> > +    int i;
> > +
> > +    trace_npcm7xx_fiu_flash_write(DEVICE(fiu)->canonical_path, cs_id, =
addr,
> > +                                  size, v);
> > +
> > +    dwr_cfg =3D fiu->regs[NPCM7XX_FIU_DWR_CFG];
> > +
> > +    qemu_irq_lower(fiu->cs_lines[cs_id]);
> > +    ssi_transfer(fiu->spi, FIU_DWR_CFG_WRCMD(dwr_cfg));
> > +
> > +    switch (FIU_DWR_CFG_ADDSIZ(dwr_cfg)) {
> > +    case FIU_ADDSIZ_4BYTES:
> > +        ssi_transfer(fiu->spi, extract32(addr, 24, 8));
> > +        /* fall through */
> > +    case FIU_ADDSIZ_3BYTES:
> > +        ssi_transfer(fiu->spi, extract32(addr, 16, 8));
> > +        ssi_transfer(fiu->spi, extract32(addr, 8, 8));
> > +        ssi_transfer(fiu->spi, extract32(addr, 0, 8));
> > +        break;
> > +
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad address size %d\n",
> > +                      DEVICE(fiu)->canonical_path, FIU_DWR_CFG_ADDSIZ(=
dwr_cfg));
> > +        break;
> > +    }
> > +
> > +    for (i =3D 0; i < size; i++) {
> > +        ssi_transfer(fiu->spi, v & 0xff);
> > +        v >>=3D 8;
>
> Or since you use deposit32() in transaction():
>
>            extract32(v, 8 * i, 8);

Needs to be extract64(), but done. Also, deposit64() in flash_read().

> > +    }
> > +
> > +    qemu_irq_raise(fiu->cs_lines[cs_id]);
> > +}
> > +
> > +static const MemoryRegionOps npcm7xx_fiu_flash_ops =3D {
> > +    .read =3D npcm7xx_fiu_flash_read,
> > +    .write =3D npcm7xx_fiu_flash_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 1,
> > +        .max_access_size =3D 8,
>
> Are you sure? Maybe, I can' tell.

Real hardware supports 16 bytes, but there's no way to do more than 8
in emulation, I think?

> > +        .unaligned =3D true,
> > +    },
> > +};
> > +
> > +/* Control register read handler. */
> > +static uint64_t npcm7xx_fiu_ctrl_read(void *opaque, hwaddr addr,
> > +                                      unsigned int size)
> > +{
> > +    hwaddr reg =3D addr / sizeof(uint32_t);
> > +    NPCM7xxFIUState *s =3D opaque;
> > +    uint32_t value;
> > +
> > +    if (reg < NPCM7XX_FIU_NR_REGS) {
> > +        value =3D s->regs[reg];
> > +    } else {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: read from invalid offset 0x%" PRIx64 "\n",
> > +                      DEVICE(s)->canonical_path, addr);
> > +        value =3D 0;
> > +    }
> > +
> > +    trace_npcm7xx_fiu_ctrl_read(DEVICE(s)->canonical_path, addr, value=
);
> > +
> > +    return value;
> > +}
> > +
> > +/* Send the specified number of address bytes from the UMA address reg=
ister. */
> > +static void send_address(SSIBus *spi, unsigned int addsiz, uint32_t ad=
dr)
> > +{
> > +    /* All cases fall through */
>
> Is this comment recognized by -Wimplicit-fallthrough?

Nope. I'll use proper fallthrough comments.

> > +    switch (addsiz) {
> > +    case 4:
> > +        ssi_transfer(spi, extract32(addr, 24, 8));
> > +    case 3:
> > +        ssi_transfer(spi, extract32(addr, 16, 8));
> > +    case 2:
> > +        ssi_transfer(spi, extract32(addr, 8, 8));
> > +    case 1:
> > +        ssi_transfer(spi, extract32(addr, 0, 8));
> > +    case 0:
> > +        break;
> > +    }
> > +}
> > +
> > +/* Send the number of dummy bits specified in the UMA config register.=
 */
> > +static void send_dummy_bits(SSIBus *spi, uint32_t uma_cfg, uint32_t um=
a_cmd)
> > +{
> > +    unsigned int bits_per_clock =3D 1U << FIU_UMA_CFG_DBPCK(uma_cfg);
> > +    unsigned int i;
> > +
> > +    for (i =3D 0; i < FIU_UMA_CFG_DBSIZ(uma_cfg); i++) {
> > +        /* Use bytes 0 and 1 first, then keep repeating byte 2 */
> > +        unsigned int field =3D (i < 2) ? ((i + 1) * 8) : 24;
> > +        unsigned int j;
> > +
> > +        for (j =3D 0; j < 8; j +=3D bits_per_clock) {
> > +            ssi_transfer(spi, extract32(uma_cmd, field + j, bits_per_c=
lock));
> > +        }
> > +    }
> > +}
> > +
> > +/* Assert the chip select specified in the UMA Control/Status Register=
. */
> > +static void npcm7xx_fiu_select(NPCM7xxFIUState *s)
> > +{
> > +    int cs_id;
> > +
> > +    cs_id =3D FIU_UMA_CTS_DEV_NUM(s->regs[NPCM7XX_FIU_UMA_CTS]);
> > +    if (cs_id < s->cs_count) {
> > +        qemu_irq_lower(s->cs_lines[cs_id]);
> > +    } else {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: UMA to CS%d; this module has only %d chip s=
elects",
> > +                      DEVICE(s)->canonical_path, cs_id, s->cs_count);
> > +        cs_id =3D -1;
> > +    }
> > +
> > +    s->active_cs =3D cs_id;
> > +}
> > +
> > +/* Deassert the currently active chip select. */
> > +static void npcm7xx_fiu_deselect(NPCM7xxFIUState *s)
> > +{
> > +    if (s->active_cs < 0) {
> > +        return;
> > +    }
> > +
> > +    qemu_irq_raise(s->cs_lines[s->active_cs]);
> > +    s->active_cs =3D -1;
> > +}
> > +
> > +/* Perform a User-Mode Access transaction. */
> > +static void npcm7xx_fiu_uma_transaction(NPCM7xxFIUState *s)
> > +{
> > +    uint32_t uma_cts =3D s->regs[NPCM7XX_FIU_UMA_CTS];
> > +    uint32_t uma_cfg;
> > +    unsigned int i;
> > +
> > +    /* SW_CS means the CS is already forced low, so don't touch it. */
> > +    if (uma_cts & FIU_UMA_CTS_SW_CS) {
> > +        npcm7xx_fiu_select(s);
> > +    }
> > +
> > +    /* Send command, if present. */
> > +    uma_cfg =3D s->regs[NPCM7XX_FIU_UMA_CFG];
> > +    if (FIU_UMA_CFG_CMDSIZ(uma_cfg) > 0) {
> > +        ssi_transfer(s->spi, extract32(s->regs[NPCM7XX_FIU_UMA_CMD], 0=
, 8));
> > +    }
> > +
> > +    /* Send address, if present. */
> > +    send_address(s->spi, FIU_UMA_CFG_ADDSIZ(uma_cfg),
> > +                 s->regs[NPCM7XX_FIU_UMA_ADDR]);
> > +
> > +    /* Write data, if present. */
> > +    for (i =3D 0; i < FIU_UMA_CFG_WDATSIZ(uma_cfg); i++) {
> > +        unsigned int reg =3D
> > +            (i < 16) ? (NPCM7XX_FIU_UMA_DW0 + i / 4) : NPCM7XX_FIU_UMA=
_DW3;
> > +        unsigned int field =3D (i % 4) * 8;
> > +
> > +        ssi_transfer(s->spi, extract32(s->regs[reg], field, 8));
> > +    }
> > +
> > +    /* Send aummy bits, if present. */
>
> Typo "dummy" ;)
>
> > +    send_dummy_bits(s->spi, uma_cfg, s->regs[NPCM7XX_FIU_UMA_CMD]);
> > +
> > +    /* Read data, if present. */
> > +    for (i =3D 0; i < FIU_UMA_CFG_RDATSIZ(uma_cfg); i++) {
> > +        unsigned int reg =3D NPCM7XX_FIU_UMA_DR0 + i / 4;
> > +        unsigned int field =3D (i % 4) * 8;
> > +        uint8_t c;
> > +
> > +        c =3D ssi_transfer(s->spi, 0);
> > +        if (reg <=3D NPCM7XX_FIU_UMA_DR3) {
> > +            s->regs[reg] =3D deposit32(s->regs[reg], field, 8, c);
> > +        }
> > +    }
> > +
> > +    /* Again, don't touch CS if the user is forcing it low. */
> > +    if (uma_cts & FIU_UMA_CTS_SW_CS) {
> > +        npcm7xx_fiu_deselect(s);
> > +    }
> > +
> > +    /* RDYST means a command has completed since it was cleared. */
> > +    s->regs[NPCM7XX_FIU_UMA_CTS] |=3D FIU_UMA_CTS_RDYST;
> > +    /* EXEC_DONE means Execute Command / Not Done, so clear it here. *=
/
> > +    s->regs[NPCM7XX_FIU_UMA_CTS] &=3D ~FIU_UMA_CTS_EXEC_DONE;
> > +}
> > +
> > +/* Control register write handler. */
> > +static void npcm7xx_fiu_ctrl_write(void *opaque, hwaddr addr, uint64_t=
 v,
> > +                                   unsigned int size)
> > +{
> > +    hwaddr reg =3D addr / sizeof(uint32_t);
> > +    NPCM7xxFIUState *s =3D opaque;
> > +    uint32_t value =3D v;
> > +
> > +    trace_npcm7xx_fiu_ctrl_write(DEVICE(s)->canonical_path, addr, valu=
e);
> > +
> > +    switch (reg) {
> > +    case NPCM7XX_FIU_UMA_CFG:
> > +        if (s->regs[reg] & FIU_UMA_CFG_CMMLCK) {
> > +            value &=3D ~FIU_UMA_CFG_CMMLCK_MASK;
> > +            value |=3D (s->regs[reg] & FIU_UMA_CFG_CMMLCK_MASK);
> > +        }
> > +        /* fall through */
> > +    case NPCM7XX_FIU_DRD_CFG:
> > +    case NPCM7XX_FIU_DWR_CFG:
> > +        if (s->regs[reg] & NPCM7XX_FIU_CFG_LCK) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s: write to locked register @ 0x%" PRIx64 =
"\n",
> > +                          DEVICE(s)->canonical_path, addr);
> > +            return;
> > +        }
> > +        s->regs[reg] =3D value;
> > +        break;
> > +
> > +    case NPCM7XX_FIU_UMA_CTS:
> > +        if (value & FIU_UMA_CTS_RDYST) {
> > +            value &=3D ~FIU_UMA_CTS_RDYST;
> > +        } else {
> > +            value |=3D s->regs[reg] & FIU_UMA_CTS_RDYST;
> > +        }
> > +        if ((s->regs[reg] ^ value) & FIU_UMA_CTS_SW_CS) {
> > +            if (value & FIU_UMA_CTS_SW_CS) {
> > +                /*
> > +                 * Don't drop CS if there's a transfer in progress, or=
 we're
> > +                 * about to start one.
> > +                 */
> > +                if (!((value | s->regs[reg]) & FIU_UMA_CTS_EXEC_DONE))=
 {
> > +                    npcm7xx_fiu_deselect(s);
> > +                }
> > +            } else {
> > +                npcm7xx_fiu_select(s);
> > +            }
> > +        }
> > +        s->regs[reg] =3D value | (s->regs[reg] & FIU_UMA_CTS_EXEC_DONE=
);
> > +        if (value & FIU_UMA_CTS_EXEC_DONE) {
> > +            npcm7xx_fiu_uma_transaction(s);
> > +        }
> > +        break;
> > +
> > +    case NPCM7XX_FIU_UMA_DR0 ... NPCM7XX_FIU_UMA_DR3:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: write to read-only register @ 0x%" PRIx64 "=
\n",
> > +                      DEVICE(s)->canonical_path, addr);
> > +        return;
> > +
> > +    case NPCM7XX_FIU_PRT_CFG:
> > +    case NPCM7XX_FIU_PRT_CMD0 ... NPCM7XX_FIU_PRT_CMD9:
> > +        qemu_log_mask(LOG_UNIMP, "%s: PRT is not implemented\n", __fun=
c__);
> > +        break;
> > +
> > +    case NPCM7XX_FIU_UMA_CMD:
> > +    case NPCM7XX_FIU_UMA_ADDR:
> > +    case NPCM7XX_FIU_UMA_DW0 ... NPCM7XX_FIU_UMA_DW3:
> > +    case NPCM7XX_FIU_CFG:
> > +        s->regs[reg] =3D value;
> > +        break;
> > +
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: write to invalid offset 0x%" PRIx64 "\n",
> > +                      DEVICE(s)->canonical_path, addr);
> > +        return;
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps npcm7xx_fiu_ctrl_ops =3D {
> > +    .read =3D npcm7xx_fiu_ctrl_read,
> > +    .write =3D npcm7xx_fiu_ctrl_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +        .unaligned =3D false,
> > +    },
> > +};
> > +
> > +static void npcm7xx_fiu_enter_reset(Object *obj, ResetType type)
> > +{
> > +    NPCM7xxFIUState *s =3D NPCM7XX_FIU(obj);
> > +
> > +    trace_npcm7xx_fiu_enter_reset(DEVICE(obj)->canonical_path, type);
> > +
> > +    memset(s->regs, 0, sizeof(s->regs));
> > +
> > +    s->regs[NPCM7XX_FIU_DRD_CFG] =3D 0x0300100b;
> > +    s->regs[NPCM7XX_FIU_DWR_CFG] =3D 0x03000002;
> > +    s->regs[NPCM7XX_FIU_UMA_CFG] =3D 0x00000400;
> > +    s->regs[NPCM7XX_FIU_UMA_CTS] =3D 0x00010000;
> > +    s->regs[NPCM7XX_FIU_UMA_CMD] =3D 0x0000000b;
> > +    s->regs[NPCM7XX_FIU_PRT_CFG] =3D 0x00000400;
> > +    s->regs[NPCM7XX_FIU_CFG] =3D 0x0000000b;
> > +}
> > +
> > +static void npcm7xx_fiu_hold_reset(Object *obj)
> > +{
> > +    NPCM7xxFIUState *s =3D NPCM7XX_FIU(obj);
> > +    int i;
> > +
> > +    trace_npcm7xx_fiu_hold_reset(DEVICE(obj)->canonical_path);
> > +
> > +    for (i =3D 0; i < s->cs_count; i++) {
> > +        qemu_irq_raise(s->cs_lines[i]);
> > +    }
> > +}
> > +
> > +static void npcm7xx_fiu_realize(DeviceState *dev, Error **errp)
> > +{
> > +    NPCM7xxFIUState *s =3D NPCM7XX_FIU(dev);
> > +    SysBusDevice *sbd =3D &s->parent;
> > +    int i;
> > +
> > +    if (s->cs_count <=3D 0) {
> > +        error_setg(errp, "%s: %d chip selects specified, need at least=
 one",
> > +                   dev->canonical_path, s->cs_count);
> > +        return;
> > +    }
> > +
> > +    s->spi =3D ssi_create_bus(dev, "spi");
> > +    s->cs_lines =3D g_new0(qemu_irq, s->cs_count);
>
> More recent API:
>
>        qdev_init_gpio_out_named(dev, &s->cs_count, "cs", s->cs_count);

Cool. Also made a matching change in npcm7xx_boards.c.

> > +    s->flash =3D g_new0(NPCM7xxFIUFlash, s->cs_count);
> > +
> > +    /*
> > +     * Register the control registers region first. It may be followed=
 by one
> > +     * or more direct flash access regions.
> > +     */
> > +    memory_region_init_io(&s->mmio, OBJECT(s), &npcm7xx_fiu_ctrl_ops, =
s, "ctrl",
> > +                          NPCM7XX_FIU_CTRL_REGS_SIZE);
> > +    sysbus_init_mmio(sbd, &s->mmio);
> > +
> > +    for (i =3D 0; i < s->cs_count; i++) {
> > +        NPCM7xxFIUFlash *flash =3D &s->flash[i];
> > +        sysbus_init_irq(sbd, &s->cs_lines[i]);
> > +        flash->fiu =3D s;
> > +        memory_region_init_io(&flash->direct_access, OBJECT(s),
> > +                              &npcm7xx_fiu_flash_ops, &s->flash[i], "f=
lash",
> > +                              NPCM7XX_FIU_FLASH_WINDOW_SIZE);
> > +        sysbus_init_mmio(sbd, &flash->direct_access);
> > +    }
> > +}
> > +
> > +static const VMStateDescription vmstate_npcm7xx_fiu =3D {
> > +    .name =3D "npcm7xx-fiu",
> > +    .version_id =3D 0,
> > +    .minimum_version_id =3D 0,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_INT32(active_cs, NPCM7xxFIUState),
> > +        VMSTATE_UINT32_ARRAY(regs, NPCM7xxFIUState, NPCM7XX_FIU_NR_REG=
S),
> > +        VMSTATE_END_OF_LIST(),
> > +    },
> > +};
> > +
> > +static Property npcm7xx_fiu_properties[] =3D {
> > +    DEFINE_PROP_INT32("cs-count", NPCM7xxFIUState, cs_count, 0),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void npcm7xx_fiu_class_init(ObjectClass *klass, void *data)
> > +{
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->desc =3D "NPCM7xx Flash Interface Unit";
> > +    dc->realize =3D npcm7xx_fiu_realize;
> > +    dc->vmsd =3D &vmstate_npcm7xx_fiu;
> > +    rc->phases.enter =3D npcm7xx_fiu_enter_reset;
> > +    rc->phases.hold =3D npcm7xx_fiu_hold_reset;
> > +    device_class_set_props(dc, npcm7xx_fiu_properties);
> > +}
> > +
> > +static const TypeInfo npcm7xx_fiu_types[] =3D {
> > +    {
> > +        .name =3D TYPE_NPCM7XX_FIU,
> > +        .parent =3D TYPE_SYS_BUS_DEVICE,
> > +        .instance_size =3D sizeof(NPCM7xxFIUState),
> > +        .class_init =3D npcm7xx_fiu_class_init,
> > +    },
> > +};
> > +DEFINE_TYPES(npcm7xx_fiu_types);
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index a31d0d282f..8d0ef0593b 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -360,6 +360,7 @@ config NPCM7XX
> >      select ARM_GIC
> >      select PL310  # cache controller
> >      select SERIAL
> > +    select SSI
> >      select UNIMP
> >
> >  config FSL_IMX25
> > diff --git a/hw/ssi/Makefile.objs b/hw/ssi/Makefile.objs
> > index 07a85f1967..cab48e72c9 100644
> > --- a/hw/ssi/Makefile.objs
> > +++ b/hw/ssi/Makefile.objs
> > @@ -5,6 +5,7 @@ common-obj-$(CONFIG_XILINX_SPIPS) +=3D xilinx_spips.o
> >  common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_smc.o
> >  common-obj-$(CONFIG_STM32F2XX_SPI) +=3D stm32f2xx_spi.o
> >  common-obj-$(CONFIG_MSF2) +=3D mss-spi.o
> > +common-obj-$(CONFIG_NPCM7XX) +=3D npcm7xx_fiu.o
> >
> >  common-obj-$(CONFIG_OMAP) +=3D omap_spi.o
> >  common-obj-$(CONFIG_IMX) +=3D imx_spi.o
> > diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
> > index 0ea498de91..8024253c1f 100644
> > --- a/hw/ssi/trace-events
> > +++ b/hw/ssi/trace-events
> > @@ -9,3 +9,12 @@ aspeed_smc_dma_checksum(uint32_t addr, uint32_t data) =
"0x%08x: 0x%08x"
> >  aspeed_smc_dma_rw(const char *dir, uint32_t flash_addr, uint32_t dram_=
addr, uint32_t size) "%s flash:@0x%08x dram:@0x%08x size:0x%08x"
> >  aspeed_smc_write(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" =
PRIx64 " size %u: 0x%" PRIx64
> >  aspeed_smc_flash_select(int cs, const char *prefix) "CS%d %sselect"
> > +
> > +# npcm7xx_fiu.c
> > +
> > +npcm7xx_fiu_enter_reset(const char *id, int reset_type) "%s reset type=
: %d"
> > +npcm7xx_fiu_hold_reset(const char *id) "%s"
> > +npcm7xx_fiu_ctrl_read(const char *id, uint64_t addr, uint32_t data) "%=
s offset: 0x%04" PRIx64 " value: 0x%08x"
> > +npcm7xx_fiu_ctrl_write(const char *id, uint64_t addr, uint32_t data) "=
%s offset: 0x%04" PRIx64 " value: 0x%08x"
>
> Nitpicking again: PRIx32 :p

Will do.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks!

> > +npcm7xx_fiu_flash_read(const char *id, int cs, uint64_t addr, unsigned=
 int size, uint64_t value) "%s[%d] offset: 0x%08" PRIx64 " size: %u value: =
0x%" PRIx64
> > +npcm7xx_fiu_flash_write(const char *id, int cs, uint64_t addr, unsigne=
d int size, uint64_t value) "%s[%d] offset: 0x%08" PRIx64 " size: %u value:=
 0x%" PRIx64
> >

