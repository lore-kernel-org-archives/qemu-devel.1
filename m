Received: from eggs.gnu.org ([2001:4830:134:3::10]:51886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQP3-0006Sa-UX
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQOz-0000BE-FE
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:02:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 13:01:07 -0300
Message-Id: <20170922160111.31885-8-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 30/34] hw/net/pcnet: use TYPE_PCI_PCNET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/net/pci.h | 1 +
 hw/mips/mips_malta.c | 2 +-
 hw/net/pcnet-pci.c   | 3 +--
 hw/ppc/prep.c        | 3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/hw/net/pci.h b/include/hw/net/pci.h
index 92111f86f3..5ad5487a91 100644
--- a/include/hw/net/pci.h
+++ b/include/hw/net/pci.h
@@ -15,6 +15,7 @@
 
 #define TYPE_PCI_E1000      "e1000"
 #define TYPE_PCI_E1000E     "e1000e"
+#define TYPE_PCI_PCNET      "pcnet"
 
 PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
                                const char *default_model,
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index fb6a2f9363..921678fdb0 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -597,7 +597,7 @@ static void network_init(PCIBus *pci_bus)
             /* The malta board has a PCNet card using PCI SLOT 11 */
             default_devaddr = "0b";
 
-        pci_nic_init_nofail(nd, pci_bus, "pcnet", default_devaddr);
+        pci_nic_init_nofail(nd, pci_bus, TYPE_PCI_PCNET, default_devaddr);
     }
 }
 
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 0acf8a4879..878e2c89c1 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -29,6 +29,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/net/pci.h"
 #include "net/net.h"
 #include "hw/loader.h"
 #include "qemu/timer.h"
@@ -46,8 +47,6 @@
 //#define PCNET_DEBUG_TMD
 //#define PCNET_DEBUG_MATCH
 
-#define TYPE_PCI_PCNET "pcnet"
-
 #define PCI_PCNET(obj) \
      OBJECT_CHECK(PCIPCNetState, (obj), TYPE_PCI_PCNET)
 
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index fb330a1769..b2c7a62ebc 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -44,6 +44,7 @@
 #include "hw/input/i8042.h"
 #include "hw/isa/pc87312.h"
 #include "hw/net/ne2000-isa.h"
+#include "hw/net/pci.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/kvm.h"
@@ -800,7 +801,7 @@ static void ibm_40p_init(MachineState *machine)
         pci_vga_init(pci_bus);
 
         for (i = 0; i < nb_nics; i++) {
-            pci_nic_init_nofail(&nd_table[i], pci_bus, "pcnet",
+            pci_nic_init_nofail(&nd_table[i], pci_bus, TYPE_PCI_PCNET,
                                 i == 0 ? "3" : NULL);
         }
     }
-- 
2.14.1
