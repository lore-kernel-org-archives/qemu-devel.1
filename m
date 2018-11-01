Received: from eggs.gnu.org ([2001:4830:134:3::10]:59433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIA9g-0004sZ-F6
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIA9Z-0003Ai-GS
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:61522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gIA9Z-00031P-4f
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:41 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Thu,  1 Nov 2018 11:22:51 +0100
Message-Id: <20181101102303.16439-12-sameo@linux.intel.com>
In-Reply-To: <20181101102303.16439-1-sameo@linux.intel.com>
References: <20181101102303.16439-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 11/23] hw: acpi: Export the MCFG getter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Yang Zhong <yang.zhong@intel.com>

The ACPI MCFG getter is not x86 specific and could be called from
anywhere within generic ACPI API, so let's export it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 hw/acpi/aml-build.c         | 24 ++++++++++++++++++++++++
 hw/i386/acpi-build.c        | 22 ----------------------
 include/hw/acpi/aml-build.h |  1 +
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 63225ee64a..c5211928da 100644
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
@@ -1657,6 +1659,28 @@ void acpi_get_pci_holes(Range *hole, Range *hole64)
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
index 14e2624d14..d8bba16776 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1856,28 +1856,6 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
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
                 MachineState *machine, AcpiConfiguration *acpi_conf)
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 1861e37ebf..64ea371656 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -408,6 +408,7 @@ void *acpi_data_push(GArray *table_data, unsigned size);
 unsigned acpi_data_len(GArray *table);
 Object *acpi_get_pci_host(void);
 void acpi_get_pci_holes(Range *hole, Range *hole64);
+bool acpi_get_mcfg(AcpiMcfgInfo *mcfg);
 /* Align AML blob size to a multiple of 'align' */
 void acpi_align_size(GArray *blob, unsigned align);
 void acpi_add_table(GArray *table_offsets, GArray *table_data);
-- 
2.19.1
