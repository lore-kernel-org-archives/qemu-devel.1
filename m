Received: from eggs.gnu.org ([2001:4830:134:3::10]:51553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6qG-0006El-Ga
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6qE-00082V-Rv
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:18:48 -0500
Date: Mon, 17 Dec 2018 23:18:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218041625.24969-30-mst@redhat.com>
References: <20181218041625.24969-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218041625.24969-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 29/31] hw: acpi: Export and share the ARM RSDP
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>, Andrew Jones <drjones@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org

From: Samuel Ortiz <sameo@linux.intel.com>

Now that build_rsdp() supports building both legacy and current RSDP
tables, we can move it to a generic folder (hw/acpi) and have the i386
ACPI code reuse it in order to reduce code duplication.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 include/hw/acpi/aml-build.h |  2 ++
 hw/acpi/aml-build.c         | 68 +++++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    | 65 -----------------------------------
 hw/i386/acpi-build.c        | 49 +++++++++++---------------
 4 files changed, 89 insertions(+), 95 deletions(-)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 6c36903c0a..1a563ad756 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -388,6 +388,8 @@ void acpi_add_table(GArray *table_offsets, GArray *table_data);
 void acpi_build_tables_init(AcpiBuildTables *tables);
 void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre);
 void
+build_rsdp(GArray *tbl, BIOSLinker *linker, AcpiRsdpData *rsdp_data);
+void
 build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
            const char *oem_id, const char *oem_table_id);
 void
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 1e43cd736d..555c24f21d 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1589,6 +1589,74 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
     g_array_free(tables->vmgenid, mfre);
 }
 
+/*
+ * ACPI spec 5.2.5.3 Root System Description Pointer (RSDP).
+ * (Revision 1.0 or later)
+ */
+void
+build_rsdp(GArray *tbl, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
+{
+    int tbl_off = tbl->len; /* Table offset in the RSDP file */
+
+    switch (rsdp_data->revision) {
+    case 0:
+        /* With ACPI 1.0, we must have an RSDT pointer */
+        g_assert(rsdp_data->rsdt_tbl_offset);
+        break;
+    case 2:
+        /* With ACPI 2.0+, we must have an XSDT pointer */
+        g_assert(rsdp_data->xsdt_tbl_offset);
+        break;
+    default:
+        /* Only revisions 0 (ACPI 1.0) and 2 (ACPI 2.0+) are valid for RSDP */
+        g_assert_not_reached();
+    }
+
+    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, tbl, 16,
+                             true /* fseg memory */);
+
+    g_array_append_vals(tbl, "RSD PTR ", 8); /* Signature */
+    build_append_int_noprefix(tbl, 0, 1); /* Checksum */
+    g_array_append_vals(tbl, rsdp_data->oem_id, 6); /* OEMID */
+    build_append_int_noprefix(tbl, rsdp_data->revision, 1); /* Revision */
+    build_append_int_noprefix(tbl, 0, 4); /* RsdtAddress */
+    if (rsdp_data->rsdt_tbl_offset) {
+        /* RSDT address to be filled by guest linker */
+        bios_linker_loader_add_pointer(linker, ACPI_BUILD_RSDP_FILE,
+                                       tbl_off + 16, 4,
+                                       ACPI_BUILD_TABLE_FILE,
+                                       *rsdp_data->rsdt_tbl_offset);
+    }
+
+    /* Checksum to be filled by guest linker */
+    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
+                                    tbl_off, 20, /* ACPI rev 1.0 RSDP size */
+                                    8);
+
+    if (rsdp_data->revision == 0) {
+        /* ACPI 1.0 RSDP, we're done */
+        return;
+    }
+
+    build_append_int_noprefix(tbl, 36, 4); /* Length */
+
+    /* XSDT address to be filled by guest linker */
+    build_append_int_noprefix(tbl, 0, 8); /* XsdtAddress */
+    /* We already validated our xsdt pointer */
+    bios_linker_loader_add_pointer(linker, ACPI_BUILD_RSDP_FILE,
+                                   tbl_off + 24, 8,
+                                   ACPI_BUILD_TABLE_FILE,
+                                   *rsdp_data->xsdt_tbl_offset);
+
+    build_append_int_noprefix(tbl, 0, 1); /* Extended Checksum */
+    build_append_int_noprefix(tbl, 0, 3); /* Reserved */
+
+    /* Extended checksum to be filled by Guest linker */
+    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
+                                    tbl_off, 36, /* ACPI rev 2.0 RSDP size */
+                                    32);
+}
+
 /* Build rsdt table */
 void
 build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 05f6654371..95fad6f0ce 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -366,71 +366,6 @@ static void acpi_dsdt_add_power_button(Aml *scope)
     aml_append(scope, dev);
 }
 
