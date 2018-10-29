Received: from eggs.gnu.org ([2001:4830:134:3::10]:59472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAMV-0000Iz-Ey
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAMS-00082f-V2
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:25:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:12971)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gHAMS-0007zZ-Bb
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:25:52 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 29 Oct 2018 17:24:32 +0100
Message-Id: <20181029162441.31631-11-sameo@linux.intel.com>
In-Reply-To: <20181029162441.31631-1-sameo@linux.intel.com>
References: <20181029162441.31631-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 10/19] hw: acpi: Export the MCFG getter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>

From: Yang Zhong <yang.zhong@intel.com>

The ACPI MCFG getter is not x86 specific and could be called from
anywhere within generic ACPI API, so let's export it.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 hw/acpi/aml-build.c         | 24 ++++++++++++++++++++++++
 hw/i386/acpi-build.c        | 22 ----------------------
 include/hw/acpi/aml-build.h |  1 +
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index aa72b5459c..2110e18799 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -32,6 +32,8 @@
 #include "hw/i386/pc.h"
 #include "sysemu/tpm.h"
 #include "hw/acpi/tpm.h"
+#include "qom/qom-qobject.h"
+#include "qapi/qmp/qnum.h"
 
 #define PCI_HOST_BRIDGE_CONFIG_ADDR        0xcf8
 #define PCI_HOST_BRIDGE_IO_0_MIN_ADDR      0x0000
@@ -1665,6 +1667,28 @@ void acpi_get_pci_holes(Range *hole, Range *hole64)
                                                NULL));
 }
 
+bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
+{
+    Object *pci_host;
+    QObject *o;
+
+    pci_host = acpi_get_pci_host();
+    g_assert(pci_host);
+
+    o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_BASE, NULL);
+    if (!o) {
+        return false;
+    }
+    mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
+    qobject_unref(o);
+
+    o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NULL);
+    assert(o);
+    mcfg->mcfg_size = qnum_get_uint(qobject_to(QNum, o));
+    qobject_unref(o);
+    return true;
+}
+
 static void crs_range_insert(GPtrArray *ranges, uint64_t base, uint64_t limit)
 {
     CrsRangeEntry *entry;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 12a8d8210a..414a6c4c4e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1857,28 +1857,6 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
                  "IVRS", table_data->len - iommu_start, 1, NULL, NULL);
 }
 
-static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
-{
-    Object *pci_host;
-    QObject *o;
-
-    pci_host = acpi_get_pci_host();
-    g_assert(pci_host);
-
-    o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_BASE, NULL);
-    if (!o) {
-        return false;
-    }
-    mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
-    qobject_unref(o);
-
-    o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NULL);
-    assert(o);
-    mcfg->mcfg_size = qnum_get_uint(qobject_to(QNum, o));
-    qobject_unref(o);
-    return true;
-}
-
 static
 void acpi_build(AcpiBuildTables *tables,
                 MachineState *machine, AcpiConfiguration *conf)
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index cdd290dd70..1fabf58df2 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -409,6 +409,7 @@ void *acpi_data_push(GArray *table_data, unsigned size);
 unsigned acpi_data_len(GArray *table);
 Object *acpi_get_pci_host(void);
 void acpi_get_pci_holes(Range *hole, Range *hole64);
+bool acpi_get_mcfg(AcpiMcfgInfo *mcfg);
 void acpi_align_size(GArray *blob, unsigned align);
 void acpi_add_table(GArray *table_offsets, GArray *table_data);
 void acpi_build_tables_init(AcpiBuildTables *tables);
-- 
2.17.2
