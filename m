Received: from eggs.gnu.org ([2001:4830:134:3::10]:41191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1jp-0007dJ-0t
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1jm-0002bE-4F
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:49 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cS1jl-0002Ze-Qd
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:46 -0500
Received: by mail-wm0-x244.google.com with SMTP id r126so11633605wmr.3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 05:17:45 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 13 Jan 2017 14:17:26 +0100
Message-Id: <20170113131731.1246-12-pbonzini@redhat.com>
In-Reply-To: <20170113131731.1246-1-pbonzini@redhat.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 11/16] block: explicitly acquire aiocontext in
 callbacks that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com

This covers both file descriptor callbacks and polling callbacks,
since they execute related code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 aio-posix.c           |  7 -------
 aio-win32.c           |  6 ------
 block/curl.c          | 16 +++++++++++++---
 block/iscsi.c         |  4 ++++
 block/linux-aio.c     |  4 ++++
 block/nfs.c           |  6 ++++++
 block/sheepdog.c      | 29 +++++++++++++++--------------
 block/ssh.c           | 29 +++++++++--------------------
 block/win32-aio.c     | 10 ++++++----
 hw/block/virtio-blk.c |  5 ++++-
 hw/scsi/virtio-scsi.c |  6 ++++++
 nbd/server.c          |  4 ++++
 12 files changed, 71 insertions(+), 55 deletions(-)

diff --git a/aio-posix.c b/aio-posix.c
index 8d79cf3..6beebcd 100644
--- a/aio-posix.c
+++ b/aio-posix.c
@@ -402,9 +402,7 @@ static bool aio_dispatch_handlers(AioContext *ctx)
             (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR)) &&
             aio_node_check(ctx, node->is_external) &&
             node->io_read) {
-            aio_context_acquire(ctx);
             node->io_read(node->opaque);
-            aio_context_release(ctx);
 
             /* aio_notify() does not count as progress */
             if (node->opaque != &ctx->notifier) {
@@ -415,9 +413,7 @@ static bool aio_dispatch_handlers(AioContext *ctx)
             (revents & (G_IO_OUT | G_IO_ERR)) &&
             aio_node_check(ctx, node->is_external) &&
             node->io_write) {
-            aio_context_acquire(ctx);
             node->io_write(node->opaque);
-            aio_context_release(ctx);
             progress = true;
         }
 
@@ -617,10 +613,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
         start = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     }
 
-    aio_context_acquire(ctx);
     progress = try_poll_mode(ctx, blocking);
-    aio_context_release(ctx);
-
     if (!progress) {
         assert(npfd == 0);
 
diff --git a/aio-win32.c b/aio-win32.c
index 810e1c6..20b63ce 100644
--- a/aio-win32.c
+++ b/aio-win32.c
@@ -266,9 +266,7 @@ static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
             (revents || event_notifier_get_handle(node->e) == event) &&
             node->io_notify) {
             node->pfd.revents = 0;
-            aio_context_acquire(ctx);
             node->io_notify(node->e);
-            aio_context_release(ctx);
 
             /* aio_notify() does not count as progress */
             if (node->e != &ctx->notifier) {
@@ -280,15 +278,11 @@ static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
             (node->io_read || node->io_write)) {
             node->pfd.revents = 0;
             if ((revents & G_IO_IN) && node->io_read) {
-                aio_context_acquire(ctx);
                 node->io_read(node->opaque);
-                aio_context_release(ctx);
                 progress = true;
             }
             if ((revents & G_IO_OUT) && node->io_write) {
-                aio_context_acquire(ctx);
                 node->io_write(node->opaque);
-                aio_context_release(ctx);
                 progress = true;
             }
 
diff --git a/block/curl.c b/block/curl.c
index 65e6da1..05b9ca3 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -386,9 +386,8 @@ static void curl_multi_check_completion(BDRVCURLState *s)
     }
 }
 
-static void curl_multi_do(void *arg)
+static void curl_multi_do_locked(CURLState *s)
 {
-    CURLState *s = (CURLState *)arg;
     CURLSocket *socket, *next_socket;
     int running;
     int r;
@@ -406,12 +405,23 @@ static void curl_multi_do(void *arg)
     }
 }
 
