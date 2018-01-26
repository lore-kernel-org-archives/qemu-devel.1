Received: from eggs.gnu.org ([2001:4830:134:3::10]:43067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ef794-0004rv-BJ
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ef790-0001Tq-ER
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:46:30 -0500
Received: from chuckie.co.uk ([82.165.15.123]:59220
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ef790-0001SX-8H
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:46:26 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 26 Jan 2018 09:20:28 +0000
Message-Id: <20180126092029.20737-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180126092029.20737-1-mark.cave-ayland@ilande.co.uk>
References: <20180126092029.20737-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/3] uninorth: convert to trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
2.11.0
