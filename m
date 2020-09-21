Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257AAC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697D720BED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyz2BMMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697D720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKI5L-0003eB-9X
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 05:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKI4d-00039p-4x
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKI4b-0000wP-AX
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600680324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gpfHcTNgr2JhEmkpAE2KDrUzkB6fU6zQgrW+S2qvNgQ=;
 b=hyz2BMMYzlV7GYmoziBlC70ngxqOF4n4IJoPDo11o8WlZhioydOiuyYbT1NjB8cu6S1MzN
 1NHSwePAoXbrBiO/LAuLu+xWWLav2s7Ja+hrbnG+Iyy6V8f2qD6Zovn2CfiflRNh18yE0U
 ux/JYmt5/k8+615nTqm1UvbmqHkYU3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-F1jYJVgTPgqkL1n5xMdS7A-1; Mon, 21 Sep 2020 05:25:22 -0400
X-MC-Unique: F1jYJVgTPgqkL1n5xMdS7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E76F1005E5B;
 Mon, 21 Sep 2020 09:25:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D92455768;
 Mon, 21 Sep 2020 09:25:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AB3111132E9A; Mon, 21 Sep 2020 11:25:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 4/6] sparc32-ledma: don't reference nd_table directly
 within the device
References: <20200920082018.16135-1-mark.cave-ayland@ilande.co.uk>
 <20200920082018.16135-5-mark.cave-ayland@ilande.co.uk>
Date: Mon, 21 Sep 2020 11:25:18 +0200
In-Reply-To: <20200920082018.16135-5-mark.cave-ayland@ilande.co.uk> (Mark
 Cave-Ayland's message of "Sun, 20 Sep 2020 09:20:16 +0100")
Message-ID: <87imc78osh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, atar4qemu@gmail.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> Instead use qdev_set_nic_properties() to configure the on-board NIC at the
> sun4m machine level.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/dma/sparc32_dma.c |  5 -----
>  hw/sparc/sun4m.c     | 21 +++++++++++++--------
>  2 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index 2cbe331959..b643b413c5 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -342,12 +342,7 @@ static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
>  {
>      LEDMADeviceState *s = SPARC32_LEDMA_DEVICE(dev);
>      SysBusPCNetState *lance = SYSBUS_PCNET(&s->lance);
> -    NICInfo *nd = &nd_table[0];
>  
> -    /* FIXME use qdev NIC properties instead of nd_table[] */
> -    qemu_check_nic_model(nd, TYPE_LANCE);
> -
> -    qdev_set_nic_properties(DEVICE(lance), nd);
>      object_property_set_link(OBJECT(lance), "dma", OBJECT(dev), &error_abort);
>      sysbus_realize(SYS_BUS_DEVICE(lance), &error_fatal);
>  }
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 947b69d159..ed5f3ccd9f 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -319,7 +319,7 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
>  
>  static void *sparc32_dma_init(hwaddr dma_base,
>                                hwaddr esp_base, qemu_irq espdma_irq,
> -                              hwaddr le_base, qemu_irq ledma_irq)
> +                              hwaddr le_base, qemu_irq ledma_irq, NICInfo *nd)
>  {
>      DeviceState *dma;
>      ESPDMADeviceState *espdma;
> @@ -328,16 +328,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
>      SysBusPCNetState *lance;
>  
>      dma = qdev_new(TYPE_SPARC32_DMA);
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
> -
>      espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
>                                     OBJECT(dma), "espdma"));
>      sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
>  
>      esp = ESP(object_resolve_path_component(OBJECT(espdma), "esp"));
> -    sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
> -    scsi_bus_legacy_handle_cmdline(&esp->esp.bus);
>  
>      ledma = SPARC32_LEDMA_DEVICE(object_resolve_path_component(
>                                   OBJECT(dma), "ledma"));
> @@ -345,6 +340,14 @@ static void *sparc32_dma_init(hwaddr dma_base,
>  
>      lance = SYSBUS_PCNET(object_resolve_path_component(
>                           OBJECT(ledma), "lance"));
> +    qdev_set_nic_properties(DEVICE(lance), nd);
> +
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
> +    scsi_bus_legacy_handle_cmdline(&esp->esp.bus);
> +
>      sysbus_mmio_map(SYS_BUS_DEVICE(lance), 0, le_base);
>  
>      return dma;

You delay a bit of work on devices @dma and @esp.  Can you explain why?

> @@ -854,6 +857,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>      unsigned int max_cpus = machine->smp.max_cpus;
>      Object *ram_memdev = object_resolve_path_type(machine->ram_memdev_id,
>                                                    TYPE_MEMORY_BACKEND, NULL);
> +    NICInfo *nd = &nd_table[0];
>  
>      if (machine->ram_size > hwdef->max_mem) {
>          error_report("Too much memory for this machine: %" PRId64 ","
> @@ -914,9 +918,10 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>                          hwdef->iommu_pad_base, hwdef->iommu_pad_len);
>      }
>  
> +    qemu_check_nic_model(nd, TYPE_LANCE);
>      sparc32_dma_init(hwdef->dma_base,
>                       hwdef->esp_base, slavio_irq[18],
> -                     hwdef->le_base, slavio_irq[16]);
> +                     hwdef->le_base, slavio_irq[16], nd);
>  
>      if (graphic_depth != 8 && graphic_depth != 24) {
>          error_report("Unsupported depth: %d", graphic_depth);
> @@ -1047,7 +1052,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>                                      machine->initrd_filename,
>                                      machine->ram_size, &initrd_size);
>  
> -    nvram_init(nvram, (uint8_t *)&nd_table[0].macaddr, machine->kernel_cmdline,
> +    nvram_init(nvram, (uint8_t *)&nd->macaddr, machine->kernel_cmdline,
>                 machine->boot_order, machine->ram_size, kernel_size,
>                 graphic_width, graphic_height, graphic_depth,
>                 hwdef->nvram_machine_id, "Sun4m");


