Received: from eggs.gnu.org ([2001:4830:134:3::10]:59704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAN7-0000tO-Fq
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAN3-0008DV-Oe
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:26:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:12997)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gHAN0-00085O-8n
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:26:27 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 29 Oct 2018 17:24:40 +0100
Message-Id: <20181029162441.31631-19-sameo@linux.intel.com>
In-Reply-To: <20181029162441.31631-1-sameo@linux.intel.com>
References: <20181029162441.31631-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 18/19] hw: i386: Export the MADT build method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It is going to be used by the PC machine type as the MADT table builder
method and thus needs to be exported outside of acpi-build.c

Also, now that the generic build_madt() API is exported, we have to
rename the ARM static one in order to avoid build time conflicts.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/arm/virt-acpi-build.c |  4 ++--
 hw/i386/acpi-build.c     |  3 ++-
 include/hw/i386/acpi.h   | 27 +++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)
 create mode 100644 include/hw/i386/acpi.h

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 353aa55357..0c349e1c60 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -565,7 +565,7 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
 /* MADT */
 static void
-build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
+virt_build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     int madt_start = table_data->len;
@@ -746,7 +746,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     build_fadt_rev5(tables_blob, tables->linker, vms, dsdt);
 
     acpi_add_table(table_offsets, tables_blob);
-    build_madt(tables_blob, tables->linker, vms);
+    virt_build_madt(tables_blob, tables->linker, vms);
 
     acpi_add_table(table_offsets, tables_blob);
     build_gtdt(tables_blob, tables->linker, vms);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9cb739bf5c..5035dac556 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -62,6 +62,7 @@
 #include "qom/qom-qobject.h"
 #include "hw/i386/amd_iommu.h"
 #include "hw/i386/intel_iommu.h"
+#include "hw/i386/acpi.h"
 
 #include "hw/acpi/ipmi.h"
 
@@ -281,7 +282,7 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
     }
 }
 
-static void
+void
 build_madt(GArray *table_data, BIOSLinker *linker,
            MachineState *ms, AcpiConfiguration *conf)
 {
diff --git a/include/hw/i386/acpi.h b/include/hw/i386/acpi.h
new file mode 100644
index 0000000000..53bf94c3ca
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
+void build_madt(GArray *table_data, BIOSLinker *linker,
+                MachineState *ms, AcpiConfiguration *conf);
+
+#endif
-- 
2.17.2
