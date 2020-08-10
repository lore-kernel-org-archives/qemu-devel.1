Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEAAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2E82080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdK/EV04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2E82080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k595y-0004fu-Jz
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 10:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k594s-00043s-7G
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 10:47:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29155
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k594q-00023Q-7q
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 10:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597070823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6xrH5xs8SgCMlThTDPogkvxcr5PElWGbR8ZrRNpuixg=;
 b=OdK/EV04zaYN0Bwit7S2w4NaAESHaAw3gfJCv4JxYnZ4HWisIW37Oxi0PVR4lSrlGW2zIm
 +rXsxsgfcUZXvdeOhcTHdkPkl10W+DhiyW2iEu8Sx3EXUx3CEocpJ/F3CdXTIkdvAx7JNE
 Imu3jUAV1IAfyChor+QFFu+9Jj8yGfw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-390wdJRUPUOTUFr-uKzuRQ-1; Mon, 10 Aug 2020 10:47:00 -0400
X-MC-Unique: 390wdJRUPUOTUFr-uKzuRQ-1
Received: by mail-wr1-f71.google.com with SMTP id t3so4311104wrr.5
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 07:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6xrH5xs8SgCMlThTDPogkvxcr5PElWGbR8ZrRNpuixg=;
 b=jDRqHKhRSsUPiYPjAkneferXUv+kqJpfE0QVnhFWQlj5cpI+3PxgLn94qCNs2lTqhu
 EImZkEWQOIfRqpAjmoI17lcihUp4fJxucC1jWJYKtmanCUkwgFngNsKBBEMi3Et8opEp
 s09nhcYlA4Z9I2ECnUrEmL7k+IdfVW2QVIyMPm1OMiSnkDZ+ohhZuEe1U+BsPECVUFUc
 I4oJT7HdkaYFiOeWsKH5VEcIvzPlvrYIHv47cciL/n4mzAScmGNRbjROuoQ4OSX+P9JK
 wkAUAIp5gwE4Gjf0tEAQ58M6E88gPuzbiruMuXkq7JiaCF7IUH9nxfcDm574th3/Jqyr
 92rA==
X-Gm-Message-State: AOAM533XkxNaoz/GZ7/lLuAp/qpnk+QERYn7zA5OKP2hDxQDFnA2qKJe
 Malva90QMIqnkaeHOGXkN5OoN7zkm2BxTnYZoOzC3LQVFcd/fT7punQpPm3JZWoWAsm59W0arZe
 L867zRr//JW/vX18=
X-Received: by 2002:a1c:e10a:: with SMTP id y10mr25011721wmg.1.1597070819718; 
 Mon, 10 Aug 2020 07:46:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2knQ3hk19j/73IYbmdseKlzBw59rLFfMoEb1tKCqv5stRMhZzQk8JVx+i59eGo1a4MqcEjQ==
X-Received: by 2002:a1c:e10a:: with SMTP id y10mr25011696wmg.1.1597070819480; 
 Mon, 10 Aug 2020 07:46:59 -0700 (PDT)
Received: from redhat.com (bzq-109-67-41-16.red.bezeqint.net. [109.67.41.16])
 by smtp.gmail.com with ESMTPSA id
 69sm22752944wmb.8.2020.08.10.07.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 07:46:58 -0700 (PDT)
Date: Mon, 10 Aug 2020 10:46:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH] Introduce global piix flag to disable PCI hotplug
Message-ID: <20200810104602-mutt-send-email-mst@kernel.org>
References: <1597058982-70090-1-git-send-email-ani@anisinha.ca>
MIME-Version: 1.0
In-Reply-To: <1597058982-70090-1-git-send-email-ani@anisinha.ca>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 10, 2020 at 04:59:41PM +0530, Ani Sinha wrote:
> We introduce a new global flag for PIIX with which we can
> turn on or off PCI device hotplug. This flag can be used
> to prevent all PCI devices from getting hotplugged/unplugged
> on the PCI bus. The new options disables all hotpluh HW
> initialization code as well as the ACPI AMLs.
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>

Well we have a flag like this for pci bridges, right?
So all that's left is an option to disable hotplug
for the pci root, right?
Wouldn't that be better than disabling it globally?

> ---
>  hw/acpi/piix4.c      |  8 ++++++--
>  hw/i386/acpi-build.c | 20 ++++++++++++++------
>  2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 26bac4f..8b13e86 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
>  
>      AcpiPciHpState acpi_pci_hotplug;
>      bool use_acpi_hotplug_bridge;
> +    bool use_acpi_pci_hotplug;
>  
>      uint8_t disable_s3;
>      uint8_t disable_s4;
> @@ -595,8 +596,9 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
>                            "acpi-gpe0", GPE_LEN);
>      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
>  
> -    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> -                    s->use_acpi_hotplug_bridge);
> +    if (s->use_acpi_pci_hotplug)
> +        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> +                        s->use_acpi_hotplug_bridge);
>  
>      s->cpu_hotplug_legacy = true;
>      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> @@ -635,6 +637,8 @@ static Property piix4_pm_properties[] = {
>      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
>      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
>                       use_acpi_hotplug_bridge, true),
> +    DEFINE_PROP_BOOL("acpi-pci-hotplug", PIIX4PMState,
> +                     use_acpi_pci_hotplug, true),
>      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
>                       acpi_memory_hotplug.is_enabled, true),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7bcbbb..343b9b6 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
>      bool s3_disabled;
>      bool s4_disabled;
>      bool pcihp_bridge_en;
> +    bool pcihp_en;
>      uint8_t s4_val;
>      AcpiFadtData fadt;
>      uint16_t cpu_hp_io_base;
> @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
>      pm->pcihp_bridge_en =
>          object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
>                                   NULL);
> +    pm->pcihp_en =
> +        object_property_get_bool(obj, "acpi-pci-hotplug", NULL);
> +
>  }
>  
>  static void acpi_get_misc_info(AcpiMiscInfo *info)
> @@ -337,14 +341,16 @@ static void build_append_pcihp_notify_entry(Aml *method, int slot)
>  }
>  
>  static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> -                                         bool pcihp_bridge_en)
> +                                         bool pcihp_bridge_en, bool pcihp_en)
>  {
>      Aml *dev, *notify_method = NULL, *method;
> -    QObject *bsel;
> +    QObject *bsel = NULL;
>      PCIBus *sec;
>      int i;
>  
> -    bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
> +    if (pcihp_en)
> +        bsel = object_property_get_qobject(OBJECT(bus),
> +                                           ACPI_PCIHP_PROP_BSEL, NULL);
>      if (bsel) {
>          uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
>  
> @@ -439,7 +445,8 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>               */
>              PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
>  
> -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
> +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,
> +                                         pcihp_en);
>          }
>          /* slot descriptor has been composed, add it into parent context */
>          aml_append(parent_scope, dev);
> @@ -468,7 +475,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>      }
>  
>      /* Notify about child bus events in any case */
> -    if (pcihp_bridge_en) {
> +    if (pcihp_bridge_en && pcihp_en) {
>          QLIST_FOREACH(sec, &bus->child, sibling) {
>              int32_t devfn = sec->parent_dev->devfn;
>  
> @@ -1818,7 +1825,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          if (bus) {
>              Aml *scope = aml_scope("PCI0");
>              /* Scan all PCI buses. Generate tables to support hotplug. */
> -            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
> +            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en,
> +                                         pm->pcihp_en);
>  
>              if (TPM_IS_TIS_ISA(tpm)) {
>                  if (misc->tpm_version == TPM_VERSION_2_0) {
> -- 
> 2.7.4


