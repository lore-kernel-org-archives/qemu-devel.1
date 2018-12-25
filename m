Received: from eggs.gnu.org ([208.118.235.92]:33269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnL6-0001Yy-5m
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnL5-0003vI-Db
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:44 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:51882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gbnL5-0003un-46
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:43 -0500
From: Fei Li <fli@suse.com>
Date: Tue, 25 Dec 2018 22:04:45 +0800
Message-Id: <20181225140449.15786-13-fli@suse.com>
In-Reply-To: <20181225140449.15786-1-fli@suse.com>
References: <20181225140449.15786-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH for-4.0 v9 12/16] qemu_thread: supplement error
 handling for iothread_complete/qemu_signalfd_compat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: lifei1214@126.com, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

For iothread_complete: utilize the existed errp to propagate the
error and do the corresponding cleanup to replace the temporary
&error_abort.

For qemu_signalfd_compat: add a local_err to hold the error, and
return the corresponding error code to replace the temporary
&error_abort.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
---
 iothread.c      | 17 +++++++++++------
 util/compatfd.c | 11 ++++++++---
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/iothread.c b/iothread.c
index 8e8aa01999..7335dacf0b 100644
--- a/iothread.c
+++ b/iothread.c
@@ -164,9 +164,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
                                 &local_error);
     if (local_error) {
         error_propagate(errp, local_error);
-        aio_context_unref(iothread->ctx);
-        iothread->ctx = NULL;
-        return;
+        goto fail;
     }
 
     qemu_mutex_init(&iothread->init_done_lock);
@@ -178,9 +176,12 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
      */
     name = object_get_canonical_path_component(OBJECT(obj));
     thread_name = g_strdup_printf("IO %s", name);
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&iothread->thread, thread_name, iothread_run,
-                       iothread, QEMU_THREAD_JOINABLE, &error_abort);
+    if (!qemu_thread_create(&iothread->thread, thread_name, iothread_run,
+                            iothread, QEMU_THREAD_JOINABLE, errp)) {
+        g_free(thread_name);
+        g_free(name);
+        goto fail;
+    }
     g_free(thread_name);
     g_free(name);
 
@@ -191,6 +192,10 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
                        &iothread->init_done_lock);
     }
     qemu_mutex_unlock(&iothread->init_done_lock);
+    return;
+fail:
+    aio_context_unref(iothread->ctx);
+    iothread->ctx = NULL;
 }
 
 typedef struct {
diff --git a/util/compatfd.c b/util/compatfd.c
index c3d8448264..9cb13381e4 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -71,6 +71,7 @@ static int qemu_signalfd_compat(const sigset_t *mask)
     struct sigfd_compat_info *info;
     QemuThread thread;
     int fds[2];
+    Error *local_err = NULL;
 
     info = malloc(sizeof(*info));
     if (info == NULL) {
@@ -89,9 +90,13 @@ static int qemu_signalfd_compat(const sigset_t *mask)
     memcpy(&info->mask, mask, sizeof(*mask));
     info->fd = fds[1];
 
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&thread, "signalfd_compat", sigwait_compat,
-                       info, QEMU_THREAD_DETACHED, &error_abort);
+    if (!qemu_thread_create(&thread, "signalfd_compat", sigwait_compat,
+                            info, QEMU_THREAD_DETACHED, &local_err)) {
+        close(fds[0]);
+        close(fds[1]);
+        free(info);
+        return -1;
+    }
 
     return fds[0];
 }
-- 
2.13.7
