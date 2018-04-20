Received: from eggs.gnu.org ([2001:4830:134:3::10]:33397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f9Pnj-0000hi-6w
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f9Pne-0004Ei-CW
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:45:43 -0400
Received: from smtp15.cstnet.cn ([159.226.251.15]:37081 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f9Pnd-0004BN-G0
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:45:38 -0400
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Fri, 20 Apr 2018 14:45:31 +0800
Message-Id: <1524206732-7729-2-git-send-email-suhang16@mails.ucas.ac.cn>
In-Reply-To: <1524206732-7729-1-git-send-email-suhang16@mails.ucas.ac.cn>
References: <1524206732-7729-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel]  [PATCH v5 1/2] Implement .hex file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au
Cc: qemu-devel@nongnu.org


This patch adds Intel Hexadecimal Object File format support to
the loader.  The file format specification is available here:
http://www.piclist.com/techref/fileext/hex/intel.htm

The file format is mainly intended for embedded systems
and microcontrollers, such as Arduino, ARM, STM32, etc.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
---
 hw/arm/boot.c       |  18 ++--
 hw/core/loader.c    | 253 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/loader.h |  14 +++
 3 files changed, 280 insertions(+), 5 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 26184bcd7c26..898a7af114ea 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1070,12 +1070,20 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
         kernel_size = load_aarch64_image(info->kernel_filename,
                                          info->loader_start, &entry, as);
         is_linux = 1;
-    } else if (kernel_size < 0) {
-        /* 32-bit ARM */
+    }
+    if (kernel_size < 0) {
+        /* 32-bit ARM .hex file */
+        entry = info->loader_start + KERNEL_LOAD_ADDR;
+        kernel_size =
+            load_targphys_hex_as(info->kernel_filename, entry,
+                                 info->ram_size - KERNEL_LOAD_ADDR, as);
+    }
+    if (kernel_size < 0) {
+        /* 32-bit ARM binary file */
         entry = info->loader_start + KERNEL_LOAD_ADDR;
-        kernel_size = load_image_targphys_as(info->kernel_filename, entry,
-                                             info->ram_size - KERNEL_LOAD_ADDR,
-                                             as);
+        kernel_size =
+            load_image_targphys_as(info->kernel_filename, entry,
+                                   info->ram_size - KERNEL_LOAD_ADDR, as);
         is_linux = 1;
     }
     if (kernel_size < 0) {
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 06bdbca53709..4e3cb141aca4 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1286,3 +1286,256 @@ void hmp_info_roms(Monitor *mon, const QDict *qdict)
         }
     }
 }