+static void curl_multi_do(void *arg)
+{
+    CURLState *s = (CURLState *)arg;
+
+    aio_context_acquire(s->s->aio_context);
+    curl_multi_do_locked(s);
+    aio_context_release(s->s->aio_context);
+}
+
 static void curl_multi_read(void *arg)
 {
     CURLState *s = (CURLState *)arg;
 
-    curl_multi_do(arg);
+    aio_context_acquire(s->s->aio_context);
+    curl_multi_do_locked(s);
     curl_multi_check_completion(s->s);
+    aio_context_release(s->s->aio_context);
 }
 
 static void curl_multi_timeout_do(void *arg)
diff --git a/block/iscsi.c b/block/iscsi.c
index e1f10d6..54d1381 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -394,8 +394,10 @@ iscsi_process_read(void *arg)
     IscsiLun *iscsilun = arg;
     struct iscsi_context *iscsi = iscsilun->iscsi;
 
+    aio_context_acquire(iscsilun->aio_context);
     iscsi_service(iscsi, POLLIN);
     iscsi_set_events(iscsilun);
+    aio_context_release(iscsilun->aio_context);
 }
 
 static void
@@ -404,8 +406,10 @@ iscsi_process_write(void *arg)
     IscsiLun *iscsilun = arg;
     struct iscsi_context *iscsi = iscsilun->iscsi;
 
+    aio_context_acquire(iscsilun->aio_context);
     iscsi_service(iscsi, POLLOUT);
     iscsi_set_events(iscsilun);
+    aio_context_release(iscsilun->aio_context);
 }
 
 static int64_t sector_lun2qemu(int64_t sector, IscsiLun *iscsilun)
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 03ab741..277c016 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -251,7 +251,9 @@ static void qemu_laio_completion_cb(EventNotifier *e)
     LinuxAioState *s = container_of(e, LinuxAioState, e);
 
     if (event_notifier_test_and_clear(&s->e)) {
+        aio_context_acquire(s->aio_context);
         qemu_laio_process_completions_and_submit(s);
+        aio_context_release(s->aio_context);
     }
 }
 
@@ -265,7 +267,9 @@ static bool qemu_laio_poll_cb(void *opaque)
         return false;
     }
 
+    aio_context_acquire(s->aio_context);
     qemu_laio_process_completions_and_submit(s);
+    aio_context_release(s->aio_context);
     return true;
 }
 
diff --git a/block/nfs.c b/block/nfs.c
index a564340..803faf9 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -207,15 +207,21 @@ static void nfs_set_events(NFSClient *client)
 static void nfs_process_read(void *arg)
 {
     NFSClient *client = arg;
+
+    aio_context_acquire(client->aio_context);
     nfs_service(client->context, POLLIN);
     nfs_set_events(client);
+    aio_context_release(client->aio_context);
 }
 
 static void nfs_process_write(void *arg)
 {
     NFSClient *client = arg;
+
+    aio_context_acquire(client->aio_context);
     nfs_service(client->context, POLLOUT);
     nfs_set_events(client);
+    aio_context_release(client->aio_context);
 }
 
 static void nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)
diff --git a/block/sheepdog.c b/block/sheepdog.c
index f757157..32c4e4c 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -575,13 +575,6 @@ static coroutine_fn int send_co_req(int sockfd, SheepdogReq *hdr, void *data,
     return ret;
 }
 
