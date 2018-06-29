Received: from eggs.gnu.org ([2001:4830:134:3::10]:38112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fYtUH-0007hb-BT
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fYtUC-0007Il-Ms
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:30:57 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 29 Jun 2018 15:29:41 +0200
Message-Id: <20180629132954.24269-8-luc.michel@greensocs.com>
In-Reply-To: <20180629132954.24269-1-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v3 07/20] intc/arm_gic: Add virtualization
 extensions helper macros and functions
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

Add some helper macros and functions related to the virtualization
extensions to gic_internal.h.

The GICH_LR_* macros help extracting specific fields of a list register
value. The only tricky one is the priority field as only the MSB are
stored. The value must be shifted accordingly to obtain the correct
priority value.

gic_is_vcpu() and gic_get_vcpu_real_id() help with (v)CPU id manipulation
to abstract the fact that vCPU id are in the range
[ GIC_NCPU; (GIC_NCPU + num_cpu) [.

gic_lr_* and gic_virq_is_valid() help with the list registers.
gic_get_lr_entry() tries to find the LR entry for a given (vCPU, irq)
pair. gic_get_lr_entry_nofail() is meant to be used in contexts where we
know for sure that the entry exists, so we can avoid the NULL check on
the returned pointer.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 hw/intc/arm_gic.c      |  5 ++++
 hw/intc/gic_internal.h | 65 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index b2dd379bd2..f25d1b1270 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -61,6 +61,11 @@ static inline int gic_get_current_cpu(GICState *s)
     return 0;
 }
 
+static inline int gic_get_current_vcpu(GICState *s)
+{
+    return gic_get_current_cpu(s) + GIC_NCPU;
+}
+
 /* Return true if this GIC config has interrupt groups, which is
  * true if we're a GICv2, or a GICv1 with the security extensions.
  */
diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
index 1aa888a576..4242a16bd4 100644
--- a/hw/intc/gic_internal.h
+++ b/hw/intc/gic_internal.h
@@ -129,6 +129,20 @@ REG32(GICH_LR63, 0x1fc)
      R_GICH_LR0_Priority_MASK | R_GICH_LR0_State_MASK | \
      R_GICH_LR0_Grp1_MASK | R_GICH_LR0_HW_MASK)
 
+#define GICH_LR_STATE_INVALID         0
+#define GICH_LR_STATE_PENDING         1
+#define GICH_LR_STATE_ACTIVE          2
+#define GICH_LR_STATE_ACTIVE_PENDING  3
+
+#define GICH_LR_VIRT_ID(entry) (FIELD_EX32(entry, GICH_LR0, VirtualID))
+#define GICH_LR_PHYS_ID(entry) (FIELD_EX32(entry, GICH_LR0, PhysicalID))
+#define GICH_LR_CPUID(entry) (FIELD_EX32(entry, GICH_LR0, CPUID))
+#define GICH_LR_EOI(entry) (FIELD_EX32(entry, GICH_LR0, EOI))
+#define GICH_LR_PRIORITY(entry) (FIELD_EX32(entry, GICH_LR0, Priority) << 3)
+#define GICH_LR_STATE(entry) (FIELD_EX32(entry, GICH_LR0, State))
+#define GICH_LR_GROUP(entry) (FIELD_EX32(entry, GICH_LR0, Grp1))
+#define GICH_LR_HW(entry) (FIELD_EX32(entry, GICH_LR0, HW))
+
 /* Valid bits for GICC_CTLR for GICv1, v1 with security extensions,
  * GICv2 and GICv2 with security extensions:
  */
@@ -164,4 +178,55 @@ static inline bool gic_is_vcpu(int cpu)
     return cpu >= GIC_NCPU;
 }
 
+static inline int gic_get_vcpu_real_id(int cpu)
+{
+    return (cpu >= GIC_NCPU) ? (cpu - GIC_NCPU) : cpu;
+}
+
+static inline bool gic_lr_entry_is_free(uint32_t entry)
+{
+    return (GICH_LR_STATE(entry) == GICH_LR_STATE_INVALID)
+        && (GICH_LR_HW(entry) || !GICH_LR_EOI(entry));
+}
+
+static inline bool gic_lr_entry_is_eoi(uint32_t entry)
+{
+    return (GICH_LR_STATE(entry) == GICH_LR_STATE_INVALID)
+        && !GICH_LR_HW(entry) && GICH_LR_EOI(entry);
+}
+
+/* Return a pointer on the LR entry for a given (irq,vcpu) pair.
+ * Having multiple LRs with the same VirtualID leads to UNPREDICTABLE
+ * behaviour in the GIC. We choose to return the first one that matches.
+ */
+static inline uint32_t *gic_get_lr_entry(GICState *s, int irq, int vcpu)
+{
+    int cpu = gic_get_vcpu_real_id(vcpu);
+    int lr_idx;
+
+    for (lr_idx = 0; lr_idx < s->num_lrs; lr_idx++) {
+        uint32_t *entry = &s->h_lr[lr_idx][cpu];
+
+        if ((GICH_LR_VIRT_ID(*entry) == irq) &&
+            (!gic_lr_entry_is_free(*entry))) {
+            return entry;
+        }
+    }
+
+    return NULL;
+}
+
+static inline bool gic_virq_is_valid(GICState *s, int irq, int vcpu)
+{
+    return gic_get_lr_entry(s, irq, vcpu) != NULL;
+}
+
+static inline uint32_t *gic_get_lr_entry_nofail(GICState *s, int irq, int vcpu)
+{
+    uint32_t *entry = gic_get_lr_entry(s, irq, vcpu);
+    assert(entry);
+
+    return entry;
+}
+
 #endif /* QEMU_ARM_GIC_INTERNAL_H */
-- 
2.17.1
