Received: from eggs.gnu.org ([2001:4830:134:3::10]:32955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eJi1G-0000wk-Ji
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:42:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eJi1B-0004sx-1g
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:41:58 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 28 Nov 2017 16:41:29 +0100
Message-Id: <1511883692-11511-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1511883692-11511-1-git-send-email-eric.auger@redhat.com>
References: <1511883692-11511-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v6 1/4] hw/intc/arm_gicv3_its: Don't call
 post_load on reset
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

>From the very beginning, post_load() was called from common
reset. This is not standard and obliged to discriminate the
reset case from the restore case using the iidr value.

Let's get rid of that call.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

---

v4 -> V5:
- added Peter's R-b
---
 hw/intc/arm_gicv3_its_common.c | 2 --
 hw/intc/arm_gicv3_its_kvm.c    | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index f2cce59..2bd2f0f 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -131,8 +131,6 @@ static void gicv3_its_common_reset(DeviceState *dev)
     s->creadr = 0;
     s->iidr = 0;
     memset(&s->baser, 0, sizeof(s->baser));
-
-    gicv3_its_post_load(s, 0);
 }
 
 static void gicv3_its_common_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 6fb45df..b1b322b 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -155,10 +155,6 @@ static void kvm_arm_its_post_load(GICv3ITSState *s)
 {
     int i;
 
-    if (!s->iidr) {
-        return;
-    }
-
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
                       GITS_IIDR, &s->iidr, true, &error_abort);
 
-- 
2.5.5