+
+typedef enum HexRecord HexRecord;
+enum HexRecord {
+    DATA_RECORD = 0,
+    EOF_RECORD,
+    EXT_SEG_ADDR_RECORD,
+    START_SEG_ADDR_RECORD,
+    EXT_LINEAR_ADDR_RECORD,
+    START_LINEAR_ADDR_RECORD,
+};
+
+#define DATA_FIELD_MAX_LEN 0xff
+#define LEN_EXCEPT_DATA 0x5
+/* 0x5 = sizeof(byte_count) + sizeof(address) + sizeof(record_type) +
+ *       sizeof(checksum) */
+typedef struct HexLine HexLine;
+struct HexLine {
+    uint8_t byte_count;
+    uint16_t address;
+    uint8_t record_type;
+    uint8_t data[DATA_FIELD_MAX_LEN];
+    uint8_t checksum;
+};
+
+/* return size or -1 if error */
+static size_t handle_record_type(const char *filename, HexLine *line,
+                                 uint8_t *bin_buf, const hwaddr addr,
+                                 size_t *total_size, uint8_t *ext_linear_record,
+                                 uint32_t *next_address_to_write,
+                                 uint32_t *current_address,
+                                 uint32_t *current_rom_index,
+                                 uint32_t *rom_start_address, AddressSpace *as)
+{
+    switch (line->record_type) {
+    case DATA_RECORD:
+        *current_address =
+            (*next_address_to_write & 0xffff0000) | line->address;
+        /* verify this is a contiguous block of memory */
+        if (*current_address != *next_address_to_write ||
+            *ext_linear_record == 1) {
+            if (*ext_linear_record != 1) {
+                return -1;
+            }
+            *ext_linear_record = 0;
+            *rom_start_address = *current_address;
+        }
+
+        /* copy from line buffer to output bin_buf */
+        memcpy(bin_buf + *current_rom_index, line->data, line->byte_count);
+        *current_rom_index += line->byte_count;
+        *total_size += line->byte_count;
+        /* Save next address to write */
+        *next_address_to_write = *current_address + line->byte_count;
+        break;
+
+    case EOF_RECORD:
+        if (*current_rom_index != 0) {
+            rom_add_blob(filename, bin_buf, *current_rom_index,
+                         *current_rom_index, addr + *rom_start_address, NULL,
+                         NULL, NULL, as, true);
+        }
+        return *total_size;
+    case EXT_SEG_ADDR_RECORD:
+    case EXT_LINEAR_ADDR_RECORD:
+        if (line->byte_count != 2) {
+            return -1;
+        }
+
+        if (*current_rom_index != 0) {
+            rom_add_blob(filename, bin_buf, *current_rom_index,
+                         *current_rom_index, addr + *rom_start_address, NULL,
+                         NULL, NULL, as, true);
+            memset(bin_buf, 0, *current_rom_index);
+            memset(line, 0, sizeof(HexLine));
+        }
+
+        *current_rom_index = 0;
+        *ext_linear_record = 1;
+
+        /* save next address to write,
+         * in case of non-contiguous block of memory */
+        *next_address_to_write =
+            line->record_type == EXT_SEG_ADDR_RECORD
+                ? ((line->data[0] << 12) | (line->data[1] << 4))
+                : ((line->data[0] << 24) | (line->data[1] << 16));
+        break;
+
+    case START_SEG_ADDR_RECORD:
+        /* nothing to do */
+        break;
+
+    case START_LINEAR_ADDR_RECORD:
+        /* nothing to do */
+        break;
+
+    default:
+        return -1;
+    }
+    return *total_size;
+}
+
+/* return 0 or -1 if error */
+static size_t parse_record(HexLine *line, uint8_t c, const uint32_t idx,
+                           uint8_t *our_checksum, const uint8_t in_process)
+{
+    /*+-------+---------------+-------+---------------------+--------+
+     *| byte  |               |record |                     |        |
+     *| count |    address    | type  |        data         |checksum|
+     *+-------+---------------+-------+---------------------+--------+
+     *^       ^               ^       ^                     ^        ^
+     *|1 byte |    2 bytes    |1 byte |     0-255 bytes     | 1 byte |
+     */
+    uint8_t value = 0;
+
+    /* ignore space */
+    if (g_ascii_isspace(c)) {
+        return 0;
+    }
+    if (!g_ascii_isxdigit(c) || in_process == 0) {
+        return -1;
+    }
+    value = g_ascii_xdigit_value(c);
+    value = idx & 0x1 ? value & 0xf : value << 4;
+    if (idx < 2) {
+        line->byte_count |= value;
+    } else if (2 <= idx && idx < 6) {
+        line->address <<= 4;
+        line->address += g_ascii_xdigit_value(c);
+    } else if (6 <= idx && idx < 8) {
+        line->record_type |= value;
+    } else if (8 <= idx && idx < 8 + 2 * line->byte_count) {
+        line->data[(idx - 8) >> 1] |= value;
+    } else if (8 + 2 * line->byte_count <= idx &&
+               idx < 10 + 2 * line->byte_count) {
+        line->checksum |= value;
+    } else {
+        return -1;
+    }
+    *our_checksum += value;
+    return 0;
+}
+
+/* return size or -1 if error */
+static size_t __parse_hex_blob(const char *filename, const hwaddr addr,
+                               uint8_t *hex_blob, off_t hex_blob_size,
+                               uint8_t *bin_buf, AddressSpace *as)
+{
+    uint8_t ext_linear_record = 1; /* record non-constitutes block */
+    uint8_t in_process = 0;        /* avoid re-enter and
+                                    * check whether record begin with ':' */
+    uint8_t *end = (uint8_t *)hex_blob + hex_blob_size;
+    uint8_t our_checksum = 0;
+    uint32_t record_index = 0;
+    uint32_t next_address_to_write = 0;
+    uint32_t current_address = 0;
+    uint32_t current_rom_index = 0;
+    uint32_t rom_start_address = 0;
+    size_t total_size = 0;
+    HexLine line = {0};
+
+    for (; hex_blob < end; ++hex_blob) {
+        switch (*hex_blob) {
+        case '\r':
+        case '\n':
+            if (!in_process) {
+                break;
+            }
+
+            in_process = 0;
+            /* uint8_t line.byte_count <= DATA_FIELD_MAX_LEN */
+            if ((record_index >> 1) - LEN_EXCEPT_DATA != line.byte_count ||
+                our_checksum != 0) {
+                return -1;
+            }
+
+            if (handle_record_type(filename, &line, bin_buf, addr, &total_size,
+                                   &ext_linear_record, &next_address_to_write,
+                                   &current_address, &current_rom_index,
+                                   &rom_start_address, as) == -1) {
+                return -1;
+            }
+            break;
+
+        /* start of a new record. */
+        case ':':
+            memset(&line, 0, sizeof(HexLine));
+            in_process = 1;
+            record_index = 0;
+            break;
+
+        /* decoding lines */
+        default:
+            if (parse_record(&line, *hex_blob, record_index, &our_checksum,
+                             in_process) != 0) {
+                return -1;
+            }
+            ++record_index;
+            break;
+        }
+    }
+    return total_size;
+}
+
+/* return size or -1 if error */
+static size_t parse_hex_blob(const char *filename, const hwaddr addr,
+                             AddressSpace *as)
+{
+    int fd;
+    off_t hex_blob_size;
+    uint8_t *hex_blob;
+    uint8_t *bin_buf;
+    size_t total_size = 0;
+
+    fd = open(filename, O_RDONLY);
+    if (fd < 0) {
+        return -1;
+    }
+    hex_blob_size = lseek(fd, 0, SEEK_END);
+    if (hex_blob_size < 0) {
+        close(fd);
+        return -1;
+    }
+    hex_blob = g_malloc(hex_blob_size);
+    bin_buf = g_malloc(hex_blob_size);
+    lseek(fd, 0, SEEK_SET);
+    if (read(fd, hex_blob, hex_blob_size) != hex_blob_size) {
+        total_size = -1;
+        goto hex_parser_exit;
+    }
+
+    total_size =
+        __parse_hex_blob(filename, addr, hex_blob, hex_blob_size, bin_buf, as);
+
+hex_parser_exit:
+    close(fd);
+    g_free(hex_blob);
+    g_free(bin_buf);
+    return total_size;
+}
+
+/* return size or -1 if error */
+int load_targphys_hex_as(const char *filename, hwaddr addr, uint64_t max_sz,
+                         AddressSpace *as)
+{
+    int size;
+
+    size = get_image_size(filename);
+    if (size < 0 || size > max_sz) {
+        return -1;
+    }
+
+    return parse_hex_blob(filename, addr, as);
+}
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 5ed3fd8ae67a..2b0cdfe56e70 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -28,6 +28,20 @@ ssize_t load_image_size(const char *filename, void *addr, size_t size);
 int load_image_targphys_as(const char *filename,
                            hwaddr addr, uint64_t max_sz, AddressSpace *as);
 
+/**load_image_targphys_hex_as:
+ * @filename: Path to the .hex file
+ * @addr: Address to load the .hex file to
+ * @max_sz: The maximum size of the .hex file to load
+ * @as: The AddressSpace to load the .hex file to. The value of
+ *      address_space_memory is used if nothing is supplied here.
+ *
+ * Load a fixed .hex file into memory.
+ *
+ * Returns the size of the loaded .hex file on success, -1 otherwise.
+ */
+int load_targphys_hex_as(const char *filename,
+                         hwaddr addr, uint64_t max_sz, AddressSpace *as);
+
 /** load_image_targphys:
  * Same as load_image_targphys_as(), but doesn't allow the caller to specify
  * an AddressSpace.
-- 
2.7.4
