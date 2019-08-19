Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E01C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A5022CE8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLSk+5Ky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A5022CE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzoFu-0004Mw-RG
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1hzoDT-000280-6e
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hzoDR-0006aR-6A
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:25:23 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:38011)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hzoDQ-0006aA-RU; Mon, 19 Aug 2019 16:25:21 -0400
Received: by mail-lj1-x242.google.com with SMTP id x3so2984799lji.5;
 Mon, 19 Aug 2019 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dvz6G/d1Us/xYoQEdX1y3F28YNAScImSurheaxUwTTo=;
 b=NLSk+5Ky4gUHD5sw3ez+zs7dUfhB6Tbq2SfChIcQpsKVbU1PHB5YndsNtGsIlFXs8q
 GeHl1txbIxQL6k/YFvqHJ+PWOOLqMKORtoQ37wLca/bPPp01H8uDvB1wHMs/sTMTa8Hk
 iANX2Of7zmpYjhAd23Lp49O90VtnKV6xNOJtw4KPJWsV4c+hqDUH5ZqZyPOvdpj8doMo
 +o7cIoSR7mQYkHkwbQo0I9RRF3htkBfbQktEV26xdhakeresIhF1aIQjEr9BsI7hQhxW
 3f4aopma4Fwsjg1cPCaYGb2g/imDA9fYMGOyKkYUFYqYAr3pUNAFhqMkR6QQjc3ojlme
 CR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dvz6G/d1Us/xYoQEdX1y3F28YNAScImSurheaxUwTTo=;
 b=pVvEGXqeerTqwGw8nO4V3t5oDN7+/XwqOVkoQVTcfq4DBh4sm9CXhW3eBIRrNbPQfC
 quFBpL09oN6fQQ5ZP6oH8brbaKCx2sX+ok70UcZMo7FHvu7tjjjgnfziawJJ2n1mWsB8
 aDaR0isUKhqXaS2kbZSI5nHkhjahhs4CAYs8L0JISgrAs4gBgh5g8b3DR7FJ5XhVOtDh
 ojwQRnV5OE3sIj8NMfHrCF7fwAPGrxCnYtlJUD7faKCxrmvILIiUUgNjYOpQw2A20Oxn
 51xCZwZ/YjZokjfOuc215MFXh5m2/ySwbpw2pEUPSW3l/El6JPHKJ2fLoH3KJBCIT0O0
 OZVA==
X-Gm-Message-State: APjAAAX6NEWesNwIG5Pce8lR4t/6l5AXcl7FA90yPG7pmhjLXnPVdfFW
 hDbeuzuHJ7cfF3aSmxhJRLjTrS+9fz61yFWDuN0=
X-Google-Smtp-Source: APXvYqyBKJsJ8Pw90eAffQSpJKej7EGFyFwJmP1L0wZwjCIuqigGZXQHyLCE6rbWFwGQzMCKHuThQoXFvMnnnm+6PM0=
X-Received: by 2002:a05:651c:109:: with SMTP id
 a9mr7638241ljb.33.1566246319285; 
 Mon, 19 Aug 2019 13:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
 <1566191521-7820-18-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1566191521-7820-18-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Aug 2019 13:21:18 -0700
