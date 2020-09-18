Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91778C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:46:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5ED20C56
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="g0yL1XKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5ED20C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJC2i-00070f-1o
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJByC-0002Zc-MV
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:42:16 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJBy7-0007uN-8x
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:42:16 -0400
Received: by mail-pg1-x542.google.com with SMTP id 67so3047241pgd.12
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Xl3GALL6nhp1zjK011RvGUMqU9rbaa06a/PicJ81RnY=;
 b=g0yL1XKQHypQLsJE/IRKxhtvuQr3q8AOFqYO/RyHGjw3G0uSTqQ61ps3F21GBYa1kX
 9yw5zbtGdizm3y7sdHwCgm/RC0FzQtCAJ+zTGQezgr6OOfdO3Qju/Wn0SMzPX/peimAs
 kmw0BzEHFcjGlvPCOMjohmUpuHA/yLg9L5gTx+Itd6WPbQkBdyNrcx/T2GHSbG95eegK
 rhFD0CjvRTpG8d4InWVmvJzMImsx4lVRyARhLcoaGuVvwCjjRKndeWzyqxEe7bvPLwyu
 bNXCdnOAwJJP+AzQ3wNdZ/fbYKnRnOi97jM7VfZeprQb5zuU7XM8GRdderdwpFpqr8J2
 Vnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Xl3GALL6nhp1zjK011RvGUMqU9rbaa06a/PicJ81RnY=;
 b=FExALyyEb43lbgBcIsFKrqxInndFkv12l3W7NdAE7QrA4UX/btpbdDlaBnSA0WFvar
 KZSzy9CnoHPT5SrZ+ZLZJMctvOYfqIxRBKPvrDwiQoSuFwHk1HJJveRKIz4IoNJyy/m/
 FOJ58iXJ03RfJvy+U+his0KzjntCyq7XtbcJufTHvZlJoX7oOIbR7v3AxhxkpEE6t1+Q
 qgz+/JQPnrJk7zLw8e6JiJtA/RngAEjnhg+IfVxzzN4w4wtheTKNctwzj76GIZxid+wq
 Y8efd4NwSWM2fYMtl/ezHe9nMw5ilCR/pvsvrL8+scn6KbL9EoqQQgLsYe2qY/tpTayJ
 OHbw==
X-Gm-Message-State: AOAM532IEcCJw4f8XA2VzKMQRCXnbTYj8wu4N8M5mBjRlY6Y8wrm+D3g
 nlR0fjKyrBNnTVUUOU3OnJ09ug==
X-Google-Smtp-Source: ABdhPJxRu0VoqUcPCjhWA4e9T9eL6wi3abLupfoWkeRsvwpuApbmAfBt5KoSHidP76Od7GLEbDGsog==
X-Received: by 2002:a62:7ad0:0:b029:13e:d13d:a12f with SMTP id
 v199-20020a627ad00000b029013ed13da12fmr30431810pfc.23.1600418530025; 
 Fri, 18 Sep 2020 01:42:10 -0700 (PDT)
Received: from localhost.localdomain ([115.96.124.157])
 by smtp.googlemail.com with ESMTPSA id gi20sm2120603pjb.28.2020.09.18.01.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:42:09 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v10 10/13] piix4: don't reserve hw resources when hotplug is
 off globally
Date: Fri, 18 Sep 2020 14:11:08 +0530
Message-Id: <20200918084111.15339-11-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918084111.15339-1-ani@anisinha.ca>
References: <20200918084111.15339-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::542;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x542.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/acpi/piix4.c      |  6 ++++--
 hw/i386/acpi-build.c | 25 ++++++++++++++++++-------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index e6163bb6ce..b70b1f98af 100644
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
index e079b686f5..e41bb0992b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
     bool s3_disabled;
     bool s4_disabled;
     bool pcihp_bridge_en;
+    bool pcihp_root_en;
     uint8_t s4_val;
     AcpiFadtData fadt;
     uint16_t cpu_hp_io_base;
@@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
     pm->pcihp_bridge_en =
         object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
                                  NULL);
+    pm->pcihp_root_en =
+        object_property_get_bool(obj, "acpi-root-pci-hotplug",
+                                 NULL);
 }
 
 static void acpi_get_misc_info(AcpiMiscInfo *info)
@@ -450,10 +454,12 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
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
@@ -479,7 +485,10 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
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
 
@@ -1504,7 +1513,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
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
@@ -1546,7 +1557,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     {
         aml_append(scope, aml_name_decl("_HID", aml_string("ACPI0006")));
 
-        if (misc->is_piix4) {
+        if (misc->is_piix4 && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
             method = aml_method("_E01", 0, AML_NOTSERIALIZED);
             aml_append(method,
                 aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
@@ -1698,7 +1709,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     crs_range_set_free(&crs_range_set);
 
     /* reserve PCIHP resources */
-    if (pm->pcihp_io_len) {
+    if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
         dev = aml_device("PHPR");
         aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
         aml_append(dev,
-- 
2.17.1


