Received: from eggs.gnu.org ([2001:4830:134:3::10]:52825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fBhJP-0000n8-1Z
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fBhJK-0007is-87
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:51:51 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:49990 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fBhJJ-0007gm-4q
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:51:46 -0400
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Thu, 26 Apr 2018 21:51:37 +0800
Message-Id: <1524750698-16322-2-git-send-email-suhang16@mails.ucas.ac.cn>
In-Reply-To: <1524750698-16322-1-git-send-email-suhang16@mails.ucas.ac.cn>
References: <1524750698-16322-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel]  [PATCH v6 1/2] Implement .hex file loader
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
and microcontrollers, such as Micro:bit Arduino, ARM, STM32, etc.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
---
 hw/arm/boot.c       |  17 ++--
 hw/core/loader.c    | 241 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/loader.h |  16 ++++
 3 files changed, 269 insertions(+), 5 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 26184bcd7c26..15fe5db37762 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1066,16 +1066,23 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
         kernel_size = load_uimage_as(info->kernel_filename, &entry, NULL,
                                      &is_linux, NULL, NULL, as);
     }
+    if (kernel_size < 0) {
+        entry = 0;
+        /* 32-bit ARM Intel HEX file */
+        kernel_size = load_targphys_hex_as(info->kernel_filename, &entry,
+                                           info->ram_size, as);
+    }
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
         kernel_size = load_aarch64_image(info->kernel_filename,
                                          info->loader_start, &entry, as);
         is_linux = 1;
