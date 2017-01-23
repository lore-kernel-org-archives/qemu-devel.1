Received: from eggs.gnu.org ([2001:4830:134:3::10]:33923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cVZ86-00053y-Q1
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:33:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cVZ81-0006gU-Tz
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:33:30 -0500
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:33774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cVZ81-0006gB-Lm
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:33:25 -0500
Received: by mail-pf0-x22e.google.com with SMTP id y143so39244673pfb.0
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 23:33:25 -0800 (PST)
From: ben@skyportsystems.com
Date: Sun, 22 Jan 2017 23:32:48 -0800
Message-Id: <59d78a9d2a1a550a883449b86a7e90ab0bcd613a.1485155611.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485155611.git.ben@skyportsystems.com>
References: <cover.1485155611.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485155611.git.ben@skyportsystems.com>
References: <cover.1485155611.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v3 2/6] linker-loader: add new 'allocate and
 return address' cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

This adds a new linker-loader command to instruct the guest to allocate
memory for a fw_cfg file and write the address back into another
writeable fw_cfg file.  Knowing this address, QEMU can then write into
guest memory at runtime.

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 hw/acpi/bios-linker-loader.c         | 71 ++++++++++++++++++++++++++++++++++--
 include/hw/acpi/bios-linker-loader.h |  7 ++++
 2 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
index d963ebe..1d991ba 100644
--- a/hw/acpi/bios-linker-loader.c
+++ b/hw/acpi/bios-linker-loader.c
@@ -78,6 +78,22 @@ struct BiosLinkerLoaderEntry {
             uint32_t length;
         } cksum;
 
+        /*
+         * COMMAND_ALLOCATE_RETURN_ADDR - allocate a table from @alloc_ret_file
+         * subject to @alloc_ret_align alignment (must be power of 2)
+         * and @alloc_ret_zone (can be HIGH or FSEG) requirements.
+         * Additionally, return the address of the allocation in
+         * @addr_file.
+         *
+         * This may be used instead of COMMAND_ALLOCATE
+         */
+        struct {
+            char alloc_ret_file[BIOS_LINKER_LOADER_FILESZ];
+            uint32_t alloc_ret_align;
+            uint8_t alloc_ret_zone;
+            char alloc_ret_addr_file[BIOS_LINKER_LOADER_FILESZ];
+        };
+
         /* padding */
         char pad[124];
     };
@@ -85,9 +101,10 @@ struct BiosLinkerLoaderEntry {
 typedef struct BiosLinkerLoaderEntry BiosLinkerLoaderEntry;
 
 enum {
-    BIOS_LINKER_LOADER_COMMAND_ALLOCATE     = 0x1,
-    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER  = 0x2,
-    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM = 0x3,
+    BIOS_LINKER_LOADER_COMMAND_ALLOCATE          = 0x1,
+    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER       = 0x2,
+    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM      = 0x3,
+    BIOS_LINKER_LOADER_COMMAND_ALLOCATE_RET_ADDR = 0x4,
 };
 
 enum {
@@ -278,3 +295,51 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
 
     g_array_append_vals(linker->cmd_blob, &entry, sizeof entry);
 }
+
+/*
+ * bios_linker_loader_alloc_ret_addr: ask guest to load file into guest memory
+ * and patch the address in another file
+ *
+ * @linker: linker object instance
+ * @data_file: name of the file blob to be loaded
+ * @file_blob: pointer to blob corresponding to @file_name
+ * @alloc_align: required minimal alignment in bytes. Must be a power of 2.
+ * @alloc_fseg: request allocation in FSEG zone (useful for the RSDP ACPI table)
+ * @addr_file: destination file that will contain the address.
+ *             This must already exist
+ *
+ * Note: this command must precede any other linker command that uses
+ * the data file.
+ */
+void bios_linker_loader_alloc_ret_addr(BIOSLinker *linker,
+                              const char *data_file,
+                              GArray *file_blob,
+                              uint32_t alloc_align,
+                              bool alloc_fseg,
+                              const char *addr_file)
+{
+    BiosLinkerLoaderEntry entry;
+    BiosLinkerFileEntry d_file = { g_strdup(data_file), file_blob};
+
+    /* Address file is expected to already be loaded */
+    const BiosLinkerFileEntry *a_file =
+        bios_linker_find_file(linker, addr_file);
+
+    assert(!(alloc_align & (alloc_align - 1)));
+    assert(a_file);
+
+    g_array_append_val(linker->file_list, d_file);
+
+    memset(&entry, 0, sizeof entry);
+    strncpy(entry.alloc_ret_file, data_file,
+            sizeof entry.alloc_ret_file - 1);
+    strncpy(entry.alloc_ret_addr_file, addr_file,
+            sizeof entry.alloc_ret_addr_file - 1);
+    entry.command = cpu_to_le32(BIOS_LINKER_LOADER_COMMAND_ALLOCATE_RET_ADDR);
+    entry.alloc.align = cpu_to_le32(alloc_align);
+    entry.alloc.zone = alloc_fseg ? BIOS_LINKER_LOADER_ALLOC_ZONE_FSEG :
+                                    BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH;
+
+    /* Alloc entries must come first, so prepend them */
+    g_array_append_vals(linker->cmd_blob, &entry, sizeof entry);
+}
diff --git a/include/hw/acpi/bios-linker-loader.h b/include/hw/acpi/bios-linker-loader.h
index fa1e5d1..69953e6 100644
--- a/include/hw/acpi/bios-linker-loader.h
+++ b/include/hw/acpi/bios-linker-loader.h
@@ -26,5 +26,12 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
                                     const char *src_file,
                                     uint32_t src_offset);
 
+void bios_linker_loader_alloc_ret_addr(BIOSLinker *linker,
+                                       const char *data_file,
+                                       GArray *file_blob,
+                                       uint32_t alloc_align,
+                                       bool alloc_fseg,
+                                       const char *addr_file);
+
 void bios_linker_loader_cleanup(BIOSLinker *linker);
 #endif
-- 
2.10.1 (Apple Git-78)
