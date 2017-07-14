Received: from eggs.gnu.org ([2001:4830:134:3::10]:42503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYg-0000Nr-QN
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYe-00053o-Ss
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:50 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVxYe-00053X-Le
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:48 -0400
Received: by mail-wr0-x241.google.com with SMTP id 77so11332499wrb.3
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:10:48 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 12:10:24 +0200
Message-Id: <1500027028-4127-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
References: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 51/55] dimm: Convert to DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Unlike the usual object_property_add_link() invocations in other
devices, dimm checks the "is mapped" state of the backend in addition to
qdev_prop_allow_set_link_before_realize. To convert it without
specializing DEFINE_PROP_LINK which always uses the qdev general check
callback, move the extra check to device realize time.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170714021509.23681-11-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mem/pc-dimm.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 5e23495..ea67b46 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -350,6 +350,8 @@ static Property pc_dimm_properties[] = {
     DEFINE_PROP_UINT32(PC_DIMM_NODE_PROP, PCDIMMDevice, node, 0),
     DEFINE_PROP_INT32(PC_DIMM_SLOT_PROP, PCDIMMDevice, slot,
                       PC_DIMM_UNASSIGNED_SLOT),
+    DEFINE_PROP_LINK(PC_DIMM_MEMDEV_PROP, PCDIMMDevice, hostmem,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
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
+    } else if (host_memory_backend_is_mapped(dimm->hostmem)) {
+        char *path = object_get_canonical_path_component(OBJECT(dimm->hostmem));
+        error_setg(errp, "can't use already busy memdev: %s", path);
+        g_free(path);
+        return;
     }
     if (((nb_numa_nodes > 0) && (dimm->node >= nb_numa_nodes)) ||
         (!nb_numa_nodes && dimm->node)) {
-- 
1.8.3.1
