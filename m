Received: from eggs.gnu.org ([2001:4830:134:3::10]:57340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e6em5-0002rO-3C
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e6em4-0004qV-Az
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:36:21 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon, 23 Oct 2017 17:35:37 +0200
Message-Id: <1508772937-21054-5-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1508772937-21054-1-git-send-email-eric.auger@redhat.com>
References: <1508772937-21054-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v2 4/4] hw/intc/arm_gicv3_its: Implement full
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
 hw/intc/arm_gicv3_its_kvm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 537cea1..73e2530 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -215,9 +215,19 @@ static void kvm_arm_its_post_load(GICv3ITSState *s)
 
 static void kvm_arm_its_reset(DeviceState *dev)
 {
+    GICv3ITSState *s = ARM_GICV3_ITS_COMMON(dev);
     KVMARMITSClass *c = KVM_ARM_ITS_GET_CLASS(s);
 
     c->parent_reset(dev);
+
+    if (!kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                               KVM_DEV_ARM_ITS_CTRL_RESET)) {
+        error_report("ITS KVM: reset is not supported by the kernel");
+        return;
+    }
+
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                      KVM_DEV_ARM_ITS_CTRL_RESET, NULL, true, &error_abort);
 }
 
 static Property kvm_arm_its_props[] = {
-- 
2.5.5
