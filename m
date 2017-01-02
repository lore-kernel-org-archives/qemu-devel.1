Received: from eggs.gnu.org ([2001:4830:134:3::10]:41685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cO4nF-0001TF-2p
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cO4nD-0001If-Ll
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:45:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cO4nD-0001Hk-Be
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:44:59 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Jan 2017 16:44:50 +0100
Message-Id: <1483371890-289981-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
References: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] fix qmp/hmp query-memdev not repporting
 IDs of memory backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com, eblake@redhat.com, afaerber@suse.de

Do it by adding 'id' property to hostmem backends and fetch it
in query-memdev from object directly.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/qom/object_interfaces.h |  2 +-
 include/sysemu/hostmem.h        |  1 +
 backends/hostmem.c              | 26 ++++++++++++++++++++++++++
 docs/qmp-commands.txt           |  1 +
 hmp.c                           |  5 +----
 numa.c                          |  3 +++
 qapi-schema.json                |  3 +++
 qom/object_interfaces.c         |  6 +++++-
 8 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index fdd7603..06cccd9 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -90,7 +90,7 @@ bool user_creatable_can_be_deleted(UserCreatable *uc, Error **errp);
  * Returns: the newly created object or NULL on error
  */
 Object *user_creatable_add_type(const char *type, const char *id,
-                                const QDict *qdict,
+                                QDict *qdict,
                                 Visitor *v, Error **errp);
 
 /**
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 678232a..ecae0cf 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -52,6 +52,7 @@ struct HostMemoryBackend {
     Object parent;
 
     /* protected */
+    char *id;
     uint64_t size;
     bool merge, dump;
     bool prealloc, force_prealloc, is_mapped;
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 4256d24..7f5de70 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -348,6 +348,24 @@ host_memory_backend_can_be_deleted(UserCreatable *uc, Error **errp)
     }
 }
 
+static char *get_id(Object *o, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(o);
+
+    return g_strdup(backend->id);
+}
+
+static void set_id(Object *o, const char *str, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(o);
+
+    if (backend->id) {
+        error_setg(errp, "cannot change property value");
+        return;
+    }
+    backend->id = g_strdup(str);
+}
+
 static void
 host_memory_backend_class_init(ObjectClass *oc, void *data)
 {
@@ -377,6 +395,13 @@ host_memory_backend_class_init(ObjectClass *oc, void *data)
         HostMemPolicy_lookup,
         host_memory_backend_get_policy,
         host_memory_backend_set_policy, &error_abort);
+    object_class_property_add_str(oc, "id", get_id, set_id, &error_abort);
+}
+
+static void host_memory_backend_finalize(Object *o)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(o);
+    g_free(backend->id);
 }
 
 static const TypeInfo host_memory_backend_info = {
@@ -387,6 +412,7 @@ static const TypeInfo host_memory_backend_info = {
     .class_init = host_memory_backend_class_init,
     .instance_size = sizeof(HostMemoryBackend),
     .instance_init = host_memory_backend_init,
+    .instance_finalize = host_memory_backend_finalize,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
diff --git a/docs/qmp-commands.txt b/docs/qmp-commands.txt
index abf210a..18db4cd 100644
--- a/docs/qmp-commands.txt
+++ b/docs/qmp-commands.txt
@@ -3529,6 +3529,7 @@ Example (1):
          "policy": "bind"
        },
        {
+         "id": "mem1",
          "size": 536870912,
          "merge": false,
          "dump": true,
diff --git a/hmp.c b/hmp.c
index e7bead5..8522efe 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2078,13 +2078,11 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdict)
     MemdevList *m = memdev_list;
     Visitor *v;
     char *str;
-    int i = 0;
-
 
     while (m) {
         v = string_output_visitor_new(false, &str);
         visit_type_uint16List(v, NULL, &m->value->host_nodes, NULL);
-        monitor_printf(mon, "memory backend: %d\n", i);
+        monitor_printf(mon, "memory backend: %s\n", m->value->id);
         monitor_printf(mon, "  size:  %" PRId64 "\n", m->value->size);
         monitor_printf(mon, "  merge: %s\n",
                        m->value->merge ? "true" : "false");
@@ -2100,7 +2098,6 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdict)
         g_free(str);
         visit_free(v);
         m = m->next;
-        i++;
     }
 
     monitor_printf(mon, "\n");
diff --git a/numa.c b/numa.c
index 9c09e45..f5fc7da 100644
--- a/numa.c
+++ b/numa.c
@@ -518,6 +518,9 @@ static int query_memdev(Object *obj, void *opaque)
 
         m->value = g_malloc0(sizeof(*m->value));
 
+        m->value->id = object_property_get_str(obj, "id", NULL);
+        m->value->has_id = !!m->value->id;
+
         m->value->size = object_property_get_int(obj, "size",
                                                  &error_abort);
         m->value->merge = object_property_get_bool(obj, "merge",
diff --git a/qapi-schema.json b/qapi-schema.json
index a0d3b5d..88eb2b9 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4453,6 +4453,8 @@
 #
 # Information about memory backend
 #
+# @id: #optional backend's ID if backend has 'id' property (since 2.9)
+#
 # @size: memory backend size
 #
 # @merge: enables or disables memory merge support
@@ -4469,6 +4471,7 @@
 ##
 { 'struct': 'Memdev',
   'data': {
+    '*id':        'str',
     'size':       'size',
     'merge':      'bool',
     'dump':       'bool',
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 9b4155a..7a8f520 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -4,6 +4,7 @@
 #include "qemu/module.h"
 #include "qapi-visit.h"
 #include "qapi/opts-visitor.h"
+#include "qapi/qmp/qstring.h"
 
 void user_creatable_complete(Object *obj, Error **errp)
 {
@@ -35,7 +36,7 @@ bool user_creatable_can_be_deleted(UserCreatable *uc, Error **errp)
 }
 
 Object *user_creatable_add_type(const char *type, const char *id,
-                                const QDict *qdict,
+                                QDict *qdict,
                                 Visitor *v, Error **errp)
 {
     Object *obj;
@@ -62,6 +63,9 @@ Object *user_creatable_add_type(const char *type, const char *id,
 
     assert(qdict);
     obj = object_new(type);
+    if (object_property_find(obj, "id", NULL)) {
+        qdict_put(qdict, "id", qstring_from_str(id));
+    }
     visit_start_struct(v, NULL, NULL, 0, &local_err);
     if (local_err) {
         goto out;
-- 
2.7.4
