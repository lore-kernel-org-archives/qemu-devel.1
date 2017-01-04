Received: from eggs.gnu.org ([2001:4830:134:3::10]:52432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOli1-0007gm-Dc
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOlhw-0000it-7D
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOlhv-0000iU-V3
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:24 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  4 Jan 2017 13:34:03 +0000
Message-Id: <20170104133414.6524-4-stefanha@redhat.com>
In-Reply-To: <20170104133414.6524-1-stefanha@redhat.com>
References: <20170104133414.6524-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 03/14] aio: add AioPollFn and io_poll() interface
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

The new AioPollFn io_poll() argument to aio_set_fd_handler() and
aio_set_event_handler() is used in the next patch.

Keep this code change separate due to the number of files it touches.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161201192652.9509-3-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio.h         |  5 ++++-
 aio-posix.c                 |  8 +++++---
 async.c                     |  5 +++--
 block/curl.c                |  8 ++++----
 block/iscsi.c               |  3 ++-
 block/linux-aio.c           |  4 ++--
 block/nbd-client.c          |  8 ++++----
 block/nfs.c                 |  7 ++++---
 block/sheepdog.c            | 26 +++++++++++++-------------
 block/ssh.c                 |  4 ++--
 block/win32-aio.c           |  4 ++--
 hw/virtio/virtio.c          |  4 ++--
 iohandler.c                 |  2 +-
 nbd/server.c                |  9 ++++-----
 stubs/set-fd-handler.c      |  1 +
 tests/test-aio.c            |  4 ++--
 util/event_notifier-posix.c |  2 +-
 17 files changed, 56 insertions(+), 48 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index c1519ec..7d9cd0d 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -44,6 +44,7 @@ void qemu_aio_ref(void *p);
 
 typedef struct AioHandler AioHandler;
 typedef void QEMUBHFunc(void *opaque);
+typedef bool AioPollFn(void *opaque);
 typedef void IOHandler(void *opaque);
 
 struct ThreadPool;
