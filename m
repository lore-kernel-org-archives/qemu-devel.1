Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6345EC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0BE20726
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J3iXJiwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0BE20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC23r-0006qc-9D
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1nk-0005vc-HL
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1ni-0003SX-EW
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:36 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jC1ni-0003SF-6R
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:34 -0400
Received: by mail-wm1-x341.google.com with SMTP id g62so2240637wme.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JRNa0aWKa8ytEPiAIp8LRg8CWJ8Ne+KmiuzmpWpcAB4=;
 b=J3iXJiwfyvma9C+OG/GJrU29Ip0h9RkqKwVx3GK9DWR+WomcGPNZtwg/1uiT7j6X18
 5Zcqr0MwZHagL5u6wzzDO5/VNEChLzYkbVKYuXTrorq4lfET7gsNNNs65aC1oB7B8IlS
 9pCtv5Z4IPN4/u+/QatdFVtItgoCWKHyH6tQ8Vly3aJwhbyuPvhbY+ASgTRniUQJWNyw
 Y8Y2Jib2XGgINMHvgV4Dx3e47/6gCF/nvORjmzDjizKSnrjq/uY8Idu4Guk1jahmdRgd
 9m558oDam/zWUrAYefs7QT07fYqGtfrY+xeyXkDfqWEov9Hl6MwrCJIinhZG6dzcDFQY
 Fozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JRNa0aWKa8ytEPiAIp8LRg8CWJ8Ne+KmiuzmpWpcAB4=;
 b=FbT4k73WPORKPfiyGm2O5iVKhz3MuXwL6P5VMu7YvdHTv8L2FvtriyAYsHHp5yNSFM
 dLH2nco3mCaXgxChqfVmU2238SzbkSS/BfuSrK3jqNV25C2myshtdk+GnfaHBZI+sdc3
 GwVnuLp77Ngi7Xpn3a93MNqzIWqqo0eMCewKG9uEqm/JvjCHJkpCPAKgAEpcvV+PRMr1
 jXTsm5W9X6Ru2Jzk7QqjVWXMhZjJZo3xk4ffrEatlvDrMCM8emmL+nrA68joXpz7e1Yc
 5YpKFp6BO2WC1C4Yo8P83h2Z8A4VGz8xwW0pr4kt+LpQ+vlbOPXnQFOY0RMvGiHBTUzS
 9I9g==
X-Gm-Message-State: ANhLgQ140mWJexKRbtTLlMt+atnjFuz7zBFZ5SmQ2wGZOESGVVR34SDT
 FXE/a/sja8Apr4Vj033Iz/m25g==
X-Google-Smtp-Source: ADFU+vvsy2tLUyJJv171NMIrE3FWHQdj3d8n0idnAZjEyKt4JJqgW4c8VogsXbyVIEK3QZ8Vja5Twg==
X-Received: by 2002:a1c:ed17:: with SMTP id l23mr3745307wmh.163.1583934811481; 
 Wed, 11 Mar 2020 06:53:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h13sm12862794wrv.39.2020.03.11.06.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 06:53:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BC82C1FF7E;
 Wed, 11 Mar 2020 13:53:29 +0000 (GMT)
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
 <20200310213203.18730-8-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v7 07/18] hw/arm/allwinner: add Security Identifier device
In-reply-to: <20200310213203.18730-8-nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 13:53:29 +0000
Message-ID: <87k13rgfqe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

