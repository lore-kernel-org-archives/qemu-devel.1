Received: from eggs.gnu.org ([2001:4830:134:3::10]:37857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gRJmm-00014E-SC
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gRJmj-0004cn-6f
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:31:00 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 26 Nov 2018 17:29:40 +0100
Message-Id: <20181126162942.21258-8-sameo@linux.intel.com>
In-Reply-To: <20181126162942.21258-1-sameo@linux.intel.com>
References: <20181126162942.21258-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 7/8] hw: acpi: Export and share the ARM RSDP
 build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Ben Warren <ben@skyportsystems.com>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Now that build_rsdp() supports building both legacy and current RSDP
tables, we can move it to a generic folder (hw/acpi) and have the i386
ACPI code reuse it in order to reduce code duplication.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 include/hw/acpi/aml-build.h |  5 +++
 hw/acpi/aml-build.c         | 81 +++++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    | 81 -------------------------------------
 hw/i386/acpi-build.c        | 34 ++--------------
 4 files changed, 90 insertions(+), 111 deletions(-)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 6c36903c0a..1bbe496e32 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -388,6 +388,11 @@ void acpi_add_table(GArray *table_offsets, GArray *table_data);
 void acpi_build_tables_init(AcpiBuildTables *tables);
 void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre);
 void
+build_rsdp(GArray *tbl, BIOSLinker *linker, AcpiRsdpData *rsdp_data);
+void
+init_rsdp_data(AcpiRsdpData *data, const char *oem_id, uint8_t revision,
+               unsigned *rsdt_offset, unsigned *xsdt_offset);
+void
 build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
            const char *oem_id, const char *oem_table_id);
 void
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 1e43cd736d..d4e15980f1 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1589,6 +1589,87 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
     g_array_free(tables->vmgenid, mfre);
 }
 
+/* RSDP */
+void
+build_rsdp(GArray *tbl, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
+{
+    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, tbl, 16,
+                             true /* fseg memory */);
+
+    /* RSDP signature */
+    g_array_append_vals(tbl, ACPI_RSDP_SIGNATURE, ACPI_RSDP_SIG_LEN);
+
+    /* Space for the checksum */
+    build_append_int_noprefix(tbl, 0, ACPI_RSDP_CHECKSUM_LEN);
+
+    /* OEM ID */
+    g_array_append_vals(tbl, rsdp_data->oem_id, ACPI_RSDP_OEMID_LEN);
+
+    /* Revision */
+    build_append_int_noprefix(tbl, rsdp_data->revision,
+                              ACPI_RSDP_REVISION_LEN);
+
+    /* Space for the RSDT address (32 bit) */
+    build_append_int_noprefix(tbl, 0, 4);
+
+    if (rsdp_data->rsdt_tbl_offset) {
+        /* RSDT address to be filled by guest linker */
+        bios_linker_loader_add_pointer(linker,
+                                       ACPI_BUILD_RSDP_FILE, 16, 4,
+                                       ACPI_BUILD_TABLE_FILE,
+                                       *rsdp_data->rsdt_tbl_offset);
+    }
+
+    /* Checksum to be filled by guest linker */
+    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE, 0,
+                                    ACPI_RSDP_REV_1_LEN,
+                                    ACPI_RSDP_CHECKSUM_OFFSET);
+
+    if (rsdp_data->revision == ACPI_RSDP_REV_1) {
+        /* Legacy RSDP, we're done */
+        return;
+    }
+
+    /* The RSDP revision is 2 and later, we must have an XSDT pointer */
+    g_assert(rsdp_data->xsdt_tbl_offset != NULL);
+
+    /* Length */
+    build_append_int_noprefix(tbl, ACPI_RSDP_REV_2_LEN, ACPI_RSDP_LEN_LEN);
+
+    /* XSDT address to be filled by guest linker */
+    build_append_int_noprefix(tbl, 0, 8); /* XSDT address (64 bit) */
+    bios_linker_loader_add_pointer(linker,
+                                   ACPI_BUILD_RSDP_FILE,
+                                   ACPI_RSDP_XSDT_OFFSET, 8,
+                                   ACPI_BUILD_TABLE_FILE,
+                                   *rsdp_data->xsdt_tbl_offset);
+
+    /* Space for the extended checksum */
+    build_append_int_noprefix(tbl, 0, ACPI_RSDP_CHECKSUM_LEN);
+
+    /* Space for the reserved bytes */
+    build_append_int_noprefix(tbl, 0, ACPI_RSDP_RESERVED_LEN);
+
+    /* Extended checksum to be filled by Guest linker */
+    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE, 0,
+                                    ACPI_RSDP_REV_2_LEN,
+                                    ACPI_RSDP_EXT_CHECKSUM_OFFSET);
+}
+
+void
+init_rsdp_data(AcpiRsdpData *data, const char *oem_id, uint8_t revision,
+               unsigned *rsdt_offset, unsigned *xsdt_offset)
+{
+    /* Caller must provide an OEM ID */
+    g_assert(oem_id);
+    g_assert(strlen(oem_id) >= 6);
+
+    memcpy(data->oem_id, oem_id, 6);
+    data->revision = revision;
+    data->rsdt_tbl_offset = rsdt_offset;
+    data->xsdt_tbl_offset = xsdt_offset;
+}
+
 /* Build rsdt table */
 void
 build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 10f8388b63..3fe86fd33e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -366,87 +366,6 @@ static void acpi_dsdt_add_power_button(Aml *scope)
     aml_append(scope, dev);
 }
 
