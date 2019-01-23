Received: from eggs.gnu.org ([209.51.188.92]:34831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFZn-0001nH-NL
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:16:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFZm-0007WJ-F2
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:16:07 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 23 Jan 2019 11:14:51 +0100
Message-Id: <20190123101458.12478-12-eric.auger@redhat.com>
In-Reply-To: <20190123101458.12478-1-eric.auger@redhat.com>
References: <20190123101458.12478-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 11/18] hw/arm/virt: Add memory hotplug
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

This patch adds the the memory hot-plug/hot-unplug infrastructure
in machvirt. It is still not enabled as no device memory is allocated.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>

---
v4 -> v5:
- change in pc_dimm_pre_plug signature
- CONFIG_MEM_HOTPLUG replaced by CONFIG_MEM_DEVICE and CONFIG_DIMM

v3 -> v4:
- check the memory device is not hotplugged

v2 -> v3:
- change in pc_dimm_plug()'s signature
- add pc_dimm_pre_plug call

v1 -> v2:
- s/virt_dimm_plug|unplug/virt_memory_plug|unplug
- s/pc_dimm_memory_plug/pc_dimm_plug
- reworded title and commit message
- added pre_plug cb
- don't handle get_memory_region failure anymore
---
 default-configs/arm-softmmu.mak |  2 ++
 hw/arm/virt.c                   | 64 ++++++++++++++++++++++++++++++++-
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 2420491aac..3c5928aae0 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -159,3 +159,5 @@ CONFIG_PCI_DESIGNWARE=3Dy
 CONFIG_STRONGARM=3Dy
 CONFIG_HIGHBANK=3Dy
 CONFIG_MUSICPAL=3Dy
+CONFIG_MEM_DEVICE=3Dy
+CONFIG_DIMM=3Dy
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 61c3bb1cef..aad7e0f095 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -59,6 +59,8 @@
 #include "qapi/visitor.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
+#include "hw/mem/pc-dimm.h"
+#include "hw/mem/nvdimm.h"
=20
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -1736,6 +1738,49 @@ static const CPUArchIdList *virt_possible_cpu_arch=
_ids(MachineState *ms)
     return ms->possible_cpus;
 }
=20
+static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceStat=
e *dev,
+                                 Error **errp)
+{
+    const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIM=
M);
+
+    if (dev->hotplugged) {
+        error_setg(errp, "memory hotplug is not supported");
+    }
+
+    if (is_nvdimm) {
+        error_setg(errp, "nvdimm is not yet supported");
+        return;
+    }
+
+    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
+}
+
+static void virt_memory_plug(HotplugHandler *hotplug_dev,
+                             DeviceState *dev, Error **errp)
+{
+    VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
+    Error *local_err =3D NULL;
+
+    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
+
+    error_propagate(errp, local_err);
+}
+
+static void virt_memory_unplug(HotplugHandler *hotplug_dev,
+                               DeviceState *dev, Error **errp)
+{
+    pc_dimm_unplug(PC_DIMM(dev), MACHINE(hotplug_dev));
+    object_unparent(OBJECT(dev));
+}
+
+static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
+                                            DeviceState *dev, Error **er=
rp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        virt_memory_pre_plug(hotplug_dev, dev, errp);
+    }
+}
+
 static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
@@ -1747,12 +1792,27 @@ static void virt_machine_device_plug_cb(HotplugHa=
ndler *hotplug_dev,
                                      SYS_BUS_DEVICE(dev));
         }
     }
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+            virt_memory_plug(hotplug_dev, dev, errp);
+    }
+}
+
+static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
+                                          DeviceState *dev, Error **errp=
)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        virt_memory_unplug(hotplug_dev, dev, errp);
+    } else {
+        error_setg(errp, "device unplug request for unsupported device"
+                   " type: %s", object_get_typename(OBJECT(dev)));
+    }
 }
=20
 static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *ma=
chine,
                                                         DeviceState *dev=
)
 {
-    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE) ||
+       (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM))) {
         return HOTPLUG_HANDLER(machine);
     }
=20
@@ -1812,7 +1872,9 @@ static void virt_machine_class_init(ObjectClass *oc=
, void *data)
     mc->kvm_type =3D virt_kvm_type;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler =3D virt_machine_get_hotplug_handler;
+    hc->pre_plug =3D virt_machine_device_pre_plug_cb;
     hc->plug =3D virt_machine_device_plug_cb;
+    hc->unplug =3D virt_machine_device_unplug_cb;
 }
=20
 static void virt_instance_init(Object *obj)
--=20
2.20.1
