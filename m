Received: from eggs.gnu.org ([2001:4830:134:3::10]:49860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd0-0003Rh-10
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcy-0005A3-Sk
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:26 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLcy-00053n-KM
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:24 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcs-0003s9-QF
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:18 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:56:52 +0100
Message-Id: <20180622125713.15303-8-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 07/28] hw/intc/arm_gicv3_kvm: Get prepared to
 handle multiple redist regions
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

Let's check if KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION is supported.
If not, we check the number of redist region is equal to 1 and use the
legacy KVM_VGIC_V3_ADDR_TYPE_REDIST attribute. Otherwise we use
the new attribute and allow to register multiple regions to the
KVM device.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 1529072910-16156-5-git-send-email-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_kvm.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 27516872643..1e11200fe2e 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -767,6 +767,7 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 {
     GICv3State *s = KVM_ARM_GICV3(dev);
     KVMARMGICv3Class *kgc = KVM_ARM_GICV3_GET_CLASS(s);
+    bool multiple_redist_region_allowed;
     Error *local_err = NULL;
     int i;
 
@@ -803,6 +804,18 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    multiple_redist_region_allowed =
+        kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+                              KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION);
+
+    if (!multiple_redist_region_allowed && s->nb_redist_regions > 1) {
+        error_setg(errp, "Multiple VGICv3 redistributor regions are not "
+                   "supported by this host kernel");
+        error_append_hint(errp, "A maximum of %d VCPUs can be used",
+                          s->redist_region_count[0]);
+        return;
+    }
+
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS,
                       0, &s->num_irq, true, &error_abort);
 
@@ -812,9 +825,27 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 
     kvm_arm_register_device(&s->iomem_dist, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
                             KVM_VGIC_V3_ADDR_TYPE_DIST, s->dev_fd, 0);
-    kvm_arm_register_device(&s->iomem_redist[0], -1,
-                            KVM_DEV_ARM_VGIC_GRP_ADDR,
-                            KVM_VGIC_V3_ADDR_TYPE_REDIST, s->dev_fd, 0);
+
+    if (!multiple_redist_region_allowed) {
+        kvm_arm_register_device(&s->iomem_redist[0], -1,
+                                KVM_DEV_ARM_VGIC_GRP_ADDR,
+                                KVM_VGIC_V3_ADDR_TYPE_REDIST, s->dev_fd, 0);
+    } else {
+        /* we register regions in reverse order as "devices" are inserted at
+         * the head of a QSLIST and the list is then popped from the head
+         * onwards by kvm_arm_machine_init_done()
+         */
+        for (i = s->nb_redist_regions - 1; i >= 0; i--) {
+            /* Address mask made of the rdist region index and count */
+            uint64_t addr_ormask =
+                        i | ((uint64_t)s->redist_region_count[i] << 52);
+
+            kvm_arm_register_device(&s->iomem_redist[i], -1,
+                                    KVM_DEV_ARM_VGIC_GRP_ADDR,
+                                    KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION,
+                                    s->dev_fd, addr_ormask);
+        }
+    }
 
     if (kvm_has_gsi_routing()) {
         /* set up irq routing */
-- 
2.17.1
