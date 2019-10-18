Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED36CA9EAB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006BA21897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="N7Z6REbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006BA21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLXOJ-0003Bn-1X
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iLXMq-000277-3k
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iLXMn-0004hB-Q3
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:52:51 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iLXMn-0004gd-KG
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:52:49 -0400
Received: by mail-pl1-x642.google.com with SMTP id g9so1957029plj.9
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=W4Q0p1F6snvYjb87ZNe382tMj7ucDM+3QvJeNbsWbhw=;
 b=N7Z6REbQX44f8ZWrrVsgVVI7LqCYO0wcf6LSfWN8j0okpr9uP5R1vA81F09n0zzS4H
 bCG4Nxl5EHzfrufWR6UB1Rtcv7DY90lHbbyxwKnaCdnczP2LRieW0KJn9uNjGs3Cn/IL
 C7TdEc+t44PF03xe2SSVr9EMM7CCmSwI3lKjAPpGwpvUg14DrpSVZVQd4ruEFOzrqzFt
 43goQsUc+ikKwt3d1fS337y0+t+zqQcZVtoxSh19wsL15xEjFgJetbVRNVQPcgGHb35G
 pQ7z3PZlkFR2wfBrZx/ze5hSpnEsUKIdqt3zTSL2U3qmRA3E6cEbX2v4t+/lgiJYfkOl
 tR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=W4Q0p1F6snvYjb87ZNe382tMj7ucDM+3QvJeNbsWbhw=;
 b=f7YOkbCc61g81cPc2a3NUOEpTmH/g7KzhOmPz+vgXHwFdE9V8EIT0vGhjb3Yp8KLa9
 raitfpAiBh6kHO6kXRJQQInD7rW6sTYm336UQMouQ9EA0pXlp0X7OA0MGGcFKixxavB5
 FZHH7POs/UqfbSGPySxg90slQv6AnjvxBBzsGxfcnu6UL+r4cuWomD0ipk5DzGuZM4Pn
 pMlB5+TzB7zrHfRa9Xo+Y8SvTVQvwe0kHchAPFJDW5jVv5k3hlWp6YUKH5C4fDW1nxVP
 u7vY/301pdXEg/h3V+oP6g3UWHSwfyDEVTm+xRrsMRHTVGCDRR47XJBJ2pawnrbK8CuB
 Xcxg==
X-Gm-Message-State: APjAAAUFVcAixIBwIm4xBl1eIMAomtd34xaFQtgenisVc2AifZmaK0Vu
 l18Mshi7+DPQTm/ZeMnNnwqUaw==
X-Google-Smtp-Source: APXvYqx3ZIKFccun5sB0Si0er8w0Os/S5tIyjXyDxb/gT2jYElJpvhQsPpTaZPoKRSoAZKRn2zt8+w==
X-Received: by 2002:a17:902:8d84:: with SMTP id
 v4mr11645507plo.220.1571424768583; 
 Fri, 18 Oct 2019 11:52:48 -0700 (PDT)
Received: from localhost ([152.179.112.46])
 by smtp.gmail.com with ESMTPSA id v9sm6893015pfe.109.2019.10.18.11.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 11:52:47 -0700 (PDT)
Date: Fri, 18 Oct 2019 11:52:47 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Oct 2019 11:51:08 PDT (-0700)
Subject: Re: [PATCH v3 2/2] riscv: virt: Use Goldfish RTC device
In-Reply-To: <20191015083459.76959-3-anup.patel@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-b8dad426-0e7a-4e79-9a2f-b0e6eaf42cdb@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 sagark@eecs.berkeley.edu, anup@brainfault.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Oct 2019 01:35:42 PDT (-0700), Anup Patel wrote:
> We extend QEMU RISC-V virt machine by adding Goldfish RTC device
> to it. This will allow Guest Linux to sync it's local date/time
> with Host date/time via RTC device.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  hw/riscv/Kconfig        |  1 +
>  hw/riscv/virt.c         | 15 +++++++++++++++
>  include/hw/riscv/virt.h |  2 ++
>  3 files changed, 18 insertions(+)
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index fb19b2df3a..b33753c780 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -34,6 +34,7 @@ config RISCV_VIRT
>      select PCI
>      select HART
>      select SERIAL
> +    select GOLDFISH_RTC
>      select VIRTIO_MMIO
>      select PCI_EXPRESS_GENERIC_BRIDGE
>      select SIFIVE
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d36f5625ec..95c42ab993 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -57,6 +57,7 @@ static const struct MemmapEntry {
>      [VIRT_DEBUG] =       {        0x0,         0x100 },
>      [VIRT_MROM] =        {     0x1000,       0x11000 },
>      [VIRT_TEST] =        {   0x100000,        0x1000 },
> +    [VIRT_RTC] =         {   0x101000,        0x1000 },
>      [VIRT_CLINT] =       {  0x2000000,       0x10000 },
>      [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
>      [VIRT_UART0] =       { 0x10000000,         0x100 },
> @@ -310,6 +311,17 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
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
>      qemu_fdt_add_subnode(fdt, "/chosen");
>      qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
>      if (cmdline) {
> @@ -496,6 +508,9 @@ static void riscv_virt_board_init(MachineState *machine)
>          0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
>          serial_hd(0), DEVICE_LITTLE_ENDIAN);
>  
> +    sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
> +        qdev_get_gpio_in(DEVICE(s->plic), RTC_IRQ));
> +
>      g_free(plic_hart_config);
>  }
>  
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 6e5fbe5d3b..e6423258d3 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -37,6 +37,7 @@ enum {
>      VIRT_DEBUG,
>      VIRT_MROM,
>      VIRT_TEST,
> +    VIRT_RTC,
>      VIRT_CLINT,
>      VIRT_PLIC,
>      VIRT_UART0,
> @@ -49,6 +50,7 @@ enum {
>  
>  enum {
>      UART0_IRQ = 10,
> +    RTC_IRQ = 11,
>      VIRTIO_IRQ = 1, /* 1 to 8 */
>      VIRTIO_COUNT = 8,
>      PCIE_IRQ = 0x20, /* 32 to 35 */

This is a wacky enum, but it's already there.  I'm going to assume this patch 
will get merged and then fix it later.

> -- 
> 2.17.1

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Acked-by: Palmer Dabbelt <palmer@sifive.com>

I think it's easier to just keep this with the goldfish implementation.  I'm 
assuming that will go in through a different tree, as per my comments on that 
patch.

