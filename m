Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472BAC4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1004D24672
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIi5yvWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1004D24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Fnm-0000zg-4w
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frasse.iglesias@gmail.com>) id 1j7FmZ-0008Iy-T6
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:48:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1j7FmY-0006oD-Qb
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:48:39 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:37770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1j7FmY-0006kH-Iw; Thu, 27 Feb 2020 04:48:38 -0500
Received: by mail-lj1-x244.google.com with SMTP id q23so2629835ljm.4;
 Thu, 27 Feb 2020 01:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=sovmJqWLi+w6r7aj57g8jsX5oYThDt/U4Hfb0qHizf8=;
 b=TIi5yvWlZrkUEh6NGhCRcrYQadVDjEtPdZv0emlKyp2WB13hFDmYP9QZLZYzRoEK9o
 WipxuxeELa5IB5J7+JyqU6FqFRDcopAV2n4Ayc1Apppyoy0/m66sGvYWLEJ7QWumtmWe
 4fsELxPKVxum1KOzksdAm/nnaPkBQC0WbJmys4pOtkWSVXTgGz63drt3vYaq7Aola2xp
 5i1+aP0hPENrb/FXH46VImzDvg2Hfb5uLMQblHoUbehJpcKSvF1indaBXPGsjc0VfZQu
 +IfjXdZg/aWWyTsa2qJLMb2BLpKtq84w3oNrVPTT6C6yco+SejSuxNSDJfIRyBMM7aRX
 13Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=sovmJqWLi+w6r7aj57g8jsX5oYThDt/U4Hfb0qHizf8=;
 b=PMluU2ay82mh1EHfB5vy4r6JFL/yT636mIRvkv6sqydeKG4YpTXMbCV4WtlULfIXot
 lhiTbVzN0mBFOn1f2OGA8FwzP7XxrP0cAwdTGWyYGmpyyZk9Cr5XLVUOuuhQi0xY9Ebr
 YZVkqK4jD57/i8D1HExGEvuX/wbpIY7tUvzAEFVLLm6p0b/dBmmy9MRYRVwsNw7sk9yC
 plqIRhXkn3AM+w/PsyH+TW+pBGwEcoep3kmrEnnXaL7KfqVCRGs44k70x9/POywZXlcG
 9CHqbrGcQLNOL+gSSYFV44IdBUHq+wEMINqV5NHhmzGm5NZD0c3Bzyc40u4fQgXUw6Dk
 CA3A==
X-Gm-Message-State: ANhLgQ2lk3BGjiv9ywtdyWjSQeqLVBDc2KZMgxSINag5xIN/u0uB/tZy
 WlJD4/PdiVecN1PdlvTmRx9oDiowfSw=
X-Google-Smtp-Source: ADFU+vs+6Vy/M+WkngVbUxY27EwKeu/RILozshk9AYRGvWqQTn1qYk0x+kJ8ZF4fzXcTvZSeV9vE+A==
X-Received: by 2002:a2e:7c08:: with SMTP id x8mr2231141ljc.185.1582796915972; 
 Thu, 27 Feb 2020 01:48:35 -0800 (PST)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 c203sm2464108lfg.28.2020.02.27.01.48.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 27 Feb 2020 01:48:35 -0800 (PST)
Date: Thu, 27 Feb 2020 10:48:33 +0100
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v1 2/2] hw/arm: versal: Generate xlnx-versal-virt zdma
 FDT nodes
Message-ID: <20200227094832.mzigobojdqrw6hv7@fralle-msi>
References: <20200227154424.6849-1-edgar.iglesias@gmail.com>
 <20200227154424.6849-3-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227154424.6849-3-edgar.iglesias@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com, alistair@alistair23.me,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On [2020 Feb 27] Thu 16:44:24, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Generate xlnx-versal-virt zdma FDT nodes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/arm/xlnx-versal-virt.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index e7f4ca8bf9..878a275140 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -229,6 +229,33 @@ static void fdt_add_gem_nodes(VersalVirt *s)
>      }
>  }
>  
> +static void fdt_add_zdma_nodes(VersalVirt *s)
> +{
> +    const char clocknames[] = "clk_main\0clk_apb";
> +    const char compat[] = "xlnx,zynqmp-dma-1.0";
> +    int i;
> +
> +    for (i = XLNX_VERSAL_NR_ADMAS - 1; i >= 0; i--) {
> +        uint64_t addr = MM_ADMA_CH0 + MM_ADMA_CH0_SIZE * i;
> +        char *name = g_strdup_printf("/dma@%" PRIx64, addr);
> +
> +        qemu_fdt_add_subnode(s->fdt, name);
> +
> +        qemu_fdt_setprop_cell(s->fdt, name, "xlnx,bus-width", 64);
> +        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
> +                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
> +        qemu_fdt_setprop(s->fdt, name, "clock-names",
> +                         clocknames, sizeof(clocknames));
> +        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> +                               GIC_FDT_IRQ_TYPE_SPI, VERSAL_ADMA_IRQ_0 + i,
> +                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> +                                     2, addr, 2, 0x1000);
> +        qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
> +        g_free(name);
> +    }
> +}
> +
>  static void fdt_nop_memory_nodes(void *fdt, Error **errp)
>  {
>      Error *err = NULL;
> @@ -427,6 +454,7 @@ static void versal_virt_init(MachineState *machine)
>      fdt_add_uart_nodes(s);
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
> +    fdt_add_zdma_nodes(s);
>      fdt_add_cpu_nodes(s, psci_conduit);
>      fdt_add_clk_node(s, "/clk125", 125000000, s->phandle.clk_125Mhz);
>      fdt_add_clk_node(s, "/clk25", 25000000, s->phandle.clk_25Mhz);
> -- 
> 2.20.1
> 