@@ -329,6 +330,7 @@ void aio_set_fd_handler(AioContext *ctx,
                         bool is_external,
                         IOHandler *io_read,
                         IOHandler *io_write,
+                        AioPollFn *io_poll,
                         void *opaque);
 
 /* Register an event notifier and associated callbacks.  Behaves very similarly
@@ -341,7 +343,8 @@ void aio_set_fd_handler(AioContext *ctx,
 void aio_set_event_notifier(AioContext *ctx,
                             EventNotifier *notifier,
                             bool is_external,
-                            EventNotifierHandler *io_read);
+                            EventNotifierHandler *io_read,
+                            AioPollFn *io_poll);
 
 /* Return a GSource that lets the main loop poll the file descriptors attached
  * to this AioContext.
diff --git a/aio-posix.c b/aio-posix.c
index 4ac2346..feab8e8 100644
--- a/aio-posix.c
+++ b/aio-posix.c
@@ -200,6 +200,7 @@ void aio_set_fd_handler(AioContext *ctx,
                         bool is_external,
                         IOHandler *io_read,
                         IOHandler *io_write,
+                        AioPollFn *io_poll,
                         void *opaque)
 {
     AioHandler *node;
@@ -258,10 +259,11 @@ void aio_set_fd_handler(AioContext *ctx,
 void aio_set_event_notifier(AioContext *ctx,
                             EventNotifier *notifier,
                             bool is_external,
-                            EventNotifierHandler *io_read)
+                            EventNotifierHandler *io_read,
+                            AioPollFn *io_poll)
 {
-    aio_set_fd_handler(ctx, event_notifier_get_fd(notifier),
-                       is_external, (IOHandler *)io_read, NULL, notifier);
+    aio_set_fd_handler(ctx, event_notifier_get_fd(notifier), is_external,
+                       (IOHandler *)io_read, NULL, io_poll, notifier);
 }
 
 bool aio_prepare(AioContext *ctx)
diff --git a/async.c b/async.c
index 52bdb8f..678845f 100644
--- a/async.c
+++ b/async.c
@@ -282,7 +282,7 @@ aio_ctx_finalize(GSource     *source)
     }
     qemu_mutex_unlock(&ctx->bh_lock);
 
-    aio_set_event_notifier(ctx, &ctx->notifier, false, NULL);
+    aio_set_event_notifier(ctx, &ctx->notifier, false, NULL, NULL);
     event_notifier_cleanup(&ctx->notifier);
     qemu_rec_mutex_destroy(&ctx->lock);
     qemu_mutex_destroy(&ctx->bh_lock);
@@ -366,7 +366,8 @@ AioContext *aio_context_new(Error **errp)
     aio_set_event_notifier(ctx, &ctx->notifier,
                            false,
                            (EventNotifierHandler *)
-                           event_notifier_dummy_cb);
+                           event_notifier_dummy_cb,
+                           NULL);
 #ifdef CONFIG_LINUX_AIO
     ctx->linux_aio = NULL;
 #endif
diff --git a/block/curl.c b/block/curl.c
index 0404c1b..792fef8 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -192,19 +192,19 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
     switch (action) {
         case CURL_POLL_IN:
             aio_set_fd_handler(s->aio_context, fd, false,
-                               curl_multi_read, NULL, state);
+                               curl_multi_read, NULL, NULL, state);
             break;
         case CURL_POLL_OUT:
             aio_set_fd_handler(s->aio_context, fd, false,
-                               NULL, curl_multi_do, state);
+                               NULL, curl_multi_do, NULL, state);
             break;
         case CURL_POLL_INOUT:
             aio_set_fd_handler(s->aio_context, fd, false,
-                               curl_multi_read, curl_multi_do, state);
+                               curl_multi_read, curl_multi_do, NULL, state);
             break;
         case CURL_POLL_REMOVE:
             aio_set_fd_handler(s->aio_context, fd, false,
-                               NULL, NULL, NULL);
+                               NULL, NULL, NULL, NULL);
             break;
     }
 
diff --git a/block/iscsi.c b/block/iscsi.c
index 0960929..6aeeb9e 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -362,6 +362,7 @@ iscsi_set_events(IscsiLun *iscsilun)
                            false,
                            (ev & POLLIN) ? iscsi_process_read : NULL,
                            (ev & POLLOUT) ? iscsi_process_write : NULL,
+                           NULL,
                            iscsilun);
         iscsilun->events = ev;
     }
@@ -1526,7 +1527,7 @@ static void iscsi_detach_aio_context(BlockDriverState *bs)
     IscsiLun *iscsilun = bs->opaque;
 
     aio_set_fd_handler(iscsilun->aio_context, iscsi_get_fd(iscsilun->iscsi),
-                       false, NULL, NULL, NULL);
+                       false, NULL, NULL, NULL, NULL);
     iscsilun->events = 0;
 
     if (iscsilun->nop_timer) {
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 1685ec2..69c4ed5 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -439,7 +439,7 @@ BlockAIOCB *laio_submit(BlockDriverState *bs, LinuxAioState *s, int fd,
 
 void laio_detach_aio_context(LinuxAioState *s, AioContext *old_context)
 {
-    aio_set_event_notifier(old_context, &s->e, false, NULL);
+    aio_set_event_notifier(old_context, &s->e, false, NULL, NULL);
     qemu_bh_delete(s->completion_bh);
 }
 
@@ -448,7 +448,7 @@ void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context)
     s->aio_context = new_context;
     s->completion_bh = aio_bh_new(new_context, qemu_laio_completion_bh, s);
     aio_set_event_notifier(new_context, &s->e, false,
-                           qemu_laio_completion_cb);
+                           qemu_laio_completion_cb, NULL);
 }
 
 LinuxAioState *laio_init(void)
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 3779c6c..06f1532 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -145,7 +145,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
     aio_context = bdrv_get_aio_context(bs);
 
     aio_set_fd_handler(aio_context, s->sioc->fd, false,
-                       nbd_reply_ready, nbd_restart_write, bs);
+                       nbd_reply_ready, nbd_restart_write, NULL, bs);
     if (qiov) {
         qio_channel_set_cork(s->ioc, true);
         rc = nbd_send_request(s->ioc, request);
@@ -161,7 +161,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
         rc = nbd_send_request(s->ioc, request);
     }
     aio_set_fd_handler(aio_context, s->sioc->fd, false,
-                       nbd_reply_ready, NULL, bs);
+                       nbd_reply_ready, NULL, NULL, bs);
     s->send_coroutine = NULL;
     qemu_co_mutex_unlock(&s->send_mutex);
     return rc;
@@ -366,14 +366,14 @@ void nbd_client_detach_aio_context(BlockDriverState *bs)
 {
     aio_set_fd_handler(bdrv_get_aio_context(bs),
                        nbd_get_client_session(bs)->sioc->fd,
-                       false, NULL, NULL, NULL);
+                       false, NULL, NULL, NULL, NULL);
 }
 
 void nbd_client_attach_aio_context(BlockDriverState *bs,
                                    AioContext *new_context)
 {
     aio_set_fd_handler(new_context, nbd_get_client_session(bs)->sioc->fd,
-                       false, nbd_reply_ready, NULL, bs);
+                       false, nbd_reply_ready, NULL, NULL, bs);
 }
 
 void nbd_client_close(BlockDriverState *bs)
diff --git a/block/nfs.c b/block/nfs.c
index a490660..a564340 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -197,7 +197,8 @@ static void nfs_set_events(NFSClient *client)
         aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context),
                            false,
                            (ev & POLLIN) ? nfs_process_read : NULL,
-                           (ev & POLLOUT) ? nfs_process_write : NULL, client);
+                           (ev & POLLOUT) ? nfs_process_write : NULL,
+                           NULL, client);
 
     }
     client->events = ev;
@@ -395,7 +396,7 @@ static void nfs_detach_aio_context(BlockDriverState *bs)
     NFSClient *client = bs->opaque;
 
     aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context),
-                       false, NULL, NULL, NULL);
+                       false, NULL, NULL, NULL, NULL);
     client->events = 0;
 }
 
@@ -415,7 +416,7 @@ static void nfs_client_close(NFSClient *client)
             nfs_close(client->context, client->fh);
         }
         aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context),
-                           false, NULL, NULL, NULL);
+                           false, NULL, NULL, NULL, NULL);
         nfs_destroy_context(client->context);
     }
     memset(client, 0, sizeof(NFSClient));
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 4c9af89..5637e0c 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -664,7 +664,7 @@ static coroutine_fn void do_co_req(void *opaque)
 
     co = qemu_coroutine_self();
     aio_set_fd_handler(srco->aio_context, sockfd, false,
-                       NULL, restart_co_req, co);
+                       NULL, restart_co_req, NULL, co);
 
     ret = send_co_req(sockfd, hdr, data, wlen);
     if (ret < 0) {
@@ -672,7 +672,7 @@ static coroutine_fn void do_co_req(void *opaque)
     }
 
     aio_set_fd_handler(srco->aio_context, sockfd, false,
-                       restart_co_req, NULL, co);
+                       restart_co_req, NULL, NULL, co);
 
     ret = qemu_co_recv(sockfd, hdr, sizeof(*hdr));
     if (ret != sizeof(*hdr)) {
@@ -698,7 +698,7 @@ out:
     /* there is at most one request for this sockfd, so it is safe to
      * set each handler to NULL. */
     aio_set_fd_handler(srco->aio_context, sockfd, false,
-                       NULL, NULL, NULL);
+                       NULL, NULL, NULL, NULL);
 
     srco->ret = ret;
     srco->finished = true;
