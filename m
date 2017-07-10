Received: from eggs.gnu.org ([2001:4830:134:3::10]:33646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUSzx-0000Pw-4G
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUSzv-0000ws-NI
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dUSzv-0000uU-Cj
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54BF781233
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 07:20:46 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Jul 2017 15:20:26 +0800
Message-Id: <20170710072027.7948-5-famz@redhat.com>
In-Reply-To: <20170710072027.7948-1-famz@redhat.com>
References: <20170710072027.7948-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 4/5] Introduce iothread-group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 Makefile.objs             |   2 +-
 include/sysemu/iothread.h |  17 ++++
 iothread-group.c          | 210 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 iothread-group.c

diff --git a/Makefile.objs b/Makefile.objs
index b2e6322..b7ee479 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -40,7 +40,7 @@ io-obj-y = io/
 
 ifeq ($(CONFIG_SOFTMMU),y)
 common-obj-y = blockdev.o blockdev-nbd.o block/
-common-obj-y += iothread.o
+common-obj-y += iothread.o iothread-group.o
 common-obj-y += net/
 common-obj-y += qdev-monitor.o device-hotplug.o
 common-obj-$(CONFIG_WIN32) += os-win32.o
diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index a3a03e8..0cb28c0 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -32,12 +32,29 @@ typedef struct {
     AioContextPollParams poll_params;
 } IOThread;
 
+#define TYPE_IOTHREAD_GROUP "iothread-group"
+
+typedef struct {
+    Object parent_obj;
+
+    int running_threads;
+    AioContext *ctx;
+    AioContextPollParams poll_params;
+    /* Number of iothreads */
+    int64_t size;
+    IOThread **iothreads;
+} IOThreadGroup;
+
 #define IOTHREAD(obj) \
    OBJECT_CHECK(IOThread, obj, TYPE_IOTHREAD)
 
+#define IOTHREAD_GROUP(obj) \
+   OBJECT_CHECK(IOThreadGroup, obj, TYPE_IOTHREAD_GROUP)
+
 char *iothread_get_id(IOThread *iothread);
 void iothread_start(IOThread *iothread, const char *thread_name, Error **errp);
 AioContext *iothread_get_aio_context(IOThread *iothread);
+AioContext *iothread_group_get_aio_context(IOThreadGroup *group);
 void iothread_stop_all(void);
 
 #ifndef _WIN32
