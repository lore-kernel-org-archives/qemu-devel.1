Received: from eggs.gnu.org ([2001:4830:134:3::10]:58499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSr-000462-Vf
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSp-0006Xg-PO
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:14 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 27 Jul 2018 11:54:06 +0200
Message-Id: <20180727095421.386-6-luc.michel@greensocs.com>
In-Reply-To: <20180727095421.386-1-luc.michel@greensocs.com>
References: <20180727095421.386-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v5 05/20] intc/arm_gic: Add the virtualization
 extensions to the GIC state
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

Add the necessary parts of the virtualization extensions state to the
GIC state. We choose to increase the size of the CPU interfaces state to
add space for the vCPU interfaces (the GIC_NCPU_VCPU macro). This way,
we'll be able to reuse most of the CPU interface code for the vCPUs.

The only exception is the APR value, which is stored in h_apr in the
virtual interface state for vCPUs. This is due to some complications
with the GIC VMState, for which we don't want to break backward
compatibility. APRs being stored in 2D arrays, increasing the second
dimension would lead to some ugly VMState description. To avoid
that, we keep it in h_apr for vCPUs.

The vCPUs are numbered from GIC_NCPU to (GIC_NCPU * 2) - 1. The
`gic_is_vcpu` function help to determine if a given CPU id correspond to
a physical CPU or a virtual one.

For the in-kernel KVM VGIC, since the exposed VGIC does not implement
the virtualization extensions, we report an error if the corresponding
property is set to true.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c                |   2 +-
 hw/intc/arm_gic_common.c         | 148 ++++++++++++++++++++++++++-----
 hw/intc/arm_gic_kvm.c            |   8 +-
 hw/intc/gic_internal.h           |   5 ++
 include/hw/intc/arm_gic_common.h |  43 +++++++--
 5 files changed, 173 insertions(+), 33 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index b8eba6e594..5231579985 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1495,11 +1495,11 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
                          "host kernel supports KVM_CAP_ARM_USER_IRQ");
         return;
     }
 
     /* This creates distributor and main CPU interface (s->cpuiomem[0]) */
