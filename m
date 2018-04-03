Received: from eggs.gnu.org ([2001:4830:134:3::10]:36214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3NtJ-00043q-Rd
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3NtG-0002an-TJ
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:30:33 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:39007 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3NtF-0002Yl-VF
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:30:30 -0400
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Tue,  3 Apr 2018 23:30:25 +0800
Message-Id: <1522769426-6056-2-git-send-email-suhang16@mails.ucas.ac.cn>
In-Reply-To: <1522769426-6056-1-git-send-email-suhang16@mails.ucas.ac.cn>
References: <1522769426-6056-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel]  [PATCH 1/2] Implement .hex file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, qemu-devel@nongnu.org

This patch adds Intel Hexadecimal Object File format support to
the loader.  The file format specification is available here:
http://www.piclist.com/techref/fileext/hex/intel.htm

The file format is mainly intended for embedded systems
and microcontrollers, such as Arduino, ARM, STM32, etc.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
---
 hw/arm/boot.c       |   9 +-
 hw/core/loader.c    | 280 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/loader.h |  17 ++++
 3 files changed, 305 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 9319b12fcd2a..07ce54e5936d 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1060,8 +1060,15 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
         kernel_size = load_aarch64_image(info->kernel_filename,
                                          info->loader_start, &entry, as);
         is_linux = 1;