@@ -760,7 +760,7 @@ static coroutine_fn void reconnect_to_sdog(void *opaque)
     AIOReq *aio_req, *next;
 
     aio_set_fd_handler(s->aio_context, s->fd, false, NULL,
-                       NULL, NULL);
+                       NULL, NULL, NULL);
     close(s->fd);
     s->fd = -1;
 
@@ -964,7 +964,7 @@ static int get_sheep_fd(BDRVSheepdogState *s, Error **errp)
     }
 
     aio_set_fd_handler(s->aio_context, fd, false,
-                       co_read_response, NULL, s);
+                       co_read_response, NULL, NULL, s);
     return fd;
 }
 
@@ -1226,7 +1226,7 @@ static void coroutine_fn add_aio_request(BDRVSheepdogState *s, AIOReq *aio_req,
     qemu_co_mutex_lock(&s->lock);
     s->co_send = qemu_coroutine_self();
     aio_set_fd_handler(s->aio_context, s->fd, false,
-                       co_read_response, co_write_request, s);
+                       co_read_response, co_write_request, NULL, s);
     socket_set_cork(s->fd, 1);
 
     /* send a header */
@@ -1245,7 +1245,7 @@ static void coroutine_fn add_aio_request(BDRVSheepdogState *s, AIOReq *aio_req,
 out:
     socket_set_cork(s->fd, 0);
     aio_set_fd_handler(s->aio_context, s->fd, false,
-                       co_read_response, NULL, s);
+                       co_read_response, NULL, NULL, s);
     s->co_send = NULL;
     qemu_co_mutex_unlock(&s->lock);
 }
