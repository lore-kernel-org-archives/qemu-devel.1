Received: from eggs.gnu.org ([2001:4830:134:3::10]:53867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fHs60-00080G-8v
	for qemu-devel@nongnu.org; Sun, 13 May 2018 10:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fHs5z-0006Oy-82
	for qemu-devel@nongnu.org; Sun, 13 May 2018 10:35:32 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sun, 13 May 2018 16:35:09 +0200
Message-Id: <1526222114-5324-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1526222114-5324-1-git-send-email-eric.auger@redhat.com>
References: <1526222114-5324-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v2 2/7] target/arm: Allow KVM device address
 overwriting
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

for KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION attribute, the attribute
data pointed to by kvm_device_attr.addr is a OR of the
redistributor region address and other fields such as the index
of the redistributor region and the number of redistributors the
region can contain.

The existing machine init done notifier framework sets the address
field to the actual address of the device and does not allow to OR
this value with other fields.

This patch extends the KVMDevice struct with a new kda_addr_fixup
member. Its value is passed at registration time and OR'ed with the
resolved address on kvm_arm_set_device_addr().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/intc/arm_gic_kvm.c       |  4 ++--
 hw/intc/arm_gicv3_its_kvm.c |  2 +-
 hw/intc/arm_gicv3_kvm.c     |  4 ++--
 target/arm/kvm.c            | 10 +++++++++-
 target/arm/kvm_arm.h        |  3 ++-
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index 6f467e6..eb9664e 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -558,7 +558,7 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
                             | KVM_VGIC_V2_ADDR_TYPE_DIST,
                             KVM_DEV_ARM_VGIC_GRP_ADDR,
                             KVM_VGIC_V2_ADDR_TYPE_DIST,
-                            s->dev_fd);
+                            s->dev_fd, 0);
     /* CPU interface for current core. Unlike arm_gic, we don't
      * provide the "interface for core #N" memory regions, because
      * cores with a VGIC don't have those.
@@ -568,7 +568,7 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
                             | KVM_VGIC_V2_ADDR_TYPE_CPU,
                             KVM_DEV_ARM_VGIC_GRP_ADDR,
                             KVM_VGIC_V2_ADDR_TYPE_CPU,
-                            s->dev_fd);
+                            s->dev_fd, 0);
 
     if (kvm_has_gsi_routing()) {
         /* set up irq routing */
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index eea6a73..271ebe4 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -103,7 +103,7 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
 
     /* register the base address */
     kvm_arm_register_device(&s->iomem_its_cntrl, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
-                            KVM_VGIC_ITS_ADDR_TYPE, s->dev_fd);
+                            KVM_VGIC_ITS_ADDR_TYPE, s->dev_fd, 0);
 
     gicv3_its_init_mmio(s, NULL);
 
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index ec37177..93ac293 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -754,9 +754,9 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
                       KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true, &error_abort);
 
     kvm_arm_register_device(&s->iomem_dist, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
-                            KVM_VGIC_V3_ADDR_TYPE_DIST, s->dev_fd);
+                            KVM_VGIC_V3_ADDR_TYPE_DIST, s->dev_fd, 0);
     kvm_arm_register_device(&s->iomem_redist, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
-                            KVM_VGIC_V3_ADDR_TYPE_REDIST, s->dev_fd);
+                            KVM_VGIC_V3_ADDR_TYPE_REDIST, s->dev_fd, 0);
 
     if (kvm_has_gsi_routing()) {
         /* set up irq routing */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 5141d0a..7eed8d4 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -184,10 +184,15 @@ unsigned long kvm_arch_vcpu_id(CPUState *cpu)
  * We use a MemoryListener to track mapping and unmapping of
  * the regions during board creation, so the board models don't
  * need to do anything special for the KVM case.
+ *
+ * Sometimes the address must be OR'ed with some other fields
+ * (for example for KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION).
+ * @kda_addr_fixup aims at storing the value of those fields.
  */
 typedef struct KVMDevice {
     struct kvm_arm_device_addr kda;
     struct kvm_device_attr kdattr;
+    uint64_t kda_addr_fixup;
     MemoryRegion *mr;
     QSLIST_ENTRY(KVMDevice) entries;
     int dev_fd;
@@ -234,6 +239,8 @@ static void kvm_arm_set_device_addr(KVMDevice *kd)
      */
     if (kd->dev_fd >= 0) {
         uint64_t addr = kd->kda.addr;
+
+        addr |= kd->kda_addr_fixup;
         attr->addr = (uintptr_t)&addr;
         ret = kvm_device_ioctl(kd->dev_fd, KVM_SET_DEVICE_ATTR, attr);
     } else {
@@ -266,7 +273,7 @@ static Notifier notify = {
 };
 
 void kvm_arm_register_device(MemoryRegion *mr, uint64_t devid, uint64_t group,
-                             uint64_t attr, int dev_fd)
+                             uint64_t attr, int dev_fd, uint64_t addr_fixup)
 {
     KVMDevice *kd;
 
@@ -286,6 +293,7 @@ void kvm_arm_register_device(MemoryRegion *mr, uint64_t devid, uint64_t group,
     kd->kdattr.group = group;
     kd->kdattr.attr = attr;
     kd->dev_fd = dev_fd;
+    kd->kda_addr_fixup = addr_fixup;
     QSLIST_INSERT_HEAD(&kvm_devices_head, kd, entries);
     memory_region_ref(kd->mr);
 }
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 1e23640..4050017 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -34,6 +34,7 @@ int kvm_arm_vcpu_init(CPUState *cs);
  * @group: device control API group for setting addresses
  * @attr: device control API address type
  * @dev_fd: device control device file descriptor (or -1 if not supported)
+ * @addr_fixup: value to be OR'ed with resolved address
  *
  * Remember the memory region @mr, and when it is mapped by the
  * machine model, tell the kernel that base address using the
@@ -45,7 +46,7 @@ int kvm_arm_vcpu_init(CPUState *cs);
  * address at the point where machine init is complete.
  */
 void kvm_arm_register_device(MemoryRegion *mr, uint64_t devid, uint64_t group,
-                             uint64_t attr, int dev_fd);
+                             uint64_t attr, int dev_fd, uint64_t addr_fixup);
 
 /**
  * kvm_arm_init_cpreg_list:
-- 
2.5.5
