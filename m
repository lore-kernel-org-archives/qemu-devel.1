Received: from eggs.gnu.org ([2001:4830:134:3::10]:45813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f0pOO-0003JW-Vj
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f0pOI-0006ka-Pg
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:16:04 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 27 Mar 2018 16:15:18 +0200
Message-Id: <1522160122-10744-5-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 4/8] hw/intc/arm_gicv3: Implement
 register_redist_region API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com, wei@redhat.com, marc.zyngier@arm.com, cdall@kernel.org, zhaoshenglong@huawei.com

This patch defines and implements the register_redist_region() API
for both arm_gicv3 and arm_gicv3_kvm. Virt machine now directly calls
the function to set the single redistributor region. The associated
memory region init is removed from gicv3_init_irqs_and_mmio.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c                      |  6 +++++-
 hw/intc/arm_gicv3.c                | 21 +++++++++++++++++++++
 hw/intc/arm_gicv3_common.c         | 10 ++++++----
 hw/intc/arm_gicv3_kvm.c            | 38 +++++++++++++++++++++++++++++++++++---
 include/hw/intc/arm_gicv3_common.h |  5 +++--
 5 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 94dcb12..0eef6aa 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -526,7 +526,11 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
     gicbusdev = SYS_BUS_DEVICE(gicdev);
     sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
     if (type == 3) {
-        sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_REDIST].base);
+        ARMGICv3CommonClass *agcc = ARM_GICV3_COMMON_GET_CLASS(gicdev);
+
+        agcc->register_redist_region((GICv3State *)gicdev,
+                                 vms->memmap[VIRT_GIC_REDIST].base,
+                                 vms->memmap[VIRT_GIC_REDIST].size >> 17);
     } else {
         sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
     }
diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 479c667..37f7564 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -378,6 +378,26 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
     gicv3_init_cpuif(s);
 }
 
+static int arm_gicv3_register_redist_region(GICv3State *s, hwaddr base,
+                                            uint32_t count)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(s);
+
+    if (s->nb_redist_regions > 0) {
+        return -EINVAL;
+    }
+
+    s->redist_region[s->nb_redist_regions].base = base;
+    s->redist_region[s->nb_redist_regions].count = count;
+    memory_region_init_io(&s->redist_region[s->nb_redist_regions].mr, OBJECT(s),
+                          gic_ops, s, "gicv3_redist", 0x20000 * count);
+    sysbus_init_mmio(sbd, &s->redist_region[s->nb_redist_regions].mr);
+    sysbus_mmio_map(sbd, 1, base);
+    s->nb_redist_regions++;
+
+    return 0;
+}
+
 static void arm_gicv3_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -385,6 +405,7 @@ static void arm_gicv3_class_init(ObjectClass *klass, void *data)
     ARMGICv3Class *agc = ARM_GICV3_CLASS(klass);
 
     agcc->post_load = arm_gicv3_post_load;
+    agcc->register_redist_region = arm_gicv3_register_redist_region;
     device_class_set_parent_realize(dc, arm_gic_realize, &agc->parent_realize);
 }
 
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index cb4ee0e..c662e06 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -199,12 +199,8 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
 
     memory_region_init_io(&s->iomem_dist, OBJECT(s), ops, s,
                           "gicv3_dist", 0x10000);
-    memory_region_init_io(&s->redist_region[0].mr, OBJECT(s),
-                          ops ? &ops[1] : NULL, s,
-                          "gicv3_redist", 0x20000 * s->num_cpu);
 
     sysbus_init_mmio(sbd, &s->iomem_dist);
-    sysbus_init_mmio(sbd, &s->redist_region[0].mr);
 }
 
 static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
@@ -384,6 +380,12 @@ static void arm_gic_common_linux_init(ARMLinuxBootIf *obj,
     }
 }
 
+static inline
+bool arm_gicv3_common_support_multiple_redist_regions(GICv3State *s)
+{
+    return s->support_multiple_redist_regions;
+}
+
 static Property arm_gicv3_common_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", GICv3State, num_cpu, 1),
     DEFINE_PROP_UINT32("num-irq", GICv3State, num_irq, 32),
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index a07bc55..b6a3faf 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -755,9 +755,6 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 
     kvm_arm_register_device(&s->iomem_dist, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
                             KVM_VGIC_V3_ADDR_TYPE_DIST, s->dev_fd);
-    kvm_arm_register_device(&s->redist_region[0].mr, -1,
-                            KVM_DEV_ARM_VGIC_GRP_ADDR,
-                            KVM_VGIC_V3_ADDR_TYPE_REDIST, s->dev_fd);
 
     if (kvm_has_gsi_routing()) {
         /* set up irq routing */
@@ -788,6 +785,40 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static int kvm_arm_gicv3_register_redist_region(GICv3State *s, hwaddr base,
+                                                uint32_t count)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(s);
+    int n = s->nb_redist_regions;
+    char *name;
+
+    if (!s->dev_fd) {
+        return -ENODEV;
+    }
+
+    if (n > 0) {
+        return -EINVAL;
+    }
+
+    name = g_strdup_printf("gicv3_redist_region[%d]", n);
+
+    s->redist_region[n].base = base;
+    s->redist_region[n].count = count;
+    memory_region_init_io(&s->redist_region[n].mr, OBJECT(s),
+                          NULL, s, name, count * 0x20000);
+    sysbus_init_mmio(sbd, &s->redist_region[n].mr);
+
+    kvm_arm_register_device(&s->redist_region[n].mr, -1,
+                            KVM_DEV_ARM_VGIC_GRP_ADDR,
+                            KVM_VGIC_V3_ADDR_TYPE_REDIST, s->dev_fd);
+
+    sysbus_mmio_map(sbd, n + 1, base); /* first region is DIST */
+
+    s->nb_redist_regions++;
+    g_free(name);
+    return 0;
+}
+
 static void kvm_arm_gicv3_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -796,6 +827,7 @@ static void kvm_arm_gicv3_class_init(ObjectClass *klass, void *data)
 
     agcc->pre_save = kvm_arm_gicv3_get;
     agcc->post_load = kvm_arm_gicv3_put;
+    agcc->register_redist_region = kvm_arm_gicv3_register_redist_region;
     device_class_set_parent_realize(dc, kvm_arm_gicv3_realize,
                                     &kgc->parent_realize);
     device_class_set_parent_reset(dc, kvm_arm_gicv3_reset, &kgc->parent_reset);
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 3cf132f..549ccc3 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -220,6 +220,7 @@ struct GICv3State {
     MemoryRegion iomem_dist; /* Distributor */
     GICv3RDISTRegion redist_region[GICV3_MAX_RDIST_REGIONS];
     uint32_t nb_redist_regions;
+    bool support_multiple_redist_regions;
 
     uint32_t num_cpu;
     uint32_t num_irq;
@@ -297,8 +298,8 @@ typedef struct ARMGICv3CommonClass {
 
     void (*pre_save)(GICv3State *s);
     void (*post_load)(GICv3State *s);
-    /* register an RDIST region at @base, containing @pfns 64kB pages */
-    int (*register_redist_region)(GICv3State *s, hwaddr base, uint32_t pfns);
+    /* register an RDIST region at @base, containing @count redistributors */
+    int (*register_redist_region)(GICv3State *s, hwaddr base, uint32_t count);
 } ARMGICv3CommonClass;
 
 void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
-- 
2.5.5
