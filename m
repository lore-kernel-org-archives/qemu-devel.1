Received: from eggs.gnu.org ([2001:4830:134:3::10]:34808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eg07Y-0004Sf-UO
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eg07X-0001cy-Pb
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:28:36 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 29 Jan 2018 14:28:18 +1100
Message-Id: <20180129032826.16876-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180129032826.16876-1-david@gibson.dropbear.id.au>
References: <20180129032826.16876-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/12] uninorth: convert to trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, surajjs@au1.ibm.com, groug@kaod.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-host/trace-events |  6 ++++++
 hw/pci-host/uninorth.c   | 24 +++++-------------------
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index 5b8fcc228b..341a87a702 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -12,3 +12,9 @@ sabre_pci_config_write(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PR
 sabre_pci_config_read(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
 sabre_pci_set_irq(int irq_num, int level) "set irq_in %d level %d"
 sabre_pci_set_obio_irq(int irq_num, int level) "set irq %d level %d"
+
+# hw/pci-host/uninorth.c
+unin_set_irq(int irq_num, int level) "setting INT %d = %d"
+unin_get_config_reg(uint32_t reg, uint32_t addr, uint32_t retval) "converted config space accessor 0x%"PRIx32 "/0x%"PRIx32 " -> 0x%"PRIx32
+unin_data_write(uint64_t addr, unsigned len, uint64_t val) "write addr 0x%"PRIx64 " len %d val 0x%"PRIx64
+unin_data_read(uint64_t addr, unsigned len, uint64_t val) "read addr 0x%"PRIx64 " len %d val 0x%"PRIx64
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 5d8ccaa711..66991da975 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -26,16 +26,7 @@
 #include "hw/ppc/mac.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
-
-/* debug UniNorth */
-//#define DEBUG_UNIN
-
-#ifdef DEBUG_UNIN
-#define UNIN_DPRINTF(fmt, ...)                                  \
-    do { printf("UNIN: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define UNIN_DPRINTF(fmt, ...)
-#endif
+#include "trace.h"
 
 static const int unin_irq_line[] = { 0x1b, 0x1c, 0x1d, 0x1e };
 
@@ -69,8 +60,7 @@ static void pci_unin_set_irq(void *opaque, int irq_num, int level)
 {
     qemu_irq *pic = opaque;
 
-    UNIN_DPRINTF("%s: setting INT %d = %d\n", __func__,
-                 unin_irq_line[irq_num], level);
+    trace_unin_set_irq(unin_irq_line[irq_num], level);
     qemu_set_irq(pic[unin_irq_line[irq_num]], level);
 }
 
@@ -103,9 +93,7 @@ static uint32_t unin_get_config_reg(uint32_t reg, uint32_t addr)
         retval |= func << 8;
     }
 
-
-    UNIN_DPRINTF("Converted config space accessor %08x/%08x -> %08x\n",
-                 reg, addr, retval);
+    trace_unin_get_config_reg(reg, addr, retval);
 
     return retval;
 }
@@ -115,8 +103,7 @@ static void unin_data_write(void *opaque, hwaddr addr,
 {
     UNINState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
-    UNIN_DPRINTF("write addr " TARGET_FMT_plx " len %d val %"PRIx64"\n",
-                 addr, len, val);
+    trace_unin_data_write(addr, len, val);
     pci_data_write(phb->bus,
                    unin_get_config_reg(phb->config_reg, addr),
                    val, len);
@@ -132,8 +119,7 @@ static uint64_t unin_data_read(void *opaque, hwaddr addr,
     val = pci_data_read(phb->bus,
                         unin_get_config_reg(phb->config_reg, addr),
                         len);
-    UNIN_DPRINTF("read addr " TARGET_FMT_plx " len %d val %x\n",
-                 addr, len, val);
+    trace_unin_data_read(addr, len, val);
     return val;
 }
 
-- 
2.14.3
