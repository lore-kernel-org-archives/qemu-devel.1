Received: from eggs.gnu.org ([2001:4830:134:3::10]:39637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf6p-0001Js-2a
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf6f-0005JI-DC
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:7889)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gEf6e-0004iw-WB
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:13 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 22 Oct 2018 20:36:51 +0200
Message-Id: <20181022183656.4902-22-sameo@linux.intel.com>
In-Reply-To: <20181022183656.4902-1-sameo@linux.intel.com>
References: <20181022183656.4902-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH 21/26] hw: acpi: reduced: Add memory hotplug
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
Cc: Yang Zhong <yang.zhong@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Yang Zhong <yang.zhong@intel.com>

We add the memory hotplug AML code to the hardware-reduced DSDT.
The memory hotplug event is handled through the GED device.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 hw/acpi/reduced.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/reduced.c b/hw/acpi/reduced.c
index 53b57760eb..33d413a255 100644
--- a/hw/acpi/reduced.c
+++ b/hw/acpi/reduced.c
@@ -33,6 +33,7 @@
 #include "hw/acpi/cpu.h"
 #include "hw/acpi/pc-hotplug.h"
 #include "hw/acpi/reduced.h"
+#include "hw/acpi/memory_hotplug.h"
 
 #include "hw/nvram/fw_cfg.h"
 
@@ -46,7 +47,16 @@
 
 #include "migration/vmstate.h"
 
-#define GED_DEVICE "GED"
+#define GED_DEVICE               "GED"
+#define CPU_SCAN_METHOD          "CSCN"
+#define MEMORY_SLOT_SCAN_METHOD  "MSCN"
+
+static void acpi_dsdt_add_memory_hotplug(MachineState *ms, Aml *dsdt)
+{
+    uint32_t nr_mem = ms->ram_slots;
+
+    build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB", NULL);
+}
 
 static void acpi_dsdt_add_cpus(MachineState *ms, Aml *dsdt, Aml *scope,
                                int smp_cpus, AcpiConfiguration *conf)
@@ -85,6 +95,7 @@ static void build_dsdt(MachineState *ms,
     if (pci_host->pci_bus) {
         acpi_dsdt_add_pci_bus(dsdt, pci_host);
     }
+    acpi_dsdt_add_memory_hotplug(ms, dsdt);
     acpi_dsdt_add_cpus(ms, dsdt, scope, smp_cpus, conf);
     acpi_dsdt_add_ged(dsdt, conf);
     aml_append(dsdt, scope);
@@ -283,8 +294,6 @@ void acpi_reduced_setup(MachineState *machine, AcpiConfiguration *conf)
     acpi_build_tables_cleanup(&tables, false);
 }
 
-#define CPU_SCAN_METHOD   "CSCN"
-
 static Aml *ged_event_aml(GedEvent *event)
 {
     if (!event) {
@@ -296,6 +305,8 @@ static Aml *ged_event_aml(GedEvent *event)
         /* We run a complete CPU SCAN when getting a CPU hotplug event */
         return aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD);
     case GED_MEMORY_HOTPLUG:
+        /* We run a complete memory SCAN when getting a memory hotplug event */
+        return aml_call0("\\_SB.MHPC." MEMORY_SLOT_SCAN_METHOD);
     case GED_PCI_HOTPLUG:
     case GED_NVDIMM_HOTPLUG:
         /* Not supported for now */
-- 
2.17.2
