Received: from eggs.gnu.org ([2001:4830:134:3::10]:41715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZI-00045U-1D
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZG-00034W-Ls
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHZG-000340-DP
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F6918553F
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:44:13 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:37 +0800
Message-Id: <20170704064347.7022-11-famz@redhat.com>
In-Reply-To: <20170704064347.7022-1-famz@redhat.com>
References: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/20] dimm: Convert to DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Unlike the usual object_property_add_link() invocations in other
devices, dimm checks the "is mapped" state of the backend in addition to
qdev_prop_allow_set_link_before_realize. To convert it without
specializing DEFINE_PROP_LINK which always uses the qdev general check
callback, move the extra check to device realize time.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/mem/nvdimm.c          | 11 +++++++----
 hw/mem/pc-dimm.c         | 42 ++++++++++++++----------------------------
 include/hw/mem/pc-dimm.h |  3 ++-
 3 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index db896b0..b22f271 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -80,7 +80,8 @@ static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm)
 
 static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
 {
-    MemoryRegion *mr = host_memory_backend_get_memory(dimm->hostmem, errp);
+    MemoryRegion *mr = host_memory_backend_get_memory(MEMORY_BACKEND(dimm->hostmem),
+                                                      errp);
     NVDIMMDevice *nvdimm = NVDIMM(dimm);
     uint64_t align, pmem_size, size = memory_region_size(mr);
 
@@ -91,7 +92,7 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
     pmem_size = QEMU_ALIGN_DOWN(pmem_size, align);
 
     if (size <= nvdimm->label_size || !pmem_size) {
-        HostMemoryBackend *hostmem = dimm->hostmem;
+        HostMemoryBackend *hostmem = MEMORY_BACKEND(dimm->hostmem);
         char *path = object_get_canonical_path_component(OBJECT(hostmem));
 
         error_setg(errp, "the size of memdev %s (0x%" PRIx64 ") is too "
@@ -136,14 +137,16 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
 
     memcpy(nvdimm->label_data + offset, buf, size);
 
-    mr = host_memory_backend_get_memory(dimm->hostmem, &error_abort);
+    mr = host_memory_backend_get_memory(MEMORY_BACKEND(dimm->hostmem),
+                                        &error_abort);
     backend_offset = memory_region_size(mr) - nvdimm->label_size + offset;
     memory_region_set_dirty(mr, backend_offset, size);
 }
 
 static MemoryRegion *nvdimm_get_vmstate_memory_region(PCDIMMDevice *dimm)
 {
-    return host_memory_backend_get_memory(dimm->hostmem, &error_abort);
+    return host_memory_backend_get_memory(MEMORY_BACKEND(dimm->hostmem),
+                                          &error_abort);
 }
 
 static void nvdimm_class_init(ObjectClass *oc, void *data)
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 5e23495..eb8deca 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -184,7 +184,7 @@ int qmp_pc_dimm_device_list(Object *obj, void *opaque)
             di->node = dimm->node;
             di->size = object_property_get_uint(OBJECT(dimm), PC_DIMM_SIZE_PROP,
                                                 NULL);
-            di->memdev = object_get_canonical_path(OBJECT(dimm->hostmem));
+            di->memdev = object_get_canonical_path(dimm->hostmem);
 
             info->u.dimm.data = di;
             elem->value = info;
@@ -350,6 +350,8 @@ static Property pc_dimm_properties[] = {
     DEFINE_PROP_UINT32(PC_DIMM_NODE_PROP, PCDIMMDevice, node, 0),
     DEFINE_PROP_INT32(PC_DIMM_SLOT_PROP, PCDIMMDevice, slot,
                       PC_DIMM_UNASSIGNED_SLOT),
+    DEFINE_PROP_LINK(PC_DIMM_MEMDEV_PROP, PCDIMMDevice, hostmem,
+                     TYPE_MEMORY_BACKEND),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -367,33 +369,10 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
     visit_type_uint64(v, name, &value, errp);
 }
 
-static void pc_dimm_check_memdev_is_busy(const Object *obj, const char *name,
-                                      Object *val, Error **errp)
-{
-    Error *local_err = NULL;
-
-    if (host_memory_backend_is_mapped(MEMORY_BACKEND(val))) {
-        char *path = object_get_canonical_path_component(val);
-        error_setg(&local_err, "can't use already busy memdev: %s", path);
-        g_free(path);
-    } else {
-        qdev_prop_allow_set_link_before_realize(obj, name, val, &local_err);
-    }
-
-    error_propagate(errp, local_err);
-}
-
 static void pc_dimm_init(Object *obj)
 {
-    PCDIMMDevice *dimm = PC_DIMM(obj);
-
     object_property_add(obj, PC_DIMM_SIZE_PROP, "uint64", pc_dimm_get_size,
                         NULL, NULL, NULL, &error_abort);
-    object_property_add_link(obj, PC_DIMM_MEMDEV_PROP, TYPE_MEMORY_BACKEND,
-                             (Object **)&dimm->hostmem,
-                             pc_dimm_check_memdev_is_busy,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
 }
 
 static void pc_dimm_realize(DeviceState *dev, Error **errp)
@@ -404,6 +383,11 @@ static void pc_dimm_realize(DeviceState *dev, Error **errp)
     if (!dimm->hostmem) {
         error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property is not set");
         return;
+    } else if (host_memory_backend_is_mapped(MEMORY_BACKEND(dimm->hostmem))) {
+        char *path = object_get_canonical_path_component(dimm->hostmem);
+        error_setg(errp, "can't use already busy memdev: %s", path);
+        g_free(path);
+        return;
     }
     if (((nb_numa_nodes > 0) && (dimm->node >= nb_numa_nodes)) ||
         (!nb_numa_nodes && dimm->node)) {
@@ -417,24 +401,26 @@ static void pc_dimm_realize(DeviceState *dev, Error **errp)
         ddc->realize(dimm, errp);
     }
 
-    host_memory_backend_set_mapped(dimm->hostmem, true);
+    host_memory_backend_set_mapped(MEMORY_BACKEND(dimm->hostmem), true);
 }
 
 static void pc_dimm_unrealize(DeviceState *dev, Error **errp)
 {
     PCDIMMDevice *dimm = PC_DIMM(dev);
 
-    host_memory_backend_set_mapped(dimm->hostmem, false);
+    host_memory_backend_set_mapped(MEMORY_BACKEND(dimm->hostmem), false);
 }
 
 static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm)
 {
-    return host_memory_backend_get_memory(dimm->hostmem, &error_abort);
+    return host_memory_backend_get_memory(MEMORY_BACKEND(dimm->hostmem),
+                                          &error_abort);
 }
 
 static MemoryRegion *pc_dimm_get_vmstate_memory_region(PCDIMMDevice *dimm)
 {
-    return host_memory_backend_get_memory(dimm->hostmem, &error_abort);
+    return host_memory_backend_get_memory(MEMORY_BACKEND(dimm->hostmem),
+                                          &error_abort);
 }
 
 static void pc_dimm_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 1e483f2..ea903f5 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -53,7 +53,8 @@ typedef struct PCDIMMDevice {
     uint64_t addr;
     uint32_t node;
     int32_t slot;
-    HostMemoryBackend *hostmem;
+    /* HostMemoryBackend pointer to be filled by link property */
+    Object *hostmem;
 } PCDIMMDevice;
 
 /**
-- 
2.9.4
