Received: from eggs.gnu.org ([2001:4830:134:3::10]:41166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAsu-0002sD-Fg
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAst-0001KW-Ew
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:00 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAst-0001Ju-8L
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:14:59 -0400
Received: by mail-wm0-x244.google.com with SMTP id o78-v6so24237693wmg.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:14:59 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-189-60.clienti.tiscali.it.
	[78.12.189.60]) by smtp.gmail.com with ESMTPSA id
	c15-v6sm14020129edr.78.2018.05.08.15.14.56
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 08 May 2018 15:14:57 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:23 +0200
Message-Id: <1525817687-34620-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/30] memdev: remove "id" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The "id" property is unnecessary and can be replaced simply with
object_get_canonical_path_component.  This patch mostly undoes commit
e1ff3c67e8 ("monitor: fix qmp/hmp query-memdev not reporting IDs of
memory backends", 2017-01-12).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/hostmem.c       | 26 --------------------------
 include/sysemu/hostmem.h |  1 -
 numa.c                   |  2 +-
 qom/object_interfaces.c  |  6 ------
 4 files changed, 1 insertion(+), 34 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 6a0c474..3627e61 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -369,24 +369,6 @@ host_memory_backend_can_be_deleted(UserCreatable *uc)
     }
 }
 
-static char *get_id(Object *o, Error **errp)
-{
-    HostMemoryBackend *backend = MEMORY_BACKEND(o);
-
-    return g_strdup(backend->id);
-}
-
-static void set_id(Object *o, const char *str, Error **errp)
-{
-    HostMemoryBackend *backend = MEMORY_BACKEND(o);
-
-    if (backend->id) {
-        error_setg(errp, "cannot change property value");
-        return;
-    }
-    backend->id = g_strdup(str);
-}
-
 static bool host_memory_backend_get_share(Object *o, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(o);
@@ -434,18 +416,11 @@ host_memory_backend_class_init(ObjectClass *oc, void *data)
         &HostMemPolicy_lookup,
         host_memory_backend_get_policy,
         host_memory_backend_set_policy, &error_abort);
-    object_class_property_add_str(oc, "id", get_id, set_id, &error_abort);
     object_class_property_add_bool(oc, "share",
         host_memory_backend_get_share, host_memory_backend_set_share,
         &error_abort);
 }
 
-static void host_memory_backend_finalize(Object *o)
-{
-    HostMemoryBackend *backend = MEMORY_BACKEND(o);
-    g_free(backend->id);
-}
-
 static const TypeInfo host_memory_backend_info = {
     .name = TYPE_MEMORY_BACKEND,
     .parent = TYPE_OBJECT,
@@ -454,7 +429,6 @@ static const TypeInfo host_memory_backend_info = {
     .class_init = host_memory_backend_class_init,
     .instance_size = sizeof(HostMemoryBackend),
     .instance_init = host_memory_backend_init,
-    .instance_finalize = host_memory_backend_finalize,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index bc36899..5beb0ef 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -52,7 +52,6 @@ struct HostMemoryBackend {
     Object parent;
 
     /* protected */
-    char *id;
     uint64_t size;
     bool merge, dump;
     bool prealloc, force_prealloc, is_mapped, share;
diff --git a/numa.c b/numa.c
index 70b150e..aac22a9 100644
--- a/numa.c
+++ b/numa.c
@@ -580,7 +580,7 @@ static int query_memdev(Object *obj, void *opaque)
 
         m->value = g_malloc0(sizeof(*m->value));
 
-        m->value->id = object_property_get_str(obj, "id", NULL);
+        m->value->id = object_get_canonical_path_component(obj);
         m->value->has_id = !!m->value->id;
 
         m->value->size = object_property_get_uint(obj, "size",
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 980ffc2..72b97a8 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -65,12 +65,6 @@ Object *user_creatable_add_type(const char *type, const char *id,
 
     assert(qdict);
     obj = object_new(type);
-    if (object_property_find(obj, "id", NULL)) {
-        object_property_set_str(obj, id, "id", &local_err);
-        if (local_err) {
-            goto out;
-        }
-    }
     visit_start_struct(v, NULL, NULL, 0, &local_err);
     if (local_err) {
         goto out;
-- 
1.8.3.1