Message-ID: <CAKmqyKMwgZzyUMjkdBxpCy-ZBrr0-a37eFEoEoSMnCDbr_XWCQ@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v4 17/28] riscv: sifive: Implement PRCI
 model for FU540
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 On Sun, Aug 18, 2019 at 10:30 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> This adds a simple PRCI model for FU540 (sifive_u). It has different
> register layout from the existing PRCI model for FE310 (sifive_e).
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> ---
>
> Changes in v4:
> - prefix all macros/variables/functions with SIFIVE_U/sifive_u
>   in the sifive_u_prci driver
>
> Changes in v3: None
> Changes in v2: None
>
>  hw/riscv/Makefile.objs           |   1 +
>  hw/riscv/sifive_u_prci.c         | 165 +++++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/sifive_u_prci.h |  90 +++++++++++++++++++++
>  3 files changed, 256 insertions(+)
>  create mode 100644 hw/riscv/sifive_u_prci.c
>  create mode 100644 include/hw/riscv/sifive_u_prci.h
>
> diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
> index c859697..b95bbd5 100644
> --- a/hw/riscv/Makefile.objs
> +++ b/hw/riscv/Makefile.objs
> @@ -8,6 +8,7 @@ obj-$(CONFIG_SIFIVE) += sifive_gpio.o
>  obj-$(CONFIG_SIFIVE) += sifive_plic.o
>  obj-$(CONFIG_SIFIVE) += sifive_test.o
>  obj-$(CONFIG_SIFIVE_U) += sifive_u.o
> +obj-$(CONFIG_SIFIVE_U) += sifive_u_prci.o
>  obj-$(CONFIG_SIFIVE) += sifive_uart.o
>  obj-$(CONFIG_SPIKE) += spike.o
>  obj-$(CONFIG_RISCV_VIRT) += virt.o
> diff --git a/hw/riscv/sifive_u_prci.c b/hw/riscv/sifive_u_prci.c
> new file mode 100644
> index 0000000..578c643
> --- /dev/null
> +++ b/hw/riscv/sifive_u_prci.c
> @@ -0,0 +1,165 @@
> +/*
> + * QEMU SiFive U PRCI (Power, Reset, Clock, Interrupt)
> + *
> + * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
> + *
> + * Simple model of the PRCI to emulate register reads made by the SDK BSP
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "qemu/module.h"
> +#include "target/riscv/cpu.h"
> +#include "hw/riscv/sifive_u_prci.h"
> +
> +static uint64_t sifive_u_prci_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    SiFiveUPRCIState *s = opaque;
> +
> +    switch (addr) {
> +    case SIFIVE_U_PRCI_HFXOSCCFG:
> +        return s->hfxosccfg;
> +    case SIFIVE_U_PRCI_COREPLLCFG0:
> +        return s->corepllcfg0;
> +    case SIFIVE_U_PRCI_DDRPLLCFG0:
> +        return s->ddrpllcfg0;
> +    case SIFIVE_U_PRCI_DDRPLLCFG1:
> +        return s->ddrpllcfg1;
> +    case SIFIVE_U_PRCI_GEMGXLPLLCFG0:
> +        return s->gemgxlpllcfg0;
> +    case SIFIVE_U_PRCI_GEMGXLPLLCFG1:
> +        return s->gemgxlpllcfg1;
> +    case SIFIVE_U_PRCI_CORECLKSEL:
> +        return s->coreclksel;
> +    case SIFIVE_U_PRCI_DEVICESRESET:
> +        return s->devicesreset;
> +    case SIFIVE_U_PRCI_CLKMUXSTATUS:
> +        return s->clkmuxstatus;
> +    }
> +
> +    hw_error("%s: read: addr=0x%x\n", __func__, (int)addr);

This should be: qemu_log_mask(LOG_GUEST_ERROR,... instead.

> +    return 0;
> +}
> +
> +static void sifive_u_prci_write(void *opaque, hwaddr addr,
> +                                uint64_t val64, unsigned int size)
> +{
> +    SiFiveUPRCIState *s = opaque;
> +
> +    switch (addr) {
> +    case SIFIVE_U_PRCI_HFXOSCCFG:
> +        s->hfxosccfg = (uint32_t) val64;
> +        /* OSC stays ready */
> +        s->hfxosccfg |= SIFIVE_U_PRCI_HFXOSCCFG_RDY;
> +        break;
> +    case SIFIVE_U_PRCI_COREPLLCFG0:
> +        s->corepllcfg0 = (uint32_t) val64;
> +        /* internal feedback */
> +        s->corepllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_FSE;
> +        /* PLL stays locked */
> +        s->corepllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_LOCK;
> +        break;
> +    case SIFIVE_U_PRCI_DDRPLLCFG0:
> +        s->ddrpllcfg0 = (uint32_t) val64;
> +        /* internal feedback */
> +        s->ddrpllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_FSE;
> +        /* PLL stays locked */
> +        s->ddrpllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_LOCK;
> +        break;
> +    case SIFIVE_U_PRCI_DDRPLLCFG1:
> +        s->ddrpllcfg1 = (uint32_t) val64;
> +        break;
> +    case SIFIVE_U_PRCI_GEMGXLPLLCFG0:
> +        s->gemgxlpllcfg0 = (uint32_t) val64;
> +         /* internal feedback */
> +        s->gemgxlpllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_FSE;
> +       /* PLL stays locked */
> +        s->gemgxlpllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_LOCK;
> +        break;
> +    case SIFIVE_U_PRCI_GEMGXLPLLCFG1:
> +        s->gemgxlpllcfg1 = (uint32_t) val64;
> +        break;
> +    case SIFIVE_U_PRCI_CORECLKSEL:
> +        s->coreclksel = (uint32_t) val64;
> +        break;
> +    case SIFIVE_U_PRCI_DEVICESRESET:
> +        s->devicesreset = (uint32_t) val64;
> +        break;
> +    case SIFIVE_U_PRCI_CLKMUXSTATUS:
> +        s->clkmuxstatus = (uint32_t) val64;

