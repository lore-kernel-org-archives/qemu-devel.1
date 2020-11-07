Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A7EC388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 10:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF4F20704
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 10:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgKZETB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF4F20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbLCO-0002Dt-F2
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 05:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbLBW-0001kW-E0
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 05:11:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbLBT-0006Iv-PN
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 05:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604743857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nYNe9GAIiqAh+l75F+nzti5nAZcKMqgPmAQ9nnb34MI=;
 b=IgKZETB8WDfLWV6ltUX6CHUO7SzV+2PoaZ+ZrLPlT3q6Qw94sFx460VrFgk9OAONkFdq8b
 l1hmY+5XoZ6QrlX3XRiVROUN9OviVgqli3f+n8Sr6rd4FrP8K8FRBixIGbz6fuYVz2/FW/
 3TPNNEaHkwq5XH7+7QPcMdQW3fRcHt8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-1uSCWMCzNiayIOKPgQpm8A-1; Sat, 07 Nov 2020 05:10:56 -0500
X-MC-Unique: 1uSCWMCzNiayIOKPgQpm8A-1
Received: by mail-wr1-f70.google.com with SMTP id u1so1559350wri.6
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 02:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nYNe9GAIiqAh+l75F+nzti5nAZcKMqgPmAQ9nnb34MI=;
 b=GImAN5lBQWGryt8qLw0lggUWchUrCp2mei8IabLpa148AX1EK9nf/fh/boPxp/ur70
 m+yuGk63AdZDbmttuntL0BbRyeuM7yFstPg3K7haKi7kQ1+WI4ik3+aJCTddvgmkKAmT
 lQ7NBAZAxnUdraPehxUlLBeD7s8HoprnZVbwHG1977otDo/hH+yFgmjX4+M0eTexq6sR
 RsyVmHkNx+iRT8SYL+6uyFPcKxDZJIaQXJEFO6Xs2yS6JJkb3IhJ9ZfaJTJwbth8PitA
 zPHyjQLQbLvCuHHSUnqLaSa3PDIHP146jMzru6eHhFsz9X62LD4PdVfY9ppvLGazNVR4
 AH6A==
X-Gm-Message-State: AOAM531HbC3q7LJXfaOVjPYGi/m69y35sRA4B7CiIZ4NBlCgnh6x4LGZ
 y5OZBanCkyqQgp8yaHua/KjJ1k2SorHlqmsN4IiX8hZnf0bwOAJ8k9MlyGpNHdWbuelrJsD4K/G
 nlpaykShcXg6MIm8=
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr4145347wmj.89.1604743854604; 
 Sat, 07 Nov 2020 02:10:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpnP3qh45kzp2qFFcoeLweBM2t4WVhaqAJa8EQlbWfXY2bMpi+Pj2Wlxz6zL4O9sW0ea5fpw==
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr4145321wmj.89.1604743854347; 
 Sat, 07 Nov 2020 02:10:54 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id a9sm1564685wrp.21.2020.11.07.02.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2020 02:10:52 -0800 (PST)
Subject: Re: [PULL v4 44/48] piix4: don't reserve hw resources when hotplug is
 off globally
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Ani Sinha <ani@anisinha.ca>
References: <20200929071948.281157-1-mst@redhat.com>
 <20200929071948.281157-45-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5b79133f-374e-8a8f-6aeb-bd5313dc8eb1@redhat.com>
Date: Sat, 7 Nov 2020 11:10:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-45-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 03:12:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 9/29/20 9:22 AM, Michael S. Tsirkin wrote:
> From: Ani Sinha <ani@anisinha.ca>
> 
> When acpi hotplug is turned off for both root pci bus as well as for pci
> bridges, we should not generate the related ACPI code for DSDT table or
> initialize related hw ports or reserve hw resources. This change makes
> sure all those operations are turned off in the case ACPI pci hotplug is
> off globally.
> 
> In this change, we also make sure ACPI code for the PCNT method are only
> added when bsel is enabled for the corresponding pci bus or bridge hotplug
> is turned on.

I'm trying to understand the following build failure using gcc 9.3.0
on Ubuntu:

[2567/3684] Compiling C object
libqemu-x86_64-softmmu.fa.p/hw_i386_acpi-build.c.o
FAILED: libqemu-x86_64-softmmu.fa.p/hw_i386_acpi-build.c.o
../hw/i386/acpi-build.c: In function 'build_append_pci_bus_devices':
../hw/i386/acpi-build.c:496:9: error: 'method' may be used uninitialized
in this function [-Werror=maybe-uninitialized]
  496 |         aml_append(parent_scope, method);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