> The Security Identifier device found in various Allwinner System on Chip
> designs gives applications a per-board unique identifier. This commit
> adds support for the Allwinner Security Identifier using a 128-bit
> UUID value as input.
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>  include/hw/arm/allwinner-h3.h   |   3 +
>  include/hw/misc/allwinner-sid.h |  60 ++++++++++++
>  hw/arm/allwinner-h3.c           |  11 ++-
>  hw/arm/orangepi.c               |   9 ++
>  hw/misc/allwinner-sid.c         | 168 ++++++++++++++++++++++++++++++++
>  hw/misc/Makefile.objs           |   1 +
>  hw/misc/trace-events            |   4 +
>  7 files changed, 255 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/misc/allwinner-sid.h
>  create mode 100644 hw/misc/allwinner-sid.c
>
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
> index dc729176ab..85416d9d64 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -42,6 +42,7 @@
>  #include "hw/misc/allwinner-h3-ccu.h"
>  #include "hw/misc/allwinner-cpucfg.h"
>  #include "hw/misc/allwinner-h3-sysctrl.h"
> +#include "hw/misc/allwinner-sid.h"
>  #include "target/arm/cpu.h"
>=20=20
>  /**
> @@ -59,6 +60,7 @@ enum {
>      AW_H3_SRAM_A2,
>      AW_H3_SRAM_C,
>      AW_H3_SYSCTRL,
> +    AW_H3_SID,
>      AW_H3_EHCI0,
>      AW_H3_OHCI0,
>      AW_H3_EHCI1,
> @@ -114,6 +116,7 @@ typedef struct AwH3State {
>      AwH3ClockCtlState ccu;
>      AwCpuCfgState cpucfg;
>      AwH3SysCtrlState sysctrl;
> +    AwSidState sid;
>      GICState gic;
>      MemoryRegion sram_a1;
>      MemoryRegion sram_a2;
> diff --git a/include/hw/misc/allwinner-sid.h b/include/hw/misc/allwinner-=
sid.h
> new file mode 100644
> index 0000000000..4c1fa4762b
> --- /dev/null
> +++ b/include/hw/misc/allwinner-sid.h
> @@ -0,0 +1,60 @@
> +/*
> + * Allwinner Security ID emulation
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
> +#ifndef HW_MISC_ALLWINNER_SID_H
> +#define HW_MISC_ALLWINNER_SID_H
> +
> +#include "qom/object.h"
> +#include "hw/sysbus.h"
> +#include "qemu/uuid.h"
> +
> +/**
> + * Object model
> + * @{
> + */
> +
> +#define TYPE_AW_SID    "allwinner-sid"
> +#define AW_SID(obj) \
> +    OBJECT_CHECK(AwSidState, (obj), TYPE_AW_SID)
> +
> +/** @} */
> +
> +/**
> + * Allwinner Security ID object instance state
> + */
> +typedef struct AwSidState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    /** Maps I/O registers in physical memory */
> +    MemoryRegion iomem;
> +
> +    /** Control register defines how and what to read */
> +    uint32_t control;
> +
> +    /** RdKey register contains the data retrieved by the device */
> +    uint32_t rdkey;
> +
> +    /** Stores the emulated device identifier */
> +    QemuUUID identifier;
> +
> +} AwSidState;
> +
> +#endif /* HW_MISC_ALLWINNER_SID_H */
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index b9a5597f2a..deeea63f5f 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -38,6 +38,7 @@ const hwaddr allwinner_h3_memmap[] =3D {
>      [AW_H3_SRAM_A2]    =3D 0x00044000,
>      [AW_H3_SRAM_C]     =3D 0x00010000,
>      [AW_H3_SYSCTRL]    =3D 0x01c00000,
> +    [AW_H3_SID]        =3D 0x01c14000,
>      [AW_H3_EHCI0]      =3D 0x01c1a000,
>      [AW_H3_OHCI0]      =3D 0x01c1a400,
>      [AW_H3_EHCI1]      =3D 0x01c1b000,
> @@ -78,7 +79,6 @@ struct AwH3Unimplemented {
>      { "mmc0",      0x01c0f000, 4 * KiB },
>      { "mmc1",      0x01c10000, 4 * KiB },
>      { "mmc2",      0x01c11000, 4 * KiB },
> -    { "sid",       0x01c14000, 1 * KiB },
>      { "crypto",    0x01c15000, 4 * KiB },
>      { "msgbox",    0x01c17000, 4 * KiB },
>      { "spinlock",  0x01c18000, 4 * KiB },
> @@ -198,6 +198,11 @@ static void allwinner_h3_init(Object *obj)
>=20=20
>      sysbus_init_child_obj(obj, "cpucfg", &s->cpucfg, sizeof(s->cpucfg),
>                            TYPE_AW_CPUCFG);
> +
> +    sysbus_init_child_obj(obj, "sid", &s->sid, sizeof(s->sid),
> +                          TYPE_AW_SID);
> +    object_property_add_alias(obj, "identifier", OBJECT(&s->sid),
> +                              "identifier", &error_abort);
>  }
>=20=20
>  static void allwinner_h3_realize(DeviceState *dev, Error **errp)
> @@ -315,6 +320,10 @@ static void allwinner_h3_realize(DeviceState *dev, E=
rror **errp)
>      qdev_init_nofail(DEVICE(&s->cpucfg));
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0, s->memmap[AW_H3_CPUCF=
G]);
>=20=20
> +    /* Security Identifier */
> +    qdev_init_nofail(DEVICE(&s->sid));
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H3_SID]);
> +
>      /* Universal Serial Bus */
>      sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
>                           qdev_get_gpio_in(DEVICE(&s->gic),
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> index 3fcec1944e..c92fab3eac 100644
> --- a/hw/arm/orangepi.c
> +++ b/hw/arm/orangepi.c
> @@ -65,6 +65,15 @@ static void orangepi_init(MachineState *machine)
>      object_property_set_int(OBJECT(h3), 24 * 1000 * 1000, "clk1-freq",
>                              &error_abort);
>=20=20
> +    /* Setup SID properties. Currently using a default fixed SID identif=
ier. */
> +    if (qemu_uuid_is_null(&h3->sid.identifier)) {
> +        qdev_prop_set_string(DEVICE(h3), "identifier",
> +                             "02c00081-1111-2222-3333-000044556677");
> +    } else if (ldl_be_p(&h3->sid.identifier.data[0]) !=3D 0x02c00081) {
> +        fprintf(stderr, "WARNING: Security Identifier value does "
> +                        "not include H3 prefix\n");
> +    }
> +

Should this be a LOG_GUEST_ERROR?

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

