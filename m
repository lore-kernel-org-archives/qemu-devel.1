Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82A8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 06:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813BD206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 06:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjrNQNdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813BD206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtQIb-0003ZL-Qk
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 02:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtQHv-00032b-GN
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 02:44:07 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:39696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtQHs-0002rj-Gr
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 02:44:07 -0400
Received: by mail-vs1-xe43.google.com with SMTP id a17so528267vsq.6
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 23:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=W0l2rdO2Fku6Mx/WWv4guDLgkeW6dXqxfcA6PXV5duY=;
 b=gjrNQNdq453283nja1JxMghY+GGudj8c8dZz+mcQYCFN5he8CLgk9LGZfP+RvWeXm6
 zSz/LQACsDFd7JpNcp8MvQVpmLKXM/1jixGdIG7IuiG0GDRjAuxp/Tnodsxf/KqmX1aL
 Rix/aW+/j8gtDQIo1DMOlEIJbIKsojhXTLCJWsNFY6qo9ASk4fyshOHH0yUXyzZ9ku42
 7q/yo/EuHWO8zLlif53D/lz2Yj0YpWt+CEClLblX6JlMrZd28dIft8/aI/WjqNSSvZ9Y
 od+ldIE144/hoY6W/V1jKCAhOKWMggC200iAM7Dzcg6WSuskw/qBLhLXMnLxA1ZvwTdW
 ic4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=W0l2rdO2Fku6Mx/WWv4guDLgkeW6dXqxfcA6PXV5duY=;
 b=oPoMalSBmYFAhVx61bYYtXumnZjMU3nsmSq3Hkw6jLRc4D43QtVlT3IP11rRgcAj9W
 Ra5BvknElRToFIHbldMy3tbyvCi7IHvbm1KY1ZBiNSFgxqopURuhhAz6ivK6LYxmy34x
 ZQdNTuklMz+xHNf9qp8i/sgRIsLhKAtqxLpDh0vXZc+NqxZp029+mYvhihywwghVg79B
 4DHROX5JPrikv9Dq9jM6WREAQkKXcumORm/+dmFJy91e5HFFNKbkiOio9tynXZGSGSd7
 4KvIG3dXKURzudgnKbHFNoBSQn/Ts1mPeKj29H1DqkBJDxIdbCURBIF/3GF7aOmRjm5H
 AqeA==
X-Gm-Message-State: AOAM533JV6I9xoW4KleZvI3COJTmL29oHxzAycbyi9HmQXVw4XpzYunb
 TLCais8cGBGQRMWFHfMXrV/P8wpZ44ckW3AoRoQCqA==
X-Google-Smtp-Source: ABdhPJycsJpX9y5VyhC/P5AqJ7vHhPPIY3dpPpanAOVnmwzXypO4VkCBqjFME3KWYFwpElSffbKJrH+6D26sJI3VBzQ=
X-Received: by 2002:a67:e0c3:: with SMTP id m3mr48444930vsl.1.1594277042843;
 Wed, 08 Jul 2020 23:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-2-hskinnemoen@google.com>
 <2fe8ea5e-56de-f57f-6146-8355125daa7f@amsat.org>
In-Reply-To: <2fe8ea5e-56de-f57f-6146-8355125daa7f@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Wed, 8 Jul 2020 23:43:51 -0700
Message-ID: <CAFQmdRYx99PpWz6bftCvBR7=YRftD_WNex_A9aoDaeRg=4tsCw@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] hw/misc: Add NPCM7xx System Global Control
 Registers device model
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e43;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe43.google.com
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

