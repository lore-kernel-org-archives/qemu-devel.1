Received: from eggs.gnu.org ([2001:4830:134:3::10]:45735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dtdB1-00065r-1V
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 13:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dtdAz-0006Eo-QY
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 13:16:14 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 17 Sep 2017 18:15:48 +0100
Message-Id: <1505668548-16616-9-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 8/8] openpic: Fix problem when IRQ transitions
 from edge to level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, benh@kernel.crashing.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Some interrupts get triggered before the OS has setup the
right interrupt type. If an edge interrupt is latched that
way, not delivered (still masked), then the interrupt is
changed to level and isn't asserted anymore, it will be
stuck "pending", causing an interrupt flood. This can happen
with the PMU GPIO interrupt for example.

There are a few other corner cases like this, so let's keep
track of the input "level" so we can properly re-evaluate
when the trigger type changes.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 hw/intc/openpic.c |   32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index debfcbf..34749f8 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -236,6 +236,7 @@ typedef struct IRQSource {
     int last_cpu;
     int output;     /* IRQ level, e.g. OPENPIC_OUTPUT_INT */
     int pending;    /* TRUE if IRQ is pending */
+    int cur_level;  /* Cache current level */
     IRQType type;
     bool level:1;   /* level-triggered */
     bool nomask:1;  /* critical interrupts ignore mask on some FSL MPICs */
@@ -552,14 +553,26 @@ static void openpic_set_irq(void *opaque, int n_IRQ, int level)
     }
 
     src = &opp->src[n_IRQ];
-    DPRINTF("openpic: set irq %d = %d ivpr=0x%08x\n",
-            n_IRQ, level, src->ivpr);
+    DPRINTF("openpic: set irq %d = %d ivpr=0x%08x (l=%d,cl=%d)\n",
+            n_IRQ, level, src->ivpr, src->level, src->cur_level);
+
+    /* Keep track of the current input level in order to properly deal
+     * with the configuration of the source changing from edge to level
+     * after it's been latched. Otherwise the interrupt can get stuck.
+     */
+    src->cur_level = level;
+
     if (src->level) {
-        /* level-sensitive irq */
         src->pending = level;
         openpic_update_irq(opp, n_IRQ);
     } else {
-        /* edge-sensitive irq */
+        /* edge-sensitive irq
+         *
+         * In an ideal world we would only set pending on an "edge", ie
+         * if level is set and src->cur_level as clear. However that would
+         * require all the devices to properly send "pulses" rather than
+         * just "raise" which isn't the case today.
+         */
         if (level) {
             src->pending = 1;
             openpic_update_irq(opp, n_IRQ);
@@ -676,6 +689,13 @@ static inline void write_IRQreg_ivpr(OpenPICState *opp, int n_IRQ, uint32_t val)
     switch (opp->src[n_IRQ].type) {
     case IRQ_TYPE_NORMAL:
         opp->src[n_IRQ].level = !!(opp->src[n_IRQ].ivpr & IVPR_SENSE_MASK);
+
+        /* If we switched to level we need to re-evaluate "pending" based
+         * on the actual input state.
+         */
+        if (opp->src[n_IRQ].level) {
+            opp->src[n_IRQ].pending = opp->src[n_IRQ].cur_level;
+        }
         break;
 
     case IRQ_TYPE_FSLINT:
@@ -687,6 +707,7 @@ static inline void write_IRQreg_ivpr(OpenPICState *opp, int n_IRQ, uint32_t val)
         break;
     }
 
+    /* Re-evaluate a level irq */
     openpic_update_irq(opp, n_IRQ);
     DPRINTF("Set IVPR %d to 0x%08x -> 0x%08x\n", n_IRQ, val,
             opp->src[n_IRQ].ivpr);
@@ -1232,7 +1253,7 @@ static uint32_t openpic_iack(OpenPICState *opp, IRQDest *dst, int cpu)
     }
 
     if (!src->level) {
-        /* edge-sensitive IRQ */
+        /* edge-sensitive IRQ or level dropped */
         src->ivpr &= ~IVPR_ACTIVITY_MASK;
         src->pending = 0;
         IRQ_resetbit(&dst->raised, irq);
@@ -1564,6 +1585,7 @@ static const VMStateDescription vmstate_openpic_irqsource = {
         VMSTATE_UINT32(destmask, IRQSource),
         VMSTATE_INT32(last_cpu, IRQSource),
         VMSTATE_INT32(pending, IRQSource),
+        VMSTATE_INT32(cur_level, IRQSource),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
1.7.10.4
