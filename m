Received: from eggs.gnu.org ([2001:4830:134:3::10]:39527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf6a-00018F-2D
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf6Z-0005BE-7G
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:7878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gEf6Y-0004Je-RK
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:07 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 22 Oct 2018 20:36:49 +0200
Message-Id: <20181022183656.4902-20-sameo@linux.intel.com>
In-Reply-To: <20181022183656.4902-1-sameo@linux.intel.com>
References: <20181022183656.4902-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH 19/26] hw: acpi: reduced: Add MCFG support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>

From: Yang Zhong <yang.zhong@intel.com>

For PCIe based platform, we need to add an MCFG table to the
hardware-reduced DSDT.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/acpi/reduced.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/acpi/reduced.c b/hw/acpi/reduced.c
index 364b105f58..0f6397c740 100644
--- a/hw/acpi/reduced.c
+++ b/hw/acpi/reduced.c
@@ -94,6 +94,7 @@ static void acpi_reduced_build(MachineState *ms, AcpiBuildTables *tables,
     Range pci_hole, pci_hole64;
     Object *pci_host;
     PCIBus *bus = NULL;
+    AcpiMcfgInfo mcfg;
     GArray *tables_blob = tables->table_data;
 
     acpi_get_pci_holes(&pci_hole, &pci_hole64);
@@ -127,6 +128,12 @@ static void acpi_reduced_build(MachineState *ms, AcpiBuildTables *tables,
     acpi_add_table(table_offsets, tables_blob);
     mc->firmware_build_methods.acpi.madt(tables_blob, tables->linker, ms, conf);
 
+    if (acpi_get_mcfg(&mcfg)) {
+        acpi_add_table(table_offsets, tables_blob);
+        mc->firmware_build_methods.acpi.mcfg(tables_blob,
+                                             tables->linker, &mcfg);
+    }
+
     /* RSDT is pointed to by RSDP */
     xsdt = tables_blob->len;
     build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
-- 
2.17.2
