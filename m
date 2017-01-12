Received: from eggs.gnu.org ([2001:4830:134:3::10]:47968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRk3C-0000yP-05
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRk39-0002LV-EJ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:37 -0500
From: Laszlo Ersek <lersek@redhat.com>
Date: Thu, 12 Jan 2017 19:24:14 +0100
Message-Id: <20170112182417.9548-2-lersek@redhat.com>
In-Reply-To: <20170112182417.9548-1-lersek@redhat.com>
References: <20170112182417.9548-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v6 wave 1 1/4] fw-cfg: support writeable blobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Gabriel L. Somlo" <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Walle <michael@walle.cc>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org

From: "Michael S. Tsirkin" <mst@redhat.com>

Useful to send guest data back to QEMU.

Changes from Laszlo Ersek <lersek@redhat.com>:
- rebase the patch from Michael Tsirkin's original postings at [1] and [2]
  to the following patches:
  - loader: Allow a custom AddressSpace when loading ROMs
  - loader: Add AddressSpace loading support to uImages
  - loader: fix handling of custom address spaces when adding ROM blobs
- reject such writes immediately that would exceed the end of the array,
  rather than performing a partial write before setting the error bit: see
  the (len != dma.length) condition
- document the write interface

[1] http://lists.nongnu.org/archive/html/qemu-devel/2016-02/msg04968.html
[2] http://lists.nongnu.org/archive/html/qemu-devel/2016-03/msg02735.html

Cc: "Gabriel L. Somlo" <somlo@cmu.edu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Michael Walle <michael@walle.cc>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm@nongnu.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Acked-by: Gabriel Somlo <somlo@cmu.edu>
Tested-by: Gabriel Somlo <somlo@cmu.edu>
---

Notes:
    v6:
    - no changes, pick up Gabriel's A-b and T-b
    
    v5:
    - no changes, just picked up Marcel's R-b

 docs/specs/fw_cfg.txt     | 32 +++++++++++++++++++++++++-------
 hw/lm32/lm32_hwsetup.h    |  2 +-
 include/hw/loader.h       |  7 ++++---
 include/hw/nvram/fw_cfg.h |  3 ++-
 hw/arm/virt-acpi-build.c  |  2 +-
 hw/core/loader.c          | 18 +++++++++++-------
 hw/i386/acpi-build.c      |  4 ++--
 hw/nvram/fw_cfg.c         | 37 +++++++++++++++++++++++++++++--------
 8 files changed, 75 insertions(+), 30 deletions(-)

diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt
index 7a5f8c7824ce..a19e2adbe1c6 100644
--- a/docs/specs/fw_cfg.txt
+++ b/docs/specs/fw_cfg.txt
@@ -33,6 +33,10 @@ the selector value is between 0x4000-0x7fff or 0xc000-0xffff.
 NOTE: As of QEMU v2.4, writes to the fw_cfg data register are no
       longer supported, and will be ignored (treated as no-ops)!
 
+NOTE: As of QEMU v2.9, writes are reinstated, but only through the DMA
+      interface (see below). Furthermore, writeability of any specific item is
+      governed independently of Bit14 in the selector key value.
+
 Bit15 of the selector register indicates whether the configuration
 setting is architecture specific. A value of 0 means the item is a
 generic configuration item. A value of 1 means the item is specific
@@ -43,7 +47,7 @@ value between 0x8000-0xffff.
 
 == Data Register ==
 
-* Read/Write (writes ignored as of QEMU v2.4)
+* Read/Write (writes ignored as of QEMU v2.4, but see the DMA interface)
 * Location: platform dependent (IOport [*] or MMIO)
 * Width: 8-bit (if IOport), 8/16/32/64-bit (if MMIO)
 * Endianness: string-preserving
