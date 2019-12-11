Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA6CC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 22:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F308D2077B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 22:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPUtnUQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F308D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifAb6-0000Bd-0C
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 17:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ifAZY-0007g7-8I
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 17:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ifAZQ-00078H-EA
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 17:35:08 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ifAZP-00075S-Vx; Wed, 11 Dec 2019 17:35:00 -0500
Received: by mail-io1-xd41.google.com with SMTP id i11so517348ioi.12;
 Wed, 11 Dec 2019 14:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IpAGi6p8GJWeq/Mz+uTJuk0JoMeG5glziVQAmBR8504=;
 b=WPUtnUQlB5M9duh8SJF3OqQku1JusmvSfr9TcaaySmRaxX7sKSElGxBXcayne3qhUR
 8xu9RVA+mr0Tom4LoGV0R0CxjsvV1QkrxytWLVHE8bhCeSPLUxC2VIzv/IGaJTHajeMO
 F1UX5Stob4IDylBm9qocv4aBdUw9JF6sWTbywkTNC1q7vjho6+Q9NmBLBBJ99YgIy1RK
 rVrsOdb6sew8jlUOEpF0MC9P04c2LA6RRPc0Y+79QY8XsV0AH4GWjFCfkqyEUDiQ1rS8
 4uvLcw+G31/tTsab5GrWkkb1m2P43GtfdPctrMRFx0sM6Da72M1rZPQLgzD6J65iHI0n
 /Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IpAGi6p8GJWeq/Mz+uTJuk0JoMeG5glziVQAmBR8504=;
 b=swNxDX3efR/y25AZKTUcOT1M4EWU1ijtH5NukrvNMctho+1UzxQx1J1sQa3kv33P+J
 qN+h99+nSIjK0Kz+KydVrA+6S5rbCYzWRyfOrOiUFCPutbaWl5b3CrspdwegjFYDWuDo
 dPk/a/3Lp1MmWVtsvNTZHGyzdKCBWZJSJAbvSL78HtcDPncDt+T7q0JBcOFbVWYd/nRv
 fX7g8Kq1WlRl841CKeJ6FbEMS1RkyuygSVwJzQXZY/kMBoCi8LaIawWNXkKwA1b7+krs
 LvqZJZhX7c+26jj87k8HXGqSrsCV+HFcfnSJFCjzssiPEjllNRXhwo4kCRfuSlGFqTx1
 vvOw==
X-Gm-Message-State: APjAAAUJ2U7Q9zdqPlAQrIZjUY/kDaZNmPhj2bB+wH91SUW2qL8qREUw
 VeXsw3WjrDeLoe0WuLc2Ani1/CqKjmtmyOUq4VUOkQ==
X-Google-Smtp-Source: APXvYqwH8YcX+ypEIL2A5MYDCkPN5E0Le4lrIKkQLKzS9hvvWfc5feqCVAA4HFUwACU6dTiIKYym1+x6hjjlNchJwO0=
X-Received: by 2002:a5d:8f17:: with SMTP id f23mr465113iof.265.1576103698472; 
 Wed, 11 Dec 2019 14:34:58 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-10-nieklinnenbank@gmail.com>
In-Reply-To: <20191202210947.3603-10-nieklinnenbank@gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 11 Dec 2019 23:34:46 +0100
Message-ID: <CAPan3WrRKnu5vFz=JvrnD8tewUk7SdwFVYx4xVL353AnfPDgHQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] arm: allwinner-h3: add SD/MMC host controller
To: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000013a1430599753d58"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000013a1430599753d58
Content-Type: text/plain; charset="UTF-8"

Ping!

Anyone would like to comment on this driver?

I finished the rework on all previous comments in this series.

Currently debugging the hflags error reported by Philippe.
After that, I'm ready to send out v2 of these patches.

Regards,
Niek

On Mon, Dec 2, 2019 at 10:10 PM Niek Linnenbank <nieklinnenbank@gmail.com>
wrote:

