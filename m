Received: from eggs.gnu.org ([2001:4830:134:3::10]:57507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dapab-0000Cl-UF
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 16:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dapaX-0006J8-0m
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 16:40:57 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1dapaW-0006IW-MM
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 16:40:52 -0400
Received: by mail-qt0-x243.google.com with SMTP id u19so8405564qtc.0
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 13:40:52 -0700 (PDT)
Date: Thu, 27 Jul 2017 16:40:50 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170727204050.GA10211@morn.lan>
References: <20170726093136.13627-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170726093136.13627-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [qemu PATCH for 2.10] i386: acpi: provide an XSDT
 instead of an RSDT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, seabios@seabios.org, lersek@redhat.com, lists@philjordan.eu, imammedo@redhat.com, mst@redhat.com, phil@philjordan.eu, programmingkidx@gmail.com, kraxel@redhat.com

On Wed, Jul 26, 2017 at 11:31:36AM +0200, Paolo Bonzini wrote:
> The tables that QEMU provides are not ACPI 1.0 compatible since commit
> 77af8a2b95 ("hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve
> guest OS support.", 2017-05-03).  This is visible with Windows 2000,
> which refuses to parse the rev3 FADT and fails to boot.
> 
> The recommended solution in this case is to build two FADTs, v1 being
> pointed to by the RSDT and v3 by the XSDT.  However, we leave this task
> to the firmware.  This patch simply switches the RSDT to the XSDT, which
> is valid for all ACPI 2.0-friendly operating systems and also leaves
> SeaBIOS the freedom to build an RSDT that points to the compatibility
> FADT.

Another possible solution to this issue would be for QEMU to instruct
the firmware to build both rev1 and rev3 FADTs, but be clear which
links are for legacy purposes only.  This could be done with a new
ADD_LEGACY_POINTER linker loader command.  Existing firmwares should
ignore the new ADD_LEGACY_POINTER command and new versions of SeaBIOS
could be extended to honor it.

I proto-typed it (but haven't done significant testing).  Admittedly,
it is a pretty ugly hack.

-Kevin


====================== SeaBIOS patch =======================

--- a/src/fw/romfile_loader.c
+++ b/src/fw/romfile_loader.c
@@ -234,6 +234,7 @@ int romfile_loader_execute(const char *name)
         case ROMFILE_LOADER_COMMAND_ALLOCATE:
             romfile_loader_allocate(entry, files);
             break;
+        case ROMFILE_LOADER_COMMAND_ADD_LEGACY_POINTER:
         case ROMFILE_LOADER_COMMAND_ADD_POINTER:
             romfile_loader_add_pointer(entry, files);
             break;
diff --git a/src/fw/romfile_loader.h b/src/fw/romfile_loader.h
index fcd4ab2..4e266e8 100644
--- a/src/fw/romfile_loader.h
+++ b/src/fw/romfile_loader.h
@@ -77,6 +77,7 @@ enum {
     ROMFILE_LOADER_COMMAND_ADD_POINTER        = 0x2,
     ROMFILE_LOADER_COMMAND_ADD_CHECKSUM       = 0x3,
     ROMFILE_LOADER_COMMAND_WRITE_POINTER      = 0x4,
+    ROMFILE_LOADER_COMMAND_ADD_LEGACY_POINTER = 0x5,
 };
 
 enum {


====================== QEMU patch =======================

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 36a6cc4..eed1a2c 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1576,7 +1576,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
 /* Build rsdt table */
 void
 build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
-           const char *oem_id, const char *oem_table_id)
+           const char *oem_id, const char *oem_table_id, unsigned fadt)
 {
     int i;
     unsigned rsdt_entries_offset;
@@ -1587,12 +1587,15 @@ build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
 
     rsdt = acpi_data_push(table_data, rsdt_len);
     rsdt_entries_offset = (char *)rsdt->table_offset_entry - table_data->data;
-    for (i = 0; i < table_offsets->len; ++i) {
+    bios_linker_loader_add_legacy_pointer(linker,
+        ACPI_BUILD_TABLE_FILE, rsdt_entries_offset, rsdt_entry_size,
+        ACPI_BUILD_TABLE_FILE, fadt);
+    for (i = 1; i < table_offsets->len; ++i) {
         uint32_t ref_tbl_offset = g_array_index(table_offsets, uint32_t, i);
         uint32_t rsdt_entry_offset = rsdt_entries_offset + rsdt_entry_size * i;
 
         /* rsdt->table_offset_entry to be filled by Guest linker */
-        bios_linker_loader_add_pointer(linker,
+        bios_linker_loader_add_legacy_pointer(linker,
             ACPI_BUILD_TABLE_FILE, rsdt_entry_offset, rsdt_entry_size,
             ACPI_BUILD_TABLE_FILE, ref_tbl_offset);
     }
diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
index 046183a..3be6ac4 100644
--- a/hw/acpi/bios-linker-loader.c
+++ b/hw/acpi/bios-linker-loader.c
@@ -100,10 +100,11 @@ struct BiosLinkerLoaderEntry {
 typedef struct BiosLinkerLoaderEntry BiosLinkerLoaderEntry;
 
 enum {
-    BIOS_LINKER_LOADER_COMMAND_ALLOCATE          = 0x1,
-    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER       = 0x2,
-    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM      = 0x3,
-    BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER     = 0x4,
+    BIOS_LINKER_LOADER_COMMAND_ALLOCATE           = 0x1,
+    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER        = 0x2,
+    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM       = 0x3,
+    BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER      = 0x4,
+    BIOS_LINKER_LOADER_COMMAND_ADD_LEGACY_POINTER = 0x5,
 };
 
 enum {
@@ -243,28 +244,13 @@ void bios_linker_loader_add_checksum(BIOSLinker *linker, const char *file_name,
     g_array_append_vals(linker->cmd_blob, &entry, sizeof entry);
 }
 
-/*
- * bios_linker_loader_add_pointer: ask guest to patch address in
- * destination file with a pointer to source file
- *
- * @linker: linker object instance
- * @dest_file: destination file that must be changed
- * @dst_patched_offset: location within destination file blob to be patched
- *                      with the pointer to @src_file+@src_offset (i.e. source
- *                      blob allocated in guest memory + @src_offset), in bytes
- * @dst_patched_offset_size: size of the pointer to be patched
- *                      at @dst_patched_offset in @dest_file blob, in bytes
- * @src_file: source file who's address must be taken
- * @src_offset: location within source file blob to which
- *              @dest_file+@dst_patched_offset will point to after
- *              firmware's executed ADD_POINTER command
- */
-void bios_linker_loader_add_pointer(BIOSLinker *linker,
-                                    const char *dest_file,
-                                    uint32_t dst_patched_offset,
-                                    uint8_t dst_patched_size,
-                                    const char *src_file,
-                                    uint32_t src_offset)
+static void add_pointer(BIOSLinker *linker,
+                        const char *dest_file,
+                        uint32_t dst_patched_offset,
+                        uint8_t dst_patched_size,
+                        const char *src_file,
+                        uint32_t src_offset,
+                        uint32_t command)
 {
     uint64_t le_src_offset;
     BiosLinkerLoaderEntry entry;
@@ -282,7 +268,7 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
             sizeof entry.pointer.dest_file - 1);
     strncpy(entry.pointer.src_file, src_file,
             sizeof entry.pointer.src_file - 1);
-    entry.command = cpu_to_le32(BIOS_LINKER_LOADER_COMMAND_ADD_POINTER);
+    entry.command = cpu_to_le32(command);
     entry.pointer.offset = cpu_to_le32(dst_patched_offset);
     entry.pointer.size = dst_patched_size;
     assert(dst_patched_size == 1 || dst_patched_size == 2 ||
@@ -296,6 +282,61 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
 }
 
 /*
+ * bios_linker_loader_add_pointer: ask guest to patch address in
+ * destination file with a pointer to source file
+ *
+ * @linker: linker object instance
+ * @dest_file: destination file that must be changed
+ * @dst_patched_offset: location within destination file blob to be patched
+ *                      with the pointer to @src_file+@src_offset (i.e. source
+ *                      blob allocated in guest memory + @src_offset), in bytes
+ * @dst_patched_offset_size: size of the pointer to be patched
+ *                      at @dst_patched_offset in @dest_file blob, in bytes
+ * @src_file: source file who's address must be taken
+ * @src_offset: location within source file blob to which
+ *              @dest_file+@dst_patched_offset will point to after
+ *              firmware's executed ADD_POINTER command
+ */
+void bios_linker_loader_add_pointer(BIOSLinker *linker,
+                                    const char *dest_file,
+                                    uint32_t dst_patched_offset,
+                                    uint8_t dst_patched_size,
+                                    const char *src_file,
+                                    uint32_t src_offset)
+{
+    add_pointer(linker, dest_file, dst_patched_offset, dst_patched_size,
+                src_file, src_offset, BIOS_LINKER_LOADER_COMMAND_ADD_POINTER);
+}
+
+/*
+ * bios_linker_loader_add_legacy_pointer: ask guest to patch address in
+ * destination file with a pointer to a legacy acpi table in source file
+ *
+ * @linker: linker object instance
+ * @dest_file: destination file that must be changed
+ * @dst_patched_offset: location within destination file blob to be patched
+ *                      with the pointer to @src_file+@src_offset (i.e. source
+ *                      blob allocated in guest memory + @src_offset), in bytes
+ * @dst_patched_offset_size: size of the pointer to be patched
+ *                      at @dst_patched_offset in @dest_file blob, in bytes
+ * @src_file: source file who's address must be taken
+ * @src_offset: location within source file blob to which
+ *              @dest_file+@dst_patched_offset will point to after
+ *              firmware's executed ADD_POINTER command
+ */
+void bios_linker_loader_add_legacy_pointer(BIOSLinker *linker,
+                                           const char *dest_file,
+                                           uint32_t dst_patched_offset,
+                                           uint8_t dst_patched_size,
+                                           const char *src_file,
+                                           uint32_t src_offset)
+{
+    add_pointer(linker, dest_file, dst_patched_offset, dst_patched_size,
+                src_file, src_offset,
+                BIOS_LINKER_LOADER_COMMAND_ADD_LEGACY_POINTER);
+}
+
+/*
  * bios_linker_loader_write_pointer: ask guest to write a pointer to the
  * source file into the destination file, and write it back to QEMU via
  * fw_cfg DMA.
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6b7bade..6c83ba8 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -272,7 +272,7 @@ build_facs(GArray *table_data, BIOSLinker *linker)
 }
 
 /* Load chipset information in FADT */
-static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
+static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm, int rev)
 {
     fadt->model = 1;
     fadt->reserved1 = 0;
@@ -305,6 +305,9 @@ static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
     }
     fadt->century = RTC_CENTURY;
 
+    if (rev < 3)
+        return;
+
     fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_RESET_REG_SUP);
     fadt->reset_value = 0xf;
     fadt->reset_register.space_id = AML_SYSTEM_IO;
@@ -334,9 +337,34 @@ static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
 
 /* FADT */
 static void
-build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
-           unsigned facs_tbl_offset, unsigned dsdt_tbl_offset,
-           const char *oem_id, const char *oem_table_id)
+build_fadt1(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
+            unsigned facs_tbl_offset, unsigned dsdt_tbl_offset,
+            const char *oem_id, const char *oem_table_id)
+{
+    unsigned fadt_length = offsetof(AcpiFadtDescriptorRev3, boot_flags);
+    AcpiFadtDescriptorRev3 *fadt = acpi_data_push(table_data, fadt_length);
+    unsigned fw_ctrl_offset = (char *)&fadt->firmware_ctrl - table_data->data;
+    unsigned dsdt_entry_offset = (char *)&fadt->dsdt - table_data->data;
+
+    /* FACS address to be filled by Guest linker */
+    bios_linker_loader_add_pointer(linker,
+        ACPI_BUILD_TABLE_FILE, fw_ctrl_offset, sizeof(fadt->firmware_ctrl),
+        ACPI_BUILD_TABLE_FILE, facs_tbl_offset);
+
+    /* DSDT address to be filled by Guest linker */
+    fadt_setup(fadt, pm, 1);
+    bios_linker_loader_add_pointer(linker,
+        ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
+        ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
+
+    build_header(linker, table_data,
+                 (void *)fadt, "FACP", fadt_length, 1, oem_id, oem_table_id);
+}
+
+static void
+build_fadt3(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
+            unsigned facs_tbl_offset, unsigned dsdt_tbl_offset,
+            const char *oem_id, const char *oem_table_id)
 {
     AcpiFadtDescriptorRev3 *fadt = acpi_data_push(table_data, sizeof(*fadt));
     unsigned fw_ctrl_offset = (char *)&fadt->firmware_ctrl - table_data->data;
@@ -349,7 +377,7 @@ build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
         ACPI_BUILD_TABLE_FILE, facs_tbl_offset);
 
     /* DSDT address to be filled by Guest linker */
-    fadt_setup(fadt, pm);
+    fadt_setup(fadt, pm, 3);
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
         ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
@@ -2557,27 +2585,40 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
 }
 
 static GArray *
-build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
+build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset,
+           unsigned xsdt_tbl_offset)
 {
     AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
     unsigned rsdt_pa_size = sizeof(rsdp->rsdt_physical_address);
     unsigned rsdt_pa_offset =
         (char *)&rsdp->rsdt_physical_address - rsdp_table->data;
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
-    bios_linker_loader_add_pointer(linker,
+    bios_linker_loader_add_legacy_pointer(linker,
         ACPI_BUILD_RSDP_FILE, rsdt_pa_offset, rsdt_pa_size,
         ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset);
+    bios_linker_loader_add_pointer(linker,
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
@@ -2621,7 +2662,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     GArray *table_offsets;
-    unsigned facs, dsdt, rsdt, fadt;
+    unsigned facs, dsdt, rsdt, xsdt, fadt1;
     AcpiPmInfo pm;
     AcpiMiscInfo misc;
     AcpiMcfgInfo mcfg;
@@ -2665,11 +2706,14 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     aml_len += tables_blob->len - dsdt;
 
     /* ACPI tables pointed to by RSDT */
-    fadt = tables_blob->len;
+    fadt1 = tables_blob->len;
+    build_fadt1(tables_blob, tables->linker, &pm, facs, dsdt,
+                slic_oem.id, slic_oem.table_id);
+    aml_len += tables_blob->len - fadt1;
+
     acpi_add_table(table_offsets, tables_blob);
-    build_fadt(tables_blob, tables->linker, &pm, facs, dsdt,
-               slic_oem.id, slic_oem.table_id);
-    aml_len += tables_blob->len - fadt;
+    build_fadt3(tables_blob, tables->linker, &pm, facs, dsdt,
+                slic_oem.id, slic_oem.table_id);
 
     acpi_add_table(table_offsets, tables_blob);
     build_madt(tables_blob, tables->linker, pcms);
@@ -2729,13 +2773,16 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
         g_array_append_vals(tables_blob, u, len);
     }
 
-    /* RSDT is pointed to by RSDP */
+    /* RSDT and XSDT is pointed to by RSDP */
     rsdt = tables_blob->len;
     build_rsdt(tables_blob, tables->linker, table_offsets,
+               slic_oem.id, slic_oem.table_id, fadt1);
+    xsdt = tables_blob->len;
+    build_xsdt(tables_blob, tables->linker, table_offsets,
                slic_oem.id, slic_oem.table_id);
 
     /* RSDP is in FSEG memory, so allocate it separately */
-    build_rsdp(tables->rsdp, tables->linker, rsdt);
+    build_rsdp(tables->rsdp, tables->linker, rsdt, xsdt);
 
     /* We'll expose it all to Guest so we want to reduce
      * chance of size changes.
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 88d0738..9afaa34 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -380,7 +380,7 @@ void acpi_build_tables_init(AcpiBuildTables *tables);
 void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre);
 void
 build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
-           const char *oem_id, const char *oem_table_id);
+           const char *oem_id, const char *oem_table_id, unsigned fadt);
 void
 build_xsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
            const char *oem_id, const char *oem_table_id);
diff --git a/include/hw/acpi/bios-linker-loader.h b/include/hw/acpi/bios-linker-loader.h
index efe17b0..ccff3e7 100644
--- a/include/hw/acpi/bios-linker-loader.h
+++ b/include/hw/acpi/bios-linker-loader.h
@@ -26,6 +26,13 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
                                     const char *src_file,
                                     uint32_t src_offset);
 
+void bios_linker_loader_add_legacy_pointer(BIOSLinker *linker,
+                                           const char *dest_file,
+                                           uint32_t dst_patched_offset,
+                                           uint8_t dst_patched_size,
+                                           const char *src_file,
+                                           uint32_t src_offset);
+
 void bios_linker_loader_write_pointer(BIOSLinker *linker,
                                       const char *dest_file,
                                       uint32_t dst_patched_offset,
