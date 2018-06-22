Received: from eggs.gnu.org ([2001:4830:134:3::10]:41434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWJA3-0000Jf-BO
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWJA2-0005aL-9m
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:19:23 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 22 Jun 2018 12:19:06 +0200
Message-Id: <1529662749-32069-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1529662749-32069-1-git-send-email-eric.auger@redhat.com>
References: <1529662749-32069-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 2/5] hw/arm/virt: Add pc-dimm mem hotplug
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

This patch adds the the PC-DIMM hot-plug/hot-unplug infrastructure
in machvirt.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
---
 default-configs/arm-softmmu.mak |  2 ++
 hw/arm/virt.c                   | 53 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 7cf73d2..0840a56 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -151,3 +151,5 @@ CONFIG_PCI_DESIGNWARE=y
 CONFIG_STRONGARM=y
 CONFIG_HIGHBANK=y
 CONFIG_MUSICPAL=y
+CONFIG_MEM_HOTPLUG=y
+
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a251054..a6e3b3d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -60,6 +60,7 @@
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
 #include "hw/acpi/acpi.h"
+#include "hw/mem/pc-dimm.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -1723,6 +1724,40 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
+static void virt_dimm_plug(HotplugHandler *hotplug_dev,
+                           DeviceState *dev, Error **errp)
+{
+    PCDIMMDevice *dimm = PC_DIMM(dev);
+    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    Error *local_err = NULL;
+    MemoryRegion *mr;
+    uint64_t align;
+
+    mr = ddc->get_memory_region(dimm, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    if (memory_region_get_alignment(mr)) {
+        align = memory_region_get_alignment(mr);
+    } else {
+        /* by default we align on 64KB page size */
+        align = SZ_64K;
+    }
+
+    pc_dimm_memory_plug(dev, MACHINE(hotplug_dev), align, &local_err);
+
+out:
+    error_propagate(errp, local_err);
+}
+
+static void virt_dimm_unplug(HotplugHandler *hotplug_dev,
+                             DeviceState *dev, Error **errp)
+{
+    pc_dimm_memory_unplug(dev, MACHINE(hotplug_dev));
+    object_unparent(OBJECT(dev));
+}
+
 static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
@@ -1734,12 +1769,27 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                      SYS_BUS_DEVICE(dev));
         }
     }
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+            virt_dimm_plug(hotplug_dev, dev, errp);
+    }
+}
+
+static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
+                                          DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        virt_dimm_unplug(hotplug_dev, dev, errp);
+    } else {
+        error_setg(errp, "device unplug request for unsupported device"
+                   " type: %s", object_get_typename(OBJECT(dev)));
+    }
 }
 
 static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
                                                         DeviceState *dev)
 {
-    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE) ||
+       (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM))) {
         return HOTPLUG_HANDLER(machine);
     }
 
@@ -1800,6 +1850,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->plug = virt_machine_device_plug_cb;
+    hc->unplug = virt_machine_device_unplug_cb;
 }
 
 static const TypeInfo virt_machine_info = {
-- 
2.5.5
