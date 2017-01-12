Received: from eggs.gnu.org ([2001:4830:134:3::10]:42014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRjee-0000Vt-Lv
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRjed-0000hC-F6
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRjed-0000gl-6Q
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:15 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 12 Jan 2017 15:53:53 -0200
Message-Id: <20170112175356.21701-4-ehabkost@redhat.com>
In-Reply-To: <20170112175356.21701-1-ehabkost@redhat.com>
References: <20170112175356.21701-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] monitor: fix qmp/hmp query-memdev not
 reporting IDs of memory backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Considering 'id' is mandatory for user_creatable objects/backends
and user_creatable_add_type() always has it as an argument
regardless of where from it is called CLI/monitor or QMP,
Fix issue by adding 'id' property to hostmem backends and
set it in user_creatable_add_type() for every object that
implements 'id' property. Then later at query-memdev time
get 'id' from object directly.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1484052795-158195-4-git-send-email-imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/qmp-commands.txt    |  1 +
 qapi-schema.json         |  3 +++
 include/sysemu/hostmem.h |  1 +
 backends/hostmem.c       | 26 ++++++++++++++++++++++++++
 hmp.c                    |  5 +----
 numa.c                   |  3 +++
 qom/object_interfaces.c  |  6 ++++++
 7 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/docs/qmp-commands.txt b/docs/qmp-commands.txt
index abf210a596..18db4cdb82 100644
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
diff --git a/qapi-schema.json b/qapi-schema.json
index eab8d4a9ee..e42998edec 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4457,6 +4457,8 @@
 #
 # Information about memory backend
 #
+# @id: #optional backend's ID if backend has 'id' property (since 2.9)
+#
 # @size: memory backend size
 #
 # @merge: enables or disables memory merge support
@@ -4473,6 +4475,7 @@
 ##
 { 'struct': 'Memdev',
   'data': {
+    '*id':        'str',
     'size':       'size',
     'merge':      'bool',
     'dump':       'bool',
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 678232af40..ecae0cff19 100644
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
index 4256d24acb..7f5de70609 100644
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
diff --git a/hmp.c b/hmp.c
index e7bead5a1d..8522efea26 100644
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
index 9c09e45e7d..f5fc7da3e9 100644
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
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 9b4155a227..03a95c3276 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -62,6 +62,12 @@ Object *user_creatable_add_type(const char *type, const char *id,
 
     assert(qdict);
     obj = object_new(type);
+    if (object_property_find(obj, "id", NULL)) {
+        object_property_set_str(obj, id, "id", &local_err);
+        if (local_err) {
+            goto out;
+        }
+    }
     visit_start_struct(v, NULL, NULL, 0, &local_err);
     if (local_err) {
         goto out;
-- 
2.11.0.259.g40922b1
