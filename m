Received: from eggs.gnu.org ([2001:4830:134:3::10]:43720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cz0cr-0001uK-D9
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 08:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cz0cq-00029h-JS
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 08:46:57 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 14 Apr 2017 14:46:34 +0200
Message-Id: <1492173995-14140-4-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1492173995-14140-1-git-send-email-eric.auger@redhat.com>
References: <1492173995-14140-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v5 3/4] hw/intc/arm_gicv3_kvm: Implement pending
 table save
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, drjones@redhat.com, christoffer.dall@linaro.org, quintela@redhat.com, dgilbert@redhat.com

This patch adds the flush of the LPI pending bits into the
redistributor pending tables. This happens on VM stop.

There is no explicit restore as the tables are implicitly sync'ed
on ITS table restore and on LPI enable at redistributor level.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v5: new
---
 hw/intc/arm_gicv3_kvm.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 19aab56..9898c49 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -25,6 +25,7 @@
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
+#include "sysemu/sysemu.h"
 #include "kvm_arm.h"
 #include "gicv3_internal.h"
 #include "vgic_common.h"
@@ -680,6 +681,26 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+/**
+ * vm_change_state_handler - VM change state callback aiming at flushing
+ * RDIST pending tables into guest RAM
+ *
+ * The tables get flushed to guest RAM whenever the VM gets stopped.
+ */
+static void vm_change_state_handler(void *opaque, int running,
+                                    RunState state)
+{
+    GICv3State *s = (GICv3State *)opaque;
+
+    if (running) {
+        return;
+    }
+
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                      KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES, NULL, true);
+}
+
+
 static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 {
     GICv3State *s = KVM_ARM_GICV3(dev);
@@ -751,6 +772,10 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+    if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                              KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES)) {
+        qemu_add_vm_change_state_handler(vm_change_state_handler, s);
+    }
 }
 
 static void kvm_arm_gicv3_class_init(ObjectClass *klass, void *data)
-- 
2.5.5
