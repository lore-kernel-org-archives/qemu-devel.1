Received: from eggs.gnu.org ([2001:4830:134:3::10]:50338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW39E-0004q3-1f
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW39D-00029o-5K
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:28 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 14:12:53 -0300
Message-Id: <20180621171257.14897-8-f4bug@amsat.org>
In-Reply-To: <20180621171257.14897-1-f4bug@amsat.org>
References: <20180621171257.14897-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/11] hw/net/ne2000: Add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/ne2000.c     | 17 ++++++++++++-----
 hw/net/trace-events |  4 ++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 3a9fc89e48..26b234b7eb 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -26,6 +26,7 @@
 #include "net/eth.h"
 #include "ne2000.h"
 #include "sysemu/sysemu.h"
+#include "trace.h"
 
 /* debug NE2000 card */
 //#define DEBUG_NE2000
@@ -662,19 +663,24 @@ static uint64_t ne2000_read(void *opaque, hwaddr addr,
                             unsigned size)
 {
     NE2000State *s = opaque;
+    uint64_t val;
 
     if (addr < 0x10 && size == 1) {
-        return ne2000_ioport_read(s, addr);
+        val = ne2000_ioport_read(s, addr);
     } else if (addr == 0x10) {
         if (size <= 2) {
-            return ne2000_asic_ioport_read(s, addr);
+            val = ne2000_asic_ioport_read(s, addr);
         } else {
-            return ne2000_asic_ioport_readl(s, addr);
+            val = ne2000_asic_ioport_readl(s, addr);
         }
     } else if (addr == 0x1f && size == 1) {
-        return ne2000_reset_ioport_read(s, addr);
+        val = ne2000_reset_ioport_read(s, addr);
+    } else {
+        val = ((uint64_t)1 << (size * 8)) - 1;
     }
-    return ((uint64_t)1 << (size * 8)) - 1;
+    trace_ne2000_read(addr, val);
+
+    return val;
 }
 
 static void ne2000_write(void *opaque, hwaddr addr,
@@ -682,6 +688,7 @@ static void ne2000_write(void *opaque, hwaddr addr,
 {
     NE2000State *s = opaque;
 
+    trace_ne2000_write(addr, data);
     if (addr < 0x10 && size == 1) {
         ne2000_ioport_write(s, addr, data);
     } else if (addr == 0x10) {
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 45c4e9fba0..95a1de01e9 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -23,6 +23,10 @@ mipsnet_read(uint64_t addr, uint32_t val) "read addr=0x%" PRIx64 " val=0x%x"
 mipsnet_write(uint64_t addr, uint64_t val) "write addr=0x%" PRIx64 " val=0x%" PRIx64
 mipsnet_irq(uint32_t isr, uint32_t intctl) "set irq to %d (0x%02x)"
 
+# hw/net/ne2000.c
+ne2000_read(uint64_t addr, uint64_t val) "read addr=0x%" PRIx64 " val=0x%" PRIx64
+ne2000_write(uint64_t addr, uint64_t val) "write addr=0x%" PRIx64 " val=0x%" PRIx64
+
 # hw/net/opencores_eth.c
 open_eth_mii_write(unsigned idx, uint16_t v) "MII[0x%02x] <- 0x%04x"
 open_eth_mii_read(unsigned idx, uint16_t v) "MII[0x%02x] -> 0x%04x"
-- 
2.18.0.rc2
