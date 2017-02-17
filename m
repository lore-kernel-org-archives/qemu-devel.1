Received: from eggs.gnu.org ([2001:4830:134:3::10]:40319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceoON-0000R5-IR
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceoOM-0002vU-2S
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:40:31 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 Feb 2017 20:40:27 +0100
Message-Id: <20170217194028.8398-3-pbonzini@redhat.com>
In-Reply-To: <20170217194028.8398-1-pbonzini@redhat.com>
References: <20170217194028.8398-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] nfs: do not use aio_context_acquire/release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com

Now that all bottom halves and callbacks take care of taking the
AioContext lock, we can migrate some users away from it and to a
specific QemuMutex or CoMutex.

Protect libnfs calls with a QemuMutex.  Callbacks are invoked
using bottom halves, so we don't even have to drop it around
callback invocations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/nfs.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 08b43dd..4eddcee 100644
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
@@ -273,6 +276,7 @@ static int coroutine_fn nfs_co_readv(BlockDriverState *bs,
     nfs_co_init_task(bs, &task);
     task.iov = iov;
 
+    qemu_mutex_lock(&client->mutex);
     if (nfs_pread_async(client->context, client->fh,
                         sector_num * BDRV_SECTOR_SIZE,
                         nb_sectors * BDRV_SECTOR_SIZE,
@@ -281,6 +285,7 @@ static int coroutine_fn nfs_co_readv(BlockDriverState *bs,
     }
 
     nfs_set_events(client);
+    qemu_mutex_unlock(&client->mutex);
     while (!task.complete) {
         qemu_coroutine_yield();
     }
@@ -314,6 +319,7 @@ static int coroutine_fn nfs_co_writev(BlockDriverState *bs,
 
     qemu_iovec_to_buf(iov, 0, buf, nb_sectors * BDRV_SECTOR_SIZE);
 
+    qemu_mutex_lock(&client->mutex);
     if (nfs_pwrite_async(client->context, client->fh,
                          sector_num * BDRV_SECTOR_SIZE,
                          nb_sectors * BDRV_SECTOR_SIZE,
@@ -323,6 +329,7 @@ static int coroutine_fn nfs_co_writev(BlockDriverState *bs,
     }
 
     nfs_set_events(client);
+    qemu_mutex_unlock(&client->mutex);
     while (!task.complete) {
         qemu_coroutine_yield();
     }
@@ -343,12 +350,14 @@ static int coroutine_fn nfs_co_flush(BlockDriverState *bs)
 
     nfs_co_init_task(bs, &task);
 
+    qemu_mutex_lock(&client->mutex);
     if (nfs_fsync_async(client->context, client->fh, nfs_co_generic_cb,
                         &task) != 0) {
         return -ENOMEM;
     }
 
     nfs_set_events(client);
+    qemu_mutex_unlock(&client->mutex);
     while (!task.complete) {
         qemu_coroutine_yield();
     }
@@ -434,6 +443,7 @@ static void nfs_file_close(BlockDriverState *bs)
 {
     NFSClient *client = bs->opaque;
     nfs_client_close(client);
+    qemu_mutex_destroy(&client->mutex);
 }
 
 static NFSServer *nfs_config(QDict *options, Error **errp)
@@ -641,6 +651,7 @@ static int nfs_file_open(BlockDriverState *bs, QDict *options, int flags,
     if (ret < 0) {
         return ret;
     }
+    qemu_mutex_init(&client->mutex);
     bs->total_sectors = ret;
     ret = 0;
     return ret;
@@ -696,6 +707,7 @@ static int nfs_has_zero_init(BlockDriverState *bs)
     return client->has_zero_init;
 }
 
+/* Called (via nfs_service) with QemuMutex held.  */
 static void
 nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
                                void *private_data)
-- 
2.9.3
