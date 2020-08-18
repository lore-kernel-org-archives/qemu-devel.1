Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE3BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2998D206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="jfbs2wUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2998D206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7yLS-00008s-Ac
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 05:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k7yKc-0007n8-6X
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:55:02 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k7yKY-0004kc-Td
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:55:01 -0400
Received: by mail-wr1-x441.google.com with SMTP id r15so7731730wrp.13
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 02:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gYc/YmymThvhpwrEF8B+hv0E8UEl5BzJVj8pR47OHgY=;
 b=jfbs2wUjwzszwRNY0yqRCnUKNVtu+Sxh+4bDPvIBKnrzdrgSnEuFT5TE1i3U+QZPpC
 HP96+ef96jzrUnJ+hWrj65dfKzybVCfz5cBpJO0lahwzoDInhT2apGOOsJdRPCjIpxwO
 KdWLVosRaYC8+4FiJy8p5XdDGCR8cWomloIYD/65jg5cCCrcLwB+N7VEZXhJFg4Grq4l
 CDyy3SOteB+vIQ2GUwz9kWZ9yUCR+IAl8RCvmAzvC3BCotBYOkH1JMVzTlBjSpp+IgEQ
 Z9/maHGCZvhBjq0DUnl5qIDsifjYZ76QpPhtkxHCezaZgW6P/3PbbiIWB84iDPQzrqBZ
 WNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gYc/YmymThvhpwrEF8B+hv0E8UEl5BzJVj8pR47OHgY=;
 b=pb4qw60fVChe4EmIhAny33mOiyC0S9NSvAPtydQT7R+9O+BigMi5Iqxt/ZOCLL0KzB
 empwXdOElgzJ/E8W++o1YOZBLOaPAow14YJReB8KPLtyswoKUqK7P8gyH12jX/kPM/A5
 6U5QSP+CG6bhYV2O7warSSg5fJmd933NT+UH80UEigNrb/l+Swwp8L0rJbg6ziUCy/U7
 bgQ4G4ICP+9PpwYd0PQPHUjaQjlM6ptpXeRBiw8ZjyjFur3mBzzRTs30bFacJcIcgiDI
 61JKCib2Tj0Sv9Xqt/wjSD4tNKh6TV0GkryjfMbLOx/OkvE1fEyBb5BiM4mIlnzGxqrp
 irDg==
X-Gm-Message-State: AOAM532RfIpX8HDcsw5XQ5e5eArLuwEnhDUAYAMhzylt6W28IzIr2qBY
 Ybf3vcFd6tm9PlCPugftCVLX//Nh9N0/nQ0B/Na1ijyo0Jk=
X-Google-Smtp-Source: ABdhPJwUiLxoaORR+3qK210EP6Uo9qCXyADznxc+NYbwmQ8CFNfW3qB4GaT64RD1lcK5PbJv5LTVifsAPU4902EY9hs=
X-Received: by 2002:a5d:5485:: with SMTP id h5mr18545090wrv.427.1597744495322; 
 Tue, 18 Aug 2020 02:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <1597151528-75766-1-git-send-email-ani@anisinha.ca>
In-Reply-To: <1597151528-75766-1-git-send-email-ani@anisinha.ca>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 18 Aug 2020 15:24:44 +0530
Message-ID: <CAARzgwxZNpiTLn8aome=tVxHe-ut=Pkbte=McUbr=B2xx6kRfQ@mail.gmail.com>
Subject: Re: [PATCH V2] Introduce a new flag for piix to disable root bus PCI
 hotplug
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::441;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Igor etc, I just tested this patch using a Windows 2012 R2 image and
it seems to be working. Any feedbacks on this patch?

On Tue, Aug 11, 2020 at 6:42 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> We introduce a new global flag for PIIX with which we can turn on or off PCI
> device hotplug on the root bus. This flag can be used to prevent all PCI
> devices from getting hotplugged or unplugged from the root PCI bus.
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  hw/acpi/piix4.c      |  3 +++
>  hw/i386/acpi-build.c | 20 ++++++++++++++++----
>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 26bac4f..94ec35a 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
>
>      AcpiPciHpState acpi_pci_hotplug;
>      bool use_acpi_hotplug_bridge;
> +    bool use_acpi_root_pci_hotplug;
>
>      uint8_t disable_s3;
>      uint8_t disable_s4;
> @@ -635,6 +636,8 @@ static Property piix4_pm_properties[] = {
>      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
>      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
>                       use_acpi_hotplug_bridge, true),
> +    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
> +                     use_acpi_root_pci_hotplug, true),
>      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
>                       acpi_memory_hotplug.is_enabled, true),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7bcbbb..a82e5c1 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
>      bool s3_disabled;
>      bool s4_disabled;
>      bool pcihp_bridge_en;
> +    bool pcihp_root_en;
>      uint8_t s4_val;
>      AcpiFadtData fadt;
>      uint16_t cpu_hp_io_base;
> @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
>      pm->pcihp_bridge_en =
>          object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
>                                   NULL);
> +    pm->pcihp_root_en =
> +        object_property_get_bool(obj, "acpi-root-pci-hotplug", NULL);
> +
>  }
>
>  static void acpi_get_misc_info(AcpiMiscInfo *info)
> @@ -337,12 +341,15 @@ static void build_append_pcihp_notify_entry(Aml *method, int slot)
>  }
>
>  static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> -                                         bool pcihp_bridge_en)
> +                                         bool pcihp_bridge_en,
> +                                         bool pcihp_root_en)
>  {
>      Aml *dev, *notify_method = NULL, *method;
>      QObject *bsel;
>      PCIBus *sec;
>      int i;
> +    bool root_bus = pci_bus_is_root(bus);
> +    bool root_pcihp_disabled = (root_bus && !pcihp_root_en);
>
>      bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
>      if (bsel) {
> @@ -361,6 +368,9 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>          bool bridge_in_acpi;
>
>          if (!pdev) {
> +            /* skip if pci hotplug for the root bus is disabled */
> +            if (root_pcihp_disabled)
> +                continue;
>              if (bsel) { /* add hotplug slots for non present devices */
>                  dev = aml_device("S%.02X", PCI_DEVFN(slot, 0));
>                  aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> @@ -419,7 +429,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>              method = aml_method("_S3D", 0, AML_NOTSERIALIZED);
>              aml_append(method, aml_return(aml_int(s3d)));
>              aml_append(dev, method);
> -        } else if (hotplug_enabled_dev) {
> +        } else if (hotplug_enabled_dev && !root_pcihp_disabled) {
>              /* add _SUN/_EJ0 to make slot hotpluggable  */
>              aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
>
> @@ -439,7 +449,8 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>               */
>              PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
>
> -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
> +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,
> +                                         pcihp_root_en);
>          }
>          /* slot descriptor has been composed, add it into parent context */
>          aml_append(parent_scope, dev);
> @@ -1818,7 +1829,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          if (bus) {
>              Aml *scope = aml_scope("PCI0");
>              /* Scan all PCI buses. Generate tables to support hotplug. */
> -            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
> +            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en,
> +                                         pm->pcihp_root_en);
>
>              if (TPM_IS_TIS_ISA(tpm)) {
>                  if (misc->tpm_version == TPM_VERSION_2_0) {
> --
> 2.7.4
>

