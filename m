Received: from eggs.gnu.org ([2001:4830:134:3::10]:36867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41r-0006av-DJ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41n-00060c-3Y
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:34:59 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eC41m-0005xq-T1
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:34:55 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41l-0004VK-Mu
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:34:53 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Nov 2017 13:35:22 +0000
Message-Id: <1510061722-14092-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1510061722-14092-1-git-send-email-peter.maydell@linaro.org>
References: <1510061722-14092-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 7/7] hw/intc/arm_gicv3_its: Don't abort on table
 save failure
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

The ITS is not fully properly reset at the moment. Caches are
not emptied.

After a reset, in case we attempt to save the state before
the bound devices have registered their MSIs and after the
1st level table has been allocated by the ITS driver
(device BASER is valid), the first level entries are still
invalid. If the device cache is not empty (devices registered
before the reset), vgic_its_save_device_tables fails with -EINVAL.
This causes a QEMU abort().

Cc: qemu-stable@nongnu.org
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: wanghaibin <wanghaibin.wang@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_its_kvm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 9b00ce5..6fb45df 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -64,20 +64,16 @@ static void vm_change_state_handler(void *opaque, int running,
 {
     GICv3ITSState *s = (GICv3ITSState *)opaque;
     Error *err = NULL;
-    int ret;
 
     if (running) {
         return;
     }
 
-    ret = kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
-                            KVM_DEV_ARM_ITS_SAVE_TABLES, NULL, true, &err);
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                      KVM_DEV_ARM_ITS_SAVE_TABLES, NULL, true, &err);
     if (err) {
         error_report_err(err);
     }
-    if (ret < 0 && ret != -EFAULT) {
-        abort();
-    }
 }
 
 static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
-- 
2.7.4
