Received: from eggs.gnu.org ([2001:4830:134:3::10]:53895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fHs62-00082E-1T
	for qemu-devel@nongnu.org; Sun, 13 May 2018 10:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fHs60-0006Ps-R7
	for qemu-devel@nongnu.org; Sun, 13 May 2018 10:35:34 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sun, 13 May 2018 16:35:10 +0200
Message-Id: <1526222114-5324-4-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1526222114-5324-1-git-send-email-eric.auger@redhat.com>
References: <1526222114-5324-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v2 3/7] hw/intc/arm_gicv3: Introduce
 redist-region-count array property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: zhaoshenglong@huawei.com, christoffer.dall@arm.com, marc.zyngier@arm.com, drjones@redhat.com, wei@redhat.com

To prepare for multiple redistributor regions, we introduce
an array of uint32_t properties that stores the redistributor
count of each redistributor region.

Non accelerated VGICv3 only supports a single redistributor region.
The capacity of all redist regions is checked against the number of
vcpus.

Machvirt is updated to set the count to 123 vcpus for the unique
redistributor region we currently have.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c                      |  6 ++++++
 hw/intc/arm_gicv3.c                | 11 ++++++++++-
 hw/intc/arm_gicv3_common.c         | 35 ++++++++++++++++++++++++++++++-----
 hw/intc/arm_gicv3_kvm.c            |  9 +++++++--
 include/hw/intc/arm_gicv3_common.h |  6 ++++--
 5 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 11b9f59..c9d842d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -525,6 +525,12 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
     if (!kvm_irqchip_in_kernel()) {
         qdev_prop_set_bit(gicdev, "has-security-extensions", vms->secure);
     }
+
+    if (type == 3) {
+        qdev_prop_set_uint32(gicdev, "len-redist-region-count", 1);
+        qdev_prop_set_uint32(gicdev , "redist-region-count[0]",
+                             vms->memmap[VIRT_GIC_REDIST].size / 0x20000);
+    }
     qdev_init_nofail(gicdev);
     gicbusdev = SYS_BUS_DEVICE(gicdev);
     sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 479c667..38d57ac 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -373,7 +373,16 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    gicv3_init_irqs_and_mmio(s, gicv3_set_irq, gic_ops);
+    if (s->nb_redist_regions != 1) {
+        error_setg(errp, "VGICv3 redist region number(%d) not equal to 1",
+                   s->nb_redist_regions);
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
index 7b54d52..f405ae1 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -169,9 +169,10 @@ static const VMStateDescription vmstate_gicv3 = {
 };
 
 void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
-                              const MemoryRegionOps *ops)
+                              const MemoryRegionOps *ops, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(s);
+    int rdist_capacity = 0;
     int i;
 
     /* For the GIC, also expose incoming GPIO lines for PPIs for each CPU.
@@ -199,11 +200,25 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
 
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
+                              ops ? &ops[1] : NULL, s,
+                              name, 0x20000 * s->redist_region_count[i]);
+        sysbus_init_mmio(sbd, &s->iomem_redist[i]);
+        rdist_capacity += s->redist_region_count[i];
+        g_free(name);
+    }
+    if (rdist_capacity < s->num_cpu) {
+        error_setg(errp, "Capacity of the redist regions(%d) "
+                   "is less than number of vcpus(%d)",
+                   rdist_capacity, s->num_cpu);
+    }
+
 }
 
 static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
@@ -285,6 +300,13 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
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
@@ -388,6 +410,8 @@ static Property arm_gicv3_common_properties[] = {
     DEFINE_PROP_UINT32("num-irq", GICv3State, num_irq, 32),
     DEFINE_PROP_UINT32("revision", GICv3State, revision, 3),
     DEFINE_PROP_BOOL("has-security-extensions", GICv3State, security_extn, 0),
+    DEFINE_PROP_ARRAY("redist-region-count", GICv3State, nb_redist_regions,
+                      redist_region_count, qdev_prop_uint32, uint32_t),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -409,6 +433,7 @@ static const TypeInfo arm_gicv3_common_type = {
     .instance_size = sizeof(GICv3State),
     .class_size = sizeof(ARMGICv3CommonClass),
     .class_init = arm_gicv3_common_class_init,
+    .instance_finalize = arm_gicv3_finalize,
     .abstract = true,
     .interfaces = (InterfaceInfo []) {
         { TYPE_ARM_LINUX_BOOT_IF },
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 93ac293..7e76b87 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -731,7 +731,11 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
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
@@ -755,7 +759,8 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 
     kvm_arm_register_device(&s->iomem_dist, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
                             KVM_VGIC_V3_ADDR_TYPE_DIST, s->dev_fd, 0);
-    kvm_arm_register_device(&s->iomem_redist, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
+    kvm_arm_register_device(&s->iomem_redist[0], -1,
+                            KVM_DEV_ARM_VGIC_GRP_ADDR,
                             KVM_VGIC_V3_ADDR_TYPE_REDIST, s->dev_fd, 0);
 
     if (kvm_has_gsi_routing()) {
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index bccdfe1..538dcc5 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -210,7 +210,9 @@ struct GICv3State {
     /*< public >*/
 
     MemoryRegion iomem_dist; /* Distributor */
-    MemoryRegion iomem_redist; /* Redistributors */
+    MemoryRegion *iomem_redist; /* Redistributor Regions */
+    uint32_t *redist_region_count; /* redistributor count within each region */
+    uint32_t nb_redist_regions; /* number of redist regions */
 
     uint32_t num_cpu;
     uint32_t num_irq;
@@ -291,6 +293,6 @@ typedef struct ARMGICv3CommonClass {
 } ARMGICv3CommonClass;
 
 void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
-                              const MemoryRegionOps *ops);
+                              const MemoryRegionOps *ops, Error **errp);
 
 #endif
-- 
2.5.5
