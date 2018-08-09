Received: from eggs.gnu.org ([2001:4830:134:3::10]:58872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fneXO-00027H-5A
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fneWu-0008OZ-Jm
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:35:10 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:39172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fneWu-0008OC-Ct
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:34:40 -0400
Received: by mail-qt0-x242.google.com with SMTP id q12-v6so5388513qtp.6
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 23:34:40 -0700 (PDT)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Thu,  9 Aug 2018 14:34:18 +0800
Message-Id: <1533796458-22306-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [RFC v4 3/6] i386/acpi-build: describe new pci domain
 in AML
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Describe new pci segments of host bridges in AML as new pci devices,
with _SEG and _BBN to let them be in DSDT.

Besides, bus_nr indicates the bus number of pxb-pcie under pcie.0 bus,
but since we put it into separate domain, it should be zero, which is
equal to BBN.

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 hw/i386/acpi-build.c                | 63 ++++++++++++++++++++-----------------
 hw/pci-bridge/pci_expander_bridge.c |  8 +++++
 hw/pci/pci.c                        |  5 +++
 include/hw/pci/pci.h                |  1 +
 include/hw/pci/pci_bus.h            |  1 +
 5 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index c0fc2b4..a7d9af2 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -828,7 +828,7 @@ static Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
     Aml *crs = aml_resource_template();
     CrsRangeSet temp_range_set;
     CrsRangeEntry *entry;
-    uint8_t max_bus = pci_bus_num(host->bus);
+    uint8_t max_bus = 0, host_bus = 0;
     uint8_t type;
     int devfn;
     int i;
@@ -967,10 +967,10 @@ static Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
     aml_append(crs,
         aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
                             0,
-                            pci_bus_num(host->bus),
+                            host_bus,
                             max_bus,
                             0,
-                            max_bus - pci_bus_num(host->bus) + 1));
+                            max_bus - host_bus + 1));
 
     return crs;
 }
@@ -1832,6 +1832,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dev, aml_name_decl("_UID", aml_int(1)));
         aml_append(dev, build_q35_osc_method());
         aml_append(sb_scope, dev);
+
         aml_append(dsdt, sb_scope);
 
         build_hpet_aml(dsdt);
@@ -1875,10 +1876,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
     crs_range_set_init(&crs_range_set);
     bus = PC_MACHINE(machine)->bus;
+    i = 1; // PCI0 is q35 host, pxb starts from 1
     if (bus) {
         QLIST_FOREACH(bus, &bus->child, sibling) {
             uint8_t bus_num = pci_bus_num(bus);
             uint8_t numa_node = pci_bus_numa_node(bus);
+            int domain_nr = pci_domain_num(bus);
 
             /* look only for expander root buses */
             if (!pci_bus_is_root(bus)) {
@@ -1890,10 +1893,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             }
 
             scope = aml_scope("\\_SB");
-            dev = aml_device("PC%.02X", bus_num);
+            dev = aml_device("PCI%d", i++);
             aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
             aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
-            aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
+            aml_append(dev, aml_name_decl("_ADR", aml_int(bus_num)));
+            aml_append(dev, aml_name_decl("_SEG", aml_int(domain_nr)));
+            aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
             if (pci_bus_is_express(bus)) {
                 aml_append(dev, build_q35_osc_method());
             }
@@ -2126,35 +2131,37 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     {
         Object *pci_host;
         PCIBus *bus = NULL;
+        int index = 0;
 
         pci_host = acpi_get_i386_pci_host();
-        if (pci_host) {
+        while (pci_host) {
             bus = PCI_HOST_BRIDGE(pci_host)->bus;
-        }
+            if (bus) {
+                Aml *scope = aml_scope("PCI%d", index);
+                /* Scan all PCI buses. Generate tables to support hotplug. */
+                build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
 
-        if (bus) {
-            Aml *scope = aml_scope("PCI0");
-            /* Scan all PCI buses. Generate tables to support hotplug. */
-            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
+                /* Only add TPM once */
+                if (index++ == 0 && TPM_IS_TIS(tpm_find())) {
+                    dev = aml_device("ISA.TPM");
+                    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
+                    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
+                    crs = aml_resource_template();
+                    aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
+                               TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
+                    /*
+                        FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
+                        Rewrite to take IRQ from TPM device model and
+                        fix default IRQ value there to use some unused IRQ
+                     */
+                    /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
+                    aml_append(dev, aml_name_decl("_CRS", crs));
+                    aml_append(scope, dev);
+                }
 
-            if (TPM_IS_TIS(tpm_find())) {
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
+                aml_append(sb_scope, scope);
             }
-
-            aml_append(sb_scope, scope);
+            pci_host = OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_host), next));
         }
     }
 
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index f50938f..d28a64c 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -87,6 +87,13 @@ static int pxb_bus_num(PCIBus *bus)
     return pxb->bus_nr;
 }
 
+static int pxb_domain_num(PCIBus *bus)
+{
+    PXBDev *pxb = convert_to_pxb(bus->parent_dev);
+
+    return pxb->domain_nr;
+}
+
 static bool pxb_is_root(PCIBus *bus)
 {
     return true; /* by definition */
@@ -104,6 +111,7 @@ static void pxb_bus_class_init(ObjectClass *class, void *data)
     PCIBusClass *pbc = PCI_BUS_CLASS(class);
 
     pbc->bus_num = pxb_bus_num;
+    pbc->domain_num = pxb_domain_num;
     pbc->is_root = pxb_is_root;
     pbc->numa_node = pxb_bus_numa_node;
 }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index ddc27ba..e72887f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -445,6 +445,11 @@ int pci_bus_num(PCIBus *s)
     return PCI_BUS_GET_CLASS(s)->bus_num(s);
 }
 
+int pci_domain_num(PCIBus *s)
+{
+    return PCI_BUS_GET_CLASS(s)->domain_num(s);
+}
+
 int pci_bus_numa_node(PCIBus *bus)
 {
     return PCI_BUS_GET_CLASS(bus)->numa_node(bus);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 990d6fc..de514d3 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -436,6 +436,7 @@ static inline PCIBus *pci_get_bus(const PCIDevice *dev)
     return PCI_BUS(qdev_get_parent_bus(DEVICE(dev)));
 }
 int pci_bus_num(PCIBus *s);
+int pci_domain_num(PCIBus *s);
 static inline int pci_dev_bus_num(const PCIDevice *dev)
 {
     return pci_bus_num(pci_get_bus(dev));
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index b7da8f5..415da90 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -15,6 +15,7 @@ typedef struct PCIBusClass {
 
     bool (*is_root)(PCIBus *bus);
     int (*bus_num)(PCIBus *bus);
+    int (*domain_num)(PCIBus *bus);
     uint16_t (*numa_node)(PCIBus *bus);
 } PCIBusClass;
 
-- 
2.7.4
