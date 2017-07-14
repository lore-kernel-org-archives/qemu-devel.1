Received: from eggs.gnu.org ([2001:4830:134:3::10]:33904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVq8s-0003Ud-TA
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVq8o-0001Dn-U4
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVq8o-0001D6-FW
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F7B980B56
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 02:15:37 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 14 Jul 2017 10:14:59 +0800
Message-Id: <20170714021509.23681-11-famz@redhat.com>
In-Reply-To: <20170714021509.23681-1-famz@redhat.com>
References: <20170714021509.23681-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 10/20] dimm: Convert to DEFINE_PROP_LINK
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
2.9.4
