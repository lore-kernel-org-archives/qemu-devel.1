Received: from eggs.gnu.org ([2001:4830:134:3::10]:51848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gTm1h-00046y-JR
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 06:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gTm1g-0002eh-Gj
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 06:04:33 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Tue, 4 Dec 2018 03:26:47 +0800
Message-Id: <1543865209-50994-7-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
References: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V11 6/8] hw/arm/virt: add configure interface
 for pvpanic-mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, drjones@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

Add configure interface for pvpanic-mmio device in virt machine.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 hw/arm/virt.c         | 23 +++++++++++++++++++++++
 include/hw/arm/virt.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a4541fa..fdd3f20 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1655,6 +1655,20 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
     vms->its = value;
 }
 
+static bool virt_get_pvpanic(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->pvpanic;
+}
+
+static void virt_set_pvpanic(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->pvpanic = value;
+}
+
 static char *virt_get_gic_version(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -1884,6 +1898,15 @@ static void virt_3_1_instance_init(Object *obj)
                                     "Valid values are none and smmuv3",
                                     NULL);
 
+    /* Default disallows pvpanic-mmio instantiation */
+    vms->pvpanic = false;
+    object_property_add_bool(obj, "pvpanic", virt_get_pvpanic,
+                             virt_set_pvpanic, NULL);
+    object_property_set_description(obj, "pvpanic",
+                                    "Set on/off to enable/disable "
+                                    "PVPANIC MMIO device",
+                                    NULL);
+
     vms->memmap = a15memmap;
     vms->irqmap = a15irqmap;
 }
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 937c124..7d6d1c0 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -113,6 +113,7 @@ typedef struct {
     bool highmem;
     bool highmem_ecam;
     bool its;
+    bool pvpanic;
     bool virt;
     int32_t gic_version;
     VirtIOMMUType iommu;
-- 
1.8.3.1
