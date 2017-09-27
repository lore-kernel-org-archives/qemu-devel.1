Received: from eggs.gnu.org ([2001:4830:134:3::10]:56629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dxDm0-0000Wq-Rh
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dxDlw-0001Yd-Vq
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:57:16 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 27 Sep 2017 16:56:43 +0200
Message-Id: <1506524205-20763-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1506524205-20763-1-git-send-email-eric.auger@redhat.com>
References: <1506524205-20763-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 1/3] hw/intc/arm_gicv3_its: Don't abort on table
 save/restore
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

The ITS is not properly reset at the moment. It is possible the
GITS_BASER<n>.valid is set and the in-kernel ITS caches are not
empty (list of devices, collections, LPIs) while data structures
in guest RAM are invalid/inconsistent.

For instance, this happens after a guest shutdown -r now or a
system reset, if we save the state before the guest re-writes
the ITS registers or map devices, the table save ioctl may
produce a QEMU abort.

Until there is a proper reset implemented, let's unplug the
consistency error checking.

The reset issue will be fixed in subsequent patches.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: wanghaibin <wanghaibin.wang@huawei.com>

---

this patch would deserve being cc'ed stable (2.10)
---
 hw/intc/arm_gicv3_its_kvm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 39903d5..120b86d 100644
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
@@ -157,6 +153,7 @@ static void kvm_arm_its_pre_save(GICv3ITSState *s)
  */
 static void kvm_arm_its_post_load(GICv3ITSState *s)
 {
+    Error *err = NULL;
     int i;
 
     if (!s->iidr) {
@@ -188,7 +185,11 @@ static void kvm_arm_its_post_load(GICv3ITSState *s)
 
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
                       KVM_DEV_ARM_ITS_RESTORE_TABLES, NULL, true,
-                      &error_abort);
+                      &err);
+
+    if (err) {
+        error_report_err(err);
+    }
 
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
                       GITS_CTLR, &s->ctlr, true, &error_abort);
-- 
2.5.5
