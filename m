Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15FEC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ACAF208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdV5tN+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACAF208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBBRg-0007Q4-LQ
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 01:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBBGk-0005nU-Gr
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 01:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBBGi-0004ig-VO
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 01:15:46 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:37522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iBBGi-0004iV-QN; Fri, 20 Sep 2019 01:15:44 -0400
Received: by mail-yw1-xc43.google.com with SMTP id u65so2093337ywe.4;
 Thu, 19 Sep 2019 22:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZMDiaxkvMK/3TxWhaMwsYFI0ERgO+YADfZs/rj7IjgI=;
 b=GdV5tN+EeUoIio/ODs0waRs6S5JazM+4C7t92cBIdoUtbWlKcxQ0BTw0P8GLdJ7h3s
 bMwEcnyykuiToka1k6x84Z9xiX4kiHiOZjDJTeGLG3pRZ7EfHrix/LUyYVVn/lGPSAQ3
 wAbE+2Dneo0LxXTHQh13pOwK0MTnMAhjJC+IrsOp6oXmcP0fr9lHNQk8RRwQHgA6aH6i
 ObAXVkdZJ1e1v96JolFoY9MwSZi8zLYp2IUw1L3rvweulcKBXYRRn+Ut9hvds8uTnAYQ
 ne9bwwuHDOb8jlunfeyXzRBrKdkhosAiyDRji8dPlMLyoy/yqh00HgF84AI+WZ4M1/uQ
 FNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZMDiaxkvMK/3TxWhaMwsYFI0ERgO+YADfZs/rj7IjgI=;
 b=r5412lElfWL/jS0oK5tHMGZ+5ZOqBIdKAyij5FYmSn/p7Vg7Uc8ZDD+z1UNAcG7Q0g
 dLryhn9/udTctz/69PogVTjE9+7PhqoEddWTgkYMc4UolVUSE9pgpknjC0AuOQloKSjR
 lFTtYHRpSUoiV4GsyCZm/cF4OhUQSrOnciBEncd3Rf/I+NnKMXxCJGwrgIcJzSMYt143
 Ju3a9expDq4itkhKkTB53Y8POeLUrXAPD+XctCElrX2/kntdaHYXVA+GFRYpoCCtmZYz
 jezHgcYDeNUNPErri1xoqYi6zufpBDMTfZExtHjSIXpN0HasRoLU34vXf4CrOfIviMs+
 A1kg==
X-Gm-Message-State: APjAAAWqbARHwNugefZRLJ7CTDQBYXar3CFveFiMnr6ky1ArNWsIi6TK
 7Zs3BsXStMTku4EpJraB+fRkrdtGhWcyh6yvCiA=
X-Google-Smtp-Source: APXvYqxm3v9S2ttwc07fCxyR44sPMQwhfqlcYYwiniareywAYePOVaIulHO1ufMmVL0buh5o49siFy1PW5AnVckKsgY=
X-Received: by 2002:a81:310f:: with SMTP id x15mr11048507ywx.257.1568956544244; 
 Thu, 19 Sep 2019 22:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568931866.git.alistair.francis@wdc.com>
 <24c15737b6e2b065d43955c1877ecb0e6e747351.1568931866.git.alistair.francis@wdc.com>
In-Reply-To: <24c15737b6e2b065d43955c1877ecb0e6e747351.1568931866.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 20 Sep 2019 13:15:31 +0800
Message-ID: <CAEUhbmVsPGf3QYrbpOohAH28VjRBFBjJ+2ySKrJhnQ0gfPVA-A@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] riscv/sifive_u: Add L2-LIM cache memory
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 6:32 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> On reset only a single L2 cache way is enabled, the others are exposed
> as memory that can be used by early boot firmware. This L2 region is
> generally disabled using the WayEnable register at a later stage in the
> boot process. To allow firmware to target QEMU and the HiFive Unleashed
> let's add the L2 LIM (LooselyIntegrated Memory).
>
> Ideally we would want to adjust the size of this chunk of memory as the
> L2 Cache Controller WayEnable register is incremented. Unfortunately I
> don't see a nice way to handle reducing or blocking out the L2 LIM while
> still allowing it be re returned to all enabled from a reset.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/sifive_u.c         | 15 +++++++++++++++
>  include/hw/riscv/sifive_u.h |  1 +
>  2 files changed, 16 insertions(+)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 9f8e84bf2e..de6e197882 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -65,6 +65,7 @@ static const struct MemmapEntry {
>      [SIFIVE_U_DEBUG] =    {        0x0,      0x100 },
>      [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
>      [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
> +    [SIFIVE_U_L2LIM] =    {  0x8000000,  0x1e00000 },

The size should be 0x2000000.

>      [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
>      [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
>      [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
> @@ -431,6 +432,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      const struct MemmapEntry *memmap = sifive_u_memmap;
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> +    MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
>      qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
>      char *plic_hart_config;
>      size_t plic_hart_config_len;
> @@ -459,6 +461,19 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
>                                  mask_rom);
>
> +    /* Add L2-LIM at reset size.

nits: wrong multi-line comment format

> +     * This should be reduced in size as the L2 Cache Controller WayEnable
> +     * register is incremented. Unfortunately I don't see a nice (or any) way
> +     * to handle reducing or blocking out the L2 LIM while still allowing it
> +     * be re returned to all enabled after a reset. For the time being, just
> +     * leave it enabled all the time. This won't break anything, but will be
> +     * too generous to misbehaving guests.
> +     */
> +    memory_region_init_ram(l2lim_mem, NULL, "riscv.sifive.u.l2lim",
> +                           memmap[SIFIVE_U_L2LIM].size, &error_fatal);
> +    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_L2LIM].base,
> +                                l2lim_mem);
> +
>      /* create PLIC hart topology configuration string */
>      plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) *
>                             ms->smp.cpus;
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index e4df298c23..50e3620c02 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -58,6 +58,7 @@ enum {
>      SIFIVE_U_DEBUG,
>      SIFIVE_U_MROM,
>      SIFIVE_U_CLINT,
> +    SIFIVE_U_L2LIM,
>      SIFIVE_U_PLIC,
>      SIFIVE_U_PRCI,
>      SIFIVE_U_UART0,
> --

Regards,
Bin

