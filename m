Received: from eggs.gnu.org ([2001:4830:134:3::10]:51778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQOv-0006Km-RS
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQOs-00006G-1F
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:02:01 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 13:01:05 -0300
Message-Id: <20170922160111.31885-6-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 28/34] hw/net/e1000: use TYPE_PCI_E1000
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Balaton Zoltan <balaton@eik.bme.hu>, Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/net/pci.h   | 2 ++
 hw/alpha/dp264.c       | 3 ++-
 hw/i386/pc.c           | 3 ++-
 hw/ppc/ppc440_bamboo.c | 3 ++-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/net/pci.h b/include/hw/net/pci.h
index 529591b7f3..b24b5257a5 100644
--- a/include/hw/net/pci.h
+++ b/include/hw/net/pci.h
@@ -13,6 +13,8 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 
+#define TYPE_PCI_E1000      "e1000"
+
 PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
                                const char *default_model,
                                const char *default_devaddr);
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index df6dadf13f..65947fe1bf 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -21,6 +21,7 @@
 #include "hw/timer/i8254.h"
 #include "hw/input/i8042.h"
 #include "hw/char/serial.h"
+#include "hw/net/pci.h"
 #include "qemu/cutils.h"
 
 #define MAX_IDE_BUS 2
@@ -93,7 +94,7 @@ static void clipper_init(MachineState *machine)
 
     /* Network setup.  e1000 is good enough, failing Tulip support.  */
     for (i = 0; i < nb_nics; i++) {
-        pci_nic_init_nofail(&nd_table[i], pci_bus, "e1000", NULL);
+        pci_nic_init_nofail(&nd_table[i], pci_bus, TYPE_PCI_E1000, NULL);
     }
 
     /* IDE disk setup.  */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 085577e066..3cdeb148aa 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -72,6 +72,7 @@
 #include "hw/nmi.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
+#include "hw/net/pci.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -1606,7 +1607,7 @@ void pc_nic_init(ISABus *isa_bus, PCIBus *pci_bus)
         if (!pci_bus || (nd->model && strcmp(nd->model, "ne2k_isa") == 0)) {
             pc_init_ne2k_isa(isa_bus, nd);
         } else {
-            pci_nic_init_nofail(nd, pci_bus, "e1000", NULL);
+            pci_nic_init_nofail(nd, pci_bus, TYPE_PCI_E1000, NULL);
         }
     }
     rom_reset_order_override();
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index f92d47f28d..6387dbda9f 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -24,6 +24,7 @@
 #include "elf.h"
 #include "exec/address-spaces.h"
 #include "hw/char/serial.h"
+#include "hw/net/pci.h"
 #include "hw/ppc/ppc.h"
 #include "ppc405.h"
 #include "sysemu/sysemu.h"
@@ -248,7 +249,7 @@ static void bamboo_init(MachineState *machine)
         for (i = 0; i < nb_nics; i++) {
             /* There are no PCI NICs on the Bamboo board, but there are
              * PCI slots, so we can pick whatever default model we want. */
-            pci_nic_init_nofail(&nd_table[i], pcibus, "e1000", NULL);
+            pci_nic_init_nofail(&nd_table[i], pcibus, TYPE_PCI_E1000, NULL);
         }
     }
 
-- 
2.14.1
