Received: from eggs.gnu.org ([2001:4830:134:3::10]:47048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fTbYV-0001o9-CP
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 19:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fTbYR-0005b1-C9
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 19:21:27 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <naravamudan@digitalocean.com>)
	id 1fTbYR-0005aL-4e
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 19:21:23 -0400
Received: by mail-qt0-x243.google.com with SMTP id p23-v6so7506320qtn.6
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 16:21:22 -0700 (PDT)
From: Nishanth Aravamudan <naravamudan@digitalocean.com>
Date: Thu, 14 Jun 2018 16:21:19 -0700
Message-Id: <20180614232119.31669-1-naravamudan@digitalocean.com>
Subject: [Qemu-devel] [PATCH] [RFC] aio: properly bubble up errors from
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Nishanth Aravamudan <naravamudan@digitalocean.com>

laio_init() can fail for a couple of reasons, which will lead to a NULL
pointer dereference in laio_attach_aio_context().

To solve this, add a aio_linux_aio_setup() path which is called where
aio_get_linux_aio() is called currently, but can propogate errors up.

virtio-block and virtio-scsi call this new function before calling
blk_io_plug() (which eventually calls aio_get_linux_aio). This is
necessary because plug/unplug currently assume they do not fail.

It is trivial to make qemu segfault in my testing. Set
/proc/sys/fs/aio-max-nr to 0 and start a guest with
aio=native,cache=directsync. With this patch, the guest successfully
starts (but obviously isn't using native AIO). Setting aio-max-nr back
up to a reasonable value, AIO contexts are consumed normally.

Signed-off-by: Nishanth Aravamudan <naravamudan@digitalocean.com>
---
 block/block-backend.c          | 10 ++++++++++
 block/file-posix.c             | 27 +++++++++++++++++++++++++++
 block/io.c                     | 27 +++++++++++++++++++++++++++
 block/linux-aio.c              | 15 ++++++++++-----
 hw/block/virtio-blk.c          |  4 ++++
 hw/scsi/virtio-scsi.c          |  4 ++++
 include/block/aio.h            |  3 +++
 include/block/block.h          |  1 +
 include/block/block_int.h      |  1 +
 include/block/raw-aio.h        |  2 +-
 include/sysemu/block-backend.h |  1 +
 stubs/linux-aio.c              |  2 +-
 util/async.c                   | 14 +++++++++++---
 13 files changed, 101 insertions(+), 10 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index d55c328736..2a18bb2af4 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1946,6 +1946,16 @@ void blk_add_insert_bs_notifier(BlockBackend *blk, Notifier *notify)
     notifier_list_add(&blk->insert_bs_notifiers, notify);
 }
 
+int blk_io_plug_setup(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+
+    if (bs) {
+        return bdrv_io_plug_setup(bs);
+    }
+    return 0;
+}
+
 void blk_io_plug(BlockBackend *blk)
 {
     BlockDriverState *bs = blk_bs(blk);
diff --git a/block/file-posix.c b/block/file-posix.c
index 07bb061fe4..adaba7c366 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1665,6 +1665,12 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
             type |= QEMU_AIO_MISALIGNED;
 #ifdef CONFIG_LINUX_AIO
         } else if (s->use_linux_aio) {
+            int rc;
+            rc = aio_linux_aio_setup(bdrv_get_aio_context(bs));
+            if (rc != 0) {
+                s->use_linux_aio = 0;
+                return rc;
+            }
             LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
             assert(qiov->size == bytes);
             return laio_co_submit(bs, aio, s->fd, offset, qiov, type);
@@ -1690,12 +1696,28 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
     return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_WRITE);
 }
 
