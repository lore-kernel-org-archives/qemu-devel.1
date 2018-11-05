Received: from eggs.gnu.org ([2001:4830:134:3::10]:47421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJTvc-0000rZ-H3
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 20:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJTvb-0003mG-4Q
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 20:43:44 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon,  5 Nov 2018 02:40:44 +0100
Message-Id: <20181105014047.26447-22-sameo@linux.intel.com>
In-Reply-To: <20181105014047.26447-1-sameo@linux.intel.com>
References: <20181105014047.26447-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 21/24] hw: i386: Implement the ACPI builder
 interface for PC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

All PC machine type derivatives will use the same ACPI table build
methods. But with that change in place, any new x86 machine type will be
able to re-use the acpi-build API and customize part of it by defining
its own ACPI table build methods.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/i386/acpi-build.c | 14 +++++++++-----
 hw/i386/pc.c         | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4b1d8fbe3f..93d89b96f1 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -34,6 +34,7 @@
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/cpu.h"
+#include "hw/acpi/builder.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/loader.h"
 #include "hw/isa/isa.h"
@@ -1683,6 +1684,7 @@ void acpi_build(AcpiBuildTables *tables,
     GArray *tables_blob = tables->table_data;
     AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
     Object *vmgenid_dev;
+    AcpiBuilder *ab = ACPI_BUILDER(machine);
 
     acpi_get_pm_info(&pm);
     acpi_get_misc_info(&misc);
@@ -1732,7 +1734,8 @@ void acpi_build(AcpiBuildTables *tables,
     aml_len += tables_blob->len - fadt;
 
     acpi_add_table(table_offsets, tables_blob);
-    build_madt(tables_blob, tables->linker, machine, acpi_conf);
+    acpi_builder_madt(ab, tables_blob, tables->linker,
+                      machine, acpi_conf);
 
     vmgenid_dev = find_vmgenid_dev();
     if (vmgenid_dev) {
@@ -1756,15 +1759,16 @@ void acpi_build(AcpiBuildTables *tables,
     }
     if (acpi_conf->numa_nodes) {
         acpi_add_table(table_offsets, tables_blob);
-        build_srat(tables_blob, tables->linker, machine, acpi_conf);
+        acpi_builder_srat(ab, tables_blob, tables->linker,
+                          machine, acpi_conf);
         if (have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
-            build_slit(tables_blob, tables->linker);
+            acpi_builder_slit(ab, tables_blob, tables->linker);
         }
     }
     if (acpi_get_mcfg(&mcfg)) {
         acpi_add_table(table_offsets, tables_blob);
-        build_mcfg(tables_blob, tables->linker, &mcfg);
+        acpi_builder_mcfg(ab, tables_blob, tables->linker, &mcfg);
     }
     if (x86_iommu_get_default()) {
         IommuType IOMMUType = x86_iommu_get_type();
@@ -1795,7 +1799,7 @@ void acpi_build(AcpiBuildTables *tables,
                slic_oem.id, slic_oem.table_id);
 
     /* RSDP is in FSEG memory, so allocate it separately */
-    build_rsdp_rsdt(tables->rsdp, tables->linker, rsdt);
+    acpi_builder_rsdp(ab, tables->rsdp, tables->linker, rsdt);
 
     /* We'll expose it all to Guest so we want to reduce
      * chance of size changes.
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c9ffc8cff6..53a3036066 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -64,6 +64,7 @@
 #include "qemu/option.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/cpu_hotplug.h"
+#include "hw/acpi/builder.h"
 #include "hw/boards.h"
 #include "acpi-build.h"
 #include "hw/mem/pc-dimm.h"
@@ -75,6 +76,7 @@
 #include "hw/nmi.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
+#include "hw/i386/acpi.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -2404,12 +2406,20 @@ static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+static AcpiConfiguration *pc_acpi_configuration(AcpiBuilder *builder)
+{
+    PCMachineState *pcms = PC_MACHINE(builder);
+
+    return &pcms->acpi_configuration;
+}
+
 static void pc_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     PCMachineClass *pcmc = PC_MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
+    AcpiBuilderMethods *abm = ACPI_BUILDER_METHODS(oc);
 
     pcmc->pci_enabled = true;
     pcmc->has_acpi_build = true;
@@ -2444,6 +2454,14 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     nc->nmi_monitor_handler = x86_nmi;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
 
+    /* ACPI building methods */
+    abm->madt = build_madt;
+    abm->rsdp = build_rsdp_rsdt;
+    abm->mcfg = build_mcfg;
+    abm->srat = build_srat;
+    abm->slit = build_slit;
+    abm->configuration = pc_acpi_configuration;
+
     object_class_property_add(oc, MEMORY_DEVICE_REGION_SIZE, "int",
         pc_machine_get_device_memory_region_size, NULL,
         NULL, NULL, &error_abort);
@@ -2495,6 +2513,7 @@ static const TypeInfo pc_machine_info = {
     .interfaces = (InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { TYPE_NMI },
+         { TYPE_ACPI_BUILDER },
          { }
     },
 };
-- 
2.19.1
