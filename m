Received: from eggs.gnu.org ([2001:4830:134:3::10]:38115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fYtUH-0007hd-CL
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fYtUD-0007LC-Ih
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:30:57 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 29 Jun 2018 15:29:51 +0200
Message-Id: <20180629132954.24269-18-luc.michel@greensocs.com>
In-Reply-To: <20180629132954.24269-1-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v3 17/20] intc/arm_gic: Implement maintenance
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
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com, Jan Kiszka <jan.kiszka@web.de>

Implement the maintenance interrupt generation that is part of the GICv2
virtualization extensions.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 hw/intc/arm_gic.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index a3ff4b89d1..10300e9b4c 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -206,6 +206,94 @@ static inline void gic_update_internal(GICState *s, bool virt)
     }
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
+    int val;
+    int vcpu = cpu + GIC_NCPU;
+
+    int num_eoi, num_valid, num_pending;
+
+    gic_extract_lr_info(s, cpu, &num_eoi, &num_valid, &num_pending);
+
+    /* EOI */
+    val = (num_eoi != 0);
+    s->h_misr[cpu] = FIELD_DP32(0, GICH_MISR, EOI, val);
+
+    /* U: true if only 0 or 1 LR entry is valid */
+    val = s->h_hcr[cpu] & R_GICH_HCR_UIE_MASK &&
+        (num_valid < 2);
+    s->h_misr[cpu] = FIELD_DP32(s->h_misr[cpu], GICH_MISR, U, val);
+
+    /* LRENP: EOICount is not 0 */
+    val = s->h_hcr[cpu] & R_GICH_HCR_LRENPIE_MASK &&
+        ((s->h_hcr[cpu] & R_GICH_HCR_EOICount_MASK) != 0);
+    s->h_misr[cpu] = FIELD_DP32(s->h_misr[cpu], GICH_MISR, LRENP, val);
+
+    /* NP: no pending interrupts */
+    val = s->h_hcr[cpu] & R_GICH_HCR_NPIE_MASK &&
+        (num_pending == 0);
+    s->h_misr[cpu] = FIELD_DP32(s->h_misr[cpu], GICH_MISR, NP, val);
+
+    /* VGrp0E: group0 virq signaling enabled */
+    val = s->h_hcr[cpu] & R_GICH_HCR_VGRP0EIE_MASK &&
+        (s->cpu_ctlr[vcpu] & GICC_CTLR_EN_GRP0);
+    s->h_misr[cpu] = FIELD_DP32(s->h_misr[cpu], GICH_MISR, VGrp0E, val);
+
+    /* VGrp0D: group0 virq signaling disabled */
+    val = s->h_hcr[cpu] & R_GICH_HCR_VGRP0DIE_MASK &&
+        !(s->cpu_ctlr[vcpu] & GICC_CTLR_EN_GRP0);
+    s->h_misr[cpu] = FIELD_DP32(s->h_misr[cpu], GICH_MISR, VGrp0D, val);
+
+    /* VGrp1E: group1 virq signaling enabled */
+    val = s->h_hcr[cpu] & R_GICH_HCR_VGRP1EIE_MASK &&
+        (s->cpu_ctlr[vcpu] & GICC_CTLR_EN_GRP1);
+    s->h_misr[cpu] = FIELD_DP32(s->h_misr[cpu], GICH_MISR, VGrp1E, val);
+
+    /* VGrp1D: group1 virq signaling disabled */
+    val = s->h_hcr[cpu] & R_GICH_HCR_VGRP1DIE_MASK &&
+        !(s->cpu_ctlr[vcpu] & GICC_CTLR_EN_GRP1);
+    s->h_misr[cpu] = FIELD_DP32(s->h_misr[cpu], GICH_MISR, VGrp1D, val);
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
 static void gic_update(GICState *s)
 {
     gic_update_internal(s, false);
@@ -214,6 +302,7 @@ static void gic_update(GICState *s)
 static void gic_update_virt(GICState *s)
 {
     gic_update_internal(s, true);
+    gic_update_maintenance(s);
 }
 
 static void gic_set_irq_11mpcore(GICState *s, int irq, int level,
-- 
2.17.1
