Received: from eggs.gnu.org ([2001:4830:134:3::10]:45571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fyBFT-0007UE-QQ
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fyBFQ-00053B-JD
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:32:11 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  7 Sep 2018 17:31:45 +1000
Message-Id: <20180907073155.26200-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180907073155.26200-1-david@gibson.dropbear.id.au>
References: <20180907073155.26200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/14] macio: move MACIOIDEState type
 declarations to macio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, mark.cave-ayland@ilande.co.uk, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ide/macio.c                |  1 +
 hw/ppc/mac.h                  | 26 --------------------------
 include/hw/misc/macio/macio.h | 26 ++++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index d3a85cba3b..f23961e241 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -26,6 +26,7 @@
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "hw/ppc/mac_dbdma.h"
+#include "hw/misc/macio/macio.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
 
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 41fd289e81..a741300ac9 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -86,32 +86,6 @@ typedef struct Core99MachineState {
     uint8_t via_config;
 } Core99MachineState;
 
-/* MacIO */
-#define TYPE_MACIO_IDE "macio-ide"
-#define MACIO_IDE(obj) OBJECT_CHECK(MACIOIDEState, (obj), TYPE_MACIO_IDE)
-
-typedef struct MACIOIDEState {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-    uint32_t channel;
-    qemu_irq real_ide_irq;
-    qemu_irq real_dma_irq;
-    qemu_irq ide_irq;
-    qemu_irq dma_irq;
-
-    MemoryRegion mem;
-    IDEBus bus;
-    IDEDMA dma;
-    void *dbdma;
-    bool dma_active;
-    uint32_t timing_reg;
-    uint32_t irq_reg;
-} MACIOIDEState;
-
-void macio_ide_init_drives(MACIOIDEState *ide, DriveInfo **hd_table);
-void macio_ide_register_dma(MACIOIDEState *ide);
-
 /* Grackle PCI */
 #define TYPE_GRACKLE_PCI_HOST_BRIDGE "grackle-pcihost"
 
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index cfaa145500..0c3964ec12 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -34,6 +34,32 @@
 #include "hw/ppc/mac_dbdma.h"
 #include "hw/ppc/openpic.h"
 
+/* MacIO IDE */
+#define TYPE_MACIO_IDE "macio-ide"
+#define MACIO_IDE(obj) OBJECT_CHECK(MACIOIDEState, (obj), TYPE_MACIO_IDE)
+
+typedef struct MACIOIDEState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+    uint32_t channel;
+    qemu_irq real_ide_irq;
+    qemu_irq real_dma_irq;
+    qemu_irq ide_irq;
+    qemu_irq dma_irq;
+
+    MemoryRegion mem;
+    IDEBus bus;
+    IDEDMA dma;
+    void *dbdma;
+    bool dma_active;
+    uint32_t timing_reg;
+    uint32_t irq_reg;
+} MACIOIDEState;
+
+void macio_ide_init_drives(MACIOIDEState *ide, DriveInfo **hd_table);
+void macio_ide_register_dma(MACIOIDEState *ide);
+
 #define TYPE_MACIO "macio"
 #define MACIO(obj) OBJECT_CHECK(MacIOState, (obj), TYPE_MACIO)
 
-- 
2.17.1
