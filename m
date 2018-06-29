Received: from eggs.gnu.org ([2001:4830:134:3::10]:38124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fYtUH-0007he-EA
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fYtUC-0007HG-8w
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:30:57 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 29 Jun 2018 15:29:44 +0200
Message-Id: <20180629132954.24269-11-luc.michel@greensocs.com>
In-Reply-To: <20180629132954.24269-1-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v3 10/20] intc/arm_gic: Implement
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
---
 hw/intc/arm_gic.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index d55a88bb33..d61c2dd557 100644
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
@@ -296,12 +303,22 @@ static int gic_get_prio_from_apr_bits(GICState *s, int cpu)
      * on the set bits in the Active Priority Registers.
      */
     int i;
-    for (i = 0; i < GIC_NR_APRS; i++) {
-        uint32_t apr = s->apr[i][cpu] | s->nsapr[i][cpu];
+    int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
+    int nr_aprs = gic_is_vcpu(cpu) ? GIC_VIRT_NR_APRS : GIC_NR_APRS;
+
+    for (i = 0; i < nr_aprs; i++) {
+        uint32_t apr;
+
+        if (gic_is_vcpu(cpu)) {
+            apr = s->h_apr[gic_get_vcpu_real_id(cpu)];
+        } else {
+            apr = s->apr[i][cpu] | s->nsapr[i][cpu];
+        }
+
         if (!apr) {
             continue;
         }
-        return (i * 32 + ctz32(apr)) << (GIC_MIN_BPR + 1);
+        return (i * 32 + ctz32(apr)) << (min_bpr + 1);
     }
     return 0x100;
 }
@@ -325,9 +342,19 @@ static void gic_drop_prio(GICState *s, int cpu, int group)
      * might not do so, and interrupts that should not preempt might do so.
      */
     int i;
+    int nr_aprs = gic_is_vcpu(cpu) ? GIC_VIRT_NR_APRS : GIC_NR_APRS;
+
+    for (i = 0; i < nr_aprs; i++) {
+        uint32_t *papr = NULL;
+
+        if (gic_is_vcpu(cpu)) {
+            papr = &s->h_apr[gic_get_vcpu_real_id(cpu)];
+        } else if (group) {
+            papr = &s->nsapr[i][cpu];
+        } else {
+            papr = &s->apr[i][cpu];
+        }
 
-    for (i = 0; i < GIC_NR_APRS; i++) {
-        uint32_t *papr = group ? &s->nsapr[i][cpu] : &s->apr[i][cpu];
         if (!*papr) {
             continue;
         }
-- 
2.17.1
