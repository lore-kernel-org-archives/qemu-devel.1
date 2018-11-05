Received: from eggs.gnu.org ([2001:4830:134:3::10]:47267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJTvA-0008PB-Kw
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 20:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJTv9-0003LM-EC
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 20:43:16 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon,  5 Nov 2018 02:40:41 +0100
Message-Id: <20181105014047.26447-19-sameo@linux.intel.com>
In-Reply-To: <20181105014047.26447-1-sameo@linux.intel.com>
References: <20181105014047.26447-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 18/24] hw: i386: Export the MADT build method
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

It is going to be used by the PC machine type as the MADT table builder
method and thus needs to be exported outside of acpi-build.c

Also, now that the generic build_madt() API is exported, we have to
rename the ARM static one in order to avoid build time conflicts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 include/hw/i386/acpi.h   | 28 ++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c |  4 ++--
 hw/i386/acpi-build.c     |  4 ++--
 3 files changed, 32 insertions(+), 4 deletions(-)
 create mode 100644 include/hw/i386/acpi.h

diff --git a/include/hw/i386/acpi.h b/include/hw/i386/acpi.h
new file mode 100644
index 0000000000..b7a887111d
--- /dev/null
+++ b/include/hw/i386/acpi.h
@@ -0,0 +1,28 @@
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
+#ifndef HW_I386_ACPI_H
+#define HW_I386_ACPI_H
+
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/bios-linker-loader.h"
+
+/* ACPI MADT (Multiple APIC Description Table) build method */
+void build_madt(GArray *table_data, BIOSLinker *linker,
+                MachineState *ms, AcpiConfiguration *conf);
+
+#endif
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b5e165543a..b0354c5f03 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -564,7 +564,7 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
 /* MADT */
 static void
-build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
+virt_build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     int madt_start = table_data->len;
@@ -745,7 +745,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     build_fadt_rev5(tables_blob, tables->linker, vms, dsdt);
 
     acpi_add_table(table_offsets, tables_blob);
-    build_madt(tables_blob, tables->linker, vms);
+    virt_build_madt(tables_blob, tables->linker, vms);
 
     acpi_add_table(table_offsets, tables_blob);
     build_gtdt(tables_blob, tables->linker, vms);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index bef5b23168..4b1d8fbe3f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -35,7 +35,6 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/cpu.h"
 #include "hw/nvram/fw_cfg.h"
-#include "hw/acpi/bios-linker-loader.h"
 #include "hw/loader.h"
 #include "hw/isa/isa.h"
 #include "hw/block/fdc.h"
@@ -60,6 +59,7 @@
 #include "qom/qom-qobject.h"
 #include "hw/i386/amd_iommu.h"
 #include "hw/i386/intel_iommu.h"
+#include "hw/i386/acpi.h"
 
 #include "hw/acpi/ipmi.h"
 
@@ -279,7 +279,7 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
     }
 }
 
-static void
+void
 build_madt(GArray *table_data, BIOSLinker *linker,
            MachineState *ms, AcpiConfiguration *acpi_conf)
 {
-- 
2.19.1
