Received: from eggs.gnu.org ([2001:4830:134:3::10]:52589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdvL-0004ml-22
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtz-0006g6-8j
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdty-0006eo-Vz
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:43 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtx-0007GR-Mx
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:41 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:51 +0100
Message-Id: <20180814181815.23348-22-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 21/45] intc/arm_gic: Implement virtualization
 extensions in gic_(activate_irq|drop_prio)
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

Implement virtualization extensions in gic_activate_irq() and
gic_drop_prio() and in gic_get_prio_from_apr_bits() called by
gic_drop_prio().

When the current CPU is a vCPU:
  - Use GIC_VIRT_MIN_BPR and GIC_VIRT_NR_APRS instead of their non-virt
  counterparts,
  - the vCPU APR is stored in the virtual interface, in h_apr.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180727095421.386-11-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 50 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 26ed7ea58ab..de73dc9f54b 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -276,16 +276,23 @@ static void gic_activate_irq(GICState *s, int cpu, int irq)
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
@@ -296,6 +303,16 @@ static int gic_get_prio_from_apr_bits(GICState *s, int cpu)
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
@@ -324,16 +341,25 @@ static void gic_drop_prio(GICState *s, int cpu, int group)
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
-- 
2.18.0