-    } else if (kernel_size < 0) {
-        /* 32-bit ARM */
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
index 06bdbca53709..cb47276f2cb5 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1286,3 +1286,244 @@ void hmp_info_roms(Monitor *mon, const QDict *qdict)
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
+typedef struct {
+    uint8_t byte_count;
+    uint16_t address;
+    uint8_t record_type;
+    uint8_t data[DATA_FIELD_MAX_LEN];
+    uint8_t checksum;
+} HexLine;
+
+/* return 0 or -1 if error */
+static size_t parse_record(HexLine *line, uint8_t *our_checksum,
+                           const uint8_t c, const uint32_t idx,
+                           const bool in_process)
+{
+    /* +-------+---------------+-------+---------------------+--------+
+     * | byte  |               |record |                     |        |
+     * | count |    address    | type  |        data         |checksum|
+     * +-------+---------------+-------+---------------------+--------+
+     * ^       ^               ^       ^                     ^        ^
+     * |1 byte |    2 bytes    |1 byte |     0-255 bytes     | 1 byte |
+     */
+    uint8_t value = 0;
+
+    /* ignore space */
+    if (g_ascii_isspace(c)) {
+        return 0;
+    }
+    if (!g_ascii_isxdigit(c) || !in_process) {
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
+typedef struct {
+    const char *filename;
+    HexLine line;
+    uint8_t *bin_buf;
+    hwaddr *addr;
+    size_t total_size;
+    uint32_t next_address_to_write;
+    uint32_t current_address;
+    uint32_t current_rom_index;
+    uint32_t rom_start_address;
+    AddressSpace *as;
+} HexParser;
+
+/* return size or -1 if error */
+static size_t handle_record_type(HexParser *parser)
+{
+    HexLine *line = &(parser->line);
+    switch (line->record_type) {
+    case DATA_RECORD:
+        parser->current_address =
+            (parser->next_address_to_write & 0xffff0000) | line->address;
+        /* verify this is a contiguous block of memory */
+        if (parser->current_address != parser->next_address_to_write) {
+            if (parser->current_rom_index != 0) {
+                rom_add_hex_blob_as(parser->filename, parser->bin_buf,
+                                    parser->current_rom_index,
+                                    parser->rom_start_address, parser->as);
+            }
+            parser->rom_start_address = parser->current_address;
+            parser->current_rom_index = 0;
+        }
+
+        /* copy from line buffer to output bin_buf */
+        memcpy(parser->bin_buf + parser->current_rom_index, line->data,
+               line->byte_count);
+        parser->current_rom_index += line->byte_count;
+        parser->total_size += line->byte_count;
+        /* save next address to write */
+        parser->next_address_to_write =
+            parser->current_address + line->byte_count;
+        break;
+
+    case EOF_RECORD:
+        if (parser->current_rom_index != 0) {
+            rom_add_hex_blob_as(parser->filename, parser->bin_buf,
+                                parser->current_rom_index,
+                                parser->rom_start_address, parser->as);
+        }
+        return parser->total_size;
+    case EXT_SEG_ADDR_RECORD:
+    case EXT_LINEAR_ADDR_RECORD:
+        if (line->byte_count != 2 && line->address != 0) {
+            return -1;
+        }
+
+        if (parser->current_rom_index != 0) {
+            rom_add_hex_blob_as(parser->filename, parser->bin_buf,
+                                parser->current_rom_index,
+                                parser->rom_start_address, parser->as);
+        }
+
+        /* save next address to write,
+         * in case of non-contiguous block of memory */
+        parser->next_address_to_write =
+            line->record_type == EXT_SEG_ADDR_RECORD
+                ? ((line->data[0] << 12) | (line->data[1] << 4))
+                : ((line->data[0] << 24) | (line->data[1] << 16));
+        parser->rom_start_address = parser->next_address_to_write;
+        parser->current_rom_index = 0;
+        break;
+
+    case START_SEG_ADDR_RECORD:
+    case START_LINEAR_ADDR_RECORD:
+        *(parser->addr) = (line->data[0] << 24) | (line->data[1] << 16) |
+                          (line->data[2] << 8) | (line->data[3]);
+        break;
+
+    default:
+        return -1;
+    }
+
+    return parser->total_size;
+}
+
+/* return size or -1 if error */
+static size_t parse_hex_blob(const char *filename, hwaddr *addr,
+                             uint8_t *hex_blob, off_t hex_blob_size,
+                             uint8_t *bin_buf, AddressSpace *as)
+{
+    bool in_process = false; /* avoid re-enter and
+                              * check whether record begin with ':' */
+    uint8_t *end = hex_blob + hex_blob_size;
+    uint8_t our_checksum = 0;
+    uint32_t record_index = 0;
+    HexParser parser = {0};
+    parser.filename = filename;
+    parser.bin_buf = bin_buf;
+    parser.addr = addr;
+    parser.as = as;
+
+    for (; hex_blob < end; ++hex_blob) {
+        switch (*hex_blob) {
+        case '\r':
+        case '\n':
+            if (!in_process) {
+                break;
+            }
+
+            in_process = false;
+            if ((record_index >> 1) - LEN_EXCEPT_DATA !=
+                    parser.line.byte_count ||
+                our_checksum != 0) {
+                return -1;
+            }
+
+            if (handle_record_type(&parser) == -1) {
+                return -1;
+            }
+            break;
+
+        /* start of a new record. */
+        case ':':
+            memset(&parser.line, 0, sizeof(HexLine));
+            in_process = true;
+            record_index = 0;
+            break;
+
+        /* decoding lines */
+        default:
+            if (parse_record(&parser.line, &our_checksum, *hex_blob,
+                             record_index, in_process) != 0) {
+                return -1;
+            }
+            ++record_index;
+            break;
+        }
+    }
+    return parser.total_size;
+}
+
+/* return size or -1 if error */
+int load_targphys_hex_as(const char *filename, hwaddr *addr, uint64_t max_sz,
+                         AddressSpace *as)
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
+        parse_hex_blob(filename, addr, hex_blob, hex_blob_size, bin_buf, as);
+
+hex_parser_exit:
+    close(fd);
+    g_free(hex_blob);
+    g_free(bin_buf);
+    return total_size;
+}
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 5ed3fd8ae67a..728198a91ef9 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -28,6 +28,20 @@ ssize_t load_image_size(const char *filename, void *addr, size_t size);
 int load_image_targphys_as(const char *filename,
                            hwaddr addr, uint64_t max_sz, AddressSpace *as);
 
+/**load_image_targphys_hex_as:
+ * @filename: Path to the .hex file
+ * @addr: Store the entry point get from .hex file
+ * @max_sz: The maximum size of the .hex file to load
+ * @as: The AddressSpace to load the .hex file to. The value of
+ *      address_space_memory is used if nothing is supplied here.
+ *
+ * Load a fixed .hex file into memory.
+ *
+ * Returns the size of the loaded .hex file on success, -1 otherwise.
+ */
+int load_targphys_hex_as(const char *filename,
+                         hwaddr *addr, uint64_t max_sz, AddressSpace *as);
+
 /** load_image_targphys:
  * Same as load_image_targphys_as(), but doesn't allow the caller to specify
  * an AddressSpace.
@@ -241,6 +255,8 @@ void hmp_info_roms(Monitor *mon, const QDict *qdict);
     rom_add_file(_f, NULL, _a, _i, false, NULL, _as)
 #define rom_add_blob_fixed_as(_f, _b, _l, _a, _as)      \
     rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, _as, true)
+#define rom_add_hex_blob_as(_f, _b, _l, _a, _as)      \
+    rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, _as, true)
 
 #define PC_ROM_MIN_VGA     0xc0000
 #define PC_ROM_MIN_OPTION  0xc8000
-- 
2.7.4
