Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CC2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FDD20727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FDD20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZe8d-0003Zq-Ap
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@ani-sinha1.localdomain>)
 id 1jZe7l-0002bt-N9
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:27:53 -0400
Received: from [192.146.154.243] (port=18672 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@ani-sinha1.localdomain>)
 id 1jZe7k-0000zm-J5
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:27:53 -0400
Received: from ani-sinha1.localdomain (ani-sinha1.dev.nutanix.com
 [10.41.71.199])
 by mcp01.nutanix.com (Postfix) with ESMTP id F41251018F82;
 Fri, 15 May 2020 17:27:51 +0000 (UTC)
Received: by ani-sinha1.localdomain (Postfix, from userid 16671)
 id F15A86BCD; Fri, 15 May 2020 17:27:51 +0000 (UTC)
From: Ani Sinha <ani.sinha@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V2] Add a new PIIX option to control global PCI hot-plugging
Date: Fri, 15 May 2020 17:27:30 +0000
Message-Id: <1589563650-70820-2-git-send-email-ani.sinha@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589563650-70820-1-git-send-email-ani.sinha@nutanix.com>
References: <[PATCH] Add a new PIIX option to control global PCI hot-plugging>
 <1589563650-70820-1-git-send-email-ani.sinha@nutanix.com>
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.146.154.243 (failed)
Received-SPF: none client-ip=192.146.154.243;
 envelope-from=ani.sinha@ani-sinha1.localdomain; helo=mcp01.nutanix.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 13:27:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NO_DNS_FOR_FROM=0.001, RDNS_NONE=0.793,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Ani Sinha <ani.sinha@nutanix.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, ani@anisinha.ca,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A new option "acpi-pci-hotplug" is introduced for PIIX which will
globally disable hot-plugging of both hot plugged and
cold plugged PCI devices. This will prevent
hot-plugging and hot un-plugging of devices from within Windows based
guests using system tray.

The patch has been tested on Windows 2016.

Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
---
 hw/acpi/piix4.c      | 18 ++++++++++++------
 hw/i386/acpi-build.c | 46 ++++++++++++++++++++++++++++++----------------
 2 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 964d6f5..91b7e86 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
 
     AcpiPciHpState acpi_pci_hotplug;
     bool use_acpi_pci_hotplug;
+    bool use_acpi_hotplug_bridge;
 
     uint8_t disable_s3;
     uint8_t disable_s4;
@@ -207,13 +208,13 @@ static const VMStateDescription vmstate_pci_status = {
 static bool vmstate_test_use_acpi_pci_hotplug(void *opaque, int version_id)
 {
     PIIX4PMState *s = opaque;
-    return s->use_acpi_pci_hotplug;
+    return s->use_acpi_hotplug_bridge;
 }
 
 static bool vmstate_test_no_use_acpi_pci_hotplug(void *opaque, int version_id)
 {
     PIIX4PMState *s = opaque;
-    return !s->use_acpi_pci_hotplug;
+    return !s->use_acpi_hotplug_bridge;
 }
 
 static bool vmstate_test_use_memhp(void *opaque)
@@ -505,7 +506,10 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
 
     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
                                    pci_get_bus(dev), s);
-    qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s), &error_abort);
+    if (s->use_acpi_pci_hotplug) {
+        qbus_set_hotplug_handler(BUS(pci_get_bus(dev)),
+                                 OBJECT(s), &error_abort);
+    }
 
     piix4_pm_add_propeties(s);
 }
@@ -528,7 +532,7 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t smb_io_base,
     s->smi_irq = smi_irq;
     s->smm_enabled = smm_enabled;
     if (xen_enabled()) {
-        s->use_acpi_pci_hotplug = false;
+        s->use_acpi_hotplug_bridge = false;
     }
 
     qdev_init_nofail(dev);
@@ -593,7 +597,7 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
     memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
 
     acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
-                    s->use_acpi_pci_hotplug);
+                    s->use_acpi_hotplug_bridge);
 
     s->cpu_hotplug_legacy = true;
     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