+    } else if (kernel_size < 0 && strstr(info->kernel_filename, ".hex")) {
+        /* 32-bit ARM .hex file */
+        entry = info->loader_start + KERNEL_LOAD_ADDR;
+        kernel_size = load_targphys_hex_as(info->kernel_filename, entry,
+                                           info->ram_size - KERNEL_LOAD_ADDR,
+                                           as);
+        is_linux = 1;
     } else if (kernel_size < 0) {
-        /* 32-bit ARM */
+        /* 32-bit ARM binary file */
         entry = info->loader_start + KERNEL_LOAD_ADDR;
         kernel_size = load_image_targphys_as(info->kernel_filename, entry,
                                              info->ram_size - KERNEL_LOAD_ADDR,
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 06bdbca53709..126832c4243c 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1286,3 +1286,283 @@ void hmp_info_roms(Monitor *mon, const QDict *qdict)
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
+typedef union HexLine HexLine;
+union HexLine {
+    uint8_t buf[0x25];
+    struct __attribute__((packed)) {
+        uint8_t byte_count;
+        uint16_t address;
+        uint8_t record_type;
+        uint8_t data[0x25 - 0x5];
+        uint8_t checksum;
+    };
+};
+
+static uint8_t ctoh(char c)
+{
+    return (c & 0x10) ? /*0-9*/ c & 0xf : /*A-F, a-f*/ (c & 0xf) + 9;
+}
+
+static uint8_t validate_checksum(HexLine *record)
+{
+    uint8_t result = 0, i = 0;
+
+    for (; i < (record->byte_count + 5); ++i) {
+        result += record->buf[i];
+    }
+
+    return result == 0;
+}
+
+/* return pointer of bin_blob or NULL if error */
+static uint8_t *parse_hex_blob(char *filename, size_t *p_size)
+{
+    int fd;
+    off_t hex_blob_size;
+    uint8_t *p_data = NULL;
+    uint8_t *hex_blob;
+    uint8_t *hex_blob_ori;         /* used to free temporary memory */
+    uint8_t *bin_buf;
+    uint8_t *end;
+    uint8_t idx = 0;
+    uint8_t in_process = 0;        /* avoid re-enter */
+    uint8_t low_nibble = 0;        /* process two hex char into 8-bits */
+    uint8_t ext_linear_record = 0; /* record non-constitutes block */
+    uint32_t next_address_to_write = 0;
+    uint32_t current_address = 0;
+    uint32_t last_address = 0;
+    HexLine line = {0};
+
+    fd = open(filename, O_RDONLY);
+    if (fd < 0) {
+        return NULL;
+    }
+    hex_blob_size = lseek(fd, 0, SEEK_END);
+    if (hex_blob_size < 0) {
+        close(fd);
+        return NULL;
+    }
+    hex_blob = g_malloc(hex_blob_size);
+    hex_blob_ori = hex_blob;
+    bin_buf = g_malloc(hex_blob_size * 2);
+    lseek(fd, 0, SEEK_SET);
+    if (read(fd, hex_blob, hex_blob_size) != hex_blob_size) {
+        close(fd);
+        goto hex_parser_exit;
+    }
+    close(fd);
+
+    memset(line.buf, 0, sizeof(HexLine));
+    end = (uint8_t *)hex_blob + hex_blob_size;
+
+    do {
+        switch ((uint8_t)(*hex_blob)) {
+        case '\r':
+        case '\n':
+            if (!in_process) {
+                break;
+            }
+
+            in_process = 0;
+            if (validate_checksum(&line) == 0) {
+                p_data = NULL;
+                goto hex_parser_exit;
+            }
+
+            line.address = bswap16(line.address);
+            switch (line.record_type) {
+            case DATA_RECORD:
+                current_address =
+                    (next_address_to_write & 0xffff0000) | line.address;
+                /* verify this is a continous block of memory */
+                if (current_address != next_address_to_write ||
+                    ext_linear_record) {
+                    if (!ext_linear_record) {
+                        /* Store next address to write */
+                        last_address = next_address_to_write;
+                        next_address_to_write = current_address;
+                    }
+                    ext_linear_record = 0;
+                    memset(bin_buf + last_address, 0x0,
+                           current_address - last_address);
+                }
+
+                /* copy from line buffer to output bin_buf */
+                memcpy((uint8_t *)bin_buf + current_address,
+                       (uint8_t *)line.data, line.byte_count);
+                /* Save next address to write */
+                last_address = current_address;
+                next_address_to_write = current_address + line.byte_count;
+                break;
+
+            case EOF_RECORD:
+                /* nothing to do */
+                break;
+            case EXT_SEG_ADDR_RECORD:
+                /* save next address to write,
+                 * in case of non-continous block of memory */
+                ext_linear_record = 1;
+                last_address = next_address_to_write;
+                next_address_to_write =
+                    ((line.data[0] << 12) | (line.data[1] << 4));
+                break;
+            case START_SEG_ADDR_RECORD:
+                /* TODO */
+                break;
+
+            case EXT_LINEAR_ADDR_RECORD:
+                /* save next address to write,
+                 * in case of non-continous block of memory */
+                ext_linear_record = 1;
+                last_address = next_address_to_write;
+                next_address_to_write =
+                    ((line.data[0] << 24) | (line.data[1] << 16));
+                break;
+            case START_LINEAR_ADDR_RECORD:
+                /* TODO */
+                break;
+
+            default:
+                p_data = NULL;
+                goto hex_parser_exit;
+            }
+            break;
+
+        /* start of a new record. */
+        case ':':
+            memset(line.buf, 0, sizeof(HexLine));
+            in_process = 1;
+            low_nibble = 0;
+            idx = 0;
+            break;
+
+        /* decoding lines */
+        default:
+            if (low_nibble) {
+                line.buf[idx] |= ctoh((uint8_t)(*hex_blob)) & 0xf;
+                ++idx;
+            } else {
+                line.buf[idx] = ctoh((uint8_t)(*hex_blob)) << 4;
+            }
+
+            low_nibble = !low_nibble;
+            break;
+        }
+
+    } while (++hex_blob != end);
+
+    *p_size = (size_t)next_address_to_write;
+    p_data = g_malloc(next_address_to_write);
+
+    memcpy(p_data, bin_buf, next_address_to_write);
+hex_parser_exit:
+    g_free(hex_blob_ori);
+    g_free(bin_buf);
+    return p_data;
+}
+
+/* return size or -1 if error */
+int load_targphys_hex_as(const char *filename, hwaddr addr, uint64_t max_sz,
+                         AddressSpace *as)
+{
+    return rom_add_hex_file(filename, NULL, addr, -1, false, NULL, as);
+}
+
+/* return size -1 if error */
+int rom_add_hex_file(const char *file, const char *fw_dir, hwaddr addr,
+                     int32_t bootindex, bool option_rom, MemoryRegion *mr,
+                     AddressSpace *as)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+    Rom *rom;
+    char devpath[100];
+    size_t datasize = 0;
+
+    if (as && mr) {
+        fprintf(stderr, "Specifying an Address Space and Memory Region is "
+                        "not valid when loading a rom\n");
+        /* We haven't allocated anything so we don't need any cleanup */
+        return -1;
+    }
+
+    rom = g_malloc0(sizeof(*rom));
+    rom->name = g_strdup(file);
+    rom->path = qemu_find_file(QEMU_FILE_TYPE_BIOS, rom->name);
+    rom->as = as;
+    if (rom->path == NULL) {
+        rom->path = g_strdup(file);
+    }
+
+    rom->data = parse_hex_blob(rom->path, &datasize);
+    if (rom->data == NULL) {
+        fprintf(stderr, "failed to parse hex file '%s': %s\n", rom->path,
+                strerror(errno));
+        goto err;
+    }
+    rom->datasize = datasize;
+
+    if (fw_dir) {
+        rom->fw_dir = g_strdup(fw_dir);
+        rom->fw_file = g_strdup(file);
+    }
+    rom->addr = addr;
+    rom->romsize = rom->datasize;
+
+    rom_insert(rom);
+
+    if (rom->fw_file && fw_cfg) {
+        const char *basename;
+        char fw_file_name[FW_CFG_MAX_FILE_PATH];
+        void *data;
+
+        basename = strrchr(rom->fw_file, '/');
+        if (basename) {
+            ++basename;
+        } else {
+            basename = rom->fw_file;
+        }
+        snprintf(fw_file_name, sizeof(fw_file_name), "%s/%s", rom->fw_dir,
+                 basename);
+        snprintf(devpath, sizeof(devpath), "/rom@%s", fw_file_name);
+
+        if ((!option_rom || mc->option_rom_has_mr) && mc->rom_file_has_mr) {
+            data = rom_set_mr(rom, OBJECT(fw_cfg), devpath, true);
+        } else {
+            data = rom->data;
+        }
+
+        fw_cfg_add_file(fw_cfg, fw_file_name, data, rom->romsize);
+    } else {
+        if (mr) {
+            rom->mr = mr;
+            snprintf(devpath, sizeof(devpath), "/rom@%s", file);
+        } else {
+            snprintf(devpath, sizeof(devpath), "/rom@" TARGET_FMT_plx, addr);
+        }
+    }
+
+    add_boot_device_path(bootindex, NULL, devpath);
+    return rom->datasize;
+
+err:
+    g_free(rom->path);
+    g_free(rom->name);
+    if (fw_dir) {
+        g_free(rom->fw_dir);
+        g_free(rom->fw_file);
+    }
+    g_free(rom);
+
+    return -1;
+}
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 5ed3fd8ae67a..176b11221a27 100644
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
@@ -210,6 +224,9 @@ void pstrcpy_targphys(const char *name,
 extern bool option_rom_has_mr;
 extern bool rom_file_has_mr;
 
+int rom_add_hex_file(const char *file, const char *fw_dir,
+                 hwaddr addr, int32_t bootindex,
+                 bool option_rom, MemoryRegion *mr, AddressSpace *as);
 int rom_add_file(const char *file, const char *fw_dir,
                  hwaddr addr, int32_t bootindex,
                  bool option_rom, MemoryRegion *mr, AddressSpace *as);
-- 
2.7.4
