Received: from eggs.gnu.org ([2001:4830:134:3::10]:33121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTb-0005Gj-0r
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTY-0006gH-QJ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:22 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dKmTY-0006fN-Fu
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:20 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTV-00015G-Ax
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:07:17 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 15:07:03 +0100
Message-Id: <1497362826-21125-15-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
References: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 14/17] kvm-all: Pass an error object to
 kvm_device_access
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

In some circumstances, we don't want to abort if the
kvm_device_access fails. This will be the case during ITS
migration, in case the ITS table save/restore fails because
the guest did not program the vITS correctly. So let's pass an
error object to the function and return the ioctl value. New
callers will be able to make a decision upon this returned
value.

Existing callers pass &error_abort which will cause the
function to abort on failure.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-id: 1497023553-18411-2-git-send-email-eric.auger@redhat.com
[PMM: wrapped long line]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/sysemu/kvm.h        | 11 +++++++----
 hw/intc/arm_gic_kvm.c       |  9 +++++----
 hw/intc/arm_gicv3_its_kvm.c |  2 +-
 hw/intc/arm_gicv3_kvm.c     | 14 +++++++-------
 kvm-all.c                   | 14 ++++++++------
 5 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index a45c145..1e91613 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -294,12 +294,15 @@ int kvm_device_check_attr(int fd, uint32_t group, uint64_t attr);
  * @attr: the attribute of that group to set or get
  * @val: pointer to a storage area for the value
  * @write: true for set and false for get operation
+ * @errp: error object handle
  *
- * This function is not allowed to fail. Use kvm_device_check_attr()
- * in order to check for the availability of optional attributes.
+ * Returns: 0 on success
+ *          < 0 on error
+ * Use kvm_device_check_attr() in order to check for the availability
+ * of optional attributes.
  */
-void kvm_device_access(int fd, int group, uint64_t attr,
-                       void *val, bool write);
+int kvm_device_access(int fd, int group, uint64_t attr,
+                      void *val, bool write, Error **errp);
 
 /**
  * kvm_create_device - create a KVM device for the device control API
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index af5cd36..ae095d0 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -100,14 +100,14 @@ static void kvm_gicd_access(GICState *s, int offset, int cpu,
                             uint32_t *val, bool write)
 {
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_DIST_REGS,
-                      KVM_VGIC_ATTR(offset, cpu), val, write);
+                      KVM_VGIC_ATTR(offset, cpu), val, write, &error_abort);
 }
 
 static void kvm_gicc_access(GICState *s, int offset, int cpu,
                             uint32_t *val, bool write)
 {
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_REGS,
-                      KVM_VGIC_ATTR(offset, cpu), val, write);
+                      KVM_VGIC_ATTR(offset, cpu), val, write, &error_abort);
 }
 
 #define for_each_irq_reg(_ctr, _max_irq, _field_width) \
@@ -538,13 +538,14 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
         if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS, 0)) {
             uint32_t numirqs = s->num_irq;
             kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS, 0,
-                              &numirqs, true);
+                              &numirqs, true, &error_abort);
         }
         /* Tell the kernel to complete VGIC initialization now */
         if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
                                   KVM_DEV_ARM_VGIC_CTRL_INIT)) {
             kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
-                              KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
+                              KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true,
+                              &error_abort);
         }
     } else if (ret != -ENODEV && ret != -ENOTSUP) {
         error_setg_errno(errp, -ret, "error creating in-kernel VGIC");
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index a0441d6..340c2b0 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -78,7 +78,7 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
 
     /* explicit init of the ITS */
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
-                      KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
+                      KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true, &error_abort);
 
     /* register the base address */
     kvm_arm_register_device(&s->iomem_its_cntrl, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 4ee2baa..b70ee27 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -93,7 +93,7 @@ static inline void kvm_gicd_access(GICv3State *s, int offset,
 {
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_DIST_REGS,
                       KVM_VGIC_ATTR(offset, 0),
-                      val, write);
+                      val, write, &error_abort);
 }
 
 static inline void kvm_gicr_access(GICv3State *s, int offset, int cpu,
@@ -101,7 +101,7 @@ static inline void kvm_gicr_access(GICv3State *s, int offset, int cpu,
 {
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
                       KVM_VGIC_ATTR(offset, s->cpu[cpu].gicr_typer),
-                      val, write);
+                      val, write, &error_abort);
 }
 
 static inline void kvm_gicc_access(GICv3State *s, uint64_t reg, int cpu,
@@ -109,7 +109,7 @@ static inline void kvm_gicc_access(GICv3State *s, uint64_t reg, int cpu,
 {
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
                       KVM_VGIC_ATTR(reg, s->cpu[cpu].gicr_typer),
-                      val, write);
+                      val, write, &error_abort);
 }
 
 static inline void kvm_gic_line_level_access(GICv3State *s, int irq, int cpu,
@@ -119,7 +119,7 @@ static inline void kvm_gic_line_level_access(GICv3State *s, int irq, int cpu,
                       KVM_VGIC_ATTR(irq, s->cpu[cpu].gicr_typer) |
                       (VGIC_LEVEL_INFO_LINE_LEVEL <<
                        KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT),
-                      val, write);
+                      val, write, &error_abort);
 }
 
 /* Loop through each distributor IRQ related register; since bits
@@ -630,7 +630,7 @@ static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     /* Initialize to actual HW supported configuration */
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
                       KVM_VGIC_ATTR(ICC_CTLR_EL1, cpu->mp_affinity),
-                      &c->icc_ctlr_el1[GICV3_NS], false);
+                      &c->icc_ctlr_el1[GICV3_NS], false, &error_abort);
 
     c->icc_ctlr_el1[GICV3_S] = c->icc_ctlr_el1[GICV3_NS];
 }
@@ -717,11 +717,11 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
     }
 
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS,
-                      0, &s->num_irq, true);
+                      0, &s->num_irq, true, &error_abort);
 
     /* Tell the kernel to complete VGIC initialization now */
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
-                      KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
+                      KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true, &error_abort);
 
     kvm_arm_register_device(&s->iomem_dist, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
                             KVM_VGIC_V3_ADDR_TYPE_DIST, s->dev_fd);
diff --git a/kvm-all.c b/kvm-all.c
index 44b3cf4..ab8262f 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -23,6 +23,7 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
@@ -2216,8 +2217,8 @@ int kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr)
     return kvm_device_ioctl(dev_fd, KVM_HAS_DEVICE_ATTR, &attribute) ? 0 : 1;
 }
 
-void kvm_device_access(int fd, int group, uint64_t attr,
-                       void *val, bool write)
+int kvm_device_access(int fd, int group, uint64_t attr,
+                      void *val, bool write, Error **errp)
 {
     struct kvm_device_attr kvmattr;
     int err;
@@ -2231,11 +2232,12 @@ void kvm_device_access(int fd, int group, uint64_t attr,
                            write ? KVM_SET_DEVICE_ATTR : KVM_GET_DEVICE_ATTR,
                            &kvmattr);
     if (err < 0) {
-        error_report("KVM_%s_DEVICE_ATTR failed: %s",
-                     write ? "SET" : "GET", strerror(-err));
-        error_printf("Group %d attr 0x%016" PRIx64 "\n", group, attr);
-        abort();
+        error_setg_errno(errp, -err,
+                         "KVM_%s_DEVICE_ATTR failed: Group %d "
+                         "attr 0x%016" PRIx64,
+                         write ? "SET" : "GET", group, attr);
     }
+    return err;
 }
 
 /* Return 1 on success, 0 on failure */
-- 
2.7.4
