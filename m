Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CB9C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70EC2100A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3ZO0qEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70EC2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBSC-0007sI-Li
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kJBR8-00074c-Lc
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kJBR5-0003Ah-Q2
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600416482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42AxDhxpKW39u4neb89p9JG5+mAwsKeO7TSpsmc5NvE=;
 b=e3ZO0qEG5vaGNqc49TpfSeBfeKNfprcwH6jLZrBwo1uRmg0VgIedfM4dDJiUm6LlPPiH8T
 /FDGZ6+9AIMNZPxAf+yMGUUDDAAIHEXwyVhiCjSukTwTiz2Ms+mJMV3vKQPpaBRUneGa6y
 6TYVZ8Vz4uRxx7TWgwpd0JD/E0YYYSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-KVCUHAW5Ocy1Ft445337nA-1; Fri, 18 Sep 2020 04:08:00 -0400
X-MC-Unique: KVCUHAW5Ocy1Ft445337nA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF37C1008558;
 Fri, 18 Sep 2020 08:07:58 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A356078816;
 Fri, 18 Sep 2020 08:07:45 +0000 (UTC)
Date: Fri, 18 Sep 2020 10:07:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v9 10/13] piix4: don't reserve hw resources when hotplug
 is off globally
Message-ID: <20200918100744.41cadad0@redhat.com>
In-Reply-To: <20200918072325.9933-11-ani@anisinha.ca>
References: <20200918072325.9933-1-ani@anisinha.ca>
 <20200918072325.9933-11-ani@anisinha.ca>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Philippe =?UTF-8?B?TWF0aGll?= =?UTF-8?B?dS1EYXVkw6k=?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Sep 2020 12:53:22 +0530
Ani Sinha <ani@anisinha.ca> wrote:

> When acpi hotplug is turned off for both root pci bus as well as for pci
> bridges, we should not generate the related ACPI code for DSDT table or
> initialize related hw ports or reserve hw resources. This change makes
> sure all those operations are turned off in the case ACPI pci hotplug is
> off globally.
> 
> In this change, we also make sure ACPI code for the PCNT method are only
> added when bsel is enabled for the corresponding pci bus or bridge hotplug
> is turned on.
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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/piix4.c      |  6 ++++--
>  hw/i386/acpi-build.c | 25 ++++++++++++++++++-------
>  2 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index e6163bb6ce..b70b1f98af 100644
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
> index e079b686f5..e41bb0992b 100644
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
> +        object_property_get_bool(obj, "acpi-root-pci-hotplug",
> +                                 NULL);
>  }
>  
>  static void acpi_get_misc_info(AcpiMiscInfo *info)
> @@ -450,10 +454,12 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
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
>      /* If bus supports hotplug select it and notify about local events */
>      if (bsel) {
>          uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
> @@ -479,7 +485,10 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
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
> @@ -1504,7 +1513,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
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
> @@ -1546,7 +1557,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      {
>          aml_append(scope, aml_name_decl("_HID", aml_string("ACPI0006")));
>  
> -        if (misc->is_piix4) {
> +        if (misc->is_piix4 && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
>              method = aml_method("_E01", 0, AML_NOTSERIALIZED);
>              aml_append(method,
>                  aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
> @@ -1698,7 +1709,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      crs_range_set_free(&crs_range_set);
>  
>      /* reserve PCIHP resources */
> -    if (pm->pcihp_io_len) {
> +    if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
>          dev = aml_device("PHPR");
>          aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
>          aml_append(dev,


