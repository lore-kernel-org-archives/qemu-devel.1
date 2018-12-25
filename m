Received: from eggs.gnu.org ([208.118.235.92]:33312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnLL-0001ql-GU
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnLK-00040t-L2
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:59 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:46221)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gbnLK-0003we-Bj
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:58 -0500
From: Fei Li <fli@suse.com>
Date: Tue, 25 Dec 2018 22:04:47 +0800
Message-Id: <20181225140449.15786-15-fli@suse.com>
In-Reply-To: <20181225140449.15786-1-fli@suse.com>
References: <20181225140449.15786-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH for-4.0 v9 14/16] qemu_thread: supplement error
 handling for vnc_start_worker_thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: lifei1214@126.com, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Supplement the error handling for vnc_thread_worker_thread: add
an Error parameter for it to propagate the error to its caller to
handle in case it fails, and make it return a Boolean to indicate
whether it succeeds.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
---
 ui/vnc-jobs.c | 17 +++++++++++------
 ui/vnc-jobs.h |  2 +-
 ui/vnc.c      |  4 +++-
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 5712f1f501..35a652d1fd 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -332,16 +332,21 @@ static bool vnc_worker_thread_running(void)
     return queue; /* Check global queue */
 }
 
-void vnc_start_worker_thread(void)
+bool vnc_start_worker_thread(Error **errp)
 {
     VncJobQueue *q;
 
-    if (vnc_worker_thread_running())
-        return ;
+    if (vnc_worker_thread_running()) {
+        goto out;
+    }
 
     q = vnc_queue_init();
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread,
-                       q, QEMU_THREAD_DETACHED, &error_abort);
+    if (!qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread,
+                            q, QEMU_THREAD_DETACHED, errp)) {
+        vnc_queue_clear(q);
+        return false;
+    }
     queue = q; /* Set global queue */
+out:
+    return true;
 }
diff --git a/ui/vnc-jobs.h b/ui/vnc-jobs.h
index 59f66bcc35..14640593db 100644
--- a/ui/vnc-jobs.h
+++ b/ui/vnc-jobs.h
@@ -37,7 +37,7 @@ void vnc_job_push(VncJob *job);
 void vnc_jobs_join(VncState *vs);
 
 void vnc_jobs_consume_buffer(VncState *vs);
-void vnc_start_worker_thread(void);
+bool vnc_start_worker_thread(Error **errp);
 
 /* Locks */
 static inline int vnc_trylock_display(VncDisplay *vd)
diff --git a/ui/vnc.c b/ui/vnc.c
index 0c1b477425..0ffe9e6a5d 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3236,7 +3236,9 @@ void vnc_display_init(const char *id, Error **errp)
     vd->connections_limit = 32;
 
     qemu_mutex_init(&vd->mutex);
-    vnc_start_worker_thread();
+    if (!vnc_start_worker_thread(errp)) {
+        return;
+    }
 
     vd->dcl.ops = &dcl_ops;
     register_displaychangelistener(&vd->dcl);
-- 
2.13.7