On Wed, Jul 8, 2020 at 11:04 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 7/9/20 2:35 AM, Havard Skinnemoen wrote:
> > Implement a device model for the System Global Control Registers in the
> > NPCM730 and NPCM750 BMC SoCs.
> >
> > This is primarily used to enable SMP boot (the boot ROM spins reading
> > the SCRPAD register) and DDR memory initialization; other registers are
> > best effort for now.
> >
> > The reset values of the MDLR and PWRON registers are determined by the
> > SoC variant (730 vs 750) and board straps respectively.
> >
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> > ---
> >  include/hw/misc/npcm7xx_gcr.h |  76 ++++++++++++
> >  hw/misc/npcm7xx_gcr.c         | 226 ++++++++++++++++++++++++++++++++++
> >  MAINTAINERS                   |   8 ++
> >  hw/arm/Kconfig                |   3 +
> >  hw/misc/Makefile.objs         |   1 +
> >  hw/misc/trace-events          |   4 +
> >  6 files changed, 318 insertions(+)
> >  create mode 100644 include/hw/misc/npcm7xx_gcr.h
> >  create mode 100644 hw/misc/npcm7xx_gcr.c
> >
> > diff --git a/include/hw/misc/npcm7xx_gcr.h b/include/hw/misc/npcm7xx_gc=
r.h
> > new file mode 100644
> > index 0000000000..4884676be2
> > --- /dev/null
> > +++ b/include/hw/misc/npcm7xx_gcr.h
> > @@ -0,0 +1,76 @@
> > +/*
> > + * Nuvoton NPCM7xx System Global Control Registers.
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
> > +#ifndef NPCM7XX_GCR_H
> > +#define NPCM7XX_GCR_H
> > +
> > +#include "exec/memory.h"
> > +#include "hw/sysbus.h"
> > +
> > +enum NPCM7xxGCRRegisters {
> > +    NPCM7XX_GCR_PDID,
> > +    NPCM7XX_GCR_PWRON,
> > +    NPCM7XX_GCR_MFSEL1          =3D 0x0c / sizeof(uint32_t),
> > +    NPCM7XX_GCR_MFSEL2,
> > +    NPCM7XX_GCR_MISCPE,
> > +    NPCM7XX_GCR_SPSWC           =3D 0x038 / sizeof(uint32_t),
> > +    NPCM7XX_GCR_INTCR,
> > +    NPCM7XX_GCR_INTSR,
> > +    NPCM7XX_GCR_HIFCR           =3D 0x050 / sizeof(uint32_t),
> > +    NPCM7XX_GCR_INTCR2          =3D 0x060 / sizeof(uint32_t),
> > +    NPCM7XX_GCR_MFSEL3,
> > +    NPCM7XX_GCR_SRCNT,
> > +    NPCM7XX_GCR_RESSR,
> > +    NPCM7XX_GCR_RLOCKR1,
> > +    NPCM7XX_GCR_FLOCKR1,
> > +    NPCM7XX_GCR_DSCNT,
> > +    NPCM7XX_GCR_MDLR,
> > +    NPCM7XX_GCR_SCRPAD3,
> > +    NPCM7XX_GCR_SCRPAD2,
> > +    NPCM7XX_GCR_DAVCLVLR        =3D 0x098 / sizeof(uint32_t),
> > +    NPCM7XX_GCR_INTCR3,
> > +    NPCM7XX_GCR_VSINTR          =3D 0x0ac / sizeof(uint32_t),
> > +    NPCM7XX_GCR_MFSEL4,
> > +    NPCM7XX_GCR_CPBPNTR         =3D 0x0c4 / sizeof(uint32_t),
> > +    NPCM7XX_GCR_CPCTL           =3D 0x0d0 / sizeof(uint32_t),
> > +    NPCM7XX_GCR_CP2BST,
> > +    NPCM7XX_GCR_B2CPNT,
> > +    NPCM7XX_GCR_CPPCTL,
> > +    NPCM7XX_GCR_I2CSEGSEL,
> > +    NPCM7XX_GCR_I2CSEGCTL,
> > +    NPCM7XX_GCR_VSRCR,
> > +    NPCM7XX_GCR_MLOCKR,
> > +    NPCM7XX_GCR_SCRPAD          =3D 0x013c / sizeof(uint32_t),
> > +    NPCM7XX_GCR_USB1PHYCTL,
> > +    NPCM7XX_GCR_USB2PHYCTL,
> > +    NPCM7XX_GCR_NR_REGS,
> > +};
> > +
> > +typedef struct NPCM7xxGCRState {
> > +    SysBusDevice parent;
> > +
> > +    MemoryRegion iomem;
> > +
> > +    uint32_t regs[NPCM7XX_GCR_NR_REGS];
> > +
> > +    uint32_t reset_pwron;
> > +    uint32_t reset_mdlr;
> > +    uint32_t reset_intcr3;
> > +} NPCM7xxGCRState;
> > +
> > +#define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
> > +#define NPCM7XX_GCR(obj) OBJECT_CHECK(NPCM7xxGCRState, (obj), TYPE_NPC=
M7XX_GCR)
> > +
> > +#endif /* NPCM7XX_GCR_H */
> > diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm7xx_gcr.c
> > new file mode 100644
> > index 0000000000..9934cd238d
> > --- /dev/null
> > +++ b/hw/misc/npcm7xx_gcr.c
> > @@ -0,0 +1,226 @@
> > +/*
> > + * Nuvoton NPCM7xx System Global Control Registers.
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
> > +#include "hw/misc/npcm7xx_gcr.h"
> > +#include "hw/qdev-properties.h"
> > +#include "migration/vmstate.h"
> > +#include "qapi/error.h"
> > +#include "qemu/log.h"
> > +#include "qemu/module.h"
> > +#include "qemu/units.h"
> > +
> > +#include "trace.h"
> > +
> > +static const uint32_t cold_reset_values[NPCM7XX_GCR_NR_REGS] =3D {
> > +    [NPCM7XX_GCR_PDID]          =3D 0x04a92750,   /* Poleg A1 */
> > +    [NPCM7XX_GCR_MISCPE]        =3D 0x0000ffff,
> > +    [NPCM7XX_GCR_SPSWC]         =3D 0x00000003,
> > +    [NPCM7XX_GCR_INTCR]         =3D 0x0000035e,
> > +    [NPCM7XX_GCR_HIFCR]         =3D 0x0000004e,
> > +    [NPCM7XX_GCR_INTCR2]        =3D (1U << 19),   /* DDR initialized *=
/
> > +    [NPCM7XX_GCR_RESSR]         =3D 0x80000000,
> > +    [NPCM7XX_GCR_DSCNT]         =3D 0x000000c0,
> > +    [NPCM7XX_GCR_DAVCLVLR]      =3D 0x5a00f3cf,
> > +    [NPCM7XX_GCR_SCRPAD]        =3D 0x00000008,
> > +    [NPCM7XX_GCR_USB1PHYCTL]    =3D 0x034730e4,
> > +    [NPCM7XX_GCR_USB2PHYCTL]    =3D 0x034730e4,
> > +};
> > +
> > +static uint64_t npcm7xx_gcr_read(void *opaque, hwaddr offset, unsigned=
 size)
> > +{
> > +    uint32_t reg =3D offset / sizeof(uint32_t);
> > +    NPCM7xxGCRState *s =3D opaque;
> > +
> > +    if (reg >=3D NPCM7XX_GCR_NR_REGS) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: offset 0x%04x out of range=
\n",
> > +                      __func__, (unsigned int)offset);
>
> Maybe use HWADDR_PRIx instead of casting to int?

Will do, thanks!

>
> > +        return 0;
> > +    }
> > +
> > +    trace_npcm7xx_gcr_read(offset, s->regs[reg]);
> > +
> > +    return s->regs[reg];
> > +}
> > +
> > +static void npcm7xx_gcr_write(void *opaque, hwaddr offset,
> > +                              uint64_t v, unsigned size)
> > +{
> > +    uint32_t reg =3D offset / sizeof(uint32_t);
> > +    NPCM7xxGCRState *s =3D opaque;
> > +    uint32_t value =3D v;
> > +
> > +    trace_npcm7xx_gcr_write(offset, value);
> > +
> > +    if (reg >=3D NPCM7XX_GCR_NR_REGS) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: offset 0x%04x out of range=
\n",
> > +                      __func__, (unsigned int)offset);
> > +        return;
> > +    }
> > +
> > +    switch (reg) {
> > +    case NPCM7XX_GCR_PDID:
> > +    case NPCM7XX_GCR_PWRON:
> > +    case NPCM7XX_GCR_INTSR:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: register @ 0x%04x is read-=
only\n",
> > +                      __func__, (unsigned int)offset);
> > +        return;
> > +
> > +    case NPCM7XX_GCR_RESSR:
> > +    case NPCM7XX_GCR_CP2BST:
> > +        /* Write 1 to clear */
> > +        value =3D s->regs[reg] & ~value;
> > +        break;
> > +
> > +    case NPCM7XX_GCR_RLOCKR1:
> > +    case NPCM7XX_GCR_MDLR:
> > +        /* Write 1 to set */
> > +        value |=3D s->regs[reg];
> > +        break;
> > +    };
> > +
> > +    s->regs[reg] =3D value;
> > +}
> > +
> > +static const struct MemoryRegionOps npcm7xx_gcr_ops =3D {
> > +    .read       =3D npcm7xx_gcr_read,
> > +    .write      =3D npcm7xx_gcr_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid      =3D {
> > +        .min_access_size        =3D 4,
> > +        .max_access_size        =3D 4,
> > +        .unaligned              =3D false,
> > +    },
> > +};
> > +
> > +static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
>
> 2nd user of this new API, nice :)
>
> > +{
> > +    NPCM7xxGCRState *s =3D NPCM7XX_GCR(obj);
> > +
> > +    QEMU_BUILD_BUG_ON(sizeof(s->regs) !=3D sizeof(cold_reset_values));
> > +
> > +    switch (type) {
> > +    case RESET_TYPE_COLD:
> > +        memcpy(s->regs, cold_reset_values, sizeof(s->regs));
> > +        s->regs[NPCM7XX_GCR_PWRON] =3D s->reset_pwron;
> > +        s->regs[NPCM7XX_GCR_MDLR] =3D s->reset_mdlr;
> > +        s->regs[NPCM7XX_GCR_INTCR3] =3D s->reset_intcr3;
> > +        break;
> > +    }
> > +}
> > +
> > +static void npcm7xx_gcr_realize(DeviceState *dev, Error **errp)
> > +{
> > +    NPCM7xxGCRState *s =3D NPCM7XX_GCR(dev);
> > +    uint64_t dram_size;
> > +    Error *err =3D NULL;
> > +    Object *obj;
> > +
> > +    obj =3D object_property_get_link(OBJECT(dev), "dram-mr", &err);
> > +    if (!obj) {
> > +        error_setg(errp, "%s: required dram-mr link not found: %s",
> > +                   __func__, error_get_pretty(err));
> > +        return;
> > +    }
> > +    dram_size =3D memory_region_size(MEMORY_REGION(obj));
> > +
> > +    /* Power-on reset value */
> > +    s->reset_intcr3 =3D 0x00001002;
> > +
> > +    /*
> > +     * The GMMAP (Graphics Memory Map) field is used by u-boot to dete=
ct the
> > +     * DRAM size, and is normally initialized by the boot block as par=
t of DRAM
> > +     * training. However, since we don't have a complete emulation of =
the
> > +     * memory controller and try to make it look like it has already b=
een
> > +     * initialized, the boot block will skip this initialization, and =
we need
> > +     * to make sure this field is set correctly up front.
> > +     *
> > +     * WARNING: some versions of u-boot only looks at bits 8 and 9, so=
 2 GiB or
> > +     * more of DRAM will be interpreted as 128 MiB.
>
> I'd say u-boot is right in wrapping at 2GB, as more DRAM is
> un-addressable.

Ah, maybe I shouldn't have said "or more". The bug is that if you
specify _exactly_ 2GiB, u-boot will see 128 MiB.

But I agree more than 2GiB doesn't make sense, so I'll add a check for that=
.

Not sure if I agree that the check should be here. > 2 GiB is an
addressing limitation, and the GCR module shouldn't really know what
the SoC's address space looks like. The lower limit is because the GCR
module can't encode anything less than 128 MiB.

> > +     *
> > +     * https://github.com/Nuvoton-Israel/u-boot/blob/2aef993bd2aafeb54=
08dbaad0f3ce099ee40c4aa/board/nuvoton/poleg/poleg.c#L244
> > +     */
> > +    if (dram_size >=3D 2 * GiB) {
>
> See my comment in this series on the machine patch.
>
> > +        s->reset_intcr3 |=3D 4 << 8;
> > +    } else if (dram_size >=3D 1 * GiB) {
> > +        s->reset_intcr3 |=3D 3 << 8;
> > +    } else if (dram_size >=3D 512 * MiB) {
> > +        s->reset_intcr3 |=3D 2 << 8;
> > +    } else if (dram_size >=3D 256 * MiB) {
> > +        s->reset_intcr3 |=3D 1 << 8;
> > +    } else if (dram_size >=3D 128 * MiB) {
> > +        s->reset_intcr3 |=3D 0 << 8;
> > +    } else {
> > +        error_setg(errp,
> > +                   "npcm7xx_gcr: DRAM size %" PRIu64
> > +                   " is too small (need 128 MiB minimum)",
> > +                   dram_size);
>
> Ah, so you could add the same error for >2GB. Easier.
>
> Preferably using HWADDR_PRIx, and similar error for >2GB:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> > +        return;
> > +    }
> > +}
> > +
> > +static void npcm7xx_gcr_init(Object *obj)
> > +{
> > +    NPCM7xxGCRState *s =3D NPCM7XX_GCR(obj);
> > +
> > +    memory_region_init_io(&s->iomem, obj, &npcm7xx_gcr_ops, s,
> > +                          TYPE_NPCM7XX_GCR, 4 * KiB);
> > +    sysbus_init_mmio(&s->parent, &s->iomem);
> > +}
> > +
> > +static const VMStateDescription vmstate_npcm7xx_gcr =3D {
> > +    .name =3D "npcm7xx-gcr",
> > +    .version_id =3D 0,
> > +    .minimum_version_id =3D 0,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT32_ARRAY(regs, NPCM7xxGCRState, NPCM7XX_GCR_NR_REG=
S),
> > +        VMSTATE_END_OF_LIST(),
> > +    },
> > +};
> > +
> > +static Property npcm7xx_gcr_properties[] =3D {
> > +    DEFINE_PROP_UINT32("disabled-modules", NPCM7xxGCRState, reset_mdlr=
, 0),
> > +    DEFINE_PROP_UINT32("power-on-straps", NPCM7xxGCRState, reset_pwron=
, 0),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
> > +{
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->desc =3D "NPCM7xx System Global Control Registers";
> > +    dc->realize =3D npcm7xx_gcr_realize;
> > +    dc->vmsd =3D &vmstate_npcm7xx_gcr;
> > +    rc->phases.enter =3D npcm7xx_gcr_enter_reset;
> > +
> > +    device_class_set_props(dc, npcm7xx_gcr_properties);
> > +}
> > +
> > +static const TypeInfo npcm7xx_gcr_info =3D {
> > +    .name               =3D TYPE_NPCM7XX_GCR,
> > +    .parent             =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size      =3D sizeof(NPCM7xxGCRState),
> > +    .instance_init      =3D npcm7xx_gcr_init,
> > +    .class_init         =3D npcm7xx_gcr_class_init,
> > +};
> > +
> > +static void npcm7xx_gcr_register_type(void)
> > +{
> > +    type_register_static(&npcm7xx_gcr_info);
> > +}
> > +type_init(npcm7xx_gcr_register_type);
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 42388f1de2..43173a338a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -723,6 +723,14 @@ S: Odd Fixes
> >  F: hw/arm/musicpal.c
> >  F: docs/system/arm/musicpal.rst
> >
> > +Nuvoton NPCM7xx
> > +M: Havard Skinnemoen <hskinnemoen@google.com>
> > +M: Tyrone Ting <kfting@nuvoton.com>
> > +L: qemu-arm@nongnu.org
> > +S: Supported
> > +F: hw/*/npcm7xx*
> > +F: include/hw/*/npcm7xx*
> > +
> >  nSeries
> >  M: Andrzej Zaborowski <balrogg@gmail.com>
> >  M: Peter Maydell <peter.maydell@linaro.org>
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index 4a224a6351..192a8dec3b 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -354,6 +354,9 @@ config XLNX_VERSAL
> >      select VIRTIO_MMIO
> >      select UNIMP
> >
> > +config NPCM7XX
> > +    bool
> > +
> >  config FSL_IMX25
> >      bool
> >      select IMX
> > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> > index 5aaca8a039..40a9d1c01e 100644
> > --- a/hw/misc/Makefile.objs
> > +++ b/hw/misc/Makefile.objs
> > @@ -51,6 +51,7 @@ common-obj-$(CONFIG_IMX) +=3D imx_rngc.o
> >  common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-hpdmc.o
> >  common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-pfpu.o
> >  common-obj-$(CONFIG_MAINSTONE) +=3D mst_fpga.o
> > +common-obj-$(CONFIG_NPCM7XX) +=3D npcm7xx_gcr.o
> >  common-obj-$(CONFIG_OMAP) +=3D omap_clk.o
> >  common-obj-$(CONFIG_OMAP) +=3D omap_gpmc.o
> >  common-obj-$(CONFIG_OMAP) +=3D omap_l4.o
> > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> > index ebea53735c..48e2d54c49 100644
> > --- a/hw/misc/trace-events
> > +++ b/hw/misc/trace-events
> > @@ -107,6 +107,10 @@ mos6522_set_sr_int(void) "set sr_int"
> >  mos6522_write(uint64_t addr, uint64_t val) "reg=3D0x%"PRIx64 " val=3D0=
x%"PRIx64
> >  mos6522_read(uint64_t addr, unsigned val) "reg=3D0x%"PRIx64 " val=3D0x=
%x"
> >
> > +# npcm7xx_gcr.c
> > +npcm7xx_gcr_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRI=
x64 " value: 0x%08" PRIx32
> > +npcm7xx_gcr_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRI=
x64 " value: 0x%08" PRIx32
> > +
> >  # stm32f4xx_syscfg
> >  stm32f4xx_syscfg_set_irq(int gpio, int line, int level) "Interupt: GPI=
O: %d, Line: %d; Level: %d"
> >  stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
> >

