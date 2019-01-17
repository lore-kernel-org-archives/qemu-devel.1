Received: from eggs.gnu.org ([209.51.188.92]:44952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gjy3o-0004nH-DJ
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 22:09:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gjy3n-00040w-Fc
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 22:09:40 -0500
From: Shannon Zhao <shannon.zhaosl@gmail.com>
Date: Thu, 17 Jan 2019 11:09:17 +0800
Message-Id: <20190117030917.18844-1-shannon.zhaosl@gmail.com>
Subject: [Qemu-devel] [PATCH] ARM: GIC: error out early when creating VGICv2
 failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org

Currently if creating a gicv2 VM on the platform without
VGICv2 support, it failed in kvm_arm_pmu_set_irq while
trying to set the interrupt number for PMU with below
error message.
KVM_SET_DEVICE_ATTR failed: Invalid argument

This error log is a little confused. Also it should error
out in kvm_arm_gic_realize early.

Signed-off-by: Shannon Zhao <shannon.zhaosl@gmail.com>
---
 hw/intc/arm_gic_kvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index a611e8e..b4f2133 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -554,8 +554,9 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
                               KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true,
                               &error_abort);
         }
-    } else if (ret != -ENODEV && ret != -ENOTSUP) {
-        error_setg_errno(errp, -ret, "error creating in-kernel VGIC");
+    } else if (ret != -ENOTSUP) {
+        error_setg_errno(errp, -ret, "error creating in-kernel VGIC, maybe "
+                                     "vGICv2 not support on this platform");
         return;
     }
 
-- 
1.8.3.1
