Received: from eggs.gnu.org ([2001:4830:134:3::10]:52470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOli6-0007lM-Oz
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOli5-0000n4-TO
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOli5-0000mo-Ks
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:33 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  4 Jan 2017 13:34:07 +0000
Message-Id: <20170104133414.6524-8-stefanha@redhat.com>
In-Reply-To: <20170104133414.6524-1-stefanha@redhat.com>
References: <20170104133414.6524-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 07/14] iothread: add polling parameters
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

Poll mode can be configured with -object iothread,poll-max-ns=NUM.
Polling is disabled with a value of 0 nanoseconds.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161201192652.9509-7-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/sysemu/iothread.h |  3 +++
 iothread.c                | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 68ac2de..314e163 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -28,6 +28,9 @@ typedef struct {
     QemuCond init_done_cond;    /* is thread initialization done? */
     bool stopping;
     int thread_id;
+
+    /* AioContext poll parameters */
+    int64_t poll_max_ns;
 } IOThread;
 
 #define IOTHREAD(obj) \
diff --git a/iothread.c b/iothread.c
index bd70344..8dfd10d 100644
--- a/iothread.c
+++ b/iothread.c
@@ -98,6 +98,15 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
         return;
     }
 
+    aio_context_set_poll_params(iothread->ctx, iothread->poll_max_ns,
+                                &local_error);
+    if (local_error) {
+        error_propagate(errp, local_error);
+        aio_context_unref(iothread->ctx);
+        iothread->ctx = NULL;
+        return;
+    }
+
     qemu_mutex_init(&iothread->init_done_lock);
     qemu_cond_init(&iothread->init_done_cond);
 
@@ -120,10 +129,51 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
     qemu_mutex_unlock(&iothread->init_done_lock);
 }
 
+static void iothread_get_poll_max_ns(Object *obj, Visitor *v,
+        const char *name, void *opaque, Error **errp)
+{
+    IOThread *iothread = IOTHREAD(obj);
+
+    visit_type_int64(v, name, &iothread->poll_max_ns, errp);
+}
+
+static void iothread_set_poll_max_ns(Object *obj, Visitor *v,
+        const char *name, void *opaque, Error **errp)
+{
+    IOThread *iothread = IOTHREAD(obj);
+    Error *local_err = NULL;
+    int64_t value;
+
+    visit_type_int64(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    if (value < 0) {
+        error_setg(&local_err, "poll_max_ns value must be in range "
+                   "[0, %"PRId64"]", INT64_MAX);
+        goto out;
+    }
+
+    iothread->poll_max_ns = value;
+
+    if (iothread->ctx) {
+        aio_context_set_poll_params(iothread->ctx, value, &local_err);
+    }
+
+out:
+    error_propagate(errp, local_err);
+}
+
 static void iothread_class_init(ObjectClass *klass, void *class_data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(klass);
     ucc->complete = iothread_complete;
+
+    object_class_property_add(klass, "poll-max-ns", "int",
+                              iothread_get_poll_max_ns,
+                              iothread_set_poll_max_ns,
+                              NULL, NULL, &error_abort);
 }
 
 static const TypeInfo iothread_info = {
-- 
2.9.3
