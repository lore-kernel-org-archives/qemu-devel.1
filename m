Received: from eggs.gnu.org ([2001:4830:134:3::10]:33905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVq8s-0003Ue-TC
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVq8q-0001EW-OI
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVq8q-0001EF-Do
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76DA37CE06
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 02:15:39 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 14 Jul 2017 10:15:00 +0800
Message-Id: <20170714021509.23681-12-famz@redhat.com>
In-Reply-To: <20170714021509.23681-1-famz@redhat.com>
References: <20170714021509.23681-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 11/20] ivshmem: Convert to DEFINE_PROP_LINK
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
 hw/misc/ivshmem.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 97beaf6..4b38248 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1009,18 +1009,6 @@ static const TypeInfo ivshmem_common_info = {
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
@@ -1037,6 +1025,8 @@ static const VMStateDescription ivshmem_plain_vmsd = {
 
 static Property ivshmem_plain_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("master", IVShmemState, master, ON_OFF_AUTO_OFF),
+    DEFINE_PROP_LINK("memdev", IVShmemState, hostmem, TYPE_MEMORY_BACKEND,
+                     HostMemoryBackend *),
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
 
@@ -1059,6 +1044,11 @@ static void ivshmem_plain_realize(PCIDevice *dev, Error **errp)
     if (!s->hostmem) {
         error_setg(errp, "You must specify a 'memdev'");
         return;
+    } else if (host_memory_backend_is_mapped(s->hostmem)) {
+        char *path = object_get_canonical_path_component(OBJECT(s->hostmem));
+        error_setg(errp, "can't use already busy memdev: %s", path);
+        g_free(path);
+        return;
     }
 
     ivshmem_common_realize(dev, errp);
-- 
2.9.4
