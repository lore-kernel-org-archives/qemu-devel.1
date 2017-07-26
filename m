Received: from eggs.gnu.org ([2001:4830:134:3::10]:59695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daIfV-0007Pm-5x
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daIfS-00026Z-29
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:31:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daIfR-00026M-Pb
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:31:45 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Jul 2017 11:31:36 +0200
Message-Id: <20170726093136.13627-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [qemu PATCH for 2.10] i386: acpi: provide an XSDT
 instead of an RSDT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin O'Connor <kevin@koconnor.net>, seabios@seabios.org, lersek@redhat.com, lists@philjordan.eu, imammedo@redhat.com, mst@redhat.com, phil@philjordan.eu, programmingkidx@gmail.com, kraxel@redhat.com

The tables that QEMU provides are not ACPI 1.0 compatible since commit
77af8a2b95 ("hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve
guest OS support.", 2017-05-03).  This is visible with Windows 2000,
which refuses to parse the rev3 FADT and fails to boot.

The recommended solution in this case is to build two FADTs, v1 being
pointed to by the RSDT and v3 by the XSDT.  However, we leave this task
to the firmware.  This patch simply switches the RSDT to the XSDT, which
is valid for all ACPI 2.0-friendly operating systems and also leaves
SeaBIOS the freedom to build an RSDT that points to the compatibility
FADT.

When running Windows 2000 with an old BIOS, Windows would simply fall
back to a non-ACPI HAL; however, the plan should be to include a BIOS with
the new feature in 2.10.

Reported-by: Programmingkid <programmingkidx@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/acpi/aml-build.c         | 27 ---------------------------
 hw/i386/acpi-build.c        | 30 ++++++++++++++++++------------
 include/hw/acpi/aml-build.h |  3 ---
 3 files changed, 18 insertions(+), 42 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 36a6cc450e..ea750d54d9 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1573,33 +1573,6 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
     g_array_free(tables->vmgenid, mfre);
 }
 
-/* Build rsdt table */
-void
-build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
-           const char *oem_id, const char *oem_table_id)
-{
-    int i;
-    unsigned rsdt_entries_offset;
-    AcpiRsdtDescriptorRev1 *rsdt;
-    const unsigned table_data_len = (sizeof(uint32_t) * table_offsets->len);
-    const unsigned rsdt_entry_size = sizeof(rsdt->table_offset_entry[0]);
-    const size_t rsdt_len = sizeof(*rsdt) + table_data_len;
-
-    rsdt = acpi_data_push(table_data, rsdt_len);
-    rsdt_entries_offset = (char *)rsdt->table_offset_entry - table_data->data;
-    for (i = 0; i < table_offsets->len; ++i) {
-        uint32_t ref_tbl_offset = g_array_index(table_offsets, uint32_t, i);
-        uint32_t rsdt_entry_offset = rsdt_entries_offset + rsdt_entry_size * i;
-
-        /* rsdt->table_offset_entry to be filled by Guest linker */
-        bios_linker_loader_add_pointer(linker,
-            ACPI_BUILD_TABLE_FILE, rsdt_entry_offset, rsdt_entry_size,
-            ACPI_BUILD_TABLE_FILE, ref_tbl_offset);
-    }
-    build_header(linker, table_data,
-                 (void *)rsdt, "RSDT", rsdt_len, 1, oem_id, oem_table_id);
-}
-
 /* Build xsdt table */
 void
 build_xsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6b7bade183..e76cad2ad7 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2557,27 +2557,33 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
 }
 
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
 
     memcpy(&rsdp->signature, "RSD PTR ", 8);
     memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, 6);
+    rsdp->length = cpu_to_le32(sizeof(*rsdp));
+    rsdp->revision = 0x02;
+
     /* Address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker,
-        ACPI_BUILD_RSDP_FILE, rsdt_pa_offset, rsdt_pa_size,
-        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset);
+        ACPI_BUILD_RSDP_FILE, xsdt_pa_offset, xsdt_pa_size,
+        ACPI_BUILD_TABLE_FILE, xsdt_tbl_offset);
 
     /* Checksum to be filled by Guest linker */
     bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
-        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
+        (char *)rsdp - rsdp_table->data, offsetof(AcpiRsdpDescriptor, length),
         (char *)&rsdp->checksum - rsdp_table->data);
+    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
+        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
+        (char *)&rsdp->extended_checksum - rsdp_table->data);
 
     return rsdp_table;
 }
@@ -2621,7 +2627,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     GArray *table_offsets;
-    unsigned facs, dsdt, rsdt, fadt;
+    unsigned facs, dsdt, xsdt, fadt;
     AcpiPmInfo pm;
     AcpiMiscInfo misc;
     AcpiMcfgInfo mcfg;
@@ -2729,13 +2735,13 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
         g_array_append_vals(tables_blob, u, len);
     }
 
-    /* RSDT is pointed to by RSDP */
-    rsdt = tables_blob->len;
-    build_rsdt(tables_blob, tables->linker, table_offsets,
+    /* XSDT is pointed to by RSDP */
+    xsdt = tables_blob->len;
+    build_xsdt(tables_blob, tables->linker, table_offsets,
                slic_oem.id, slic_oem.table_id);
 
     /* RSDP is in FSEG memory, so allocate it separately */
-    build_rsdp(tables->rsdp, tables->linker, rsdt);
+    build_rsdp(tables->rsdp, tables->linker, xsdt);
 
     /* We'll expose it all to Guest so we want to reduce
      * chance of size changes.
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 88d0738d76..4bdd88ee23 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -379,9 +379,6 @@ void acpi_add_table(GArray *table_offsets, GArray *table_data);
 void acpi_build_tables_init(AcpiBuildTables *tables);
 void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre);
 void
-build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
-           const char *oem_id, const char *oem_table_id);
-void
 build_xsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
            const char *oem_id, const char *oem_table_id);
 
-- 
2.13.3