-/* RSDP */
-static void
-build_rsdp(GArray *tbl, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
-{
-    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, tbl, 16,
-                             true /* fseg memory */);
-
-    /* RSDP signature */
-    g_array_append_vals(tbl, ACPI_RSDP_SIGNATURE, ACPI_RSDP_SIG_LEN);
-
-    /* Space for the checksum */
-    build_append_int_noprefix(tbl, 0, ACPI_RSDP_CHECKSUM_LEN);
-
-    /* OEM ID */
-    g_array_append_vals(tbl, rsdp_data->oem_id, ACPI_RSDP_OEMID_LEN);
-
-    /* Revision */
-    build_append_int_noprefix(tbl, rsdp_data->revision,
-                              ACPI_RSDP_REVISION_LEN);
-
-    /* Space for the RSDT address (32 bit) */
-    build_append_int_noprefix(tbl, 0, 4);
-
-    if (rsdp_data->rsdt_tbl_offset) {
-        /* RSDT address to be filled by guest linker */
-        bios_linker_loader_add_pointer(linker,
-                                       ACPI_BUILD_RSDP_FILE, 16, 4,
-                                       ACPI_BUILD_TABLE_FILE,
-                                       *rsdp_data->rsdt_tbl_offset);
-    }
-
-    /* Checksum to be filled by guest linker */
-    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE, 0,
-                                    ACPI_RSDP_REV_1_LEN,
-                                    ACPI_RSDP_CHECKSUM_OFFSET);
-
-    if (rsdp_data->revision == ACPI_RSDP_REV_1) {
-        /* Legacy RSDP, we're done */
-        return;
-    }
-
-    /* The RSDP revision is 2 and later, we must have an XSDT pointer */
-    g_assert(rsdp_data->xsdt_tbl_offset != NULL);
-
-    /* Length */
-    build_append_int_noprefix(tbl, ACPI_RSDP_REV_2_LEN, ACPI_RSDP_LEN_LEN);
-
-    /* XSDT address to be filled by guest linker */
-    build_append_int_noprefix(tbl, 0, 8); /* XSDT address (64 bit) */
-    bios_linker_loader_add_pointer(linker,
-                                   ACPI_BUILD_RSDP_FILE,
-                                   ACPI_RSDP_XSDT_OFFSET, 8,
-                                   ACPI_BUILD_TABLE_FILE,
-                                   *rsdp_data->xsdt_tbl_offset);
-
-    /* Space for the extended checksum */
-    build_append_int_noprefix(tbl, 0, ACPI_RSDP_CHECKSUM_LEN);
-
-    /* Space for the reserved bytes */
-    build_append_int_noprefix(tbl, 0, ACPI_RSDP_RESERVED_LEN);
-
-    /* Extended checksum to be filled by Guest linker */
-    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE, 0,
-                                    ACPI_RSDP_REV_2_LEN,
-                                    ACPI_RSDP_EXT_CHECKSUM_OFFSET);
-}
-
-static void
-init_rsdp_data(AcpiRsdpData *data, const char *oem_id, uint8_t revision,
-               unsigned *rsdt_offset, unsigned *xsdt_offset)
-{
-    /* Caller must provide an OEM ID */
-    g_assert(oem_id);
-    g_assert(strlen(oem_id) >= 6);
-
-    memcpy(data->oem_id, oem_id, 6);
-    data->revision = revision;
-    data->rsdt_tbl_offset = rsdt_offset;
-    data->xsdt_tbl_offset = xsdt_offset;
-}
-
 static void
 build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index fb877648ac..f7ab112599 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2547,35 +2547,6 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
                  "IVRS", table_data->len - iommu_start, 1, NULL, NULL);
 }
 
-static void
-build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
-{
-    /* AcpiRsdpDescriptor describes revision 2 RSDP table and as result we
-     * allocate extra 16 bytes for pc/q35 RSDP rev1 as well. Keep extra 16 bytes
-     * wasted to make sure we won't breake migration for machine types older
-     * than 2.3 due to size mismatch.
-     */
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
-        (char *)rsdp - rsdp_table->data, 20 /* ACPI rev 1.0 RSDP size */,
-        (char *)&rsdp->checksum - rsdp_table->data);
-}
-
 typedef
 struct AcpiBuildState {
     /* Copy of table in RAM (for patching). */
@@ -2625,6 +2596,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     GArray *tables_blob = tables->table_data;
     AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
     Object *vmgenid_dev;
+    AcpiRsdpData rsdp;
 
     acpi_get_pm_info(&pm);
     acpi_get_misc_info(&misc);
@@ -2732,7 +2704,9 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                slic_oem.id, slic_oem.table_id);
 
     /* RSDP is in FSEG memory, so allocate it separately */
-    build_rsdp(tables->rsdp, tables->linker, rsdt);
+    init_rsdp_data(&rsdp, ACPI_BUILD_APPNAME6, ACPI_RSDP_REV_1,
+                   &rsdt, NULL);
+    build_rsdp(tables->rsdp, tables->linker, &rsdp);
 
     /* We'll expose it all to Guest so we want to reduce
      * chance of size changes.
-- 
2.19.1
