Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A2CC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 08:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E67206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 08:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5XqXhX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E67206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8gJG-0000Se-FJ
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 04:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8gId-00081w-5q
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 04:51:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20025
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8gIb-0007Rg-4w
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 04:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597913512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0RsfgwAo/Gssk9N/gbwY0Fk4CgGme2Ag/EzBECFSq1U=;
 b=J5XqXhX6ctLdAz9SaAxYGr2TDVgWP+3lDUsIksHP2Zr8Gt/neLmtosgTMAtsDMJYe704OL
 T68MrC0E7vSikXueZKfdKTvKFUsC837+JB/fY8ZL+OjY4YgbuX51HIEBEPlmGSNjp2aNpq
 k4Z9TGfODa1XcLALTIpYqZqocGKuGsg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-aZY9RP5lNwSGV9GxlWS5wg-1; Thu, 20 Aug 2020 04:51:48 -0400
X-MC-Unique: aZY9RP5lNwSGV9GxlWS5wg-1
Received: by mail-wr1-f69.google.com with SMTP id t12so411076wrp.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 01:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0RsfgwAo/Gssk9N/gbwY0Fk4CgGme2Ag/EzBECFSq1U=;
 b=MmhUbRgNwWvgLo6poooJwWSdVXVRcUysgw1lN9rLJpL0+zQBk0vjliK5/9Vny2pLY6
 i8+NzA1LXIDF3UHP2ePUXlTSHkBoLV+5xA/+7jgcaoZYYDSfvLSFyvcCjlv7IaZgjMES
 UE63nx15DJbmP96Qf3v6puhmSpf9qqDglcG/fdMS8XFIT3uycHMNOIL5sLdUmMue9qCv
 +c6OL3/yQJz+wuniyJFcykpMcb97dckFY+2uG9bHMRFh7og/OLJD1T2fdm/5Cf5Uqf2q
 PwBNTdpIYs18g+cgIWbiZPA9I4WdHUhrJ95O//XS1ZD6HxC4DWSotgla3hpB2PEzkptv
 +ghg==
X-Gm-Message-State: AOAM531I7AzkuntJWysTHioUOXWrQEUPftp8BWU5exT5Ous1YAvV4eMc
 mbKcCsNnRYds+7D9rg48AjvCk6xkdtvojvhFICVMqjJ+IX5i5yPZbDnTCa9eSBQ4tDysymtxsEJ
 v4lwM/ywTgTUzMbc=
X-Received: by 2002:adf:81c5:: with SMTP id 63mr2170524wra.185.1597913506957; 
 Thu, 20 Aug 2020 01:51:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsc14OesBNYJAe9VhmP3L0MNES8g86oaa/L/utbG3XpZ7EfdE8zX7w1GZwBgAI/wuw8ib6Jg==
X-Received: by 2002:adf:81c5:: with SMTP id 63mr2170489wra.185.1597913506618; 
 Thu, 20 Aug 2020 01:51:46 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id r21sm2921709wrc.2.2020.08.20.01.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 01:51:46 -0700 (PDT)
Subject: Re: [PATCH V5] Introduce a new flag for i440fx to disable PCI hotplug
 on the root bus
To: Ani Sinha <ani@anisinha.ca>, qemu-devel@nongnu.org
References: <20200820081659.17328-1-ani@anisinha.ca>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <447c3e1d-ab86-13bd-4699-d791c1bc1d0d@redhat.com>
Date: Thu, 20 Aug 2020 10:51:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820081659.17328-1-ani@anisinha.ca>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:38:44
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 10:16 AM, Ani Sinha wrote:
> We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx with which
> we can turn on or off PCI device hotplug on the root bus. This flag can be
> used to prevent all PCI devices from getting hotplugged or unplugged from the
> root PCI bus.
> This feature is targetted mostly towards Windows VMs. It is useful in cases
> where some hypervisor admins want to deploy guest VMs in a way so that the
> users of the guest OSes are not able to hot-eject certain PCI devices from
> the Windows system tray. Laine has explained the use case here in detail:
> https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html
> 
> Julia has resolved this issue for PCIE buses with the following commit:
> 530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling option")
> 
> This commit attempts to introduce similar behavior for PCI root buses used in
> i440fx machine types (although in this case, we do not have a per-slot
> capability to turn hotplug on or off).
> 
> Usage:
>    -global PIIX4_PM.acpi-root-pci-hotplug=off
> 
> By default, this option is enabled which means that hotplug is turned on for
> the PCI root bus.
> 
> The previously existing flag 'acpi-pci-hotplug-with-bridge-support' for PCI-PCI
> bridges remain as is and can be used along with this new flag to control PCI
> hotplug on PCI bridges.
> 
> This change has been tested using a Windows 2012R2 server guest image and also
> with a Windows 2019 server guest image on a Ubuntu 18.04 host using the latest
> master qemu from upstream.

"latest master qemu from upstream" -> "v5.1.0 tag"

> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  hw/acpi/piix4.c      |  8 ++++++--
>  hw/i386/acpi-build.c | 26 +++++++++++++++++++-------
>  2 files changed, 25 insertions(+), 9 deletions(-)
> 
> Change Log:
> V4..V5: Updated commit message to reflect the fact that testing was also
> performed on a Windows 2019 server guest image. Minor commit log formatting
> to make sure 80 col rule is enforced.
> 
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 26bac4f16c..4f436e5bf3 100644
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
> @@ -595,8 +596,9 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
>                            "acpi-gpe0", GPE_LEN);
>      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
>  
> -    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> -                    s->use_acpi_hotplug_bridge);
> +    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug)
> +        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> +                        s->use_acpi_hotplug_bridge);
>  
>      s->cpu_hotplug_legacy = true;
>      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> @@ -635,6 +637,8 @@ static Property piix4_pm_properties[] = {
>      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
>      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
>                       use_acpi_hotplug_bridge, true),
> +    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
> +                     use_acpi_root_pci_hotplug, true),
>      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
>                       acpi_memory_hotplug.is_enabled, true),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7bcbbbb2a..19a1702ad1 100644
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
> @@ -337,15 +341,18 @@ static void build_append_pcihp_notify_entry(Aml *method, int slot)
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
> -    if (bsel) {
> +    if (bsel && !root_pcihp_disabled) {
>          uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
>  
>          aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
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
> @@ -439,13 +449,14 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>               */
>              PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
>  
> -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
> +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,
> +                                         pcihp_root_en);
>          }
>          /* slot descriptor has been composed, add it into parent context */
>          aml_append(parent_scope, dev);
>      }
>  
> -    if (bsel) {
> +    if (bsel && !root_pcihp_disabled) {
>          aml_append(parent_scope, notify_method);
>      }
>  
> @@ -455,7 +466,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>      method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
>  
>      /* If bus supports hotplug select it and notify about local events */
> -    if (bsel) {
> +    if (bsel && !root_pcihp_disabled) {
>          uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
>  
>          aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
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
> 