> The Allwinner H3 System on Chip contains an integrated storage
> controller for Secure Digital (SD) and Multi Media Card (MMC)
> interfaces. This commit adds support for the Allwinner H3
> SD/MMC storage controller with the following emulated features:
>
>  * DMA transfers
>  * Direct FIFO I/O
>  * Short/Long format command responses
>  * Auto-Stop command (CMD12)
>  * Insert & remove card detection
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>  hw/arm/allwinner-h3.c               |  20 +
>  hw/arm/orangepi.c                   |  17 +
>  hw/sd/Makefile.objs                 |   1 +
>  hw/sd/allwinner-h3-sdhost.c         | 791 ++++++++++++++++++++++++++++
>  hw/sd/trace-events                  |   7 +
>  include/hw/arm/allwinner-h3.h       |   2 +
>  include/hw/sd/allwinner-h3-sdhost.h |  73 +++
>  7 files changed, 911 insertions(+)
>  create mode 100644 hw/sd/allwinner-h3-sdhost.c
>  create mode 100644 include/hw/sd/allwinner-h3-sdhost.h
>
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index 4fc4c8c725..c2972caf88 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -50,6 +50,9 @@ static void aw_h3_init(Object *obj)
>
>      sysbus_init_child_obj(obj, "sid", &s->sid, sizeof(s->sid),
>                            TYPE_AW_H3_SID);
> +
> +    sysbus_init_child_obj(obj, "mmc0", &s->mmc0, sizeof(s->mmc0),
> +                          TYPE_AW_H3_SDHOST);
>  }
>
>  static void aw_h3_realize(DeviceState *dev, Error **errp)
> @@ -217,6 +220,23 @@ static void aw_h3_realize(DeviceState *dev, Error
> **errp)
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, AW_H3_SID_BASE);
>
> +    /* SD/MMC */
> +    object_property_set_bool(OBJECT(&s->mmc0), true, "realized", &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbusdev = SYS_BUS_DEVICE(&s->mmc0);
> +    sysbus_mmio_map(sysbusdev, 0, AW_H3_MMC0_BASE);
> +    sysbus_connect_irq(sysbusdev, 0, s->irq[AW_H3_GIC_SPI_MMC0]);
> +
> +    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->mmc0),
> +                              "sd-bus", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
>      /* Universal Serial Bus */
>      sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_BASE,
>                           s->irq[AW_H3_GIC_SPI_EHCI0]);
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> index 5ef2735f81..dee3efaf08 100644
> --- a/hw/arm/orangepi.c
> +++ b/hw/arm/orangepi.c
> @@ -39,6 +39,10 @@ typedef struct OrangePiState {
>  static void orangepi_init(MachineState *machine)
>  {
>      OrangePiState *s = g_new(OrangePiState, 1);
> +    DriveInfo *di;
> +    BlockBackend *blk;
> +    BusState *bus;
> +    DeviceState *carddev;
>      Error *err = NULL;
>
>      s->h3 = AW_H3(object_new(TYPE_AW_H3));
> @@ -64,6 +68,18 @@ static void orangepi_init(MachineState *machine)
>          exit(1);
>      }
>
> +    /* Create and plug in the SD card */
> +    di = drive_get_next(IF_SD);
> +    blk = di ? blk_by_legacy_dinfo(di) : NULL;
> +    bus = qdev_get_child_bus(DEVICE(s->h3), "sd-bus");
> +    if (bus == NULL) {
> +        error_report("No SD/MMC found in H3 object");
> +        exit(1);
> +    }
> +    carddev = qdev_create(bus, TYPE_SD_CARD);
> +    qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
> +    object_property_set_bool(OBJECT(carddev), true, "realized",
> &error_fatal);
> +
>      /* RAM */
>      memory_region_allocate_system_memory(&s->sdram, NULL, "orangepi.ram",
>                                           machine->ram_size);
> @@ -80,6 +96,7 @@ static void orangepi_machine_init(MachineClass *mc)
>  {
>      mc->desc = "Orange Pi PC";
>      mc->init = orangepi_init;
> +    mc->block_default_type = IF_SD;
>      mc->units_per_default_bus = 1;
>      mc->min_cpus = AW_H3_NUM_CPUS;
>      mc->max_cpus = AW_H3_NUM_CPUS;
> diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
> index a884c238df..e7cc5ab739 100644
> --- a/hw/sd/Makefile.objs
> +++ b/hw/sd/Makefile.objs
> @@ -4,6 +4,7 @@ common-obj-$(CONFIG_SD) += sd.o core.o sdmmc-internal.o
>  common-obj-$(CONFIG_SDHCI) += sdhci.o
>  common-obj-$(CONFIG_SDHCI_PCI) += sdhci-pci.o
>
> +obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-sdhost.o
>  obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
>  obj-$(CONFIG_OMAP) += omap_mmc.o
>  obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
> diff --git a/hw/sd/allwinner-h3-sdhost.c b/hw/sd/allwinner-h3-sdhost.c
> new file mode 100644
> index 0000000000..26e113a144
> --- /dev/null
> +++ b/hw/sd/allwinner-h3-sdhost.c
> @@ -0,0 +1,791 @@
> +/*
> + * Allwinner H3 SD Host Controller emulation
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
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "sysemu/blockdev.h"
> +#include "hw/irq.h"
> +#include "hw/sd/allwinner-h3-sdhost.h"
> +#include "migration/vmstate.h"
> +#include "trace.h"
> +
> +#define TYPE_AW_H3_SDHOST_BUS "allwinner-h3-sdhost-bus"
> +#define AW_H3_SDHOST_BUS(obj) \
> +    OBJECT_CHECK(SDBus, (obj), TYPE_AW_H3_SDHOST_BUS)
> +
> +/* SD Host register offsets */
> +#define REG_SD_GCTL        (0x00)  /* Global Control */
> +#define REG_SD_CKCR        (0x04)  /* Clock Control */
> +#define REG_SD_TMOR        (0x08)  /* Timeout */
> +#define REG_SD_BWDR        (0x0C)  /* Bus Width */
> +#define REG_SD_BKSR        (0x10)  /* Block Size */
> +#define REG_SD_BYCR        (0x14)  /* Byte Count */
> +#define REG_SD_CMDR        (0x18)  /* Command */
> +#define REG_SD_CAGR        (0x1C)  /* Command Argument */
> +#define REG_SD_RESP0       (0x20)  /* Response Zero */
> +#define REG_SD_RESP1       (0x24)  /* Response One */
> +#define REG_SD_RESP2       (0x28)  /* Response Two */
> +#define REG_SD_RESP3       (0x2C)  /* Response Three */
> +#define REG_SD_IMKR        (0x30)  /* Interrupt Mask */
> +#define REG_SD_MISR        (0x34)  /* Masked Interrupt Status */
> +#define REG_SD_RISR        (0x38)  /* Raw Interrupt Status */
> +#define REG_SD_STAR        (0x3C)  /* Status */
> +#define REG_SD_FWLR        (0x40)  /* FIFO Water Level */
> +#define REG_SD_FUNS        (0x44)  /* FIFO Function Select */
> +#define REG_SD_DBGC        (0x50)  /* Debug Enable */
> +#define REG_SD_A12A        (0x58)  /* Auto command 12 argument */
> +#define REG_SD_NTSR        (0x5C)  /* SD NewTiming Set */
> +#define REG_SD_SDBG        (0x60)  /* SD newTiming Set Debug */
> +#define REG_SD_HWRST       (0x78)  /* Hardware Reset Register */
> +#define REG_SD_DMAC        (0x80)  /* Internal DMA Controller Control */
> +#define REG_SD_DLBA        (0x84)  /* Descriptor List Base Address */
> +#define REG_SD_IDST        (0x88)  /* Internal DMA Controller Status */
> +#define REG_SD_IDIE        (0x8C)  /* Internal DMA Controller IRQ Enable
> */
> +#define REG_SD_THLDC       (0x100) /* Card Threshold Control */
> +#define REG_SD_DSBD        (0x10C) /* eMMC DDR Start Bit Detection
> Control */
> +#define REG_SD_RES_CRC     (0x110) /* Response CRC from card/eMMC */
> +#define REG_SD_DATA7_CRC   (0x114) /* CRC Data 7 from card/eMMC */
> +#define REG_SD_DATA6_CRC   (0x118) /* CRC Data 6 from card/eMMC */
> +#define REG_SD_DATA5_CRC   (0x11C) /* CRC Data 5 from card/eMMC */
> +#define REG_SD_DATA4_CRC   (0x120) /* CRC Data 4 from card/eMMC */
> +#define REG_SD_DATA3_CRC   (0x124) /* CRC Data 3 from card/eMMC */
> +#define REG_SD_DATA2_CRC   (0x128) /* CRC Data 2 from card/eMMC */
> +#define REG_SD_DATA1_CRC   (0x12C) /* CRC Data 1 from card/eMMC */
> +#define REG_SD_DATA0_CRC   (0x130) /* CRC Data 0 from card/eMMC */
> +#define REG_SD_CRC_STA     (0x134) /* CRC status from card/eMMC during
> write */
> +#define REG_SD_FIFO        (0x200) /* Read/Write FIFO */
> +
> +/* SD Host register flags */
> +#define SD_GCTL_FIFO_AC_MOD     (1 << 31)
> +#define SD_GCTL_DDR_MOD_SEL     (1 << 10)
> +#define SD_GCTL_CD_DBC_ENB      (1 << 8)
> +#define SD_GCTL_DMA_ENB         (1 << 5)
> +#define SD_GCTL_INT_ENB         (1 << 4)
> +#define SD_GCTL_DMA_RST         (1 << 2)
> +#define SD_GCTL_FIFO_RST        (1 << 1)
> +#define SD_GCTL_SOFT_RST        (1 << 0)
> +
> +#define SD_CMDR_LOAD            (1 << 31)
> +#define SD_CMDR_CLKCHANGE       (1 << 21)
> +#define SD_CMDR_WRITE           (1 << 10)
> +#define SD_CMDR_AUTOSTOP        (1 << 12)
> +#define SD_CMDR_DATA            (1 << 9)
> +#define SD_CMDR_RESPONSE_LONG   (1 << 7)
> +#define SD_CMDR_RESPONSE        (1 << 6)
> +#define SD_CMDR_CMDID_MASK      (0x3f)
> +
> +#define SD_RISR_CARD_REMOVE     (1 << 31)
> +#define SD_RISR_CARD_INSERT     (1 << 30)
> +#define SD_RISR_AUTOCMD_DONE    (1 << 14)
> +#define SD_RISR_DATA_COMPLETE   (1 << 3)
> +#define SD_RISR_CMD_COMPLETE    (1 << 2)
> +#define SD_RISR_NO_RESPONSE     (1 << 1)
> +
> +#define SD_STAR_CARD_PRESENT    (1 << 8)
> +
> +#define SD_IDST_SUM_RECEIVE_IRQ (1 << 8)
> +#define SD_IDST_RECEIVE_IRQ     (1 << 1)
> +#define SD_IDST_TRANSMIT_IRQ    (1 << 0)
> +#define SD_IDST_IRQ_MASK        (SD_IDST_RECEIVE_IRQ |
> SD_IDST_TRANSMIT_IRQ | \
> +                                 SD_IDST_SUM_RECEIVE_IRQ)
> +#define SD_IDST_WR_MASK         (0x3ff)
> +
> +/* SD Host register reset values */
> +#define REG_SD_GCTL_RST         (0x00000300)
> +#define REG_SD_CKCR_RST         (0x0)
> +#define REG_SD_TMOR_RST         (0xFFFFFF40)
> +#define REG_SD_BWDR_RST         (0x0)
> +#define REG_SD_BKSR_RST         (0x00000200)
> +#define REG_SD_BYCR_RST         (0x00000200)
> +#define REG_SD_CMDR_RST         (0x0)
> +#define REG_SD_CAGR_RST         (0x0)
> +#define REG_SD_RESP_RST         (0x0)
> +#define REG_SD_IMKR_RST         (0x0)
> +#define REG_SD_MISR_RST         (0x0)
> +#define REG_SD_RISR_RST         (0x0)
> +#define REG_SD_STAR_RST         (0x00000100)
> +#define REG_SD_FWLR_RST         (0x000F0000)
> +#define REG_SD_FUNS_RST         (0x0)
> +#define REG_SD_DBGC_RST         (0x0)
> +#define REG_SD_A12A_RST         (0x0000FFFF)
> +#define REG_SD_NTSR_RST         (0x00000001)
> +#define REG_SD_SDBG_RST         (0x0)
> +#define REG_SD_HWRST_RST        (0x00000001)
> +#define REG_SD_DMAC_RST         (0x0)
> +#define REG_SD_DLBA_RST         (0x0)
> +#define REG_SD_IDST_RST         (0x0)
> +#define REG_SD_IDIE_RST         (0x0)
> +#define REG_SD_THLDC_RST        (0x0)
> +#define REG_SD_DSBD_RST         (0x0)
> +#define REG_SD_RES_CRC_RST      (0x0)
> +#define REG_SD_DATA_CRC_RST     (0x0)
> +#define REG_SD_CRC_STA_RST      (0x0)
> +#define REG_SD_FIFO_RST         (0x0)
> +
> +/* Data transfer descriptor for DMA */
> +typedef struct TransferDescriptor {
> +    uint32_t status; /* Status flags */
> +    uint32_t size;   /* Data buffer size */
> +    uint32_t addr;   /* Data buffer address */
> +    uint32_t next;   /* Physical address of next descriptor */
> +} TransferDescriptor;
> +
> +/* Data transfer descriptor flags */
> +#define DESC_STATUS_HOLD   (1 << 31) /* Set when descriptor is in use by
> DMA */
> +#define DESC_STATUS_ERROR  (1 << 30) /* Set when DMA transfer error
> occurred */
> +#define DESC_STATUS_CHAIN  (1 << 4)  /* Indicates chained descriptor. */
> +#define DESC_STATUS_FIRST  (1 << 3)  /* Set on the first descriptor */
> +#define DESC_STATUS_LAST   (1 << 2)  /* Set on the last descriptor */
> +#define DESC_STATUS_NOIRQ  (1 << 1)  /* Skip raising interrupt after
> transfer */
> +
> +#define DESC_SIZE_MASK     (0xfffffffc)
> +
> +static void aw_h3_sdhost_update_irq(AwH3SDHostState *s)
> +{
> +    uint32_t irq_en = s->global_ctl & SD_GCTL_INT_ENB;
> +    uint32_t irq = irq_en ? s->irq_status & s->irq_mask : 0;
> +
> +    trace_aw_h3_sdhost_update_irq(irq);
> +    qemu_set_irq(s->irq, irq);
> +}
> +
> +static void aw_h3_sdhost_update_transfer_cnt(AwH3SDHostState *s, uint32_t
> bytes)
> +{
> +    if (s->transfer_cnt > bytes) {
> +        s->transfer_cnt -= bytes;
> +    } else {
> +        s->transfer_cnt = 0;
> +    }
> +
> +    if (!s->transfer_cnt) {
> +        s->irq_status |= SD_RISR_DATA_COMPLETE | SD_RISR_AUTOCMD_DONE;
> +    }
> +}
> +
> +static void aw_h3_sdhost_set_inserted(DeviceState *dev, bool inserted)
> +{
> +    AwH3SDHostState *s = AW_H3_SDHOST(dev);
> +
> +    trace_aw_h3_sdhost_set_inserted(inserted);
> +
> +    if (inserted) {
> +        s->irq_status |= SD_RISR_CARD_INSERT;
> +        s->irq_status &= ~SD_RISR_CARD_REMOVE;
> +        s->status |= SD_STAR_CARD_PRESENT;
> +    } else {
> +        s->irq_status &= ~SD_RISR_CARD_INSERT;
> +        s->irq_status |= SD_RISR_CARD_REMOVE;
> +        s->status &= ~SD_STAR_CARD_PRESENT;
> +    }
> +
> +    aw_h3_sdhost_update_irq(s);
> +}
> +
> +static void aw_h3_sdhost_send_command(AwH3SDHostState *s)
> +{
> +    SDRequest request;
> +    uint8_t resp[16];
> +    int rlen;
> +
> +    /* Auto clear load flag */
> +    s->command &= ~SD_CMDR_LOAD;
> +
> +    /* Clock change does not actually interact with the SD bus */
> +    if (!(s->command & SD_CMDR_CLKCHANGE)) {
> +
> +        /* Prepare request */
> +        request.cmd = s->command & SD_CMDR_CMDID_MASK;
> +        request.arg = s->command_arg;
> +
> +        /* Send request to SD bus */
> +        rlen = sdbus_do_command(&s->sdbus, &request, resp);
> +        if (rlen < 0) {
> +            goto error;
> +        }
> +
> +        /* If the command has a response, store it in the response
> registers */
> +        if ((s->command & SD_CMDR_RESPONSE)) {
> +            if (rlen == 0 ||
> +               (rlen == 4 && (s->command & SD_CMDR_RESPONSE_LONG))) {
> +                goto error;
> +            }
> +            if (rlen != 4 && rlen != 16) {
> +                goto error;
> +            }
> +            if (rlen == 4) {
> +                s->response[0] = ldl_be_p(&resp[0]);
> +                s->response[1] = s->response[2] = s->response[3] = 0;
> +            } else {
> +                s->response[0] = ldl_be_p(&resp[12]);
> +                s->response[1] = ldl_be_p(&resp[8]);
> +                s->response[2] = ldl_be_p(&resp[4]);
> +                s->response[3] = ldl_be_p(&resp[0]);
> +            }
> +        }
> +    }
> +
> +    /* Set interrupt status bits */
> +    s->irq_status |= SD_RISR_CMD_COMPLETE;
> +    return;
> +
> +error:
> +    s->irq_status |= SD_RISR_NO_RESPONSE;
> +}
> +
> +static void aw_h3_sdhost_auto_stop(AwH3SDHostState *s)
> +{
> +    /*
> +     * The stop command (CMD12) ensures the SD bus
> +     * returns to the transfer state.
> +     */
> +    if ((s->command & SD_CMDR_AUTOSTOP) && (s->transfer_cnt == 0)) {
> +        /* First save current command registers */
> +        uint32_t saved_cmd = s->command;
> +        uint32_t saved_arg = s->command_arg;
> +
> +        /* Prepare stop command (CMD12) */
> +        s->command &= ~SD_CMDR_CMDID_MASK;
> +        s->command |= 12; /* CMD12 */
> +        s->command_arg = 0;
> +
> +        /* Put the command on SD bus */
> +        aw_h3_sdhost_send_command(s);
> +
> +        /* Restore command values */
> +        s->command = saved_cmd;
> +        s->command_arg = saved_arg;
> +    }
> +}
> +
> +static uint32_t aw_h3_sdhost_process_desc(AwH3SDHostState *s,
> +                                          hwaddr desc_addr,
> +                                          TransferDescriptor *desc,
> +                                          bool is_write, uint32_t
> max_bytes)
> +{
> +    uint32_t num_done = 0;
> +    uint32_t num_bytes = max_bytes;
> +    uint8_t buf[1024];
> +
> +    /* Read descriptor */
> +    cpu_physical_memory_read(desc_addr, desc, sizeof(*desc));
> +    if (desc->size == 0) {
> +        desc->size = 0xffff + 1;
> +    }
> +    if (desc->size < num_bytes) {
> +        num_bytes = desc->size;
> +    }
> +
> +    trace_aw_h3_sdhost_process_desc(desc_addr, desc->size, is_write,
> max_bytes);
> +
> +    while (num_done < num_bytes) {
> +        /* Try to completely fill the local buffer */
> +        uint32_t buf_bytes = num_bytes - num_done;
> +        if (buf_bytes > sizeof(buf)) {
> +            buf_bytes = sizeof(buf);
> +        }
> +
> +        /* Write to SD bus */
> +        if (is_write) {
> +            cpu_physical_memory_read((desc->addr & DESC_SIZE_MASK) +
> num_done,
> +                                      buf, buf_bytes);
> +
> +            for (uint32_t i = 0; i < buf_bytes; i++) {
> +                sdbus_write_data(&s->sdbus, buf[i]);
> +            }
> +
> +        /* Read from SD bus */
> +        } else {
> +            for (uint32_t i = 0; i < buf_bytes; i++) {
> +                buf[i] = sdbus_read_data(&s->sdbus);
> +            }
> +            cpu_physical_memory_write((desc->addr & DESC_SIZE_MASK) +
> num_done,
> +                                       buf, buf_bytes);
> +        }
> +        num_done += buf_bytes;
> +    }
> +
> +    /* Clear hold flag and flush descriptor */
> +    desc->status &= ~DESC_STATUS_HOLD;
> +    cpu_physical_memory_write(desc_addr, desc, sizeof(*desc));
> +
> +    return num_done;
> +}
> +
> +static void aw_h3_sdhost_dma(AwH3SDHostState *s)
> +{
> +    TransferDescriptor desc;
> +    hwaddr desc_addr = s->desc_base;
> +    bool is_write = (s->command & SD_CMDR_WRITE);
> +    uint32_t bytes_done = 0;
> +
> +    /* Check if DMA can be performed */
> +    if (s->byte_count == 0 || s->block_size == 0 ||
> +      !(s->global_ctl & SD_GCTL_DMA_ENB)) {
> +        return;
> +    }
> +
> +    /*
> +     * For read operations, data must be available on the SD bus
> +     * If not, it is an error and we should not act at all
> +     */
> +    if (!is_write && !sdbus_data_ready(&s->sdbus)) {
> +        return;
> +    }
> +
> +    /* Process the DMA descriptors until all data is copied */
> +    while (s->byte_count > 0) {
> +        bytes_done = aw_h3_sdhost_process_desc(s, desc_addr, &desc,
> +                                               is_write, s->byte_count);
> +        aw_h3_sdhost_update_transfer_cnt(s, bytes_done);
> +
> +        if (bytes_done <= s->byte_count) {
> +            s->byte_count -= bytes_done;
> +        } else {
> +            s->byte_count = 0;
> +        }
> +
> +        if (desc.status & DESC_STATUS_LAST) {
> +            break;
> +        } else {
> +            desc_addr = desc.next;
> +        }
> +    }
> +
> +    /* Raise IRQ to signal DMA is completed */
> +    s->irq_status |= SD_RISR_DATA_COMPLETE | SD_RISR_AUTOCMD_DONE;
> +
> +    /* Update DMAC bits */
> +    if (is_write) {
> +        s->dmac_status |= SD_IDST_TRANSMIT_IRQ;
> +    } else {
> +        s->dmac_status |= (SD_IDST_SUM_RECEIVE_IRQ | SD_IDST_RECEIVE_IRQ);
> +    }
> +}
> +
> +static uint64_t aw_h3_sdhost_read(void *opaque, hwaddr offset,
> +                                  unsigned size)
> +{
> +    AwH3SDHostState *s = (AwH3SDHostState *)opaque;
> +    uint32_t res = 0;
> +
> +    switch (offset) {
> +    case REG_SD_GCTL:      /* Global Control */
> +        res = s->global_ctl;
> +        break;
> +    case REG_SD_CKCR:      /* Clock Control */
> +        res = s->clock_ctl;
> +        break;
> +    case REG_SD_TMOR:      /* Timeout */
> +        res = s->timeout;
> +        break;
> +    case REG_SD_BWDR:      /* Bus Width */
> +        res = s->bus_width;
> +        break;
> +    case REG_SD_BKSR:      /* Block Size */
> +        res = s->block_size;
> +        break;
> +    case REG_SD_BYCR:      /* Byte Count */
> +        res = s->byte_count;
> +        break;
> +    case REG_SD_CMDR:      /* Command */
> +        res = s->command;
> +        break;
> +    case REG_SD_CAGR:      /* Command Argument */
> +        res = s->command_arg;
> +        break;
> +    case REG_SD_RESP0:     /* Response Zero */
> +        res = s->response[0];
> +        break;
> +    case REG_SD_RESP1:     /* Response One */
> +        res = s->response[1];
> +        break;
> +    case REG_SD_RESP2:     /* Response Two */
> +        res = s->response[2];
> +        break;
> +    case REG_SD_RESP3:     /* Response Three */
> +        res = s->response[3];
> +        break;
> +    case REG_SD_IMKR:      /* Interrupt Mask */
> +        res = s->irq_mask;
> +        break;
> +    case REG_SD_MISR:      /* Masked Interrupt Status */
> +        res = s->irq_status & s->irq_mask;
> +        break;
> +    case REG_SD_RISR:      /* Raw Interrupt Status */
> +        res = s->irq_status;
> +        break;
> +    case REG_SD_STAR:      /* Status */
> +        res = s->status;
> +        break;
> +    case REG_SD_FWLR:      /* FIFO Water Level */
> +        res = s->fifo_wlevel;
> +        break;
> +    case REG_SD_FUNS:      /* FIFO Function Select */
> +        res = s->fifo_func_sel;
> +        break;
> +    case REG_SD_DBGC:      /* Debug Enable */
> +        res = s->debug_enable;
> +        break;
> +    case REG_SD_A12A:      /* Auto command 12 argument */
> +        res = s->auto12_arg;
> +        break;
> +    case REG_SD_NTSR:      /* SD NewTiming Set */
> +        res = s->newtiming_set;
> +        break;
> +    case REG_SD_SDBG:      /* SD newTiming Set Debug */
> +        res = s->newtiming_debug;
> +        break;
> +    case REG_SD_HWRST:     /* Hardware Reset Register */
> +        res = s->hardware_rst;
> +        break;
> +    case REG_SD_DMAC:      /* Internal DMA Controller Control */
> +        res = s->dmac;
> +        break;
> +    case REG_SD_DLBA:      /* Descriptor List Base Address */
> +        res = s->desc_base;
> +        break;
> +    case REG_SD_IDST:      /* Internal DMA Controller Status */
> +        res = s->dmac_status;
> +        break;
> +    case REG_SD_IDIE:      /* Internal DMA Controller Interrupt Enable */
> +        res = s->dmac_irq;
> +        break;
> +    case REG_SD_THLDC:     /* Card Threshold Control */
> +        res = s->card_threshold;
> +        break;
> +    case REG_SD_DSBD:      /* eMMC DDR Start Bit Detection Control */
> +        res = s->startbit_detect;
> +        break;
> +    case REG_SD_RES_CRC:   /* Response CRC from card/eMMC */
> +        res = s->response_crc;
> +        break;
> +    case REG_SD_DATA7_CRC: /* CRC Data 7 from card/eMMC */
> +    case REG_SD_DATA6_CRC: /* CRC Data 6 from card/eMMC */
> +    case REG_SD_DATA5_CRC: /* CRC Data 5 from card/eMMC */
> +    case REG_SD_DATA4_CRC: /* CRC Data 4 from card/eMMC */
> +    case REG_SD_DATA3_CRC: /* CRC Data 3 from card/eMMC */
> +    case REG_SD_DATA2_CRC: /* CRC Data 2 from card/eMMC */
> +    case REG_SD_DATA1_CRC: /* CRC Data 1 from card/eMMC */
> +    case REG_SD_DATA0_CRC: /* CRC Data 0 from card/eMMC */
> +        res = s->data_crc[((offset - REG_SD_DATA7_CRC) /
> sizeof(uint32_t))];
> +        break;
> +    case REG_SD_CRC_STA:   /* CRC status from card/eMMC in write
> operation */
> +        res = s->status_crc;
> +        break;
> +    case REG_SD_FIFO:      /* Read/Write FIFO */
> +        if (sdbus_data_ready(&s->sdbus)) {
> +            res = sdbus_read_data(&s->sdbus);
> +            res |= sdbus_read_data(&s->sdbus) << 8;
> +            res |= sdbus_read_data(&s->sdbus) << 16;
> +            res |= sdbus_read_data(&s->sdbus) << 24;
> +            aw_h3_sdhost_update_transfer_cnt(s, sizeof(uint32_t));
> +            aw_h3_sdhost_auto_stop(s);
> +            aw_h3_sdhost_update_irq(s);
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: no data ready on SD
> bus\n",
> +                          __func__);
> +        }
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
> +                      __func__, offset);
> +        res = 0;
> +        break;
> +    }
> +
> +    trace_aw_h3_sdhost_read(offset, res, size);
> +    return res;
> +}
> +
> +static void aw_h3_sdhost_write(void *opaque, hwaddr offset,
> +                               uint64_t value, unsigned size)
> +{
> +    AwH3SDHostState *s = (AwH3SDHostState *)opaque;
> +
> +    trace_aw_h3_sdhost_write(offset, value, size);
> +
> +    switch (offset) {
> +    case REG_SD_GCTL:      /* Global Control */
> +        s->global_ctl = value;
> +        s->global_ctl &= ~(SD_GCTL_DMA_RST | SD_GCTL_FIFO_RST |
> +                           SD_GCTL_SOFT_RST);
> +        aw_h3_sdhost_update_irq(s);
> +        break;
> +    case REG_SD_CKCR:      /* Clock Control */
> +        s->clock_ctl = value;
> +        break;
> +    case REG_SD_TMOR:      /* Timeout */
> +        s->timeout = value;
> +        break;
> +    case REG_SD_BWDR:      /* Bus Width */
> +        s->bus_width = value;
> +        break;
> +    case REG_SD_BKSR:      /* Block Size */
> +        s->block_size = value;
> +        break;
> +    case REG_SD_BYCR:      /* Byte Count */
> +        s->byte_count = value;
> +        s->transfer_cnt = value;
> +        break;
> +    case REG_SD_CMDR:      /* Command */
> +        s->command = value;
> +        if (value & SD_CMDR_LOAD) {
> +            aw_h3_sdhost_send_command(s);
> +            aw_h3_sdhost_dma(s);
> +            aw_h3_sdhost_auto_stop(s);
> +        }
> +        aw_h3_sdhost_update_irq(s);
> +        break;
> +    case REG_SD_CAGR:      /* Command Argument */
> +        s->command_arg = value;
> +        break;
> +    case REG_SD_RESP0:     /* Response Zero */
> +        s->response[0] = value;
> +        break;
> +    case REG_SD_RESP1:     /* Response One */
> +        s->response[1] = value;
> +        break;
> +    case REG_SD_RESP2:     /* Response Two */
> +        s->response[2] = value;
> +        break;
> +    case REG_SD_RESP3:     /* Response Three */
> +        s->response[3] = value;
> +        break;
> +    case REG_SD_IMKR:      /* Interrupt Mask */
> +        s->irq_mask = value;
> +        aw_h3_sdhost_update_irq(s);
> +        break;
> +    case REG_SD_MISR:      /* Masked Interrupt Status */
> +    case REG_SD_RISR:      /* Raw Interrupt Status */
> +        s->irq_status &= ~value;
> +        aw_h3_sdhost_update_irq(s);
> +        break;
> +    case REG_SD_STAR:      /* Status */
> +        s->status &= ~value;
> +        aw_h3_sdhost_update_irq(s);
> +        break;
> +    case REG_SD_FWLR:      /* FIFO Water Level */
> +        s->fifo_wlevel = value;
> +        break;
> +    case REG_SD_FUNS:      /* FIFO Function Select */
> +        s->fifo_func_sel = value;
> +        break;
> +    case REG_SD_DBGC:      /* Debug Enable */
> +        s->debug_enable = value;
> +        break;
> +    case REG_SD_A12A:      /* Auto command 12 argument */
> +        s->auto12_arg = value;
> +        break;
> +    case REG_SD_NTSR:      /* SD NewTiming Set */
> +        s->newtiming_set = value;
> +        break;
> +    case REG_SD_SDBG:      /* SD newTiming Set Debug */
> +        s->newtiming_debug = value;
> +        break;
> +    case REG_SD_HWRST:     /* Hardware Reset Register */
> +        s->hardware_rst = value;
> +        break;
> +    case REG_SD_DMAC:      /* Internal DMA Controller Control */
> +        s->dmac = value;
> +        aw_h3_sdhost_update_irq(s);
> +        break;
> +    case REG_SD_DLBA:      /* Descriptor List Base Address */
> +        s->desc_base = value;
> +        break;
> +    case REG_SD_IDST:      /* Internal DMA Controller Status */
> +        s->dmac_status &= (~SD_IDST_WR_MASK) | (~value & SD_IDST_WR_MASK);
> +        aw_h3_sdhost_update_irq(s);
> +        break;
> +    case REG_SD_IDIE:      /* Internal DMA Controller Interrupt Enable */
> +        s->dmac_irq = value;
> +        aw_h3_sdhost_update_irq(s);
> +        break;
> +    case REG_SD_THLDC:     /* Card Threshold Control */
> +        s->card_threshold = value;
> +        break;
> +    case REG_SD_DSBD:      /* eMMC DDR Start Bit Detection Control */
> +        s->startbit_detect = value;
> +        break;
> +    case REG_SD_FIFO:      /* Read/Write FIFO */
> +        sdbus_write_data(&s->sdbus, value & 0xff);
> +        sdbus_write_data(&s->sdbus, (value >> 8) & 0xff);
> +        sdbus_write_data(&s->sdbus, (value >> 16) & 0xff);
> +        sdbus_write_data(&s->sdbus, (value >> 24) & 0xff);
> +        aw_h3_sdhost_update_transfer_cnt(s, sizeof(uint32_t));
> +        aw_h3_sdhost_auto_stop(s);
> +        aw_h3_sdhost_update_irq(s);
> +        break;
> +    case REG_SD_RES_CRC:   /* Response CRC from card/eMMC */
> +    case REG_SD_DATA7_CRC: /* CRC Data 7 from card/eMMC */
> +    case REG_SD_DATA6_CRC: /* CRC Data 6 from card/eMMC */
> +    case REG_SD_DATA5_CRC: /* CRC Data 5 from card/eMMC */
> +    case REG_SD_DATA4_CRC: /* CRC Data 4 from card/eMMC */
> +    case REG_SD_DATA3_CRC: /* CRC Data 3 from card/eMMC */
> +    case REG_SD_DATA2_CRC: /* CRC Data 2 from card/eMMC */
> +    case REG_SD_DATA1_CRC: /* CRC Data 1 from card/eMMC */
> +    case REG_SD_DATA0_CRC: /* CRC Data 0 from card/eMMC */
> +    case REG_SD_CRC_STA:   /* CRC status from card/eMMC in write
> operation */
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
> +                      __func__, offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps aw_h3_sdhost_ops = {
> +    .read = aw_h3_sdhost_read,
> +    .write = aw_h3_sdhost_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static const VMStateDescription vmstate_aw_h3_sdhost = {
> +    .name = TYPE_AW_H3_SDHOST,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(global_ctl, AwH3SDHostState),
> +        VMSTATE_UINT32(clock_ctl, AwH3SDHostState),
> +        VMSTATE_UINT32(timeout, AwH3SDHostState),
> +        VMSTATE_UINT32(bus_width, AwH3SDHostState),
> +        VMSTATE_UINT32(block_size, AwH3SDHostState),
> +        VMSTATE_UINT32(byte_count, AwH3SDHostState),
> +        VMSTATE_UINT32(transfer_cnt, AwH3SDHostState),
> +        VMSTATE_UINT32(command, AwH3SDHostState),
> +        VMSTATE_UINT32(command_arg, AwH3SDHostState),
> +        VMSTATE_UINT32_ARRAY(response, AwH3SDHostState, 4),
> +        VMSTATE_UINT32(irq_mask, AwH3SDHostState),
> +        VMSTATE_UINT32(irq_status, AwH3SDHostState),
> +        VMSTATE_UINT32(status, AwH3SDHostState),
> +        VMSTATE_UINT32(fifo_wlevel, AwH3SDHostState),
> +        VMSTATE_UINT32(fifo_func_sel, AwH3SDHostState),
> +        VMSTATE_UINT32(debug_enable, AwH3SDHostState),
> +        VMSTATE_UINT32(auto12_arg, AwH3SDHostState),
> +        VMSTATE_UINT32(newtiming_set, AwH3SDHostState),
> +        VMSTATE_UINT32(newtiming_debug, AwH3SDHostState),
> +        VMSTATE_UINT32(hardware_rst, AwH3SDHostState),
> +        VMSTATE_UINT32(dmac, AwH3SDHostState),
> +        VMSTATE_UINT32(desc_base, AwH3SDHostState),
> +        VMSTATE_UINT32(dmac_status, AwH3SDHostState),
> +        VMSTATE_UINT32(dmac_irq, AwH3SDHostState),
> +        VMSTATE_UINT32(card_threshold, AwH3SDHostState),
> +        VMSTATE_UINT32(startbit_detect, AwH3SDHostState),
> +        VMSTATE_UINT32(response_crc, AwH3SDHostState),
> +        VMSTATE_UINT32_ARRAY(data_crc, AwH3SDHostState, 8),
> +        VMSTATE_UINT32(status_crc, AwH3SDHostState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void aw_h3_sdhost_init(Object *obj)
> +{
> +    AwH3SDHostState *s = AW_H3_SDHOST(obj);
> +
> +    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus),
> +                        TYPE_AW_H3_SDHOST_BUS, DEVICE(s), "sd-bus");
> +
> +    memory_region_init_io(&s->iomem, obj, &aw_h3_sdhost_ops, s,
> +                          TYPE_AW_H3_SDHOST, AW_H3_SDHOST_REGS_MEM_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
> +    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
> +}
> +
> +static void aw_h3_sdhost_reset(DeviceState *dev)
> +{
> +    AwH3SDHostState *s = AW_H3_SDHOST(dev);
> +
> +    s->global_ctl = REG_SD_GCTL_RST;
> +    s->clock_ctl = REG_SD_CKCR_RST;
> +    s->timeout = REG_SD_TMOR_RST;
> +    s->bus_width = REG_SD_BWDR_RST;
> +    s->block_size = REG_SD_BKSR_RST;
> +    s->byte_count = REG_SD_BYCR_RST;
> +    s->transfer_cnt = 0;
> +
> +    s->command = REG_SD_CMDR_RST;
> +    s->command_arg = REG_SD_CAGR_RST;
> +
> +    for (int i = 0; i < sizeof(s->response) / sizeof(s->response[0]);
> i++) {
> +        s->response[i] = REG_SD_RESP_RST;
> +    }
> +
> +    s->irq_mask = REG_SD_IMKR_RST;
> +    s->irq_status = REG_SD_RISR_RST;
> +    s->status = REG_SD_STAR_RST;
> +
> +    s->fifo_wlevel = REG_SD_FWLR_RST;
> +    s->fifo_func_sel = REG_SD_FUNS_RST;
> +    s->debug_enable = REG_SD_DBGC_RST;
> +    s->auto12_arg = REG_SD_A12A_RST;
> +    s->newtiming_set = REG_SD_NTSR_RST;
> +    s->newtiming_debug = REG_SD_SDBG_RST;
> +    s->hardware_rst = REG_SD_HWRST_RST;
> +    s->dmac = REG_SD_DMAC_RST;
> +    s->desc_base = REG_SD_DLBA_RST;
> +    s->dmac_status = REG_SD_IDST_RST;
> +    s->dmac_irq = REG_SD_IDIE_RST;
> +    s->card_threshold = REG_SD_THLDC_RST;
> +    s->startbit_detect = REG_SD_DSBD_RST;
> +    s->response_crc = REG_SD_RES_CRC_RST;
> +
> +    for (int i = 0; i < sizeof(s->data_crc) / sizeof(s->data_crc[0]);
> i++) {
> +        s->data_crc[i] = REG_SD_DATA_CRC_RST;
> +    }
> +
> +    s->status_crc = REG_SD_CRC_STA_RST;
> +}
> +
> +static void aw_h3_sdhost_bus_class_init(ObjectClass *klass, void *data)
> +{
> +    SDBusClass *sbc = SD_BUS_CLASS(klass);
> +
> +    sbc->set_inserted = aw_h3_sdhost_set_inserted;
> +}
> +
> +static void aw_h3_sdhost_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = aw_h3_sdhost_reset;
> +    dc->vmsd = &vmstate_aw_h3_sdhost;
> +}
> +
> +static TypeInfo aw_h3_sdhost_info = {
> +    .name          = TYPE_AW_H3_SDHOST,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(AwH3SDHostState),
> +    .class_init    = aw_h3_sdhost_class_init,
> +    .instance_init = aw_h3_sdhost_init,
> +};
> +
> +static const TypeInfo aw_h3_sdhost_bus_info = {
> +    .name = TYPE_AW_H3_SDHOST_BUS,
> +    .parent = TYPE_SD_BUS,
> +    .instance_size = sizeof(SDBus),
> +    .class_init = aw_h3_sdhost_bus_class_init,
> +};
> +
> +static void aw_h3_sdhost_register_types(void)
> +{
> +    type_register_static(&aw_h3_sdhost_info);
> +    type_register_static(&aw_h3_sdhost_bus_info);
> +}
> +
> +type_init(aw_h3_sdhost_register_types)
> diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> index efcff666a2..c672a201b5 100644
> --- a/hw/sd/trace-events
> +++ b/hw/sd/trace-events
> @@ -1,5 +1,12 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>
> +# allwinner-h3-sdhost.c
> +aw_h3_sdhost_set_inserted(bool inserted) "inserted %u"
> +aw_h3_sdhost_process_desc(uint64_t desc_addr, uint32_t desc_size, bool
> is_write, uint32_t max_bytes) "desc_addr 0x%" PRIx64 " desc_size %u
> is_write %u max_bytes %u"
> +aw_h3_sdhost_read(uint64_t offset, uint64_t data, unsigned size) "offset
> 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
> +aw_h3_sdhost_write(uint64_t offset, uint64_t data, unsigned size) "offset
> 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
> +aw_h3_sdhost_update_irq(uint32_t irq) "IRQ bits 0x%x"
> +
>  # bcm2835_sdhost.c
>  bcm2835_sdhost_read(uint64_t offset, uint64_t data, unsigned size)
> "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  bcm2835_sdhost_write(uint64_t offset, uint64_t data, unsigned size)
> "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
> index 33602599eb..7aff4ebbd2 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -30,6 +30,7 @@
>  #include "hw/misc/allwinner-h3-cpucfg.h"
>  #include "hw/misc/allwinner-h3-syscon.h"
>  #include "hw/misc/allwinner-h3-sid.h"
> +#include "hw/sd/allwinner-h3-sdhost.h"
>  #include "target/arm/cpu.h"
>
>  #define AW_H3_SRAM_A1_BASE     (0x00000000)
> @@ -117,6 +118,7 @@ typedef struct AwH3State {
>      AwH3CpuCfgState cpucfg;
>      AwH3SysconState syscon;
>      AwH3SidState sid;
> +    AwH3SDHostState mmc0;
>      GICState gic;
>      MemoryRegion sram_a1;
>      MemoryRegion sram_a2;
> diff --git a/include/hw/sd/allwinner-h3-sdhost.h
> b/include/hw/sd/allwinner-h3-sdhost.h
> new file mode 100644
> index 0000000000..6c898a3c84
> --- /dev/null
> +++ b/include/hw/sd/allwinner-h3-sdhost.h
> @@ -0,0 +1,73 @@
> +/*
> + * Allwinner H3 SD Host Controller emulation
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
> +#ifndef ALLWINNER_H3_SDHOST_H
> +#define ALLWINNER_H3_SDHOST_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/sd/sd.h"
> +
> +#define AW_H3_SDHOST_REGS_MEM_SIZE  (1024)
> +
> +#define TYPE_AW_H3_SDHOST "allwinner-h3-sdhost"
> +#define AW_H3_SDHOST(obj) \
> +        OBJECT_CHECK(AwH3SDHostState, (obj), TYPE_AW_H3_SDHOST)
> +
> +typedef struct {
> +    SysBusDevice busdev;
> +    SDBus sdbus;
> +    MemoryRegion iomem;
> +
> +    uint32_t global_ctl;
> +    uint32_t clock_ctl;
> +    uint32_t timeout;
> +    uint32_t bus_width;
> +    uint32_t block_size;
> +    uint32_t byte_count;
> +    uint32_t transfer_cnt;
> +
> +    uint32_t command;
> +    uint32_t command_arg;
> +    uint32_t response[4];
> +
> +    uint32_t irq_mask;
> +    uint32_t irq_status;
> +    uint32_t status;
> +
> +    uint32_t fifo_wlevel;
> +    uint32_t fifo_func_sel;
> +    uint32_t debug_enable;
> +    uint32_t auto12_arg;
> +    uint32_t newtiming_set;
> +    uint32_t newtiming_debug;
> +    uint32_t hardware_rst;
> +    uint32_t dmac;
> +    uint32_t desc_base;
> +    uint32_t dmac_status;
> +    uint32_t dmac_irq;
> +    uint32_t card_threshold;
> +    uint32_t startbit_detect;
> +    uint32_t response_crc;
> +    uint32_t data_crc[8];
> +    uint32_t status_crc;
> +
> +    qemu_irq irq;
> +} AwH3SDHostState;
> +
> +#endif
> --
> 2.17.1
>
>

-- 
Niek Linnenbank

--00000000000013a1430599753d58
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Ping!</div><div><br></div><div>Anyone would like to c=
omment on this driver?</div><div><br></div><div>I finished the rework on al=
l previous comments in this series.</div><div><br></div><div>Currently debu=
gging the hflags error reported by Philippe.</div><div>After that, I&#39;m =
ready to send out v2 of these patches.</div><div><br></div><div>Regards,<br=
></div><div>Niek<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Mon, Dec 2, 2019 at 10:10 PM Niek Linnenbank &lt;<a =
href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The Allwin=
ner H3 System on Chip contains an integrated storage<br>
controller for Secure Digital (SD) and Multi Media Card (MMC)<br>
interfaces. This commit adds support for the Allwinner H3<br>
SD/MMC storage controller with the following emulated features:<br>
<br>
=C2=A0* DMA transfers<br>
=C2=A0* Direct FIFO I/O<br>
=C2=A0* Short/Long format command responses<br>
=C2=A0* Auto-Stop command (CMD12)<br>
=C2=A0* Insert &amp; remove card detection<br>
<br>
Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.c=
om" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 20 +<br>
=C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 17 +<br>
=C2=A0hw/sd/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0hw/sd/allwinner-h3-sdhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 791 ++=
++++++++++++++++++++++++++<br>
=C2=A0hw/sd/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
=C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +<br>
=C2=A0include/hw/sd/allwinner-h3-sdhost.h |=C2=A0 73 +++<br>
=C2=A07 files changed, 911 insertions(+)<br>
=C2=A0create mode 100644 hw/sd/allwinner-h3-sdhost.c<br>
=C2=A0create mode 100644 include/hw/sd/allwinner-h3-sdhost.h<br>
<br>
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
index 4fc4c8c725..c2972caf88 100644<br>
--- a/hw/arm/allwinner-h3.c<br>
+++ b/hw/arm/allwinner-h3.c<br>
@@ -50,6 +50,9 @@ static void aw_h3_init(Object *obj)<br>
<br>
=C2=A0 =C2=A0 =C2=A0sysbus_init_child_obj(obj, &quot;sid&quot;, &amp;s-&gt;=
sid, sizeof(s-&gt;sid),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0TYPE_AW_H3_SID);<br>
+<br>
+=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;mmc0&quot;, &amp;s-&gt;mmc0=
, sizeof(s-&gt;mmc0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TYPE_AW_H3_SDHOST);<br>
=C2=A0}<br>
<br>
=C2=A0static void aw_h3_realize(DeviceState *dev, Error **errp)<br>
@@ -217,6 +220,23 @@ static void aw_h3_realize(DeviceState *dev, Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;sid), 0, AW_H=
3_SID_BASE);<br>
<br>
+=C2=A0 =C2=A0 /* SD/MMC */<br>
+=C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp;s-&gt;mmc0), true, &quo=
t;realized&quot;, &amp;err);<br>
+=C2=A0 =C2=A0 if (err !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 sysbusdev =3D SYS_BUS_DEVICE(&amp;s-&gt;mmc0);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(sysbusdev, 0, AW_H3_MMC0_BASE);<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(sysbusdev, 0, s-&gt;irq[AW_H3_GIC_SPI_MMC=
0]);<br>
+<br>
+=C2=A0 =C2=A0 object_property_add_alias(OBJECT(s), &quot;sd-bus&quot;, OBJ=
ECT(&amp;s-&gt;mmc0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;sd-bus&quot;, &amp;err);<br>
+=C2=A0 =C2=A0 if (err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* Universal Serial Bus */<br>
=C2=A0 =C2=A0 =C2=A0sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_BASE,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 s-&gt;irq[AW_H3_GIC_SPI_EHCI0]);<br>
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c<br>
index 5ef2735f81..dee3efaf08 100644<br>
--- a/hw/arm/orangepi.c<br>
+++ b/hw/arm/orangepi.c<br>
@@ -39,6 +39,10 @@ typedef struct OrangePiState {<br>
=C2=A0static void orangepi_init(MachineState *machine)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0OrangePiState *s =3D g_new(OrangePiState, 1);<br>
+=C2=A0 =C2=A0 DriveInfo *di;<br>
+=C2=A0 =C2=A0 BlockBackend *blk;<br>
+=C2=A0 =C2=A0 BusState *bus;<br>
+=C2=A0 =C2=A0 DeviceState *carddev;<br>
=C2=A0 =C2=A0 =C2=A0Error *err =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;h3 =3D AW_H3(object_new(TYPE_AW_H3));<br>
@@ -64,6 +68,18 @@ static void orangepi_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 /* Create and plug in the SD card */<br>
+=C2=A0 =C2=A0 di =3D drive_get_next(IF_SD);<br>
+=C2=A0 =C2=A0 blk =3D di ? blk_by_legacy_dinfo(di) : NULL;<br>
+=C2=A0 =C2=A0 bus =3D qdev_get_child_bus(DEVICE(s-&gt;h3), &quot;sd-bus&qu=
ot;);<br>
+=C2=A0 =C2=A0 if (bus =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;No SD/MMC found in H3 objec=
t&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 carddev =3D qdev_create(bus, TYPE_SD_CARD);<br>
+=C2=A0 =C2=A0 qdev_prop_set_drive(carddev, &quot;drive&quot;, blk, &amp;er=
ror_fatal);<br>
+=C2=A0 =C2=A0 object_property_set_bool(OBJECT(carddev), true, &quot;realiz=
ed&quot;, &amp;error_fatal);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* RAM */<br>
=C2=A0 =C2=A0 =C2=A0memory_region_allocate_system_memory(&amp;s-&gt;sdram, =
NULL, &quot;orangepi.ram&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m=
achine-&gt;ram_size);<br>
@@ -80,6 +96,7 @@ static void orangepi_machine_init(MachineClass *mc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;desc =3D &quot;Orange Pi PC&quot;;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;init =3D orangepi_init;<br>
+=C2=A0 =C2=A0 mc-&gt;block_default_type =3D IF_SD;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;units_per_default_bus =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;min_cpus =3D AW_H3_NUM_CPUS;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;max_cpus =3D AW_H3_NUM_CPUS;<br>
diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs<br>
index a884c238df..e7cc5ab739 100644<br>
--- a/hw/sd/Makefile.objs<br>
+++ b/hw/sd/Makefile.objs<br>
@@ -4,6 +4,7 @@ common-obj-$(CONFIG_SD) +=3D sd.o core.o sdmmc-internal.o<b=
r>
=C2=A0common-obj-$(CONFIG_SDHCI) +=3D sdhci.o<br>
=C2=A0common-obj-$(CONFIG_SDHCI_PCI) +=3D sdhci-pci.o<br>
<br>
+obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-sdhost.o<br>
=C2=A0obj-$(CONFIG_MILKYMIST) +=3D milkymist-memcard.o<br>
=C2=A0obj-$(CONFIG_OMAP) +=3D omap_mmc.o<br>
=C2=A0obj-$(CONFIG_PXA2XX) +=3D pxa2xx_mmci.o<br>
diff --git a/hw/sd/allwinner-h3-sdhost.c b/hw/sd/allwinner-h3-sdhost.c<br>
new file mode 100644<br>
index 0000000000..26e113a144<br>
--- /dev/null<br>
+++ b/hw/sd/allwinner-h3-sdhost.c<br>
@@ -0,0 +1,791 @@<br>
+/*<br>
+ * Allwinner H3 SD Host Controller emulation<br>
+ *<br>
+ * Copyright (C) 2019 Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank=
@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
+ *<br>
+ * This program is free software: you can redistribute it and/or modify<br=
>
+ * it under the terms of the GNU General Public License as published by<br=
>
+ * the Free Software Foundation, either version 2 of the License, or<br>
+ * (at your option) any later version.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License<br>
+ * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gn=
u.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/li=
censes/</a>&gt;.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+#include &quot;qemu/module.h&quot;<br>
+#include &quot;sysemu/blockdev.h&quot;<br>
+#include &quot;hw/irq.h&quot;<br>
+#include &quot;hw/sd/allwinner-h3-sdhost.h&quot;<br>
+#include &quot;migration/vmstate.h&quot;<br>
+#include &quot;trace.h&quot;<br>
+<br>
+#define TYPE_AW_H3_SDHOST_BUS &quot;allwinner-h3-sdhost-bus&quot;<br>
+#define AW_H3_SDHOST_BUS(obj) \<br>
+=C2=A0 =C2=A0 OBJECT_CHECK(SDBus, (obj), TYPE_AW_H3_SDHOST_BUS)<br>
+<br>
+/* SD Host register offsets */<br>
+#define REG_SD_GCTL=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x00)=C2=A0 /* Global Cont=
rol */<br>
+#define REG_SD_CKCR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x04)=C2=A0 /* Clock Contr=
ol */<br>
+#define REG_SD_TMOR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x08)=C2=A0 /* Timeout */<=
br>
+#define REG_SD_BWDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0C)=C2=A0 /* Bus Width *=
/<br>
+#define REG_SD_BKSR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x10)=C2=A0 /* Block Size =
*/<br>
+#define REG_SD_BYCR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x14)=C2=A0 /* Byte Count =
*/<br>
+#define REG_SD_CMDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x18)=C2=A0 /* Command */<=
br>
+#define REG_SD_CAGR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x1C)=C2=A0 /* Command Arg=
ument */<br>
+#define REG_SD_RESP0=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x20)=C2=A0 /* Response Ze=
ro */<br>
+#define REG_SD_RESP1=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x24)=C2=A0 /* Response On=
e */<br>
+#define REG_SD_RESP2=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x28)=C2=A0 /* Response Tw=
o */<br>
+#define REG_SD_RESP3=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x2C)=C2=A0 /* Response Th=
ree */<br>
+#define REG_SD_IMKR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x30)=C2=A0 /* Interrupt M=
ask */<br>
+#define REG_SD_MISR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x34)=C2=A0 /* Masked Inte=
rrupt Status */<br>
+#define REG_SD_RISR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x38)=C2=A0 /* Raw Interru=
pt Status */<br>
+#define REG_SD_STAR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x3C)=C2=A0 /* Status */<b=
r>
+#define REG_SD_FWLR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x40)=C2=A0 /* FIFO Water =
Level */<br>
+#define REG_SD_FUNS=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x44)=C2=A0 /* FIFO Functi=
on Select */<br>
+#define REG_SD_DBGC=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x50)=C2=A0 /* Debug Enabl=
e */<br>
+#define REG_SD_A12A=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x58)=C2=A0 /* Auto comman=
d 12 argument */<br>
+#define REG_SD_NTSR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x5C)=C2=A0 /* SD NewTimin=
g Set */<br>
+#define REG_SD_SDBG=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x60)=C2=A0 /* SD newTimin=
g Set Debug */<br>
+#define REG_SD_HWRST=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x78)=C2=A0 /* Hardware Re=
set Register */<br>
+#define REG_SD_DMAC=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x80)=C2=A0 /* Internal DM=
A Controller Control */<br>
+#define REG_SD_DLBA=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x84)=C2=A0 /* Descriptor =
List Base Address */<br>
+#define REG_SD_IDST=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x88)=C2=A0 /* Internal DM=
A Controller Status */<br>
+#define REG_SD_IDIE=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x8C)=C2=A0 /* Internal DM=
A Controller IRQ Enable */<br>
+#define REG_SD_THLDC=C2=A0 =C2=A0 =C2=A0 =C2=A0(0x100) /* Card Threshold C=
ontrol */<br>
+#define REG_SD_DSBD=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x10C) /* eMMC DDR Start B=
it Detection Control */<br>
+#define REG_SD_RES_CRC=C2=A0 =C2=A0 =C2=A0(0x110) /* Response CRC from car=
d/eMMC */<br>
+#define REG_SD_DATA7_CRC=C2=A0 =C2=A0(0x114) /* CRC Data 7 from card/eMMC =
*/<br>
+#define REG_SD_DATA6_CRC=C2=A0 =C2=A0(0x118) /* CRC Data 6 from card/eMMC =
*/<br>
+#define REG_SD_DATA5_CRC=C2=A0 =C2=A0(0x11C) /* CRC Data 5 from card/eMMC =
*/<br>
+#define REG_SD_DATA4_CRC=C2=A0 =C2=A0(0x120) /* CRC Data 4 from card/eMMC =
*/<br>
+#define REG_SD_DATA3_CRC=C2=A0 =C2=A0(0x124) /* CRC Data 3 from card/eMMC =
*/<br>
+#define REG_SD_DATA2_CRC=C2=A0 =C2=A0(0x128) /* CRC Data 2 from card/eMMC =
*/<br>
+#define REG_SD_DATA1_CRC=C2=A0 =C2=A0(0x12C) /* CRC Data 1 from card/eMMC =
*/<br>
+#define REG_SD_DATA0_CRC=C2=A0 =C2=A0(0x130) /* CRC Data 0 from card/eMMC =
*/<br>
+#define REG_SD_CRC_STA=C2=A0 =C2=A0 =C2=A0(0x134) /* CRC status from card/=
eMMC during write */<br>
+#define REG_SD_FIFO=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x200) /* Read/Write FIFO =
*/<br>
+<br>
+/* SD Host register flags */<br>
+#define SD_GCTL_FIFO_AC_MOD=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 31)<br>
+#define SD_GCTL_DDR_MOD_SEL=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 10)<br>
+#define SD_GCTL_CD_DBC_ENB=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 8)<br>
+#define SD_GCTL_DMA_ENB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 5)<br=
>
+#define SD_GCTL_INT_ENB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 4)<br=
>
+#define SD_GCTL_DMA_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 2)<br=
>
+#define SD_GCTL_FIFO_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 1)<br>
+#define SD_GCTL_SOFT_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 0)<br>
+<br>
+#define SD_CMDR_LOAD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; =
31)<br>
+#define SD_CMDR_CLKCHANGE=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 21)<br>
+#define SD_CMDR_WRITE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; =
10)<br>
+#define SD_CMDR_AUTOSTOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 12)<br>
+#define SD_CMDR_DATA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; =
9)<br>
+#define SD_CMDR_RESPONSE_LONG=C2=A0 =C2=A0(1 &lt;&lt; 7)<br>
+#define SD_CMDR_RESPONSE=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 6)<br>
+#define SD_CMDR_CMDID_MASK=C2=A0 =C2=A0 =C2=A0 (0x3f)<br>
+<br>
+#define SD_RISR_CARD_REMOVE=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 31)<br>
+#define SD_RISR_CARD_INSERT=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 30)<br>
+#define SD_RISR_AUTOCMD_DONE=C2=A0 =C2=A0 (1 &lt;&lt; 14)<br>
+#define SD_RISR_DATA_COMPLETE=C2=A0 =C2=A0(1 &lt;&lt; 3)<br>
+#define SD_RISR_CMD_COMPLETE=C2=A0 =C2=A0 (1 &lt;&lt; 2)<br>
+#define SD_RISR_NO_RESPONSE=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 1)<br>
+<br>
+#define SD_STAR_CARD_PRESENT=C2=A0 =C2=A0 (1 &lt;&lt; 8)<br>
+<br>
+#define SD_IDST_SUM_RECEIVE_IRQ (1 &lt;&lt; 8)<br>
+#define SD_IDST_RECEIVE_IRQ=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 1)<br>
+#define SD_IDST_TRANSMIT_IRQ=C2=A0 =C2=A0 (1 &lt;&lt; 0)<br>
+#define SD_IDST_IRQ_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 (SD_IDST_RECEIVE_IRQ |=
 SD_IDST_TRANSMIT_IRQ | \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SD_IDST_SUM_RECEIVE_IRQ)<br>
+#define SD_IDST_WR_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x3ff)<br>
+<br>
+/* SD Host register reset values */<br>
+#define REG_SD_GCTL_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00000300)<br>
+#define REG_SD_CKCR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_TMOR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0xFFFFFF40)<br>
+#define REG_SD_BWDR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_BKSR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00000200)<br>
+#define REG_SD_BYCR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00000200)<br>
+#define REG_SD_CMDR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_CAGR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_RESP_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_IMKR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_MISR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_RISR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_STAR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00000100)<br>
+#define REG_SD_FWLR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x000F0000)<br>
+#define REG_SD_FUNS_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_DBGC_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_A12A_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0000FFFF)<br>
+#define REG_SD_NTSR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00000001)<br>
+#define REG_SD_SDBG_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_HWRST_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x00000001)<br>
+#define REG_SD_DMAC_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_DLBA_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_IDST_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_IDIE_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_THLDC_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0)<br>
+#define REG_SD_DSBD_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_RES_CRC_RST=C2=A0 =C2=A0 =C2=A0 (0x0)<br>
+#define REG_SD_DATA_CRC_RST=C2=A0 =C2=A0 =C2=A0(0x0)<br>
+#define REG_SD_CRC_STA_RST=C2=A0 =C2=A0 =C2=A0 (0x0)<br>
+#define REG_SD_FIFO_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0)<br>
+<br>
+/* Data transfer descriptor for DMA */<br>
+typedef struct TransferDescriptor {<br>
+=C2=A0 =C2=A0 uint32_t status; /* Status flags */<br>
+=C2=A0 =C2=A0 uint32_t size;=C2=A0 =C2=A0/* Data buffer size */<br>
+=C2=A0 =C2=A0 uint32_t addr;=C2=A0 =C2=A0/* Data buffer address */<br>
+=C2=A0 =C2=A0 uint32_t next;=C2=A0 =C2=A0/* Physical address of next descr=
iptor */<br>
+} TransferDescriptor;<br>
+<br>
+/* Data transfer descriptor flags */<br>
+#define DESC_STATUS_HOLD=C2=A0 =C2=A0(1 &lt;&lt; 31) /* Set when descripto=
r is in use by DMA */<br>
+#define DESC_STATUS_ERROR=C2=A0 (1 &lt;&lt; 30) /* Set when DMA transfer e=
rror occurred */<br>
+#define DESC_STATUS_CHAIN=C2=A0 (1 &lt;&lt; 4)=C2=A0 /* Indicates chained =
descriptor. */<br>
+#define DESC_STATUS_FIRST=C2=A0 (1 &lt;&lt; 3)=C2=A0 /* Set on the first d=
escriptor */<br>
+#define DESC_STATUS_LAST=C2=A0 =C2=A0(1 &lt;&lt; 2)=C2=A0 /* Set on the la=
st descriptor */<br>
+#define DESC_STATUS_NOIRQ=C2=A0 (1 &lt;&lt; 1)=C2=A0 /* Skip raising inter=
rupt after transfer */<br>
+<br>
+#define DESC_SIZE_MASK=C2=A0 =C2=A0 =C2=A0(0xfffffffc)<br>
+<br>
+static void aw_h3_sdhost_update_irq(AwH3SDHostState *s)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t irq_en =3D s-&gt;global_ctl &amp; SD_GCTL_INT_ENB;<=
br>
+=C2=A0 =C2=A0 uint32_t irq =3D irq_en ? s-&gt;irq_status &amp; s-&gt;irq_m=
ask : 0;<br>
+<br>
+=C2=A0 =C2=A0 trace_aw_h3_sdhost_update_irq(irq);<br>
+=C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq, irq);<br>
+}<br>
+<br>
+static void aw_h3_sdhost_update_transfer_cnt(AwH3SDHostState *s, uint32_t =
bytes)<br>
+{<br>
+=C2=A0 =C2=A0 if (s-&gt;transfer_cnt &gt; bytes) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;transfer_cnt -=3D bytes;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;transfer_cnt =3D 0;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!s-&gt;transfer_cnt) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq_status |=3D SD_RISR_DATA_COMPLETE | =
SD_RISR_AUTOCMD_DONE;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void aw_h3_sdhost_set_inserted(DeviceState *dev, bool inserted)<br>
+{<br>
+=C2=A0 =C2=A0 AwH3SDHostState *s =3D AW_H3_SDHOST(dev);<br>
+<br>
+=C2=A0 =C2=A0 trace_aw_h3_sdhost_set_inserted(inserted);<br>
+<br>
+=C2=A0 =C2=A0 if (inserted) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq_status |=3D SD_RISR_CARD_INSERT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq_status &amp;=3D ~SD_RISR_CARD_REMOVE=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;status |=3D SD_STAR_CARD_PRESENT;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq_status &amp;=3D ~SD_RISR_CARD_INSERT=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq_status |=3D SD_RISR_CARD_REMOVE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;status &amp;=3D ~SD_STAR_CARD_PRESENT;<b=
r>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);<br>
+}<br>
+<br>
+static void aw_h3_sdhost_send_command(AwH3SDHostState *s)<br>
+{<br>
+=C2=A0 =C2=A0 SDRequest request;<br>
+=C2=A0 =C2=A0 uint8_t resp[16];<br>
+=C2=A0 =C2=A0 int rlen;<br>
+<br>
+=C2=A0 =C2=A0 /* Auto clear load flag */<br>
+=C2=A0 =C2=A0 s-&gt;command &amp;=3D ~SD_CMDR_LOAD;<br>
+<br>
+=C2=A0 =C2=A0 /* Clock change does not actually interact with the SD bus *=
/<br>
+=C2=A0 =C2=A0 if (!(s-&gt;command &amp; SD_CMDR_CLKCHANGE)) {<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Prepare request */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 request.cmd =3D s-&gt;command &amp; SD_CMDR_CM=
DID_MASK;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 request.arg =3D s-&gt;command_arg;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Send request to SD bus */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rlen =3D sdbus_do_command(&amp;s-&gt;sdbus, &a=
mp;request, resp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rlen &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If the command has a response, store it in =
the response registers */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((s-&gt;command &amp; SD_CMDR_RESPONSE)) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rlen =3D=3D 0 ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rlen =3D=3D 4 &amp=
;&amp; (s-&gt;command &amp; SD_CMDR_RESPONSE_LONG))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rlen !=3D 4 &amp;&amp; rlen =
!=3D 16) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rlen =3D=3D 4) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;response[0] =
=3D ldl_be_p(&amp;resp[0]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;response[1] =
=3D s-&gt;response[2] =3D s-&gt;response[3] =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;response[0] =
=3D ldl_be_p(&amp;resp[12]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;response[1] =
=3D ldl_be_p(&amp;resp[8]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;response[2] =
=3D ldl_be_p(&amp;resp[4]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;response[3] =
=3D ldl_be_p(&amp;resp[0]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Set interrupt status bits */<br>
+=C2=A0 =C2=A0 s-&gt;irq_status |=3D SD_RISR_CMD_COMPLETE;<br>
+=C2=A0 =C2=A0 return;<br>
+<br>
+error:<br>
+=C2=A0 =C2=A0 s-&gt;irq_status |=3D SD_RISR_NO_RESPONSE;<br>
+}<br>
+<br>
+static void aw_h3_sdhost_auto_stop(AwH3SDHostState *s)<br>
+{<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* The stop command (CMD12) ensures the SD bus<br>
+=C2=A0 =C2=A0 =C2=A0* returns to the transfer state.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if ((s-&gt;command &amp; SD_CMDR_AUTOSTOP) &amp;&amp; (s-&gt=
;transfer_cnt =3D=3D 0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* First save current command registers */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t saved_cmd =3D s-&gt;command;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t saved_arg =3D s-&gt;command_arg;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Prepare stop command (CMD12) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;command &amp;=3D ~SD_CMDR_CMDID_MASK;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;command |=3D 12; /* CMD12 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;command_arg =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Put the command on SD bus */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_send_command(s);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Restore command values */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;command =3D saved_cmd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;command_arg =3D saved_arg;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static uint32_t aw_h3_sdhost_process_desc(AwH3SDHostState *s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 h=
waddr desc_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 T=
ransferDescriptor *desc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b=
ool is_write, uint32_t max_bytes)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t num_done =3D 0;<br>
+=C2=A0 =C2=A0 uint32_t num_bytes =3D max_bytes;<br>
+=C2=A0 =C2=A0 uint8_t buf[1024];<br>
+<br>
+=C2=A0 =C2=A0 /* Read descriptor */<br>
+=C2=A0 =C2=A0 cpu_physical_memory_read(desc_addr, desc, sizeof(*desc));<br=
>
+=C2=A0 =C2=A0 if (desc-&gt;size =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc-&gt;size =3D 0xffff + 1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (desc-&gt;size &lt; num_bytes) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 num_bytes =3D desc-&gt;size;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 trace_aw_h3_sdhost_process_desc(desc_addr, desc-&gt;size, is=
_write, max_bytes);<br>
+<br>
+=C2=A0 =C2=A0 while (num_done &lt; num_bytes) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Try to completely fill the local buffer */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t buf_bytes =3D num_bytes - num_done;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (buf_bytes &gt; sizeof(buf)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_bytes =3D sizeof(buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Write to SD bus */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_write) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_read((desc-&=
gt;addr &amp; DESC_SIZE_MASK) + num_done,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf, buf_bytes)=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (uint32_t i =3D 0; i &lt; bu=
f_bytes; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sdbus_write_data(&=
amp;s-&gt;sdbus, buf[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Read from SD bus */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (uint32_t i =3D 0; i &lt; bu=
f_bytes; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[i] =3D sdbus_r=
ead_data(&amp;s-&gt;sdbus);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_write((desc-=
&gt;addr &amp; DESC_SIZE_MASK) + num_done,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf, buf_=
bytes);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 num_done +=3D buf_bytes;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Clear hold flag and flush descriptor */<br>
+=C2=A0 =C2=A0 desc-&gt;status &amp;=3D ~DESC_STATUS_HOLD;<br>
+=C2=A0 =C2=A0 cpu_physical_memory_write(desc_addr, desc, sizeof(*desc));<b=
r>
+<br>
+=C2=A0 =C2=A0 return num_done;<br>
+}<br>
+<br>
+static void aw_h3_sdhost_dma(AwH3SDHostState *s)<br>
+{<br>
+=C2=A0 =C2=A0 TransferDescriptor desc;<br>
+=C2=A0 =C2=A0 hwaddr desc_addr =3D s-&gt;desc_base;<br>
+=C2=A0 =C2=A0 bool is_write =3D (s-&gt;command &amp; SD_CMDR_WRITE);<br>
+=C2=A0 =C2=A0 uint32_t bytes_done =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 /* Check if DMA can be performed */<br>
+=C2=A0 =C2=A0 if (s-&gt;byte_count =3D=3D 0 || s-&gt;block_size =3D=3D 0 |=
|<br>
+=C2=A0 =C2=A0 =C2=A0 !(s-&gt;global_ctl &amp; SD_GCTL_DMA_ENB)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* For read operations, data must be available on the S=
D bus<br>
+=C2=A0 =C2=A0 =C2=A0* If not, it is an error and we should not act at all<=
br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (!is_write &amp;&amp; !sdbus_data_ready(&amp;s-&gt;sdbus)=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Process the DMA descriptors until all data is copied */<b=
r>
+=C2=A0 =C2=A0 while (s-&gt;byte_count &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_done =3D aw_h3_sdhost_process_desc(s, de=
sc_addr, &amp;desc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0is_write, s-&gt;byte_count);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_transfer_cnt(s, bytes_done=
);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes_done &lt;=3D s-&gt;byte_count) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;byte_count -=3D bytes_done=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;byte_count =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (desc.status &amp; DESC_STATUS_LAST) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc_addr =3D desc.next;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Raise IRQ to signal DMA is completed */<br>
+=C2=A0 =C2=A0 s-&gt;irq_status |=3D SD_RISR_DATA_COMPLETE | SD_RISR_AUTOCM=
D_DONE;<br>
+<br>
+=C2=A0 =C2=A0 /* Update DMAC bits */<br>
+=C2=A0 =C2=A0 if (is_write) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;dmac_status |=3D SD_IDST_TRANSMIT_IRQ;<b=
r>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;dmac_status |=3D (SD_IDST_SUM_RECEIVE_IR=
Q | SD_IDST_RECEIVE_IRQ);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static uint64_t aw_h3_sdhost_read(void *opaque, hwaddr offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned size)<br>
+{<br>
+=C2=A0 =C2=A0 AwH3SDHostState *s =3D (AwH3SDHostState *)opaque;<br>
+=C2=A0 =C2=A0 uint32_t res =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 switch (offset) {<br>
+=C2=A0 =C2=A0 case REG_SD_GCTL:=C2=A0 =C2=A0 =C2=A0 /* Global Control */<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;global_ctl;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_CKCR:=C2=A0 =C2=A0 =C2=A0 /* Clock Control */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;clock_ctl;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_TMOR:=C2=A0 =C2=A0 =C2=A0 /* Timeout */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;timeout;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_BWDR:=C2=A0 =C2=A0 =C2=A0 /* Bus Width */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;bus_width;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_BKSR:=C2=A0 =C2=A0 =C2=A0 /* Block Size */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;block_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_BYCR:=C2=A0 =C2=A0 =C2=A0 /* Byte Count */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;byte_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_CMDR:=C2=A0 =C2=A0 =C2=A0 /* Command */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;command;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_CAGR:=C2=A0 =C2=A0 =C2=A0 /* Command Argument */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;command_arg;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_RESP0:=C2=A0 =C2=A0 =C2=A0/* Response Zero */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;response[0];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_RESP1:=C2=A0 =C2=A0 =C2=A0/* Response One */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;response[1];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_RESP2:=C2=A0 =C2=A0 =C2=A0/* Response Two */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;response[2];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_RESP3:=C2=A0 =C2=A0 =C2=A0/* Response Three */<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;response[3];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_IMKR:=C2=A0 =C2=A0 =C2=A0 /* Interrupt Mask */<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;irq_mask;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_MISR:=C2=A0 =C2=A0 =C2=A0 /* Masked Interrupt St=
atus */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;irq_status &amp; s-&gt;irq_mask;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_RISR:=C2=A0 =C2=A0 =C2=A0 /* Raw Interrupt Statu=
s */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;irq_status;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_STAR:=C2=A0 =C2=A0 =C2=A0 /* Status */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;status;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_FWLR:=C2=A0 =C2=A0 =C2=A0 /* FIFO Water Level */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;fifo_wlevel;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_FUNS:=C2=A0 =C2=A0 =C2=A0 /* FIFO Function Selec=
t */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;fifo_func_sel;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_DBGC:=C2=A0 =C2=A0 =C2=A0 /* Debug Enable */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;debug_enable;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_A12A:=C2=A0 =C2=A0 =C2=A0 /* Auto command 12 arg=
ument */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;auto12_arg;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_NTSR:=C2=A0 =C2=A0 =C2=A0 /* SD NewTiming Set */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;newtiming_set;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_SDBG:=C2=A0 =C2=A0 =C2=A0 /* SD newTiming Set De=
bug */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;newtiming_debug;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_HWRST:=C2=A0 =C2=A0 =C2=A0/* Hardware Reset Regi=
ster */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;hardware_rst;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_DMAC:=C2=A0 =C2=A0 =C2=A0 /* Internal DMA Contro=
ller Control */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;dmac;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_DLBA:=C2=A0 =C2=A0 =C2=A0 /* Descriptor List Bas=
e Address */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;desc_base;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_IDST:=C2=A0 =C2=A0 =C2=A0 /* Internal DMA Contro=
ller Status */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;dmac_status;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_IDIE:=C2=A0 =C2=A0 =C2=A0 /* Internal DMA Contro=
ller Interrupt Enable */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;dmac_irq;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_THLDC:=C2=A0 =C2=A0 =C2=A0/* Card Threshold Cont=
rol */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;card_threshold;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_DSBD:=C2=A0 =C2=A0 =C2=A0 /* eMMC DDR Start Bit =
Detection Control */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;startbit_detect;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_RES_CRC:=C2=A0 =C2=A0/* Response CRC from card/e=
MMC */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;response_crc;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_DATA7_CRC: /* CRC Data 7 from card/eMMC */<br>
+=C2=A0 =C2=A0 case REG_SD_DATA6_CRC: /* CRC Data 6 from card/eMMC */<br>
+=C2=A0 =C2=A0 case REG_SD_DATA5_CRC: /* CRC Data 5 from card/eMMC */<br>
+=C2=A0 =C2=A0 case REG_SD_DATA4_CRC: /* CRC Data 4 from card/eMMC */<br>
+=C2=A0 =C2=A0 case REG_SD_DATA3_CRC: /* CRC Data 3 from card/eMMC */<br>
+=C2=A0 =C2=A0 case REG_SD_DATA2_CRC: /* CRC Data 2 from card/eMMC */<br>
+=C2=A0 =C2=A0 case REG_SD_DATA1_CRC: /* CRC Data 1 from card/eMMC */<br>
+=C2=A0 =C2=A0 case REG_SD_DATA0_CRC: /* CRC Data 0 from card/eMMC */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;data_crc[((offset - REG_SD_DATA7=
_CRC) / sizeof(uint32_t))];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_CRC_STA:=C2=A0 =C2=A0/* CRC status from card/eMM=
C in write operation */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;status_crc;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_FIFO:=C2=A0 =C2=A0 =C2=A0 /* Read/Write FIFO */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sdbus_data_ready(&amp;s-&gt;sdbus)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D sdbus_read_data(&amp;s-&=
gt;sdbus);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res |=3D sdbus_read_data(&amp;s-=
&gt;sdbus) &lt;&lt; 8;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res |=3D sdbus_read_data(&amp;s-=
&gt;sdbus) &lt;&lt; 16;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res |=3D sdbus_read_data(&amp;s-=
&gt;sdbus) &lt;&lt; 24;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_transfer_cnt=
(s, sizeof(uint32_t));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_auto_stop(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &=
quot;%s: no data ready on SD bus\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __func__);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Bad o=
ffset %&quot;HWADDR_PRIx&quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 trace_aw_h3_sdhost_read(offset, res, size);<br>
+=C2=A0 =C2=A0 return res;<br>
+}<br>
+<br>
+static void aw_h3_sdhost_write(void *opaque, hwaddr offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t value, unsigned size)<br>
+{<br>
+=C2=A0 =C2=A0 AwH3SDHostState *s =3D (AwH3SDHostState *)opaque;<br>
+<br>
+=C2=A0 =C2=A0 trace_aw_h3_sdhost_write(offset, value, size);<br>
+<br>
+=C2=A0 =C2=A0 switch (offset) {<br>
+=C2=A0 =C2=A0 case REG_SD_GCTL:=C2=A0 =C2=A0 =C2=A0 /* Global Control */<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;global_ctl =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;global_ctl &amp;=3D ~(SD_GCTL_DMA_RST | =
SD_GCTL_FIFO_RST |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0SD_GCTL_SOFT_RST);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_CKCR:=C2=A0 =C2=A0 =C2=A0 /* Clock Control */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;clock_ctl =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_TMOR:=C2=A0 =C2=A0 =C2=A0 /* Timeout */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;timeout =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_BWDR:=C2=A0 =C2=A0 =C2=A0 /* Bus Width */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;bus_width =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_BKSR:=C2=A0 =C2=A0 =C2=A0 /* Block Size */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;block_size =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_BYCR:=C2=A0 =C2=A0 =C2=A0 /* Byte Count */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;byte_count =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;transfer_cnt =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_CMDR:=C2=A0 =C2=A0 =C2=A0 /* Command */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;command =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &amp; SD_CMDR_LOAD) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_send_command(s);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_dma(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_auto_stop(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_CAGR:=C2=A0 =C2=A0 =C2=A0 /* Command Argument */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;command_arg =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_RESP0:=C2=A0 =C2=A0 =C2=A0/* Response Zero */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;response[0] =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_RESP1:=C2=A0 =C2=A0 =C2=A0/* Response One */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;response[1] =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_RESP2:=C2=A0 =C2=A0 =C2=A0/* Response Two */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;response[2] =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_RESP3:=C2=A0 =C2=A0 =C2=A0/* Response Three */<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;response[3] =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_IMKR:=C2=A0 =C2=A0 =C2=A0 /* Interrupt Mask */<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq_mask =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_MISR:=C2=A0 =C2=A0 =C2=A0 /* Masked Interrupt St=
atus */<br>
+=C2=A0 =C2=A0 case REG_SD_RISR:=C2=A0 =C2=A0 =C2=A0 /* Raw Interrupt Statu=
s */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq_status &amp;=3D ~value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_STAR:=C2=A0 =C2=A0 =C2=A0 /* Status */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;status &amp;=3D ~value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_FWLR:=C2=A0 =C2=A0 =C2=A0 /* FIFO Water Level */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;fifo_wlevel =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_FUNS:=C2=A0 =C2=A0 =C2=A0 /* FIFO Function Selec=
t */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;fifo_func_sel =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_DBGC:=C2=A0 =C2=A0 =C2=A0 /* Debug Enable */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;debug_enable =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_A12A:=C2=A0 =C2=A0 =C2=A0 /* Auto command 12 arg=
ument */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;auto12_arg =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_NTSR:=C2=A0 =C2=A0 =C2=A0 /* SD NewTiming Set */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;newtiming_set =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_SDBG:=C2=A0 =C2=A0 =C2=A0 /* SD newTiming Set De=
bug */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;newtiming_debug =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_HWRST:=C2=A0 =C2=A0 =C2=A0/* Hardware Reset Regi=
ster */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;hardware_rst =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_DMAC:=C2=A0 =C2=A0 =C2=A0 /* Internal DMA Contro=
ller Control */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;dmac =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_DLBA:=C2=A0 =C2=A0 =C2=A0 /* Descriptor List Bas=
e Address */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;desc_base =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_IDST:=C2=A0 =C2=A0 =C2=A0 /* Internal DMA Contro=
ller Status */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;dmac_status &amp;=3D (~SD_IDST_WR_MASK) =
| (~value &amp; SD_IDST_WR_MASK);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_IDIE:=C2=A0 =C2=A0 =C2=A0 /* Internal DMA Contro=
ller Interrupt Enable */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;dmac_irq =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_THLDC:=C2=A0 =C2=A0 =C2=A0/* Card Threshold Cont=
rol */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;card_threshold =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_DSBD:=C2=A0 =C2=A0 =C2=A0 /* eMMC DDR Start Bit =
Detection Control */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;startbit_detect =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_FIFO:=C2=A0 =C2=A0 =C2=A0 /* Read/Write FIFO */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sdbus_write_data(&amp;s-&gt;sdbus, value &amp;=
 0xff);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sdbus_write_data(&amp;s-&gt;sdbus, (value &gt;=
&gt; 8) &amp; 0xff);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sdbus_write_data(&amp;s-&gt;sdbus, (value &gt;=
&gt; 16) &amp; 0xff);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sdbus_write_data(&amp;s-&gt;sdbus, (value &gt;=
&gt; 24) &amp; 0xff);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_transfer_cnt(s, sizeof(uin=
t32_t));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_auto_stop(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_sdhost_update_irq(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_SD_RES_CRC:=C2=A0 =C2=A0/* Response CRC from card/e=
MMC */<br>
+=C2=A0 =C2=A0 case REG_SD_DATA7_CRC: /* CRC Data 7 from card/eMMC */<br>
+=C2=A0 =C2=A0 case REG_SD_DATA6_CRC: /* CRC Data 6 from card/eMMC */<br>
+=C2=A0 =C2=A0 case REG_SD_DATA5_CRC: /* CRC Data 5 from card/eMMC */<br>
+=C2=A0 =C2=A0 case REG_SD_DATA4_CRC: /* CRC Data 4 from card/eMMC */<br>
+=C2=A0 =C2=A0 case REG_SD_DATA3_CRC: /* CRC Data 3 from card/eMMC */<br>
+=C2=A0 =C2=A0 case REG_SD_DATA2_CRC: /* CRC Data 2 from card/eMMC */<br>
+=C2=A0 =C2=A0 case REG_SD_DATA1_CRC: /* CRC Data 1 from card/eMMC */<br>
+=C2=A0 =C2=A0 case REG_SD_DATA0_CRC: /* CRC Data 0 from card/eMMC */<br>
+=C2=A0 =C2=A0 case REG_SD_CRC_STA:=C2=A0 =C2=A0/* CRC status from card/eMM=
C in write operation */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Bad o=
ffset %&quot;HWADDR_PRIx&quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static const MemoryRegionOps aw_h3_sdhost_ops =3D {<br>
+=C2=A0 =C2=A0 .read =3D aw_h3_sdhost_read,<br>
+=C2=A0 =C2=A0 .write =3D aw_h3_sdhost_write,<br>
+=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
+};<br>
+<br>
+static const VMStateDescription vmstate_aw_h3_sdhost =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_AW_H3_SDHOST,<br>
+=C2=A0 =C2=A0 .version_id =3D 1,<br>
+=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
+=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(global_ctl, AwH3SDHostState),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(clock_ctl, AwH3SDHostState),<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(timeout, AwH3SDHostState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(bus_width, AwH3SDHostState),<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(block_size, AwH3SDHostState),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(byte_count, AwH3SDHostState),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(transfer_cnt, AwH3SDHostState),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(command, AwH3SDHostState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(command_arg, AwH3SDHostState),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(response, AwH3SDHostState=
, 4),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(irq_mask, AwH3SDHostState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(irq_status, AwH3SDHostState),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(status, AwH3SDHostState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(fifo_wlevel, AwH3SDHostState),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(fifo_func_sel, AwH3SDHostState)=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(debug_enable, AwH3SDHostState),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(auto12_arg, AwH3SDHostState),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(newtiming_set, AwH3SDHostState)=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(newtiming_debug, AwH3SDHostStat=
e),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(hardware_rst, AwH3SDHostState),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(dmac, AwH3SDHostState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(desc_base, AwH3SDHostState),<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(dmac_status, AwH3SDHostState),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(dmac_irq, AwH3SDHostState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(card_threshold, AwH3SDHostState=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(startbit_detect, AwH3SDHostStat=
e),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(response_crc, AwH3SDHostState),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(data_crc, AwH3SDHostState=
, 8),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(status_crc, AwH3SDHostState),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
+=C2=A0 =C2=A0 }<br>
+};<br>
+<br>
+static void aw_h3_sdhost_init(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AwH3SDHostState *s =3D AW_H3_SDHOST(obj);<br>
+<br>
+=C2=A0 =C2=A0 qbus_create_inplace(&amp;s-&gt;sdbus, sizeof(s-&gt;sdbus),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 TYPE_AW_H3_SDHOST_BUS, DEVICE(s), &quot;sd-bus&quot;);<br>
+<br>
+=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem, obj, &amp;aw_h3_sdho=
st_ops, s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TYPE_AW_H3_SDHOST, AW_H3_SDHOST_REGS_MEM_SIZE);<br>
+=C2=A0 =C2=A0 sysbus_init_mmio(SYS_BUS_DEVICE(s), &amp;s-&gt;iomem);<br>
+=C2=A0 =C2=A0 sysbus_init_irq(SYS_BUS_DEVICE(s), &amp;s-&gt;irq);<br>
+}<br>
+<br>
+static void aw_h3_sdhost_reset(DeviceState *dev)<br>
+{<br>
+=C2=A0 =C2=A0 AwH3SDHostState *s =3D AW_H3_SDHOST(dev);<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;global_ctl =3D REG_SD_GCTL_RST;<br>
+=C2=A0 =C2=A0 s-&gt;clock_ctl =3D REG_SD_CKCR_RST;<br>
+=C2=A0 =C2=A0 s-&gt;timeout =3D REG_SD_TMOR_RST;<br>
+=C2=A0 =C2=A0 s-&gt;bus_width =3D REG_SD_BWDR_RST;<br>
+=C2=A0 =C2=A0 s-&gt;block_size =3D REG_SD_BKSR_RST;<br>
+=C2=A0 =C2=A0 s-&gt;byte_count =3D REG_SD_BYCR_RST;<br>
+=C2=A0 =C2=A0 s-&gt;transfer_cnt =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;command =3D REG_SD_CMDR_RST;<br>
+=C2=A0 =C2=A0 s-&gt;command_arg =3D REG_SD_CAGR_RST;<br>
+<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; sizeof(s-&gt;response) / sizeof(s-&=
gt;response[0]); i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;response[i] =3D REG_SD_RESP_RST;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;irq_mask =3D REG_SD_IMKR_RST;<br>
+=C2=A0 =C2=A0 s-&gt;irq_status =3D REG_SD_RISR_RST;<br>
+=C2=A0 =C2=A0 s-&gt;status =3D REG_SD_STAR_RST;<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;fifo_wlevel =3D REG_SD_FWLR_RST;<br>
+=C2=A0 =C2=A0 s-&gt;fifo_func_sel =3D REG_SD_FUNS_RST;<br>
+=C2=A0 =C2=A0 s-&gt;debug_enable =3D REG_SD_DBGC_RST;<br>
+=C2=A0 =C2=A0 s-&gt;auto12_arg =3D REG_SD_A12A_RST;<br>
+=C2=A0 =C2=A0 s-&gt;newtiming_set =3D REG_SD_NTSR_RST;<br>
+=C2=A0 =C2=A0 s-&gt;newtiming_debug =3D REG_SD_SDBG_RST;<br>
+=C2=A0 =C2=A0 s-&gt;hardware_rst =3D REG_SD_HWRST_RST;<br>
+=C2=A0 =C2=A0 s-&gt;dmac =3D REG_SD_DMAC_RST;<br>
+=C2=A0 =C2=A0 s-&gt;desc_base =3D REG_SD_DLBA_RST;<br>
+=C2=A0 =C2=A0 s-&gt;dmac_status =3D REG_SD_IDST_RST;<br>
+=C2=A0 =C2=A0 s-&gt;dmac_irq =3D REG_SD_IDIE_RST;<br>
+=C2=A0 =C2=A0 s-&gt;card_threshold =3D REG_SD_THLDC_RST;<br>
+=C2=A0 =C2=A0 s-&gt;startbit_detect =3D REG_SD_DSBD_RST;<br>
+=C2=A0 =C2=A0 s-&gt;response_crc =3D REG_SD_RES_CRC_RST;<br>
+<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; sizeof(s-&gt;data_crc) / sizeof(s-&=
gt;data_crc[0]); i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;data_crc[i] =3D REG_SD_DATA_CRC_RST;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;status_crc =3D REG_SD_CRC_STA_RST;<br>
+}<br>
+<br>
+static void aw_h3_sdhost_bus_class_init(ObjectClass *klass, void *data)<br=
>
+{<br>
+=C2=A0 =C2=A0 SDBusClass *sbc =3D SD_BUS_CLASS(klass);<br>
+<br>
+=C2=A0 =C2=A0 sbc-&gt;set_inserted =3D aw_h3_sdhost_set_inserted;<br>
+}<br>
+<br>
+static void aw_h3_sdhost_class_init(ObjectClass *klass, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+<br>
+=C2=A0 =C2=A0 dc-&gt;reset =3D aw_h3_sdhost_reset;<br>
+=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;vmstate_aw_h3_sdhost;<br>
+}<br>
+<br>
+static TypeInfo aw_h3_sdhost_info =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_H3_SDHOS=
T,<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEVICE,<=
br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(AwH3SDHostState),<br>
+=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D aw_h3_sdhost_class_init,<br>
+=C2=A0 =C2=A0 .instance_init =3D aw_h3_sdhost_init,<br>
+};<br>
+<br>
+static const TypeInfo aw_h3_sdhost_bus_info =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_AW_H3_SDHOST_BUS,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_SD_BUS,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(SDBus),<br>
+=C2=A0 =C2=A0 .class_init =3D aw_h3_sdhost_bus_class_init,<br>
+};<br>
+<br>
+static void aw_h3_sdhost_register_types(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;aw_h3_sdhost_info);<br>
+=C2=A0 =C2=A0 type_register_static(&amp;aw_h3_sdhost_bus_info);<br>
+}<br>
+<br>
+type_init(aw_h3_sdhost_register_types)<br>
diff --git a/hw/sd/trace-events b/hw/sd/trace-events<br>
index efcff666a2..c672a201b5 100644<br>
--- a/hw/sd/trace-events<br>
+++ b/hw/sd/trace-events<br>
@@ -1,5 +1,12 @@<br>
=C2=A0# See docs/devel/tracing.txt for syntax documentation.<br>
<br>
+# allwinner-h3-sdhost.c<br>
+aw_h3_sdhost_set_inserted(bool inserted) &quot;inserted %u&quot;<br>
+aw_h3_sdhost_process_desc(uint64_t desc_addr, uint32_t desc_size, bool is_=
write, uint32_t max_bytes) &quot;desc_addr 0x%&quot; PRIx64 &quot; desc_siz=
e %u is_write %u max_bytes %u&quot;<br>
+aw_h3_sdhost_read(uint64_t offset, uint64_t data, unsigned size) &quot;off=
set 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 &quot; size %u&quot;<br>
+aw_h3_sdhost_write(uint64_t offset, uint64_t data, unsigned size) &quot;of=
fset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 &quot; size %u&quot;<br>
+aw_h3_sdhost_update_irq(uint32_t irq) &quot;IRQ bits 0x%x&quot;<br>
+<br>
=C2=A0# bcm2835_sdhost.c<br>
=C2=A0bcm2835_sdhost_read(uint64_t offset, uint64_t data, unsigned size) &q=
uot;offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 &quot; size %u&quo=
t;<br>
=C2=A0bcm2835_sdhost_write(uint64_t offset, uint64_t data, unsigned size) &=
quot;offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 &quot; size %u&qu=
ot;<br>
diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h<=
br>
index 33602599eb..7aff4ebbd2 100644<br>
--- a/include/hw/arm/allwinner-h3.h<br>
+++ b/include/hw/arm/allwinner-h3.h<br>
@@ -30,6 +30,7 @@<br>
=C2=A0#include &quot;hw/misc/allwinner-h3-cpucfg.h&quot;<br>
=C2=A0#include &quot;hw/misc/allwinner-h3-syscon.h&quot;<br>
=C2=A0#include &quot;hw/misc/allwinner-h3-sid.h&quot;<br>
+#include &quot;hw/sd/allwinner-h3-sdhost.h&quot;<br>
=C2=A0#include &quot;target/arm/cpu.h&quot;<br>
<br>
=C2=A0#define AW_H3_SRAM_A1_BASE=C2=A0 =C2=A0 =C2=A0(0x00000000)<br>
@@ -117,6 +118,7 @@ typedef struct AwH3State {<br>
=C2=A0 =C2=A0 =C2=A0AwH3CpuCfgState cpucfg;<br>
=C2=A0 =C2=A0 =C2=A0AwH3SysconState syscon;<br>
=C2=A0 =C2=A0 =C2=A0AwH3SidState sid;<br>
+=C2=A0 =C2=A0 AwH3SDHostState mmc0;<br>
=C2=A0 =C2=A0 =C2=A0GICState gic;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a1;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a2;<br>
diff --git a/include/hw/sd/allwinner-h3-sdhost.h b/include/hw/sd/allwinner-=
h3-sdhost.h<br>
new file mode 100644<br>
index 0000000000..6c898a3c84<br>
--- /dev/null<br>
+++ b/include/hw/sd/allwinner-h3-sdhost.h<br>
@@ -0,0 +1,73 @@<br>
+/*<br>
+ * Allwinner H3 SD Host Controller emulation<br>
+ *<br>
+ * Copyright (C) 2019 Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank=
@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
+ *<br>
+ * This program is free software: you can redistribute it and/or modify<br=
>
+ * it under the terms of the GNU General Public License as published by<br=
>
+ * the Free Software Foundation, either version 2 of the License, or<br>
+ * (at your option) any later version.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License<br>
+ * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gn=
u.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/li=
censes/</a>&gt;.<br>
+ */<br>
+<br>
+#ifndef ALLWINNER_H3_SDHOST_H<br>
+#define ALLWINNER_H3_SDHOST_H<br>
+<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;hw/sd/sd.h&quot;<br>
+<br>
+#define AW_H3_SDHOST_REGS_MEM_SIZE=C2=A0 (1024)<br>
+<br>
+#define TYPE_AW_H3_SDHOST &quot;allwinner-h3-sdhost&quot;<br>
+#define AW_H3_SDHOST(obj) \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 OBJECT_CHECK(AwH3SDHostState, (obj), TYPE_AW_H=
3_SDHOST)<br>
+<br>
+typedef struct {<br>
+=C2=A0 =C2=A0 SysBusDevice busdev;<br>
+=C2=A0 =C2=A0 SDBus sdbus;<br>
+=C2=A0 =C2=A0 MemoryRegion iomem;<br>
+<br>
+=C2=A0 =C2=A0 uint32_t global_ctl;<br>
+=C2=A0 =C2=A0 uint32_t clock_ctl;<br>
+=C2=A0 =C2=A0 uint32_t timeout;<br>
+=C2=A0 =C2=A0 uint32_t bus_width;<br>
+=C2=A0 =C2=A0 uint32_t block_size;<br>
+=C2=A0 =C2=A0 uint32_t byte_count;<br>
+=C2=A0 =C2=A0 uint32_t transfer_cnt;<br>
+<br>
+=C2=A0 =C2=A0 uint32_t command;<br>
+=C2=A0 =C2=A0 uint32_t command_arg;<br>
+=C2=A0 =C2=A0 uint32_t response[4];<br>
+<br>
+=C2=A0 =C2=A0 uint32_t irq_mask;<br>
+=C2=A0 =C2=A0 uint32_t irq_status;<br>
+=C2=A0 =C2=A0 uint32_t status;<br>
+<br>
+=C2=A0 =C2=A0 uint32_t fifo_wlevel;<br>
+=C2=A0 =C2=A0 uint32_t fifo_func_sel;<br>
+=C2=A0 =C2=A0 uint32_t debug_enable;<br>
+=C2=A0 =C2=A0 uint32_t auto12_arg;<br>
+=C2=A0 =C2=A0 uint32_t newtiming_set;<br>
+=C2=A0 =C2=A0 uint32_t newtiming_debug;<br>
+=C2=A0 =C2=A0 uint32_t hardware_rst;<br>
+=C2=A0 =C2=A0 uint32_t dmac;<br>
+=C2=A0 =C2=A0 uint32_t desc_base;<br>
+=C2=A0 =C2=A0 uint32_t dmac_status;<br>
+=C2=A0 =C2=A0 uint32_t dmac_irq;<br>
+=C2=A0 =C2=A0 uint32_t card_threshold;<br>
+=C2=A0 =C2=A0 uint32_t startbit_detect;<br>
+=C2=A0 =C2=A0 uint32_t response_crc;<br>
+=C2=A0 =C2=A0 uint32_t data_crc[8];<br>
+=C2=A0 =C2=A0 uint32_t status_crc;<br>
+<br>
+=C2=A0 =C2=A0 qemu_irq irq;<br>
+} AwH3SDHostState;<br>
+<br>
+#endif<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000013a1430599753d58--

