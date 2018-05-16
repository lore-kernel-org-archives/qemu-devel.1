Received: from eggs.gnu.org ([2001:4830:134:3::10]:51900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fIyzQ-0000oH-VU
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fIyzP-0004fT-Oe
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:09:20 -0400
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Date: Wed, 16 May 2018 16:20:23 +0100
Message-ID: <20180516152026.2920-4-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v2 3/6] hw/arm/virt: Add pc-dimm mem hotplug
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: drjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, eric.auger@redhat.com, zhaoshenglong@huawei.com, jonathan.cameron@huawei.com, linuxarm@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

This will be used in subsequent patches to model a chunk of
memory as pc-dimm(cold plug) if the valid iova regions are
non-contiguous. This is not yet a full hotplug support.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 default-configs/aarch64-softmmu.mak |  1 +
 hw/arm/virt.c                       | 82 +++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h               |  2 +
 3 files changed, 85 insertions(+)

diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-softmmu.mak
index 9ddccf8..7a82ed8 100644
--- a/default-configs/aarch64-softmmu.mak
+++ b/default-configs/aarch64-softmmu.mak
@@ -8,3 +8,4 @@ CONFIG_DDC=y
 CONFIG_DPCD=y
 CONFIG_XLNX_ZYNQMP=y
 CONFIG_XLNX_ZYNQMP_ARM=y
+CONFIG_MEM_HOTPLUG=y
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 05fcb62..be3ad14 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1552,9 +1552,82 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
+static void virt_dimm_plug(HotplugHandler *hotplug_dev,
+                         DeviceState *dev, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+    PCDIMMDevice *dimm = PC_DIMM(dev);
+    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    MemoryRegion *mr;
+    uint64_t align;
+    Error *local_err = NULL;
+
+    mr = ddc->get_memory_region(dimm, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    align = memory_region_get_alignment(mr);
+    pc_dimm_memory_plug(dev, &vms->hotplug_memory, mr, align, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+out:
+    error_propagate(errp, local_err);
+}
+
+static void virt_dimm_unplug(HotplugHandler *hotplug_dev,
+                           DeviceState *dev, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+    PCDIMMDevice *dimm = PC_DIMM(dev);
+    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    MemoryRegion *mr;
+    Error *local_err = NULL;
+
+    mr = ddc->get_memory_region(dimm, &local_err);
+    pc_dimm_memory_unplug(dev, &vms->hotplug_memory, mr);
+    object_unparent(OBJECT(dev));
+
+    error_propagate(errp, local_err);
+}
+
+static void virt_machinedevice_plug_cb(HotplugHandler *hotplug_dev,
+                                      DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        virt_dimm_plug(hotplug_dev, dev, errp);
+    } else {
+        error_setg(errp, "device plug request for not supported device"
+                   " type: %s", object_get_typename(OBJECT(dev)));
+    }
+}
+
+static void virt_machinedevice_unplug_cb(HotplugHandler *hotplug_dev,
+                                        DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        virt_dimm_unplug(hotplug_dev, dev, errp);
+    } else {
+        error_setg(errp, "device unplug for not supported device"
+                   " type: %s", object_get_typename(OBJECT(dev)));
+    }
+}
+
+static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
+                                             DeviceState *dev)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        return HOTPLUG_HANDLER(machine);
+    }
+    return NULL;
+}
+
 static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
     mc->init = machvirt_init;
     /* Start max_cpus at the maximum QEMU supports. We'll further restrict
@@ -1573,6 +1646,11 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
+
+    mc->get_hotplug_handler = virt_get_hotplug_handler;
+    hc->plug = virt_machinedevice_plug_cb;
+    hc->unplug = virt_machinedevice_unplug_cb;
+
 }
 
 static const TypeInfo virt_machine_info = {
@@ -1582,6 +1660,10 @@ static const TypeInfo virt_machine_info = {
     .instance_size = sizeof(VirtMachineState),
     .class_size    = sizeof(VirtMachineClass),
     .class_init    = virt_machine_class_init,
+    .interfaces = (InterfaceInfo[]) {
+         { TYPE_HOTPLUG_HANDLER },
+         { }
+    },
 };
 
 static void machvirt_machine_init(void)
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index fc24f3a..a39f29e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -35,6 +35,7 @@
 #include "qemu/notify.h"
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
+#include "hw/mem/pc-dimm.h"
 
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
@@ -108,6 +109,7 @@ typedef struct {
     uint32_t gic_phandle;
     uint32_t msi_phandle;
     int psci_conduit;
+    MemoryHotplugState hotplug_memory;
 } VirtMachineState;
 
 #define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
-- 
2.7.4