-    gic_init_irqs_and_mmio(s, gic_set_irq, gic_ops);
+    gic_init_irqs_and_mmio(s, gic_set_irq, gic_ops, NULL);
 
     /* Extra core-specific regions for the CPU interfaces. This is
      * necessary for "franken-GIC" implementations, for example on
      * Exynos 4.
      * NB that the memory region size of 0x100 applies for the 11MPCore
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 295ee9cc5e..547dc41185 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -44,10 +44,17 @@ static int gic_post_load(void *opaque, int version_id)
         c->post_load(s);
     }
     return 0;
 }
 
+static bool gic_virt_state_needed(void *opaque)
+{
+    GICState *s = (GICState *)opaque;
+
+    return s->virt_extn;
+}
+
 static const VMStateDescription vmstate_gic_irq_state = {
     .name = "arm_gic_irq_state",
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
@@ -60,38 +67,67 @@ static const VMStateDescription vmstate_gic_irq_state = {
         VMSTATE_UINT8(group, gic_irq_state),
         VMSTATE_END_OF_LIST()
     }
 };
 
+static const VMStateDescription vmstate_gic_virt_state = {
+    .name = "arm_gic_virt_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = gic_virt_state_needed,
+    .fields = (VMStateField[]) {
+        /* Virtual interface */
+        VMSTATE_UINT32_ARRAY(h_hcr, GICState, GIC_NCPU),
+        VMSTATE_UINT32_ARRAY(h_misr, GICState, GIC_NCPU),
+        VMSTATE_UINT32_2DARRAY(h_lr, GICState, GIC_MAX_LR, GIC_NCPU),
+        VMSTATE_UINT32_ARRAY(h_apr, GICState, GIC_NCPU),
+
+        /* Virtual CPU interfaces */
+        VMSTATE_UINT32_SUB_ARRAY(cpu_ctlr, GICState, GIC_NCPU, GIC_NCPU),
+        VMSTATE_UINT16_SUB_ARRAY(priority_mask, GICState, GIC_NCPU, GIC_NCPU),
+        VMSTATE_UINT16_SUB_ARRAY(running_priority, GICState, GIC_NCPU, GIC_NCPU),
+        VMSTATE_UINT16_SUB_ARRAY(current_pending, GICState, GIC_NCPU, GIC_NCPU),
+        VMSTATE_UINT8_SUB_ARRAY(bpr, GICState, GIC_NCPU, GIC_NCPU),
+        VMSTATE_UINT8_SUB_ARRAY(abpr, GICState, GIC_NCPU, GIC_NCPU),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_gic = {
     .name = "arm_gic",
     .version_id = 12,
     .minimum_version_id = 12,
     .pre_save = gic_pre_save,
     .post_load = gic_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(ctlr, GICState),
-        VMSTATE_UINT32_ARRAY(cpu_ctlr, GICState, GIC_NCPU),
+        VMSTATE_UINT32_SUB_ARRAY(cpu_ctlr, GICState, 0, GIC_NCPU),
         VMSTATE_STRUCT_ARRAY(irq_state, GICState, GIC_MAXIRQ, 1,
                              vmstate_gic_irq_state, gic_irq_state),
         VMSTATE_UINT8_ARRAY(irq_target, GICState, GIC_MAXIRQ),
         VMSTATE_UINT8_2DARRAY(priority1, GICState, GIC_INTERNAL, GIC_NCPU),
         VMSTATE_UINT8_ARRAY(priority2, GICState, GIC_MAXIRQ - GIC_INTERNAL),
         VMSTATE_UINT8_2DARRAY(sgi_pending, GICState, GIC_NR_SGIS, GIC_NCPU),
-        VMSTATE_UINT16_ARRAY(priority_mask, GICState, GIC_NCPU),
-        VMSTATE_UINT16_ARRAY(running_priority, GICState, GIC_NCPU),
-        VMSTATE_UINT16_ARRAY(current_pending, GICState, GIC_NCPU),
-        VMSTATE_UINT8_ARRAY(bpr, GICState, GIC_NCPU),
-        VMSTATE_UINT8_ARRAY(abpr, GICState, GIC_NCPU),
+        VMSTATE_UINT16_SUB_ARRAY(priority_mask, GICState, 0, GIC_NCPU),
+        VMSTATE_UINT16_SUB_ARRAY(running_priority, GICState, 0, GIC_NCPU),
+        VMSTATE_UINT16_SUB_ARRAY(current_pending, GICState, 0, GIC_NCPU),
+        VMSTATE_UINT8_SUB_ARRAY(bpr, GICState, 0, GIC_NCPU),
+        VMSTATE_UINT8_SUB_ARRAY(abpr, GICState, 0, GIC_NCPU),
         VMSTATE_UINT32_2DARRAY(apr, GICState, GIC_NR_APRS, GIC_NCPU),
         VMSTATE_UINT32_2DARRAY(nsapr, GICState, GIC_NR_APRS, GIC_NCPU),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_gic_virt_state,
+        NULL
     }
 };
 
 void gic_init_irqs_and_mmio(GICState *s, qemu_irq_handler handler,
-                            const MemoryRegionOps *ops)
+                            const MemoryRegionOps *ops,
+                            const MemoryRegionOps *virt_ops)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(s);
     int i = s->num_irq - GIC_INTERNAL;
 
     /* For the GIC, also expose incoming GPIO lines for PPIs for each CPU.
@@ -114,10 +150,15 @@ void gic_init_irqs_and_mmio(GICState *s, qemu_irq_handler handler,
         sysbus_init_irq(sbd, &s->parent_virq[i]);
     }
     for (i = 0; i < s->num_cpu; i++) {
         sysbus_init_irq(sbd, &s->parent_vfiq[i]);
     }
+    if (s->virt_extn) {
+        for (i = 0; i < s->num_cpu; i++) {
+            sysbus_init_irq(sbd, &s->maintenance_irq[i]);
+        }
+    }
 
     /* Distributor */
     memory_region_init_io(&s->iomem, OBJECT(s), ops, s, "gic_dist", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
 
@@ -125,10 +166,21 @@ void gic_init_irqs_and_mmio(GICState *s, qemu_irq_handler handler,
      * present because it is required by both software emulation and KVM.
      */
     memory_region_init_io(&s->cpuiomem[0], OBJECT(s), ops ? &ops[1] : NULL,
                           s, "gic_cpu", s->revision == 2 ? 0x2000 : 0x100);
     sysbus_init_mmio(sbd, &s->cpuiomem[0]);
+
+    if (s->virt_extn) {
+        memory_region_init_io(&s->vifaceiomem[0], OBJECT(s), virt_ops,
+                              s, "gic_viface", 0x1000);
+        sysbus_init_mmio(sbd, &s->vifaceiomem[0]);
+
+        memory_region_init_io(&s->vcpuiomem, OBJECT(s),
+                              virt_ops ? &virt_ops[1] : NULL,
+                              s, "gic_vcpu", 0x2000);
+        sysbus_init_mmio(sbd, &s->vcpuiomem);
+    }
 }
 
 static void arm_gic_common_realize(DeviceState *dev, Error **errp)
 {
     GICState *s = ARM_GIC_COMMON(dev);
@@ -161,10 +213,52 @@ static void arm_gic_common_realize(DeviceState *dev, Error **errp)
         (s->revision == REV_11MPCORE)) {
         error_setg(errp, "this GIC revision does not implement "
                    "the security extensions");
         return;
     }
+
+    if (s->virt_extn) {
+        if (s->revision != 2) {
+            error_setg(errp, "GIC virtualization extensions are only "
+                       "supported by revision 2");
+            return;
+        }
+
+        /* For now, set the number of implemented LRs to 4, as found in most
+         * real GICv2. This could be promoted as a QOM property if we need to
+         * emulate a variant with another num_lrs.
+         */
+        s->num_lrs = 4;
+    }
+}
+
+static inline void arm_gic_common_reset_irq_state(GICState *s, int first_cpu,
+                                                  int resetprio)
+{
+    int i, j;
+
+    for (i = first_cpu; i < first_cpu + s->num_cpu; i++) {
+        if (s->revision == REV_11MPCORE) {
+            s->priority_mask[i] = 0xf0;
+        } else {
+            s->priority_mask[i] = resetprio;
+        }
+        s->current_pending[i] = 1023;
+        s->running_priority[i] = 0x100;
+        s->cpu_ctlr[i] = 0;
+        s->bpr[i] = gic_is_vcpu(i) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
+        s->abpr[i] = gic_is_vcpu(i) ? GIC_VIRT_MIN_ABPR : GIC_MIN_ABPR;
+
+        if (!gic_is_vcpu(i)) {
+            for (j = 0; j < GIC_INTERNAL; j++) {
+                s->priority1[j][i] = resetprio;
+            }
+            for (j = 0; j < GIC_NR_SGIS; j++) {
+                s->sgi_pending[j][i] = 0;
+            }
+        }
+    }
 }
 
 static void arm_gic_common_reset(DeviceState *dev)
 {
     GICState *s = ARM_GIC_COMMON(dev);
@@ -183,28 +277,19 @@ static void arm_gic_common_reset(DeviceState *dev)
     } else {
         resetprio = 0;
     }
 
     memset(s->irq_state, 0, GIC_MAXIRQ * sizeof(gic_irq_state));