@@ -134,8 +138,8 @@ struct FWCfgFile {		/* an individual file entry, 64 bytes total */
 
 === All Other Data Items ===
 
-Please consult the QEMU source for the most up-to-date and authoritative
-list of selector keys and their respective items' purpose and format.
+Please consult the QEMU source for the most up-to-date and authoritative list
+of selector keys and their respective items' purpose, format and writeability.
 
 === Ranges ===
 
@@ -144,9 +148,11 @@ items, and up to 0x4000 architecturally specific ones.
 
 Selector Reg.    Range Usage
 ---------------  -----------
-0x0000 - 0x3fff  Generic (0x0000 - 0x3fff, RO)
+0x0000 - 0x3fff  Generic (0x0000 - 0x3fff, generally RO, possibly RW through
+                          the DMA interface in QEMU v2.9+)
 0x4000 - 0x7fff  Generic (0x0000 - 0x3fff, RW, ignored in QEMU v2.4+)
-0x8000 - 0xbfff  Arch. Specific (0x0000 - 0x3fff, RO)
+0x8000 - 0xbfff  Arch. Specific (0x0000 - 0x3fff, generally RO, possibly RW
+                                 through the DMA interface in QEMU v2.9+)
 0xc000 - 0xffff  Arch. Specific (0x0000 - 0x3fff, RW, ignored in v2.4+)
 
 In practice, the number of allowed firmware configuration items is given
@@ -182,6 +188,7 @@ The "control" field has the following bits:
  - Bit 1: Read
  - Bit 2: Skip
  - Bit 3: Select. The upper 16 bits are the selected index.
+ - Bit 4: Write
 
 When an operation is triggered, if the "control" field has bit 3 set, the
 upper 16 bits are interpreted as an index of a firmware configuration item.
@@ -191,8 +198,17 @@ If the "control" field has bit 1 set, a read operation will be performed.
 "length" bytes for the current selector and offset will be copied into the
 physical RAM address specified by the "address" field.
 
-If the "control" field has bit 2 set (and not bit 1), a skip operation will be
-performed. The offset for the current selector will be advanced "length" bytes.
+If the "control" field has bit 4 set (and not bit 1), a write operation will be
+performed. "length" bytes will be copied from the physical RAM address
+specified by the "address" field to the current selector and offset. QEMU
+prevents starting or finishing the write beyond the end of the item associated
+with the current selector (i.e., the item cannot be resized). Truncated writes
+are dropped entirely. Writes to read-only items are also rejected. All of these
+write errors set bit 0 (the error bit) in the "control" field.
+
+If the "control" field has bit 2 set (and neither bit 1 nor bit 4), a skip
+operation will be performed. The offset for the current selector will be
+advanced "length" bytes.
 
 To check the result, read the "control" field:
    error bit set        ->  something went wrong.
@@ -234,3 +250,5 @@ Prefix "opt/org.qemu/" is reserved for QEMU itself.
 
 Use of names not beginning with "opt/" is potentially dangerous and
 entirely unsupported.  QEMU will warn if you try.
+
+All externally provided fw_cfg items are read-only to the guest.
diff --git a/hw/lm32/lm32_hwsetup.h b/hw/lm32/lm32_hwsetup.h
index 23e18784dffd..a01f6bc5dfeb 100644
--- a/hw/lm32/lm32_hwsetup.h
+++ b/hw/lm32/lm32_hwsetup.h
@@ -75,7 +75,7 @@ static inline void hwsetup_create_rom(HWSetup *hw,
         hwaddr base)
 {
     rom_add_blob("hwsetup", hw->data, TARGET_PAGE_SIZE,
-                 TARGET_PAGE_SIZE, base, NULL, NULL, NULL, NULL);
+                 TARGET_PAGE_SIZE, base, NULL, NULL, NULL, NULL, true);
 }
 
 static inline void hwsetup_add_u8(HWSetup *hw, uint8_t u)
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 0c864cfd6046..0dbd8d6bf37a 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -180,7 +180,8 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
                            size_t max_len, hwaddr addr,
                            const char *fw_file_name,
                            FWCfgReadCallback fw_callback,