+static int raw_aio_plug_setup(BlockDriverState *bs)
+{
+    int rc = 0;
+#ifdef CONFIG_LINUX_AIO
+    BDRVRawState *s = bs->opaque;
+    if (s->use_linux_aio) {
+        rc = aio_linux_aio_setup(bdrv_get_aio_context(bs));
+        if (rc != 0) {
+            s->use_linux_aio = 0;
+        }
+    }
+#endif
+    return rc;
+}
+
 static void raw_aio_plug(BlockDriverState *bs)
 {
 #ifdef CONFIG_LINUX_AIO
     BDRVRawState *s = bs->opaque;
     if (s->use_linux_aio) {
         LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
+        assert(aio != NULL);
         laio_io_plug(bs, aio);
     }
 #endif
@@ -1707,6 +1729,7 @@ static void raw_aio_unplug(BlockDriverState *bs)
     BDRVRawState *s = bs->opaque;
     if (s->use_linux_aio) {
         LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
+        assert(aio != NULL);
         laio_io_unplug(bs, aio);
     }
 #endif
@@ -2599,6 +2622,7 @@ BlockDriver bdrv_file = {
     .bdrv_co_copy_range_from = raw_co_copy_range_from,
     .bdrv_co_copy_range_to  = raw_co_copy_range_to,
     .bdrv_refresh_limits = raw_refresh_limits,
+    .bdrv_io_plug_setup = raw_aio_plug_setup,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
 
@@ -3079,6 +3103,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_co_copy_range_from = raw_co_copy_range_from,
     .bdrv_co_copy_range_to  = raw_co_copy_range_to,
     .bdrv_refresh_limits = raw_refresh_limits,
+    .bdrv_io_plug_setup = raw_aio_plug_setup,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
 
@@ -3201,6 +3226,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_co_pwritev        = raw_co_pwritev,
     .bdrv_aio_flush	= raw_aio_flush,
     .bdrv_refresh_limits = raw_refresh_limits,
+    .bdrv_io_plug_setup = raw_aio_plug_setup,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
 
@@ -3331,6 +3357,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_co_pwritev        = raw_co_pwritev,
     .bdrv_aio_flush	= raw_aio_flush,
     .bdrv_refresh_limits = raw_refresh_limits,
+    .bdrv_io_plug_setup = raw_aio_plug_setup,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
 
diff --git a/block/io.c b/block/io.c
index b7beaeeb9f..3c9711f6ed 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2779,6 +2779,33 @@ void bdrv_add_before_write_notifier(BlockDriverState *bs,
     notifier_with_return_list_add(&bs->before_write_notifiers, notifier);
 }
 
+int bdrv_io_plug_setup(BlockDriverState *bs)
+{
+    int rc;
+    BdrvChild *child;
+
+    QLIST_FOREACH(child, &bs->children, next) {
+        // XXX: do we need to undo the successful setups if we fail midway?
+        rc = bdrv_io_plug_setup(child->bs);
+        if (rc != 0) {
+            return rc;
+        }
+    }
+
+    if (atomic_fetch_inc(&bs->io_plugged) == 0) {
+        BlockDriver *drv = bs->drv;
+        if (drv && drv->bdrv_io_plug_setup) {
+            rc = drv->bdrv_io_plug_setup(bs);
+            // XXX: do we need to undo the successful setups if we fail midway?
+            if (rc != 0) {
+                return rc;
+            }
+        }
+    }
+
+    return 0;
+}
+
 void bdrv_io_plug(BlockDriverState *bs)
 {
     BdrvChild *child;
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 88b8d55ec7..4d799f85fe 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -470,28 +470,33 @@ void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context)
                            qemu_laio_poll_cb);
 }
 
-LinuxAioState *laio_init(void)
+int laio_init(LinuxAioState **linux_aio)
 {
+    int rc;
     LinuxAioState *s;
 
     s = g_malloc0(sizeof(*s));
-    if (event_notifier_init(&s->e, false) < 0) {
+    rc = event_notifier_init(&s->e, false);
+    if (rc < 0) {
         goto out_free_state;
     }
 
-    if (io_setup(MAX_EVENTS, &s->ctx) != 0) {
+    rc = io_setup(MAX_EVENTS, &s->ctx);
+    if (rc != 0) {
         goto out_close_efd;
     }
 
     ioq_init(&s->io_q);
 
-    return s;
+    *linux_aio = s;
+    return 0;
 
 out_close_efd:
     event_notifier_cleanup(&s->e);
 out_free_state:
     g_free(s);
-    return NULL;
+    *linux_aio = NULL;
+    return rc;
 }
 
 void laio_cleanup(LinuxAioState *s)
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 50b5c869e3..a2cd008a4c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -598,6 +598,9 @@ bool virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq)
     bool progress = false;
 
     aio_context_acquire(blk_get_aio_context(s->blk));
+    if (blk_io_plug_setup(s->blk) != 0) {
+        goto error;
+    }
     blk_io_plug(s->blk);
 
     do {
@@ -620,6 +623,7 @@ bool virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq)
     }
 
     blk_io_unplug(s->blk);