@@ -631,8 +635,10 @@ static Property piix4_pm_properties[] = {
     DEFINE_PROP_UINT8(ACPI_PM_PROP_S3_DISABLED, PIIX4PMState, disable_s3, 0),
     DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_DISABLED, PIIX4PMState, disable_s4, 0),
     DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
-    DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
+    DEFINE_PROP_BOOL("acpi-pci-hotplug", PIIX4PMState,
                      use_acpi_pci_hotplug, true),
+    DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
+                     use_acpi_hotplug_bridge, true),
     DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
                      acpi_memory_hotplug.is_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2e15f68..1737378 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -96,6 +96,7 @@ typedef struct AcpiPmInfo {
     bool s3_disabled;
     bool s4_disabled;
     bool pcihp_bridge_en;
+    bool acpi_pcihp_en;
     uint8_t s4_val;
     AcpiFadtData fadt;
     uint16_t cpu_hp_io_base;
@@ -246,6 +247,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
     pm->pcihp_bridge_en =
         object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
                                  NULL);
+    pm->acpi_pcihp_en =
+        object_property_get_bool(obj, "acpi-pci-hotplug",
+                                 NULL);
 }
 
 static void acpi_get_misc_info(AcpiMiscInfo *info)
@@ -457,7 +461,8 @@ static void build_append_pcihp_notify_entry(Aml *method, int slot)
 }
 
 static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
-                                         bool pcihp_bridge_en)
+                                         bool pcihp_bridge_en,
+                                         bool acpi_pcihp_en)
 {
     Aml *dev, *notify_method = NULL, *method;
     QObject *bsel;
@@ -481,18 +486,25 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
         bool bridge_in_acpi;
 
         if (!pdev) {
-            if (bsel) { /* add hotplug slots for non present devices */
-                dev = aml_device("S%.02X", PCI_DEVFN(slot, 0));
-                aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
-                aml_append(dev, aml_name_decl("_ADR", aml_int(slot << 16)));
-                method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
-                aml_append(method,
-                    aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
-                );
-                aml_append(dev, method);
-                aml_append(parent_scope, dev);
-
-                build_append_pcihp_notify_entry(notify_method, slot);
+            if (bsel) {
+                /*
+                 * add hotplug slots for non present devices when
+                 * acpi hotplug is enabled.
+                 */
+                if (acpi_pcihp_en) {
+                    dev = aml_device("S%.02X", PCI_DEVFN(slot, 0));
+                    aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
+                    aml_append(dev, aml_name_decl("_ADR", aml_int(slot << 16)));
+                    method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
+                    aml_append(method,
+                               aml_call2("PCEJ", aml_name("BSEL"),
+                                         aml_name("_SUN"))
+                        );
+                    aml_append(dev, method);
+                    aml_append(parent_scope, dev);
+
+                    build_append_pcihp_notify_entry(notify_method, slot);
+                }
             }
             continue;
         }
@@ -539,7 +551,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
             method = aml_method("_S3D", 0, AML_NOTSERIALIZED);
             aml_append(method, aml_return(aml_int(s3d)));
             aml_append(dev, method);
-        } else if (hotplug_enabled_dev) {
+        } else if (hotplug_enabled_dev && acpi_pcihp_en) {
             /* add _SUN/_EJ0 to make slot hotpluggable  */
             aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
 
@@ -559,7 +571,8 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
              */
             PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
 
-            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
+            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,
+                                         acpi_pcihp_en);
         }
         /* slot descriptor has been composed, add it into parent context */
         aml_append(parent_scope, dev);
@@ -2197,7 +2210,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         if (bus) {
             Aml *scope = aml_scope("PCI0");
             /* Scan all PCI buses. Generate tables to support hotplug. */
-            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
+            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en,
+                                         pm->acpi_pcihp_en);
 
             if (TPM_IS_TIS_ISA(tpm)) {
                 if (misc->tpm_version == TPM_VERSION_2_0) {
-- 
1.9.4


