Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8FDC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E4D20787
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="GEmdCS2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E4D20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThqB-0002rA-48
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:13:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jThlM-00054F-C5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jThiJ-0003XK-DT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:08:12 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:59162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jThbX-0001H1-56; Wed, 29 Apr 2020 03:58:03 -0400
Received: from [172.17.10.6] (unknown [172.17.10.6])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 3220196EF0;
 Wed, 29 Apr 2020 07:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1588147080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSrXzddqDgKI0K/JpB3wIhCVtkikOq/WAV+67S0rIWI=;
 b=GEmdCS2TNOsnkIO2JC8jaPgdarqalux+mibdJ/j3qk9NKI/jo5nGpdiOeNV+45a5L7bzT9
 X4ElwCf0QOUFqX8EonH5tNC9akMGZpEN0KLlQN1k7MRg/KT7EcHIRZsswyfi1cdfB5jBPC
 fvBN3q+DjKkxV7h5y4jGDLJpuewB0iA=
Subject: Re: [PATCH v1 11/11] hw/arm: versal-virt: Add support for the RTC
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-12-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <83a60c58-c549-0a88-0ad8-66dbaea69d33@greensocs.com>
Date: Wed, 29 Apr 2020 09:57:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427181649.26851-12-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1588147080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSrXzddqDgKI0K/JpB3wIhCVtkikOq/WAV+67S0rIWI=;
 b=6uSXSEI7UC8RcGJRSi1DRJ1uNdg8XUdAlCeSdd/3GGP3KxF3NDOjatRQ8FFTFqGjtQHWEN
 DOKg29ExOeie6ilsCRonR66LxGSKtFFIkeedBc5C+guYYQ08cOdh+m67KeGuyvRFldDoME
 ISrXElW/U9AR+9srKxIjOH4ejdi5OkA=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1588147080; a=rsa-sha256; cv=none;
 b=5rT5HNTUhO6VQ2WmyYOjDm+w5njrsLPgz8f5AuuiIwLHgtBMqbBUI8CV/O5rgQN0ndbwGS
 3tIi4N/oQILkfWkWvY306mNpP5Gb9UAANXkTiBUia6vZOSK0lw+djCcsy8l1Y8YhBhZScP
 zuSSaxUqHWLjNd22lYPrKMSg7Vbx7nk=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 03:23:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 5.135.226.135
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
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 8:16 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add support for the RTC.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/xlnx-versal-virt.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 0afee48672..7e749e1926 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -283,6 +283,27 @@ static void fdt_add_sd_nodes(VersalVirt *s)
>      }
>  }
>  
> +static void fdt_add_rtc_node(VersalVirt *s)
> +{
> +    const char compat[] = "xlnx,zynqmp-rtc";
> +    const char interrupt_names[] = "alarm\0sec";
> +    char *name = g_strdup_printf("/rtc@%x", MM_PMC_RTC);
> +
> +    qemu_fdt_add_subnode(s->fdt, name);
> +
> +    qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> +                           GIC_FDT_IRQ_TYPE_SPI, VERSAL_RTC_ALARM_IRQ,
> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI,
> +                           GIC_FDT_IRQ_TYPE_SPI, VERSAL_RTC_SECONDS_IRQ,
> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +    qemu_fdt_setprop(s->fdt, name, "interrupt-names",
> +                     interrupt_names, sizeof(interrupt_names));
> +    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> +                                 2, MM_PMC_RTC, 2, MM_PMC_RTC_SIZE);
> +    qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
> +    g_free(name);
> +}
> +
>  static void fdt_nop_memory_nodes(void *fdt, Error **errp)
>  {
>      Error *err = NULL;
> @@ -496,6 +517,7 @@ static void versal_virt_init(MachineState *machine)
>      fdt_add_timer_nodes(s);
>      fdt_add_zdma_nodes(s);
>      fdt_add_sd_nodes(s);
> +    fdt_add_rtc_node(s);
>      fdt_add_cpu_nodes(s, psci_conduit);
>      fdt_add_clk_node(s, "/clk125", 125000000, s->phandle.clk_125Mhz);
>      fdt_add_clk_node(s, "/clk25", 25000000, s->phandle.clk_25Mhz);
> 

