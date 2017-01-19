Received: from eggs.gnu.org ([2001:4830:134:3::10]:36681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxd-0000PV-GG
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxa-00081U-7f
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:33 -0500
Received: from mail.kernel.org ([198.145.29.136]:56700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxZ-000801-Ta
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:30 -0500
Date: Thu, 19 Jan 2017 23:09:22 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484860116-25361-7-git-send-email-mst@redhat.com>
References: <1484860116-25361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484860116-25361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 06/17] fw-cfg: turn FW_CFG_FILE_SLOTS into a
 device property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, "Gabriel L. Somlo" <somlo@cmu.edu>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>

From: Laszlo Ersek <lersek@redhat.com>

We'd like to raise the value of FW_CFG_FILE_SLOTS. Doing it naively could
lead to problems with backward migration: a more recent QEMU (running an
older machine type) would allow the guest, in fw_cfg_select(), to select a
high key value that is unavailable in the same machine type implemented by
the older (target) QEMU. On the target host, fw_cfg_data_read() for
example could dereference nonexistent entries.

As first step, size the FWCfgState.entries[*] and FWCfgState.entry_order
arrays dynamically. All three array sizes will be influenced by the new
field FWCfgState.file_slots (and matching device property).

Make the following changes:

- Replace the FW_CFG_FILE_SLOTS macro with FW_CFG_FILE_SLOTS_MIN (minimum
  count of fw_cfg file slots) in the header file. The value remains 0x10.

- Replace all uses of FW_CFG_FILE_SLOTS with a helper function called
  fw_cfg_file_slots(), returning the new property.

- Eliminate the macro FW_CFG_MAX_ENTRY, and replace all its uses with a
  helper function called fw_cfg_max_entry().

- In the MMIO- and IO-mapped realize functions both, allocate all three
  arrays dynamically, based on the new property.

- The new property defaults to FW_CFG_FILE_SLOTS_MIN. This is going to be
  customized in the following patches.

Cc: "Gabriel L. Somlo" <somlo@cmu.edu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Acked-by: Gabriel Somlo <somlo@cmu.edu>
Tested-by: Gabriel Somlo <somlo@cmu.edu>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/specs/fw_cfg.txt          |  2 +-
 include/hw/nvram/fw_cfg_keys.h |  3 +-
 hw/nvram/fw_cfg.c              | 71 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt
index a19e2ad..9373bbc 100644
--- a/docs/specs/fw_cfg.txt
+++ b/docs/specs/fw_cfg.txt
@@ -156,7 +156,7 @@ Selector Reg.    Range Usage
 0xc000 - 0xffff  Arch. Specific (0x0000 - 0x3fff, RW, ignored in v2.4+)
 
 In practice, the number of allowed firmware configuration items is given
-by the value of FW_CFG_MAX_ENTRY (see fw_cfg.h).
+by the value (FW_CFG_FILE_FIRST + FW_CFG_FILE_SLOTS_MIN) (see fw_cfg.h).
 
 = Guest-side DMA Interface =
 
diff --git a/include/hw/nvram/fw_cfg_keys.h b/include/hw/nvram/fw_cfg_keys.h
index 0f3e871..b691945 100644
--- a/include/hw/nvram/fw_cfg_keys.h
+++ b/include/hw/nvram/fw_cfg_keys.h
@@ -29,8 +29,7 @@
 #define FW_CFG_FILE_DIR         0x19
 
 #define FW_CFG_FILE_FIRST       0x20
-#define FW_CFG_FILE_SLOTS       0x10
-#define FW_CFG_MAX_ENTRY        (FW_CFG_FILE_FIRST + FW_CFG_FILE_SLOTS)
+#define FW_CFG_FILE_SLOTS_MIN   0x10
 
 #define FW_CFG_WRITE_CHANNEL    0x4000
 #define FW_CFG_ARCH_LOCAL       0x8000
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index e0145c1..bf75ef7 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -33,6 +33,7 @@
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
+#include "qapi/error.h"
 
 #define FW_CFG_NAME "fw_cfg"
 #define FW_CFG_PATH "/machine/" FW_CFG_NAME
@@ -71,8 +72,9 @@ struct FWCfgState {
     SysBusDevice parent_obj;
     /*< public >*/
 
-    FWCfgEntry entries[2][FW_CFG_MAX_ENTRY];
-    int entry_order[FW_CFG_MAX_ENTRY];
+    uint16_t file_slots;
+    FWCfgEntry *entries[2];
+    int *entry_order;
     FWCfgFiles *files;
     uint16_t cur_entry;
     uint32_t cur_offset;
@@ -257,13 +259,24 @@ static void fw_cfg_write(FWCfgState *s, uint8_t value)
     /* nothing, write support removed in QEMU v2.4+ */
 }
 
+static inline uint16_t fw_cfg_file_slots(const FWCfgState *s)
+{
+    return s->file_slots;
+}
+
+/* Note: this function returns an exclusive limit. */
+static inline uint32_t fw_cfg_max_entry(const FWCfgState *s)
+{
+    return FW_CFG_FILE_FIRST + fw_cfg_file_slots(s);
+}
+
 static int fw_cfg_select(FWCfgState *s, uint16_t key)
 {
     int arch, ret;
     FWCfgEntry *e;
 
     s->cur_offset = 0;
-    if ((key & FW_CFG_ENTRY_MASK) >= FW_CFG_MAX_ENTRY) {
+    if ((key & FW_CFG_ENTRY_MASK) >= fw_cfg_max_entry(s)) {
         s->cur_entry = FW_CFG_INVALID;
         ret = 0;
     } else {
@@ -610,7 +623,7 @@ static void fw_cfg_add_bytes_read_callback(FWCfgState *s, uint16_t key,
 
     key &= FW_CFG_ENTRY_MASK;
 
-    assert(key < FW_CFG_MAX_ENTRY && len < UINT32_MAX);
+    assert(key < fw_cfg_max_entry(s) && len < UINT32_MAX);
     assert(s->entries[arch][key].data == NULL); /* avoid key conflict */
 
     s->entries[arch][key].data = data;
@@ -628,7 +641,7 @@ static void *fw_cfg_modify_bytes_read(FWCfgState *s, uint16_t key,
 
     key &= FW_CFG_ENTRY_MASK;
 
-    assert(key < FW_CFG_MAX_ENTRY && len < UINT32_MAX);
+    assert(key < fw_cfg_max_entry(s) && len < UINT32_MAX);
 
     /* return the old data to the function caller, avoid memory leak */
     ptr = s->entries[arch][key].data;
@@ -777,13 +790,13 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
     int order = 0;
 
     if (!s->files) {
-        dsize = sizeof(uint32_t) + sizeof(FWCfgFile) * FW_CFG_FILE_SLOTS;
+        dsize = sizeof(uint32_t) + sizeof(FWCfgFile) * fw_cfg_file_slots(s);
         s->files = g_malloc0(dsize);
         fw_cfg_add_bytes(s, FW_CFG_FILE_DIR, s->files, dsize);
     }
 
     count = be32_to_cpu(s->files->count);
-    assert(count < FW_CFG_FILE_SLOTS);
+    assert(count < fw_cfg_file_slots(s));
 
     /* Find the insertion point. */
     if (mc->legacy_fw_cfg_order) {
@@ -857,7 +870,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
     assert(s->files);
 
     index = be32_to_cpu(s->files->count);
-    assert(index < FW_CFG_FILE_SLOTS);
+    assert(index < fw_cfg_file_slots(s));
 
     for (i = 0; i < index; i++) {
         if (strcmp(filename, s->files->f[i].name) == 0) {
@@ -1014,12 +1027,38 @@ static const TypeInfo fw_cfg_info = {
     .class_init    = fw_cfg_class_init,
 };
 
+static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp)
+{
+    uint16_t file_slots_max;
+
+    if (fw_cfg_file_slots(s) < FW_CFG_FILE_SLOTS_MIN) {
+        error_setg(errp, "\"file_slots\" must be at least 0x%x",
+                   FW_CFG_FILE_SLOTS_MIN);
+        return;
+    }
+
+    /* (UINT16_MAX & FW_CFG_ENTRY_MASK) is the highest inclusive selector value
+     * that we permit. The actual (exclusive) value coming from the
+     * configuration is (FW_CFG_FILE_FIRST + fw_cfg_file_slots(s)). */
+    file_slots_max = (UINT16_MAX & FW_CFG_ENTRY_MASK) - FW_CFG_FILE_FIRST + 1;
+    if (fw_cfg_file_slots(s) > file_slots_max) {
+        error_setg(errp, "\"file_slots\" must not exceed 0x%" PRIx16,
+                   file_slots_max);
+        return;
+    }
+
+    s->entries[0] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
+    s->entries[1] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
+    s->entry_order = g_new0(int, fw_cfg_max_entry(s));
+}
 
 static Property fw_cfg_io_properties[] = {
     DEFINE_PROP_UINT32("iobase", FWCfgIoState, iobase, -1),
     DEFINE_PROP_UINT32("dma_iobase", FWCfgIoState, dma_iobase, -1),
     DEFINE_PROP_BOOL("dma_enabled", FWCfgIoState, parent_obj.dma_enabled,
                      true),
+    DEFINE_PROP_UINT16("x-file-slots", FWCfgIoState, parent_obj.file_slots,
+                       FW_CFG_FILE_SLOTS_MIN),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1027,6 +1066,13 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
 {
     FWCfgIoState *s = FW_CFG_IO(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    Error *local_err = NULL;
+
+    fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     /* when using port i/o, the 8-bit data register ALWAYS overlaps
      * with half of the 16-bit control register. Hence, the total size
@@ -1063,6 +1109,8 @@ static Property fw_cfg_mem_properties[] = {
     DEFINE_PROP_UINT32("data_width", FWCfgMemState, data_width, -1),
     DEFINE_PROP_BOOL("dma_enabled", FWCfgMemState, parent_obj.dma_enabled,
                      true),
+    DEFINE_PROP_UINT16("x-file-slots", FWCfgMemState, parent_obj.file_slots,
+                       FW_CFG_FILE_SLOTS_MIN),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1071,6 +1119,13 @@ static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
     FWCfgMemState *s = FW_CFG_MEM(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     const MemoryRegionOps *data_ops = &fw_cfg_data_mem_ops;
+    Error *local_err = NULL;
+
+    fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     memory_region_init_io(&s->ctl_iomem, OBJECT(s), &fw_cfg_ctl_mem_ops,
                           FW_CFG(s), "fwcfg.ctl", FW_CFG_CTL_SIZE);
-- 
MST
