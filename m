Received: from eggs.gnu.org ([2001:4830:134:3::10]:34490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6w-0003NU-0O
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6v-0003nI-3O
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXB6u-0003m2-Q4
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Jul 2017 15:50:45 -0300
Message-Id: <20170717185051.18740-10-ehabkost@redhat.com>
In-Reply-To: <20170717185051.18740-1-ehabkost@redhat.com>
References: <20170717185051.18740-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 09/15] fw_cfg: move QOM type defines and fw_cfg
 types into fw_cfg.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

By exposing FWCfgIoState and FWCfgMemState internals we allow the possibility
for the internal MemoryRegion fields to be mapped by name for boards that wish
to wire up the fw_cfg device themselves.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <1500025208-14827-4-git-send-email-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/nvram/fw_cfg.h | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/typedefs.h   |  1 +
 hw/nvram/fw_cfg.c         | 49 +---------------------------------------------
 3 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index b980cba..b77ea48 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -1,8 +1,19 @@
 #ifndef FW_CFG_H
 #define FW_CFG_H
 
+#include "qemu/typedefs.h"
 #include "exec/hwaddr.h"
 #include "hw/nvram/fw_cfg_keys.h"
+#include "hw/sysbus.h"
+#include "sysemu/dma.h"
+
+#define TYPE_FW_CFG     "fw_cfg"
+#define TYPE_FW_CFG_IO  "fw_cfg_io"
+#define TYPE_FW_CFG_MEM "fw_cfg_mem"
+
+#define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG)
+#define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_IO)
+#define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_MEM)
 
 typedef struct FWCfgFile {
     uint32_t  size;        /* file size */
@@ -35,6 +46,45 @@ typedef struct FWCfgDmaAccess {
 
 typedef void (*FWCfgReadCallback)(void *opaque);
 
+struct FWCfgState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    uint16_t file_slots;
+    FWCfgEntry *entries[2];
+    int *entry_order;
+    FWCfgFiles *files;
+    uint16_t cur_entry;
+    uint32_t cur_offset;
+    Notifier machine_ready;
+
+    int fw_cfg_order_override;
+
+    bool dma_enabled;
+    dma_addr_t dma_addr;
+    AddressSpace *dma_as;
+    MemoryRegion dma_iomem;
+};
+
+struct FWCfgIoState {
+    /*< private >*/
+    FWCfgState parent_obj;
+    /*< public >*/
+
+    MemoryRegion comb_iomem;
+};
+
+struct FWCfgMemState {
+    /*< private >*/
+    FWCfgState parent_obj;
+    /*< public >*/
+
+    MemoryRegion ctl_iomem, data_iomem;
+    uint32_t data_width;
+    MemoryRegionOps wide_data_ops;
+};
+
 /**
  * fw_cfg_add_bytes:
  * @s: fw_cfg device being modified
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index b191591..7b0d4e7 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -30,6 +30,7 @@ typedef struct DisplaySurface DisplaySurface;
 typedef struct DriveInfo DriveInfo;
 typedef struct Error Error;
 typedef struct EventNotifier EventNotifier;
+typedef struct FWCfgEntry FWCfgEntry;
 typedef struct FWCfgIoState FWCfgIoState;
 typedef struct FWCfgMemState FWCfgMemState;
 typedef struct FWCfgState FWCfgState;
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 97c7677..5bd9044 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -37,14 +37,6 @@
 
 #define FW_CFG_FILE_SLOTS_DFLT 0x20
 
-#define TYPE_FW_CFG     "fw_cfg"
-#define TYPE_FW_CFG_IO  "fw_cfg_io"
-#define TYPE_FW_CFG_MEM "fw_cfg_mem"
-
-#define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG)
-#define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_IO)
-#define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_MEM)
-
 /* FW_CFG_VERSION bits */
 #define FW_CFG_VERSION      0x01
 #define FW_CFG_VERSION_DMA  0x02
@@ -58,51 +50,12 @@
 
 #define FW_CFG_DMA_SIGNATURE 0x51454d5520434647ULL /* "QEMU CFG" */
 
-typedef struct FWCfgEntry {
+struct FWCfgEntry {
     uint32_t len;
     bool allow_write;
     uint8_t *data;
     void *callback_opaque;
     FWCfgReadCallback read_callback;
-} FWCfgEntry;
-
-struct FWCfgState {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-
-    uint16_t file_slots;
-    FWCfgEntry *entries[2];
-    int *entry_order;
-    FWCfgFiles *files;
-    uint16_t cur_entry;
-    uint32_t cur_offset;
-    Notifier machine_ready;
-
-    int fw_cfg_order_override;
-
-    bool dma_enabled;
-    dma_addr_t dma_addr;
-    AddressSpace *dma_as;
-    MemoryRegion dma_iomem;
-};
-
-struct FWCfgIoState {
-    /*< private >*/
-    FWCfgState parent_obj;
-    /*< public >*/
-
-    MemoryRegion comb_iomem;
-};
-
-struct FWCfgMemState {
-    /*< private >*/
-    FWCfgState parent_obj;
-    /*< public >*/
-
-    MemoryRegion ctl_iomem, data_iomem;
-    uint32_t data_width;
-    MemoryRegionOps wide_data_ops;
 };
 
 #define JPG_FILE 0
-- 
2.9.4
