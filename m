Received: from eggs.gnu.org ([2001:4830:134:3::10]:52231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQPE-0006dS-9K
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQP8-0000Id-3v
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:02:20 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 13:01:09 -0300
Message-Id: <20170922160111.31885-10-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 32/34] hw/net/ne2000: use TYPE_PCI_NE2000
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/net/pci.h  | 1 +
 hw/net/ne2000.c       | 3 ++-
 hw/ppc/mac_newworld.c | 3 ++-
 hw/ppc/mac_oldworld.c | 3 ++-
 hw/ppc/prep.c         | 2 +-
 hw/sparc64/sun4u.c    | 3 ++-
 6 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/hw/net/pci.h b/include/hw/net/pci.h
index 43ed3b0145..da733dd1d9 100644
--- a/include/hw/net/pci.h
+++ b/include/hw/net/pci.h
@@ -15,6 +15,7 @@
 
 #define TYPE_PCI_E1000      "e1000"
 #define TYPE_PCI_E1000E     "e1000e"
+#define TYPE_PCI_NE2000     "ne2k_pci"
 #define TYPE_PCI_PCNET      "pcnet"
 #define TYPE_PCI_RTL8139    "rtl8139"
 
diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 29bd4adb3f..b0a664d302 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -23,6 +23,7 @@
  */
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/net/pci.h"
 #include "ne2000.h"
 #include "hw/loader.h"
 #include "sysemu/sysemu.h"
@@ -779,7 +780,7 @@ static void ne2000_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo ne2000_info = {
-    .name          = "ne2k_pci",
+    .name          = TYPE_PCI_NE2000,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCINE2000State),
     .class_init    = ne2000_class_init,
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 33b46cb50b..2afc35c27f 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -55,6 +55,7 @@
 #include "hw/ppc/mac_dbdma.h"
 #include "hw/timer/m48t59.h"
 #include "hw/pci/pci.h"
+#include "hw/net/pci.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
@@ -435,7 +436,7 @@ static void ppc_core99_init(MachineState *machine)
     }
 
     for (i = 0; i < nb_nics; i++) {
-        pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
+        pci_nic_init_nofail(&nd_table[i], pci_bus, TYPE_PCI_NE2000, NULL);
     }
 
     /* The NewWorld NVRAM is not located in the MacIO device */
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 193b9047d9..8096e5a126 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -34,6 +34,7 @@
 #include "net/net.h"
 #include "hw/isa/isa.h"
 #include "hw/pci/pci.h"
+#include "hw/net/pci.h"
 #include "hw/boards.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/char/escc.h"
@@ -278,7 +279,7 @@ static void ppc_heathrow_init(MachineState *machine)
                              escc_mem, 0, memory_region_size(escc_mem));
 
     for(i = 0; i < nb_nics; i++)
-        pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
+        pci_nic_init_nofail(&nd_table[i], pci_bus, TYPE_PCI_NE2000, NULL);
 
 
     ide_drive_get(hd, ARRAY_SIZE(hd));
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index b2c7a62ebc..103beafef3 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -636,7 +636,7 @@ static void ppc_prep_init(MachineState *machine)
             isa_ne2000_init(isa_bus, ne2000_io[i], ne2000_irq[i],
                             &nd_table[i]);
         } else {
-            pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
+            pci_nic_init_nofail(&nd_table[i], pci_bus, TYPE_PCI_NE2000, NULL);
         }
     }
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index fd10741607..67879c5135 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -32,6 +32,7 @@
 #include "hw/char/serial.h"
 #include "hw/timer/m48t59.h"
 #include "hw/input/i8042.h"
+#include "hw/net/pci.h"
 #include "hw/block/fdc.h"
 #include "net/net.h"
 #include "qemu/timer.h"
@@ -476,7 +477,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
 
             onboard_nic_idx = i;
         } else {
-            pci_nic_init_nofail(nd, pci_bus, "ne2k_pci", NULL);
+            pci_nic_init_nofail(nd, pci_bus, TYPE_PCI_NE2000, NULL);
         }
     }
     onboard_nic_idx = MAX(onboard_nic_idx, 0);
-- 
2.14.1
