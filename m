Received: from eggs.gnu.org ([2001:4830:134:3::10]:46990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJTuf-0007Lp-Ab
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 20:42:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJTua-0002kY-Ci
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 20:42:45 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon,  5 Nov 2018 02:40:33 +0100
Message-Id: <20181105014047.26447-11-sameo@linux.intel.com>
In-Reply-To: <20181105014047.26447-1-sameo@linux.intel.com>
References: <20181105014047.26447-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 10/24] hw: acpi: Export the PCI host and
 holes getters
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

This is going to be needed by the hardware reduced implementation, so
let's export it.
Once the ACPI builder methods and getters will be implemented, the
acpi_get_pci_host() implementation will become hardware agnostic.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 include/hw/acpi/aml-build.h |  2 ++
 hw/acpi/aml-build.c         | 43 +++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c        | 47 ++-----------------------------------
 3 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index c27c0935ae..fde2785b9a 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -400,6 +400,8 @@ build_header(BIOSLinker *linker, GArray *table_data,
              const char *oem_id, const char *oem_table_id);
 void *acpi_data_push(GArray *table_data, unsigned size);
 unsigned acpi_data_len(GArray *table);
+Object *acpi_get_pci_host(void);
+void acpi_get_pci_holes(Range *hole, Range *hole64);
 /* Align AML blob size to a multiple of 'align' */
 void acpi_align_size(GArray *blob, unsigned align);
 void acpi_add_table(GArray *table_offsets, GArray *table_data);
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 2b9a636e75..b8e32f15f7 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1601,6 +1601,49 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
     g_array_free(tables->vmgenid, mfre);
 }
 
+/*
+ * Because of the PXB hosts we cannot simply query TYPE_PCI_HOST_BRIDGE.
+ */
+Object *acpi_get_pci_host(void)
+{
+    PCIHostState *host;
+
+    host = OBJECT_CHECK(PCIHostState,
+                        object_resolve_path("/machine/i440fx", NULL),
+                        TYPE_PCI_HOST_BRIDGE);
+    if (!host) {
+        host = OBJECT_CHECK(PCIHostState,
+                            object_resolve_path("/machine/q35", NULL),
+                            TYPE_PCI_HOST_BRIDGE);
+    }
+
+    return OBJECT(host);
+}
+
+
+void acpi_get_pci_holes(Range *hole, Range *hole64)
+{
+    Object *pci_host;
+
+    pci_host = acpi_get_pci_host();
+    g_assert(pci_host);
+
+    range_set_bounds1(hole,
+                      object_property_get_uint(pci_host,
+                                               PCI_HOST_PROP_PCI_HOLE_START,
+                                               NULL),
+                      object_property_get_uint(pci_host,
+                                               PCI_HOST_PROP_PCI_HOLE_END,
+                                               NULL));
+    range_set_bounds1(hole64,
+                      object_property_get_uint(pci_host,
+                                               PCI_HOST_PROP_PCI_HOLE64_START,
+                                               NULL),
+                      object_property_get_uint(pci_host,
+                                               PCI_HOST_PROP_PCI_HOLE64_END,
+                                               NULL));
+}
+
 static void crs_range_insert(GPtrArray *ranges, uint64_t base, uint64_t limit)
 {
     CrsRangeEntry *entry;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index bd147a6bd2..a5f5f83500 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -232,49 +232,6 @@ static void acpi_get_misc_info(AcpiMiscInfo *info)
     info->applesmc_io_base = applesmc_port();
 }
 
-/*
- * Because of the PXB hosts we cannot simply query TYPE_PCI_HOST_BRIDGE.
- * On i386 arch we only have two pci hosts, so we can look only for them.
- */
-static Object *acpi_get_i386_pci_host(void)
-{
-    PCIHostState *host;
-
-    host = OBJECT_CHECK(PCIHostState,
-                        object_resolve_path("/machine/i440fx", NULL),
-                        TYPE_PCI_HOST_BRIDGE);
-    if (!host) {
-        host = OBJECT_CHECK(PCIHostState,
-                            object_resolve_path("/machine/q35", NULL),
-                            TYPE_PCI_HOST_BRIDGE);
-    }
-
-    return OBJECT(host);
-}
-
-static void acpi_get_pci_holes(Range *hole, Range *hole64)
-{
-    Object *pci_host;
-
-    pci_host = acpi_get_i386_pci_host();
-    g_assert(pci_host);
-
-    range_set_bounds1(hole,
-                      object_property_get_uint(pci_host,
-                                               PCI_HOST_PROP_PCI_HOLE_START,
-                                               NULL),
-                      object_property_get_uint(pci_host,
-                                               PCI_HOST_PROP_PCI_HOLE_END,
-                                               NULL));
-    range_set_bounds1(hole64,
-                      object_property_get_uint(pci_host,
-                                               PCI_HOST_PROP_PCI_HOLE64_START,
-                                               NULL),
-                      object_property_get_uint(pci_host,
-                                               PCI_HOST_PROP_PCI_HOLE64_END,
-                                               NULL));
-}
-
 /* FACS */
 static void
 build_facs(GArray *table_data, BIOSLinker *linker)
@@ -1634,7 +1591,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         Object *pci_host;
         PCIBus *bus = NULL;
 
-        pci_host = acpi_get_i386_pci_host();
+        pci_host = acpi_get_pci_host();
         if (pci_host) {
             bus = PCI_HOST_BRIDGE(pci_host)->bus;
         }
@@ -2008,7 +1965,7 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
     Object *pci_host;
     QObject *o;
 
-    pci_host = acpi_get_i386_pci_host();
+    pci_host = acpi_get_pci_host();
     g_assert(pci_host);
 
     o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_BASE, NULL);
-- 
2.19.1
