Received: from eggs.gnu.org ([2001:4830:134:3::10]:54613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d84zJ-00028s-3N
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d84zH-0003OR-OF
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:15:37 -0400
Date: Tue, 9 May 2017 16:15:29 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1494330527-24163-3-git-send-email-mst@redhat.com>
References: <1494330527-24163-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494330527-24163-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 2/8] hw/arm/virt: generate 64-bit addressable
 ACPI objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Andrew Jones <drjones@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Our current ACPI table generation code limits the placement of ACPI
tables to 32-bit addressable memory, in order to be able to emit the
root pointer (RSDP) and root table (RSDT) using table types from the
ACPI 1.0 days.

Since ARM was not supported by ACPI before version 5.0, it makes sense
to lift this restriction. This is not crucial for mach-virt, which is
guaranteed to have some memory available below the 4 GB mark, but it
is a nice to have for QEMU machines that do not have any 32-bit
addressable memory, which is not uncommon for real world 64-bit ARM
systems.

Since we already emit a version of the RSDP root pointer that has a
secondary 64-bit wide address field for the 64-bit root table (XSDT),
all we need to do is replace the RSDT generation with the generation
of an XSDT table, and use a different slot in the FADT table to refer
to the DSDT.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/acpi/acpi-defs.h | 11 +++++++++++
 include/hw/acpi/aml-build.h |  3 +++
 hw/acpi/aml-build.c         | 27 +++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    | 26 +++++++++++++-------------
 4 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index db48807..dff6d4f 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -238,6 +238,17 @@ struct AcpiRsdtDescriptorRev1
 typedef struct AcpiRsdtDescriptorRev1 AcpiRsdtDescriptorRev1;
 
 /*
+ * ACPI 2.0 eXtended System Description Table (XSDT)
+ */
+struct AcpiXsdtDescriptorRev2
+{
+    ACPI_TABLE_HEADER_DEF       /* ACPI common table header */
+    uint64_t table_offset_entry[0];  /* Array of pointers to other */
+    /* ACPI tables */
+} QEMU_PACKED;
+typedef struct AcpiXsdtDescriptorRev2 AcpiXsdtDescriptorRev2;
+
+/*
  * ACPI 1.0 Firmware ACPI Control Structure (FACS)
  */
 struct AcpiFacsDescriptorRev1
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 00c21f1..eb07c2d 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -381,6 +381,9 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre);
 void
 build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
            const char *oem_id, const char *oem_table_id);
+void
+build_xsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
+           const char *oem_id, const char *oem_table_id);
 
 int
 build_append_named_dword(GArray *array, const char *name_format, ...)
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index c6f2032..4ddfb68 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1599,6 +1599,33 @@ build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
                  (void *)rsdt, "RSDT", rsdt_len, 1, oem_id, oem_table_id);
 }
 
+/* Build xsdt table */
+void
+build_xsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
+           const char *oem_id, const char *oem_table_id)
+{
+    int i;
+    unsigned xsdt_entries_offset;
+    AcpiXsdtDescriptorRev2 *xsdt;
+    const unsigned table_data_len = (sizeof(uint64_t) * table_offsets->len);
+    const unsigned xsdt_entry_size = sizeof(xsdt->table_offset_entry[0]);
+    const size_t xsdt_len = sizeof(*xsdt) + table_data_len;
+
+    xsdt = acpi_data_push(table_data, xsdt_len);
+    xsdt_entries_offset = (char *)xsdt->table_offset_entry - table_data->data;
+    for (i = 0; i < table_offsets->len; ++i) {
+        uint64_t ref_tbl_offset = g_array_index(table_offsets, uint32_t, i);
+        uint64_t xsdt_entry_offset = xsdt_entries_offset + xsdt_entry_size * i;
+
+        /* xsdt->table_offset_entry to be filled by Guest linker */
+        bios_linker_loader_add_pointer(linker,
+            ACPI_BUILD_TABLE_FILE, xsdt_entry_offset, xsdt_entry_size,
+            ACPI_BUILD_TABLE_FILE, ref_tbl_offset);
+    }
+    build_header(linker, table_data,
+                 (void *)xsdt, "XSDT", xsdt_len, 1, oem_id, oem_table_id);
+}
+
 void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags)
 {
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 0835e59..6e5f339 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -364,12 +364,12 @@ static void acpi_dsdt_add_power_button(Aml *scope)
 
 /* RSDP */
 static GArray *
-build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
+build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
 {
     AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
-    unsigned rsdt_pa_size = sizeof(rsdp->rsdt_physical_address);
-    unsigned rsdt_pa_offset =
-        (char *)&rsdp->rsdt_physical_address - rsdp_table->data;
+    unsigned xsdt_pa_size = sizeof(rsdp->xsdt_physical_address);
+    unsigned xsdt_pa_offset =
+        (char *)&rsdp->xsdt_physical_address - rsdp_table->data;
 
     bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 16,
                              true /* fseg memory */);
@@ -381,8 +381,8 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
 
     /* Address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker,
-        ACPI_BUILD_RSDP_FILE, rsdt_pa_offset, rsdt_pa_size,
-        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset);
+        ACPI_BUILD_RSDP_FILE, xsdt_pa_offset, xsdt_pa_size,
+        ACPI_BUILD_TABLE_FILE, xsdt_tbl_offset);
 
     /* Checksum to be filled by Guest linker */
     bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
@@ -659,7 +659,7 @@ static void build_fadt(GArray *table_data, BIOSLinker *linker,
                        VirtMachineState *vms, unsigned dsdt_tbl_offset)
 {
     AcpiFadtDescriptorRev5_1 *fadt = acpi_data_push(table_data, sizeof(*fadt));
-    unsigned dsdt_entry_offset = (char *)&fadt->dsdt - table_data->data;
+    unsigned xdsdt_entry_offset = (char *)&fadt->x_dsdt - table_data->data;
     uint16_t bootflags;
 
     switch (vms->psci_conduit) {
@@ -685,7 +685,7 @@ static void build_fadt(GArray *table_data, BIOSLinker *linker,
 
     /* DSDT address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker,
-        ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
+        ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, sizeof(fadt->x_dsdt),
         ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
 
     build_header(linker, table_data,
@@ -748,7 +748,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     GArray *table_offsets;
-    unsigned dsdt, rsdt;
+    unsigned dsdt, xsdt;
     GArray *tables_blob = tables->table_data;
 
     table_offsets = g_array_new(false, true /* clear */,
@@ -788,12 +788,12 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
         build_iort(tables_blob, tables->linker);
     }
 
-    /* RSDT is pointed to by RSDP */
-    rsdt = tables_blob->len;
-    build_rsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
+    /* XSDT is pointed to by RSDP */
+    xsdt = tables_blob->len;
+    build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
 
     /* RSDP is in FSEG memory, so allocate it separately */
-    build_rsdp(tables->rsdp, tables->linker, rsdt);
+    build_rsdp(tables->rsdp, tables->linker, xsdt);
 
     /* Cleanup memory that's no longer used. */
     g_array_free(table_offsets, true);
-- 
MST
