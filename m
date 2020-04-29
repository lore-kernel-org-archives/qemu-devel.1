Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9879C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A416B206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="ylsOsKkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A416B206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThNj-0001ad-MO
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jThJK-0003VS-KK
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jThJ5-0004Ki-TG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:39:14 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:58120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jThGN-0001yq-7h; Wed, 29 Apr 2020 03:36:11 -0400
Received: from [172.17.10.6] (unknown [172.17.10.6])
 by beetle.greensocs.com (Postfix) with ESMTPSA id A1C2096EF2;
 Wed, 29 Apr 2020 07:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1588145769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzhevfxjE6BknwcVZueUscmT1UamdlbbHVzaCvbbbdE=;
 b=ylsOsKkBDpNYTInJ2+G6Tvmb3o+YYvM/ZCJ0jjr143R209MbMAYzxc3uzxnizAprDFUJsK
 3DLMUa+4AaZH/r7hHUhuRxPj+p/doU1ARFft23rqN03q6g2QBF6zkoxqFBzpqj4/P0SMfw
 3OMb9P/qAzow4NOatDmhZbtVXugZ3d8=
Subject: Re: [PATCH v1 10/11] hw/arm: versal-virt: Add support for SD
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-11-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <8a3fa218-f92c-5e99-701e-b6f37b532ef0@greensocs.com>
Date: Wed, 29 Apr 2020 09:36:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427181649.26851-11-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1588145769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzhevfxjE6BknwcVZueUscmT1UamdlbbHVzaCvbbbdE=;
 b=Blqi+/IK6zKXrIye3xUPhdpruzMl8sel+Jr/0UgxfjhcC9e1OvxaeWsu415Q2DjOlQkUJE
 7uWNW7GGEwzaU6he1EyVxihS5b3/pK/LC9lzn6+m/8BCg1rRvoQP6J8hozRMlZjk30Bo72
 aT8RXRrZs/Uf2wI0iySTeQ7YkZi0SkA=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1588145769; a=rsa-sha256; cv=none;
 b=4HfhGo9z02s3pkWxM+kzDKbCC2xfplRv90wn6KFFyw/JoVsXJi4D8qoL5ey5HMU3yKCBcD
 og2QizvmnTCZy+nbjcMRC3uk7Q0FCFX8/LtQ4OtMo/I0S4UpRgr79NpFliFfFhhxG5ejHe
 2BOnQ7bhAjZVm2WMMkEM13Q4xyp1x3M=
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
> Add support for SD.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/xlnx-versal-virt.c | 46 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index d7be1ad494..0afee48672 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -20,6 +20,7 @@
>  #include "hw/arm/sysbus-fdt.h"
>  #include "hw/arm/fdt.h"
>  #include "cpu.h"
> +#include "hw/qdev-properties.h"
>  #include "hw/arm/xlnx-versal.h"
>  
>  #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("xlnx-versal-virt")
> @@ -256,6 +257,32 @@ static void fdt_add_zdma_nodes(VersalVirt *s)
>      }
>  }
>  
> +static void fdt_add_sd_nodes(VersalVirt *s)
> +{
> +    const char clocknames[] = "clk_xin\0clk_ahb";
> +    const char compat[] = "arasan,sdhci-8.9a";
> +    int i;
> +
> +    for (i = ARRAY_SIZE(s->soc.pmc.iou.sd) - 1; i >= 0; i--) {
> +        uint64_t addr = MM_PMC_SD0 + MM_PMC_SD0_SIZE * i;
> +        char *name = g_strdup_printf("/sdhci@%" PRIx64, addr);
> +
> +        qemu_fdt_add_subnode(s->fdt, name);
> +
> +        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
> +                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
> +        qemu_fdt_setprop(s->fdt, name, "clock-names",
> +                         clocknames, sizeof(clocknames));
> +        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> +                               GIC_FDT_IRQ_TYPE_SPI, VERSAL_SD0_IRQ_0 + i * 2,
> +                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> +                                     2, addr, 2, MM_PMC_SD0_SIZE);
> +        qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
> +        g_free(name);
> +    }
> +}
> +
>  static void fdt_nop_memory_nodes(void *fdt, Error **errp)
>  {
>      Error *err = NULL;
> @@ -411,10 +438,23 @@ static void create_virtio_regions(VersalVirt *s)
>      }
>  }
>  
> +static void sd_plugin_card(SDHCIState *sd, DriveInfo *di)
> +{
> +    BlockBackend *blk = di ? blk_by_legacy_dinfo(di) : NULL;
> +    DeviceState *card;
> +
> +    card = qdev_create(qdev_get_child_bus(DEVICE(sd), "sd-bus"), TYPE_SD_CARD);
> +    object_property_add_child(OBJECT(sd), "card[*]", OBJECT(card),
> +                              &error_fatal);
> +    qdev_prop_set_drive(card, "drive", blk, &error_fatal);
> +    object_property_set_bool(OBJECT(card), true, "realized", &error_fatal);
> +}
> +
>  static void versal_virt_init(MachineState *machine)
>  {
>      VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(machine);
>      int psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
> +    int i;
>  
>      /*
>       * If the user provides an Operating System to be loaded, we expect them
> @@ -455,6 +495,7 @@ static void versal_virt_init(MachineState *machine)
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
>      fdt_add_zdma_nodes(s);
> +    fdt_add_sd_nodes(s);
>      fdt_add_cpu_nodes(s, psci_conduit);
>      fdt_add_clk_node(s, "/clk125", 125000000, s->phandle.clk_125Mhz);
>      fdt_add_clk_node(s, "/clk25", 25000000, s->phandle.clk_25Mhz);
> @@ -464,6 +505,11 @@ static void versal_virt_init(MachineState *machine)
>      memory_region_add_subregion_overlap(get_system_memory(),
>                                          0, &s->soc.fpd.apu.mr, 0);
>  
> +    /* Plugin SD cards.  */
> +    for (i = 0; i < ARRAY_SIZE(s->soc.pmc.iou.sd); i++) {
> +        sd_plugin_card(&s->soc.pmc.iou.sd[i], drive_get_next(IF_SD));
> +    }
> +
>      s->binfo.ram_size = machine->ram_size;
>      s->binfo.loader_start = 0x0;
>      s->binfo.get_dtb = versal_virt_get_dtb;
> 

