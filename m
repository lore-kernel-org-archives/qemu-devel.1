Received: from eggs.gnu.org ([2001:4830:134:3::10]:50285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fx9DH-0001L2-4j
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fx9DG-0006Nv-3d
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:39 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:52209)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1fx9DF-0006Mo-Nl
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:37 -0400
From: Fei Li <fli@suse.com>
Date: Tue,  4 Sep 2018 19:08:19 +0800
Message-Id: <20180904110822.12863-3-fli@suse.com>
In-Reply-To: <20180904110822.12863-1-fli@suse.com>
References: <20180904110822.12863-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH 2/5] ui/vnc.c: polish vnc_init_func
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fli@suse.com

Add a new Error parameter to vnc_display_init() and handle the Error
in its caller: vnc_init_func() just like vnc_display_open() does. And
let the call trace propagate the Error.

Signed-off-by: Fei Li <fli@suse.com>
---
 include/ui/console.h |  2 +-
 ui/vnc-jobs.c        |  2 +-
 ui/vnc-jobs.h        |  2 +-
 ui/vnc.c             | 15 ++++++++++++---
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index fb969caf70..c17803c530 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -453,7 +453,7 @@ void qemu_display_early_init(DisplayOptions *opts);
 void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
 
 /* vnc.c */
-void vnc_display_init(const char *id);
+void vnc_display_init(const char *id, Error **errp);
 void vnc_display_open(const char *id, Error **errp);
 void vnc_display_add_client(const char *id, int csock, bool skipauth);
 int vnc_display_password(const char *id, const char *password);
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 929391f85d..7c05a1e6df 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -331,7 +331,7 @@ static bool vnc_worker_thread_running(void)
     return queue; /* Check global queue */
 }
 
-void vnc_start_worker_thread(void)
+void vnc_start_worker_thread(Error **errp)
 {
     VncJobQueue *q;
 
diff --git a/ui/vnc-jobs.h b/ui/vnc-jobs.h
index 59f66bcc35..31eb482582 100644
--- a/ui/vnc-jobs.h
+++ b/ui/vnc-jobs.h
@@ -37,7 +37,7 @@ void vnc_job_push(VncJob *job);
 void vnc_jobs_join(VncState *vs);
 
 void vnc_jobs_consume_buffer(VncState *vs);
-void vnc_start_worker_thread(void);
+void vnc_start_worker_thread(Error **errp);
 
 /* Locks */
 static inline int vnc_trylock_display(VncDisplay *vd)
diff --git a/ui/vnc.c b/ui/vnc.c
index ccb1335d86..ff22bbc055 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3206,9 +3206,10 @@ static const DisplayChangeListenerOps dcl_ops = {
     .dpy_cursor_define    = vnc_dpy_cursor_define,
 };
 
-void vnc_display_init(const char *id)
+void vnc_display_init(const char *id, Error **errp)
 {
     VncDisplay *vd;
+    Error *local_err = NULL;
 
     if (vnc_display_find(id) != NULL) {
         return;
@@ -3236,7 +3237,11 @@ void vnc_display_init(const char *id)
     vd->connections_limit = 32;
 
     qemu_mutex_init(&vd->mutex);
-    vnc_start_worker_thread();
+    vnc_start_worker_thread(&local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     vd->dcl.ops = &dcl_ops;
     register_displaychangelistener(&vd->dcl);
@@ -4079,7 +4084,11 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
     char *id = (char *)qemu_opts_id(opts);
 
     assert(id);
-    vnc_display_init(id);
+    vnc_display_init(id, &local_err);
+    if (local_err) {
+        error_reportf_err(local_err, "Failed to init VNC server: ");
+        exit(1);
+    }
     vnc_display_open(id, &local_err);
     if (local_err != NULL) {
         error_reportf_err(local_err, "Failed to start VNC server: ");
-- 
2.13.7