-    for (i = 0 ; i < s->num_cpu; i++) {
-        if (s->revision == REV_11MPCORE) {
-            s->priority_mask[i] = 0xf0;
-        } else {
-            s->priority_mask[i] = resetprio;
-        }
-        s->current_pending[i] = 1023;
-        s->running_priority[i] = 0x100;
-        s->cpu_ctlr[i] = 0;
-        s->bpr[i] = GIC_MIN_BPR;
-        s->abpr[i] = GIC_MIN_ABPR;
-        for (j = 0; j < GIC_INTERNAL; j++) {
-            s->priority1[j][i] = resetprio;
-        }
-        for (j = 0; j < GIC_NR_SGIS; j++) {
-            s->sgi_pending[j][i] = 0;
-        }
+    arm_gic_common_reset_irq_state(s, 0, resetprio);
+
+    if (s->virt_extn) {
+        /* vCPU states are stored at indexes GIC_NCPU .. GIC_NCPU+num_cpu.
+         * The exposed vCPU interface does not have security extensions.
+         */
+        arm_gic_common_reset_irq_state(s, GIC_NCPU, 0);
     }
+
     for (i = 0; i < GIC_NR_SGIS; i++) {
         GIC_DIST_SET_ENABLED(i, ALL_CPU_MASK);
         GIC_DIST_SET_EDGE_TRIGGER(i);
     }
 
@@ -224,10 +309,23 @@ static void arm_gic_common_reset(DeviceState *dev)
         for (i = 0; i < GIC_MAXIRQ; i++) {
             GIC_DIST_SET_GROUP(i, ALL_CPU_MASK);
         }
     }
 
+    if (s->virt_extn) {
+        for (i = 0; i < s->num_lrs; i++) {
+            for (j = 0; j < s->num_cpu; j++) {
+                s->h_lr[i][j] = 0;
+            }
+        }
+
+        for (i = 0; i < s->num_cpu; i++) {
+            s->h_hcr[i] = 0;
+            s->h_misr[i] = 0;
+        }
+    }
+
     s->ctlr = 0;
 }
 
 static void arm_gic_common_linux_init(ARMLinuxBootIf *obj,
                                       bool secure_boot)
