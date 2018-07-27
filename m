Received: from eggs.gnu.org ([2001:4830:134:3::10]:58290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSi-0003ng-W5
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSg-0006KH-B1
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:04 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 27 Jul 2018 11:54:13 +0200
Message-Id: <20180727095421.386-13-luc.michel@greensocs.com>
In-Reply-To: <20180727095421.386-1-luc.michel@greensocs.com>
References: <20180727095421.386-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v5 12/20] intc/arm_gic: Implement
 virtualization extensions in gic_(deactivate|complete_irq)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com, Jan Kiszka <jan.kiszka@web.de>

Implement virtualization extensions in the gic_deactivate_irq() and
gic_complete_irq() functions.

When the guest writes an invalid vIRQ to V_EOIR or V_DIR, since the
GICv2 specification is not entirely clear here, we adopt the behaviour
observed on real hardware:
  * When V_CTRL.EOIMode is false (EOI split is disabled):
    - In case of an invalid vIRQ write to V_EOIR:
      -> If some bits are set in H_APR, an invalid vIRQ write to V_EOIR
         triggers a priority drop, and increments V_HCR.EOICount.
      -> If V_APR is already cleared, nothing happen

    - An invalid vIRQ write to V_DIR is ignored.

  * When V_CTRL.EOIMode is true:
    - In case of an invalid vIRQ write to V_EOIR:
      -> If some bits are set in H_APR, an invalid vIRQ write to V_EOIR
         triggers a priority drop.
      -> If V_APR is already cleared, nothing happen

    - An invalid vIRQ write to V_DIR increments V_HCR.EOICount.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 hw/intc/arm_gic.c | 51 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index d80acde989..3cddf65826 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -581,31 +581,41 @@ static bool gic_eoi_split(GICState *s, int cpu, MemTxAttrs attrs)
 
 static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
 {
     int group;
 
-    if (irq >= s->num_irq) {
+    if (irq >= GIC_MAXIRQ || (!gic_is_vcpu(cpu) && irq >= s->num_irq)) {
         /*
          * This handles two cases:
          * 1. If software writes the ID of a spurious interrupt [ie 1023]
          * to the GICC_DIR, the GIC ignores that write.
          * 2. If software writes the number of a non-existent interrupt
          * this must be a subcase of "value written is not an active interrupt"
-         * and so this is UNPREDICTABLE. We choose to ignore it.
+         * and so this is UNPREDICTABLE. We choose to ignore it. For vCPUs,
+         * all IRQs potentially exist, so this limit does not apply.
          */
         return;
     }
 
-    group = gic_has_groups(s) && gic_test_group(s, irq, cpu);
-
     if (!gic_eoi_split(s, cpu, attrs)) {
         /* This is UNPREDICTABLE; we choose to ignore it */
         qemu_log_mask(LOG_GUEST_ERROR,
                       "gic_deactivate_irq: GICC_DIR write when EOIMode clear");
         return;
     }
 
+    if (gic_is_vcpu(cpu) && !gic_virq_is_valid(s, irq, cpu)) {
+        /* This vIRQ does not have an LR entry which is either active or
+         * pending and active. Increment EOICount and ignore the write.
+         */
+        int rcpu = gic_get_vcpu_real_id(cpu);
+        s->h_hcr[rcpu] += 1 << R_GICH_HCR_EOICount_SHIFT;
+        return;
+    }
+
+    group = gic_has_groups(s) && gic_test_group(s, irq, cpu);
+
     if (gic_cpu_ns_access(s, cpu, attrs) && !group) {
         DPRINTF("Non-secure DI for Group0 interrupt %d ignored\n", irq);
         return;
     }
 
@@ -616,10 +626,43 @@ static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
 {
     int cm = 1 << cpu;
     int group;
 
     DPRINTF("EOI %d\n", irq);
+    if (gic_is_vcpu(cpu)) {
+        /* The call to gic_prio_drop() will clear a bit in GICH_APR iff the
+         * running prio is < 0x100.
+         */
+        bool prio_drop = s->running_priority[cpu] < 0x100;
+
+        if (irq >= GIC_MAXIRQ) {
+            /* Ignore spurious interrupt */
+            return;
+        }
+
+        gic_drop_prio(s, cpu, 0);
+
+        if (!gic_eoi_split(s, cpu, attrs)) {
+            bool valid = gic_virq_is_valid(s, irq, cpu);
+            if (prio_drop && !valid) {
+                /* We are in a situation where:
+                 *   - V_CTRL.EOIMode is false (no EOI split),
+                 *   - The call to gic_drop_prio() cleared a bit in GICH_APR,
+                 *   - This vIRQ does not have an LR entry which is either
+                 *     active or pending and active.
+                 * In that case, we must increment EOICount.
+                 */
+                int rcpu = gic_get_vcpu_real_id(cpu);
+                s->h_hcr[rcpu] += 1 << R_GICH_HCR_EOICount_SHIFT;
+            } else if (valid) {
+                gic_clear_active(s, irq, cpu);
+            }
+        }
+
+        return;
+    }
+
     if (irq >= s->num_irq) {
         /* This handles two cases:
          * 1. If software writes the ID of a spurious interrupt [ie 1023]
          * to the GICC_EOIR, the GIC ignores that write.
          * 2. If software writes the number of a non-existent interrupt
-- 
2.18.0
