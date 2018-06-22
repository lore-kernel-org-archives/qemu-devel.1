Received: from eggs.gnu.org ([2001:4830:134:3::10]:49907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd1-0003Rz-Ah
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcz-0005DP-K0
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLcz-00051P-AA
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:25 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcs-0003rh-30
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:18 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:56:51 +0100
Message-Id: <20180622125713.15303-7-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/28] hw/intc/arm_gicv3: Introduce
 redist-region-count array property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

To prepare for multiple redistributor regions, we introduce
an array of uint32_t properties that stores the redistributor
count of each redistributor region.

Non accelerated VGICv3 only supports a single redistributor region.
The capacity of all redist regions is checked against the number of
vcpus.

Machvirt is updated to set those properties, ie. a single
redistributor region with count set to the number of vcpus
capped by 123.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 1529072910-16156-4-git-send-email-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gicv3_common.h |  8 +++++--
 hw/arm/virt.c                      | 11 ++++++++-
 hw/intc/arm_gicv3.c                | 12 +++++++++-
 hw/intc/arm_gicv3_common.c         | 38 ++++++++++++++++++++++++++----
 hw/intc/arm_gicv3_kvm.c            |  9 +++++--
 5 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index d75b49d5581..b798486ecf0 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -35,6 +35,8 @@
 #define GICV3_MAXIRQ 1020
 #define GICV3_MAXSPI (GICV3_MAXIRQ - GIC_INTERNAL)
 
+#define GICV3_REDIST_SIZE 0x20000
+
 /* Number of SGI target-list bits */
 #define GICV3_TARGETLIST_BITS 16
 
@@ -210,7 +212,9 @@ struct GICv3State {
     /*< public >*/
 
     MemoryRegion iomem_dist; /* Distributor */
-    MemoryRegion iomem_redist; /* Redistributors */
+    MemoryRegion *iomem_redist; /* Redistributor Regions */
+    uint32_t *redist_region_count; /* redistributor count within each region */
+    uint32_t nb_redist_regions; /* number of redist regions */
 
     uint32_t num_cpu;
     uint32_t num_irq;
@@ -292,6 +296,6 @@ typedef struct ARMGICv3CommonClass {
 } ARMGICv3CommonClass;
 
 void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
-                              const MemoryRegionOps *ops);
+                              const MemoryRegionOps *ops, Error **errp);
 
 #endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 98b99cf2364..de189c72960 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -523,6 +523,15 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
     if (!kvm_irqchip_in_kernel()) {
         qdev_prop_set_bit(gicdev, "has-security-extensions", vms->secure);
     }
+
+    if (type == 3) {
+        uint32_t redist0_capacity =
+                    vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
+        uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
+
+        qdev_prop_set_uint32(gicdev, "len-redist-region-count", 1);
+        qdev_prop_set_uint32(gicdev, "redist-region-count[0]", redist0_count);
+    }
     qdev_init_nofail(gicdev);
     gicbusdev = SYS_BUS_DEVICE(gicdev);
     sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
@@ -1322,7 +1331,7 @@ static void machvirt_init(MachineState *machine)
      * many redistributors we can fit into the memory map.
      */
     if (vms->gic_version == 3) {
-        virt_max_cpus = vms->memmap[VIRT_GIC_REDIST].size / 0x20000;
+        virt_max_cpus = vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
     } else {
         virt_max_cpus = GIC_NCPU;
     }
diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 479c66733c7..7044133e2d7 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -373,7 +373,17 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    gicv3_init_irqs_and_mmio(s, gicv3_set_irq, gic_ops);
+    if (s->nb_redist_regions != 1) {
+        error_setg(errp, "VGICv3 redist region number(%d) not equal to 1",
+                   s->nb_redist_regions);
+        return;
+    }
+
+    gicv3_init_irqs_and_mmio(s, gicv3_set_irq, gic_ops, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     gicv3_init_cpuif(s);
 }
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 864b7c6515f..ff326b374ad 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -247,11 +247,22 @@ static const VMStateDescription vmstate_gicv3 = {
 };
 
 void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
