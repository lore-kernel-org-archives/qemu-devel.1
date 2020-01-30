Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B41C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5089E20674
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHqkS6Cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5089E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixBx0-0001ra-I5
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 10:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ixBwQ-0001Ob-E6
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ixBwP-00039I-5A
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:41:14 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ixBwO-00036C-T1
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:41:13 -0500
Received: by mail-wr1-x444.google.com with SMTP id z7so4548599wrl.13
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 07:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=TqdxCq8HJGFxkopVlfL9vKt9zf5Mhvk+4P/TZ0pMgsk=;
 b=vHqkS6CvPiPCADFLG5wYwBKsU1JwngycIB2w6bLzvBG8kR8o2KmA1uAMENy+f/OBqa
 2BTujHzzDsy81xoh1dRQ9wBas+kR4GOXddukFBrS56YjyhGkXSGGd/Usfuamvd97Ya2V
 xnxz8broO4bWc+ZS5e8M6T2mIjYsHGj07Q0i9QLU8jt9PNJfOVVRfCrY1Tya1Ox5ZgEx
 oOq2jGMaEp2MdRCKv7yvhRzwzEMJ3ofDfuc34pyvzhGX4MpQVd2nmVvWbT6yXboReGA1
 K8hSwfXbAyXZkUU1mOW96BOo4YR0zx48kkZ8w1PqSHvEnawJ3w68e6tRay0ZOx6lFqb1
 aQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=TqdxCq8HJGFxkopVlfL9vKt9zf5Mhvk+4P/TZ0pMgsk=;
 b=U8m79K4xMZHJvNmDMFDTdwDZRo900ybMuTYzBG8jk0MX8AZ4eEcF+fnNgey7vj1JyH
 +otTpffl6beQNhjTWZuAzer7FHfNYgk4nR6E/LzcTRy48Z9ZU93nmUyPTTBBbnzrXKzB
 ZXj5VLHCgso9yIsmdwDwupx5dzz/dIr34qN1SrsmSYLppssaVOxz//UzS/8uvYdqGuVn
 Jn1wg2VUDJtFhqCa92xAXbE1lHir+bE1aP0d7kuZKvvpAX8pycGO1nzzdbEBm25MzSXI
 /hQ+g9PX9QT/vuynZ0s2PGxxQ3g5TQ7tZ/hOt4P2CKSurn6ic9lMIVlHRmYx2Bhmpsmx
 ldow==
X-Gm-Message-State: APjAAAU4lc4xTQ8lMqfyRBQIIZj02IcHYmFx3lBSi9blikyfbjN/eST8
 r7E+kN/4vNW5aDt7KdlB8o5+Ug==
X-Google-Smtp-Source: APXvYqzkdFR2SNwoPiw3hmoOFyHK5/2ot3Xw2xyHO5tnq9Jh1DRSqkjlV09XQ6dPrQOBYoF7r4zJTQ==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr6127174wrp.171.1580398871123; 
 Thu, 30 Jan 2020 07:41:11 -0800 (PST)
Received: from localhost ([2a00:79e0:d:11:1da2:3fd4:a302:4fff])
 by smtp.gmail.com with ESMTPSA id s8sm2667347wmf.45.2020.01.30.07.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 07:41:10 -0800 (PST)
Date: Thu, 30 Jan 2020 07:41:10 -0800 (PST)
X-Google-Original-Date: Thu, 30 Jan 2020 15:13:27 GMT (+0000)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v2] riscv/virt: Add syscon reboot and poweroff DT nodes
CC: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, sagark@eecs.berkeley.edu,
 Atish Patra <Atish.Patra@wdc.com>, 
 Christoph Hellwig <hch@lst.de>, anup@brainfault.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Anup Patel <Anup.Patel@wdc.com>
To: Anup Patel <Anup.Patel@wdc.com>
In-Reply-To: <20200122131641.34953-1-anup.patel@wdc.com>
References: <20200122131641.34953-1-anup.patel@wdc.com>
Message-ID: <mhng-dab9223a-0a91-4196-809e-2b6e6e2bce28@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Jan 2020 13:17:23 GMT (+0000), Anup Patel wrote:
> The SiFive test device found on virt machine can be used by
> generic syscon reboot and poweroff drivers available in Linux
> kernel.
>
> This patch updates FDT generation in virt machine so that
> Linux kernel can probe and use generic syscon drivers.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
> Changes since v1:
>  - Rebased on latest QEMU master commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd40
> ---
>  hw/riscv/virt.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index c44b865959..6d682f8a78 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -182,11 +182,10 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      uint64_t mem_size, const char *cmdline)
>  {
>      void *fdt;
> -    int cpu;
> +    int cpu, i;
>      uint32_t *cells;
>      char *nodename;
> -    uint32_t plic_phandle, phandle = 1;
> -    int i;
> +    uint32_t plic_phandle, test_phandle, phandle = 1;
>      hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
>      hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
>  
> @@ -356,16 +355,35 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      create_pcie_irq_map(fdt, nodename, plic_phandle);
>      g_free(nodename);
>  
> +    test_phandle = phandle++;
>      nodename = g_strdup_printf("/test@%lx",
>          (long)memmap[VIRT_TEST].base);
>      qemu_fdt_add_subnode(fdt, nodename);
>      {
> -        const char compat[] = "sifive,test1\0sifive,test0";
> +        const char compat[] = "sifive,test1\0sifive,test0\0syscon";
>          qemu_fdt_setprop(fdt, nodename, "compatible", compat, sizeof(compat));
>      }
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
>          0x0, memmap[VIRT_TEST].base,
>          0x0, memmap[VIRT_TEST].size);
> +    qemu_fdt_setprop_cell(fdt, nodename, "phandle", test_phandle);
> +    test_phandle = qemu_fdt_get_phandle(fdt, nodename);
> +    g_free(nodename);
> +
> +    nodename = g_strdup_printf("/reboot");
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-reboot");
> +    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_phandle);
> +    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
> +    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_RESET);
> +    g_free(nodename);
> +
> +    nodename = g_strdup_printf("/poweroff");
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-poweroff");
> +    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_phandle);
> +    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
> +    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_PASS);
>      g_free(nodename);
>  
>      nodename = g_strdup_printf("/uart@%lx",

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks, I've queued this up for master.  I'm still hoping to get the H
extension stuff in as part of my next PR, but if that gets blocked again then
I'll send this up before then.  I'd like to get it in sooner rather than later
so we can do the Linux side of things.

