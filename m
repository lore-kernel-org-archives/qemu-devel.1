Received: from eggs.gnu.org ([2001:4830:134:3::10]:48351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dLrDk-000554-UZ
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dLrDj-000727-C3
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:23:28 -0400
Received: from chuckie.co.uk ([82.165.15.123]:53182
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dLrDj-00071g-4y
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:23:27 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 16 Jun 2017 14:23:07 +0100
Message-Id: <1497619387-11333-6-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1497619387-11333-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1497619387-11333-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv4 5/5] fw_cfg: move QOM type defines and fw_cfg
 types into fw_cfg.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

This allows the device to be instantiated externally for boards that
wish to wire up the fw_cfg device themselves.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/nvram/fw_cfg.c         |   56 -------------------------------------------
 include/hw/nvram/fw_cfg.h |   58 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 56 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b5f10ac..00771c9 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -40,14 +40,6 @@
 #define FW_CFG_NAME "fw_cfg"
 #define FW_CFG_PATH "/machine/" FW_CFG_NAME
 
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
@@ -61,54 +53,6 @@
 
 #define FW_CFG_DMA_SIGNATURE 0x51454d5520434647ULL /* "QEMU CFG" */
 
-typedef struct FWCfgEntry {
-    uint32_t len;
-    bool allow_write;
-    uint8_t *data;
-    void *callback_opaque;
-    FWCfgReadCallback read_callback;
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
-    uint32_t iobase, dma_iobase;
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
-};
-
 #define JPG_FILE 0
 #define BMP_FILE 1
 
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index b980cba..a16907a 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -3,6 +3,16 @@
 
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
@@ -35,6 +45,54 @@ typedef struct FWCfgDmaAccess {
 
 typedef void (*FWCfgReadCallback)(void *opaque);
 
+typedef struct FWCfgEntry {
+    uint32_t len;
+    bool allow_write;
+    uint8_t *data;
+    void *callback_opaque;
+    FWCfgReadCallback read_callback;
+} FWCfgEntry;
+
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
+    uint32_t iobase, dma_iobase;
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
-- 
1.7.10.4
