Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBF8C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 20:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6427A22BE8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 20:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2LDzBZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6427A22BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr6hQ-0002i4-Hs
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 16:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58445)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hr6hF-0002Bl-7V
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 16:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hr6hE-0008LG-4J
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 16:20:09 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:45181)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hr6hA-0008CZ-Ok; Fri, 26 Jul 2019 16:20:05 -0400
Received: by mail-lf1-x143.google.com with SMTP id u10so37889636lfm.12;
 Fri, 26 Jul 2019 13:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i8GhjrgZ/1A+wzeMJutEsi+NVp4LvJ6MVmjlXTFeXPw=;
 b=i2LDzBZfGZD0YxVpQOFlr+7yfQWwRNuf9p5DpgCOzWFYbXSzs6LmPPv5T7SLWexbJy
 lbc5vUONLDEA6Dnk1fjPYYiPA45DB5lLwzxeWB3vbAmtzDofwcQzUMVvafToTnJeN0Zy
 xv7tUtdIzneYavlssRRnOuGiPBWRyjnBkJb5ClAeob07oN3bKH1756KoDPsVsaUmXwQP
 RjQYCtVXQw0eAUPtDaRuqVAbpsqQxKs5tAl/bQSJjwYdzB6Hg6WtnWotFLSaNY9NGASp
 uOPVuJXDWLdq/E8Vxa7EbYqXQurXKD+Z588Atz/l3z4mtbHqBX1Z9re+KYCIHcHaT+JE
 EhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i8GhjrgZ/1A+wzeMJutEsi+NVp4LvJ6MVmjlXTFeXPw=;
 b=ZPIEWZwHSg30H1cOHOLiwz5zsXZx59UecSo+Kb4Ry+hKVXPNyPkW2wwEF/AL4MPBOb
 oUvtA4udvylLIwGuPvjQE59yjkYdC2RXE20dCk5HMaXmYxxkWy/IX+PR1ydO82kdKv/P
 2nZM3Pu3GOz/EAfrza6YFCJWC/CgPVgDWFIwq9yyZZqRRVmFRtnrtWPTnOTc+GWKbGxP
 BoCRL1NwOAGACFHk/BgwvU5RYqLwQJIv4bPBY+0wLs/DqUnbGSiVBvEHu1crQJwxcbZr
 8/CU3aSC+dfIu1S/C0Y9Q+ZPLHsDQfR19NfsaTlnIHtRmKZ0BoEPhWSctahic/ckqZQG
 qQAg==
X-Gm-Message-State: APjAAAXkIy9uzkgF8Tlje7mbNl+C6+t+kNdJfmfBS2vV0Ukb6BAOV2iM
 HIO6wOKaFWO6xoiabbBfUNJklfJ4bvMauvwpUeA=
X-Google-Smtp-Source: APXvYqxB90UowXWnTyucmFk4E/tRWRaoR5DuZchbg2RcDVrb3/rdfEeWQrZzbFysxeDEY+/efXZdthG/TMMQADFcygo=
X-Received: by 2002:ac2:563c:: with SMTP id b28mr32403184lff.93.1564172403043; 
 Fri, 26 Jul 2019 13:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <1563543645-20804-1-git-send-email-linux@roeck-us.net>
 <1563543645-20804-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1563543645-20804-2-git-send-email-linux@roeck-us.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jul 2019 13:16:30 -0700
Message-ID: <CAKmqyKMEjj7xprsgbYkiPrZic+DQHjNpoc=2N1mzc13M1VZCwA@mail.gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH 2/3] riscv: sivive_u: Add dummy serial
 clock and aliases entry for uart
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

On Fri, Jul 19, 2019 at 6:41 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> The riscv uart needs valid clocks. This requires a refereence
> to the clock node. Since the SOC clock is not emulated by qemu,
> add a reference to a fixed clock instead. The clock-frequency
> entry in the uart node does not seem to be necessary, so drop it.
>
> In addition to a reference to the clock, the driver also needs
> an aliases entry for the serial node. Add it as well.
>
> Without this patch, the serial driver fails to instantiate with
> the following error message.
>
> sifive-serial 10013000.uart: unable to find controller clock
> sifive-serial: probe of 10013000.uart failed with error -2
>
> when trying to boot Linux.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_u.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 0657046..5a221c6 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -76,6 +76,7 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      char *nodename;
>      char ethclk_names[] = "pclk\0hclk\0tx_clk";
>      uint32_t plic_phandle, ethclk_phandle, phandle = 1;
> +    uint32_t uartclk_phandle;
>
>      fdt = s->fdt = create_device_tree(&s->fdt_size);
>      if (!fdt) {
> @@ -226,6 +227,17 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cells(fdt, nodename, "reg", 0x0);
>      g_free(nodename);
>
> +    uartclk_phandle = phandle++;
> +    nodename = g_strdup_printf("/soc/uartclk");
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "fixed-clock");
> +    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
> +    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", 3686400);
> +    qemu_fdt_setprop_cell(fdt, nodename, "phandle", uartclk_phandle);
> +    qemu_fdt_setprop_cell(fdt, nodename, "linux,phandle", uartclk_phandle);
> +    uartclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
> +    g_free(nodename);
> +
>      nodename = g_strdup_printf("/soc/uart@%lx",
>          (long)memmap[SIFIVE_U_UART0].base);
>      qemu_fdt_add_subnode(fdt, nodename);
> @@ -233,8 +245,7 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
>          0x0, memmap[SIFIVE_U_UART0].base,
>          0x0, memmap[SIFIVE_U_UART0].size);
> -    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
> -                          SIFIVE_U_CLOCK_FREQ / 2);
> +    qemu_fdt_setprop_cells(fdt, nodename, "clocks", uartclk_phandle);
>      qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle);
>      qemu_fdt_setprop_cells(fdt, nodename, "interrupts", SIFIVE_U_UART0_IRQ);
>
> @@ -243,6 +254,10 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      if (cmdline) {
>          qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
>      }
> +
> +    qemu_fdt_add_subnode(fdt, "/aliases");
> +    qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
> +
>      g_free(nodename);
>
>      return fdt;
> --
> 2.7.4
>
>

