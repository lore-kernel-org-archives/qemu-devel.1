Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64316C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3546D223CB
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Hfy+1sA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3546D223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvHj5-00083Z-DQ
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 04:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48593)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hvHid-0007dG-Mt
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hvHib-0007Qh-N6
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:54:51 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hvHib-0007QD-FA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:54:49 -0400
Received: by mail-ot1-x341.google.com with SMTP id o101so101329778ota.8
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 01:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NasqwgARd8VqeJUNiKe6yXRna1Oyz8d5wdX3A0iFcSM=;
 b=Hfy+1sA81qPuqLCEEY3zV+Jh5KipkcZFM4eHHUOO0iYUnDrTS9odESmefm624XPq7R
 SI2uYqg032mthAOAK/mXueOm2T1LqIb7dA5EO7p1EvoZnYeqcC3Uw0lUuxu/0rOZKrY5
 NfDA6R556XGxJ++ZAh0uThUiZ5b5jOGAJIwEoEGCcHLwTp0BivMbVvHf+7zAU3a7frGO
 RhVzvw9Jhxa/HKcckx95ZvblEi4n9PHeZus872MNjJyWJvJVQn1u8nrYnDUgX7ikFaXK
 UGEpXtMHfUJMZJmiR1+eskn9q/Hl4Z0tRVudxln2msi9NsvF/JekpcYQr/AMwLDZoGld
 RMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NasqwgARd8VqeJUNiKe6yXRna1Oyz8d5wdX3A0iFcSM=;
 b=sTnwFT7mHmJU2k3zZ7TnyZGah4V0vVi37HRZwQREi3bn5QZZNQtpRtGMdWAgtJ6RbR
 t2dSqS5zCHoElVF0fGq51x+pvIXtmgIukPefXKmTL52tozKcfkDABdmGohC1JqlajyW0
 UYs2mQyecMYjaZtHQ7Oy6RwBl5Wx9vJi5cUJtAJf677gOd+XgWTnAsrF3SBsxDeNrtdy
 gp7QTWhQgCaR0N6vasNcM4udLm46cX10RzakxM9yavD1RiHh/1l2XTXDv0DameJArs72
 IIfbVhPAHS+R5L2iF3fpeGbzecFqVOYHVUv1Muff/mhIW3gtFpicPBNnAdQwHNu59n5x
 ySQg==
X-Gm-Message-State: APjAAAWXY+A3H3m+7YmUdph+ZuV+m0oBgRyUqH8EbshZceKLOab4pYMR
 c9WKUSMp4JV0v6BauvhaLarzYLXz5mC4eX7mRwLONg==
X-Google-Smtp-Source: APXvYqxzmAumR0YcMB/ITwbBV/92yIAV/Zl+GqaWtVNt3RpdKqbsTlfI/0CS6pIql8WXxG0SQz5DopAa5wqsQte7npo=
X-Received: by 2002:a02:a07:: with SMTP id 7mr9083419jaw.65.1565168087481;
 Wed, 07 Aug 2019 01:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
 <1565163924-18621-12-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565163924-18621-12-git-send-email-bmeng.cn@gmail.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Wed, 7 Aug 2019 16:54:36 +0800
Message-ID: <CAEiOBXU9UXEGYjEDP-LJ5mEY-bF+OtMKt4O+LGJh9qQt3OPaew@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 11/28] riscv: sifive: Rename
 sifive_prci.{c, h} to sifive_e_prci.{c, h}
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 7, 2019 at 3:49 PM Bin Meng <bmeng.cn@gmail.com> wrote:

