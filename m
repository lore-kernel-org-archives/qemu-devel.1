Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF06C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 11:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B55F20709
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 11:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="DQdK4C09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B55F20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k564s-0004Cq-MN
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 07:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k563j-0003Yl-0Y
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 07:33:43 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k563h-0002O4-05
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 07:33:42 -0400
Received: by mail-wm1-x344.google.com with SMTP id d190so7328547wmd.4
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 04:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/cAWnYOQyINb41XRZKjpBdLUawNgvehNhfWp57VPPB8=;
 b=DQdK4C09SGnS6I5U6jvMUaFV/YdQ30JXsHD1ErB8h9v/HeBo4tIEhzG1dpQJY/i3gB
 gc4eW6/Rdflyy0gR88R05E2VZjtBr7FVukZeK0ZMS8UKlJz4444AT1wrCw8qGbKvpfmz
 4XktNyAvOmInJpTAWsO/9MUymgFQrJ3ANRdajiNzHC90DU3drF85h1dR32X5E51p36NT
 dbbUpFP1aNAUlzSojjO3s2TppZAgCew7nrsVs8spvA1VztwwwYiQwpjScoNyZcmJP9nV
 5dILXkGQZjY9iFVAjkEGbvNdKDT7WRIsWdLeyMERir/9WuVIbM5Z5JxDQAAISHO5lZqS
 utGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/cAWnYOQyINb41XRZKjpBdLUawNgvehNhfWp57VPPB8=;
 b=fjaeW59IDpcIRVjnTnzBg1OPCiykbI/ExrDISWmPiNFX1QZEx/+WweO1OvSTdmlTZl
 4IrzD7S5C8QBUAQ1mz0NWW3QEC70HkNcdtIpx/oM6/EXr/UGAr70BpRgo6qjXWVM6mUq
 5uXfhkFoMw4oWdbGenxXlmhTon1TffRYvu1yv4Junsd28vBle5YQN7HRCba0SZsNcRyB
 r6AZOqRBEdzBzj+7T/6mYRC8zP0NLzVf5+dVJjxxbNWC5oGs58dhjv6cLtLFZOuWrEXS
 NfBMMDSCOIQkF4++/GlC6TjyyFvO/k2r+MkZTWW8WC9JF6Ew7rhl5SMP789SaHAgKFZe
 Idhw==
X-Gm-Message-State: AOAM531II6IMBQATF5zYY8S222OIKXGcachx3ZUVVUvcWdcZbMoYZJlo
 wYhdQkIP3LRCIB31LQYo4Kn+8o4fKcjs9VFERZlA852umqfypw==
X-Google-Smtp-Source: ABdhPJxLDy1GatcdDOkpCqZwJHdD6bDmqCmnw8QWJEUC2PwwKnCScgSGwmP8iGGTc3NURQDbIv2sHTIcpa9oXlM6zy0=
X-Received: by 2002:a05:600c:514:: with SMTP id
 i20mr25386904wmc.102.1597059218632; 
 Mon, 10 Aug 2020 04:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <1597058982-70090-1-git-send-email-ani@anisinha.ca>
In-Reply-To: <1597058982-70090-1-git-send-email-ani@anisinha.ca>
From: Ani Sinha <ani@anisinha.ca>
Date: Mon, 10 Aug 2020 17:03:27 +0530
Message-ID: <CAARzgwzMA5gS5xy+Z28U6eZNv1+=UTX-fQTsr5w2skpvoPUXdg@mail.gmail.com>
Subject: Re: [PATCH] Introduce global piix flag to disable PCI hotplug
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::344;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is related to the discussion we had a few weeks ago:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg705212.html

Igor, could you please comment if this will do. I have not tested it
since I do not have a setup handy. Sending this out for a quick
review.

thanks
ani

On Mon, Aug 10, 2020 at 4:59 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> We introduce a new global flag for PIIX with which we can
> turn on or off PCI device hotplug. This flag can be used
> to prevent all PCI devices from getting hotplugged/unplugged
> on the PCI bus. The new options disables all hotpluh HW
> initialization code as well as the ACPI AMLs.
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
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
>

