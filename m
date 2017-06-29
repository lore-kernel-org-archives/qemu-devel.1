Received: from eggs.gnu.org ([2001:4830:134:3::10]:34425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dQhQL-0005kz-JF
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dQhQK-0000Sg-Mr
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:56:29 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dQhQK-0000Rs-Bk
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:56:28 -0400
Received: by mail-lf0-x242.google.com with SMTP id n136so8680281lfn.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 14:56:28 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Fri, 30 Jun 2017 00:56:01 +0300
Message-Id: <1498773362-18675-6-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
References: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH RFC 5/6] hw/acpi: extend acpi pci hotplug
 support for pci express
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 hw/i386/acpi-build.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e434efe..8bbece5 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -254,6 +254,11 @@ static void acpi_get_pci_holes(Range *hole, Range *hole64)
                                               NULL));
 }
 
+static void acpi_test_pci_bus(PCIBus *bus, void *opaque)
+{
+    *(bool *)opaque |= !pci_bus_is_express(bus);
+}
+
 #define ACPI_PORT_SMI_CMD           0x00b2 /* TODO: this is APM_CNT_IOPORT */
 
 static void acpi_align_size(GArray *blob, unsigned align)
@@ -489,7 +494,7 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
     unsigned *bsel_alloc = opaque;
     unsigned *bus_bsel;
 
-    if (qbus_is_hotpluggable(BUS(bus))) {
+    if (qbus_is_hotpluggable(BUS(bus)) && !pci_bus_is_express(bus)) {
         bus_bsel = g_malloc(sizeof *bus_bsel);
 
         *bus_bsel = (*bsel_alloc)++;
@@ -500,15 +505,12 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
     return bsel_alloc;
 }
 
-static void acpi_set_pci_info(void)
+static void acpi_set_pci_info(PCIBus *bus)
 {
-    PCIBus *bus = find_i440fx(); /* TODO: Q35 support */
     unsigned bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT;
 
-    if (bus) {
-        /* Scan all PCI buses. Set property to enable acpi based hotplug. */
-        pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_alloc);
-    }
+    /* Scan all PCI buses. Set property to enable acpi based hotplug. */
+    pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_alloc);
 }
 
 static void build_append_pcihp_notify_entry(Aml *method, int slot)
@@ -570,7 +572,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
          * In this case they aren't themselves hot-pluggable.
          * Hotplugged bridges *are* hot-pluggable.
          */
-        bridge_in_acpi = pc->is_bridge && pcihp_bridge_en &&
+        bridge_in_acpi = pc->is_bridge && !pc->is_express && pcihp_bridge_en &&
             !DEVICE(pdev)->hotplugged;
 
         hotplug_enabled_dev = bsel && dc->hotpluggable && !bridge_in_acpi;
@@ -1787,7 +1789,7 @@ static void build_piix4_isa_bridge(Aml *table)
     aml_append(table, scope);
 }
 
-static void build_piix4_pci_hotplug(Aml *table)
+static void build_acpi_pci_hotplug(Aml *table)
 {
     Aml *scope;
     Aml *field;
@@ -1889,6 +1891,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     uint32_t nr_mem = machine->ram_slots;
     int root_bus_limit = 0xFF;
     PCIBus *root_bus = NULL;
+    bool has_pci_bus = false;
     int i;
 
     dsdt = init_aml_allocator();
@@ -1910,7 +1913,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_piix4_pm(dsdt);
         build_piix4_isa_bridge(dsdt);
         build_isa_devices_aml(dsdt);
-        build_piix4_pci_hotplug(dsdt);
         build_piix4_pci0_int(dsdt);
     } else {
         sb_scope = aml_scope("_SB");
@@ -1932,6 +1934,11 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     root_bus = PC_MACHINE(machine)->bus;
     assert(root_bus);
 
+    pci_for_each_bus(root_bus, acpi_test_pci_bus, &has_pci_bus);
+    if (pm->pcihp_bridge_en && has_pci_bus) {
+        build_acpi_pci_hotplug(dsdt);
+    }
+
     if (pcmc->legacy_cpu_hotplug) {
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
@@ -1947,7 +1954,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     {
         aml_append(scope, aml_name_decl("_HID", aml_string("ACPI0006")));
 
-        if (misc->is_piix4) {
+        if (pm->pcihp_bridge_en && has_pci_bus) {
             method = aml_method("_E01", 0, AML_NOTSERIALIZED);
             aml_append(method,
                 aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
@@ -2080,7 +2087,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     crs_range_set_free(&crs_range_set);
 
     /* reserve PCIHP resources */
-    if (pm->pcihp_io_len) {
+    if (pm->pcihp_bridge_en && has_pci_bus && pm->pcihp_io_len) {
         dev = aml_device("PHPR");
         aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
         aml_append(dev,
@@ -2212,8 +2219,13 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     sb_scope = aml_scope("\\_SB");
     {
         Aml *scope = aml_scope("PCI0");
-        /* Scan all PCI buses. Generate tables to support hotplug. */
-        build_append_pci_bus_devices(scope, root_bus, pm->pcihp_bridge_en);
+        bool scope_used = false;
+
+        if (pm->pcihp_bridge_en && has_pci_bus) {
+            /* Scan all PCI buses. Generate tables to support hotplug. */
+            build_append_pci_bus_devices(scope, root_bus, pm->pcihp_bridge_en);
+            scope_used = true;
+        }
 
         if (misc->tpm_version != TPM_VERSION_UNSPEC) {
             dev = aml_device("ISA.TPM");
@@ -2230,9 +2242,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
             aml_append(dev, aml_name_decl("_CRS", crs));
             aml_append(scope, dev);
+            scope_used = true;
         }
 
-        aml_append(sb_scope, scope);
+        if (scope_used) {
+            aml_append(sb_scope, scope);
+        }
     }
     aml_append(dsdt, sb_scope);
 
@@ -2866,7 +2881,7 @@ void acpi_setup(void)
 
     build_state = g_malloc0(sizeof *build_state);
 
-    acpi_set_pci_info();
+    acpi_set_pci_info(pcms->bus);
 
     acpi_build_tables_init(&tables);
     acpi_build(&tables, MACHINE(pcms));
-- 
2.7.4
