Received: from eggs.gnu.org ([2001:4830:134:3::10]:54277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4ax-0003Ut-IC
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4aw-0002yS-Bq
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:47 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 12:51:25 +1000
Message-Id: <20170606025135.2685-8-david@gibson.dropbear.id.au>
In-Reply-To: <20170606025135.2685-1-david@gibson.dropbear.id.au>
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/17] target-ppc: Fix openpic timer read
 register offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, Aaron Larson <alarson@ddci.com>, David Gibson <david@gibson.dropbear.id.au>

From: Aaron Larson <alarson@ddci.com>

openpic_tmr_read() is incorrectly computing register offset of the
TCCR, TBCR, TVPR, and TDR registers when accessing the open pic timer
registers.  Specifically the offset of timer registers for
openpic_tmr_read() is not accounting for the timer frequency reporting
register (TFFR) which is the first register in the "tmr" memory
region.

openpic_tmr_write() *is* correctly computing the offset by adding
0x10f0 to the address prior to computing the register index.  This
patch instead subtracts 0x10 in both the read and write routines and
eliminates some other gratuitous differences between the functions.

Signed-off-by: Aaron Larson <alarson@ddci.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/openpic.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 4349e45..f966d06 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -796,27 +796,24 @@ static uint64_t openpic_gbl_read(void *opaque, hwaddr addr, unsigned len)
 }
 
 static void openpic_tmr_write(void *opaque, hwaddr addr, uint64_t val,
-                                unsigned len)
+                              unsigned len)
 {
     OpenPICState *opp = opaque;
     int idx;
 
-    addr += 0x10f0;
-
     DPRINTF("%s: addr %#" HWADDR_PRIx " <= %08" PRIx64 "\n",
-            __func__, addr, val);
+            __func__, (addr + 0x10f0), val);
     if (addr & 0xF) {
         return;
     }
 
-    if (addr == 0x10f0) {
+    if (addr == 0) {
         /* TFRR */
         opp->tfrr = val;
         return;
     }
-
+    addr -= 0x10;  /* correct for TFRR */
     idx = (addr >> 6) & 0x3;
-    addr = addr & 0x30;
 
     switch (addr & 0x30) {
     case 0x00: /* TCCR */
@@ -844,16 +841,17 @@ static uint64_t openpic_tmr_read(void *opaque, hwaddr addr, unsigned len)
     uint32_t retval = -1;
     int idx;
 
-    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr);
+    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr + 0x10f0);
     if (addr & 0xF) {
         goto out;
     }
-    idx = (addr >> 6) & 0x3;
-    if (addr == 0x0) {
+    if (addr == 0) {
         /* TFRR */
         retval = opp->tfrr;
         goto out;
     }
+    addr -= 0x10;  /* correct for TFRR */
+    idx = (addr >> 6) & 0x3;
     switch (addr & 0x30) {
     case 0x00: /* TCCR */
         retval = opp->timers[idx].tccr;
@@ -861,10 +859,10 @@ static uint64_t openpic_tmr_read(void *opaque, hwaddr addr, unsigned len)
     case 0x10: /* TBCR */
         retval = opp->timers[idx].tbcr;
         break;
-    case 0x20: /* TIPV */
+    case 0x20: /* TVPR */
         retval = read_IRQreg_ivpr(opp, opp->irq_tim0 + idx);
         break;
-    case 0x30: /* TIDE (TIDR) */
+    case 0x30: /* TDR */
         retval = read_IRQreg_idr(opp, opp->irq_tim0 + idx);
         break;
     }
-- 
2.9.4
