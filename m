Received: from eggs.gnu.org ([2001:4830:134:3::10]:59012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfq2-00062U-76
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfq0-0001cC-UJ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:38:14 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Oct 2018 10:32:44 -0300
Message-Id: <20181025133301.16578-27-ehabkost@redhat.com>
In-Reply-To: <20181025133301.16578-1-ehabkost@redhat.com>
References: <20181025133301.16578-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 26/43] memory-device: factor out
 get_memory_region() from pc-dimm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

The memory region is necessary for plugging/unplugging a memory device.
The region size (via get_region_size()) is no longer sufficient, as
besides the alignment, also the region itself is required in order to
add it to the device memory region of the machine via
- memory_region_add_subregion
- memory_region_del_subregion

So, to factor out plugging/unplugging of memory devices from pc-dimm
code, we have to factor out access to the memory region first.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181005092024.14344-11-david@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/mem/memory-device.h | 15 +++++++++++++++
 include/hw/mem/pc-dimm.h       |  4 ----
 hw/mem/nvdimm.c                |  9 ++++++---
 hw/mem/pc-dimm.c               | 27 ++++++++++++++++++---------
 4 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 898df3057d..659f38385c 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -38,6 +38,11 @@ typedef struct MemoryDeviceState {
  * mapped into guest physical address space at a certain address. The
  * address in guest physical memory can either be specified explicitly
  * or get assigned automatically.
+ *
+ * Conceptually, memory devices only span one memory region. If multiple
+ * successive memory regions are used, a covering memory region has to
+ * be provided. Scattered memory regions are not supported for single
+ * devices.
  */
 typedef struct MemoryDeviceClass {
     /* private */
@@ -68,6 +73,16 @@ typedef struct MemoryDeviceClass {
     uint64_t (*get_plugged_size)(const MemoryDeviceState *md, Error **errp);
     uint64_t (*get_region_size)(const MemoryDeviceState *md, Error **errp);
 
+    /*
+     * Return the memory region of the memory device.
+     *
+     * Called when (un)plugging the memory device, to (un)map the
+     * memory region in guest physical memory, but also to detect the
+     * required alignment during address assignment or when the size of the
+     * memory region is required.
+     */
+    MemoryRegion *(*get_memory_region)(MemoryDeviceState *md, Error **errp);
+
     /*
      * Translate the memory device into #MemoryDeviceInfo.
      */
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 99cbd54de7..01436b9f50 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -61,9 +61,6 @@ typedef struct PCDIMMDevice {
  * PCDIMMDeviceClass:
  * @realize: called after common dimm is realized so that the dimm based
  * devices get the chance to do specified operations.
- * @get_memory_region: returns #MemoryRegion associated with @dimm which
- * is directly mapped into the physical address space of guest. Will not
- * fail after the device was realized.
  * @get_vmstate_memory_region: returns #MemoryRegion which indicates the
  * memory of @dimm should be kept during live migration. Will not fail
  * after the device was realized.
@@ -74,7 +71,6 @@ typedef struct PCDIMMDeviceClass {
 
     /* public */
     void (*realize)(PCDIMMDevice *dimm, Error **errp);
-    MemoryRegion *(*get_memory_region)(PCDIMMDevice *dimm, Error **errp);
     MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm,
                                                Error **errp);
 } PCDIMMDeviceClass;
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 1c6674c4ed..49324f3fae 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -27,6 +27,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/mem/memory-device.h"
 
 static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
@@ -118,9 +119,10 @@ static void nvdimm_prepare_memory_region(NVDIMMDevice *nvdimm, Error **errp)
     nvdimm->nvdimm_mr->align = align;
 }
 
-static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
+static MemoryRegion *nvdimm_md_get_memory_region(MemoryDeviceState *md,
+                                                 Error **errp)
 {
-    NVDIMMDevice *nvdimm = NVDIMM(dimm);
+    NVDIMMDevice *nvdimm = NVDIMM(md);
     Error *local_err = NULL;
 
     if (!nvdimm->nvdimm_mr) {
@@ -190,11 +192,12 @@ static Property nvdimm_properties[] = {
 static void nvdimm_class_init(ObjectClass *oc, void *data)
 {
     PCDIMMDeviceClass *ddc = PC_DIMM_CLASS(oc);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
     NVDIMMClass *nvc = NVDIMM_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     ddc->realize = nvdimm_realize;
-    ddc->get_memory_region = nvdimm_get_memory_region;
+    mdc->get_memory_region = nvdimm_md_get_memory_region;
     dc->props = nvdimm_properties;
 
     nvc->read_label_data = nvdimm_read_label_data;
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 3e43ec8742..c9f6ad589e 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -32,7 +32,7 @@ static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
                       const uint64_t *legacy_align, Error **errp)
 {
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(dimm);
     Error *local_err = NULL;
     MemoryRegion *mr;
     uint64_t addr, align;
@@ -49,7 +49,7 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
                             &error_abort);
     trace_mhp_pc_dimm_assigned_slot(slot);
 
-    mr = ddc->get_memory_region(dimm, &local_err);
+    mr = mdc->get_memory_region(MEMORY_DEVICE(dimm), &local_err);
     if (local_err) {
         goto out;
     }
@@ -72,9 +72,11 @@ out:
 void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp)
 {
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
                                                               &error_abort);
-    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
+    MemoryRegion *mr = mdc->get_memory_region(MEMORY_DEVICE(dimm),
+                                              &error_abort);
     uint64_t addr;
 
     addr = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
@@ -87,9 +89,11 @@ void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp)
 void pc_dimm_unplug(PCDIMMDevice *dimm, MachineState *machine)
 {
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
                                                               &error_abort);
-    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
+    MemoryRegion *mr = mdc->get_memory_region(MEMORY_DEVICE(dimm),
+                                              &error_abort);
 
     memory_device_unplug_region(machine, mr);
     vmstate_unregister_ram(vmstate_mr, DEVICE(dimm));
@@ -235,12 +239,11 @@ static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
 static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md,
                                            Error **errp)
 {
-    /* dropping const here is fine as we don't touch the memory region */
-    PCDIMMDevice *dimm = PC_DIMM(md);
-    const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(md);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
     MemoryRegion *mr;
 
-    mr = ddc->get_memory_region(dimm, errp);
+    /* dropping const here is fine as we don't touch the memory region */
+    mr = mdc->get_memory_region((MemoryDeviceState *)md, errp);
     if (!mr) {
         return 0;
     }
@@ -248,6 +251,12 @@ static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md,
     return memory_region_size(mr);
 }
 
+static MemoryRegion *pc_dimm_md_get_memory_region(MemoryDeviceState *md,
+                                                  Error **errp)
+{
+    return pc_dimm_get_memory_region(PC_DIMM(md), errp);
+}
+
 static void pc_dimm_md_fill_device_info(const MemoryDeviceState *md,
                                         MemoryDeviceInfo *info)
 {
@@ -289,13 +298,13 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
     dc->props = pc_dimm_properties;
     dc->desc = "DIMM memory module";
 
-    ddc->get_memory_region = pc_dimm_get_memory_region;
     ddc->get_vmstate_memory_region = pc_dimm_get_memory_region;
 
     mdc->get_addr = pc_dimm_md_get_addr;
     /* for a dimm plugged_size == region_size */
     mdc->get_plugged_size = pc_dimm_md_get_region_size;
     mdc->get_region_size = pc_dimm_md_get_region_size;
+    mdc->get_memory_region = pc_dimm_md_get_memory_region;
     mdc->fill_device_info = pc_dimm_md_fill_device_info;
 }
 
-- 
2.18.0.rc1.1.g3f1ff2140
