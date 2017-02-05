Received: from eggs.gnu.org ([2001:4830:134:3::10]:59509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1caIsB-0002XH-IP
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1caIsA-0001rE-0G
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:39 -0500
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:36566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1caIs9-0001r7-Nw
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:37 -0500
Received: by mail-pg0-x230.google.com with SMTP id v184so19465480pgv.3
	for <qemu-devel@nongnu.org>; Sun, 05 Feb 2017 01:12:37 -0800 (PST)
From: ben@skyportsystems.com
Date: Sun,  5 Feb 2017 01:11:57 -0800
Message-Id: <2bb2dd455ea355b279867a312924add82ae685e4.1486285434.git.ben@skyportsystems.com>
In-Reply-To: <cover.1486285434.git.ben@skyportsystems.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
In-Reply-To: <cover.1486285434.git.ben@skyportsystems.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v5 02/10] linker-loader: Add new 'write
 pointer' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

This adds to the existing 'add pointer' functionality in that it
instructs the guest (BIOS or UEFI) to not patch memory but to instead
write the changes back to QEMU via a writeable fw_cfg file.

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 hw/acpi/aml-build.c                  |  2 +-
 hw/acpi/bios-linker-loader.c         | 35 ++++++++++++++++++++++++-----------
 hw/acpi/nvdimm.c                     |  2 +-
 hw/arm/virt-acpi-build.c             |  4 ++--
 hw/i386/acpi-build.c                 |  8 ++++----
 include/hw/acpi/bios-linker-loader.h |  3 ++-
 6 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 9fc54c9..03b6c6c 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1626,7 +1626,7 @@ build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
         /* rsdt->table_offset_entry to be filled by Guest linker */
         bios_linker_loader_add_pointer(linker,
             ACPI_BUILD_TABLE_FILE, rsdt_entry_offset, rsdt_entry_size,
-            ACPI_BUILD_TABLE_FILE, ref_tbl_offset);
+            ACPI_BUILD_TABLE_FILE, ref_tbl_offset, false);
     }
     build_header(linker, table_data,
                  (void *)rsdt, "RSDT", rsdt_len, 1, oem_id, oem_table_id);
diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
index d963ebe..e46bc29 100644
--- a/hw/acpi/bios-linker-loader.c
+++ b/hw/acpi/bios-linker-loader.c
@@ -52,10 +52,13 @@ struct BiosLinkerLoaderEntry {
         } alloc;
 
         /*
-         * COMMAND_ADD_POINTER - patch the table (originating from
-         * @dest_file) at @pointer.offset, by adding a pointer to the table
+         * COMMAND_ADD_POINTER &
+         * COMMAND_WRITE_POINTER - patch guest memory (originating from
+         * @dest_file) at @pointer.offset, by adding a pointer to the memory
          * originating from @src_file. 1,2,4 or 8 byte unsigned
          * addition is used depending on @pointer.size.
+         * Instead of patching memory, COMMAND_WRITE_POINTER writes the changes
+         * to @dest_file in QEMU via fw_cfg DMA.
          */
         struct {
             char dest_file[BIOS_LINKER_LOADER_FILESZ];
@@ -85,9 +88,10 @@ struct BiosLinkerLoaderEntry {
 typedef struct BiosLinkerLoaderEntry BiosLinkerLoaderEntry;
 
 enum {
-    BIOS_LINKER_LOADER_COMMAND_ALLOCATE     = 0x1,
-    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER  = 0x2,
-    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM = 0x3,
+    BIOS_LINKER_LOADER_COMMAND_ALLOCATE          = 0x1,
+    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER       = 0x2,
+    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM      = 0x3,
+    BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER     = 0x4,
 };
 
 enum {
@@ -242,13 +246,15 @@ void bios_linker_loader_add_checksum(BIOSLinker *linker, const char *file_name,
  * @src_offset: location within source file blob to which
  *              @dest_file+@dst_patched_offset will point to after
  *              firmware's executed ADD_POINTER command
+ * @write_back: guest should write change contents back to QEMU after patching
  */
 void bios_linker_loader_add_pointer(BIOSLinker *linker,
                                     const char *dest_file,
                                     uint32_t dst_patched_offset,
                                     uint8_t dst_patched_size,
                                     const char *src_file,
-                                    uint32_t src_offset)
+                                    uint32_t src_offset,
+                                    bool write_back)
 {
     uint64_t le_src_offset;
     BiosLinkerLoaderEntry entry;
@@ -257,8 +263,11 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
     const BiosLinkerFileEntry *source_file =
         bios_linker_find_file(linker, src_file);
 
-    assert(dst_patched_offset < dst_file->blob->len);
-    assert(dst_patched_offset + dst_patched_size <= dst_file->blob->len);
+    /* dst_file need not exist if writing back */
+    if (!write_back) {
+        assert(dst_patched_offset < dst_file->blob->len);
+        assert(dst_patched_offset + dst_patched_size <= dst_file->blob->len);
+    }
     assert(src_offset < source_file->blob->len);
 
     memset(&entry, 0, sizeof entry);
@@ -266,15 +275,19 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
             sizeof entry.pointer.dest_file - 1);
     strncpy(entry.pointer.src_file, src_file,
             sizeof entry.pointer.src_file - 1);
-    entry.command = cpu_to_le32(BIOS_LINKER_LOADER_COMMAND_ADD_POINTER);
+    entry.command = cpu_to_le32(write_back ?
+                                BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER :
+                                BIOS_LINKER_LOADER_COMMAND_ADD_POINTER);
     entry.pointer.offset = cpu_to_le32(dst_patched_offset);
     entry.pointer.size = dst_patched_size;
     assert(dst_patched_size == 1 || dst_patched_size == 2 ||
            dst_patched_size == 4 || dst_patched_size == 8);
 
     le_src_offset = cpu_to_le64(src_offset);
-    memcpy(dst_file->blob->data + dst_patched_offset,
-           &le_src_offset, dst_patched_size);
+    if (!write_back) {
+        memcpy(dst_file->blob->data + dst_patched_offset,
+               &le_src_offset, dst_patched_size);
+    }
 
     g_array_append_vals(linker->cmd_blob, &entry, sizeof entry);
 }
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 8e7d6ec..175996e 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -1266,7 +1266,7 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
                              sizeof(NvdimmDsmIn), false /* high memory */);
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, mem_addr_offset, sizeof(uint32_t),
-        NVDIMM_DSM_MEM_FILE, 0);
+        NVDIMM_DSM_MEM_FILE, 0, false);
     build_header(linker, table_data,
         (void *)(table_data->data + nvdimm_ssdt),
         "SSDT", table_data->len - nvdimm_ssdt, 1, NULL, "NVDIMM");
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 07a10ac..a13f40d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -380,7 +380,7 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
     /* Address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_RSDP_FILE, rsdt_pa_offset, rsdt_pa_size,
-        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset);
+        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset, false);
 
     /* Checksum to be filled by Guest linker */
     bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
