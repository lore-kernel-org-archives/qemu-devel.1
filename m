Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA33C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951CD21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJggXS7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951CD21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC28e-0002kY-5W
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1qT-0003pl-B4
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1qO-0001sG-Tt
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:56:25 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41349)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jC1qO-0001oO-EW
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:56:20 -0400
Received: by mail-wr1-x441.google.com with SMTP id s14so2724796wrt.8
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 06:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vRD/Iig0yfG5bpYHukkw0EefzyMjfqNuJ+j2PjIi/3I=;
 b=pJggXS7PbXIo/uHNRJwzrD+r6/lqHRqBbH/NdUJa6zqdk+Xt90XNynKorGX9ILOHT7
 hm1MY9x+B0s9UEnSUT0w/ThkfRVK8wFZ8gmLT5GGLB2Fg+pbbVJEkzt0+/Rn57+SRCOg
 gm1h8s+1wBPLVgKMIx+MgiCYiSzGyKy2Hh3jCJyrqGD5VkKBQwi36DyV/w7oRfHbXoIJ
 oq29PuQ8u3tp9ixOGiS6VTrus/G+GzDMNh4AQCFKsG7VOPILn4l2VBXrSdiJfMNeuxlN
 abIVYvV4+gLSfp5FN0wi+x5ptfQDdq+Yx1HCvoSJmaI7WNUZtyLaZ7VUVK3E2iK+iMcs
 ru5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vRD/Iig0yfG5bpYHukkw0EefzyMjfqNuJ+j2PjIi/3I=;
 b=kgo0zSWTtSakZ0aJM3Ip9GZcZvWgY0mkGIlw4BVSARa+2VTh7HwFyY/vePAzPFHkpj
 P4u3CdNSpuqwmXUmyR9wCZIjPpkFtbZW4E05E07ALjJeFE8idRTY7tXuBP6ncXTAr4/i
 UABH1OUj02yjzlv8puaOxFhbJoKu3z0b33GXti5Odh4upPDzlEtf6ArZMXEBWnninAua
 d1u9bG0jg821ojXAIDpucn4FBG+PqlLq2CwblK6roAuWhEupGfHSq5pv66Ksa5CDQlti
 vfj3n4VZ2jPZVToDR1MlAu7aIZEtCADiRkGTyJ+F4bZPYZJ7mlJwXtqrNzbwVHMRA7me
 g5Og==
X-Gm-Message-State: ANhLgQ2Yn9KwgGaQyxyYJlZ7HSkS+p+xGFjnNauWydxD0g+IM90tNTXk
 ZxqRxtLH5kN++2RaSCPVhBne/g==
X-Google-Smtp-Source: ADFU+vvpWwzvhPAbFPbQy6RxKFNobDB/teUhxKXQk0AcbVtBSl+CEohI/ujUk3AyCDSxN50UwpwmOg==
X-Received: by 2002:a05:6000:1107:: with SMTP id
 z7mr5002337wrw.340.1583934979003; 
 Wed, 11 Mar 2020 06:56:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i1sm53113888wrs.18.2020.03.11.06.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 06:56:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 050F01FF7E;
 Wed, 11 Mar 2020 13:56:17 +0000 (GMT)
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
 <20200310213203.18730-10-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v7 09/18] hw/arm/allwinner-h3: add EMAC ethernet device
In-reply-to: <20200310213203.18730-10-nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 13:56:16 +0000
Message-ID: <87h7yvgflr.fsf@linaro.org>
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

