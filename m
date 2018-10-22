Received: from eggs.gnu.org ([2001:4830:134:3::10]:39467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf6T-00012Z-TH
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf6P-0004ug-8J
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:7887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gEf6N-0004fU-4j
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:38:55 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 22 Oct 2018 20:36:47 +0200
Message-Id: <20181022183656.4902-18-sameo@linux.intel.com>
In-Reply-To: <20181022183656.4902-1-sameo@linux.intel.com>
References: <20181022183656.4902-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH 17/26] hw: i386: Convert PC machine type to
 firmware build methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

All PC machine type derivatives will use the same ACPI table build
methods. But with that change in place, any new x86 machine type will be
able to re-use the acpi-build API and customize part of it by defining
its own ACPI table build methods.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/i386/acpi-build.c   | 22 ++++++++++++++--------
 hw/i386/pc.c           |  9 +++++++++
 include/hw/i386/acpi.h | 27 +++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 8 deletions(-)
 create mode 100644 include/hw/i386/acpi.h

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9cb739bf5c..4274349053 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -62,6 +62,7 @@
 #include "qom/qom-qobject.h"
 #include "hw/i386/amd_iommu.h"
 #include "hw/i386/intel_iommu.h"
+#include "hw/i386/acpi.h"
 
 #include "hw/acpi/ipmi.h"
 
@@ -281,9 +282,8 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
     }
 }
 
-static void
-build_madt(GArray *table_data, BIOSLinker *linker,
-           MachineState *ms, AcpiConfiguration *conf)
+GArray *build_madt(GArray *table_data, BIOSLinker *linker,
+                   MachineState *ms, AcpiConfiguration *conf)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(ms);
@@ -360,6 +360,8 @@ build_madt(GArray *table_data, BIOSLinker *linker,
     build_header(linker, table_data,
                  (void *)(table_data->data + madt_start), "APIC",
                  table_data->len - madt_start, 1, NULL, NULL);
+
+    return table_data;
 }
 
 static void build_hpet_aml(Aml *table)
@@ -1544,6 +1546,7 @@ static
 void acpi_build(AcpiBuildTables *tables,
                 MachineState *machine, AcpiConfiguration *conf)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     GArray *table_offsets;
     unsigned facs, dsdt, rsdt, fadt;
     AcpiPmInfo pm;
@@ -1604,7 +1607,8 @@ void acpi_build(AcpiBuildTables *tables,
     aml_len += tables_blob->len - fadt;
 
     acpi_add_table(table_offsets, tables_blob);
-    build_madt(tables_blob, tables->linker, machine, conf);
+    mc->firmware_build_methods.acpi.madt(tables_blob, tables->linker,
+                                         machine, conf);
 
     vmgenid_dev = find_vmgenid_dev();
     if (vmgenid_dev) {
@@ -1628,15 +1632,17 @@ void acpi_build(AcpiBuildTables *tables,
     }
     if (conf->numa_nodes) {
         acpi_add_table(table_offsets, tables_blob);
-        build_srat(tables_blob, tables->linker, machine, conf);
+        mc->firmware_build_methods.acpi.srat(tables_blob, tables->linker,
+                                             machine, conf);
         if (have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
-            build_slit(tables_blob, tables->linker);
+            mc->firmware_build_methods.acpi.slit(tables_blob, tables->linker);
         }
     }
     if (acpi_get_mcfg(&mcfg)) {
         acpi_add_table(table_offsets, tables_blob);
-        build_mcfg(tables_blob, tables->linker, &mcfg);
+        mc->firmware_build_methods.acpi.mcfg(tables_blob, tables->linker,
+                                             &mcfg);
     }
     if (x86_iommu_get_default()) {
         IommuType IOMMUType = x86_iommu_get_type();
@@ -1667,7 +1673,7 @@ void acpi_build(AcpiBuildTables *tables,
                slic_oem.id, slic_oem.table_id);
 
     /* RSDP is in FSEG memory, so allocate it separately */
-    build_rsdp_rsdt(tables->rsdp, tables->linker, rsdt);
+    mc->firmware_build_methods.acpi.rsdp(tables->rsdp, tables->linker, rsdt);
 
     /* We'll expose it all to Guest so we want to reduce
      * chance of size changes.
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index fa12583096..db69dbfef7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -75,6 +75,7 @@
 #include "hw/nmi.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
+#include "hw/i386/acpi.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -2443,6 +2444,14 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     nc->nmi_monitor_handler = x86_nmi;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
 
+    /* Firmware building handler */
+    mc->firmware_build_methods.acpi.madt = build_madt;
+    mc->firmware_build_methods.acpi.rsdp = build_rsdp_rsdt;
+    mc->firmware_build_methods.acpi.setup = acpi_setup;
+    mc->firmware_build_methods.acpi.mcfg = build_mcfg;
+    mc->firmware_build_methods.acpi.srat = build_srat;
+    mc->firmware_build_methods.acpi.slit = build_slit;
+
     object_class_property_add(oc, MEMORY_DEVICE_REGION_SIZE, "int",
         pc_machine_get_device_memory_region_size, NULL,
         NULL, NULL, &error_abort);
diff --git a/include/hw/i386/acpi.h b/include/hw/i386/acpi.h
new file mode 100644
index 0000000000..d92c29350b
--- /dev/null
+++ b/include/hw/i386/acpi.h
@@ -0,0 +1,27 @@
+/*
+ *
+ * Copyright (c) 2018 Intel Corportation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef QEMU_I386_ACPI_H
+#define QEMU_I386_ACPI_H
+
+#include "hw/acpi/acpi.h"
+
+/* Build methods */
+GArray *build_madt(GArray *table_data, BIOSLinker *linker,
+                   MachineState *ms, AcpiConfiguration *conf);
+
+#endif
-- 
2.17.2