@@ -684,7 +684,7 @@ static void build_fadt(GArray *table_data, BIOSLinker *linker,
     /* DSDT address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
-        ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
+        ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset, false);
 
     build_header(linker, table_data,
                  (void *)fadt, "FACP", sizeof(*fadt), 5, NULL, NULL);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1c928ab..78a1d84 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -319,13 +319,13 @@ build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
     /* FACS address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, fw_ctrl_offset, sizeof(fadt->firmware_ctrl),
-        ACPI_BUILD_TABLE_FILE, facs_tbl_offset);
+        ACPI_BUILD_TABLE_FILE, facs_tbl_offset, false);
 
     /* DSDT address to be filled by Guest linker */
     fadt_setup(fadt, pm);
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
-        ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
+        ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset, false);
 
     build_header(linker, table_data,
                  (void *)fadt, "FACP", sizeof(*fadt), 1, oem_id, oem_table_id);
@@ -2262,7 +2262,7 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
     /* log area start address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, log_addr_offset, log_addr_size,
-        ACPI_BUILD_TPMLOG_FILE, 0);
+        ACPI_BUILD_TPMLOG_FILE, 0, false);
 
     build_header(linker, table_data,
                  (void *)tcpa, "TCPA", sizeof(*tcpa), 2, NULL, NULL);
@@ -2552,7 +2552,7 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
     /* Address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_RSDP_FILE, rsdt_pa_offset, rsdt_pa_size,
-        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset);
+        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset, false);
 
     /* Checksum to be filled by Guest linker */
     bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
diff --git a/include/hw/acpi/bios-linker-loader.h b/include/hw/acpi/bios-linker-loader.h
index fa1e5d1..d97e39d 100644
--- a/include/hw/acpi/bios-linker-loader.h
+++ b/include/hw/acpi/bios-linker-loader.h
@@ -24,7 +24,8 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
                                     uint32_t dst_patched_offset,
                                     uint8_t dst_patched_size,
                                     const char *src_file,
-                                    uint32_t src_offset);
+                                    uint32_t src_offset,
+                                    bool write_back);
 
 void bios_linker_loader_cleanup(BIOSLinker *linker);
 #endif
-- 
2.7.4
