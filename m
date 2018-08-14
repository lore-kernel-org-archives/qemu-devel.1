Received: from eggs.gnu.org ([2001:4830:134:3::10]:52585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdvK-0004mZ-QJ
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdu0-0006ge-Tu
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdu0-0006gE-JI
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:44 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtz-0007H6-Ee
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:43 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:52 +0100
Message-Id: <20180814181815.23348-23-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 22/45] intc/arm_gic: Implement virtualization
 extensions in gic_acknowledge_irq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Luc Michel <luc.michel@greensocs.com>

Implement virtualization extensions in the gic_acknowledge_irq()
function. This function changes the state of the highest priority IRQ
from pending to active.

When the current CPU is a vCPU, modifying the state of an IRQ modifies
the corresponding LR entry. However if we clear the pending flag before
setting the active one, we lose track of the LR entry as it becomes
invalid. The next call to gic_get_lr_entry() will fail.

To overcome this issue, we call gic_activate_irq() before
gic_clear_pending(). This does not change the general behaviour of
gic_acknowledge_irq.

We also move the SGI case in gic_clear_pending_sgi() to enhance
code readability as the virtualization extensions support adds a if-else
level.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180727095421.386-12-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 52 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index de73dc9f54b..d80acde989f 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -365,17 +365,44 @@ static void gic_drop_prio(GICState *s, int cpu, int group)
     s->running_priority[cpu] = gic_get_prio_from_apr_bits(s, cpu);
 }
 
+static inline uint32_t gic_clear_pending_sgi(GICState *s, int irq, int cpu)
+{
+    int src;
+    uint32_t ret;
+
+    if (!gic_is_vcpu(cpu)) {
+        /* Lookup the source CPU for the SGI and clear this in the
+         * sgi_pending map.  Return the src and clear the overall pending
+         * state on this CPU if the SGI is not pending from any CPUs.
+         */
+        assert(s->sgi_pending[irq][cpu] != 0);
+        src = ctz32(s->sgi_pending[irq][cpu]);
+        s->sgi_pending[irq][cpu] &= ~(1 << src);
+        if (s->sgi_pending[irq][cpu] == 0) {
+            gic_clear_pending(s, irq, cpu);
+        }
+        ret = irq | ((src & 0x7) << 10);
+    } else {
+        uint32_t *lr_entry = gic_get_lr_entry(s, irq, cpu);
+        src = GICH_LR_CPUID(*lr_entry);
+
+        gic_clear_pending(s, irq, cpu);
+        ret = irq | (src << 10);
+    }
+
+    return ret;
+}
+
 uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
 {
-    int ret, irq, src;
-    int cm = 1 << cpu;
+    int ret, irq;
 
     /* gic_get_current_pending_irq() will return 1022 or 1023 appropriately
      * for the case where this GIC supports grouping and the pending interrupt
      * is in the wrong group.
      */
     irq = gic_get_current_pending_irq(s, cpu, attrs);
-    trace_gic_acknowledge_irq(cpu, irq);
+    trace_gic_acknowledge_irq(gic_get_vcpu_real_id(cpu), irq);
 
     if (irq >= GIC_MAXIRQ) {
         DPRINTF("ACK, no pending interrupt or it is hidden: %d\n", irq);
@@ -387,6 +414,8 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
         return 1023;
     }
 
+    gic_activate_irq(s, cpu, irq);
+
     if (s->revision == REV_11MPCORE) {
         /* Clear pending flags for both level and edge triggered interrupts.
          * Level triggered IRQs will be reasserted once they become inactive.
@@ -395,28 +424,13 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
         ret = irq;
     } else {
         if (irq < GIC_NR_SGIS) {
-            /* Lookup the source CPU for the SGI and clear this in the
-             * sgi_pending map.  Return the src and clear the overall pending
-             * state on this CPU if the SGI is not pending from any CPUs.
-             */
-            assert(s->sgi_pending[irq][cpu] != 0);
-            src = ctz32(s->sgi_pending[irq][cpu]);
-            s->sgi_pending[irq][cpu] &= ~(1 << src);
-            if (s->sgi_pending[irq][cpu] == 0) {
-                gic_clear_pending(s, irq, cpu);
-            }
-            ret = irq | ((src & 0x7) << 10);
+            ret = gic_clear_pending_sgi(s, irq, cpu);
         } else {
-            /* Clear pending state for both level and edge triggered
-             * interrupts. (level triggered interrupts with an active line
-             * remain pending, see gic_test_pending)
-             */
             gic_clear_pending(s, irq, cpu);
             ret = irq;
         }
     }
 
-    gic_activate_irq(s, cpu, irq);
     gic_update(s);
     DPRINTF("ACK %d\n", irq);
     return ret;
-- 
2.18.0
