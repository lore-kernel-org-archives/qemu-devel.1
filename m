Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D86C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B44A21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JgQyBSOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B44A21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53021 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC27H-00085T-Fs
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1sg-000131-R7
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1sd-0004Jk-Km
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:58:42 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jC1sd-0004II-9q
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:58:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id g62so2260609wme.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 06:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2BUpB3jtYOamS4LFZTHGi9UgrFiJM0jFFIQm14SYKdo=;
 b=JgQyBSOaUVP80WDQD6Skpjue5obMqPUtbXleDj2xHKGhzZ0YEtXGjTlZTmgIYDOoef
 pY6vD0XM8SVJoJhM/dxqKPm2xW66Q2M4aqsghQGNrxgHPZZZKHbYwLY+RZ/+U3CnfAB/
 KusyvShJ0EMGsX0SFh2Qk+AWNEG664n5DDnQ80E2j7Pl6z4M6CazeMlW8UjnBUNrWBQh
 aMTZsuOnBT7BZL3emQLF/FTLCMDyMZsG663+jE9N57GrkFhFbIOhUSSvfqEh/BlUHlvN
 SGb04YFxKGuv9MKJKlAosXZBaslWVBe7jDAed/W+z81bnrL+n05Hc1yQrQjCS33gtMux
 wjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2BUpB3jtYOamS4LFZTHGi9UgrFiJM0jFFIQm14SYKdo=;
 b=ZtKCuCTt8ZVxx+Eqvztc13TktXcN+bOd7Np9rm2luw9qJWeRjwkx1jtca/btJ1q31v
 1P6rnkf+MwWSOR5qNwsgW4ZBbdduE9vci834OvmkRL4bqfSEJ2UC8FkD1Up1f+z2WmHN
 /59I2QD0Tx7qkiXuNe88TJbj0JM2NSb2KhYcf4lD0MTvwidHQSGPm8KNRXRyLZkdo0Sr
 5xoAdSJncxVI+IqrHoHZeKTmfL5i4KzYGQ3IULvtFpZH0Z2boSVwBNY5Od5ZrhhqG+Qo
 52APWOL42WqIV7Jym7uc5h2UL5XQ8xW8WZ+WPZTM3Fc9b5vmfbOtwd90bVFG9b0xXRxo
 oueg==
X-Gm-Message-State: ANhLgQ1zJ0tjXddda7jCx75wOJsN5sPIq0jGPNjPWJgvvcDJ1nerlBQ5
 6funIZKj2IPy6ytAIn8b4h3rWw==
X-Google-Smtp-Source: ADFU+vuADu3Fx2VEuAXqyuFJ5wiY/8s2M7uDVK9aXqGYdYNfFovsdhaqwApeaKtsdOLkiD+2ioBtQQ==
X-Received: by 2002:a05:600c:350:: with SMTP id
 u16mr3943447wmd.168.1583935118112; 
 Wed, 11 Mar 2020 06:58:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a1sm30633862wru.75.2020.03.11.06.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 06:58:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 55F9B1FF7E;
 Wed, 11 Mar 2020 13:58:36 +0000 (GMT)
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
 <20200310213203.18730-12-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v7 11/18] hw/arm/allwinner-h3: add SDRAM controller device
In-reply-to: <20200310213203.18730-12-nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 13:58:36 +0000
Message-ID: <87blp3gfhv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

