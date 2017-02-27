Received: from eggs.gnu.org ([2001:4830:134:3::10]:45895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ciOGF-0007nI-3X
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ciOGD-0008PL-O0
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:34:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ciOGD-0008P9-Ex
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:34:53 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 27 Feb 2017 16:34:45 +0000
Message-Id: <20170227163447.20428-3-stefanha@redhat.com>
In-Reply-To: <20170227163447.20428-1-stefanha@redhat.com>
References: <20170227163447.20428-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] nfs: do not use aio_context_acquire/release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Now that all bottom halves and callbacks take care of taking the
AioContext lock, we can migrate some users away from it and to a
specific QemuMutex or CoMutex.

Protect libnfs calls with a QemuMutex.  Callbacks are invoked
using bottom halves, so we don't even have to drop it around
callback invocations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20170222180725.28611-3-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/nfs.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index ffb54be..890d5d4 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -54,6 +54,7 @@ typedef struct NFSClient {
     int events;
     bool has_zero_init;
     AioContext *aio_context;
+    QemuMutex mutex;
     blkcnt_t st_blocks;
     bool cache_used;
     NFSServer *server;
@@ -191,6 +192,7 @@ static void nfs_parse_filename(const char *filename, QDict *options,
 static void nfs_process_read(void *arg);
 static void nfs_process_write(void *arg);
 
+/* Called with QemuMutex held.  */
 static void nfs_set_events(NFSClient *client)
 {
     int ev = nfs_which_events(client->context);
@@ -209,20 +211,20 @@ static void nfs_process_read(void *arg)
 {
     NFSClient *client = arg;
 
-    aio_context_acquire(client->aio_context);
+    qemu_mutex_lock(&client->mutex);
     nfs_service(client->context, POLLIN);
     nfs_set_events(client);
-    aio_context_release(client->aio_context);
+    qemu_mutex_unlock(&client->mutex);
 }
 
 static void nfs_process_write(void *arg)
 {
     NFSClient *client = arg;
 
-    aio_context_acquire(client->aio_context);
+    qemu_mutex_lock(&client->mutex);
     nfs_service(client->context, POLLOUT);
     nfs_set_events(client);
-    aio_context_release(client->aio_context);
+    qemu_mutex_unlock(&client->mutex);
 }
 
 static void nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)
@@ -242,6 +244,7 @@ static void nfs_co_generic_bh_cb(void *opaque)
     aio_co_wake(task->co);
 }
 
+/* Called (via nfs_service) with QemuMutex held.  */
 static void
 nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
                   void *private_data)
@@ -273,12 +276,15 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, uint64_t offset,
     nfs_co_init_task(bs, &task);
     task.iov = iov;
 
+    qemu_mutex_lock(&client->mutex);
     if (nfs_pread_async(client->context, client->fh,
                         offset, bytes, nfs_co_generic_cb, &task) != 0) {
+        qemu_mutex_unlock(&client->mutex);
         return -ENOMEM;
     }
 
     nfs_set_events(client);
+    qemu_mutex_unlock(&client->mutex);
     while (!task.complete) {
         qemu_coroutine_yield();
     }
@@ -317,9 +323,11 @@ static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, uint64_t offset,
         buf = iov->iov[0].iov_base;
     }
 
+    qemu_mutex_lock(&client->mutex);
     if (nfs_pwrite_async(client->context, client->fh,
                          offset, bytes, buf,
                          nfs_co_generic_cb, &task) != 0) {
+        qemu_mutex_unlock(&client->mutex);
         if (my_buffer) {
             g_free(buf);
         }
@@ -327,6 +335,7 @@ static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, uint64_t offset,
     }
 
     nfs_set_events(client);
+    qemu_mutex_unlock(&client->mutex);
     while (!task.complete) {
         qemu_coroutine_yield();
     }
@@ -349,12 +358,15 @@ static int coroutine_fn nfs_co_flush(BlockDriverState *bs)
 
     nfs_co_init_task(bs, &task);
 
+    qemu_mutex_lock(&client->mutex);
     if (nfs_fsync_async(client->context, client->fh, nfs_co_generic_cb,
                         &task) != 0) {
+        qemu_mutex_unlock(&client->mutex);
         return -ENOMEM;
     }
 
     nfs_set_events(client);
+    qemu_mutex_unlock(&client->mutex);
     while (!task.complete) {
         qemu_coroutine_yield();
     }
@@ -440,6 +452,7 @@ static void nfs_file_close(BlockDriverState *bs)
 {
     NFSClient *client = bs->opaque;
     nfs_client_close(client);
+    qemu_mutex_destroy(&client->mutex);
 }
 
 static NFSServer *nfs_config(QDict *options, Error **errp)
@@ -647,6 +660,7 @@ static int nfs_file_open(BlockDriverState *bs, QDict *options, int flags,
     if (ret < 0) {
         return ret;
     }
+    qemu_mutex_init(&client->mutex);
     bs->total_sectors = ret;
     ret = 0;
     return ret;
@@ -702,6 +716,7 @@ static int nfs_has_zero_init(BlockDriverState *bs)
     return client->has_zero_init;
 }
 
+/* Called (via nfs_service) with QemuMutex held.  */
 static void
 nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
                                void *private_data)
-- 
2.9.3
