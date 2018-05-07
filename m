Received: from eggs.gnu.org ([2001:4830:134:3::10]:50529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFdIT-0001tn-37
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFdIP-00049m-3v
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:23:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fFdIO-00049i-VM
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:23:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3956B406C76B
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 10:23:01 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  7 May 2018 12:22:54 +0200
Message-Id: <20180507102254.12107-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] vnc: add magic cookie to VncState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Set magic cookie on initialization.  Clear on cleanup.  Sprinkle a bunch
of assert()s checking the cookie, to verify the pointer is valid.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.h      |  3 +++
 ui/vnc-jobs.c |  4 ++++
 ui/vnc.c      | 10 +++++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 7b29def77d..762632929b 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -255,8 +255,11 @@ typedef enum {
     VNC_STATE_UPDATE_FORCE,
 } VncStateUpdate;
 
+#define VNC_MAGIC ((uint64_t)0x05b3f069b3d204bb)
+
 struct VncState
 {
+    uint64_t magic;
     QIOChannelSocket *sioc; /* The underlying socket */
     QIOChannel *ioc; /* The channel currently used for I/O */
     guint ioc_tag;
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 868dddef4b..b0b15d42a8 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -82,6 +82,7 @@ VncJob *vnc_job_new(VncState *vs)
 {
     VncJob *job = g_new0(VncJob, 1);
 
+    assert(vs->magic == VNC_MAGIC);
     job->vs = vs;
     vnc_lock_queue(queue);
     QLIST_INIT(&job->rectangles);
@@ -214,6 +215,7 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
     /* Here job can only be NULL if queue->exit is true */
     job = QTAILQ_FIRST(&queue->jobs);
     vnc_unlock_queue(queue);
+    assert(job->vs->magic == VNC_MAGIC);
 
     if (queue->exit) {
         return -1;
@@ -236,6 +238,7 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
 
     /* Make a local copy of vs and switch output buffers */
     vnc_async_encoding_start(job->vs, &vs);
+    vs.magic = VNC_MAGIC;
 
     /* Start sending rectangles */
     n_rectangles = 0;
@@ -289,6 +292,7 @@ disconnected:
     vnc_unlock_queue(queue);
     qemu_cond_broadcast(&queue->cond);
     g_free(job);
+    vs.magic = 0;
     return 0;
 }
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 5526e54f48..359693238b 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1138,6 +1138,7 @@ static void audio_capture_notify(void *opaque, audcnotification_e cmd)
 {
     VncState *vs = opaque;
 
+    assert(vs->magic == VNC_MAGIC);
     switch (cmd) {
     case AUD_CNOTIFY_DISABLE:
         vnc_lock_output(vs);
@@ -1167,6 +1168,7 @@ static void audio_capture(void *opaque, void *buf, int size)
 {
     VncState *vs = opaque;
 
+    assert(vs->magic == VNC_MAGIC);
     vnc_lock_output(vs);
     if (vs->output.offset < vs->throttle_output_offset) {
         vnc_write_u8(vs, VNC_MSG_SERVER_QEMU);
@@ -1275,6 +1277,7 @@ void vnc_disconnect_finish(VncState *vs)
     vs->ioc = NULL;
     object_unref(OBJECT(vs->sioc));
     vs->sioc = NULL;
+    vs->magic = 0;
     g_free(vs);
 }
 
@@ -1414,7 +1417,7 @@ static void vnc_client_write_locked(VncState *vs)
 
 static void vnc_client_write(VncState *vs)
 {
-
+    assert(vs->magic == VNC_MAGIC);
     vnc_lock_output(vs);
     if (vs->output.offset) {
         vnc_client_write_locked(vs);
@@ -1487,6 +1490,7 @@ static void vnc_jobs_bh(void *opaque)
 {
     VncState *vs = opaque;
 
+    assert(vs->magic == VNC_MAGIC);
     vnc_jobs_consume_buffer(vs);
 }
 
@@ -1537,6 +1541,8 @@ gboolean vnc_client_io(QIOChannel *ioc G_GNUC_UNUSED,
                        GIOCondition condition, void *opaque)
 {
     VncState *vs = opaque;
+
+    assert(vs->magic == VNC_MAGIC);
     if (condition & G_IO_IN) {
         if (vnc_client_read(vs) < 0) {
             /* vs is free()ed here */
@@ -1568,6 +1574,7 @@ gboolean vnc_client_io(QIOChannel *ioc G_GNUC_UNUSED,
 
 void vnc_write(VncState *vs, const void *data, size_t len)
 {
+    assert(vs->magic == VNC_MAGIC);
     if (vs->disconnecting) {
         return;
     }
@@ -3064,6 +3071,7 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
     int i;
 
     trace_vnc_client_connect(vs, sioc);
+    vs->magic = VNC_MAGIC;
     vs->sioc = sioc;
     object_ref(OBJECT(vs->sioc));
     vs->ioc = QIO_CHANNEL(sioc);
-- 
2.9.3