@@ -1396,7 +1396,7 @@ static void sd_detach_aio_context(BlockDriverState *bs)
     BDRVSheepdogState *s = bs->opaque;
 
     aio_set_fd_handler(s->aio_context, s->fd, false, NULL,
-                       NULL, NULL);
+                       NULL, NULL, NULL);
 }
 
 static void sd_attach_aio_context(BlockDriverState *bs,
@@ -1406,7 +1406,7 @@ static void sd_attach_aio_context(BlockDriverState *bs,
 
     s->aio_context = new_context;
     aio_set_fd_handler(new_context, s->fd, false,
-                       co_read_response, NULL, s);
+                       co_read_response, NULL, NULL, s);
 }
 
 /* TODO Convert to fine grained options */
@@ -1520,7 +1520,7 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     return 0;
 out:
     aio_set_fd_handler(bdrv_get_aio_context(bs), s->fd,
-                       false, NULL, NULL, NULL);
+                       false, NULL, NULL, NULL, NULL);
     if (s->fd >= 0) {
         closesocket(s->fd);
     }
@@ -1559,7 +1559,7 @@ static void sd_reopen_commit(BDRVReopenState *state)
 
     if (s->fd) {
         aio_set_fd_handler(s->aio_context, s->fd, false,
-                           NULL, NULL, NULL);
+                           NULL, NULL, NULL, NULL);
         closesocket(s->fd);
     }
 
@@ -1583,7 +1583,7 @@ static void sd_reopen_abort(BDRVReopenState *state)
 
     if (re_s->fd) {
         aio_set_fd_handler(s->aio_context, re_s->fd, false,
-                           NULL, NULL, NULL);
+                           NULL, NULL, NULL, NULL);
         closesocket(re_s->fd);
     }
 
@@ -1972,7 +1972,7 @@ static void sd_close(BlockDriverState *bs)
     }
 
     aio_set_fd_handler(bdrv_get_aio_context(bs), s->fd,
-                       false, NULL, NULL, NULL);
+                       false, NULL, NULL, NULL, NULL);
     closesocket(s->fd);
     g_free(s->host_spec);
 }
