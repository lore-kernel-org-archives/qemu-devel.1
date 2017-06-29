Received: from eggs.gnu.org ([2001:4830:134:3::10]:34388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dQhQJ-0005kZ-JC
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dQhQF-0000QI-N6
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:56:27 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dQhQF-0000Po-Fg
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:56:23 -0400
Received: by mail-lf0-x244.google.com with SMTP id n136so8680200lfn.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 14:56:23 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Fri, 30 Jun 2017 00:55:58 +0300
Message-Id: <1498773362-18675-3-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
References: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH RFC 2/6] hw/acpi: simplify dsdt building code
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
 hw/i386/acpi-build.c | 59 +++++++++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6fce967..b0dcd34 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1886,7 +1886,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
     uint32_t nr_mem = machine->ram_slots;
     int root_bus_limit = 0xFF;
-    PCIBus *bus = NULL;
+    PCIBus *root_bus = NULL;
     int i;
 
     dsdt = init_aml_allocator();
@@ -1927,6 +1927,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_q35_pci0_int(dsdt);
     }
 
+    root_bus = PC_MACHINE(machine)->bus;
+    assert(root_bus);
+
     if (pcmc->legacy_cpu_hotplug) {
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
@@ -1961,8 +1964,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     aml_append(dsdt, scope);
 
     crs_range_set_init(&crs_range_set);
-    bus = PC_MACHINE(machine)->bus;
-    if (bus) {
+    {
+        PCIBus *bus = root_bus;
         QLIST_FOREACH(bus, &bus->child, sibling) {
             uint8_t bus_num = pci_bus_num(bus);
             uint8_t numa_node = pci_bus_numa_node(bus);
@@ -2206,38 +2209,28 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
     sb_scope = aml_scope("\\_SB");
     {
-        Object *pci_host;
-        PCIBus *bus = NULL;
-
-        pci_host = acpi_get_i386_pci_host();
-        if (pci_host) {
-            bus = PCI_HOST_BRIDGE(pci_host)->bus;
+        Aml *scope = aml_scope("PCI0");
+        /* Scan all PCI buses. Generate tables to support hotplug. */
+        build_append_pci_bus_devices(scope, root_bus, pm->pcihp_bridge_en);
+
+        if (misc->tpm_version != TPM_VERSION_UNSPEC) {
+            dev = aml_device("ISA.TPM");
+            aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
+            aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
+            crs = aml_resource_template();
+            aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
+                       TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
+            /*
+                FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
+                Rewrite to take IRQ from TPM device model and
+                fix default IRQ value there to use some unused IRQ
+             */
+            /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
+            aml_append(dev, aml_name_decl("_CRS", crs));
+            aml_append(scope, dev);
         }
 
-        if (bus) {
-            Aml *scope = aml_scope("PCI0");
-            /* Scan all PCI buses. Generate tables to support hotplug. */
-            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
-
-            if (misc->tpm_version != TPM_VERSION_UNSPEC) {
-                dev = aml_device("ISA.TPM");
-                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
-                aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
-                crs = aml_resource_template();
-                aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
-                           TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
-                /*
-                    FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
-                    Rewrite to take IRQ from TPM device model and
-                    fix default IRQ value there to use some unused IRQ
-                 */
-                /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
-                aml_append(dev, aml_name_decl("_CRS", crs));
-                aml_append(scope, dev);
-            }
-
-            aml_append(sb_scope, scope);
-        }
+        aml_append(sb_scope, scope);
     }
     aml_append(dsdt, sb_scope);
 
-- 
2.7.4