-                           void *callback_opaque, AddressSpace *as);
+                           void *callback_opaque, AddressSpace *as,
+                           bool read_only);
 int rom_add_elf_program(const char *name, void *data, size_t datasize,
                         size_t romsize, hwaddr addr, AddressSpace *as);
 int rom_check_and_register_reset(void);
@@ -194,7 +195,7 @@ void hmp_info_roms(Monitor *mon, const QDict *qdict);
 #define rom_add_file_fixed(_f, _a, _i)          \
     rom_add_file(_f, NULL, _a, _i, false, NULL, NULL)
 #define rom_add_blob_fixed(_f, _b, _l, _a)      \
-    rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, NULL)
+    rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, NULL, true)
 #define rom_add_file_mr(_f, _mr, _i)            \
     rom_add_file(_f, NULL, 0, _i, false, _mr, NULL)
 #define rom_add_file_as(_f, _as, _i)            \
@@ -202,7 +203,7 @@ void hmp_info_roms(Monitor *mon, const QDict *qdict);
 #define rom_add_file_fixed_as(_f, _a, _i, _as)          \
     rom_add_file(_f, NULL, _a, _i, false, NULL, _as)
 #define rom_add_blob_fixed_as(_f, _b, _l, _a, _as)      \
-    rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, _as)
+    rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, _as, true)
 
 #define PC_ROM_MIN_VGA     0xc0000
 #define PC_ROM_MIN_OPTION  0xc8000
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 5c27a1f0d50b..b980cbaebf43 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -136,6 +136,7 @@ void fw_cfg_add_file(FWCfgState *s, const char *filename, void *data,
  * @callback_opaque: argument to be passed into callback function
  * @data: pointer to start of item data
  * @len: size of item data
+ * @read_only: is file read only
  *
  * Add a new NAMED fw_cfg item as a raw "blob" of the given size. The data
  * referenced by the starting pointer is only linked, NOT copied, into the
@@ -151,7 +152,7 @@ void fw_cfg_add_file(FWCfgState *s, const char *filename, void *data,
  */
 void fw_cfg_add_file_callback(FWCfgState *s, const char *filename,
                               FWCfgReadCallback callback, void *callback_opaque,
-                              void *data, size_t len);
+                              void *data, size_t len, bool read_only);
 
 /**
  * fw_cfg_modify_file:
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 085a61117378..205d6268e217 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -818,7 +818,7 @@ static MemoryRegion *acpi_add_rom_blob(AcpiBuildState *build_state,
                                        uint64_t max_size)
 {
     return rom_add_blob(name, blob->data, acpi_data_len(blob), max_size, -1,
-                        name, virt_acpi_build_update, build_state, NULL);
+                        name, virt_acpi_build_update, build_state, NULL, true);
 }
 
 static const VMStateDescription vmstate_virt_acpi_build = {
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 45742494e6fd..ee5abd6eb7f4 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -853,7 +853,7 @@ static void fw_cfg_resized(const char *id, uint64_t length, void *host)
     }
 }
 
-static void *rom_set_mr(Rom *rom, Object *owner, const char *name)
+static void *rom_set_mr(Rom *rom, Object *owner, const char *name, bool ro)
 {
     void *data;
 
@@ -862,7 +862,7 @@ static void *rom_set_mr(Rom *rom, Object *owner, const char *name)
                                       rom->datasize, rom->romsize,
                                       fw_cfg_resized,
                                       &error_fatal);
-    memory_region_set_readonly(rom->mr, true);
+    memory_region_set_readonly(rom->mr, ro);
     vmstate_register_ram_global(rom->mr);
 
     data = memory_region_get_ram_ptr(rom->mr);
@@ -942,7 +942,7 @@ int rom_add_file(const char *file, const char *fw_dir,
         snprintf(devpath, sizeof(devpath), "/rom@%s", fw_file_name);
 
         if ((!option_rom || mc->option_rom_has_mr) && mc->rom_file_has_mr) {
-            data = rom_set_mr(rom, OBJECT(fw_cfg), devpath);
+            data = rom_set_mr(rom, OBJECT(fw_cfg), devpath, true);
         } else {
             data = rom->data;
         }
@@ -979,7 +979,7 @@ err:
 MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
                    size_t max_len, hwaddr addr, const char *fw_file_name,
                    FWCfgReadCallback fw_callback, void *callback_opaque,
-                   AddressSpace *as)
+                   AddressSpace *as, bool read_only)
 {
     MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     Rom *rom;
@@ -998,10 +998,14 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
         char devpath[100];
         void *data;
 
-        snprintf(devpath, sizeof(devpath), "/rom@%s", fw_file_name);
+        if (read_only) {
+            snprintf(devpath, sizeof(devpath), "/rom@%s", fw_file_name);
+        } else {
+            snprintf(devpath, sizeof(devpath), "/ram@%s", fw_file_name);
+        }
 
         if (mc->rom_file_has_mr) {
-            data = rom_set_mr(rom, OBJECT(fw_cfg), devpath);
+            data = rom_set_mr(rom, OBJECT(fw_cfg), devpath, read_only);
             mr = rom->mr;
         } else {
             data = rom->data;
@@ -1009,7 +1013,7 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
 
         fw_cfg_add_file_callback(fw_cfg, fw_file_name,
                                  fw_callback, callback_opaque,
-                                 data, rom->datasize);
+                                 data, rom->datasize, read_only);
     }
     return mr;
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 0c8912fd861b..a1d781ae42d8 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2806,7 +2806,7 @@ static MemoryRegion *acpi_add_rom_blob(AcpiBuildState *build_state,
                                        uint64_t max_size)
 {
     return rom_add_blob(name, blob->data, acpi_data_len(blob), max_size, -1,
-                        name, acpi_build_update, build_state, NULL);
+                        name, acpi_build_update, build_state, NULL, true);
 }
 
 static const VMStateDescription vmstate_acpi_build = {
@@ -2872,7 +2872,7 @@ void acpi_setup(void)
         build_state->rsdp = g_memdup(tables.rsdp->data, rsdp_size);
         fw_cfg_add_file_callback(pcms->fw_cfg, ACPI_BUILD_RSDP_FILE,
                                  acpi_build_update, build_state,
-                                 build_state->rsdp, rsdp_size);
+                                 build_state->rsdp, rsdp_size, true);
         build_state->rsdp_mr = NULL;
     } else {
         build_state->rsdp = NULL;
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 3ebecb22606a..e0145c11a19b 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -54,11 +54,13 @@
 #define FW_CFG_DMA_CTL_READ    0x02
 #define FW_CFG_DMA_CTL_SKIP    0x04
 #define FW_CFG_DMA_CTL_SELECT  0x08
+#define FW_CFG_DMA_CTL_WRITE   0x10
 
 #define FW_CFG_DMA_SIGNATURE 0x51454d5520434647ULL /* "QEMU CFG" */
 
 typedef struct FWCfgEntry {
     uint32_t len;
+    bool allow_write;
     uint8_t *data;
     void *callback_opaque;
     FWCfgReadCallback read_callback;
@@ -326,7 +328,7 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
     FWCfgDmaAccess dma;
     int arch;
     FWCfgEntry *e;
-    int read;
+    int read = 0, write = 0;
     dma_addr_t dma_addr;
 
     /* Reset the address before the next access */
@@ -353,8 +355,13 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
 
     if (dma.control & FW_CFG_DMA_CTL_READ) {
         read = 1;
+        write = 0;
+    } else if (dma.control & FW_CFG_DMA_CTL_WRITE) {
+        read = 0;
+        write = 1;
     } else if (dma.control & FW_CFG_DMA_CTL_SKIP) {
         read = 0;
+        write = 0;
     } else {
         dma.length = 0;
     }
@@ -374,7 +381,9 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
                     dma.control |= FW_CFG_DMA_CTL_ERROR;
                 }
             }
