Received: from eggs.gnu.org ([2001:4830:134:3::10]:58400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSm-0003vf-BH
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSi-0006NI-Do
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:08 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 27 Jul 2018 11:54:11 +0200
Message-Id: <20180727095421.386-11-luc.michel@greensocs.com>
In-Reply-To: <20180727095421.386-1-luc.michel@greensocs.com>
References: <20180727095421.386-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v5 10/20] intc/arm_gic: Implement
 virtualization extensions in gic_(activate_irq|drop_prio)
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

Implement virtualization extensions in gic_activate_irq() and
gic_drop_prio() and in gic_get_prio_from_apr_bits() called by
gic_drop_prio().

When the current CPU is a vCPU:
  - Use GIC_VIRT_MIN_BPR and GIC_VIRT_NR_APRS instead of their non-virt
  counterparts,
  - the vCPU APR is stored in the virtual interface, in h_apr.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 50 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 26ed7ea58a..de73dc9f54 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -274,30 +274,47 @@ static void gic_activate_irq(GICState *s, int cpu, int irq)
 {
     /* Set the appropriate Active Priority Register bit for this IRQ,
      * and update the running priority.
      */
     int prio = gic_get_group_priority(s, cpu, irq);
-    int preemption_level = prio >> (GIC_MIN_BPR + 1);
+    int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
+    int preemption_level = prio >> (min_bpr + 1);
     int regno = preemption_level / 32;
     int bitno = preemption_level % 32;
+    uint32_t *papr = NULL;
 
-    if (gic_has_groups(s) && gic_test_group(s, irq, cpu)) {
-        s->nsapr[regno][cpu] |= (1 << bitno);
+    if (gic_is_vcpu(cpu)) {
+        assert(regno == 0);
+        papr = &s->h_apr[gic_get_vcpu_real_id(cpu)];
+    } else if (gic_has_groups(s) && gic_test_group(s, irq, cpu)) {
+        papr = &s->nsapr[regno][cpu];
     } else {
-        s->apr[regno][cpu] |= (1 << bitno);
+        papr = &s->apr[regno][cpu];
     }
 
+    *papr |= (1 << bitno);
+
     s->running_priority[cpu] = prio;
     gic_set_active(s, irq, cpu);
 }
 
 static int gic_get_prio_from_apr_bits(GICState *s, int cpu)
 {
     /* Recalculate the current running priority for this CPU based
      * on the set bits in the Active Priority Registers.
      */
     int i;
+
+    if (gic_is_vcpu(cpu)) {
+        uint32_t apr = s->h_apr[gic_get_vcpu_real_id(cpu)];
+        if (apr) {
+            return ctz32(apr) << (GIC_VIRT_MIN_BPR + 1);
+        } else {
+            return 0x100;
+        }
+    }
+
     for (i = 0; i < GIC_NR_APRS; i++) {
         uint32_t apr = s->apr[i][cpu] | s->nsapr[i][cpu];
         if (!apr) {
             continue;
         }
@@ -322,20 +339,29 @@ static void gic_drop_prio(GICState *s, int cpu, int group)
      * behaviour of the GIC is UNPREDICTABLE, which for us means that
      * the values of the APR registers might become incorrect and the
      * running priority will be wrong, so interrupts that should preempt
      * might not do so, and interrupts that should not preempt might do so.
      */
-    int i;
+    if (gic_is_vcpu(cpu)) {
+        int rcpu = gic_get_vcpu_real_id(cpu);
 
-    for (i = 0; i < GIC_NR_APRS; i++) {
-        uint32_t *papr = group ? &s->nsapr[i][cpu] : &s->apr[i][cpu];
-        if (!*papr) {
-            continue;
+        if (s->h_apr[rcpu]) {
+            /* Clear lowest set bit */
+            s->h_apr[rcpu] &= s->h_apr[rcpu] - 1;
+        }
+    } else {
+        int i;
+
+        for (i = 0; i < GIC_NR_APRS; i++) {
+            uint32_t *papr = group ? &s->nsapr[i][cpu] : &s->apr[i][cpu];
+            if (!*papr) {
+                continue;
+            }
+            /* Clear lowest set bit */
+            *papr &= *papr - 1;
+            break;
         }
-        /* Clear lowest set bit */
-        *papr &= *papr - 1;
-        break;
     }
 
     s->running_priority[cpu] = gic_get_prio_from_apr_bits(s, cpu);
 }
 
-- 
2.18.0