+error:
     aio_context_release(blk_get_aio_context(s->blk));
     return progress;
 }
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 3aa99717e2..7d17f082d5 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -569,6 +569,10 @@ static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req)
         return -ENOBUFS;
     }
     scsi_req_ref(req->sreq);
+    rc = blk_io_plug_setup(d->conf.blk);
+    if (rc != 0) {
+        return rc;
+    }
     blk_io_plug(d->conf.blk);
     return 0;
 }
diff --git a/include/block/aio.h b/include/block/aio.h
index ae6f354e6c..64881c24b9 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -381,6 +381,9 @@ GSource *aio_get_g_source(AioContext *ctx);
 /* Return the ThreadPool bound to this AioContext */
 struct ThreadPool *aio_get_thread_pool(AioContext *ctx);
 
+/* Setup the LinuxAioState bound to this AioContext */
+int aio_linux_aio_setup(AioContext *ctx);
+
 /* Return the LinuxAioState bound to this AioContext */
 struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);
 
diff --git a/include/block/block.h b/include/block/block.h
index e677080c4e..2974f64ad2 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -548,6 +548,7 @@ void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context);
 int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz);
 int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo);
 
+int bdrv_io_plug_setup(BlockDriverState *bs);
 void bdrv_io_plug(BlockDriverState *bs);
 void bdrv_io_unplug(BlockDriverState *bs);
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 327e478a73..2e5ffbdc4f 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -388,6 +388,7 @@ struct BlockDriver {
                                     AioContext *new_context);
 
     /* io queue for linux-aio */
+    int (*bdrv_io_plug_setup)(BlockDriverState *bs);
     void (*bdrv_io_plug)(BlockDriverState *bs);
     void (*bdrv_io_unplug)(BlockDriverState *bs);
 
diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index 0e717fd475..81b90e5fc6 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -43,7 +43,7 @@
 /* linux-aio.c - Linux native implementation */
 #ifdef CONFIG_LINUX_AIO
 typedef struct LinuxAioState LinuxAioState;
-LinuxAioState *laio_init(void);
+int laio_init(LinuxAioState **linux_aio);
 void laio_cleanup(LinuxAioState *s);
 int coroutine_fn laio_co_submit(BlockDriverState *bs, LinuxAioState *s, int fd,
                                 uint64_t offset, QEMUIOVector *qiov, int type);
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 8d03d493c2..7a1093f8f0 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -197,6 +197,7 @@ void blk_remove_aio_context_notifier(BlockBackend *blk,
                                      void *opaque);
 void blk_add_remove_bs_notifier(BlockBackend *blk, Notifier *notify);
 void blk_add_insert_bs_notifier(BlockBackend *blk, Notifier *notify);
+int blk_io_plug_setup(BlockBackend *blk);
 void blk_io_plug(BlockBackend *blk);
 void blk_io_unplug(BlockBackend *blk);
 BlockAcctStats *blk_get_stats(BlockBackend *blk);
diff --git a/stubs/linux-aio.c b/stubs/linux-aio.c
index ed47bd443c..88ab927e35 100644
--- a/stubs/linux-aio.c
+++ b/stubs/linux-aio.c
@@ -21,7 +21,7 @@ void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context)
     abort();
 }
 
-LinuxAioState *laio_init(void)
+int laio_init(LinuxAioState **linux_aio)
 {
     abort();
 }
diff --git a/util/async.c b/util/async.c
index 03f62787f2..34534aae63 100644
--- a/util/async.c
+++ b/util/async.c
@@ -323,12 +323,20 @@ ThreadPool *aio_get_thread_pool(AioContext *ctx)
 }
 
 #ifdef CONFIG_LINUX_AIO
-LinuxAioState *aio_get_linux_aio(AioContext *ctx)
+int aio_linux_aio_setup(AioContext *ctx)
 {
+    int rc = 0;
     if (!ctx->linux_aio) {
-        ctx->linux_aio = laio_init();
-        laio_attach_aio_context(ctx->linux_aio, ctx);
+        rc = laio_init(&ctx->linux_aio);
+        if (rc == 0) {
+            laio_attach_aio_context(ctx->linux_aio, ctx);
+        }
     }
+    return rc;
+}
+
+LinuxAioState *aio_get_linux_aio(AioContext *ctx)
+{
     return ctx->linux_aio;
 }
 #endif
-- 
2.17.1
