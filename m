Received: from eggs.gnu.org ([2001:4830:134:3::10]:45291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cy4aj-00047k-P4
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cy4ag-0002bR-IZ
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:48:53 -0400
Received: from mail-bn3nam01on0075.outbound.protection.outlook.com
	([104.47.33.75]:15538
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1cy4ag-0002bJ-B9
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:48:50 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 11 Apr 2017 15:30:22 -0700
Message-ID: <438bcc014f8f8a2f8f68f322cb6a53f4c04688c2.1491947224.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1491947224.git.alistair.francis@xilinx.com>
References: <cover.1491947224.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 3/5] cadence_gem: Correct the interupt logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: f4bug@amsat.org, alistair.francis@xilinx.com, alistair23@gmail.com

This patch fixes two mistakes in the interrupt logic.

First we only trigger single-queue or multi-queue interrupts if the status
register is set. This logic was already used for non multi-queue interrupts
but it also applies to multi-queue interrupts.

Secondly we need to lower the interrupts if the ISR isn't set. As part
of this we can remove the other interrupt lowering logic and consolidate
it inside gem_update_int_status().

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/net/cadence_gem.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index a66a9cc..e1962e1 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -509,7 +509,18 @@ static void gem_update_int_status(CadenceGEMState *s)
 {
     int i;
 
-    if ((s->num_priority_queues == 1) && s->regs[GEM_ISR]) {
+    if (!s->regs[GEM_ISR]) {
+        /* ISR isn't set, clear all the interrupts */
+        for (i = 0; i < s->num_priority_queues; ++i) {
+            qemu_set_irq(s->irq[i], 0);
+        }
+        return;
+    }
+
+    /* If we get here we know s->regs[GEM_ISR] is set, so we don't need to
+     * check it again.
+     */
+    if (s->num_priority_queues == 1) {
         /* No priority queues, just trigger the interrupt */
         DB_PRINT("asserting int.\n");
         qemu_set_irq(s->irq[0], 1);
@@ -1274,7 +1285,6 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
 {
     CadenceGEMState *s;
     uint32_t retval;
-    int i;
     s = (CadenceGEMState *)opaque;
 
     offset >>= 2;
@@ -1285,9 +1295,7 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
     switch (offset) {
     case GEM_ISR:
         DB_PRINT("lowering irqs on ISR read\n");
-        for (i = 0; i < s->num_priority_queues; ++i) {
-            qemu_set_irq(s->irq[i], 0);
-        }
+        /* The interrupts get updated at the end of the function. */
         break;
     case GEM_PHYMNTNC:
         if (retval & GEM_PHYMNTNC_OP_R) {
-- 
2.9.3
