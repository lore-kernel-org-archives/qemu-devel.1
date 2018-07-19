Received: from eggs.gnu.org ([2001:4830:134:3::10]:44234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1ffzMR-0000iw-Vz
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 23:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1ffzMR-00071o-2g
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 23:12:11 -0400
From: Jia He <hejianet@gmail.com>
Date: Thu, 19 Jul 2018 11:11:50 +0800
Message-Id: <1531969910-32843-1-git-send-email-jia.he@hxt-semitech.com>
Subject: [Qemu-devel] [PATCH] hw/intc/arm_gicv3_its: downgrade error_report
 to warn_report in kvm_arm_its_reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Jia He <jia.he@hxt-semitech.com>

In scripts/arch-run.bash of kvm-unit-tests, it will check the qemu
output log with:
if [ -z "$(echo "$errors" | grep -vi warning)" ]; then

Thus without the warning prefix, all of the test fail.

Since it is not unrecoverable error in kvm_arm_its_reset for
current implementation, downgrading the report from error to
warn makes sense.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 hw/intc/arm_gicv3_its_kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 271ebe4..01573ab 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -211,7 +211,7 @@ static void kvm_arm_its_reset(DeviceState *dev)
         return;
     }
 
-    error_report("ITS KVM: full reset is not supported by the host kernel");
+    warn_report("ITS KVM: full reset is not supported by the host kernel");
 
     if (!kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
                                GITS_CTLR)) {
-- 
1.8.3.1
