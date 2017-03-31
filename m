Received: from eggs.gnu.org ([2001:4830:134:3::10]:54907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cts8d-0008QP-CI
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cts8Y-00021s-F1
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:42:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:21496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cts8Y-00020h-3W
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:42:26 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Fri, 31 Mar 2017 16:41:44 +0800
Message-Id: <20170331084147.32716-2-haozhong.zhang@intel.com>
In-Reply-To: <20170331084147.32716-1-haozhong.zhang@intel.com>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC PATCH 1/4] pc-dimm: add 'reserved-size' to
 reserve address range after the ending address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dan.j.williams@intel.com, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

If option 'reserved-size=RSVD' is present, QEMU will reserve an
address range of size 'RSVD' after the ending address of pc-dimm
device.

For the following example,
    -object memory-backend-file,id=mem0,size=4G,...
    -device nvdimm,id=dimm0,memdev=mem0,reserved-size=4K,...
    -device pc-dimm,id=dimm1,...
if dimm0 is allocated to address N ~ N+4G, the address range of
dimm1 will start from N+4G+4K or higher.

Its current usage is to reserve spaces for flush hint addresses
of nvdimm devices.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 hw/mem/pc-dimm.c         | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 include/hw/mem/pc-dimm.h |  2 ++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 9e8dab0..13dcd71 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -28,6 +28,7 @@
 #include "sysemu/kvm.h"
 #include "trace.h"
 #include "hw/virtio/vhost.h"
+#include "exec/address-spaces.h"
 
 typedef struct pc_dimms_capacity {
      uint64_t size;
@@ -44,7 +45,12 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
     Error *local_err = NULL;
     uint64_t existing_dimms_capacity = 0;
-    uint64_t addr;
+    uint64_t addr, size = memory_region_size(mr);
+
+    size += object_property_get_int(OBJECT(dimm), PC_DIMM_RSVD_PROP, &local_err);
+    if (local_err) {
+        goto out;
+    }
 
     addr = object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP, &local_err);
     if (local_err) {
@@ -54,7 +60,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
     addr = pc_dimm_get_free_addr(hpms->base,
                                  memory_region_size(&hpms->mr),
                                  !addr ? NULL : &addr, align,
-                                 memory_region_size(mr), &local_err);
+                                 size, &local_err);
     if (local_err) {
         goto out;
     }
@@ -64,7 +70,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
         goto out;
     }
 
-    if (existing_dimms_capacity + memory_region_size(mr) >
+    if (existing_dimms_capacity + size >
         machine->maxram_size - machine->ram_size) {
         error_setg(&local_err, "not enough space, currently 0x%" PRIx64
                    " in use of total hot pluggable 0x" RAM_ADDR_FMT,
@@ -315,6 +321,9 @@ uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
         PCDIMMDevice *dimm = item->data;
         uint64_t dimm_size = object_property_get_int(OBJECT(dimm),
                                                      PC_DIMM_SIZE_PROP,
+                                                     errp) +
+                             object_property_get_int(OBJECT(dimm),
+                                                     PC_DIMM_RSVD_PROP,
                                                      errp);
         if (errp && *errp) {
             goto out;
@@ -382,6 +391,37 @@ static void pc_dimm_check_memdev_is_busy(Object *obj, const char *name,
     error_propagate(errp, local_err);
 }
 
+static void pc_dimm_get_reserved_size(Object *obj, Visitor *v, const char *name,
+                                      void *opaque, Error **errp)
+{
+    PCDIMMDevice *dimm = PC_DIMM(obj);
+    uint64_t value = dimm->reserved_size;
+
+    visit_type_size(v, name, &value, errp);
+}
+
+static void pc_dimm_set_reserved_size(Object *obj, Visitor *v, const char *name,
+                                      void *opaque, Error **errp)
+{
+    PCDIMMDevice *dimm = PC_DIMM(obj);
+    Error *local_err = NULL;
+    uint64_t value;
+
+    if (dimm->reserved_size) {
+        error_setg(&local_err, "cannot change 'reserved-size'");
+        goto out;
+    }
+
+    visit_type_size(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    dimm->reserved_size = value;
+
+ out:
+    error_propagate(errp, local_err);
+}
+
 static void pc_dimm_init(Object *obj)
 {
     PCDIMMDevice *dimm = PC_DIMM(obj);
@@ -393,6 +433,8 @@ static void pc_dimm_init(Object *obj)
                              pc_dimm_check_memdev_is_busy,
                              OBJ_PROP_LINK_UNREF_ON_RELEASE,
                              &error_abort);
+    object_property_add(obj, PC_DIMM_RSVD_PROP, "int", pc_dimm_get_reserved_size,
+                        pc_dimm_set_reserved_size, NULL, NULL, &error_abort);
 }
 
 static void pc_dimm_realize(DeviceState *dev, Error **errp)
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 1e483f2..99c4dfd 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -33,6 +33,7 @@
 #define PC_DIMM_NODE_PROP "node"
 #define PC_DIMM_SIZE_PROP "size"
 #define PC_DIMM_MEMDEV_PROP "memdev"
+#define PC_DIMM_RSVD_PROP "reserved-size"
 
 #define PC_DIMM_UNASSIGNED_SLOT -1
 
@@ -53,6 +54,7 @@ typedef struct PCDIMMDevice {
     uint64_t addr;
     uint32_t node;
     int32_t slot;
+    uint64_t reserved_size;
     HostMemoryBackend *hostmem;
 } PCDIMMDevice;
 
-- 
2.10.1
