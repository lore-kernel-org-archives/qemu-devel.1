Received: from eggs.gnu.org ([2001:4830:134:3::10]:45469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f0pO6-000324-Sa
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f0pO5-0006W8-NF
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:15:46 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 27 Mar 2018 16:15:16 +0200
Message-Id: <1522160122-10744-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 2/8] hw/intc/arm_gicv3: Use an array of
 redistributor regions
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

In the prospect to support multiple redistributor regions,
let's introduce a GICv3RDISTRegion struct datatype and a
statically sized array of those. For the time being, only
one redistributor region is used.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/intc/arm_gicv3_common.c         |  5 +++--
 hw/intc/arm_gicv3_kvm.c            |  3 ++-
 include/hw/intc/arm_gicv3_common.h | 13 ++++++++++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 7b54d52..cb4ee0e 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -199,11 +199,12 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
 
     memory_region_init_io(&s->iomem_dist, OBJECT(s), ops, s,
                           "gicv3_dist", 0x10000);
-    memory_region_init_io(&s->iomem_redist, OBJECT(s), ops ? &ops[1] : NULL, s,
+    memory_region_init_io(&s->redist_region[0].mr, OBJECT(s),
+                          ops ? &ops[1] : NULL, s,
                           "gicv3_redist", 0x20000 * s->num_cpu);
 
     sysbus_init_mmio(sbd, &s->iomem_dist);
-    sysbus_init_mmio(sbd, &s->iomem_redist);
+    sysbus_init_mmio(sbd, &s->redist_region[0].mr);
 }
 
 static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index ec37177..a07bc55 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -755,7 +755,8 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 
     kvm_arm_register_device(&s->iomem_dist, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
                             KVM_VGIC_V3_ADDR_TYPE_DIST, s->dev_fd);
-    kvm_arm_register_device(&s->iomem_redist, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
+    kvm_arm_register_device(&s->redist_region[0].mr, -1,
+                            KVM_DEV_ARM_VGIC_GRP_ADDR,
                             KVM_VGIC_V3_ADDR_TYPE_REDIST, s->dev_fd);
 
     if (kvm_has_gsi_routing()) {
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index bccdfe1..3cf132f 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -137,12 +137,20 @@ typedef struct GICv3CPUState GICv3CPUState;
 #define GICV3_S 0
 #define GICV3_NS 1
 
+#define GICV3_MAX_RDIST_REGIONS 8
+
 typedef struct {
     int irq;
     uint8_t prio;
     int grp;
 } PendingIrq;
 
+typedef struct GICv3RDISTRegion {
+    hwaddr base;
+    uint32_t count; /* number or redistributors */
+    MemoryRegion mr;
+} GICv3RDISTRegion ;
+
 struct GICv3CPUState {
     GICv3State *gic;
     CPUState *cpu;
@@ -210,7 +218,8 @@ struct GICv3State {
     /*< public >*/
 
     MemoryRegion iomem_dist; /* Distributor */
-    MemoryRegion iomem_redist; /* Redistributors */
+    GICv3RDISTRegion redist_region[GICV3_MAX_RDIST_REGIONS];
+    uint32_t nb_redist_regions;
 
     uint32_t num_cpu;
     uint32_t num_irq;
@@ -288,6 +297,8 @@ typedef struct ARMGICv3CommonClass {
 
     void (*pre_save)(GICv3State *s);
     void (*post_load)(GICv3State *s);
+    /* register an RDIST region at @base, containing @pfns 64kB pages */
+    int (*register_redist_region)(GICv3State *s, hwaddr base, uint32_t pfns);
 } ARMGICv3CommonClass;
 
 void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
-- 
2.5.5
