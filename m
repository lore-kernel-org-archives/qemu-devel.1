Received: from eggs.gnu.org ([2001:4830:134:3::10]:59213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIA98-0004F3-56
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIA92-0002xG-37
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:61500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gIA91-0002qQ-MZ
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:07 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Thu,  1 Nov 2018 11:22:44 +0100
Message-Id: <20181101102303.16439-5-sameo@linux.intel.com>
In-Reply-To: <20181101102303.16439-1-sameo@linux.intel.com>
References: <20181101102303.16439-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 04/23] hw: acpi: Implement XSDT support for
 RSDP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

XSDT is the 64-bit version of the legacy ACPI RSDT (Root System
Description Table). RSDT only allow for 32-bit addressses and have thus
been deprecated. Since ACPI version 2.0, RSDPs should point at XSDTs and
no longer RSDTs, although RSDTs are still supported for backward
compatibility.

Since version 2.0, RSDPs should add an extended checksum, a complete table
length and a version field to the table.

Here we provide a legacy API (RSDP points at RSDTs) for backward
compatibility purpose and a default, XSDT pointing API.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/acpi/aml-build.c         | 41 ++++++++++++++++++++++++++++++++++++-
 hw/i386/acpi-build.c        |  2 +-
 include/hw/acpi/aml-build.h |  5 ++++-
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 2d6f538f9d..77eb17b113 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1651,8 +1651,10 @@ build_xsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
                  (void *)xsdt, "XSDT", xsdt_len, 1, oem_id, oem_table_id);
 }
 
+/* Legacy RSDP pointing at an RSDT. This is deprecated */
 void
-build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
+build_rsdp_rsdt(GArray *rsdp_table,
+                BIOSLinker *linker, unsigned rsdt_tbl_offset)
 {
     AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
     unsigned rsdt_pa_size = sizeof(rsdp->rsdt_physical_address);
@@ -1675,6 +1677,43 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
         (char *)&rsdp->checksum - rsdp_table->data);
 }
 
+/* RSDP pointing at an XSDT */
+void
+build_rsdp(GArray *rsdp_table,
+           BIOSLinker *linker, unsigned xsdt_tbl_offset)
+{
+    AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
+    unsigned xsdt_pa_size = sizeof(rsdp->xsdt_physical_address);
+    unsigned xsdt_pa_offset =
+        (char *)&rsdp->xsdt_physical_address - rsdp_table->data;
+    unsigned xsdt_offset =
+        (char *)&rsdp->length - rsdp_table->data;
+
+    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 16,
+                             true /* fseg memory */);
+
+    memcpy(&rsdp->signature, "RSD PTR ", 8);
+    memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, 6);
+    rsdp->length = cpu_to_le32(sizeof(*rsdp));
+    /* version 2, we will use the XSDT pointer */
+    rsdp->revision = 0x02;
+
+    /* Address to be filled by Guest linker */
+    bios_linker_loader_add_pointer(linker,
+        ACPI_BUILD_RSDP_FILE, xsdt_pa_offset, xsdt_pa_size,
+        ACPI_BUILD_TABLE_FILE, xsdt_tbl_offset);
+
+    /* Legacy checksum to be filled by Guest linker */
+    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
+        (char *)rsdp - rsdp_table->data, xsdt_offset,
+        (char *)&rsdp->checksum - rsdp_table->data);
+
+    /* Extended checksum to be filled by Guest linker */
+    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
+        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
+        (char *)&rsdp->extended_checksum - rsdp_table->data);
+}
+
 void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags)
 {
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d7b47e05b5..cfc2444d0d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2657,7 +2657,7 @@ void acpi_build(AcpiBuildTables *tables,
                slic_oem.id, slic_oem.table_id);
 
     /* RSDP is in FSEG memory, so allocate it separately */
-    build_rsdp(tables->rsdp, tables->linker, rsdt);
+    build_rsdp_rsdt(tables->rsdp, tables->linker, rsdt);
 
     /* We'll expose it all to Guest so we want to reduce
      * chance of size changes.
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index c9bcb32d81..a2ef8b6f31 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -390,8 +390,11 @@ void acpi_add_table(GArray *table_offsets, GArray *table_data);
 void acpi_build_tables_init(AcpiBuildTables *tables);
 void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre);
 void
+build_rsdp_rsdt(GArray *table_data,
+                BIOSLinker *linker, unsigned rsdt_tbl_offset);
+void
 build_rsdp(GArray *table_data,
-           BIOSLinker *linker, unsigned rsdt_tbl_offset);
+           BIOSLinker *linker, unsigned xsdt_tbl_offset);
 void
 build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
            const char *oem_id, const char *oem_table_id);
-- 
2.19.1
