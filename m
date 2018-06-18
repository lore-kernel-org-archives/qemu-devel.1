Received: from eggs.gnu.org ([2001:4830:134:3::10]:46408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUvS2-0006pE-B9
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUvRy-0004lI-62
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:48:14 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Jun 2018 16:47:59 +0200
Message-Id: <20180618144800.555-4-david@redhat.com>
In-Reply-To: <20180618144800.555-1-david@redhat.com>
References: <20180618144800.555-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/4] pc-dimm/memory-device: detect alignment
 internally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

We can now avoid having to pass in the alignment explicitly but can
instead make use of the new machine compat parameter
"memory_device_align".

As we are using TARGET_PAGE_SIZE in memory-device.c, we can now longer
compile it as common object.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c                   | 13 +------------
 hw/mem/Makefile.objs           |  2 +-
 hw/mem/memory-device.c         | 25 +++++++++++++++++++++++++
 hw/mem/pc-dimm.c               |  4 ++--
 hw/ppc/spapr.c                 |  5 ++---
 include/hw/mem/memory-device.h |  1 +
 include/hw/mem/pc-dimm.h       |  3 +--
 7 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 04a97e89e7..d5581ab0a1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1704,20 +1704,9 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
-    MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
-    PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
-    uint64_t align = TARGET_PAGE_SIZE;
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
-
-    if (memory_region_get_alignment(mr) &&
-        mc->memory_device_align != MEMORY_DEVICE_ALIGN_PAGE) {
-        align = memory_region_get_alignment(mr);
-    }
-
-    pc_dimm_plug(dev, MACHINE(pcms), align, &local_err);
+    pc_dimm_plug(dev, MACHINE(pcms), &local_err);
     if (local_err) {
         goto out;
     }
diff --git a/hw/mem/Makefile.objs b/hw/mem/Makefile.objs
index 10be4df2a2..f519441091 100644
--- a/hw/mem/Makefile.objs
+++ b/hw/mem/Makefile.objs
@@ -1,3 +1,3 @@
 common-obj-$(CONFIG_MEM_HOTPLUG) += pc-dimm.o
-common-obj-$(CONFIG_MEM_HOTPLUG) += memory-device.o
+obj-$(CONFIG_MEM_HOTPLUG) += memory-device.o
 common-obj-$(CONFIG_NVDIMM) += nvdimm.o
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 6de4f70bb4..968c64be97 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -249,6 +249,31 @@ uint64_t get_plugged_memory_size(void)
     return size;
 }
 
+uint64_t memory_device_get_align(MachineState *ms, MemoryRegion *mr) {
+    const MachineClass *mc = MACHINE_GET_CLASS(ms);
+    uint64_t align;
+
+    /* use the configured memory device alignment (compat handling) */
+    switch (mc->memory_device_align) {
+    case MEMORY_DEVICE_ALIGN_REGION:
+        align = memory_region_get_alignment(mr);;
+        break;
+    case MEMORY_DEVICE_ALIGN_PAGE:
+        align = TARGET_PAGE_SIZE;
+        break;
+    case MEMORY_DEVICE_ALIGN_REGION_OR_PAGE:
+        align = memory_region_get_alignment(mr);
+        if (!align) {
+            align = TARGET_PAGE_SIZE;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return align;
+}
+
 void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
                                uint64_t addr)
 {
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index e56c4daef2..9198104d34 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -47,14 +47,14 @@ out:
     error_propagate(errp, local_err);
 }
 
-void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
-                  Error **errp)
+void pc_dimm_plug(DeviceState *dev, MachineState *machine, Error **errp)
 {
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
                                                               &error_abort);
     MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
+    const uint64_t align = memory_device_get_align(machine, mr);
     Error *local_err = NULL;
     uint64_t addr;
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9da233588b..03752c6aaf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3143,13 +3143,12 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
-    uint64_t align, size, addr;
+    uint64_t size, addr;
     uint32_t node;
 
-    align = memory_region_get_alignment(mr);
     size = memory_region_size(mr);
 
-    pc_dimm_plug(dev, MACHINE(ms), align, &local_err);
+    pc_dimm_plug(dev, MACHINE(ms), &local_err);
     if (local_err) {
         goto out;
     }
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 2853b084b5..32cd15a0cb 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -44,6 +44,7 @@ uint64_t get_plugged_memory_size(void);
 uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
                                      uint64_t align, uint64_t size,
                                      Error **errp);
+uint64_t memory_device_get_align(MachineState *ms, MemoryRegion *mr);
 void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
                                uint64_t addr);
 void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr);
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 7b120416d1..ba9f7e7146 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -80,7 +80,6 @@ typedef struct PCDIMMDeviceClass {
 } PCDIMMDeviceClass;
 
 void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine, Error **errp);
-void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
-                  Error **errp);
+void pc_dimm_plug(DeviceState *dev, MachineState *machine, Error **errp);
 void pc_dimm_unplug(DeviceState *dev, MachineState *machine);
 #endif
-- 
2.17.1