diff --git a/iothread-group.c b/iothread-group.c
new file mode 100644
index 0000000..163ca2b
--- /dev/null
+++ b/iothread-group.c
@@ -0,0 +1,210 @@
+/*
+ * Event loop thread group
+ *
+ * Copyright Red Hat Inc., 2013, 2017
+ *
+ * Authors:
+ *  Stefan Hajnoczi   <stefanha@redhat.com>
+ *  Fam Zheng         <famz@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "qom/object_interfaces.h"
+#include "qemu/module.h"
+#include "block/aio.h"
+#include "block/block.h"
+#include "sysemu/iothread.h"
+#include "qmp-commands.h"
+#include "qemu/error-report.h"
+#include "qemu/rcu.h"
+#include "qemu/main-loop.h"
+
+static int iothread_group_stop(Object *object, void *opaque)
+{
+    /* XXX: stop each iothread */
+    return 0;
+}
+
+static void iothread_group_instance_init(Object *obj)
+{
+    IOThreadGroup *group = IOTHREAD_GROUP(obj);
+
+    group->poll_params.max_ns = IOTHREAD_POLL_MAX_NS_DEFAULT;
+    group->size = 1;
+}
+
+static void iothread_group_instance_finalize(Object *obj)
+{
+    IOThreadGroup *group = IOTHREAD_GROUP(obj);
+
+    iothread_group_stop(obj, NULL);
+    if (!group->ctx) {
+        return;
+    }
+    aio_context_unref(group->ctx);
+}
+
+static void iothread_group_complete(UserCreatable *obj, Error **errp)
+{
+    Error *local_err = NULL;
+    IOThreadGroup *group = IOTHREAD_GROUP(obj);
+    char *name, *thread_name;
+    int i;
+
+    group->ctx = aio_context_new(&local_err);
+    if (!group->ctx) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    aio_context_set_poll_params(group->ctx, group->poll_params,
+                                &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        aio_context_unref(group->ctx);
+        group->ctx = NULL;
+        return;
+    }
+
+    /* This assumes we are called from a thread with useful CPU affinity for us
+     * to inherit.
+     */
+    name = object_get_canonical_path_component(OBJECT(obj));
+    group->iothreads = g_new0(IOThread *, group->size);
+    for (i = 0; i < group->size; ++i) {
+        IOThread *iothread = (IOThread *)object_new(TYPE_IOTHREAD);
+
+        /* We've already set up the shared aio context so this should do
+         * nothing, but better be consistent. */
+        iothread->poll_params = group->poll_params;
+        iothread->ctx = group->ctx;
+
+        thread_name = g_strdup_printf("IO %s[%d]", name, i);
+        iothread_start(iothread, thread_name, &local_err);
+        g_free(thread_name);
+        if (local_err) {
+            object_unref(OBJECT(iothread));
+            break;
+        }
+        group->iothreads[i] = iothread;
+    }
+    g_free(name);
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
+}
+
+typedef struct {
+    const char *name;
+    ptrdiff_t offset; /* field's byte offset in IOThreadGroup struct */
+} PropInfo;
+
+static PropInfo size_info = {
+    "size", offsetof(IOThreadGroup, size),
+};
+static PropInfo poll_max_ns_info = {
+    "poll-max-ns", offsetof(IOThreadGroup, poll_params.max_ns),
+};
+static PropInfo poll_grow_info = {
+    "poll-grow", offsetof(IOThreadGroup, poll_params.grow),
+};
+static PropInfo poll_shrink_info = {
+    "poll-shrink", offsetof(IOThreadGroup, poll_params.shrink),
+};
+
+static void iothread_group_get_prop(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    IOThreadGroup *group = IOTHREAD_GROUP(obj);
+    PropInfo *info = opaque;
+    int64_t *field = (void *)group + info->offset;
+
+    visit_type_int64(v, name, field, errp);
+}
+
+static void iothread_group_set_prop(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    IOThreadGroup *group = IOTHREAD_GROUP(obj);
+    PropInfo *info = opaque;
+    int64_t *field = (void *)group + info->offset;
+    Error *local_err = NULL;
+    int64_t value;
+
+    visit_type_int64(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    if (value < 0) {
+        error_setg(&local_err, "%s value must be in range [0, %"PRId64"]",
+                   info->name, INT64_MAX);
+        goto out;
+    }
+
+    *field = value;
+
+    if (group->ctx) {
+        aio_context_set_poll_params(group->ctx,
+                                    group->poll_params,
+                                    &local_err);
+    }
+
+out:
+    error_propagate(errp, local_err);
+}
+
+static void iothread_group_class_init(ObjectClass *klass, void *class_data)
+{
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(klass);
+    ucc->complete = iothread_group_complete;
+
+    object_class_property_add(klass, "size", "int",
+                              iothread_group_get_prop,
+                              iothread_group_set_prop,
+                              NULL, &size_info, &error_abort);
+    object_class_property_add(klass, "poll-max-ns", "int",
+                              iothread_group_get_prop,
+                              iothread_group_set_prop,
+                              NULL, &poll_max_ns_info, &error_abort);
+    object_class_property_add(klass, "poll-grow", "int",
+                              iothread_group_get_prop,
+                              iothread_group_set_prop,
+                              NULL, &poll_grow_info, &error_abort);
+    object_class_property_add(klass, "poll-shrink", "int",
+                              iothread_group_get_prop,
+                              iothread_group_set_prop,
+                              NULL, &poll_shrink_info, &error_abort);
+}
+
+static const TypeInfo iothread_group_info = {
+    .name = TYPE_IOTHREAD_GROUP,
+    .parent = TYPE_OBJECT,
+    .class_init = iothread_group_class_init,
+    .instance_size = sizeof(IOThreadGroup),
+    .instance_init = iothread_group_instance_init,
+    .instance_finalize = iothread_group_instance_finalize,
+    .interfaces = (InterfaceInfo[]) {
+        {TYPE_USER_CREATABLE},
+        {}
+    },
+};
+
+static void iothread_group_register_types(void)
+{
+    type_register_static(&iothread_group_info);
+}
+
+type_init(iothread_group_register_types)
+
+AioContext *iothread_group_get_aio_context(IOThreadGroup *group)
+{
+    return group->ctx;
+}
-- 
2.9.4
