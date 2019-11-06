Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F342AC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B561E2173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="neFhVUZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B561E2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJqN-0007yZ-UQ
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anup@brainfault.org>) id 1iSJnE-0004u2-0p
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anup@brainfault.org>) id 1iSJnC-00009j-K0
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:48:07 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53711)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anup@brainfault.org>) id 1iSJnC-00009D-9o
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:48:06 -0500
Received: by mail-wm1-x343.google.com with SMTP id x4so3006586wmi.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WoJWC5LTv9yoYodFK6TMZmiav5ViLBLLuzbTWdGWz14=;
 b=neFhVUZg0lm90fNhLzcALmxVSX0r4hTrLTLRDIdnYhAxw4h+u95vhI8H2C03nK5YLK
 LN7rbMHf/ZVtt81VkCUPvLEhmCsxliDtToNCCus1drjbMvtI6s1G+Ssk+YkVx2LqOY4B
 /JkbrUEbS6Mc2UIWBrxopHsKdXs5oixaiflERa1rcXDUHAPIl/XgUUjw1IvtJTNyvf+X
 6vFORa6UeKsqKGr2mB72WTN62yLBlinUKIWtat2mFOKG7/uK0pXBCXwitZXc4+ntbdYU
 cO2iNgq9Tg74076FMvOitD7sl3VlFKn+ouJYAXZyFLS6Po9pNLSpcX2HH1Mfww0BKdo/
 IxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WoJWC5LTv9yoYodFK6TMZmiav5ViLBLLuzbTWdGWz14=;
 b=qGHc6jzuwA64a5JXJDhcw7zkfXm92x1mEC1PSfYSB1h+r7HYKbpmdARMEtf/rD+qQ5
 Xc3SG4OLDeuZak0u6L18kzdSpCJaUjqC/sar0BAS8FLVctnlhll4zkPhHcGctumBSE1O
 5AmDe8U9C13xx7dI7CYAqbZNWfrGxhVAyeTuwdHqc8dpFu4H0mxherOp89pIj7SMC4+J
 vFKjnIbAp1fc9vLe4tcYvuuwKv7tG/wZkvAjgi9puEHD96nsbQhfzlyHEFWjOWV5Xe6X
 pAvKPDnvzjNP+YFzXBF8jq2l31QsjU2esjvVcBoRsfl8hTwTvaZj/qbI+sSUjNB99KOi
 bZbA==
X-Gm-Message-State: APjAAAXQV/QLCJ7UjayM8XlzT84m5YZy1hxGoH86eeDG1OrNI1Ds+pC9
 4cu3FJ+OlymL7PvUrieMskVWTj+26qYvLkXEJuAB9Q==
X-Google-Smtp-Source: APXvYqw48/rC1X6oaGN9eu92tgMTCocnVfcBth3Q+Fiw0DMPPPowjFMhO7jbZGURD95hzXwOOIMuwAdLYokMXS3aIHk=
X-Received: by 2002:a1c:9a4f:: with SMTP id c76mr2116983wme.103.1573040884665; 
 Wed, 06 Nov 2019 03:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20191106083444.41113-1-anup.patel@wdc.com>
 <20191106083444.41113-3-anup.patel@wdc.com>
In-Reply-To: <20191106083444.41113-3-anup.patel@wdc.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 6 Nov 2019 17:17:53 +0530
Message-ID: <CAAhSdy1LG8t7mETn8dqqBURf5QwuEiD7expuU7p-bAcKrqUewg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] riscv: virt: Use Goldfish RTC device
To: Anup Patel <Anup.Patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 6, 2019 at 2:05 PM Anup Patel <Anup.Patel@wdc.com> wrote:
>
> We extend QEMU RISC-V virt machine by adding Goldfish RTC device
> to it. This will allow Guest Linux to sync it's local date/time
> with Host date/time via RTC device.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Acked-by: Palmer Dabbelt <palmer@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/Kconfig        |  1 +
>  hw/riscv/virt.c         | 15 +++++++++++++++
>  include/hw/riscv/virt.h |  2 ++
>  3 files changed, 18 insertions(+)
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index b12660b9f8..ff9fbe958a 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -34,6 +34,7 @@ config RISCV_VIRT
>      select PCI
>      select HART
>      select SERIAL
> +    select GOLDFISH_RTC
>      select VIRTIO_MMIO
>      select PCI_EXPRESS_GENERIC_BRIDGE
>      select PFLASH_CFI01
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index cc8f311e6b..818678a4b2 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -58,6 +58,7 @@ static const struct MemmapEntry {
>      [VIRT_DEBUG] =       {        0x0,         0x100 },
>      [VIRT_MROM] =        {     0x1000,       0x11000 },
>      [VIRT_TEST] =        {   0x100000,        0x1000 },
> +    [VIRT_RTC] =         {   0x101000,        0x1000 },
>      [VIRT_CLINT] =       {  0x2000000,       0x10000 },
>      [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
>      [VIRT_UART0] =       { 0x10000000,         0x100 },
> @@ -376,6 +377,17 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
>      qemu_fdt_setprop_cell(fdt, nodename, "interrupts", UART0_IRQ);
>
> +    nodename = g_strdup_printf("/rtc@%lx",
> +        (long)memmap[VIRT_RTC].base);
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible",
> +        "google,goldfish-rtc");
> +    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> +        0x0, memmap[VIRT_RTC].base,
> +        0x0, memmap[VIRT_RTC].size);
> +    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
> +    qemu_fdt_setprop_cell(fdt, nodename, "interrupts", RTC_IRQ);
> +

We cannot create RTC node here because "nodename" is directly
used as "stdout-path" below. Due to this patch, U-Boot S-mode
stops working on QEMU because it see incorrect "stdout-path".

I will quickly send updated v8 series.

>      qemu_fdt_add_subnode(fdt, "/chosen");
>      qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
>      if (cmdline) {
> @@ -579,6 +591,9 @@ static void riscv_virt_board_init(MachineState *machine)
>          0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
>          serial_hd(0), DEVICE_LITTLE_ENDIAN);
>
> +    sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
> +        qdev_get_gpio_in(DEVICE(s->plic), RTC_IRQ));
> +
>      virt_flash_create(s);
>
>      for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index b17048a93a..e69355efaf 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -44,6 +44,7 @@ enum {
>      VIRT_DEBUG,
>      VIRT_MROM,
>      VIRT_TEST,
> +    VIRT_RTC,
>      VIRT_CLINT,
>      VIRT_PLIC,
>      VIRT_UART0,
> @@ -57,6 +58,7 @@ enum {
>
>  enum {
>      UART0_IRQ = 10,
> +    RTC_IRQ = 11,
>      VIRTIO_IRQ = 1, /* 1 to 8 */
>      VIRTIO_COUNT = 8,
>      PCIE_IRQ = 0x20, /* 32 to 35 */
> --
> 2.17.1
>

Regards,
Anup

