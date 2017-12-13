Received: from eggs.gnu.org ([2001:4830:134:3::10]:51518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWa-0004iO-VB
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWa-0007qC-5p
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:56 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWZ-0007ls-VE
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:56 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWY-0007fz-El
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:12:54 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:15 +0000
Message-Id: <1513188761-20784-18-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 17/43] hw/intc/arm_gicv3_its: Implement full
 reset
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

Voiding the ITS caches is not supposed to happen via
individual register writes. So we introduced a dedicated
ITS KVM device ioctl to perform a cold reset of the ITS:
KVM_DEV_ARM_VGIC_GRP_CTRL/KVM_DEV_ARM_ITS_CTRL_RESET. Let's
use this latter if the kernel supports it.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1511883692-11511-5-git-send-email-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_its_kvm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 1c663ac..bf290b8 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -204,7 +204,14 @@ static void kvm_arm_its_reset(DeviceState *dev)
 
     c->parent_reset(dev);
 
-    error_report("ITS KVM: full reset is not supported by QEMU");
+    if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                               KVM_DEV_ARM_ITS_CTRL_RESET)) {
+        kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                          KVM_DEV_ARM_ITS_CTRL_RESET, NULL, true, &error_abort);
+        return;
+    }
+
+    error_report("ITS KVM: full reset is not supported by the host kernel");
 
     if (!kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
                                GITS_CTLR)) {
-- 
2.7.4