-static void restart_co_req(void *opaque)
-{
-    Coroutine *co = opaque;
-
-    qemu_coroutine_enter(co);
-}
-
 typedef struct SheepdogReqCo {
     int sockfd;
     BlockDriverState *bs;
@@ -592,12 +585,19 @@ typedef struct SheepdogReqCo {
     unsigned int *rlen;
     int ret;
     bool finished;
+    Coroutine *co;
 } SheepdogReqCo;
 
+static void restart_co_req(void *opaque)
+{
+    SheepdogReqCo *srco = opaque;
+
+    aio_co_wake(srco->co);
+}
+
 static coroutine_fn void do_co_req(void *opaque)
 {
     int ret;
-    Coroutine *co;
     SheepdogReqCo *srco = opaque;
     int sockfd = srco->sockfd;
     SheepdogReq *hdr = srco->hdr;
@@ -605,9 +605,9 @@ static coroutine_fn void do_co_req(void *opaque)
     unsigned int *wlen = srco->wlen;
     unsigned int *rlen = srco->rlen;
 
-    co = qemu_coroutine_self();
+    srco->co = qemu_coroutine_self();
     aio_set_fd_handler(srco->aio_context, sockfd, false,
-                       NULL, restart_co_req, NULL, co);
+                       NULL, restart_co_req, NULL, srco);
 
     ret = send_co_req(sockfd, hdr, data, wlen);
     if (ret < 0) {
@@ -615,7 +615,7 @@ static coroutine_fn void do_co_req(void *opaque)
     }
 
     aio_set_fd_handler(srco->aio_context, sockfd, false,
-                       restart_co_req, NULL, NULL, co);
+                       restart_co_req, NULL, NULL, srco);
 
     ret = qemu_co_recv(sockfd, hdr, sizeof(*hdr));
     if (ret != sizeof(*hdr)) {
@@ -643,6 +643,7 @@ out:
     aio_set_fd_handler(srco->aio_context, sockfd, false,
                        NULL, NULL, NULL, NULL);
 
+    srco->co = NULL;
     srco->ret = ret;
     srco->finished = true;
     if (srco->bs) {
@@ -866,7 +867,7 @@ static void coroutine_fn aio_read_response(void *opaque)
          * We've finished all requests which belong to the AIOCB, so
          * we can switch back to sd_co_readv/writev now.
          */
-        qemu_coroutine_enter(acb->coroutine);
+        aio_co_wake(acb->coroutine);
     }
 
     return;
@@ -883,14 +884,14 @@ static void co_read_response(void *opaque)
         s->co_recv = qemu_coroutine_create(aio_read_response, opaque);
     }
 
