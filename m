Received: from eggs.gnu.org ([2001:4830:134:3::10]:44978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dMVAJ-0005yt-Hm
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 04:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dMVAI-0006XU-G7
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 04:02:35 -0400
Received: from chuckie.co.uk ([82.165.15.123]:56452
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dMVAI-0006Wl-8V
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 04:02:34 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 18 Jun 2017 09:02:14 +0100
Message-Id: <1497772934-15561-6-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1497772934-15561-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1497772934-15561-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv5 5/5] fw_cfg: move QOM type defines and fw_cfg
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

By exposing FWCfgIoState and FWCfgMemState internals we allow the possibility
for the internal MemoryRegion fields to be mapped by name for boards that wish
to wire up the fw_cfg device themselves.

An additional minor tidy-up is that the FWCfgEntry typedef is moved from the
struct definitions in fw_cfg.h to typedefs.h along with the others.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/nvram/fw_cfg.c         |   55 ------------------------------------------
 include/hw/nvram/fw_cfg.h |   58 +++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/typedefs.h   |    1 +
 3 files changed, 59 insertions(+), 55 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index df99903..00771c9 100644
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
@@ -61,53 +53,6 @@
 
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
index b980cba..b0511b9 100644
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
@@ -35,6 +46,53 @@ typedef struct FWCfgDmaAccess {
 
 typedef void (*FWCfgReadCallback)(void *opaque);
 
+struct FWCfgEntry {
+    uint32_t len;
+    bool allow_write;
+    uint8_t *data;
+    void *callback_opaque;
+    FWCfgReadCallback read_callback;
+};
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
index f745d5f..2db2918 100644
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
-- 
1.7.10.4
