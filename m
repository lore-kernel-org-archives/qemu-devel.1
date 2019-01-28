Received: from eggs.gnu.org ([209.51.188.92]:41928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7oD-0004OL-AN
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7oB-000295-64
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:22:44 -0500
Received: from m15-113.126.com ([220.181.15.113]:56449)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7o1-00022Z-L7
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:22:43 -0500
From: Fei Li <lifei1214@126.com>
Date: Mon, 28 Jan 2019 22:22:11 +0800
Message-Id: <20190128142217.12979-4-lifei1214@126.com>
In-Reply-To: <20190128142217.12979-1-lifei1214@126.com>
References: <20190128142217.12979-1-lifei1214@126.com>
Subject: [Qemu-devel] [PATCH for-4.0 10/11] qemu_thread: supplement error
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
Cc: Markus Armbruster <armbru@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Fei Li <fli@suse.com>

From: Fei Li <fli@suse.com>

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
index 5712f1f501..1371895513 100644
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
+        return true;
+    }
 
     q = vnc_queue_init();
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread,
-                       q, QEMU_THREAD_DETACHED, &error_abort);
+    if (qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread,
+                           q, QEMU_THREAD_DETACHED, errp) < 0) {
+        vnc_queue_clear(q);
+        return false;
+    }
     queue = q; /* Set global queue */
+
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
index 6002d09407..2ab920f1a7 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3255,7 +3255,9 @@ void vnc_display_init(const char *id, Error **errp)
     vd->connections_limit = 32;
 
     qemu_mutex_init(&vd->mutex);
-    vnc_start_worker_thread();
+    if (!vnc_start_worker_thread(errp)) {
+        return;
+    }
 
     vd->dcl.ops = &dcl_ops;
     register_displaychangelistener(&vd->dcl);
-- 
2.17.2 (Apple Git-113)
