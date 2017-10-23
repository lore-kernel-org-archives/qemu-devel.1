Received: from eggs.gnu.org ([2001:4830:134:3::10]:57217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e6elm-0002cq-J1
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e6ell-0004iS-Py
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:36:02 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon, 23 Oct 2017 17:35:34 +0200
Message-Id: <1508772937-21054-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1508772937-21054-1-git-send-email-eric.auger@redhat.com>
References: <1508772937-21054-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v2 1/4] hw/intc/arm_gicv3_its: Don't abort on
 table save failure
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

The ITS is not fully properly reset at the moment. Caches are
not emptied.

After a reset, in case we attempt to save the state before
the bound devices have registered their MSIs and after the
1st level table has been allocated by the ITS driver
(device BASER is valid), the first level entries are still
invalid. If the device cache is not empty (devices registered
before the reset), vgic_its_save_device_tables fails with -EINVAL.
This causes a QEMU abort().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: wanghaibin <wanghaibin.wang@huawei.com>

---

this patch would deserve being cc'ed stable (2.10)
This goes along with patches 1-5 of
[PATCH v5 00/10] vITS Migration fixes and reset, candidate
for being cc'ed stable
---
 hw/intc/arm_gicv3_its_kvm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 39903d5..1ae205f 100644
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
2.5.5
