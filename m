Received: from eggs.gnu.org ([2001:4830:134:3::10]:50899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fb2vS-0000jq-KX
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fb2vR-0002by-Cj
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46352 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fb2vR-0002b2-8K
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0E554023132
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 11:59:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  5 Jul 2018 13:59:36 +0200
Message-Id: <20180705115943.29402-5-david@redhat.com>
In-Reply-To: <20180705115943.29402-1-david@redhat.com>
References: <20180705115943.29402-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 04/11] memory-device: convert
 get_region_size() to get_memory_region()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>

To factor out plugging and unplugging of memory device we need access to
the memory region. So let's replace get_region_size() by
get_memory_region().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 10 ++++++----
 hw/mem/pc-dimm.c               | 19 ++++++++++++++-----
 include/hw/mem/memory-device.h |  2 +-
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 3ac0d5e505..a69ae343f8 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -56,11 +56,13 @@ static int memory_device_used_region_size(Object *obj, void *opaque)
 
     if (object_dynamic_cast(obj, TYPE_MEMORY_DEVICE)) {
         const DeviceState *dev = DEVICE(obj);
-        const MemoryDeviceState *md = MEMORY_DEVICE(obj);
+        MemoryDeviceState *md = MEMORY_DEVICE(obj);
         const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
 
         if (dev->realized) {
-            *size += mdc->get_region_size(md, &error_abort);
+            MemoryRegion *mr = mdc->get_memory_region(md, &error_abort);
+
+            *size += memory_region_size(mr);
         }
     }
 
@@ -162,12 +164,12 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
     /* find address range that will fit new memory device */
     object_child_foreach(OBJECT(ms), memory_device_build_list, &list);
     for (item = list; item; item = g_slist_next(item)) {
-        const MemoryDeviceState *md = item->data;
+        MemoryDeviceState *md = item->data;
         const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(OBJECT(md));
         uint64_t md_size, md_addr;
 
         md_addr = mdc->get_addr(md);
-        md_size = mdc->get_region_size(md, &error_abort);
+        md_size = memory_region_size(mdc->get_memory_region(md, &error_abort));
         if (*errp) {
             goto out;
         }
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 4bf1a0acc9..a208b17c64 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -236,8 +236,8 @@ static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
     return dimm->addr;
 }
 
-static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md,
-                                           Error **errp)
+static uint64_t pc_dimm_md_get_plugged_size(const MemoryDeviceState *md,
+                                            Error **errp)
 {
     /* dropping const here is fine as we don't touch the memory region */
     PCDIMMDevice *dimm = PC_DIMM(md);
@@ -249,9 +249,19 @@ static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md,
         return 0;
     }
 
+    /* for a dimm plugged_size == region_size */
     return memory_region_size(mr);
 }
 
+static MemoryRegion *pc_dimm_md_get_memory_region(MemoryDeviceState *md,
+                                                  Error **errp)
+{
+    PCDIMMDevice *dimm = PC_DIMM(md);
+    const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(md);
+
+    return ddc->get_memory_region(dimm, errp);
+}
+
 static void pc_dimm_md_fill_device_info(const MemoryDeviceState *md,
                                         MemoryDeviceInfo *info)
 {
@@ -297,9 +307,8 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
     ddc->get_vmstate_memory_region = pc_dimm_get_memory_region;
 
     mdc->get_addr = pc_dimm_md_get_addr;
-    /* for a dimm plugged_size == region_size */
-    mdc->get_plugged_size = pc_dimm_md_get_region_size;
-    mdc->get_region_size = pc_dimm_md_get_region_size;
+    mdc->get_plugged_size = pc_dimm_md_get_plugged_size;
+    mdc->get_memory_region = pc_dimm_md_get_memory_region;
     mdc->fill_device_info = pc_dimm_md_fill_device_info;
 }
 
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index f02b229837..852fd8f98a 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -34,7 +34,7 @@ typedef struct MemoryDeviceClass {
 
     uint64_t (*get_addr)(const MemoryDeviceState *md);
     uint64_t (*get_plugged_size)(const MemoryDeviceState *md, Error **errp);
-    uint64_t (*get_region_size)(const MemoryDeviceState *md, Error **errp);
+    MemoryRegion *(*get_memory_region)(MemoryDeviceState *md, Error **errp);
     void (*fill_device_info)(const MemoryDeviceState *md,
                              MemoryDeviceInfo *info);
 } MemoryDeviceClass;
-- 
2.17.1