-/* RSDP */
-static void
-build_rsdp(GArray *tbl, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
-{
-    int tbl_off = tbl->len; /* Table offset in the RSDP file */
-
-    switch (rsdp_data->revision) {
-    case 0:
-        /* With ACPI 1.0, we must have an RSDT pointer */
-        g_assert(rsdp_data->rsdt_tbl_offset);
-        break;
-    case 2:
-        /* With ACPI 2.0+, we must have an XSDT pointer */
-        g_assert(rsdp_data->xsdt_tbl_offset);
-        break;
-    default:
-        /* Only revisions 0 (ACPI 1.0) and 2 (ACPI 2.0+) are valid for RSDP */
-        g_assert_not_reached();
-    }
-
-    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, tbl, 16,
-                             true /* fseg memory */);
-
-    g_array_append_vals(tbl, "RSD PTR ", 8); /* Signature */
-    build_append_int_noprefix(tbl, 0, 1); /* Checksum */
-    g_array_append_vals(tbl, rsdp_data->oem_id, 6); /* OEMID */
-    build_append_int_noprefix(tbl, rsdp_data->revision, 1); /* Revision */
-    build_append_int_noprefix(tbl, 0, 4); /* RsdtAddress */
-    if (rsdp_data->rsdt_tbl_offset) {
-        /* RSDT address to be filled by guest linker */
-        bios_linker_loader_add_pointer(linker, ACPI_BUILD_RSDP_FILE,
-                                       tbl_off + 16, 4,
-                                       ACPI_BUILD_TABLE_FILE,
-                                       *rsdp_data->rsdt_tbl_offset);
-    }
-
-    /* Checksum to be filled by guest linker */
-    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
-                                    tbl_off, 20, /* ACPI rev 1.0 RSDP size */
-                                    8);
-
-    if (rsdp_data->revision == 0) {
-        /* ACPI 1.0 RSDP, we're done */
-        return;
-    }
-
-    build_append_int_noprefix(tbl, 36, 4); /* Length */
-
-    /* XSDT address to be filled by guest linker */
-    build_append_int_noprefix(tbl, 0, 8); /* XsdtAddress */
-    /* We already validated our xsdt pointer */
-    bios_linker_loader_add_pointer(linker, ACPI_BUILD_RSDP_FILE,
-                                   tbl_off + 24, 8,
-                                   ACPI_BUILD_TABLE_FILE,
-                                   *rsdp_data->xsdt_tbl_offset);
-
-    build_append_int_noprefix(tbl, 0, 1); /* Extended Checksum */
-    build_append_int_noprefix(tbl, 0, 3); /* Reserved */
-
-    /* Extended checksum to be filled by Guest linker */
-    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
-                                    tbl_off, 36, /* ACPI rev 2.0 RSDP size */
-                                    32);
-}
-
 static void
 build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index fb877648ac..9891b6913b 100644
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
@@ -2732,7 +2703,25 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                slic_oem.id, slic_oem.table_id);
 
     /* RSDP is in FSEG memory, so allocate it separately */
-    build_rsdp(tables->rsdp, tables->linker, rsdt);
+    {
+        AcpiRsdpData rsdp_data = {
+            .revision = 0,
+            .oem_id = ACPI_BUILD_APPNAME6,
+            .xsdt_tbl_offset = NULL,
+            .rsdt_tbl_offset = &rsdt,
+        };
+        build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
+        if (!pcmc->rsdp_in_ram) {
+            /* We used to allocate some extra space for RSDP revision 2 but
+             * only used the RSDP revision 0 space. The extra bytes were
+             * zeroed out and not used.
+             * Here we continue wasting those extra 16 bytes to make sure we
+             * don't break migration for machine types 2.2 and older due to
+             * RSDP blob size mismatch.
+             */
+            build_append_int_noprefix(tables->rsdp, 0, 16);
+        }
+    }
 
     /* We'll expose it all to Guest so we want to reduce
      * chance of size changes.
-- 
MST
