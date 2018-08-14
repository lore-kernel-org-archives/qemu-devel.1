Received: from eggs.gnu.org ([2001:4830:134:3::10]:52702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdvZ-0004xc-4T
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdu7-0006kL-RK
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:20 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdu6-0006h8-Os
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:50 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdu5-0007JN-38
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:49 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:58 +0100
Message-Id: <20180814181815.23348-29-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 28/45] intc/arm_gic: Implement maintenance
 interrupt generation
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

Implement the maintenance interrupt generation that is part of the GICv2
virtualization extensions.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180727095421.386-18-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 6b97e197966..6ff7da3e5d3 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -240,9 +240,106 @@ static inline bool gic_lr_entry_is_eoi(uint32_t entry)
         && !GICH_LR_HW(entry) && GICH_LR_EOI(entry);
 }
 
+static inline void gic_extract_lr_info(GICState *s, int cpu,
+                                int *num_eoi, int *num_valid, int *num_pending)
+{
+    int lr_idx;
+
+    *num_eoi = 0;
+    *num_valid = 0;
+    *num_pending = 0;
+
+    for (lr_idx = 0; lr_idx < s->num_lrs; lr_idx++) {
+        uint32_t *entry = &s->h_lr[lr_idx][cpu];
+
+        if (gic_lr_entry_is_eoi(*entry)) {
+            (*num_eoi)++;
+        }
+
+        if (GICH_LR_STATE(*entry) != GICH_LR_STATE_INVALID) {
+            (*num_valid)++;
+        }
+
+        if (GICH_LR_STATE(*entry) == GICH_LR_STATE_PENDING) {
+            (*num_pending)++;
+        }
+    }
+}
+
+static void gic_compute_misr(GICState *s, int cpu)
+{
+    uint32_t value = 0;
+    int vcpu = cpu + GIC_NCPU;
+
+    int num_eoi, num_valid, num_pending;
+
+    gic_extract_lr_info(s, cpu, &num_eoi, &num_valid, &num_pending);
+
+    /* EOI */
+    if (num_eoi) {
+        value |= R_GICH_MISR_EOI_MASK;
+    }
+
+    /* U: true if only 0 or 1 LR entry is valid */
+    if ((s->h_hcr[cpu] & R_GICH_HCR_UIE_MASK) && (num_valid < 2)) {
+        value |= R_GICH_MISR_U_MASK;
+    }
+
+    /* LRENP: EOICount is not 0 */
+    if ((s->h_hcr[cpu] & R_GICH_HCR_LRENPIE_MASK) &&
+        ((s->h_hcr[cpu] & R_GICH_HCR_EOICount_MASK) != 0)) {
+        value |= R_GICH_MISR_LRENP_MASK;
+    }
+
+    /* NP: no pending interrupts */
+    if ((s->h_hcr[cpu] & R_GICH_HCR_NPIE_MASK) && (num_pending == 0)) {
+        value |= R_GICH_MISR_NP_MASK;
+    }
+
+    /* VGrp0E: group0 virq signaling enabled */
+    if ((s->h_hcr[cpu] & R_GICH_HCR_VGRP0EIE_MASK) &&
+        (s->cpu_ctlr[vcpu] & GICC_CTLR_EN_GRP0)) {
+        value |= R_GICH_MISR_VGrp0E_MASK;
+    }
+
+    /* VGrp0D: group0 virq signaling disabled */
+    if ((s->h_hcr[cpu] & R_GICH_HCR_VGRP0DIE_MASK) &&
+        !(s->cpu_ctlr[vcpu] & GICC_CTLR_EN_GRP0)) {
+        value |= R_GICH_MISR_VGrp0D_MASK;
+    }
+
+    /* VGrp1E: group1 virq signaling enabled */
+    if ((s->h_hcr[cpu] & R_GICH_HCR_VGRP1EIE_MASK) &&
+        (s->cpu_ctlr[vcpu] & GICC_CTLR_EN_GRP1)) {
+        value |= R_GICH_MISR_VGrp1E_MASK;
+    }
+
+    /* VGrp1D: group1 virq signaling disabled */
+    if ((s->h_hcr[cpu] & R_GICH_HCR_VGRP1DIE_MASK) &&
+        !(s->cpu_ctlr[vcpu] & GICC_CTLR_EN_GRP1)) {
+        value |= R_GICH_MISR_VGrp1D_MASK;
+    }
+
+    s->h_misr[cpu] = value;
+}
+
+static void gic_update_maintenance(GICState *s)
+{
+    int cpu = 0;
+    int maint_level;
+
+    for (cpu = 0; cpu < s->num_cpu; cpu++) {
+        gic_compute_misr(s, cpu);
+        maint_level = (s->h_hcr[cpu] & R_GICH_HCR_EN_MASK) && s->h_misr[cpu];
+
+        qemu_set_irq(s->maintenance_irq[cpu], maint_level);
+    }
+}
+
 static void gic_update_virt(GICState *s)
 {
     gic_update_internal(s, true);
+    gic_update_maintenance(s);
 }
 
 static void gic_set_irq_11mpcore(GICState *s, int irq, int level,
-- 
2.18.0
