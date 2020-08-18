Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785DAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FB320709
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0jnadWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FB320709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k89ai-0002hY-Gv
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 17:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1k89ZV-00018h-5T
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 17:55:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51181
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1k89ZT-0007fd-C1
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 17:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597787706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zRkoBhPPk1tgK/aHWbcM7m+I8n/pyxfQdRuXyWBtaOA=;
 b=M0jnadWlq0gAXSWVKhBrauWAtGIvjDIHbPX24KWjMkQTKXN4E97yzcVDFycDZlOy6bBtAW
 PiK+aeLAJAVVCdYuZt/biDEFK68Fa1um+DPIm7ifpP2uzwtws6ahBHdMKDFg47JWpeSjUj
 jClbbnzB2UmoAZa3lNqFBiYOmIBNCYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-ZrNY5CDePYquKKL-QovE3Q-1; Tue, 18 Aug 2020 17:55:05 -0400
X-MC-Unique: ZrNY5CDePYquKKL-QovE3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52BF9425D2;
 Tue, 18 Aug 2020 21:55:04 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.2.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED99A1014182;
 Tue, 18 Aug 2020 21:55:02 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 2/4] hw/i386/acpi-build: Add ACPI PCI hot-plug methods
 to q35
Date: Tue, 18 Aug 2020 23:52:25 +0200
Message-Id: <20200818215227.181654-3-jusual@redhat.com>
In-Reply-To: <20200818215227.181654-1-jusual@redhat.com>
References: <20200818215227.181654-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jusual@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jusual@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 17:55:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement notifications and gpe to support q35 ACPI PCI hot-plug.
Use 0xcc4 - 0xcd7 range for 'acpi-pci-hotplug' io ports.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 include/hw/acpi/pcihp.h |  3 ++-
 hw/acpi/pcihp.c         | 10 ++++++----
 hw/acpi/piix4.c         |  2 +-
 hw/i386/acpi-build.c    | 25 ++++++++++++++-----------
 4 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index 8bc4a4c01d..1e9d246f57 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -54,7 +54,8 @@ typedef struct AcpiPciHpState {
 } AcpiPciHpState;
 
 void acpi_pcihp_init(Object *owner, AcpiPciHpState *, PCIBus *root,
-                     MemoryRegion *address_space_io, bool bridges_enabled);
+                     MemoryRegion *address_space_io, bool bridges_enabled,
+                     bool is_piix4);
 
 void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp);
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 9e31ab2da4..9a35ed6c83 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -38,7 +38,8 @@
 #include "qom/qom-qobject.h"
 #include "trace.h"
 
-#define ACPI_PCIHP_ADDR 0xae00
+#define ACPI_PCIHP_ADDR_PIIX4 0xae00
+#define ACPI_PCIHP_ADDR_Q35 0x0cc4
 #define ACPI_PCIHP_SIZE 0x0014
 #define PCI_UP_BASE 0x0000
 #define PCI_DOWN_BASE 0x0004
@@ -359,12 +360,13 @@ static const MemoryRegionOps acpi_pcihp_io_ops = {
 };
 
 void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
-                     MemoryRegion *address_space_io, bool bridges_enabled)
+                     MemoryRegion *address_space_io, bool bridges_enabled,
+                     bool is_piix4)
 {
     s->io_len = ACPI_PCIHP_SIZE;
-    s->io_base = ACPI_PCIHP_ADDR;
+    s->io_base = is_piix4 ? ACPI_PCIHP_ADDR_PIIX4 : ACPI_PCIHP_ADDR_Q35;
 
-    s->root= root_bus;
+    s->root = root_bus;
     s->legacy_piix = !bridges_enabled;
 
     memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index cdfa0e2998..1f27bfbd06 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -596,7 +596,7 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
     memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
 
     acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
-                    s->use_acpi_hotplug_bridge);
+                    s->use_acpi_hotplug_bridge, true);
 
     s->cpu_hotplug_legacy = true;
     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b7bcbbbb2a..f3cd52bd06 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -201,10 +201,6 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
         /* w2k requires FADT(rev1) or it won't boot, keep PC compatible */
         pm->fadt.rev = 1;
         pm->cpu_hp_io_base = PIIX4_CPU_HOTPLUG_IO_BASE;
-        pm->pcihp_io_base =
-            object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
-        pm->pcihp_io_len =
-            object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
     }
     if (lpc) {
         struct AcpiGenericAddress r = { .space_id = AML_AS_SYSTEM_IO,
@@ -214,6 +210,10 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
         pm->fadt.flags |= 1 << ACPI_FADT_F_RESET_REG_SUP;
         pm->cpu_hp_io_base = ICH9_CPU_HOTPLUG_IO_BASE;
     }
+    pm->pcihp_io_base =
+        object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
+    pm->pcihp_io_len =
+        object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
 
     /* The above need not be conditional on machine type because the reset port
      * happens to be the same on PIIX (pc) and ICH9 (q35). */
@@ -472,7 +472,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
         QLIST_FOREACH(sec, &bus->child, sibling) {
             int32_t devfn = sec->parent_dev->devfn;
 
-            if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {
+            if (pci_bus_is_root(sec)) {
                 continue;
             }
 
@@ -1368,7 +1368,7 @@ static void build_piix4_isa_bridge(Aml *table)
     aml_append(table, scope);
 }
 
-static void build_piix4_pci_hotplug(Aml *table)
+static void build_i386_pci_hotplug(Aml *table, uint64_t pcihp_addr)
 {
     Aml *scope;
     Aml *field;
@@ -1377,20 +1377,22 @@ static void build_piix4_pci_hotplug(Aml *table)
     scope =  aml_scope("_SB.PCI0");
 
     aml_append(scope,
-        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(0xae00), 0x08));
+        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(pcihp_addr), 0x08));
     field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
     aml_append(field, aml_named_field("PCIU", 32));
     aml_append(field, aml_named_field("PCID", 32));
     aml_append(scope, field);
 
     aml_append(scope,
-        aml_operation_region("SEJ", AML_SYSTEM_IO, aml_int(0xae08), 0x04));
+    aml_operation_region("SEJ", AML_SYSTEM_IO,
+                         aml_int(pcihp_addr + 0x08), 0x04));
     field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
     aml_append(field, aml_named_field("B0EJ", 32));
     aml_append(scope, field);
 
     aml_append(scope,
-        aml_operation_region("BNMR", AML_SYSTEM_IO, aml_int(0xae10), 0x04));
+        aml_operation_region("BNMR", AML_SYSTEM_IO,
+                             aml_int(pcihp_addr + 0x10), 0x04));
     field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
     aml_append(field, aml_named_field("BNUM", 32));
     aml_append(scope, field);
@@ -1504,7 +1506,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_hpet_aml(dsdt);
         build_piix4_isa_bridge(dsdt);
         build_isa_devices_aml(dsdt);
-        build_piix4_pci_hotplug(dsdt);
         build_piix4_pci0_int(dsdt);
     } else {
         sb_scope = aml_scope("_SB");
@@ -1526,6 +1527,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         }
     }
 
+    build_i386_pci_hotplug(dsdt, pm->pcihp_io_base);
+
     if (pcmc->legacy_cpu_hotplug) {
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
@@ -1546,7 +1549,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     {
         aml_append(scope, aml_name_decl("_HID", aml_string("ACPI0006")));
 
-        if (misc->is_piix4) {
+        if (misc->is_piix4 || pm->pcihp_bridge_en) {
             method = aml_method("_E01", 0, AML_NOTSERIALIZED);
             aml_append(method,
                 aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
-- 
2.25.4


