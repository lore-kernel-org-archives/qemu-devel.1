Received: from eggs.gnu.org ([2001:4830:134:3::10]:42520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cdssu-00023D-7w
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cdssq-0007DD-Pa
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:16:12 -0500
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:36595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cdssq-0007Ch-Hp
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:16:08 -0500
Received: by mail-pg0-x22f.google.com with SMTP id v184so34070435pgv.3
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 22:16:07 -0800 (PST)
From: ben@skyportsystems.com
Date: Tue, 14 Feb 2017 22:15:43 -0800
Message-Id: <9dffe31a245cf6a717eef8227fe80ca666b168b5.1487139038.git.ben@skyportsystems.com>
In-Reply-To: <cover.1487139038.git.ben@skyportsystems.com>
References: <cover.1487139038.git.ben@skyportsystems.com>
In-Reply-To: <cover.1487139038.git.ben@skyportsystems.com>
References: <cover.1487139038.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v6 1/7] linker-loader: Add new 'write pointer'
 command
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

This is similar to the existing 'add pointer' functionality, but instead
of instructing the guest (BIOS or UEFI) to patch memory, it instructs
the guest to write the pointer back to QEMU via a writeable fw_cfg file.

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 hw/acpi/bios-linker-loader.c         | 58 ++++++++++++++++++++++++++++++++++--
 include/hw/acpi/bios-linker-loader.h |  6 ++++
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
index d963ebe..5030cf1 100644
--- a/hw/acpi/bios-linker-loader.c
+++ b/hw/acpi/bios-linker-loader.c
@@ -78,6 +78,19 @@ struct BiosLinkerLoaderEntry {
             uint32_t length;
         } cksum;
 
+        /*
+         * COMMAND_WRITE_POINTER - write the fw_cfg file (originating from
+         * @dest_file) at @wr_pointer.offset, by adding a pointer to the table
+         * originating from @src_file. 1,2,4 or 8 byte unsigned
+         * addition is used depending on @wr_pointer.size.
+         */
+        struct {
+            char dest_file[BIOS_LINKER_LOADER_FILESZ];
+            char src_file[BIOS_LINKER_LOADER_FILESZ];
+            uint32_t offset;
+            uint8_t size;
+        } wr_pointer;
+
         /* padding */
         char pad[124];
     };
@@ -85,9 +98,10 @@ struct BiosLinkerLoaderEntry {
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
@@ -278,3 +292,41 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
 
     g_array_append_vals(linker->cmd_blob, &entry, sizeof entry);
 }
+
+/*
+ * bios_linker_loader_write_pointer: ask guest to write a pointer to the
+ * source file into the destination file, and write it back to QEMU via
+ * fw_cfg DMA.
+ *
+ * @linker: linker object instance
+ * @dest_file: destination file that must be written
+ * @dst_patched_offset: location within destination file blob to be patched
+ *                      with the pointer to @src_file, in bytes
+ * @dst_patched_offset_size: size of the pointer to be patched
+ *                      at @dst_patched_offset in @dest_file blob, in bytes
+ * @src_file: source file who's address must be taken
+ */
+void bios_linker_loader_write_pointer(BIOSLinker *linker,
+                                    const char *dest_file,
+                                    uint32_t dst_patched_offset,
+                                    uint8_t dst_patched_size,
+                                    const char *src_file)
+{
+    BiosLinkerLoaderEntry entry;
+    const BiosLinkerFileEntry *source_file =
+        bios_linker_find_file(linker, src_file);
+
+    assert(source_file);
+    memset(&entry, 0, sizeof entry);
+    strncpy(entry.wr_pointer.dest_file, dest_file,
+            sizeof entry.wr_pointer.dest_file - 1);
+    strncpy(entry.wr_pointer.src_file, src_file,
+            sizeof entry.wr_pointer.src_file - 1);
+    entry.command = cpu_to_le32(BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER);
+    entry.wr_pointer.offset = cpu_to_le32(dst_patched_offset);
+    entry.wr_pointer.size = dst_patched_size;
+    assert(dst_patched_size == 1 || dst_patched_size == 2 ||
+           dst_patched_size == 4 || dst_patched_size == 8);
+
+    g_array_append_vals(linker->cmd_blob, &entry, sizeof entry);
+}
diff --git a/include/hw/acpi/bios-linker-loader.h b/include/hw/acpi/bios-linker-loader.h
index fa1e5d1..f9ba5d6 100644
--- a/include/hw/acpi/bios-linker-loader.h
+++ b/include/hw/acpi/bios-linker-loader.h
@@ -26,5 +26,11 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
                                     const char *src_file,
                                     uint32_t src_offset);
 
+void bios_linker_loader_write_pointer(BIOSLinker *linker,
+                                      const char *dest_file,
+                                      uint32_t dst_patched_offset,
+                                      uint8_t dst_patched_size,
+                                      const char *src_file);
+
 void bios_linker_loader_cleanup(BIOSLinker *linker);
 #endif
-- 
2.7.4