-    qemu_coroutine_enter(s->co_recv);
+    aio_co_wake(s->co_recv);
 }
 
 static void co_write_request(void *opaque)
 {
     BDRVSheepdogState *s = opaque;
 
-    qemu_coroutine_enter(s->co_send);
+    aio_co_wake(s->co_send);
 }
 
 /*
diff --git a/block/ssh.c b/block/ssh.c
index e0edf20..835932e 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -889,10 +889,14 @@ static void restart_coroutine(void *opaque)
 
     DPRINTF("co=%p", co);
 
-    qemu_coroutine_enter(co);
+    aio_co_wake(co);
 }
 
-static coroutine_fn void set_fd_handler(BDRVSSHState *s, BlockDriverState *bs)
+/* A non-blocking call returned EAGAIN, so yield, ensuring the
+ * handlers are set up so that we'll be rescheduled when there is an
+ * interesting event on the socket.
+ */
+static coroutine_fn void co_yield(BDRVSSHState *s, BlockDriverState *bs)
 {
     int r;
     IOHandler *rd_handler = NULL, *wr_handler = NULL;
@@ -912,25 +916,10 @@ static coroutine_fn void set_fd_handler(BDRVSSHState *s, BlockDriverState *bs)
 
     aio_set_fd_handler(bdrv_get_aio_context(bs), s->sock,
                        false, rd_handler, wr_handler, NULL, co);
-}
-
-static coroutine_fn void clear_fd_handler(BDRVSSHState *s,
-                                          BlockDriverState *bs)
-{
-    DPRINTF("s->sock=%d", s->sock);
-    aio_set_fd_handler(bdrv_get_aio_context(bs), s->sock,
-                       false, NULL, NULL, NULL, NULL);
-}
-
-/* A non-blocking call returned EAGAIN, so yield, ensuring the
- * handlers are set up so that we'll be rescheduled when there is an
- * interesting event on the socket.
- */
-static coroutine_fn void co_yield(BDRVSSHState *s, BlockDriverState *bs)
-{
-    set_fd_handler(s, bs);
     qemu_coroutine_yield();
-    clear_fd_handler(s, bs);
+    DPRINTF("s->sock=%d - back", s->sock);
+    aio_set_fd_handler(bdrv_get_aio_context(bs), s->sock, false,
+                       NULL, NULL, NULL, NULL);
 }
 
 /* SFTP has a function `libssh2_sftp_seek64' which seeks to a position
diff --git a/block/win32-aio.c b/block/win32-aio.c
index 8cdf73b..c3f8f1a 100644
--- a/block/win32-aio.c
+++ b/block/win32-aio.c
@@ -41,7 +41,7 @@ struct QEMUWin32AIOState {
     HANDLE hIOCP;
     EventNotifier e;
     int count;
-    bool is_aio_context_attached;
+    AioContext *aio_ctx;
 };
 
 typedef struct QEMUWin32AIOCB {
@@ -88,7 +88,9 @@ static void win32_aio_process_completion(QEMUWin32AIOState *s,
     }
 
 
+    aio_context_acquire(s->aio_ctx);
     waiocb->common.cb(waiocb->common.opaque, ret);
+    aio_context_release(s->aio_ctx);
     qemu_aio_unref(waiocb);
 }
 
@@ -176,13 +178,13 @@ void win32_aio_detach_aio_context(QEMUWin32AIOState *aio,
                                   AioContext *old_context)
 {
     aio_set_event_notifier(old_context, &aio->e, false, NULL, NULL);
-    aio->is_aio_context_attached = false;
+    aio->aio_ctx = NULL;
 }
 
 void win32_aio_attach_aio_context(QEMUWin32AIOState *aio,
                                   AioContext *new_context)
 {
-    aio->is_aio_context_attached = true;
+    aio->aio_ctx = new_context;
     aio_set_event_notifier(new_context, &aio->e, false,
                            win32_aio_completion_cb, NULL);
 }
@@ -212,7 +214,7 @@ out_free_state:
 
 void win32_aio_cleanup(QEMUWin32AIOState *aio)
 {
-    assert(!aio->is_aio_context_attached);
+    assert(!aio->aio_ctx);
     CloseHandle(aio->hIOCP);
     event_notifier_cleanup(&aio->e);
     g_free(aio);
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 702eda8..a00ee38 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -150,7 +150,8 @@ static void virtio_blk_ioctl_complete(void *opaque, int status)
 {
     VirtIOBlockIoctlReq *ioctl_req = opaque;
     VirtIOBlockReq *req = ioctl_req->req;
-    VirtIODevice *vdev = VIRTIO_DEVICE(req->dev);
+    VirtIOBlock *s = req->dev;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
     struct virtio_scsi_inhdr *scsi;
     struct sg_io_hdr *hdr;
 
@@ -586,6 +587,7 @@ void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq)
     VirtIOBlockReq *req;
     MultiReqBuffer mrb = {};
 
+    aio_context_acquire(blk_get_aio_context(s->blk));
     blk_io_plug(s->blk);
 
     do {
@@ -607,6 +609,7 @@ void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq)
     }
 
     blk_io_unplug(s->blk);
+    aio_context_release(blk_get_aio_context(s->blk));
 }
 
 static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index ce19eff..5d9718a 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -440,9 +440,11 @@ void virtio_scsi_handle_ctrl_vq(VirtIOSCSI *s, VirtQueue *vq)
 {
     VirtIOSCSIReq *req;
 
+    virtio_scsi_acquire(s);
     while ((req = virtio_scsi_pop_req(s, vq))) {
         virtio_scsi_handle_ctrl_req(s, req);
     }
+    virtio_scsi_release(s);
 }
 
 static void virtio_scsi_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
@@ -598,6 +600,7 @@ void virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq)
 
     QTAILQ_HEAD(, VirtIOSCSIReq) reqs = QTAILQ_HEAD_INITIALIZER(reqs);
 
+    virtio_scsi_acquire(s);
     do {
         virtio_queue_set_notification(vq, 0);
 
@@ -624,6 +627,7 @@ void virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq)
     QTAILQ_FOREACH_SAFE(req, &reqs, next, next) {
         virtio_scsi_handle_cmd_req_submit(s, req);
     }
+    virtio_scsi_release(s);
 }
 
 static void virtio_scsi_handle_cmd(VirtIODevice *vdev, VirtQueue *vq)
@@ -754,9 +758,11 @@ out:
 
 void virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
 {
+    virtio_scsi_acquire(s);
     if (s->events_dropped) {
         virtio_scsi_push_event(s, NULL, VIRTIO_SCSI_T_NO_EVENT, 0);
     }
+    virtio_scsi_release(s);
 }
 
 static void virtio_scsi_handle_event(VirtIODevice *vdev, VirtQueue *vq)
diff --git a/nbd/server.c b/nbd/server.c
index efe5cb8..08fb720 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1366,6 +1366,10 @@ static void nbd_restart_write(void *opaque)
 static void nbd_set_handlers(NBDClient *client)
 {
     if (client->exp && client->exp->ctx) {
+        /* Note that the handlers do not expect any concurrency; qemu-nbd
+         * does not instantiate multiple AioContexts yet, nor does it call
+         * aio_poll/aio_dispatch from multiple threads.
+         */
         aio_set_fd_handler(client->exp->ctx, client->sioc->fd, true,
                            client->can_read ? nbd_read : NULL,
                            client->send_coroutine ? nbd_restart_write : NULL,
-- 
2.9.3
