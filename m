Received: from eggs.gnu.org ([2001:4830:134:3::10]:59112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIA8z-00047A-I9
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIA8y-0002up-Hd
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:05 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Thu,  1 Nov 2018 11:22:43 +0100
Message-Id: <20181101102303.16439-4-sameo@linux.intel.com>
In-Reply-To: <20181101102303.16439-1-sameo@linux.intel.com>
References: <20181101102303.16439-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 03/23] hw: acpi: Export the RSDP build API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>

The hardware-reduced API will need to build RSDP as well, so we should
export this routine. While doing so, we also slightly change the
function prototype. Since no caller needs it, and to make it more
consistent with the rest of the AML build API, the function no longer
returns its RSDP table.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/acpi/aml-build.c         | 24 ++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    |  2 +-
 hw/i386/acpi-build.c        | 26 --------------------------
 include/hw/acpi/aml-build.h |  3 +++
 4 files changed, 28 insertions(+), 27 deletions(-)

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
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f28a2faa53..0ed132b79b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -367,7 +367,7 @@ static void acpi_dsdt_add_power_button(Aml *scope)
 }
 
 /* RSDP */
-static GArray *
+static void
 build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
 {
     AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 81d98fa34f..d7b47e05b5 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2513,32 +2513,6 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
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
index 73fc6659f2..c9bcb32d81 100644
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
2.19.1
