Received: from eggs.gnu.org ([2001:4830:134:3::10]:52592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOliP-00086p-2e
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOliL-0000uT-48
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOliK-0000tn-SS
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:49 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  4 Jan 2017 13:34:14 +0000
Message-Id: <20170104133414.6524-15-stefanha@redhat.com>
In-Reply-To: <20170104133414.6524-1-stefanha@redhat.com>
References: <20170104133414.6524-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 14/14] iothread: add poll-grow and poll-shrink
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

These parameters control the poll time self-tuning algorithm.  They are
optional and will default to sane values if omitted.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161201192652.9509-14-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/sysemu/iothread.h |  2 ++
 iothread.c                | 56 +++++++++++++++++++++++++++++++++++++----------
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 314e163..e6da1a4 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -31,6 +31,8 @@ typedef struct {
 
     /* AioContext poll parameters */
     int64_t poll_max_ns;
+    int64_t poll_grow;
+    int64_t poll_shrink;
 } IOThread;
 
 #define IOTHREAD(obj) \
diff --git a/iothread.c b/iothread.c
index 28598b5..7bedde8 100644
--- a/iothread.c
+++ b/iothread.c
@@ -98,7 +98,10 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
         return;
     }
 
-    aio_context_set_poll_params(iothread->ctx, iothread->poll_max_ns, 0, 0,
+    aio_context_set_poll_params(iothread->ctx,
+                                iothread->poll_max_ns,
+                                iothread->poll_grow,
+                                iothread->poll_shrink,
                                 &local_error);
     if (local_error) {
         error_propagate(errp, local_error);
@@ -129,18 +132,37 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
     qemu_mutex_unlock(&iothread->init_done_lock);
 }
 
-static void iothread_get_poll_max_ns(Object *obj, Visitor *v,
+typedef struct {
+    const char *name;
+    ptrdiff_t offset; /* field's byte offset in IOThread struct */
+} PollParamInfo;
+
+static PollParamInfo poll_max_ns_info = {
+    "poll-max-ns", offsetof(IOThread, poll_max_ns),
+};
+static PollParamInfo poll_grow_info = {
+    "poll-grow", offsetof(IOThread, poll_grow),
+};
+static PollParamInfo poll_shrink_info = {
+    "poll-shrink", offsetof(IOThread, poll_shrink),
+};
+
+static void iothread_get_poll_param(Object *obj, Visitor *v,
         const char *name, void *opaque, Error **errp)
 {
     IOThread *iothread = IOTHREAD(obj);
+    PollParamInfo *info = opaque;
+    int64_t *field = (void *)iothread + info->offset;
 
-    visit_type_int64(v, name, &iothread->poll_max_ns, errp);
+    visit_type_int64(v, name, field, errp);
 }
 
-static void iothread_set_poll_max_ns(Object *obj, Visitor *v,
+static void iothread_set_poll_param(Object *obj, Visitor *v,
         const char *name, void *opaque, Error **errp)
 {
     IOThread *iothread = IOTHREAD(obj);
+    PollParamInfo *info = opaque;
+    int64_t *field = (void *)iothread + info->offset;
     Error *local_err = NULL;
     int64_t value;
 
@@ -150,15 +172,19 @@ static void iothread_set_poll_max_ns(Object *obj, Visitor *v,
     }
 
     if (value < 0) {
-        error_setg(&local_err, "poll_max_ns value must be in range "
-                   "[0, %"PRId64"]", INT64_MAX);
+        error_setg(&local_err, "%s value must be in range [0, %"PRId64"]",
+                   info->name, INT64_MAX);
         goto out;
     }
 
-    iothread->poll_max_ns = value;
+    *field = value;
 
     if (iothread->ctx) {
-        aio_context_set_poll_params(iothread->ctx, value, 0, 0, &local_err);
+        aio_context_set_poll_params(iothread->ctx,
+                                    iothread->poll_max_ns,
+                                    iothread->poll_grow,
+                                    iothread->poll_shrink,
+                                    &local_err);
     }
 
 out:
@@ -171,9 +197,17 @@ static void iothread_class_init(ObjectClass *klass, void *class_data)
     ucc->complete = iothread_complete;
 
     object_class_property_add(klass, "poll-max-ns", "int",
-                              iothread_get_poll_max_ns,
-                              iothread_set_poll_max_ns,
-                              NULL, NULL, &error_abort);
+                              iothread_get_poll_param,
+                              iothread_set_poll_param,
+                              NULL, &poll_max_ns_info, &error_abort);
+    object_class_property_add(klass, "poll-grow", "int",
+                              iothread_get_poll_param,
+                              iothread_set_poll_param,
+                              NULL, &poll_grow_info, &error_abort);
+    object_class_property_add(klass, "poll-shrink", "int",
+                              iothread_get_poll_param,
+                              iothread_set_poll_param,
+                              NULL, &poll_shrink_info, &error_abort);
 }
 
 static const TypeInfo iothread_info = {
-- 
2.9.3