@@ -253,10 +351,12 @@ static Property arm_gic_common_properties[] = {
      * versions 1 or 2, or 0 to indicate the legacy 11MPCore GIC.
      */
     DEFINE_PROP_UINT32("revision", GICState, revision, 1),
     /* True if the GIC should implement the security extensions */
     DEFINE_PROP_BOOL("has-security-extensions", GICState, security_extn, 0),
+    /* True if the GIC should implement the virtualization extensions */
+    DEFINE_PROP_BOOL("has-virtualization-extensions", GICState, virt_extn, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
 static void arm_gic_common_class_init(ObjectClass *klass, void *data)
 {
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index 4b611c8d6d..a611e8ee12 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -509,10 +509,16 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "the in-kernel VGIC does not implement the "
                    "security extensions");
         return;
     }
 
+    if (s->virt_extn) {
+        error_setg(errp, "the in-kernel VGIC does not implement the "
+                   "virtualization extensions");
+        return;
+    }
+
     if (!kvm_arm_gic_can_save_restore(s)) {
         error_setg(&s->migration_blocker, "This operating system kernel does "
                                           "not support vGICv2 migration");
         migrate_add_blocker(s->migration_blocker, &local_err);
         if (local_err) {
@@ -520,11 +526,11 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
             error_free(s->migration_blocker);
             return;
         }
     }
 
-    gic_init_irqs_and_mmio(s, kvm_arm_gicv2_set_irq, NULL);
+    gic_init_irqs_and_mmio(s, kvm_arm_gicv2_set_irq, NULL, NULL);
 
     for (i = 0; i < s->num_irq - GIC_INTERNAL; i++) {
         qemu_irq irq = qdev_get_gpio_in(dev, i);
         kvm_irqchip_set_qemuirq_gsi(kvm_state, irq, i);
     }
diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
index a2075a94db..c85427c8e3 100644
--- a/hw/intc/gic_internal.h
+++ b/hw/intc/gic_internal.h
@@ -92,6 +92,11 @@ static inline bool gic_test_pending(GICState *s, int irq, int cm)
         return (s->irq_state[irq].pending & cm) ||
             (!GIC_DIST_TEST_EDGE_TRIGGER(irq) && GIC_DIST_TEST_LEVEL(irq, cm));
     }
 }
 
+static inline bool gic_is_vcpu(int cpu)
+{
+    return cpu >= GIC_NCPU;
+}
+
 #endif /* QEMU_ARM_GIC_INTERNAL_H */
diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_common.h
index af3ca18e2f..b5585fec45 100644
--- a/include/hw/intc/arm_gic_common.h
+++ b/include/hw/intc/arm_gic_common.h
@@ -28,17 +28,30 @@
 /* First 32 are private to each CPU (SGIs and PPIs). */
 #define GIC_INTERNAL 32
 #define GIC_NR_SGIS 16
 /* Maximum number of possible CPU interfaces, determined by GIC architecture */
 #define GIC_NCPU 8
+/* Maximum number of possible CPU interfaces with their respective vCPU */
+#define GIC_NCPU_VCPU (GIC_NCPU * 2)
 
 #define MAX_NR_GROUP_PRIO 128
 #define GIC_NR_APRS (MAX_NR_GROUP_PRIO / 32)
 
 #define GIC_MIN_BPR 0
 #define GIC_MIN_ABPR (GIC_MIN_BPR + 1)
 
