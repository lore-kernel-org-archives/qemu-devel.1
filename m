Received: from eggs.gnu.org ([2001:4830:134:3::10]:39800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf7G-0001mS-HR
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf7D-0005lu-8t
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:7887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gEf7B-0004fU-BX
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:46 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 22 Oct 2018 20:36:56 +0200
Message-Id: <20181022183656.4902-27-sameo@linux.intel.com>
In-Reply-To: <20181022183656.4902-1-sameo@linux.intel.com>
References: <20181022183656.4902-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH 26/26] hw: acpi: reduced: Add PCI hotplug
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

In order to support PCI hotplug through a hardware-reduced GED, we need
to modify the GED device definition in the DSDT table, so that a PCI hotplug
related interrupt will trigger a new PCI scan.
We also need to modify the DSDT PCI bus definition in order to make sure
a PCI scan of all available slots can be performed when an interrupt
comes in.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 hw/acpi/aml-build.c | 8 +++++++-
 hw/acpi/reduced.c   | 7 +++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 752642a67a..99f04a3e71 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2510,7 +2510,7 @@ void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
 
 void acpi_dsdt_add_pci_bus(Aml *dsdt, AcpiPciBus *pci_host)
 {
-    Aml *dev, *pci_scope;
+    Aml *dev, *pci_scope, *hp_scope;
 
     dev = aml_device("\\_SB.PCI0");
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
@@ -2522,6 +2522,12 @@ void acpi_dsdt_add_pci_bus(Aml *dsdt, AcpiPciBus *pci_host)
     aml_append(dev, build_osc_method(0x1F));
     aml_append(dsdt, dev);
 
+    /* PCIHP */
+    hp_scope =  aml_scope("\\_SB.PCI0");
+    build_acpi_pci_hotplug(hp_scope);
+    build_append_pci_bus_devices(hp_scope, pci_host->pci_bus, false);
+    aml_append(dsdt, hp_scope);
+
     pci_scope = build_pci_host_bridge(dsdt, pci_host);
     aml_append(dsdt, pci_scope);
 }
diff --git a/hw/acpi/reduced.c b/hw/acpi/reduced.c
index fac19a978a..7faccdc634 100644
--- a/hw/acpi/reduced.c
+++ b/hw/acpi/reduced.c
@@ -331,6 +331,8 @@ void acpi_reduced_setup(MachineState *machine, AcpiConfiguration *conf)
 
 static Aml *ged_event_aml(GedEvent *event)
 {
+    Aml *method;
+
     if (!event) {
         return NULL;
     }
@@ -343,6 +345,11 @@ static Aml *ged_event_aml(GedEvent *event)
         /* We run a complete memory SCAN when getting a memory hotplug event */
         return aml_call0("\\_SB.MHPC." MEMORY_SLOT_SCAN_METHOD);
     case GED_PCI_HOTPLUG:
+        /* Take the PCI lock and trigger a PCI rescan */
+        method = aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF);
+        aml_append(method, aml_call0("\\_SB.PCI0.PCNT"));
+        aml_append(method, aml_release(aml_name("\\_SB.PCI0.BLCK")));
+        return method;
     case GED_NVDIMM_HOTPLUG:
         return aml_notify(aml_name("\\_SB.NVDR"), aml_int(0x80));
     default:
-- 
2.17.2
