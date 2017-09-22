Received: from eggs.gnu.org ([2001:4830:134:3::10]:51929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQP5-0006Tu-8M
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQP3-0000Dp-Du
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:02:11 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 13:01:08 -0300
Message-Id: <20170922160111.31885-9-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 31/34] hw/net/rtl8139: use TYPE_PCI_RTL8139
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Magnus Damm <magnus.damm@gmail.com>, Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/net/pci.h    | 1 +
 hw/arm/realview.c       | 3 ++-
 hw/arm/versatilepb.c    | 3 ++-
 hw/mips/mips_fulong2e.c | 3 ++-
 hw/net/rtl8139.c        | 7 +++----
 hw/sh4/r2d.c            | 5 +++--
 6 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/hw/net/pci.h b/include/hw/net/pci.h
index 5ad5487a91..43ed3b0145 100644
--- a/include/hw/net/pci.h
+++ b/include/hw/net/pci.h
@@ -16,6 +16,7 @@
 #define TYPE_PCI_E1000      "e1000"
 #define TYPE_PCI_E1000E     "e1000e"
 #define TYPE_PCI_PCNET      "pcnet"
+#define TYPE_PCI_RTL8139    "rtl8139"
 
 PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
                                const char *default_model,
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 87cd1e583c..35f0da28e4 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -20,6 +20,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/i2c/i2c.h"
+#include "hw/net/pci.h"
 #include "sysemu/block-backend.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
@@ -269,7 +270,7 @@ static void realview_init(MachineState *machine,
             done_nic = 1;
         } else {
             if (pci_bus) {
-                pci_nic_init_nofail(nd, pci_bus, "rtl8139", NULL);
+                pci_nic_init_nofail(nd, pci_bus, TYPE_PCI_RTL8139, NULL);
             }
         }
     }
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 418792cd02..297aad78e1 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -18,6 +18,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/pci/pci.h"
 #include "hw/i2c/i2c.h"
+#include "hw/net/pci.h"
 #include "hw/boards.h"
 #include "sysemu/block-backend.h"
 #include "exec/address-spaces.h"
@@ -271,7 +272,7 @@ static void versatile_init(MachineState *machine, int board_id)
             smc91c111_init(nd, 0x10010000, sic[25]);
             done_smc = 1;
         } else {
-            pci_nic_init_nofail(nd, pci_bus, "rtl8139", NULL);
+            pci_nic_init_nofail(nd, pci_bus, TYPE_PCI_RTL8139, NULL);
         }
     }
     if (machine_usb(machine)) {
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 7ebbffa8f2..fe618953c9 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -44,6 +44,7 @@
 #include "hw/timer/mc146818rtc.h"
 #include "hw/timer/i8254.h"
 #include "hw/input/i8042.h"
+#include "hw/net/pci.h"
 #include "sysemu/blockdev.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
@@ -253,7 +254,7 @@ static void network_init (PCIBus *pci_bus)
             default_devaddr = "07";
         }
 
-        pci_nic_init_nofail(nd, pci_bus, "rtl8139", default_devaddr);
+        pci_nic_init_nofail(nd, pci_bus, TYPE_PCI_RTL8139, default_devaddr);
     }
 }
 
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 3be24bbee7..0f952eceba 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -59,6 +59,7 @@
 #include "net/net.h"
 #include "net/eth.h"
 #include "hw/loader.h"
+#include "hw/net/pci.h"
 #include "sysemu/sysemu.h"
 #include "qemu/iov.h"
 
@@ -90,10 +91,8 @@ static inline GCC_FMT_ATTR(1, 2) int DPRINTF(const char *fmt, ...)
 }
 #endif
 
-#define TYPE_RTL8139 "rtl8139"
-
 #define RTL8139(obj) \
-     OBJECT_CHECK(RTL8139State, (obj), TYPE_RTL8139)
+     OBJECT_CHECK(RTL8139State, (obj), TYPE_PCI_RTL8139)
 
 /* Symbolic offsets to registers. */
 enum RTL8139_registers {
@@ -3437,7 +3436,7 @@ static void rtl8139_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo rtl8139_info = {
-    .name          = TYPE_RTL8139,
+    .name          = TYPE_PCI_RTL8139,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(RTL8139State),
     .class_init    = rtl8139_class_init,
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 16b9ed2db2..dde60b2bc2 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -39,6 +39,7 @@
 #include "hw/ide.h"
 #include "hw/loader.h"
 #include "hw/usb.h"
+#include "hw/net/pci.h"
 #include "hw/block/flash.h"
 #include "sysemu/block-backend.h"
 #include "exec/address-spaces.h"
@@ -303,8 +304,8 @@ static void r2d_init(MachineState *machine)
 
     /* NIC: rtl8139 on-board, and 2 slots. */
     for (i = 0; i < nb_nics; i++)
-        pci_nic_init_nofail(&nd_table[i], pci_bus,
-                            "rtl8139", i==0 ? "2" : NULL);
+        pci_nic_init_nofail(&nd_table[i], pci_bus, TYPE_PCI_RTL8139,
+                            i == 0 ? "2" : NULL);
 
     /* USB keyboard */
     usb_create_simple(usb_bus_find(-1), "usb-kbd");
-- 
2.14.1