Maybe it's worth creating a 32-bit val variable and using that instead
of casting everywhere.

> +        break;
> +    default:
> +        hw_error("%s: bad write: addr=0x%x v=0x%x\n",
> +                 __func__, (int)addr, (int)val64);

Same comment about: qemu_log_mask(LOG_GUEST_ERROR,

> +    }
> +}
> +
> +static const MemoryRegionOps sifive_u_prci_ops = {
> +    .read = sifive_u_prci_read,
> +    .write = sifive_u_prci_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4
> +    }
> +};
> +
> +static void sifive_u_prci_init(Object *obj)
> +{
> +    SiFiveUPRCIState *s = SIFIVE_U_PRCI(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &sifive_u_prci_ops, s,
> +                          TYPE_SIFIVE_U_PRCI, SIFIVE_U_PRCI_REG_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +
> +    /* Initialize register to power-on-reset values */
> +    s->hfxosccfg = (SIFIVE_U_PRCI_HFXOSCCFG_RDY | SIFIVE_U_PRCI_HFXOSCCFG_EN);
> +    s->corepllcfg0 = (SIFIVE_U_PRCI_PLLCFG0_DIVR | SIFIVE_U_PRCI_PLLCFG0_DIVF |
> +                      SIFIVE_U_PRCI_PLLCFG0_DIVQ | SIFIVE_U_PRCI_PLLCFG0_FSE |
> +                      SIFIVE_U_PRCI_PLLCFG0_LOCK);
> +    s->ddrpllcfg0 = (SIFIVE_U_PRCI_PLLCFG0_DIVR | SIFIVE_U_PRCI_PLLCFG0_DIVF |
> +                     SIFIVE_U_PRCI_PLLCFG0_DIVQ | SIFIVE_U_PRCI_PLLCFG0_FSE |
> +                     SIFIVE_U_PRCI_PLLCFG0_LOCK);
> +    s->gemgxlpllcfg0 = (SIFIVE_U_PRCI_PLLCFG0_DIVR |
> +                        SIFIVE_U_PRCI_PLLCFG0_DIVF |
> +                        SIFIVE_U_PRCI_PLLCFG0_DIVQ |
> +                        SIFIVE_U_PRCI_PLLCFG0_FSE |
> +                        SIFIVE_U_PRCI_PLLCFG0_LOCK);
> +    s->coreclksel = SIFIVE_U_PRCI_CORECLKSEL_HFCLK;

These should be in the reset functino shouldn't they?

> +}
> +
> +static const TypeInfo sifive_u_prci_info = {
> +    .name          = TYPE_SIFIVE_U_PRCI,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(SiFiveUPRCIState),
> +    .instance_init = sifive_u_prci_init,
> +};
> +
> +static void sifive_u_prci_register_types(void)
> +{
> +    type_register_static(&sifive_u_prci_info);
> +}
> +
> +type_init(sifive_u_prci_register_types)
> +
> +
> +/* Create PRCI device */
> +DeviceState *sifive_u_prci_create(hwaddr addr)
> +{
> +    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_U_PRCI);
> +    qdev_init_nofail(dev);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> +    return dev;
> +}