> Current SiFive PRCI model only works with sifive_e machine, as it
> only emulates registers or PRCI block in the FE310 SoC.
>
> Rename the file name to make it clear that it is for sifive_e.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
> Changes in v2: None
>
>  hw/riscv/Makefile.objs                              |  2 +-
>  hw/riscv/sifive_e.c                                 |  4 ++--
>  hw/riscv/{sifive_prci.c => sifive_e_prci.c}         | 14 +++++++-------
>  include/hw/riscv/{sifive_prci.h => sifive_e_prci.h} | 14 +++++++-------
>  4 files changed, 17 insertions(+), 17 deletions(-)
>  rename hw/riscv/{sifive_prci.c => sifive_e_prci.c} (90%)
>  rename include/hw/riscv/{sifive_prci.h => sifive_e_prci.h} (82%)
>
> diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
> index eb9d4f9..c859697 100644
> --- a/hw/riscv/Makefile.objs
> +++ b/hw/riscv/Makefile.objs
> @@ -2,9 +2,9 @@ obj-y += boot.o
>  obj-$(CONFIG_SPIKE) += riscv_htif.o
>  obj-$(CONFIG_HART) += riscv_hart.o
>  obj-$(CONFIG_SIFIVE_E) += sifive_e.o
> +obj-$(CONFIG_SIFIVE_E) += sifive_e_prci.o
>  obj-$(CONFIG_SIFIVE) += sifive_clint.o
>  obj-$(CONFIG_SIFIVE) += sifive_gpio.o
> -obj-$(CONFIG_SIFIVE) += sifive_prci.o
>  obj-$(CONFIG_SIFIVE) += sifive_plic.o
>  obj-$(CONFIG_SIFIVE) += sifive_test.o
>  obj-$(CONFIG_SIFIVE_U) += sifive_u.o
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 2a499d8..2d67670 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -41,9 +41,9 @@
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/riscv/sifive_plic.h"
>  #include "hw/riscv/sifive_clint.h"
> -#include "hw/riscv/sifive_prci.h"
>  #include "hw/riscv/sifive_uart.h"
>  #include "hw/riscv/sifive_e.h"
> +#include "hw/riscv/sifive_e_prci.h"
>  #include "hw/riscv/boot.h"
>  #include "chardev/char.h"
>  #include "sysemu/arch_init.h"
> @@ -174,7 +174,7 @@ static void riscv_sifive_e_soc_realize(DeviceState
> *dev, Error **errp)
>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
>      sifive_mmio_emulate(sys_mem, "riscv.sifive.e.aon",
>          memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
> -    sifive_prci_create(memmap[SIFIVE_E_PRCI].base);
> +    sifive_e_prci_create(memmap[SIFIVE_E_PRCI].base);
>
>      /* GPIO */
>
>
I  think adding infix to function name is sufficient and keeping the
filename the same may be better.
The U board PRCI or variant implementation in future could be included in
the same files with different create function

chihmin



> diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_e_prci.c
> similarity index 90%
> rename from hw/riscv/sifive_prci.c
> rename to hw/riscv/sifive_e_prci.c
> index f406682..acb914d 100644
> --- a/hw/riscv/sifive_prci.c
> +++ b/hw/riscv/sifive_e_prci.c
> @@ -1,5 +1,5 @@
>  /*
> - * QEMU SiFive PRCI (Power, Reset, Clock, Interrupt)
> + * QEMU SiFive E PRCI (Power, Reset, Clock, Interrupt)
>   *
>   * Copyright (c) 2017 SiFive, Inc.
>   *
> @@ -22,7 +22,7 @@
>  #include "hw/sysbus.h"
>  #include "qemu/module.h"
>  #include "target/riscv/cpu.h"
> -#include "hw/riscv/sifive_prci.h"
> +#include "hw/riscv/sifive_e_prci.h"
>
>  static uint64_t sifive_prci_read(void *opaque, hwaddr addr, unsigned int
> size)
>  {
> @@ -82,10 +82,10 @@ static const MemoryRegionOps sifive_prci_ops = {
>
>  static void sifive_prci_init(Object *obj)
>  {
> -    SiFivePRCIState *s = SIFIVE_PRCI(obj);
> +    SiFivePRCIState *s = SIFIVE_E_PRCI(obj);
>
>      memory_region_init_io(&s->mmio, obj, &sifive_prci_ops, s,
> -                          TYPE_SIFIVE_PRCI, 0x8000);
> +                          TYPE_SIFIVE_E_PRCI, 0x8000);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>
>      s->hfrosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
> @@ -97,7 +97,7 @@ static void sifive_prci_init(Object *obj)
>  }
>
>  static const TypeInfo sifive_prci_info = {
> -    .name          = TYPE_SIFIVE_PRCI,
> +    .name          = TYPE_SIFIVE_E_PRCI,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(SiFivePRCIState),
>      .instance_init = sifive_prci_init,
> @@ -114,9 +114,9 @@ type_init(sifive_prci_register_types)
>  /*
>   * Create PRCI device.
>   */
> -DeviceState *sifive_prci_create(hwaddr addr)
> +DeviceState *sifive_e_prci_create(hwaddr addr)
>  {
> -    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_PRCI);
> +    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_E_PRCI);
>      qdev_init_nofail(dev);
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
>      return dev;
> diff --git a/include/hw/riscv/sifive_prci.h
> b/include/hw/riscv/sifive_e_prci.h
> similarity index 82%
> rename from include/hw/riscv/sifive_prci.h
> rename to include/hw/riscv/sifive_e_prci.h
> index bd51c4a..7932fe7 100644
> --- a/include/hw/riscv/sifive_prci.h
> +++ b/include/hw/riscv/sifive_e_prci.h
> @@ -1,5 +1,5 @@
>  /*
> - * QEMU SiFive PRCI (Power, Reset, Clock, Interrupt) interface
> + * QEMU SiFive E PRCI (Power, Reset, Clock, Interrupt) interface
>   *
>   * Copyright (c) 2017 SiFive, Inc.
>   *
> @@ -16,8 +16,8 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>
> -#ifndef HW_SIFIVE_PRCI_H
> -#define HW_SIFIVE_PRCI_H
> +#ifndef HW_SIFIVE_E_PRCI_H
> +#define HW_SIFIVE_E_PRCI_H
>
>  enum {
>      SIFIVE_PRCI_HFROSCCFG   = 0x0,
> @@ -47,10 +47,10 @@ enum {
>      SIFIVE_PRCI_PLLOUTDIV_DIV1  = (1 << 8)
>  };
>
> -#define TYPE_SIFIVE_PRCI "riscv.sifive.prci"
> +#define TYPE_SIFIVE_E_PRCI      "riscv.sifive.e.prci"
>
> -#define SIFIVE_PRCI(obj) \
> -    OBJECT_CHECK(SiFivePRCIState, (obj), TYPE_SIFIVE_PRCI)
> +#define SIFIVE_E_PRCI(obj) \
> +    OBJECT_CHECK(SiFivePRCIState, (obj), TYPE_SIFIVE_E_PRCI)
>
>  typedef struct SiFivePRCIState {
>      /*< private >*/
> @@ -64,6 +64,6 @@ typedef struct SiFivePRCIState {
>      uint32_t plloutdiv;
>  } SiFivePRCIState;
>
> -DeviceState *sifive_prci_create(hwaddr addr);
> +DeviceState *sifive_e_prci_create(hwaddr addr);
>
>  #endif
> --
> 2.7.4
>
>
>
