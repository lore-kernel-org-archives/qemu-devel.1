Received: from eggs.gnu.org ([2001:4830:134:3::10]:45703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f0pOJ-0003Ek-1Y
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f0pOH-0006k9-Vq
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:15:59 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 27 Mar 2018 16:15:19 +0200
Message-Id: <1522160122-10744-6-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 5/8] hw/intc/arm_gicv3_kvm: Allow multiple
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

If the host kernel supports it, let's allow the regitration of more
than one redistributor region through the new GICv3 group/attribute:
KVM_DEV_ARM_VGIC_GRP_ADDR/KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION.

In that case we don't use kvm_arm_register_device anymore. this latter
registers the kvm device memory listener which resolves the absolute
gpa of the base address in kvm_arm_devlistener_add(). Then
kvm_arm_set_device_addr() is called on machine init done and invokes
the ioctl with the resolved absolute GPA.

In our case we know the absolute GPA at registration time and the
attribute value needs to be combined with the region index and
size of the region. So this does not nicely fit the current
infrastructure.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/intc/arm_gicv3_kvm.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index b6a3faf..811d809 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -789,14 +789,21 @@ static int kvm_arm_gicv3_register_redist_region(GICv3State *s, hwaddr base,
                                                 uint32_t count)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(s);
+    bool multiple_redist_region_allowed;
     int n = s->nb_redist_regions;
+    Error **local_err = NULL;
     char *name;
+    int ret;
 
     if (!s->dev_fd) {
         return -ENODEV;
     }
 
-    if (n > 0) {
+    multiple_redist_region_allowed =
+        kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+                              KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION);
+
+    if (n > 0 && !multiple_redist_region_allowed) {
         return -EINVAL;
     }
 
@@ -808,15 +815,28 @@ static int kvm_arm_gicv3_register_redist_region(GICv3State *s, hwaddr base,
                           NULL, s, name, count * 0x20000);
     sysbus_init_mmio(sbd, &s->redist_region[n].mr);
 
-    kvm_arm_register_device(&s->redist_region[n].mr, -1,
-                            KVM_DEV_ARM_VGIC_GRP_ADDR,
-                            KVM_VGIC_V3_ADDR_TYPE_REDIST, s->dev_fd);
-
+    if (!multiple_redist_region_allowed) {
+        /* use the legacy API */
+        kvm_arm_register_device(&s->redist_region[n].mr, -1,
+                                KVM_DEV_ARM_VGIC_GRP_ADDR,
+                                KVM_VGIC_V3_ADDR_TYPE_REDIST, s->dev_fd);
+    } else {
+        uint64_t val = base | n;
+
+        val = deposit64(val, 52, 12, count);
+        ret = kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+                                KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION,
+                                &val, true, local_err);
+        if (ret) {
+            goto out;
+        }
+    }
     sysbus_mmio_map(sbd, n + 1, base); /* first region is DIST */
 
     s->nb_redist_regions++;
+out:
     g_free(name);
-    return 0;
+    return ret;
 }
 
 static void kvm_arm_gicv3_class_init(ObjectClass *klass, void *data)
-- 
2.5.5
