Received: from eggs.gnu.org ([2001:4830:134:3::10]:45003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dJMDu-0003Jl-Iy
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dJMDt-0005GJ-Mx
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:53:18 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  9 Jun 2017 17:52:32 +0200
Message-Id: <1497023553-18411-4-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1497023553-18411-1-git-send-email-eric.auger@redhat.com>
References: <1497023553-18411-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v6 3/4] hw/intc/arm_gicv3_kvm: Implement
 pending table save
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, drjones@redhat.com, peterx@redhat.com, quintela@redhat.com, dgilbert@redhat.com, christoffer.dall@linaro.org, zhaoshenglong@huawei.com, wei@redhat.com

This patch adds the flush of the LPI pending bits into the
redistributor pending tables. This happens on VM stop.

There is no explicit restore as the tables are implicitly sync'ed
on ITS table restore and on LPI enable at redistributor level.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v5 -> v6:
- do not abort on -EFAULT
---
 hw/intc/arm_gicv3_kvm.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index b70ee27..6051c77 100644
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
@@ -680,6 +681,35 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
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
+    Error *err = NULL;
+    int ret;
+
+    if (running) {
+        return;
+    }
+
+    ret = kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                           KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES,
+                           NULL, true, &err);
+    if (err) {
+        error_report_err(err);
+    }
+    if (ret < 0 && ret != -EFAULT) {
+        abort();
+    }
+}
+
+
 static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 {
     GICv3State *s = KVM_ARM_GICV3(dev);
@@ -751,6 +781,10 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
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
