Received: from eggs.gnu.org ([2001:4830:134:3::10]:41739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZN-00049N-1g
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZI-00035X-N1
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHZI-000357-E8
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68A56A0212
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:44:15 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:38 +0800
Message-Id: <20170704064347.7022-12-famz@redhat.com>
In-Reply-To: <20170704064347.7022-1-famz@redhat.com>
References: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 11/20] ivshmem: Convert to DEFINE_PROP_LINK
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
devices, ivshmem checks the "is mapped" state of the backend in addition
to qdev_prop_allow_set_link_before_realize. To convert it without
specializing DEFINE_PROP_LINK which always uses the qdev callback, move
the extra check to device realize time.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/misc/ivshmem.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 97beaf6..e318427 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -87,7 +87,8 @@ typedef struct IVShmemState {
     uint32_t features;
 
     /* exactly one of these two may be set */
-    HostMemoryBackend *hostmem; /* with interrupts */
+    Object *hostmem; /* HostMemoryBackend pointer to be filled by link
+                        property, used with interrupts */
     CharBackend server_chr; /* without interrupts */
 
     /* registers */
@@ -864,7 +865,7 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
     if (s->hostmem != NULL) {
         IVSHMEM_DPRINTF("using hostmem\n");
 
-        s->ivshmem_bar2 = host_memory_backend_get_memory(s->hostmem,
+        s->ivshmem_bar2 = host_memory_backend_get_memory(MEMORY_BACKEND(s->hostmem),
                                                          &error_abort);
     } else {
         Chardev *chr = qemu_chr_fe_get_driver(&s->server_chr);
@@ -1009,18 +1010,6 @@ static const TypeInfo ivshmem_common_info = {
     .class_init    = ivshmem_common_class_init,
 };
 
-static void ivshmem_check_memdev_is_busy(const Object *obj, const char *name,
-                                         Object *val, Error **errp)
-{
-    if (host_memory_backend_is_mapped(MEMORY_BACKEND(val))) {
-        char *path = object_get_canonical_path_component(val);
-        error_setg(errp, "can't use already busy memdev: %s", path);
-        g_free(path);
-    } else {
-        qdev_prop_allow_set_link_before_realize(obj, name, val, errp);
-    }
-}
-
 static const VMStateDescription ivshmem_plain_vmsd = {
     .name = TYPE_IVSHMEM_PLAIN,
     .version_id = 0,
@@ -1037,6 +1026,7 @@ static const VMStateDescription ivshmem_plain_vmsd = {
 
 static Property ivshmem_plain_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("master", IVShmemState, master, ON_OFF_AUTO_OFF),
+    DEFINE_PROP_LINK("memdev", IVShmemState, hostmem, TYPE_MEMORY_BACKEND),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1044,11 +1034,6 @@ static void ivshmem_plain_init(Object *obj)
 {
     IVShmemState *s = IVSHMEM_PLAIN(obj);
 
-    object_property_add_link(obj, "memdev", TYPE_MEMORY_BACKEND,
-                             (Object **)&s->hostmem,
-                             ivshmem_check_memdev_is_busy,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
     s->not_legacy_32bit = 1;
 }
 
@@ -1059,17 +1044,22 @@ static void ivshmem_plain_realize(PCIDevice *dev, Error **errp)
     if (!s->hostmem) {
         error_setg(errp, "You must specify a 'memdev'");
         return;
+    } else if (host_memory_backend_is_mapped(MEMORY_BACKEND(s->hostmem))) {
+        char *path = object_get_canonical_path_component(s->hostmem);
+        error_setg(errp, "can't use already busy memdev: %s", path);
+        g_free(path);
+        return;
     }
 
     ivshmem_common_realize(dev, errp);
-    host_memory_backend_set_mapped(s->hostmem, true);
+    host_memory_backend_set_mapped(MEMORY_BACKEND(s->hostmem), true);
 }
 
 static void ivshmem_plain_exit(PCIDevice *pci_dev)
 {
     IVShmemState *s = IVSHMEM_COMMON(pci_dev);
 
-    host_memory_backend_set_mapped(s->hostmem, false);
+    host_memory_backend_set_mapped(MEMORY_BACKEND(s->hostmem), false);
 }
 
 static void ivshmem_plain_class_init(ObjectClass *klass, void *data)
@@ -1245,7 +1235,7 @@ static void desugar_shm(IVShmemState *s)
     object_property_add_child(OBJECT(s), "internal-shm-backend", obj,
                               &error_abort);
     user_creatable_complete(obj, &error_abort);
-    s->hostmem = MEMORY_BACKEND(obj);
+    s->hostmem = obj;
 }
 
 static void ivshmem_realize(PCIDevice *dev, Error **errp)
-- 
2.9.4
