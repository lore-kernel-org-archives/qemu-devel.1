Received: from eggs.gnu.org ([2001:4830:134:3::10]:33703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dVx5F-0006bR-M9
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dVx5E-0007aN-OU
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:40:25 -0400
Received: from chuckie.co.uk ([82.165.15.123]:41074
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dVx5E-0007a7-FW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:40:24 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 14 Jul 2017 10:40:08 +0100
Message-Id: <1500025208-14827-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1500025208-14827-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1500025208-14827-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv9 3/3] fw_cfg: move QOM type defines and fw_cfg
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 hw/nvram/fw_cfg.c         |   49 +-------------------------------------------
 include/hw/nvram/fw_cfg.h |   50 +++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/typedefs.h   |    1 +
 3 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b850ac3..2375f21 100644
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
index 2706aab..0a23020 100644
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
