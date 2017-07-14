Received: from eggs.gnu.org ([2001:4830:134:3::10]:42537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYh-0000Ok-NG
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYg-00054P-4U
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:51 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVxYf-00053x-Q0
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:50 -0400
Received: by mail-wr0-x244.google.com with SMTP id y28so6807577wrd.2
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:10:49 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 12:10:25 +0200
Message-Id: <1500027028-4127-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
References: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 52/55] ivshmem: Convert to DEFINE_PROP_LINK
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
devices, ivshmem checks the "is mapped" state of the backend in addition
to qdev_prop_allow_set_link_before_realize. To convert it without
specializing DEFINE_PROP_LINK which always uses the qdev callback, move
the extra check to device realize time.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170714021509.23681-12-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/ivshmem.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 731f3c1..a58f9ee 100644
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
1.8.3.1