> 
> As q35 machines do not use bsel for it's pci buses at this point in time, this
> change affects DSDT acpi table for q35 machines as well. Therefore, we will
> also need to commit the updated golden master DSDT table acpi binary blobs as
> well. Following is the list of blobs which needs updating:
> 
>  tests/data/acpi/q35/DSDT
>  tests/data/acpi/q35/DSDT.acpihmat
>  tests/data/acpi/q35/DSDT.bridge
>  tests/data/acpi/q35/DSDT.cphp
>  tests/data/acpi/q35/DSDT.dimmpxm
>  tests/data/acpi/q35/DSDT.ipmibt
>  tests/data/acpi/q35/DSDT.memhp
>  tests/data/acpi/q35/DSDT.mmio64
>  tests/data/acpi/q35/DSDT.numamem
>  tests/data/acpi/q35/DSDT.tis
> 
> These tables are updated in the following commit. Without the updated table
> blobs, the unit tests would fail with this patch.
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Message-Id: <20200918084111.15339-11-ani@anisinha.ca>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/acpi/piix4.c      |  6 ++++--
>  hw/i386/acpi-build.c | 25 ++++++++++++++++++-------
>  2 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 832f8fba82..894d357f8c 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -596,8 +596,10 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
>                            "acpi-gpe0", GPE_LEN);
>      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
>  
> -    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> -                    s->use_acpi_hotplug_bridge);
> +    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug) {
> +        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> +                        s->use_acpi_hotplug_bridge);
> +    }
>  
>      s->cpu_hotplug_legacy = true;
>      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2b17843837..8d14e4667a 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -96,6 +96,7 @@ typedef struct AcpiPmInfo {
>      bool s4_disabled;
>      bool pcihp_bridge_en;
>      bool smi_on_cpuhp;
> +    bool pcihp_root_en;
>      uint8_t s4_val;
>      AcpiFadtData fadt;
>      uint16_t cpu_hp_io_base;
> @@ -251,6 +252,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
>      pm->pcihp_bridge_en =
>          object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
>                                   NULL);
> +    pm->pcihp_root_en =
> +        object_property_get_bool(obj, "acpi-root-pci-hotplug",
> +                                 NULL);
>  }
>  
>  static void acpi_get_misc_info(AcpiMiscInfo *info)
> @@ -456,10 +460,12 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>      }
>  
>      /* Append PCNT method to notify about events on local and child buses.
> -     * Add unconditionally for root since DSDT expects it.
> +     * Add this method for root bus only when hotplug is enabled since DSDT
> +     * expects it.
>       */
> -    method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
> -
> +    if (bsel || pcihp_bridge_en) {
> +        method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
> +    }

build_append_pci_bus_devices() is not easy to follow and could certainly
benefit from a refactor.

So here, before 'method' was always reinitialized. Now not always,
so it can be any value set in the big for() loop before...

Something is definitively wrong.

>      /* If bus supports hotplug select it and notify about local events */
>      if (bsel) {
>          uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
> @@ -485,7 +491,10 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>              aml_append(method, aml_name("^S%.02X.PCNT", devfn));
>          }
>      }
> -    aml_append(parent_scope, method);
> +
> +    if (bsel || pcihp_bridge_en) {
> +        aml_append(parent_scope, method);
> +    }
>      qobject_unref(bsel);
>  }
>  
> @@ -1510,7 +1519,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          build_hpet_aml(dsdt);
>          build_piix4_isa_bridge(dsdt);
>          build_isa_devices_aml(dsdt);
> -        build_piix4_pci_hotplug(dsdt);
> +        if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
> +            build_piix4_pci_hotplug(dsdt);
> +        }
>          build_piix4_pci0_int(dsdt);
>      } else {
>          sb_scope = aml_scope("_SB");
> @@ -1579,7 +1590,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      {
>          aml_append(scope, aml_name_decl("_HID", aml_string("ACPI0006")));
>  
> -        if (misc->is_piix4) {
> +        if (misc->is_piix4 && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
>              method = aml_method("_E01", 0, AML_NOTSERIALIZED);
>              aml_append(method,
>                  aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
> @@ -1731,7 +1742,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      crs_range_set_free(&crs_range_set);
>  
>      /* reserve PCIHP resources */
> -    if (pm->pcihp_io_len) {
> +    if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
>          dev = aml_device("PHPR");
>          aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
>          aml_append(dev,
> 