-                              const MemoryRegionOps *ops)
+                              const MemoryRegionOps *ops, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(s);
+    int rdist_capacity = 0;
     int i;
 
+    for (i = 0; i < s->nb_redist_regions; i++) {
+        rdist_capacity += s->redist_region_count[i];
+    }
+    if (rdist_capacity < s->num_cpu) {
+        error_setg(errp, "Capacity of the redist regions(%d) "
+                   "is less than number of vcpus(%d)",
+                   rdist_capacity, s->num_cpu);
+        return;
+    }
+
     /* For the GIC, also expose incoming GPIO lines for PPIs for each CPU.
      * GPIO array layout is thus:
      *  [0..N-1] spi
@@ -277,11 +288,18 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
 
     memory_region_init_io(&s->iomem_dist, OBJECT(s), ops, s,
                           "gicv3_dist", 0x10000);
-    memory_region_init_io(&s->iomem_redist, OBJECT(s), ops ? &ops[1] : NULL, s,
-                          "gicv3_redist", 0x20000 * s->num_cpu);
-
     sysbus_init_mmio(sbd, &s->iomem_dist);
-    sysbus_init_mmio(sbd, &s->iomem_redist);
+
+    s->iomem_redist = g_new0(MemoryRegion, s->nb_redist_regions);
+    for (i = 0; i < s->nb_redist_regions; i++) {
+        char *name = g_strdup_printf("gicv3_redist_region[%d]", i);
+
+        memory_region_init_io(&s->iomem_redist[i], OBJECT(s),
+                              ops ? &ops[1] : NULL, s, name,
+                              s->redist_region_count[i] * GICV3_REDIST_SIZE);
+        sysbus_init_mmio(sbd, &s->iomem_redist[i]);
+        g_free(name);
+    }
 }
 
 static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
@@ -363,6 +381,13 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void arm_gicv3_finalize(Object *obj)
+{
+    GICv3State *s = ARM_GICV3_COMMON(obj);
+
+    g_free(s->redist_region_count);
+}
+
 static void arm_gicv3_common_reset(DeviceState *dev)
 {
     GICv3State *s = ARM_GICV3_COMMON(dev);
@@ -467,6 +492,8 @@ static Property arm_gicv3_common_properties[] = {
     DEFINE_PROP_UINT32("num-irq", GICv3State, num_irq, 32),
     DEFINE_PROP_UINT32("revision", GICv3State, revision, 3),
     DEFINE_PROP_BOOL("has-security-extensions", GICv3State, security_extn, 0),
+    DEFINE_PROP_ARRAY("redist-region-count", GICv3State, nb_redist_regions,
+                      redist_region_count, qdev_prop_uint32, uint32_t),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -488,6 +515,7 @@ static const TypeInfo arm_gicv3_common_type = {
     .instance_size = sizeof(GICv3State),
     .class_size = sizeof(ARMGICv3CommonClass),
     .class_init = arm_gicv3_common_class_init,
+    .instance_finalize = arm_gicv3_finalize,
     .abstract = true,
     .interfaces = (InterfaceInfo []) {
         { TYPE_ARM_LINUX_BOOT_IF },
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 95491df72a0..27516872643 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -784,7 +784,11 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
+    gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     for (i = 0; i < s->num_cpu; i++) {
         ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
@@ -808,7 +812,8 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 
     kvm_arm_register_device(&s->iomem_dist, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
                             KVM_VGIC_V3_ADDR_TYPE_DIST, s->dev_fd, 0);
-    kvm_arm_register_device(&s->iomem_redist, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
+    kvm_arm_register_device(&s->iomem_redist[0], -1,
+                            KVM_DEV_ARM_VGIC_GRP_ADDR,
                             KVM_VGIC_V3_ADDR_TYPE_REDIST, s->dev_fd, 0);
 
     if (kvm_has_gsi_routing()) {
-- 
2.17.1