> The Allwinner Sun8i System on Chip family includes an Ethernet MAC (EMAC)
> which provides 10M/100M/1000M Ethernet connectivity. This commit
> adds support for the Allwinner EMAC from the Sun8i family (H2+, H3, A33, =
etc),
> including emulation for the following functionality:
>
>  * DMA transfers
>  * MII interface
>  * Transmit CRC calculation
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/hw/arm/allwinner-h3.h         |   3 +
>  include/hw/net/allwinner-sun8i-emac.h |  99 +++
>  hw/arm/allwinner-h3.c                 |  16 +-
>  hw/arm/orangepi.c                     |   3 +
>  hw/net/allwinner-sun8i-emac.c         | 871 ++++++++++++++++++++++++++
>  hw/arm/Kconfig                        |   1 +
>  hw/net/Kconfig                        |   3 +
>  hw/net/Makefile.objs                  |   1 +
>  hw/net/trace-events                   |  10 +
>  9 files changed, 1006 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/net/allwinner-sun8i-emac.h
>  create mode 100644 hw/net/allwinner-sun8i-emac.c
>
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
> index d71a4917ab..f9b9a02373 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -44,6 +44,7 @@
>  #include "hw/misc/allwinner-h3-sysctrl.h"
>  #include "hw/misc/allwinner-sid.h"
>  #include "hw/sd/allwinner-sdhost.h"
> +#include "hw/net/allwinner-sun8i-emac.h"
>  #include "target/arm/cpu.h"
>=20=20
>  /**
> @@ -77,6 +78,7 @@ enum {
>      AW_H3_UART1,
>      AW_H3_UART2,
>      AW_H3_UART3,
> +    AW_H3_EMAC,
>      AW_H3_GIC_DIST,
>      AW_H3_GIC_CPU,
>      AW_H3_GIC_HYP,
> @@ -120,6 +122,7 @@ typedef struct AwH3State {
>      AwH3SysCtrlState sysctrl;
>      AwSidState sid;
>      AwSdHostState mmc0;
> +    AwSun8iEmacState emac;
>      GICState gic;
>      MemoryRegion sram_a1;
>      MemoryRegion sram_a2;
> diff --git a/include/hw/net/allwinner-sun8i-emac.h b/include/hw/net/allwi=
nner-sun8i-emac.h
> new file mode 100644
> index 0000000000..eda034e96b
> --- /dev/null
> +++ b/include/hw/net/allwinner-sun8i-emac.h
> @@ -0,0 +1,99 @@
> +/*
> + * Allwinner Sun8i Ethernet MAC emulation
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
> +#ifndef HW_NET_ALLWINNER_SUN8I_EMAC_H
> +#define HW_NET_ALLWINNER_SUN8I_EMAC_H
> +
> +#include "qom/object.h"
> +#include "net/net.h"
> +#include "hw/sysbus.h"
> +
> +/**
> + * Object model
> + * @{
> + */
> +
> +#define TYPE_AW_SUN8I_EMAC "allwinner-sun8i-emac"
> +#define AW_SUN8I_EMAC(obj) \
> +    OBJECT_CHECK(AwSun8iEmacState, (obj), TYPE_AW_SUN8I_EMAC)
> +
> +/** @} */
> +
> +/**
> + * Allwinner Sun8i EMAC object instance state
> + */
> +typedef struct AwSun8iEmacState {
> +    /*< private >*/
> +    SysBusDevice  parent_obj;
> +    /*< public >*/
> +
> +    /** Maps I/O registers in physical memory */
> +    MemoryRegion iomem;
> +
> +    /** Interrupt output signal to notify CPU */
> +    qemu_irq     irq;
> +
> +    /** Generic Network Interface Controller (NIC) for networking API */
> +    NICState     *nic;
> +
> +    /** Generic Network Interface Controller (NIC) configuration */
> +    NICConf      conf;
> +
> +    /**
> +     * @name Media Independent Interface (MII)
> +     * @{
> +     */
> +
> +    uint8_t      mii_phy_addr;  /**< PHY address */
> +    uint32_t     mii_cr;        /**< Control */
> +    uint32_t     mii_st;        /**< Status */
> +    uint32_t     mii_adv;       /**< Advertised Abilities */
> +
> +    /** @} */
> +
> +    /**
> +     * @name Hardware Registers
> +     * @{
> +     */
> +
> +    uint32_t     basic_ctl0;    /**< Basic Control 0 */
> +    uint32_t     basic_ctl1;    /**< Basic Control 1 */
> +    uint32_t     int_en;        /**< Interrupt Enable */
> +    uint32_t     int_sta;       /**< Interrupt Status */
> +    uint32_t     frm_flt;       /**< Receive Frame Filter */
> +
> +    uint32_t     rx_ctl0;       /**< Receive Control 0 */
> +    uint32_t     rx_ctl1;       /**< Receive Control 1 */
> +    uint32_t     rx_desc_head;  /**< Receive Descriptor List Address */
> +    uint32_t     rx_desc_curr;  /**< Current Receive Descriptor Address =
*/
> +
> +    uint32_t     tx_ctl0;       /**< Transmit Control 0 */
> +    uint32_t     tx_ctl1;       /**< Transmit Control 1 */
> +    uint32_t     tx_desc_head;  /**< Transmit Descriptor List Address */
> +    uint32_t     tx_desc_curr;  /**< Current Transmit Descriptor Address=
 */
> +    uint32_t     tx_flowctl;    /**< Transmit Flow Control */
> +
> +    uint32_t     mii_cmd;       /**< Management Interface Command */
> +    uint32_t     mii_data;      /**< Management Interface Data */
> +
> +    /** @} */
> +
> +} AwSun8iEmacState;
> +
> +#endif /* HW_NET_ALLWINNER_SUN8I_H */
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index 8c7ac61517..d1245d2b01 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -54,6 +54,7 @@ const hwaddr allwinner_h3_memmap[] =3D {
>      [AW_H3_UART1]      =3D 0x01c28400,
>      [AW_H3_UART2]      =3D 0x01c28800,
>      [AW_H3_UART3]      =3D 0x01c28c00,
> +    [AW_H3_EMAC]       =3D 0x01c30000,
>      [AW_H3_GIC_DIST]   =3D 0x01c81000,
>      [AW_H3_GIC_CPU]    =3D 0x01c82000,
>      [AW_H3_GIC_HYP]    =3D 0x01c84000,
> @@ -106,7 +107,6 @@ struct AwH3Unimplemented {
>      { "twi1",      0x01c2b000, 1 * KiB },
>      { "twi2",      0x01c2b400, 1 * KiB },
>      { "scr",       0x01c2c400, 1 * KiB },
> -    { "emac",      0x01c30000, 64 * KiB },
>      { "gpu",       0x01c40000, 64 * KiB },
>      { "hstmr",     0x01c60000, 4 * KiB },
>      { "dramcom",   0x01c62000, 4 * KiB },
> @@ -162,6 +162,7 @@ enum {
>      AW_H3_GIC_SPI_OHCI2     =3D 77,
>      AW_H3_GIC_SPI_EHCI3     =3D 78,
>      AW_H3_GIC_SPI_OHCI3     =3D 79,
> +    AW_H3_GIC_SPI_EMAC      =3D 82
>  };
>=20=20
>  /* Allwinner H3 general constants */
> @@ -207,6 +208,9 @@ static void allwinner_h3_init(Object *obj)
>=20=20
>      sysbus_init_child_obj(obj, "mmc0", &s->mmc0, sizeof(s->mmc0),
>                            TYPE_AW_SDHOST_SUN5I);
> +
> +    sysbus_init_child_obj(obj, "emac", &s->emac, sizeof(s->emac),
> +                          TYPE_AW_SUN8I_EMAC);
>  }
>=20=20
>  static void allwinner_h3_realize(DeviceState *dev, Error **errp)
> @@ -337,6 +341,16 @@ static void allwinner_h3_realize(DeviceState *dev, E=
rror **errp)
>      object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->mmc0),
>                                "sd-bus", &error_abort);
>=20=20
> +    /* EMAC */
> +    if (nd_table[0].used) {
> +        qemu_check_nic_model(&nd_table[0], TYPE_AW_SUN8I_EMAC);
> +        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
> +    }
> +    qdev_init_nofail(DEVICE(&s->emac));
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emac), 0, s->memmap[AW_H3_EMAC]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->emac), 0,
> +                       qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_E=
MAC));
> +
>      /* Universal Serial Bus */
>      sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
>                           qdev_get_gpio_in(DEVICE(&s->gic),
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> index e5e3f74743..4299c59b8a 100644
> --- a/hw/arm/orangepi.c
> +++ b/hw/arm/orangepi.c
> @@ -78,6 +78,9 @@ static void orangepi_init(MachineState *machine)
>                          "not include H3 prefix\n");
>      }
>=20=20
> +    /* Setup EMAC properties */
> +    object_property_set_int(OBJECT(&h3->emac), 1, "phy-addr", &error_abo=
rt);
> +
>      /* Mark H3 object realized */
>      object_property_set_bool(OBJECT(h3), true, "realized", &error_abort);
>=20=20
> diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
> new file mode 100644
> index 0000000000..3fc5e34640
> --- /dev/null
> +++ b/hw/net/allwinner-sun8i-emac.c
> @@ -0,0 +1,871 @@
> +/*
> + * Allwinner Sun8i Ethernet MAC emulation
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
> +#include "net/net.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +#include "net/checksum.h"
> +#include "qemu/module.h"
> +#include "exec/cpu-common.h"
> +#include "hw/net/allwinner-sun8i-emac.h"
> +
> +/* EMAC register offsets */
> +enum {
> +    REG_BASIC_CTL_0        =3D 0x0000, /* Basic Control 0 */
> +    REG_BASIC_CTL_1        =3D 0x0004, /* Basic Control 1 */
> +    REG_INT_STA            =3D 0x0008, /* Interrupt Status */
> +    REG_INT_EN             =3D 0x000C, /* Interrupt Enable */
> +    REG_TX_CTL_0           =3D 0x0010, /* Transmit Control 0 */
> +    REG_TX_CTL_1           =3D 0x0014, /* Transmit Control 1 */
> +    REG_TX_FLOW_CTL        =3D 0x001C, /* Transmit Flow Control */
> +    REG_TX_DMA_DESC_LIST   =3D 0x0020, /* Transmit Descriptor List Addre=
ss */
> +    REG_RX_CTL_0           =3D 0x0024, /* Receive Control 0 */
> +    REG_RX_CTL_1           =3D 0x0028, /* Receive Control 1 */
> +    REG_RX_DMA_DESC_LIST   =3D 0x0034, /* Receive Descriptor List Addres=
s */
> +    REG_FRM_FLT            =3D 0x0038, /* Receive Frame Filter */
> +    REG_RX_HASH_0          =3D 0x0040, /* Receive Hash Table 0 */
> +    REG_RX_HASH_1          =3D 0x0044, /* Receive Hash Table 1 */
> +    REG_MII_CMD            =3D 0x0048, /* Management Interface Command */
> +    REG_MII_DATA           =3D 0x004C, /* Management Interface Data */
> +    REG_ADDR_HIGH          =3D 0x0050, /* MAC Address High */
> +    REG_ADDR_LOW           =3D 0x0054, /* MAC Address Low */
> +    REG_TX_DMA_STA         =3D 0x00B0, /* Transmit DMA Status */
> +    REG_TX_CUR_DESC        =3D 0x00B4, /* Transmit Current Descriptor */
> +    REG_TX_CUR_BUF         =3D 0x00B8, /* Transmit Current Buffer */
> +    REG_RX_DMA_STA         =3D 0x00C0, /* Receive DMA Status */
> +    REG_RX_CUR_DESC        =3D 0x00C4, /* Receive Current Descriptor */
> +    REG_RX_CUR_BUF         =3D 0x00C8, /* Receive Current Buffer */
> +    REG_RGMII_STA          =3D 0x00D0, /* RGMII Status */
> +};
> +
> +/* EMAC register flags */
> +enum {
> +    BASIC_CTL0_100Mbps     =3D (0b11 << 2),
> +    BASIC_CTL0_FD          =3D (1 << 0),
> +    BASIC_CTL1_SOFTRST     =3D (1 << 0),
> +};
> +
> +enum {
> +    INT_STA_RGMII_LINK     =3D (1 << 16),
> +    INT_STA_RX_EARLY       =3D (1 << 13),
> +    INT_STA_RX_OVERFLOW    =3D (1 << 12),
> +    INT_STA_RX_TIMEOUT     =3D (1 << 11),
> +    INT_STA_RX_DMA_STOP    =3D (1 << 10),
> +    INT_STA_RX_BUF_UA      =3D (1 << 9),
> +    INT_STA_RX             =3D (1 << 8),
> +    INT_STA_TX_EARLY       =3D (1 << 5),
> +    INT_STA_TX_UNDERFLOW   =3D (1 << 4),
> +    INT_STA_TX_TIMEOUT     =3D (1 << 3),
> +    INT_STA_TX_BUF_UA      =3D (1 << 2),
> +    INT_STA_TX_DMA_STOP    =3D (1 << 1),
> +    INT_STA_TX             =3D (1 << 0),
> +};
> +
> +enum {
> +    INT_EN_RX_EARLY        =3D (1 << 13),
> +    INT_EN_RX_OVERFLOW     =3D (1 << 12),
> +    INT_EN_RX_TIMEOUT      =3D (1 << 11),
> +    INT_EN_RX_DMA_STOP     =3D (1 << 10),
> +    INT_EN_RX_BUF_UA       =3D (1 << 9),
> +    INT_EN_RX              =3D (1 << 8),
> +    INT_EN_TX_EARLY        =3D (1 << 5),
> +    INT_EN_TX_UNDERFLOW    =3D (1 << 4),
> +    INT_EN_TX_TIMEOUT      =3D (1 << 3),
> +    INT_EN_TX_BUF_UA       =3D (1 << 2),
> +    INT_EN_TX_DMA_STOP     =3D (1 << 1),
> +    INT_EN_TX              =3D (1 << 0),
> +};
> +
> +enum {
> +    TX_CTL0_TX_EN          =3D (1 << 31),
> +    TX_CTL1_TX_DMA_START   =3D (1 << 31),
> +    TX_CTL1_TX_DMA_EN      =3D (1 << 30),
> +    TX_CTL1_TX_FLUSH       =3D (1 << 0),
> +};
> +
> +enum {
> +    RX_CTL0_RX_EN          =3D (1 << 31),
> +    RX_CTL0_STRIP_FCS      =3D (1 << 28),
> +    RX_CTL0_CRC_IPV4       =3D (1 << 27),
> +};
> +
> +enum {
> +    RX_CTL1_RX_DMA_START   =3D (1 << 31),
> +    RX_CTL1_RX_DMA_EN      =3D (1 << 30),
> +    RX_CTL1_RX_MD          =3D (1 << 1),
> +};
> +
> +enum {
> +    RX_FRM_FLT_DIS_ADDR    =3D (1 << 31),
> +};
> +
> +enum {
> +    MII_CMD_PHY_ADDR_SHIFT =3D (12),
> +    MII_CMD_PHY_ADDR_MASK  =3D (0xf000),
> +    MII_CMD_PHY_REG_SHIFT  =3D (4),
> +    MII_CMD_PHY_REG_MASK   =3D (0xf0),
> +    MII_CMD_PHY_RW         =3D (1 << 1),
> +    MII_CMD_PHY_BUSY       =3D (1 << 0),
> +};
> +
> +enum {
> +    TX_DMA_STA_STOP        =3D (0b000),
> +    TX_DMA_STA_RUN_FETCH   =3D (0b001),
> +    TX_DMA_STA_WAIT_STA    =3D (0b010),
> +};
> +
> +enum {
> +    RX_DMA_STA_STOP        =3D (0b000),
> +    RX_DMA_STA_RUN_FETCH   =3D (0b001),
> +    RX_DMA_STA_WAIT_FRM    =3D (0b011),
> +};
> +
> +/* EMAC register reset values */
> +enum {
> +    REG_BASIC_CTL_1_RST    =3D 0x08000000,
> +};
> +
> +/* EMAC constants */
> +enum {
> +    AW_SUN8I_EMAC_MIN_PKT_SZ  =3D 64
> +};
> +
> +/* Transmit/receive frame descriptor */
> +typedef struct FrameDescriptor {
> +    uint32_t status;
> +    uint32_t status2;
> +    uint32_t addr;
> +    uint32_t next;
> +} FrameDescriptor;
> +
> +/* Frame descriptor flags */
> +enum {
> +    DESC_STATUS_CTL                 =3D (1 << 31),
> +    DESC_STATUS2_BUF_SIZE_MASK      =3D (0x7ff),
> +};
> +
> +/* Transmit frame descriptor flags */
> +enum {
> +    TX_DESC_STATUS_LENGTH_ERR       =3D (1 << 14),
> +    TX_DESC_STATUS2_FIRST_DESC      =3D (1 << 29),
> +    TX_DESC_STATUS2_LAST_DESC       =3D (1 << 30),
> +    TX_DESC_STATUS2_CHECKSUM_MASK   =3D (0x3 << 27),
> +};
> +
> +/* Receive frame descriptor flags */
> +enum {
> +    RX_DESC_STATUS_FIRST_DESC       =3D (1 << 9),
> +    RX_DESC_STATUS_LAST_DESC        =3D (1 << 8),
> +    RX_DESC_STATUS_FRM_LEN_MASK     =3D (0x3fff0000),
> +    RX_DESC_STATUS_FRM_LEN_SHIFT    =3D (16),
> +    RX_DESC_STATUS_NO_BUF           =3D (1 << 14),
> +    RX_DESC_STATUS_HEADER_ERR       =3D (1 << 7),
> +    RX_DESC_STATUS_LENGTH_ERR       =3D (1 << 4),
> +    RX_DESC_STATUS_CRC_ERR          =3D (1 << 1),
> +    RX_DESC_STATUS_PAYLOAD_ERR      =3D (1 << 0),
> +    RX_DESC_STATUS2_RX_INT_CTL      =3D (1 << 31),
> +};
> +
> +/* MII register offsets */
> +enum {
> +    MII_REG_CR                      =3D (0x0), /* Control */
> +    MII_REG_ST                      =3D (0x1), /* Status */
> +    MII_REG_ID_HIGH                 =3D (0x2), /* Identifier High */
> +    MII_REG_ID_LOW                  =3D (0x3), /* Identifier Low */
> +    MII_REG_ADV                     =3D (0x4), /* Advertised abilities */
> +    MII_REG_LPA                     =3D (0x5), /* Link partner abilities=
 */
> +};
> +
> +/* MII register flags */
> +enum {
> +    MII_REG_CR_RESET                =3D (1 << 15),
> +    MII_REG_CR_POWERDOWN            =3D (1 << 11),
> +    MII_REG_CR_10Mbit               =3D (0),
> +    MII_REG_CR_100Mbit              =3D (1 << 13),
> +    MII_REG_CR_1000Mbit             =3D (1 << 6),
> +    MII_REG_CR_AUTO_NEG             =3D (1 << 12),
> +    MII_REG_CR_AUTO_NEG_RESTART     =3D (1 << 9),
> +    MII_REG_CR_FULLDUPLEX           =3D (1 << 8),
> +};
> +
> +enum {
> +    MII_REG_ST_100BASE_T4           =3D (1 << 15),
> +    MII_REG_ST_100BASE_X_FD         =3D (1 << 14),
> +    MII_REG_ST_100BASE_X_HD         =3D (1 << 13),
> +    MII_REG_ST_10_FD                =3D (1 << 12),
> +    MII_REG_ST_10_HD                =3D (1 << 11),
> +    MII_REG_ST_100BASE_T2_FD        =3D (1 << 10),
> +    MII_REG_ST_100BASE_T2_HD        =3D (1 << 9),
> +    MII_REG_ST_AUTONEG_COMPLETE     =3D (1 << 5),
> +    MII_REG_ST_AUTONEG_AVAIL        =3D (1 << 3),
> +    MII_REG_ST_LINK_UP              =3D (1 << 2),
> +};
> +
> +enum {
> +    MII_REG_LPA_10_HD               =3D (1 << 5),
> +    MII_REG_LPA_10_FD               =3D (1 << 6),
> +    MII_REG_LPA_100_HD              =3D (1 << 7),
> +    MII_REG_LPA_100_FD              =3D (1 << 8),
> +    MII_REG_LPA_PAUSE               =3D (1 << 10),
> +    MII_REG_LPA_ASYMPAUSE           =3D (1 << 11),
> +};
> +
> +/* MII constants */
> +enum {
> +    MII_PHY_ID_HIGH                 =3D 0x0044,
> +    MII_PHY_ID_LOW                  =3D 0x1400,
> +};
> +
> +static void allwinner_sun8i_emac_mii_set_link(AwSun8iEmacState *s,
> +                                              bool link_active)
> +{
> +    if (link_active) {
> +        s->mii_st |=3D MII_REG_ST_LINK_UP;
> +    } else {
> +        s->mii_st &=3D ~MII_REG_ST_LINK_UP;
> +    }
> +}
> +
> +static void allwinner_sun8i_emac_mii_reset(AwSun8iEmacState *s,
> +                                           bool link_active)
> +{
> +    s->mii_cr =3D MII_REG_CR_100Mbit | MII_REG_CR_AUTO_NEG |
> +                MII_REG_CR_FULLDUPLEX;
> +    s->mii_st =3D MII_REG_ST_100BASE_T4 | MII_REG_ST_100BASE_X_FD |
> +                MII_REG_ST_100BASE_X_HD | MII_REG_ST_10_FD | MII_REG_ST_=
10_HD |
> +                MII_REG_ST_100BASE_T2_FD | MII_REG_ST_100BASE_T2_HD |
> +                MII_REG_ST_AUTONEG_COMPLETE | MII_REG_ST_AUTONEG_AVAIL;
> +    s->mii_adv =3D 0;
> +
> +    allwinner_sun8i_emac_mii_set_link(s, link_active);
> +}
> +
> +static void allwinner_sun8i_emac_mii_cmd(AwSun8iEmacState *s)
> +{
> +    uint8_t addr, reg;
> +
> +    addr =3D (s->mii_cmd & MII_CMD_PHY_ADDR_MASK) >> MII_CMD_PHY_ADDR_SH=
IFT;
> +    reg =3D (s->mii_cmd & MII_CMD_PHY_REG_MASK) >> MII_CMD_PHY_REG_SHIFT;
> +
> +    if (addr !=3D s->mii_phy_addr) {
> +        return;
> +    }
> +
> +    /* Read or write a PHY register? */
> +    if (s->mii_cmd & MII_CMD_PHY_RW) {
> +        trace_allwinner_sun8i_emac_mii_write_reg(reg, s->mii_data);
> +
> +        switch (reg) {
> +        case MII_REG_CR:
> +            if (s->mii_data & MII_REG_CR_RESET) {
> +                allwinner_sun8i_emac_mii_reset(s, s->mii_st &
> +                                                  MII_REG_ST_LINK_UP);
> +            } else {
> +                s->mii_cr =3D s->mii_data & ~(MII_REG_CR_RESET |
> +                                            MII_REG_CR_AUTO_NEG_RESTART);
> +            }
> +            break;
> +        case MII_REG_ADV:
> +            s->mii_adv =3D s->mii_data;
> +            break;
> +        case MII_REG_ID_HIGH:
> +        case MII_REG_ID_LOW:
> +        case MII_REG_LPA:
> +            break;
> +        default:
> +            qemu_log_mask(LOG_UNIMP, "allwinner-h3-emac: write access to=
 "
> +                                     "unknown MII register 0x%x\n", reg);
> +            break;
> +        }
> +    } else {
> +        switch (reg) {
> +        case MII_REG_CR:
> +            s->mii_data =3D s->mii_cr;
> +            break;
> +        case MII_REG_ST:
> +            s->mii_data =3D s->mii_st;
> +            break;
> +        case MII_REG_ID_HIGH:
> +            s->mii_data =3D MII_PHY_ID_HIGH;
> +            break;
> +        case MII_REG_ID_LOW:
> +            s->mii_data =3D MII_PHY_ID_LOW;
> +            break;
> +        case MII_REG_ADV:
> +            s->mii_data =3D s->mii_adv;
> +            break;
> +        case MII_REG_LPA:
> +            s->mii_data =3D MII_REG_LPA_10_HD | MII_REG_LPA_10_FD |
> +                          MII_REG_LPA_100_HD | MII_REG_LPA_100_FD |
> +                          MII_REG_LPA_PAUSE | MII_REG_LPA_ASYMPAUSE;
> +            break;
> +        default:
> +            qemu_log_mask(LOG_UNIMP, "allwinner-h3-emac: read access to "
> +                                     "unknown MII register 0x%x\n", reg);
> +            s->mii_data =3D 0;
> +            break;
> +        }
> +
> +        trace_allwinner_sun8i_emac_mii_read_reg(reg, s->mii_data);
> +    }
> +}
> +
> +static void allwinner_sun8i_emac_update_irq(AwSun8iEmacState *s)
> +{
> +    qemu_set_irq(s->irq, (s->int_sta & s->int_en) !=3D 0);
> +}
> +
> +static uint32_t allwinner_sun8i_emac_next_desc(FrameDescriptor *desc,
> +                                               size_t min_size)
> +{
> +    uint32_t paddr =3D desc->next;
> +
> +    cpu_physical_memory_read(paddr, desc, sizeof(*desc));
> +
> +    if ((desc->status & DESC_STATUS_CTL) &&
> +        (desc->status2 & DESC_STATUS2_BUF_SIZE_MASK) >=3D min_size) {
> +        return paddr;
> +    } else {
> +        return 0;
> +    }
> +}
> +
> +static uint32_t allwinner_sun8i_emac_get_desc(FrameDescriptor *desc,
> +                                              uint32_t start_addr,
> +                                              size_t min_size)
> +{
> +    uint32_t desc_addr =3D start_addr;
> +
> +    /* Note that the list is a cycle. Last entry points back to the head=
. */
> +    while (desc_addr !=3D 0) {
> +        cpu_physical_memory_read(desc_addr, desc, sizeof(*desc));
> +
> +        if ((desc->status & DESC_STATUS_CTL) &&
> +            (desc->status2 & DESC_STATUS2_BUF_SIZE_MASK) >=3D min_size) {
> +            return desc_addr;
> +        } else if (desc->next =3D=3D start_addr) {
> +            break;
> +        } else {
> +            desc_addr =3D desc->next;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static uint32_t allwinner_sun8i_emac_rx_desc(AwSun8iEmacState *s,
> +                                             FrameDescriptor *desc,
> +                                             size_t min_size)
> +{
> +    return allwinner_sun8i_emac_get_desc(desc, s->rx_desc_curr, min_size=
);
> +}
> +
> +static uint32_t allwinner_sun8i_emac_tx_desc(AwSun8iEmacState *s,
> +                                             FrameDescriptor *desc,
> +                                             size_t min_size)
> +{
> +    return allwinner_sun8i_emac_get_desc(desc, s->tx_desc_head, min_size=
);
> +}
> +
> +static void allwinner_sun8i_emac_flush_desc(FrameDescriptor *desc,
> +                                            uint32_t phys_addr)
> +{
> +    cpu_physical_memory_write(phys_addr, desc, sizeof(*desc));
> +}
> +
> +static int allwinner_sun8i_emac_can_receive(NetClientState *nc)
> +{
> +    AwSun8iEmacState *s =3D qemu_get_nic_opaque(nc);
> +    FrameDescriptor desc;
> +
> +    return (s->rx_ctl0 & RX_CTL0_RX_EN) &&
> +           (allwinner_sun8i_emac_rx_desc(s, &desc, 0) !=3D 0);
> +}
> +
> +static ssize_t allwinner_sun8i_emac_receive(NetClientState *nc,
> +                                            const uint8_t *buf,
> +                                            size_t size)
> +{
> +    AwSun8iEmacState *s =3D qemu_get_nic_opaque(nc);
> +    FrameDescriptor desc;
> +    size_t bytes_left =3D size;
> +    size_t desc_bytes =3D 0;
> +    size_t pad_fcs_size =3D 4;
> +    size_t padding =3D 0;
> +
> +    if (!(s->rx_ctl0 & RX_CTL0_RX_EN)) {
> +        return -1;
> +    }
> +
> +    s->rx_desc_curr =3D allwinner_sun8i_emac_rx_desc(s, &desc,
> +                                                   AW_SUN8I_EMAC_MIN_PKT=
_SZ);
> +    if (!s->rx_desc_curr) {
> +        s->int_sta |=3D INT_STA_RX_BUF_UA;
> +    }
> +
> +    /* Keep filling RX descriptors until the whole frame is written */
> +    while (s->rx_desc_curr && bytes_left > 0) {
> +        desc.status &=3D ~DESC_STATUS_CTL;
> +        desc.status &=3D ~RX_DESC_STATUS_FRM_LEN_MASK;
> +
> +        if (bytes_left =3D=3D size) {
> +            desc.status |=3D RX_DESC_STATUS_FIRST_DESC;
> +        }
> +
> +        if ((desc.status2 & DESC_STATUS2_BUF_SIZE_MASK) <
> +            (bytes_left + pad_fcs_size)) {
> +            desc_bytes =3D desc.status2 & DESC_STATUS2_BUF_SIZE_MASK;
> +            desc.status |=3D desc_bytes << RX_DESC_STATUS_FRM_LEN_SHIFT;
> +        } else {
> +            padding =3D pad_fcs_size;
> +            if (bytes_left < AW_SUN8I_EMAC_MIN_PKT_SZ) {
> +                padding +=3D (AW_SUN8I_EMAC_MIN_PKT_SZ - bytes_left);
> +            }
> +
> +            desc_bytes =3D (bytes_left);
> +            desc.status |=3D RX_DESC_STATUS_LAST_DESC;
> +            desc.status |=3D (bytes_left + padding)
> +                            << RX_DESC_STATUS_FRM_LEN_SHIFT;
> +        }
> +
> +        cpu_physical_memory_write(desc.addr, buf, desc_bytes);
> +        allwinner_sun8i_emac_flush_desc(&desc, s->rx_desc_curr);
> +        trace_allwinner_sun8i_emac_receive(s->rx_desc_curr, desc.addr,
> +                                           desc_bytes);
> +
> +        /* Check if frame needs to raise the receive interrupt */
> +        if (!(desc.status2 & RX_DESC_STATUS2_RX_INT_CTL)) {
> +            s->int_sta |=3D INT_STA_RX;
> +        }
> +
> +        /* Increment variables */
> +        buf +=3D desc_bytes;
> +        bytes_left -=3D desc_bytes;
> +
> +        /* Move to the next descriptor */
> +        s->rx_desc_curr =3D allwinner_sun8i_emac_next_desc(&desc, 64);
> +        if (!s->rx_desc_curr) {
> +            /* Not enough buffer space available */
> +            s->int_sta |=3D INT_STA_RX_BUF_UA;
> +            s->rx_desc_curr =3D s->rx_desc_head;
> +            break;
> +        }
> +    }
> +
> +    /* Report receive DMA is finished */
> +    s->rx_ctl1 &=3D ~RX_CTL1_RX_DMA_START;
> +    allwinner_sun8i_emac_update_irq(s);
> +
> +    return size;
> +}
> +
> +static void allwinner_sun8i_emac_transmit(AwSun8iEmacState *s)
> +{
> +    NetClientState *nc =3D qemu_get_queue(s->nic);
> +    FrameDescriptor desc;
> +    size_t bytes =3D 0;
> +    size_t packet_bytes =3D 0;
> +    size_t transmitted =3D 0;
> +    static uint8_t packet_buf[2048];
> +
> +    s->tx_desc_curr =3D allwinner_sun8i_emac_tx_desc(s, &desc, 0);
> +
> +    /* Read all transmit descriptors */
> +    while (s->tx_desc_curr !=3D 0) {
> +
> +        /* Read from physical memory into packet buffer */
> +        bytes =3D desc.status2 & DESC_STATUS2_BUF_SIZE_MASK;
> +        if (bytes + packet_bytes > sizeof(packet_buf)) {
> +            desc.status |=3D TX_DESC_STATUS_LENGTH_ERR;
> +            break;
> +        }
> +        cpu_physical_memory_read(desc.addr, packet_buf + packet_bytes, b=
ytes);
> +        packet_bytes +=3D bytes;
> +        desc.status &=3D ~DESC_STATUS_CTL;
> +        allwinner_sun8i_emac_flush_desc(&desc, s->tx_desc_curr);
> +
> +        /* After the last descriptor, send the packet */
> +        if (desc.status2 & TX_DESC_STATUS2_LAST_DESC) {
> +            if (desc.status2 & TX_DESC_STATUS2_CHECKSUM_MASK) {
> +                net_checksum_calculate(packet_buf, packet_bytes);
> +            }
> +
> +            qemu_send_packet(nc, packet_buf, packet_bytes);
> +            trace_allwinner_sun8i_emac_transmit(s->tx_desc_curr, desc.ad=
dr,
> +                                                bytes);
> +
> +            packet_bytes =3D 0;
> +            transmitted++;
> +        }
> +        s->tx_desc_curr =3D allwinner_sun8i_emac_next_desc(&desc, 0);
> +    }
> +
> +    /* Raise transmit completed interrupt */
> +    if (transmitted > 0) {
> +        s->int_sta |=3D INT_STA_TX;
> +        s->tx_ctl1 &=3D ~TX_CTL1_TX_DMA_START;
> +        allwinner_sun8i_emac_update_irq(s);
> +    }
> +}
> +
> +static void allwinner_sun8i_emac_reset(DeviceState *dev)
> +{
> +    AwSun8iEmacState *s =3D AW_SUN8I_EMAC(dev);
> +    NetClientState *nc =3D qemu_get_queue(s->nic);
> +
> +    trace_allwinner_sun8i_emac_reset();
> +
> +    s->mii_cmd =3D 0;
> +    s->mii_data =3D 0;
> +    s->basic_ctl0 =3D 0;
> +    s->basic_ctl1 =3D REG_BASIC_CTL_1_RST;
> +    s->int_en =3D 0;
> +    s->int_sta =3D 0;
> +    s->frm_flt =3D 0;
> +    s->rx_ctl0 =3D 0;
> +    s->rx_ctl1 =3D RX_CTL1_RX_MD;
> +    s->rx_desc_head =3D 0;
> +    s->rx_desc_curr =3D 0;
> +    s->tx_ctl0 =3D 0;
> +    s->tx_ctl1 =3D 0;
> +    s->tx_desc_head =3D 0;
> +    s->tx_desc_curr =3D 0;
> +    s->tx_flowctl =3D 0;
> +
> +    allwinner_sun8i_emac_mii_reset(s, !nc->link_down);
> +}
> +
> +static uint64_t allwinner_sun8i_emac_read(void *opaque, hwaddr offset,
> +                                          unsigned size)
> +{
> +    AwSun8iEmacState *s =3D AW_SUN8I_EMAC(opaque);
> +    uint64_t value =3D 0;
> +    FrameDescriptor desc;
> +
> +    switch (offset) {
> +    case REG_BASIC_CTL_0:       /* Basic Control 0 */
> +        value =3D s->basic_ctl0;
> +        break;
> +    case REG_BASIC_CTL_1:       /* Basic Control 1 */
> +        value =3D s->basic_ctl1;
> +        break;
> +    case REG_INT_STA:           /* Interrupt Status */
> +        value =3D s->int_sta;
> +        break;
> +    case REG_INT_EN:            /* Interupt Enable */
> +        value =3D s->int_en;
> +        break;
> +    case REG_TX_CTL_0:          /* Transmit Control 0 */
> +        value =3D s->tx_ctl0;
> +        break;
> +    case REG_TX_CTL_1:          /* Transmit Control 1 */
> +        value =3D s->tx_ctl1;
> +        break;
> +    case REG_TX_FLOW_CTL:       /* Transmit Flow Control */
> +        value =3D s->tx_flowctl;
> +        break;
> +    case REG_TX_DMA_DESC_LIST:  /* Transmit Descriptor List Address */
> +        value =3D s->tx_desc_head;
> +        break;
> +    case REG_RX_CTL_0:          /* Receive Control 0 */
> +        value =3D s->rx_ctl0;
> +        break;
> +    case REG_RX_CTL_1:          /* Receive Control 1 */
> +        value =3D s->rx_ctl1;
> +        break;
> +    case REG_RX_DMA_DESC_LIST:  /* Receive Descriptor List Address */
> +        value =3D s->rx_desc_head;
> +        break;
> +    case REG_FRM_FLT:           /* Receive Frame Filter */
> +        value =3D s->frm_flt;
> +        break;
> +    case REG_RX_HASH_0:         /* Receive Hash Table 0 */
> +    case REG_RX_HASH_1:         /* Receive Hash Table 1 */
> +        break;
> +    case REG_MII_CMD:           /* Management Interface Command */
> +        value =3D s->mii_cmd;
> +        break;
> +    case REG_MII_DATA:          /* Management Interface Data */
> +        value =3D s->mii_data;
> +        break;
> +    case REG_ADDR_HIGH:         /* MAC Address High */
> +        value =3D *(((uint32_t *) (s->conf.macaddr.a)) + 1);
> +        break;
> +    case REG_ADDR_LOW:          /* MAC Address Low */
> +        value =3D *(uint32_t *) (s->conf.macaddr.a);
> +        break;
> +    case REG_TX_DMA_STA:        /* Transmit DMA Status */
> +        break;
> +    case REG_TX_CUR_DESC:       /* Transmit Current Descriptor */
> +        value =3D s->tx_desc_curr;
> +        break;
> +    case REG_TX_CUR_BUF:        /* Transmit Current Buffer */
> +        if (s->tx_desc_curr !=3D 0) {
> +            cpu_physical_memory_read(s->tx_desc_curr, &desc, sizeof(desc=
));
> +            value =3D desc.addr;
> +        } else {
> +            value =3D 0;
> +        }
> +        break;
> +    case REG_RX_DMA_STA:        /* Receive DMA Status */
> +        break;
> +    case REG_RX_CUR_DESC:       /* Receive Current Descriptor */
> +        value =3D s->rx_desc_curr;
> +        break;
> +    case REG_RX_CUR_BUF:        /* Receive Current Buffer */
> +        if (s->rx_desc_curr !=3D 0) {
> +            cpu_physical_memory_read(s->rx_desc_curr, &desc, sizeof(desc=
));
> +            value =3D desc.addr;
> +        } else {
> +            value =3D 0;
> +        }
> +        break;
> +    case REG_RGMII_STA:         /* RGMII Status */
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "allwinner-h3-emac: read access to unkn=
own "
> +                                 "EMAC register 0x" TARGET_FMT_plx "\n",
> +                                  offset);
> +    }
> +
> +    trace_allwinner_sun8i_emac_read(offset, value);
> +    return value;
> +}
> +
> +static void allwinner_sun8i_emac_write(void *opaque, hwaddr offset,
> +                                       uint64_t value, unsigned size)
> +{
> +    AwSun8iEmacState *s =3D AW_SUN8I_EMAC(opaque);
> +    NetClientState *nc =3D qemu_get_queue(s->nic);
> +
> +    trace_allwinner_sun8i_emac_write(offset, value);
> +
> +    switch (offset) {
> +    case REG_BASIC_CTL_0:       /* Basic Control 0 */
> +        s->basic_ctl0 =3D value;
> +        break;
> +    case REG_BASIC_CTL_1:       /* Basic Control 1 */
> +        if (value & BASIC_CTL1_SOFTRST) {
> +            allwinner_sun8i_emac_reset(DEVICE(s));
> +            value &=3D ~BASIC_CTL1_SOFTRST;
> +        }
> +        s->basic_ctl1 =3D value;
> +        if (allwinner_sun8i_emac_can_receive(nc)) {
> +            qemu_flush_queued_packets(nc);
> +        }
> +        break;
> +    case REG_INT_STA:           /* Interrupt Status */
> +        s->int_sta &=3D ~value;
> +        allwinner_sun8i_emac_update_irq(s);
> +        break;
> +    case REG_INT_EN:            /* Interrupt Enable */
> +        s->int_en =3D value;
> +        allwinner_sun8i_emac_update_irq(s);
> +        break;
> +    case REG_TX_CTL_0:          /* Transmit Control 0 */
> +        s->tx_ctl0 =3D value;
> +        break;
> +    case REG_TX_CTL_1:          /* Transmit Control 1 */
> +        s->tx_ctl1 =3D value;
> +        if (value & TX_CTL1_TX_DMA_EN) {
> +            allwinner_sun8i_emac_transmit(s);
> +        }
> +        break;
> +    case REG_TX_FLOW_CTL:       /* Transmit Flow Control */
> +        s->tx_flowctl =3D value;
> +        break;
> +    case REG_TX_DMA_DESC_LIST:  /* Transmit Descriptor List Address */
> +        s->tx_desc_head =3D value;
> +        s->tx_desc_curr =3D value;
> +        break;
> +    case REG_RX_CTL_0:          /* Receive Control 0 */
> +        s->rx_ctl0 =3D value;
> +        break;
> +    case REG_RX_CTL_1:          /* Receive Control 1 */
> +        s->rx_ctl1 =3D value | RX_CTL1_RX_MD;
> +        if ((value & RX_CTL1_RX_DMA_EN) &&
> +             allwinner_sun8i_emac_can_receive(nc)) {
> +            qemu_flush_queued_packets(nc);
> +        }
> +        break;
> +    case REG_RX_DMA_DESC_LIST:  /* Receive Descriptor List Address */
> +        s->rx_desc_head =3D value;
> +        s->rx_desc_curr =3D value;
> +        break;
> +    case REG_FRM_FLT:           /* Receive Frame Filter */
> +        s->frm_flt =3D value;
> +        break;
> +    case REG_RX_HASH_0:         /* Receive Hash Table 0 */
> +    case REG_RX_HASH_1:         /* Receive Hash Table 1 */
> +        break;
> +    case REG_MII_CMD:           /* Management Interface Command */
> +        s->mii_cmd =3D value & ~MII_CMD_PHY_BUSY;
> +        allwinner_sun8i_emac_mii_cmd(s);
> +        break;
> +    case REG_MII_DATA:          /* Management Interface Data */
> +        s->mii_data =3D value;
> +        break;
> +    case REG_ADDR_HIGH:         /* MAC Address High */
> +        s->conf.macaddr.a[4] =3D (value & 0xff);
> +        s->conf.macaddr.a[5] =3D (value & 0xff00) >> 8;
> +        break;
> +    case REG_ADDR_LOW:          /* MAC Address Low */
> +        s->conf.macaddr.a[0] =3D (value & 0xff);
> +        s->conf.macaddr.a[1] =3D (value & 0xff00) >> 8;
> +        s->conf.macaddr.a[2] =3D (value & 0xff0000) >> 16;
> +        s->conf.macaddr.a[3] =3D (value & 0xff000000) >> 24;
> +        break;
> +    case REG_TX_DMA_STA:        /* Transmit DMA Status */
> +    case REG_TX_CUR_DESC:       /* Transmit Current Descriptor */
> +    case REG_TX_CUR_BUF:        /* Transmit Current Buffer */
> +    case REG_RX_DMA_STA:        /* Receive DMA Status */
> +    case REG_RX_CUR_DESC:       /* Receive Current Descriptor */
> +    case REG_RX_CUR_BUF:        /* Receive Current Buffer */
> +    case REG_RGMII_STA:         /* RGMII Status */
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "allwinner-h3-emac: write access to unk=
nown "
> +                                 "EMAC register 0x" TARGET_FMT_plx "\n",
> +                                  offset);
> +    }
> +}
> +
> +static void allwinner_sun8i_emac_set_link(NetClientState *nc)
> +{
> +    AwSun8iEmacState *s =3D qemu_get_nic_opaque(nc);
> +
> +    trace_allwinner_sun8i_emac_set_link(!nc->link_down);
> +    allwinner_sun8i_emac_mii_set_link(s, !nc->link_down);
> +}
> +
> +static const MemoryRegionOps allwinner_sun8i_emac_mem_ops =3D {
> +    .read =3D allwinner_sun8i_emac_read,
> +    .write =3D allwinner_sun8i_emac_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +    .impl.min_access_size =3D 4,
> +};
> +
> +static NetClientInfo net_allwinner_sun8i_emac_info =3D {
> +    .type =3D NET_CLIENT_DRIVER_NIC,
> +    .size =3D sizeof(NICState),
> +    .can_receive =3D allwinner_sun8i_emac_can_receive,
> +    .receive =3D allwinner_sun8i_emac_receive,
> +    .link_status_changed =3D allwinner_sun8i_emac_set_link,
> +};
> +
> +static void allwinner_sun8i_emac_init(Object *obj)
> +{
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    AwSun8iEmacState *s =3D AW_SUN8I_EMAC(obj);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_sun8i_emac_me=
m_ops,
> +                           s, TYPE_AW_SUN8I_EMAC, 64 * KiB);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_irq(sbd, &s->irq);
> +}
> +
> +static void allwinner_sun8i_emac_realize(DeviceState *dev, Error **errp)
> +{
> +    AwSun8iEmacState *s =3D AW_SUN8I_EMAC(dev);
> +
> +    qemu_macaddr_default_if_unset(&s->conf.macaddr);
> +    s->nic =3D qemu_new_nic(&net_allwinner_sun8i_emac_info, &s->conf,
> +                           object_get_typename(OBJECT(dev)), dev->id, s);
> +    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
> +}
> +
> +static Property allwinner_sun8i_emac_properties[] =3D {
> +    DEFINE_NIC_PROPERTIES(AwSun8iEmacState, conf),
> +    DEFINE_PROP_UINT8("phy-addr", AwSun8iEmacState, mii_phy_addr, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static int allwinner_sun8i_emac_post_load(void *opaque, int version_id)
> +{
> +    AwSun8iEmacState *s =3D opaque;
> +
> +    allwinner_sun8i_emac_set_link(qemu_get_queue(s->nic));
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_aw_emac =3D {
> +    .name =3D "allwinner-sun8i-emac",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .post_load =3D allwinner_sun8i_emac_post_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8(mii_phy_addr, AwSun8iEmacState),
> +        VMSTATE_UINT32(mii_cmd, AwSun8iEmacState),
> +        VMSTATE_UINT32(mii_data, AwSun8iEmacState),
> +        VMSTATE_UINT32(mii_cr, AwSun8iEmacState),
> +        VMSTATE_UINT32(mii_st, AwSun8iEmacState),
> +        VMSTATE_UINT32(mii_adv, AwSun8iEmacState),
> +        VMSTATE_UINT32(basic_ctl0, AwSun8iEmacState),
> +        VMSTATE_UINT32(basic_ctl1, AwSun8iEmacState),
> +        VMSTATE_UINT32(int_en, AwSun8iEmacState),
> +        VMSTATE_UINT32(int_sta, AwSun8iEmacState),
> +        VMSTATE_UINT32(frm_flt, AwSun8iEmacState),
> +        VMSTATE_UINT32(rx_ctl0, AwSun8iEmacState),
> +        VMSTATE_UINT32(rx_ctl1, AwSun8iEmacState),
> +        VMSTATE_UINT32(rx_desc_head, AwSun8iEmacState),
> +        VMSTATE_UINT32(rx_desc_curr, AwSun8iEmacState),
> +        VMSTATE_UINT32(tx_ctl0, AwSun8iEmacState),
> +        VMSTATE_UINT32(tx_ctl1, AwSun8iEmacState),
> +        VMSTATE_UINT32(tx_desc_head, AwSun8iEmacState),
> +        VMSTATE_UINT32(tx_desc_curr, AwSun8iEmacState),
> +        VMSTATE_UINT32(tx_flowctl, AwSun8iEmacState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void allwinner_sun8i_emac_class_init(ObjectClass *klass, void *da=
ta)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D allwinner_sun8i_emac_realize;
> +    dc->reset =3D allwinner_sun8i_emac_reset;
> +    dc->vmsd =3D &vmstate_aw_emac;
> +    device_class_set_props(dc, allwinner_sun8i_emac_properties);
> +}
> +
> +static const TypeInfo allwinner_sun8i_emac_info =3D {
> +    .name           =3D TYPE_AW_SUN8I_EMAC,
> +    .parent         =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size  =3D sizeof(AwSun8iEmacState),
> +    .instance_init  =3D allwinner_sun8i_emac_init,
> +    .class_init     =3D allwinner_sun8i_emac_class_init,
> +};
> +
> +static void allwinner_sun8i_emac_register_types(void)
> +{
> +    type_register_static(&allwinner_sun8i_emac_info);
> +}
> +
> +type_init(allwinner_sun8i_emac_register_types)
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index dd22fffdb0..e5a876c8d1 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -300,6 +300,7 @@ config ALLWINNER_A10
>  config ALLWINNER_H3
>      bool
>      select ALLWINNER_A10_PIT
> +    select ALLWINNER_SUN8I_EMAC
>      select SERIAL
>      select ARM_TIMER
>      select ARM_GIC
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index 54411d3dcc..e43c96dae0 100644
> --- a/hw/net/Kconfig
> +++ b/hw/net/Kconfig
> @@ -79,6 +79,9 @@ config MIPSNET
>  config ALLWINNER_EMAC
>      bool
>=20=20
> +config ALLWINNER_SUN8I_EMAC
> +    bool
> +
>  config IMX_FEC
>      bool
>=20=20
> diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
> index 991c46c773..af4d194866 100644
> --- a/hw/net/Makefile.objs
> +++ b/hw/net/Makefile.objs
> @@ -23,6 +23,7 @@ common-obj-$(CONFIG_XGMAC) +=3D xgmac.o
>  common-obj-$(CONFIG_MIPSNET) +=3D mipsnet.o
>  common-obj-$(CONFIG_XILINX_AXI) +=3D xilinx_axienet.o
>  common-obj-$(CONFIG_ALLWINNER_EMAC) +=3D allwinner_emac.o
> +common-obj-$(CONFIG_ALLWINNER_SUN8I_EMAC) +=3D allwinner-sun8i-emac.o
>  common-obj-$(CONFIG_IMX_FEC) +=3D imx_fec.o
>=20=20
>  common-obj-$(CONFIG_CADENCE) +=3D cadence_gem.o
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index a1da98a643..e18f883cfd 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -1,5 +1,15 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>=20=20
> +# allwinner-sun8i-emac.c
> +allwinner_sun8i_emac_mii_write_reg(uint32_t reg, uint32_t value) "MII wr=
ite: reg=3D0x%" PRIx32 " value=3D0x%" PRIx32
> +allwinner_sun8i_emac_mii_read_reg(uint32_t reg, uint32_t value) "MII rea=
d: reg=3D0x%" PRIx32 " value=3D0x%" PRIx32
> +allwinner_sun8i_emac_receive(uint32_t desc, uint32_t paddr, uint32_t byt=
es) "RX packet: desc=3D0x%" PRIx32 " paddr=3D0x%" PRIx32 " bytes=3D%" PRIu32
> +allwinner_sun8i_emac_transmit(uint32_t desc, uint32_t paddr, uint32_t by=
tes) "TX packet: desc=3D0x%" PRIx32 " paddr=3D0x%" PRIx32 " bytes=3D%" PRIu=
32
> +allwinner_sun8i_emac_reset(void) "HW reset"
> +allwinner_sun8i_emac_set_link(bool active) "Set link: active=3D%u"
> +allwinner_sun8i_emac_read(uint64_t offset, uint64_t val) "MMIO read: off=
set=3D0x%" PRIx64 " value=3D0x%" PRIx64
> +allwinner_sun8i_emac_write(uint64_t offset, uint64_t val) "MMIO write: o=
ffset=3D0x%" PRIx64 " value=3D0x%" PRIx64
> +
>  # etraxfs_eth.c
>  mdio_phy_read(int regnum, uint16_t value) "read phy_reg:%d value:0x%04x"
>  mdio_phy_write(int regnum, uint16_t value) "write phy_reg:%d value:0x%04=
x"


--=20
Alex Benn=C3=A9e

