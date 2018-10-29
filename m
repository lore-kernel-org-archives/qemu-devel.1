Received: from eggs.gnu.org ([2001:4830:134:3::10]:59367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAMO-0000DB-UU
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAMK-0007y8-Hz
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:25:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:12964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gHAMK-0007uo-5g
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:25:44 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 29 Oct 2018 17:24:25 +0100
Message-Id: <20181029162441.31631-4-sameo@linux.intel.com>
In-Reply-To: <20181029162441.31631-1-sameo@linux.intel.com>
References: <20181029162441.31631-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 03/19] hw: acpi: Export the RSDP build API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The hardware-reduced API will need to build RSDP as well, so we should
export this routine. While doing so, we also slightly change the
function prototype. Since no caller needs it, and to make it more
consistent with the rest of the AML build API, the function no longer
returns its RSDP table.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/acpi/aml-build.c         | 24 ++++++++++++++++++++++++
 hw/i386/acpi-build.c        | 26 --------------------------
 include/hw/acpi/aml-build.h |  3 +++
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 51b608432f..2d6f538f9d 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1651,6 +1651,30 @@ build_xsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
                  (void *)xsdt, "XSDT", xsdt_len, 1, oem_id, oem_table_id);
 }
 
+void
+build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
+{
+    AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
+    unsigned rsdt_pa_size = sizeof(rsdp->rsdt_physical_address);
+    unsigned rsdt_pa_offset =
+        (char *)&rsdp->rsdt_physical_address - rsdp_table->data;
+
+    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 16,
+                             true /* fseg memory */);
+
+    memcpy(&rsdp->signature, "RSD PTR ", 8);
+    memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, 6);
+    /* Address to be filled by Guest linker */
+    bios_linker_loader_add_pointer(linker,
+        ACPI_BUILD_RSDP_FILE, rsdt_pa_offset, rsdt_pa_size,
+        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset);
+
+    /* Checksum to be filled by Guest linker */
+    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
+        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
+        (char *)&rsdp->checksum - rsdp_table->data);
+}
+
 void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags)
 {
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1bf02b6a93..9f1c9f4cf5 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2512,32 +2512,6 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
                  "IVRS", table_data->len - iommu_start, 1, NULL, NULL);
 }
 
-static GArray *
-build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
-{
-    AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
-    unsigned rsdt_pa_size = sizeof(rsdp->rsdt_physical_address);
-    unsigned rsdt_pa_offset =
-        (char *)&rsdp->rsdt_physical_address - rsdp_table->data;
-
-    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 16,
-                             true /* fseg memory */);
-
-    memcpy(&rsdp->signature, "RSD PTR ", 8);
-    memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, 6);
-    /* Address to be filled by Guest linker */
-    bios_linker_loader_add_pointer(linker,
-        ACPI_BUILD_RSDP_FILE, rsdt_pa_offset, rsdt_pa_size,
-        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset);
-
-    /* Checksum to be filled by Guest linker */
-    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
-        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
-        (char *)&rsdp->checksum - rsdp_table->data);
-
-    return rsdp_table;
-}
-
 static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
 {
     Object *pci_host;
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 813f51317c..865f5d23f5 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -390,6 +390,9 @@ void acpi_add_table(GArray *table_offsets, GArray *table_data);
 void acpi_build_tables_init(AcpiBuildTables *tables);
 void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre);
 void
+build_rsdp(GArray *table_data,
+           BIOSLinker *linker, unsigned rsdt_tbl_offset);
+void
 build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
            const char *oem_id, const char *oem_table_id);
 void
-- 
2.17.2
