Received: from eggs.gnu.org ([209.51.188.92]:41927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7oD-0004OI-2k
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7oB-00028z-66
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:22:44 -0500
Received: from m15-113.126.com ([220.181.15.113]:56550)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7oA-00026W-2R
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:22:43 -0500
From: Fei Li <lifei1214@126.com>
Date: Mon, 28 Jan 2019 22:22:08 +0800
Message-Id: <20190128142217.12979-1-lifei1214@126.com>
Subject: [Qemu-devel] [PATCH for-4.0 07/11] qemu_thread: supplement error
 handling for iothread_complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: Markus Armbruster <armbru@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Fei Li <fli@suse.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Fei Li <fli@suse.com>

For iothread_complete: utilize the existed errp to propagate the
error and do the corresponding cleanup to replace the temporary
&error_abort.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
---
 iothread.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/iothread.c b/iothread.c
index 8e8aa01999..ea2e553dc5 100644
--- a/iothread.c
+++ b/iothread.c
@@ -148,6 +148,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
     Error *local_error = NULL;
     IOThread *iothread = IOTHREAD(obj);
     char *name, *thread_name;
+    int thread_ok;
 
     iothread->stopping = false;
     iothread->running = true;
@@ -164,9 +165,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
                                 &local_error);
     if (local_error) {
         error_propagate(errp, local_error);
-        aio_context_unref(iothread->ctx);
-        iothread->ctx = NULL;
-        return;
+        goto fail;
     }
 
     qemu_mutex_init(&iothread->init_done_lock);
@@ -178,11 +177,15 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
      */
     name = object_get_canonical_path_component(OBJECT(obj));
     thread_name = g_strdup_printf("IO %s", name);
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&iothread->thread, thread_name, iothread_run,
-                       iothread, QEMU_THREAD_JOINABLE, &error_abort);
+    thread_ok = qemu_thread_create(&iothread->thread, thread_name, iothread_run,
+                                   iothread, QEMU_THREAD_JOINABLE, errp);
     g_free(thread_name);
     g_free(name);
+    if (thread_ok < 0) {
+        qemu_cond_destroy(&iothread->init_done_cond);
+        qemu_mutex_destroy(&iothread->init_done_lock);
+        goto fail;
+    }
 
     /* Wait for initialization to complete */
     qemu_mutex_lock(&iothread->init_done_lock);
@@ -191,6 +194,10 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
                        &iothread->init_done_lock);
     }
     qemu_mutex_unlock(&iothread->init_done_lock);
+    return;
+fail:
+    aio_context_unref(iothread->ctx);
+    iothread->ctx = NULL;
 }
 
 typedef struct {
-- 
2.17.2 (Apple Git-113)