-
+            if (write) {
+                dma.control |= FW_CFG_DMA_CTL_ERROR;
+            }
         } else {
             if (dma.length <= (e->len - s->cur_offset)) {
                 len = dma.length;
@@ -391,6 +400,14 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
                     dma.control |= FW_CFG_DMA_CTL_ERROR;
                 }
             }
+            if (write) {
+                if (!e->allow_write ||
+                    len != dma.length ||
+                    dma_memory_read(s->dma_as, dma.address,
+                                    &e->data[s->cur_offset], len)) {
+                    dma.control |= FW_CFG_DMA_CTL_ERROR;
+                }
+            }
 
             s->cur_offset += len;
         }
@@ -586,7 +603,8 @@ static const VMStateDescription vmstate_fw_cfg = {
 static void fw_cfg_add_bytes_read_callback(FWCfgState *s, uint16_t key,
                                            FWCfgReadCallback callback,
                                            void *callback_opaque,
-                                           void *data, size_t len)
+                                           void *data, size_t len,
+                                           bool read_only)
 {
     int arch = !!(key & FW_CFG_ARCH_LOCAL);
 
@@ -599,6 +617,7 @@ static void fw_cfg_add_bytes_read_callback(FWCfgState *s, uint16_t key,
     s->entries[arch][key].len = (uint32_t)len;
     s->entries[arch][key].read_callback = callback;
     s->entries[arch][key].callback_opaque = callback_opaque;
+    s->entries[arch][key].allow_write = !read_only;
 }
 
 static void *fw_cfg_modify_bytes_read(FWCfgState *s, uint16_t key,
@@ -616,13 +635,14 @@ static void *fw_cfg_modify_bytes_read(FWCfgState *s, uint16_t key,
     s->entries[arch][key].data = data;
     s->entries[arch][key].len = len;
     s->entries[arch][key].callback_opaque = NULL;
+    s->entries[arch][key].allow_write = false;
 
     return ptr;
 }
 
 void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t len)
 {
-    fw_cfg_add_bytes_read_callback(s, key, NULL, NULL, data, len);
+    fw_cfg_add_bytes_read_callback(s, key, NULL, NULL, data, len, true);
 }
 
 void fw_cfg_add_string(FWCfgState *s, uint16_t key, const char *value)
@@ -749,7 +769,7 @@ static int get_fw_cfg_order(FWCfgState *s, const char *name)
 
 void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
                               FWCfgReadCallback callback, void *callback_opaque,
-                              void *data, size_t len)
+                              void *data, size_t len, bool read_only)
 {
     int i, index, count;
     size_t dsize;
@@ -811,7 +831,8 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
     }
 
     fw_cfg_add_bytes_read_callback(s, FW_CFG_FILE_FIRST + index,
-                                   callback, callback_opaque, data, len);
+                                   callback, callback_opaque, data, len,
+                                   read_only);
 
     s->files->f[index].size   = cpu_to_be32(len);
     s->files->f[index].select = cpu_to_be16(FW_CFG_FILE_FIRST + index);
@@ -824,7 +845,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
 void fw_cfg_add_file(FWCfgState *s,  const char *filename,
                      void *data, size_t len)
 {
-    fw_cfg_add_file_callback(s, filename, NULL, NULL, data, len);
+    fw_cfg_add_file_callback(s, filename, NULL, NULL, data, len, true);
 }
 
 void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
@@ -847,7 +868,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
         }
     }
     /* add new one */
-    fw_cfg_add_file_callback(s, filename, NULL, NULL, data, len);
+    fw_cfg_add_file_callback(s, filename, NULL, NULL, data, len, true);
     return NULL;
 }
 
-- 
2.9.3
