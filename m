Received: from eggs.gnu.org ([2001:4830:134:3::10]:40422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eHsvx-0002AH-D6
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 09:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eHsvw-0007wH-Mp
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 09:56:57 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 23 Nov 2017 15:56:15 +0100
Message-Id: <1511448975-28326-5-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1511448975-28326-1-git-send-email-eric.auger@redhat.com>
References: <1511448975-28326-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v3 4/4] hw/intc/arm_gicv3_its: Implement full
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, wanghaibin.wang@huawei.com
Cc: vijay.kilari@gmail.com, drjones@redhat.com, wei@redhat.com, quintela@redhat.com, dgilbert@redhat.com, christoffer.dall@linaro.org, wu.wubin@huawei.com

Voiding the ITS caches is not supposed to happen via
individual register writes. So we introduced a dedicated
ITS KVM device ioctl to perform a cold reset of the ITS:
KVM_DEV_ARM_VGIC_GRP_CTRL/KVM_DEV_ARM_ITS_CTRL_RESET. Let's
use this latter if the kernel supports it.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/intc/arm_gicv3_its_kvm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 83e5268..bad593f 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -204,6 +204,13 @@ static void kvm_arm_its_reset(DeviceState *dev)
 
     c->parent_reset(dev);
 
+    if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                               KVM_DEV_ARM_ITS_CTRL_RESET)) {
+        kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                          KVM_DEV_ARM_ITS_CTRL_RESET, NULL, true, &error_abort);
+        return;
+    }
+
     error_report("ITS KVM: full reset is not supported by the host kernel");
 
     if (!kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
-- 
2.5.5