Don't do this, just create it in the machine.

> diff --git a/include/hw/riscv/sifive_u_prci.h b/include/hw/riscv/sifive_u_prci.h
> new file mode 100644
> index 0000000..66eacb5
> --- /dev/null
> +++ b/include/hw/riscv/sifive_u_prci.h
> @@ -0,0 +1,90 @@
> +/*
> + * QEMU SiFive U PRCI (Power, Reset, Clock, Interrupt) interface
> + *
> + * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_SIFIVE_U_PRCI_H
> +#define HW_SIFIVE_U_PRCI_H
> +
> +enum {
> +    SIFIVE_U_PRCI_HFXOSCCFG     = 0x00,
> +    SIFIVE_U_PRCI_COREPLLCFG0   = 0x04,
> +    SIFIVE_U_PRCI_DDRPLLCFG0    = 0x0C,
> +    SIFIVE_U_PRCI_DDRPLLCFG1    = 0x10,
> +    SIFIVE_U_PRCI_GEMGXLPLLCFG0 = 0x1C,
> +    SIFIVE_U_PRCI_GEMGXLPLLCFG1 = 0x20,
> +    SIFIVE_U_PRCI_CORECLKSEL    = 0x24,
> +    SIFIVE_U_PRCI_DEVICESRESET  = 0x28,
> +    SIFIVE_U_PRCI_CLKMUXSTATUS  = 0x2C
> +};
> +
> +/*
> + * Current FU540-C000 manual says ready bit is at bit 29, but
> + * freedom-u540-c000-bootloader codes (ux00prci.h) says it is at bit 31.
> + * We have to trust the actual codes that worked.

s/codes that worked/code that works/g

> + *
> + * see https://github.com/sifive/freedom-u540-c000-bootloader
> + */
> +enum {
> +    SIFIVE_U_PRCI_HFXOSCCFG_EN  = (1 << 30),
> +    SIFIVE_U_PRCI_HFXOSCCFG_RDY = (1 << 31),
> +};
> +
> +/* xxxPLLCFG0 register bits */
> +enum {
> +    SIFIVE_U_PRCI_PLLCFG0_DIVR  = (1 << 0),
> +    SIFIVE_U_PRCI_PLLCFG0_DIVF  = (31 << 6),
> +    SIFIVE_U_PRCI_PLLCFG0_DIVQ  = (3 << 15),
> +    SIFIVE_U_PRCI_PLLCFG0_FSE   = (1 << 25),
> +    SIFIVE_U_PRCI_PLLCFG0_LOCK  = (1 << 31)
> +};
> +
> +/* xxxPLLCFG1 register bits */
> +enum {
> +    SIFIVE_U_PRCI_PLLCFG1_CKE   = (1 << 24)
> +};
> +
> +enum {
> +    SIFIVE_U_PRCI_CORECLKSEL_HFCLK = (1 << 0)
> +};

Why use enums for eveythign instead of #defines?

Alistair

> +
> +#define SIFIVE_U_PRCI_REG_SIZE  0x1000
> +
> +#define TYPE_SIFIVE_U_PRCI      "riscv.sifive.u.prci"
> +
> +#define SIFIVE_U_PRCI(obj) \
> +    OBJECT_CHECK(SiFiveUPRCIState, (obj), TYPE_SIFIVE_U_PRCI)
> +
> +typedef struct SiFiveUPRCIState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion mmio;
> +    uint32_t hfxosccfg;
> +    uint32_t corepllcfg0;
> +    uint32_t ddrpllcfg0;
> +    uint32_t ddrpllcfg1;
> +    uint32_t gemgxlpllcfg0;
> +    uint32_t gemgxlpllcfg1;
> +    uint32_t coreclksel;
> +    uint32_t devicesreset;
> +    uint32_t clkmuxstatus;
> +} SiFiveUPRCIState;
> +
> +DeviceState *sifive_u_prci_create(hwaddr addr);
> +
> +#endif /* HW_SIFIVE_U_PRCI_H */
> --
> 2.7.4
>
>