> In the Allwinner H3 SoC the SDRAM controller is responsible
> for interfacing with the external Synchronous Dynamic Random
> Access Memory (SDRAM). Types of memory that the SDRAM controller
> supports are DDR2/DDR3 and capacities of up to 2GiB. This commit
> adds emulation support of the Allwinner H3 SDRAM controller.
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/hw/arm/allwinner-h3.h        |   5 +
>  include/hw/misc/allwinner-h3-dramc.h | 106 ++++++++
>  hw/arm/allwinner-h3.c                |  19 +-
>  hw/arm/orangepi.c                    |   6 +
>  hw/misc/allwinner-h3-dramc.c         | 358 +++++++++++++++++++++++++++
>  hw/misc/Makefile.objs                |   1 +
>  hw/misc/trace-events                 |  10 +
>  7 files changed, 502 insertions(+), 3 deletions(-)
>  create mode 100644 include/hw/misc/allwinner-h3-dramc.h
>  create mode 100644 hw/misc/allwinner-h3-dramc.c
>
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
> index d338003724..065d020c73 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -41,6 +41,7 @@
>  #include "hw/intc/arm_gic.h"
>  #include "hw/misc/allwinner-h3-ccu.h"
>  #include "hw/misc/allwinner-cpucfg.h"
> +#include "hw/misc/allwinner-h3-dramc.h"
>  #include "hw/misc/allwinner-h3-sysctrl.h"
>  #include "hw/misc/allwinner-sid.h"
>  #include "hw/sd/allwinner-sdhost.h"
> @@ -80,6 +81,9 @@ enum {
>      AW_H3_UART2,
>      AW_H3_UART3,
>      AW_H3_EMAC,
> +    AW_H3_DRAMCOM,
> +    AW_H3_DRAMCTL,
> +    AW_H3_DRAMPHY,
>      AW_H3_GIC_DIST,
>      AW_H3_GIC_CPU,
>      AW_H3_GIC_HYP,
> @@ -120,6 +124,7 @@ typedef struct AwH3State {
>      AwA10PITState timer;
>      AwH3ClockCtlState ccu;
>      AwCpuCfgState cpucfg;
> +    AwH3DramCtlState dramc;
>      AwH3SysCtrlState sysctrl;
>      AwSidState sid;
>      AwSdHostState mmc0;
> diff --git a/include/hw/misc/allwinner-h3-dramc.h b/include/hw/misc/allwi=
nner-h3-dramc.h
> new file mode 100644
> index 0000000000..bacdf236b7
> --- /dev/null
> +++ b/include/hw/misc/allwinner-h3-dramc.h
> @@ -0,0 +1,106 @@
> +/*
> + * Allwinner H3 SDRAM Controller emulation
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
> +#ifndef HW_MISC_ALLWINNER_H3_DRAMC_H
> +#define HW_MISC_ALLWINNER_H3_DRAMC_H
> +
> +#include "qom/object.h"
> +#include "hw/sysbus.h"
> +#include "exec/hwaddr.h"
> +
> +/**
> + * Constants
> + * @{
> + */
> +
> +/** Highest register address used by DRAMCOM module */
> +#define AW_H3_DRAMCOM_REGS_MAXADDR  (0x804)
> +
> +/** Total number of known DRAMCOM registers */
> +#define AW_H3_DRAMCOM_REGS_NUM      (AW_H3_DRAMCOM_REGS_MAXADDR / \
> +                                     sizeof(uint32_t))
> +
> +/** Highest register address used by DRAMCTL module */
> +#define AW_H3_DRAMCTL_REGS_MAXADDR  (0x88c)
> +
> +/** Total number of known DRAMCTL registers */
> +#define AW_H3_DRAMCTL_REGS_NUM      (AW_H3_DRAMCTL_REGS_MAXADDR / \
> +                                     sizeof(uint32_t))
> +
> +/** Highest register address used by DRAMPHY module */
> +#define AW_H3_DRAMPHY_REGS_MAXADDR  (0x4)
> +
> +/** Total number of known DRAMPHY registers */
> +#define AW_H3_DRAMPHY_REGS_NUM      (AW_H3_DRAMPHY_REGS_MAXADDR / \
> +                                     sizeof(uint32_t))
> +
> +/** @} */
> +
> +/**
> + * Object model
> + * @{
> + */
> +
> +#define TYPE_AW_H3_DRAMC "allwinner-h3-dramc"
> +#define AW_H3_DRAMC(obj) \
> +    OBJECT_CHECK(AwH3DramCtlState, (obj), TYPE_AW_H3_DRAMC)
> +
> +/** @} */
> +
> +/**
> + * Allwinner H3 SDRAM Controller object instance state.
> + */
> +typedef struct AwH3DramCtlState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    /** Physical base address for start of RAM */
> +    hwaddr ram_addr;
> +
> +    /** Total RAM size in megabytes */
> +    uint32_t ram_size;
> +
> +    /**
> +     * @name Memory Regions
> +     * @{
> +     */
> +
> +    MemoryRegion row_mirror;       /**< Simulates rows for RAM size dete=
ction */
> +    MemoryRegion row_mirror_alias; /**< Alias of the row which is mirror=
ed */
> +    MemoryRegion dramcom_iomem;    /**< DRAMCOM module I/O registers */
> +    MemoryRegion dramctl_iomem;    /**< DRAMCTL module I/O registers */
> +    MemoryRegion dramphy_iomem;    /**< DRAMPHY module I/O registers */
> +
> +    /** @} */
> +
> +    /**
> +     * @name Hardware Registers
> +     * @{
> +     */
> +
> +    uint32_t dramcom[AW_H3_DRAMCOM_REGS_NUM]; /**< Array of DRAMCOM regi=
sters */
> +    uint32_t dramctl[AW_H3_DRAMCTL_REGS_NUM]; /**< Array of DRAMCTL regi=
sters */
> +    uint32_t dramphy[AW_H3_DRAMPHY_REGS_NUM] ;/**< Array of DRAMPHY regi=
sters */
> +
> +    /** @} */
> +
> +} AwH3DramCtlState;
> +
> +#endif /* HW_MISC_ALLWINNER_H3_DRAMC_H */
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index 56b5c563a8..0e0fea6223 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -56,6 +56,9 @@ const hwaddr allwinner_h3_memmap[] =3D {
>      [AW_H3_UART2]      =3D 0x01c28800,
>      [AW_H3_UART3]      =3D 0x01c28c00,
>      [AW_H3_EMAC]       =3D 0x01c30000,
> +    [AW_H3_DRAMCOM]    =3D 0x01c62000,
> +    [AW_H3_DRAMCTL]    =3D 0x01c63000,
> +    [AW_H3_DRAMPHY]    =3D 0x01c65000,
>      [AW_H3_GIC_DIST]   =3D 0x01c81000,
>      [AW_H3_GIC_CPU]    =3D 0x01c82000,
>      [AW_H3_GIC_HYP]    =3D 0x01c84000,
> @@ -110,9 +113,6 @@ struct AwH3Unimplemented {
>      { "scr",       0x01c2c400, 1 * KiB },
>      { "gpu",       0x01c40000, 64 * KiB },
>      { "hstmr",     0x01c60000, 4 * KiB },
> -    { "dramcom",   0x01c62000, 4 * KiB },
> -    { "dramctl0",  0x01c63000, 4 * KiB },
> -    { "dramphy0",  0x01c65000, 4 * KiB },
>      { "spi0",      0x01c68000, 4 * KiB },
>      { "spi1",      0x01c69000, 4 * KiB },
>      { "csi",       0x01cb0000, 320 * KiB },
> @@ -229,6 +229,13 @@ static void allwinner_h3_init(Object *obj)
>=20=20
>      sysbus_init_child_obj(obj, "emac", &s->emac, sizeof(s->emac),
>                            TYPE_AW_SUN8I_EMAC);
> +
> +    sysbus_init_child_obj(obj, "dramc", &s->dramc, sizeof(s->dramc),
> +                          TYPE_AW_H3_DRAMC);
> +    object_property_add_alias(obj, "ram-addr", OBJECT(&s->dramc),
> +                             "ram-addr", &error_abort);
> +    object_property_add_alias(obj, "ram-size", OBJECT(&s->dramc),
> +                              "ram-size", &error_abort);
>  }
>=20=20
>  static void allwinner_h3_realize(DeviceState *dev, Error **errp)
> @@ -413,6 +420,12 @@ static void allwinner_h3_realize(DeviceState *dev, E=
rror **errp)
>                     qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART3=
),
>                     115200, serial_hd(3), DEVICE_NATIVE_ENDIAN);
>=20=20
> +    /* DRAMC */
> +    qdev_init_nofail(DEVICE(&s->dramc));
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 0, s->memmap[AW_H3_DRAMCO=
M]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 1, s->memmap[AW_H3_DRAMCT=
L]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 2, s->memmap[AW_H3_DRAMPH=
Y]);
> +
>      /* Unimplemented devices */
>      for (i =3D 0; i < ARRAY_SIZE(unimplemented); i++) {
>          create_unimplemented_device(unimplemented[i].device_name,
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> index 1c32d2898f..be05a533b5 100644
> --- a/hw/arm/orangepi.c
> +++ b/hw/arm/orangepi.c
> @@ -81,6 +81,12 @@ static void orangepi_init(MachineState *machine)
>      /* Setup EMAC properties */
>      object_property_set_int(OBJECT(&h3->emac), 1, "phy-addr", &error_abo=
rt);
>=20=20
> +    /* DRAMC */
> +    object_property_set_uint(OBJECT(h3), h3->memmap[AW_H3_SDRAM],
> +                             "ram-addr", &error_abort);
> +    object_property_set_int(OBJECT(h3), machine->ram_size / MiB, "ram-si=
ze",
> +                            &error_abort);
> +
>      /* Mark H3 object realized */
>      object_property_set_bool(OBJECT(h3), true, "realized", &error_abort);
>=20=20
> diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
> new file mode 100644
> index 0000000000..2b5260260e
> --- /dev/null
> +++ b/hw/misc/allwinner-h3-dramc.c
> @@ -0,0 +1,358 @@
> +/*
> + * Allwinner H3 SDRAM Controller emulation
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
> +#include "qemu/error-report.h"
> +#include "hw/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "exec/address-spaces.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "hw/misc/allwinner-h3-dramc.h"
> +#include "trace.h"
> +
> +#define REG_INDEX(offset)    (offset / sizeof(uint32_t))
> +
> +/* DRAMCOM register offsets */
> +enum {
> +    REG_DRAMCOM_CR    =3D 0x0000, /* Control Register */
> +};
> +
> +/* DRAMCTL register offsets */
> +enum {
> +    REG_DRAMCTL_PIR   =3D 0x0000, /* PHY Initialization Register */
> +    REG_DRAMCTL_PGSR  =3D 0x0010, /* PHY General Status Register */
> +    REG_DRAMCTL_STATR =3D 0x0018, /* Status Register */
> +};
> +
> +/* DRAMCTL register flags */
> +enum {
> +    REG_DRAMCTL_PGSR_INITDONE =3D (1 << 0),
> +};
> +
> +enum {
> +    REG_DRAMCTL_STATR_ACTIVE  =3D (1 << 0),
> +};
> +
> +static void allwinner_h3_dramc_map_rows(AwH3DramCtlState *s, uint8_t row=
_bits,
> +                                        uint8_t bank_bits, uint16_t page=
_size)
> +{
> +    /*
> +     * This function simulates row addressing behavior when bootloader
> +     * software attempts to detect the amount of available SDRAM. In U-B=
oot
> +     * the controller is configured with the widest row addressing avail=
able.
> +     * Then a pattern is written to RAM at an offset on the row boundary=
 size.
> +     * If the value read back equals the value read back from the
> +     * start of RAM, the bootloader knows the amount of row bits.
> +     *
> +     * This function inserts a mirrored memory region when the configure=
d row
> +     * bits are not matching the actual emulated memory, to simulate the
> +     * same behavior on hardware as expected by the bootloader.
> +     */
> +    uint8_t row_bits_actual =3D 0;
> +
> +    /* Calculate the actual row bits using the ram_size property */
> +    for (uint8_t i =3D 8; i < 12; i++) {
> +        if (1 << i =3D=3D s->ram_size) {
> +            row_bits_actual =3D i + 3;
> +            break;
> +        }
> +    }
> +
> +    if (s->ram_size =3D=3D (1 << (row_bits - 3))) {
> +        /* When row bits is the expected value, remove the mirror */
> +        memory_region_set_enabled(&s->row_mirror_alias, false);
> +        trace_allwinner_h3_dramc_rowmirror_disable();
> +
> +    } else if (row_bits_actual) {
> +        /* Row bits not matching ram_size, install the rows mirror */
> +        hwaddr row_mirror =3D s->ram_addr + ((1 << (row_bits_actual +
> +                                                  bank_bits)) * page_siz=
e);
> +
> +        memory_region_set_enabled(&s->row_mirror_alias, true);
> +        memory_region_set_address(&s->row_mirror_alias, row_mirror);
> +
> +        trace_allwinner_h3_dramc_rowmirror_enable(row_mirror);
> +    }
> +}
> +
> +static uint64_t allwinner_h3_dramcom_read(void *opaque, hwaddr offset,
> +                                          unsigned size)
> +{
> +    const AwH3DramCtlState *s =3D AW_H3_DRAMC(opaque);
> +    const uint32_t idx =3D REG_INDEX(offset);
> +
> +    if (idx >=3D AW_H3_DRAMCOM_REGS_NUM) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\=
n",
> +                      __func__, (uint32_t)offset);
> +        return 0;
> +    }
> +
> +    trace_allwinner_h3_dramcom_read(offset, s->dramcom[idx], size);
> +
> +    return s->dramcom[idx];
> +}
> +
> +static void allwinner_h3_dramcom_write(void *opaque, hwaddr offset,
> +                                       uint64_t val, unsigned size)
> +{
> +    AwH3DramCtlState *s =3D AW_H3_DRAMC(opaque);
> +    const uint32_t idx =3D REG_INDEX(offset);
> +
> +    trace_allwinner_h3_dramcom_write(offset, val, size);
> +
> +    if (idx >=3D AW_H3_DRAMCOM_REGS_NUM) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\=
n",
> +                      __func__, (uint32_t)offset);
> +        return;
> +    }
> +
> +    switch (offset) {
> +    case REG_DRAMCOM_CR:   /* Control Register */
> +        allwinner_h3_dramc_map_rows(s, ((val >> 4) & 0xf) + 1,
> +                                       ((val >> 2) & 0x1) + 2,
> +                                       1 << (((val >> 8) & 0xf) + 3));
> +        break;
> +    default:
> +        break;
> +    };
> +
> +    s->dramcom[idx] =3D (uint32_t) val;
> +}
> +
> +static uint64_t allwinner_h3_dramctl_read(void *opaque, hwaddr offset,
> +                                          unsigned size)
> +{
> +    const AwH3DramCtlState *s =3D AW_H3_DRAMC(opaque);
> +    const uint32_t idx =3D REG_INDEX(offset);
> +
> +    if (idx >=3D AW_H3_DRAMCTL_REGS_NUM) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\=
n",
> +                      __func__, (uint32_t)offset);
> +        return 0;
> +    }
> +
> +    trace_allwinner_h3_dramctl_read(offset, s->dramctl[idx], size);
> +
> +    return s->dramctl[idx];
> +}
> +
> +static void allwinner_h3_dramctl_write(void *opaque, hwaddr offset,
> +                                       uint64_t val, unsigned size)
> +{
> +    AwH3DramCtlState *s =3D AW_H3_DRAMC(opaque);
> +    const uint32_t idx =3D REG_INDEX(offset);
> +
> +    trace_allwinner_h3_dramctl_write(offset, val, size);
> +
> +    if (idx >=3D AW_H3_DRAMCTL_REGS_NUM) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\=
n",
> +                      __func__, (uint32_t)offset);
> +        return;
> +    }
> +
> +    switch (offset) {
> +    case REG_DRAMCTL_PIR:    /* PHY Initialization Register */
> +        s->dramctl[REG_INDEX(REG_DRAMCTL_PGSR)] |=3D REG_DRAMCTL_PGSR_IN=
ITDONE;
> +        s->dramctl[REG_INDEX(REG_DRAMCTL_STATR)] |=3D REG_DRAMCTL_STATR_=
ACTIVE;
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    s->dramctl[idx] =3D (uint32_t) val;
> +}
> +
> +static uint64_t allwinner_h3_dramphy_read(void *opaque, hwaddr offset,
> +                                          unsigned size)
> +{
> +    const AwH3DramCtlState *s =3D AW_H3_DRAMC(opaque);
> +    const uint32_t idx =3D REG_INDEX(offset);
> +
> +    if (idx >=3D AW_H3_DRAMPHY_REGS_NUM) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\=
n",
> +                      __func__, (uint32_t)offset);
> +        return 0;
> +    }
> +
> +    trace_allwinner_h3_dramphy_read(offset, s->dramphy[idx], size);
> +
> +    return s->dramphy[idx];
> +}
> +
> +static void allwinner_h3_dramphy_write(void *opaque, hwaddr offset,
> +                                       uint64_t val, unsigned size)
> +{
> +    AwH3DramCtlState *s =3D AW_H3_DRAMC(opaque);
> +    const uint32_t idx =3D REG_INDEX(offset);
> +
> +    trace_allwinner_h3_dramphy_write(offset, val, size);
> +
> +    if (idx >=3D AW_H3_DRAMPHY_REGS_NUM) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\=
n",
> +                      __func__, (uint32_t)offset);
> +        return;
> +    }
> +
> +    s->dramphy[idx] =3D (uint32_t) val;
> +}
> +
> +static const MemoryRegionOps allwinner_h3_dramcom_ops =3D {
> +    .read =3D allwinner_h3_dramcom_read,
> +    .write =3D allwinner_h3_dramcom_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +    .impl.min_access_size =3D 4,
> +};
> +
> +static const MemoryRegionOps allwinner_h3_dramctl_ops =3D {
> +    .read =3D allwinner_h3_dramctl_read,
> +    .write =3D allwinner_h3_dramctl_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +    .impl.min_access_size =3D 4,
> +};
> +
> +static const MemoryRegionOps allwinner_h3_dramphy_ops =3D {
> +    .read =3D allwinner_h3_dramphy_read,
> +    .write =3D allwinner_h3_dramphy_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +    .impl.min_access_size =3D 4,
> +};
> +
> +static void allwinner_h3_dramc_reset(DeviceState *dev)
> +{
> +    AwH3DramCtlState *s =3D AW_H3_DRAMC(dev);
> +
> +    /* Set default values for registers */
> +    memset(&s->dramcom, 0, sizeof(s->dramcom));
> +    memset(&s->dramctl, 0, sizeof(s->dramctl));
> +    memset(&s->dramphy, 0, sizeof(s->dramphy));
> +}
> +
> +static void allwinner_h3_dramc_realize(DeviceState *dev, Error **errp)
> +{
> +    AwH3DramCtlState *s =3D AW_H3_DRAMC(dev);
> +
> +    /* Only power of 2 RAM sizes from 256MiB up to 2048MiB are supported=
 */
> +    for (uint8_t i =3D 8; i < 13; i++) {
> +        if (1 << i =3D=3D s->ram_size) {
> +            break;
> +        } else if (i =3D=3D 12) {
> +            error_report("%s: ram-size %u MiB is not supported",
> +                          __func__, s->ram_size);
> +            exit(1);
> +        }
> +    }
> +
> +    /* Setup row mirror mappings */
> +    memory_region_init_ram(&s->row_mirror, OBJECT(s),
> +                           "allwinner-h3-dramc.row-mirror",
> +                            4 * KiB, &error_abort);
> +    memory_region_add_subregion_overlap(get_system_memory(), s->ram_addr,
> +                                       &s->row_mirror, 10);
> +
> +    memory_region_init_alias(&s->row_mirror_alias, OBJECT(s),
> +                            "allwinner-h3-dramc.row-mirror-alias",
> +                            &s->row_mirror, 0, 4 * KiB);
> +    memory_region_add_subregion_overlap(get_system_memory(),
> +                                        s->ram_addr + 1 * MiB,
> +                                       &s->row_mirror_alias, 10);
> +    memory_region_set_enabled(&s->row_mirror_alias, false);
> +}
> +
> +static void allwinner_h3_dramc_init(Object *obj)
> +{
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    AwH3DramCtlState *s =3D AW_H3_DRAMC(obj);
> +
> +    /* DRAMCOM registers */
> +    memory_region_init_io(&s->dramcom_iomem, OBJECT(s),
> +                          &allwinner_h3_dramcom_ops, s,
> +                           TYPE_AW_H3_DRAMC, 4 * KiB);
> +    sysbus_init_mmio(sbd, &s->dramcom_iomem);
> +
> +    /* DRAMCTL registers */
> +    memory_region_init_io(&s->dramctl_iomem, OBJECT(s),
> +                          &allwinner_h3_dramctl_ops, s,
> +                           TYPE_AW_H3_DRAMC, 4 * KiB);
> +    sysbus_init_mmio(sbd, &s->dramctl_iomem);
> +
> +    /* DRAMPHY registers */
> +    memory_region_init_io(&s->dramphy_iomem, OBJECT(s),
> +                          &allwinner_h3_dramphy_ops, s,
> +                          TYPE_AW_H3_DRAMC, 4 * KiB);
> +    sysbus_init_mmio(sbd, &s->dramphy_iomem);
> +}
> +
> +static Property allwinner_h3_dramc_properties[] =3D {
> +    DEFINE_PROP_UINT64("ram-addr", AwH3DramCtlState, ram_addr, 0x0),
> +    DEFINE_PROP_UINT32("ram-size", AwH3DramCtlState, ram_size, 256 * MiB=
),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static const VMStateDescription allwinner_h3_dramc_vmstate =3D {
> +    .name =3D "allwinner-h3-dramc",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(dramcom, AwH3DramCtlState, AW_H3_DRAMCOM_RE=
GS_NUM),
> +        VMSTATE_UINT32_ARRAY(dramctl, AwH3DramCtlState, AW_H3_DRAMCTL_RE=
GS_NUM),
> +        VMSTATE_UINT32_ARRAY(dramphy, AwH3DramCtlState, AW_H3_DRAMPHY_RE=
GS_NUM),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void allwinner_h3_dramc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->reset =3D allwinner_h3_dramc_reset;
> +    dc->vmsd =3D &allwinner_h3_dramc_vmstate;
> +    dc->realize =3D allwinner_h3_dramc_realize;
> +    device_class_set_props(dc, allwinner_h3_dramc_properties);
> +}
> +
> +static const TypeInfo allwinner_h3_dramc_info =3D {
> +    .name          =3D TYPE_AW_H3_DRAMC,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_init =3D allwinner_h3_dramc_init,
> +    .instance_size =3D sizeof(AwH3DramCtlState),
> +    .class_init    =3D allwinner_h3_dramc_class_init,
> +};
> +
> +static void allwinner_h3_dramc_register(void)
> +{
> +    type_register_static(&allwinner_h3_dramc_info);
> +}
> +
> +type_init(allwinner_h3_dramc_register)
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index daa734036e..68aae2eabb 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -30,6 +30,7 @@ common-obj-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem.o
>=20=20
>  common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-ccu.o
>  obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-cpucfg.o
> +common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-dramc.o
>  common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-sysctrl.o
>  common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-sid.o
>  common-obj-$(CONFIG_REALVIEW) +=3D arm_sysctl.o
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 4f38328d9c..a5862b2bed 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -5,6 +5,16 @@ allwinner_cpucfg_cpu_reset(uint8_t cpu_id, uint32_t rese=
t_addr) "id %u, reset_ad
>  allwinner_cpucfg_read(uint64_t offset, uint64_t data, unsigned size) "of=
fset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
>  allwinner_cpucfg_write(uint64_t offset, uint64_t data, unsigned size) "o=
ffset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
>=20=20
> +# allwinner-h3-dramc.c
> +allwinner_h3_dramc_rowmirror_disable(void) "Disable row mirror"
> +allwinner_h3_dramc_rowmirror_enable(uint64_t addr) "Enable row mirror: a=
ddr 0x%" PRIx64
> +allwinner_h3_dramcom_read(uint64_t offset, uint64_t data, unsigned size)=
 "Read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> +allwinner_h3_dramcom_write(uint64_t offset, uint64_t data, unsigned size=
) "Write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> +allwinner_h3_dramctl_read(uint64_t offset, uint64_t data, unsigned size)=
 "Read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> +allwinner_h3_dramctl_write(uint64_t offset, uint64_t data, unsigned size=
) "Write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> +allwinner_h3_dramphy_read(uint64_t offset, uint64_t data, unsigned size)=
 "Read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> +allwinner_h3_dramphy_write(uint64_t offset, uint64_t data, unsigned size=
) "write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> +
>  # allwinner-sid.c
>  allwinner_sid_read(uint64_t offset, uint64_t data, unsigned size) "offse=
t 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
>  allwinner_sid_write(uint64_t offset, uint64_t data, unsigned size) "offs=
et 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32


--=20
Alex Benn=C3=A9e