diff --git a/block/ssh.c b/block/ssh.c
index 15ed281..e0edf20 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -911,7 +911,7 @@ static coroutine_fn void set_fd_handler(BDRVSSHState *s, BlockDriverState *bs)
             rd_handler, wr_handler);
 
     aio_set_fd_handler(bdrv_get_aio_context(bs), s->sock,
-                       false, rd_handler, wr_handler, co);
+                       false, rd_handler, wr_handler, NULL, co);
 }
 
 static coroutine_fn void clear_fd_handler(BDRVSSHState *s,
@@ -919,7 +919,7 @@ static coroutine_fn void clear_fd_handler(BDRVSSHState *s,
 {
     DPRINTF("s->sock=%d", s->sock);
     aio_set_fd_handler(bdrv_get_aio_context(bs), s->sock,
-                       false, NULL, NULL, NULL);
+                       false, NULL, NULL, NULL, NULL);
 }
 
 /* A non-blocking call returned EAGAIN, so yield, ensuring the
diff --git a/block/win32-aio.c b/block/win32-aio.c
index 95e3ab1..8cdf73b 100644
--- a/block/win32-aio.c
+++ b/block/win32-aio.c
@@ -175,7 +175,7 @@ int win32_aio_attach(QEMUWin32AIOState *aio, HANDLE hfile)
 void win32_aio_detach_aio_context(QEMUWin32AIOState *aio,
                                   AioContext *old_context)
 {
-    aio_set_event_notifier(old_context, &aio->e, false, NULL);
+    aio_set_event_notifier(old_context, &aio->e, false, NULL, NULL);
     aio->is_aio_context_attached = false;
 }
 
@@ -184,7 +184,7 @@ void win32_aio_attach_aio_context(QEMUWin32AIOState *aio,
 {
     aio->is_aio_context_attached = true;
     aio_set_event_notifier(new_context, &aio->e, false,
-                           win32_aio_completion_cb);
+                           win32_aio_completion_cb, NULL);
 }
 
 QEMUWin32AIOState *win32_aio_init(void)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 1af2de2..6f8ca25 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2053,9 +2053,9 @@ void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext *ctx,
     if (handle_output) {
         vq->handle_aio_output = handle_output;
         aio_set_event_notifier(ctx, &vq->host_notifier, true,
-                               virtio_queue_host_notifier_aio_read);
+                               virtio_queue_host_notifier_aio_read, NULL);
     } else {
-        aio_set_event_notifier(ctx, &vq->host_notifier, true, NULL);
+        aio_set_event_notifier(ctx, &vq->host_notifier, true, NULL, NULL);
         /* Test and clear notifier before after disabling event,
          * in case poll callback didn't have time to run. */
         virtio_queue_host_notifier_aio_read(&vq->host_notifier);
diff --git a/iohandler.c b/iohandler.c
index f2fc8a9..eb625d9 100644
--- a/iohandler.c
+++ b/iohandler.c
@@ -63,7 +63,7 @@ void qemu_set_fd_handler(int fd,
 {
     iohandler_init();
     aio_set_fd_handler(iohandler_ctx, fd, false,
-                       fd_read, fd_write, opaque);
+                       fd_read, fd_write, NULL, opaque);
 }
 
 /* reaping of zombies.  right now we're not passing the status to
diff --git a/nbd/server.c b/nbd/server.c
index 5b76261..efe5cb8 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1366,19 +1366,18 @@ static void nbd_restart_write(void *opaque)
 static void nbd_set_handlers(NBDClient *client)
 {
     if (client->exp && client->exp->ctx) {
-        aio_set_fd_handler(client->exp->ctx, client->sioc->fd,
-                           true,
+        aio_set_fd_handler(client->exp->ctx, client->sioc->fd, true,
                            client->can_read ? nbd_read : NULL,
                            client->send_coroutine ? nbd_restart_write : NULL,
-                           client);
+                           NULL, client);
     }
 }
 
 static void nbd_unset_handlers(NBDClient *client)
 {
     if (client->exp && client->exp->ctx) {
-        aio_set_fd_handler(client->exp->ctx, client->sioc->fd,
-                           true, NULL, NULL, NULL);
+        aio_set_fd_handler(client->exp->ctx, client->sioc->fd, true, NULL,
+                           NULL, NULL, NULL);
     }
 }
 
diff --git a/stubs/set-fd-handler.c b/stubs/set-fd-handler.c
index 06a5da4..acbe65c 100644
--- a/stubs/set-fd-handler.c
+++ b/stubs/set-fd-handler.c
@@ -15,6 +15,7 @@ void aio_set_fd_handler(AioContext *ctx,
                         bool is_external,
                         IOHandler *io_read,
                         IOHandler *io_write,
+                        AioPollFn *io_poll,
                         void *opaque)
 {
     abort();
diff --git a/tests/test-aio.c b/tests/test-aio.c
index 5be99f8..2754f15 100644
--- a/tests/test-aio.c
+++ b/tests/test-aio.c
@@ -128,7 +128,7 @@ static void *test_acquire_thread(void *opaque)
 static void set_event_notifier(AioContext *ctx, EventNotifier *notifier,
                                EventNotifierHandler *handler)
 {
-    aio_set_event_notifier(ctx, notifier, false, handler);
+    aio_set_event_notifier(ctx, notifier, false, handler, NULL);
 }
 
 static void dummy_notifier_read(EventNotifier *n)
@@ -388,7 +388,7 @@ static void test_aio_external_client(void)
     for (i = 1; i < 3; i++) {
         EventNotifierTestData data = { .n = 0, .active = 10, .auto_set = true };
         event_notifier_init(&data.e, false);
-        aio_set_event_notifier(ctx, &data.e, true, event_ready_cb);
+        aio_set_event_notifier(ctx, &data.e, true, event_ready_cb, NULL);
         event_notifier_set(&data.e);
         for (j = 0; j < i; j++) {
             aio_disable_external(ctx);
diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
index c1f0d79..f2aacfc 100644
--- a/util/event_notifier-posix.c
+++ b/util/event_notifier-posix.c
@@ -95,7 +95,7 @@ int event_notifier_set_handler(EventNotifier *e,
                                EventNotifierHandler *handler)
 {
     aio_set_fd_handler(iohandler_get_aio_context(), e->rfd, is_external,
-                       (IOHandler *)handler, NULL, e);
+                       (IOHandler *)handler, NULL, NULL, e);
     return 0;
 }
 
-- 
2.9.3