+/* Architectural maximum number of list registers in the virtual interface */
+#define GIC_MAX_LR 64
+
+/* Only 32 priority levels and 32 preemption levels in the vCPU interfaces */
+#define GIC_VIRT_MAX_GROUP_PRIO_BITS 5
+#define GIC_VIRT_MAX_NR_GROUP_PRIO (1 << GIC_VIRT_MAX_GROUP_PRIO_BITS)
+#define GIC_VIRT_NR_APRS (GIC_VIRT_MAX_NR_GROUP_PRIO / 32)
+
+#define GIC_VIRT_MIN_BPR 2
+#define GIC_VIRT_MIN_ABPR (GIC_VIRT_MIN_BPR + 1)
+
 typedef struct gic_irq_state {
     /* The enable bits are only banked for per-cpu interrupts.  */
     uint8_t enabled;
     uint8_t pending;
     uint8_t active;
@@ -55,18 +68,20 @@ typedef struct GICState {
 
     qemu_irq parent_irq[GIC_NCPU];
     qemu_irq parent_fiq[GIC_NCPU];
     qemu_irq parent_virq[GIC_NCPU];
     qemu_irq parent_vfiq[GIC_NCPU];
+    qemu_irq maintenance_irq[GIC_NCPU];
+
     /* GICD_CTLR; for a GIC with the security extensions the NS banked version
      * of this register is just an alias of bit 1 of the S banked version.
      */
     uint32_t ctlr;
     /* GICC_CTLR; again, the NS banked version is just aliases of bits of
      * the S banked register, so our state only needs to store the S version.
      */
-    uint32_t cpu_ctlr[GIC_NCPU];
+    uint32_t cpu_ctlr[GIC_NCPU_VCPU];
 
     gic_irq_state irq_state[GIC_MAXIRQ];
     uint8_t irq_target[GIC_MAXIRQ];
     uint8_t priority1[GIC_INTERNAL][GIC_NCPU];
     uint8_t priority2[GIC_MAXIRQ - GIC_INTERNAL];
@@ -76,43 +91,56 @@ typedef struct GICState {
      * the bytes in the GIC_SPENDSGIR* registers as
      * read by the target CPU.
      */
     uint8_t sgi_pending[GIC_NR_SGIS][GIC_NCPU];
 
-    uint16_t priority_mask[GIC_NCPU];
-    uint16_t running_priority[GIC_NCPU];
-    uint16_t current_pending[GIC_NCPU];
+    uint16_t priority_mask[GIC_NCPU_VCPU];
+    uint16_t running_priority[GIC_NCPU_VCPU];
+    uint16_t current_pending[GIC_NCPU_VCPU];
 
     /* If we present the GICv2 without security extensions to a guest,
      * the guest can configure the GICC_CTLR to configure group 1 binary point
      * in the abpr.
      * For a GIC with Security Extensions we use use bpr for the
      * secure copy and abpr as storage for the non-secure copy of the register.
      */
-    uint8_t  bpr[GIC_NCPU];
-    uint8_t  abpr[GIC_NCPU];
+    uint8_t  bpr[GIC_NCPU_VCPU];
+    uint8_t  abpr[GIC_NCPU_VCPU];
 
     /* The APR is implementation defined, so we choose a layout identical to
      * the KVM ABI layout for QEMU's implementation of the gic:
      * If an interrupt for preemption level X is active, then
      *   APRn[X mod 32] == 0b1,  where n = X / 32
      * otherwise the bit is clear.
      */
     uint32_t apr[GIC_NR_APRS][GIC_NCPU];
     uint32_t nsapr[GIC_NR_APRS][GIC_NCPU];
 
+    /* Virtual interface control registers */
+    uint32_t h_hcr[GIC_NCPU];
+    uint32_t h_misr[GIC_NCPU];
+    uint32_t h_lr[GIC_MAX_LR][GIC_NCPU];
+    uint32_t h_apr[GIC_NCPU];
+
+    /* Number of LRs implemented in this GIC instance */
+    uint32_t num_lrs;
+
     uint32_t num_cpu;
 
     MemoryRegion iomem; /* Distributor */
     /* This is just so we can have an opaque pointer which identifies
      * both this GIC and which CPU interface we should be accessing.
      */
     struct GICState *backref[GIC_NCPU];
     MemoryRegion cpuiomem[GIC_NCPU + 1]; /* CPU interfaces */
+    MemoryRegion vifaceiomem[GIC_NCPU + 1]; /* Virtual interfaces */
+    MemoryRegion vcpuiomem; /* vCPU interface */
+
     uint32_t num_irq;
     uint32_t revision;
     bool security_extn;
+    bool virt_extn;
     bool irq_reset_nonsecure; /* configure IRQs as group 1 (NS) on reset? */
     int dev_fd; /* kvm device fd if backed by kvm vgic support */
     Error *migration_blocker;
 } GICState;
 
@@ -132,8 +160,9 @@ typedef struct ARMGICCommonClass {
     void (*pre_save)(GICState *s);
     void (*post_load)(GICState *s);
 } ARMGICCommonClass;
 
 void gic_init_irqs_and_mmio(GICState *s, qemu_irq_handler handler,
-                            const MemoryRegionOps *ops);
+                            const MemoryRegionOps *ops,
+                            const MemoryRegionOps *virt_ops);
 
 #endif
-- 
2.18.0
