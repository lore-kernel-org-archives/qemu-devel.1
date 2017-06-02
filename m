Received: from eggs.gnu.org ([2001:4830:134:3::10]:51739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGozy-0006bh-PW
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGozw-0000Qx-A2
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGozv-0000Pk-TS
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:24 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri,  2 Jun 2017 18:00:00 +0200
Message-Id: <20170602160006.1748-2-lersek@redhat.com>
In-Reply-To: <20170602160006.1748-1-lersek@redhat.com>
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
	<20170602160006.1748-1-lersek@redhat.com>
Subject: [Qemu-devel] [qemu PATCH 1/7] hw/acpi/bios-linker-loader: expose
 allocation zone as an enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: SeaBIOS@seabios.org, qemu-devel@nongnu.org, edk2-devel@lists.01.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ben Warren <ben@skyportsystems.com>, Dongjiu Geng <gengdongjiu@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>

In a later patch, we'll introduce another allocation zone (which won't fit
in the "alloc_fseg" bool). For now, just move the enum constants from
"bios-linker-loader.c" to "bios-linker-loader.h", and update the
bios_linker_loader_alloc() function prototype so that callers can directly
pass in the enumeration constants.

This is all the more justified because at the bios_linker_loader_alloc()
call sites, the true/false arguments passed in to the current "alloc_fseg"
boolean parameter are always accompanied by a textual comment that spells
out the actual zone. So this patch improves clarity in itself.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Ben Warren <ben@skyportsystems.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 include/hw/acpi/bios-linker-loader.h | 10 +++++++++-
 hw/acpi/bios-linker-loader.c         | 14 ++++----------
 hw/acpi/nvdimm.c                     |  3 ++-
 hw/acpi/vmgenid.c                    |  5 +++--
 hw/arm/virt-acpi-build.c             |  4 ++--
 hw/i386/acpi-build.c                 |  6 +++---
 6 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/include/hw/acpi/bios-linker-loader.h b/include/hw/acpi/bios-linker-loader.h
index efe17b0b9cb0..8d55f1fab32b 100644
--- a/include/hw/acpi/bios-linker-loader.h
+++ b/include/hw/acpi/bios-linker-loader.h
@@ -5,17 +5,25 @@
 typedef struct BIOSLinker {
     GArray *cmd_blob;
     GArray *file_list;
 } BIOSLinker;
 
+typedef enum BIOSLinkerLoaderAllocZone {
+    /* request blob allocation in 32-bit memory */
+    BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH = 0x1,
+
+    /* request blob allocation in FSEG zone (useful for the RSDP ACPI table) */
+    BIOS_LINKER_LOADER_ALLOC_ZONE_FSEG = 0x2,
+} BIOSLinkerLoaderAllocZone;
+
 BIOSLinker *bios_linker_loader_init(void);
 
 void bios_linker_loader_alloc(BIOSLinker *linker,
                               const char *file_name,
                               GArray *file_blob,
                               uint32_t alloc_align,
-                              bool alloc_fseg);
+                              BIOSLinkerLoaderAllocZone zone);
 
 void bios_linker_loader_add_checksum(BIOSLinker *linker, const char *file,
                                      unsigned start_offset, unsigned size,
                                      unsigned checksum_offset);
 
diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
index 046183a0f142..9754d98e7345 100644
--- a/hw/acpi/bios-linker-loader.c
+++ b/hw/acpi/bios-linker-loader.c
@@ -38,11 +38,11 @@ struct BiosLinkerLoaderEntry {
     uint32_t command;
     union {
         /*
          * COMMAND_ALLOCATE - allocate a table from @alloc.file
          * subject to @alloc.align alignment (must be power of 2)
-         * and @alloc.zone (can be HIGH or FSEG) requirements.
+         * and @alloc.zone (see BIOSLinkerLoaderAllocZone) requirements.
          *
          * Must appear exactly once for each file, and before
          * this file is referenced by any other command.
          */
         struct {
@@ -104,15 +104,10 @@ enum {
     BIOS_LINKER_LOADER_COMMAND_ADD_POINTER       = 0x2,
     BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM      = 0x3,
     BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER     = 0x4,
 };
 
-enum {
-    BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH = 0x1,
-    BIOS_LINKER_LOADER_ALLOC_ZONE_FSEG = 0x2,
-};
-
 /*
  * BiosLinkerFileEntry:
  *
  * An internal type used for book-keeping file entries
  */
@@ -173,19 +168,19 @@ bios_linker_find_file(const BIOSLinker *linker, const char *name)
  *
  * @linker: linker object instance
  * @file_name: name of the file blob to be loaded
  * @file_blob: pointer to blob corresponding to @file_name
  * @alloc_align: required minimal alignment in bytes. Must be a power of 2.
- * @alloc_fseg: request allocation in FSEG zone (useful for the RSDP ACPI table)
+ * @zone: request allocation in this zone
  *
  * Note: this command must precede any other linker command using this file.
  */
 void bios_linker_loader_alloc(BIOSLinker *linker,
                               const char *file_name,
                               GArray *file_blob,
                               uint32_t alloc_align,
-                              bool alloc_fseg)
+                              BIOSLinkerLoaderAllocZone zone)
 {
     BiosLinkerLoaderEntry entry;
     BiosLinkerFileEntry file = { g_strdup(file_name), file_blob};
 
     assert(!(alloc_align & (alloc_align - 1)));
@@ -195,12 +190,11 @@ void bios_linker_loader_alloc(BIOSLinker *linker,
 
     memset(&entry, 0, sizeof entry);
     strncpy(entry.alloc.file, file_name, sizeof entry.alloc.file - 1);
     entry.command = cpu_to_le32(BIOS_LINKER_LOADER_COMMAND_ALLOCATE);
     entry.alloc.align = cpu_to_le32(alloc_align);
-    entry.alloc.zone = alloc_fseg ? BIOS_LINKER_LOADER_ALLOC_ZONE_FSEG :
-                                    BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH;
+    entry.alloc.zone = zone;
 
     /* Alloc entries must come first, so prepend them */
     g_array_prepend_vals(linker->cmd_blob, &entry, sizeof entry);
 }
 
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 8e7d6ec03490..91dd0df4b128 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -1261,11 +1261,12 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
     mem_addr_offset = build_append_named_dword(table_data,
                                                NVDIMM_ACPI_MEM_ADDR);
 
     bios_linker_loader_alloc(linker,
                              NVDIMM_DSM_MEM_FILE, dsm_dma_arrea,
-                             sizeof(NvdimmDsmIn), false /* high memory */);
+                             sizeof(NvdimmDsmIn),
+                             BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH);
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, mem_addr_offset, sizeof(uint32_t),
         NVDIMM_DSM_MEM_FILE, 0);
     build_header(linker, table_data,
         (void *)(table_data->data + nvdimm_ssdt),
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index a32b847fe0df..315d3b3327ed 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -88,12 +88,13 @@ void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *guid,
     aml_append(ssdt, method);
 
     g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
 
     /* Allocate guest memory for the Data fw_cfg blob */
-    bios_linker_loader_alloc(linker, VMGENID_GUID_FW_CFG_FILE, guid, 4096,
-                             false /* page boundary, high memory */);
+    bios_linker_loader_alloc(linker, VMGENID_GUID_FW_CFG_FILE, guid,
+                             4096 /* page boundary */,
+                             BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH);
 
     /* Patch address of GUID fw_cfg blob into the ADDR fw_cfg blob
      * so QEMU can write the GUID there.  The address is expected to be
      * < 4GB, but write 64 bits anyway.
      * The address that is patched in is offset in order to implement
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e5852067f5bd..a378e18b0d97 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -370,11 +370,11 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
     unsigned xsdt_pa_size = sizeof(rsdp->xsdt_physical_address);
     unsigned xsdt_pa_offset =
         (char *)&rsdp->xsdt_physical_address - rsdp_table->data;
 
     bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 16,
-                             true /* fseg memory */);
+                             BIOS_LINKER_LOADER_ALLOC_ZONE_FSEG);
 
     memcpy(&rsdp->signature, "RSD PTR ", sizeof(rsdp->signature));
     memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, sizeof(rsdp->oem_id));
     rsdp->length = cpu_to_le32(sizeof(*rsdp));
     rsdp->revision = 0x02;
@@ -749,11 +749,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     table_offsets = g_array_new(false, true /* clear */,
                                         sizeof(uint32_t));
 
     bios_linker_loader_alloc(tables->linker,
                              ACPI_BUILD_TABLE_FILE, tables_blob,
-                             64, false /* high memory */);
+                             64, BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH);
 
     /* DSDT is pointed to by FADT */
     dsdt = tables_blob->len;
     build_dsdt(tables_blob, tables->linker, vms);
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index afcadacd2e7d..4e7b30b44d5a 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2285,11 +2285,11 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
     tcpa->platform_class = cpu_to_le16(TPM_TCPA_ACPI_CLASS_CLIENT);
     tcpa->log_area_minimum_length = cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
     acpi_data_push(tcpalog, le32_to_cpu(tcpa->log_area_minimum_length));
 
     bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
-                             false /* high memory */);
+                             BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH);
 
     /* log area start address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, log_addr_offset, log_addr_size,
         ACPI_BUILD_TPMLOG_FILE, 0);
@@ -2570,11 +2570,11 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
     unsigned rsdt_pa_size = sizeof(rsdp->rsdt_physical_address);
     unsigned rsdt_pa_offset =
         (char *)&rsdp->rsdt_physical_address - rsdp_table->data;
 
     bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 16,
-                             true /* fseg memory */);
+                             BIOS_LINKER_LOADER_ALLOC_ZONE_FSEG);
 
     memcpy(&rsdp->signature, "RSD PTR ", 8);
     memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, 6);
     /* Address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker,
@@ -2649,11 +2649,11 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     ACPI_BUILD_DPRINTF("init ACPI tables\n");
 
     bios_linker_loader_alloc(tables->linker,
                              ACPI_BUILD_TABLE_FILE, tables_blob,
                              64 /* Ensure FACS is aligned */,
-                             false /* high memory */);
+                             BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH);
 
     /*
      * FACS is pointed to by FADT.
      * We place it first since it's the only table that has alignment
      * requirements.
-- 
2.9.3
