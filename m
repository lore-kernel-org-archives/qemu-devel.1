Received: from eggs.gnu.org ([2001:4830:134:3::10]:56923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xv-00078h-TW
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xt-0002wZ-Lf
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:55 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 26 Nov 2017 15:59:08 -0600
Message-Id: <5d63d645603b83d24187c3844bd0728bd4c4b682.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 10/17] e500: move uarts CCSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/ppc/e500.c      | 13 -------------
 hw/ppc/e500_ccsr.c | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 1872bb8eaa..2d87d91582 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -22,7 +22,6 @@
 #include "net/net.h"
 #include "qemu/config-file.h"
 #include "hw/hw.h"
-#include "hw/char/serial.h"
 #include "hw/pci/pci.h"
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
@@ -770,18 +769,6 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     mpicdev = DEVICE(object_resolve_path("/machine/pic", 0));
     assert(mpicdev);
 
-    /* Serial */
-    if (serial_hds[0]) {
-        serial_mm_init(ccsr_addr_space, MPC8544_SERIAL0_REGS_OFFSET,
-                       0, qdev_get_gpio_in(mpicdev, 42), 399193,
-                       serial_hds[0], DEVICE_BIG_ENDIAN);
-    }
-
-    if (serial_hds[1]) {
-        serial_mm_init(ccsr_addr_space, MPC8544_SERIAL1_REGS_OFFSET,
-                       0, qdev_get_gpio_in(mpicdev, 42), 399193,
-                       serial_hds[1], DEVICE_BIG_ENDIAN);
-    }
 
     /* PCI */
     dev = qdev_create(NULL, "e500-pcihost");
diff --git a/hw/ppc/e500_ccsr.c b/hw/ppc/e500_ccsr.c
index 68d952794e..f1adba4e54 100644
--- a/hw/ppc/e500_ccsr.c
+++ b/hw/ppc/e500_ccsr.c
@@ -31,6 +31,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "hw/sysbus.h"
+#include "hw/char/serial.h"
 #include "hw/ppc/openpic.h"
 
 /* E500_ denotes registers common to all */
@@ -45,6 +46,8 @@
 #define E500_ERR_DETECT  (0x2e40)
 #define E500_ERR_DISABLE (0x2e44)
 
+#define E500_DUART_OFFSET(N) (0x4500 + (N) * 0x100)
+
 #define E500_PORPLLSR    (0xE0000)
 #define E500_PVR         (0xE00A0)
 #define E500_SVR         (0xE00A4)
@@ -266,6 +269,21 @@ static void e500_ccsr_realize(DeviceState *dev, Error **errp)
 
     memory_region_add_subregion(&ccsr->iomem, E500_MPIC_OFFSET,
                                 sysbus_mmio_get_region(pic, 0));
+    /* Note: MPIC internal interrupts are offset by 16 */
+
+    /* DUARTS */
+    if (serial_hds[0]) {
+        serial_mm_init(&ccsr->iomem, E500_DUART_OFFSET(0),
+                       0, qdev_get_gpio_in(ccsr->pic, 16 + 26), 399193,
+                       serial_hds[0], DEVICE_BIG_ENDIAN);
+    }
+
+    if (serial_hds[1]) {
+        serial_mm_init(&ccsr->iomem, E500_DUART_OFFSET(1),
+                       0, qdev_get_gpio_in(ccsr->pic, 16 + 26), 399193,
+                       serial_hds[1], DEVICE_BIG_ENDIAN);
+    }
+
 }
 
 static Property e500_ccsr_props[] = {
-- 
2.11.0
