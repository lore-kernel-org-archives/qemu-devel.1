Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358A1C4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C312083B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPp3004n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C312083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAEV-0002Ug-PC
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yX-0004lV-BH
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yT-0001q2-P0
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:23:01 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nwcj0J+3W9niD2uxFj+QS0HzuXLpmU3R+RTOGWxyjvU=;
 b=fPp3004nvzlmFXaQJwuMYng++qRxKT6t0lzDRBgQTq+M6RbriDH0HgZ9lc5LBBosQXPJs/
 oO7UNpmF5EJn7dh4gRwk4o0o+FL8fqEH+MzbH50CBDIUu2rzV/NscTLoZjadXOmqj/Y6nG
 Sw4+LbaTVEh5ShjW5DVrC4hlXZ3sVmY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-uchkqMQgM8SO5izPBdBROw-1; Tue, 29 Sep 2020 03:22:54 -0400
X-MC-Unique: uchkqMQgM8SO5izPBdBROw-1
Received: by mail-wm1-f71.google.com with SMTP id b14so1358413wmj.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Nwcj0J+3W9niD2uxFj+QS0HzuXLpmU3R+RTOGWxyjvU=;
 b=oSltEbwF3Oxmv7xwzq5vS+4BO+HjQ7VASRw4VCl8rI7Cy8gXDV2Zt97e43xHbwxncI
 6LHuaNCJO6GhdTKrqsGwIpyY1zlROKjhocMJo5TJZ0x0G1ZgNY7CaovNkPOereUjcAJo
 i+D6zBdWwBPTub1xI4cYcKrsCUhdKSt2/7FAHq9d3ImEQ+wY6AmLE2X2oflulz98laob
 9h0hGNltVuwpb7PfXcr5oIOE89jzVmbppugUOrwmXNffodZhj5l7SYMwvAb4e1e7bkiA
 uKaEkAmfbOkgLKALrc6l5h1DbMxMRL5PdGE0i7rmQcidztEjlOpMDTYc540at86ASjV0
 UpgA==
X-Gm-Message-State: AOAM530LhjehOQJtChvyIiLeAXRBUViaJuZspLydIvrvUri8haeVaBB2
 gJM2H635/5PLV5X/aR5Vo1/UHo/48vRkhISWNcJktoYbVKdyJ6wkQ88RNkQf6MGjPCeuL9PCOYA
 V6ojBpFRKSRQ47lA=
X-Received: by 2002:adf:e711:: with SMTP id c17mr2568030wrm.359.1601364172398; 
 Tue, 29 Sep 2020 00:22:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEarA19GwsEPEyvTt4uthIca0XlZSaJdJL2MYIjcVqQnsC+xiTG+aaVH2716SX5tsv5SifVA==
X-Received: by 2002:adf:e711:: with SMTP id c17mr2567999wrm.359.1601364172203; 
 Tue, 29 Sep 2020 00:22:52 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id d83sm4603942wmf.23.2020.09.29.00.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:51 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 44/48] piix4: don't reserve hw resources when hotplug is
 off globally
Message-ID: <20200929071948.281157-45-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ani Sinha <ani@anisinha.ca>

When acpi hotplug is turned off for both root pci bus as well as for pci
bridges, we should not generate the related ACPI code for DSDT table or
initialize related hw ports or reserve hw resources. This change makes
sure all those operations are turned off in the case ACPI pci hotplug is
off globally.

In this change, we also make sure ACPI code for the PCNT method are only
added when bsel is enabled for the corresponding pci bus or bridge hotplug
is turned on.

As q35 machines do not use bsel for it's pci buses at this point in time, this
change affects DSDT acpi table for q35 machines as well. Therefore, we will
also need to commit the updated golden master DSDT table acpi binary blobs as
well. Following is the list of blobs which needs updating:

 tests/data/acpi/q35/DSDT
 tests/data/acpi/q35/DSDT.acpihmat
 tests/data/acpi/q35/DSDT.bridge
 tests/data/acpi/q35/DSDT.cphp
 tests/data/acpi/q35/DSDT.dimmpxm
 tests/data/acpi/q35/DSDT.ipmibt
 tests/data/acpi/q35/DSDT.memhp
 tests/data/acpi/q35/DSDT.mmio64
 tests/data/acpi/q35/DSDT.numamem
 tests/data/acpi/q35/DSDT.tis

These tables are updated in the following commit. Without the updated table
blobs, the unit tests would fail with this patch.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200918084111.15339-11-ani@anisinha.ca>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/piix4.c      |  6 ++++--
 hw/i386/acpi-build.c | 25 ++++++++++++++++++-------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 832f8fba82..894d357f8c 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -596,8 +596,10 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
                           "acpi-gpe0", GPE_LEN);
     memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
 
-    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
-                    s->use_acpi_hotplug_bridge);
+    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug) {
+        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
+                        s->use_acpi_hotplug_bridge);
+    }
 
     s->cpu_hotplug_legacy = true;
     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2b17843837..8d14e4667a 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -96,6 +96,7 @@ typedef struct AcpiPmInfo {
     bool s4_disabled;
     bool pcihp_bridge_en;
     bool smi_on_cpuhp;
+    bool pcihp_root_en;
     uint8_t s4_val;
     AcpiFadtData fadt;
     uint16_t cpu_hp_io_base;
@@ -251,6 +252,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
     pm->pcihp_bridge_en =
         object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
                                  NULL);
+    pm->pcihp_root_en =
+        object_property_get_bool(obj, "acpi-root-pci-hotplug",
+                                 NULL);
 }
 
 static void acpi_get_misc_info(AcpiMiscInfo *info)
@@ -456,10 +460,12 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
     }
 
     /* Append PCNT method to notify about events on local and child buses.
-     * Add unconditionally for root since DSDT expects it.
+     * Add this method for root bus only when hotplug is enabled since DSDT
+     * expects it.
      */
-    method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
-
+    if (bsel || pcihp_bridge_en) {
+        method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
+    }
     /* If bus supports hotplug select it and notify about local events */
     if (bsel) {
         uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
@@ -485,7 +491,10 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
             aml_append(method, aml_name("^S%.02X.PCNT", devfn));
         }
     }
-    aml_append(parent_scope, method);
+
+    if (bsel || pcihp_bridge_en) {
+        aml_append(parent_scope, method);
+    }
     qobject_unref(bsel);
 }
 
@@ -1510,7 +1519,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_hpet_aml(dsdt);
         build_piix4_isa_bridge(dsdt);
         build_isa_devices_aml(dsdt);
-        build_piix4_pci_hotplug(dsdt);
+        if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
+            build_piix4_pci_hotplug(dsdt);
+        }
         build_piix4_pci0_int(dsdt);
     } else {
         sb_scope = aml_scope("_SB");
@@ -1579,7 +1590,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     {
         aml_append(scope, aml_name_decl("_HID", aml_string("ACPI0006")));
 
-        if (misc->is_piix4) {
+        if (misc->is_piix4 && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
             method = aml_method("_E01", 0, AML_NOTSERIALIZED);
             aml_append(method,
                 aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
@@ -1731,7 +1742,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     crs_range_set_free(&crs_range_set);
 
     /* reserve PCIHP resources */
-    if (pm->pcihp_io_len) {
+    if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
         dev = aml_device("PHPR");
         aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
         aml_append(dev,
-- 
MST


