Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC182C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E12206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAtaai/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E12206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTUcZ-0005kW-LB
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 14:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTUax-0003TT-5Z
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTUZU-0005tt-6L
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:04:34 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:43887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jTUZT-0005tg-OA; Tue, 28 Apr 2020 14:03:03 -0400
Received: by mail-io1-xd43.google.com with SMTP id 19so24080000ioz.10;
 Tue, 28 Apr 2020 11:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uu3s5aXZm1z/tpMzctzNOl49/zW6r4r/WN270b2Pon4=;
 b=jAtaai/pHIleJIGJZ+o7t42RriRobhlkgSY3At7vYknCigelmu5LCKg0tpPHZcxm0L
 ZhevH6GuItAfQ5OKxQCArF+0yfzIYm0pq8C65i/YILtFslZVolq/jGItQE893MJEmbLS
 kKjxsHiDVw8SrRwiHNMs9M+CpbDm9fpS6l0M/9MFalgEGXg28HJ6lzpV20L5+PdyVsW1
 tqAxM77ShoByEOV0NNLYyyU1pYIwRbi7/cCuOrI9Pw0ZR9hW0R9T3jjTbmhIv7WVthzi
 hltdUwgRV9lhfTX9G8RQf8E4lJvigKJIFNAMaSGfW8Zq/cXWHQpZsoqd1qhAdMj2GFEm
 zyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uu3s5aXZm1z/tpMzctzNOl49/zW6r4r/WN270b2Pon4=;
 b=iUe9EYtuDcQ71cwPWsImFc0/M/dhkXqhhXSaWnbxDwwsOFTUZ905lSQiCk5GqsCJ2h
 J1M5RD9A/H+YAEeyzoJm1B3m1TkIBwVVKvrBeVkeQgDTeTJ2wFB44gHxmn9Ye9Vj4TI1
 3fbvFd5JI5fMBAkHfgKWECnEHUGkIoD4uDHMNFDqiiFaOsW+08Mm2crZZ+FAhrE8aXHM
 DlfSQkvMYQlOqHEysAjI3mKl50r3HNBZwwyMgMxaVLwrAPSYXRl26Bt3qkPmlSkGQ8VT
 05uCxrRLVVsJU6MyvOlJMtEIg/XgoKe0HKdUM0DcQvTItaLypT+aQkiJH5PHlAi4rFnM
 Y15w==
X-Gm-Message-State: AGi0PuZcnTPDv3BMQDQjA2/FqJcxeRgHtdNYy7Czn75cdKYuPfLVPams
 0iKS0c9PhREgdPbKdO05snpy5v4QkArPW3OCQ5A=
X-Google-Smtp-Source: APiQypJ+6P9g5PxVm5dSZ/lVNYii56Cq0ctbiMIAKoCHfh8cF3udG3/kg50QSDTVhyhf86j01sh7fDDTE+E5eIJ4ZtM=
X-Received: by 2002:a5d:984b:: with SMTP id p11mr27057653ios.175.1588096982272; 
 Tue, 28 Apr 2020 11:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-11-edgar.iglesias@gmail.com>
In-Reply-To: <20200427181649.26851-11-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Apr 2020 10:54:22 -0700
Message-ID: <CAKmqyKMoomzGq6_ZRLr2Cm6Tuz8EMWnDyX_V1Enj_Hp4wOV4jQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] hw/arm: versal-virt: Add support for SD
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 11:25 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add support for SD.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> --
> 2.20.1
>
>

