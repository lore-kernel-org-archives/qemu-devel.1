Received: from eggs.gnu.org ([2001:4830:134:3::10]:52419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYBkX-0005Qy-Te
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYBkW-00054u-Lj
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:48:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 27 Jun 2018 15:48:38 +0100
Message-Id: <20180627144838.26772-3-stefanha@redhat.com>
In-Reply-To: <20180627144838.26772-1-stefanha@redhat.com>
References: <20180627144838.26772-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] linux-aio: properly bubble up errors from
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
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Nishanth Aravamudan <naravamudan@digitalocean.com>

laio_init() can fail for a couple of reasons, which will lead to a NULL
pointer dereference in laio_attach_aio_context().

To solve this, add a aio_setup_linux_aio() function which is called
early in raw_open_common. If this fails, propagate the error up. The
signature of aio_get_linux_aio() was not modified, because it seems
preferable to return the actual errno from the possible failing
initialization calls.

Additionally, when the AioContext changes, we need to associate a
LinuxAioState with the new AioContext. Use the bdrv_attach_aio_context
callback and call the new aio_setup_linux_aio(), which will allocate a
new AioContext if needed, and return errors on failures. If it fails for
any reason, fallback to threaded AIO with an error message, as the
device is already in-use by the guest.

Add an assert that aio_get_linux_aio() cannot return NULL.

Signed-off-by: Nishanth Aravamudan <naravamudan@digitalocean.com>
Message-id: 20180622193700.6523-1-naravamudan@digitalocean.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio.h     |  3 +++
 include/block/raw-aio.h |  2 +-
 block/file-posix.c      | 33 ++++++++++++++++++++++++++++-----
 block/linux-aio.c       | 12 +++++++++---
 stubs/linux-aio.c       |  2 +-
 util/async.c            | 14 +++++++++++---
 6 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index ae6f354e6c..f08630c6e5 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -381,6 +381,9 @@ GSource *aio_get_g_source(AioContext *ctx);
 /* Return the ThreadPool bound to this AioContext */
 struct ThreadPool *aio_get_thread_pool(AioContext *ctx);
 
+/* Setup the LinuxAioState bound to this AioContext */
+struct LinuxAioState *aio_setup_linux_aio(AioContext *ctx, Error **errp);
+
 /* Return the LinuxAioState bound to this AioContext */
 struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);
 
diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index 0e717fd475..8d698ccd31 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -43,7 +43,7 @@
 /* linux-aio.c - Linux native implementation */
 #ifdef CONFIG_LINUX_AIO
 typedef struct LinuxAioState LinuxAioState;
-LinuxAioState *laio_init(void);
+LinuxAioState *laio_init(Error **errp);
 void laio_cleanup(LinuxAioState *s);
 int coroutine_fn laio_co_submit(BlockDriverState *bs, LinuxAioState *s, int fd,
                                 uint64_t offset, QEMUIOVector *qiov, int type);
diff --git a/block/file-posix.c b/block/file-posix.c
index 07bb061fe4..43b963b13e 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -545,11 +545,17 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
 
 #ifdef CONFIG_LINUX_AIO
      /* Currently Linux does AIO only for files opened with O_DIRECT */
-    if (s->use_linux_aio && !(s->open_flags & O_DIRECT)) {
-        error_setg(errp, "aio=native was specified, but it requires "
-                         "cache.direct=on, which was not specified.");
-        ret = -EINVAL;
-        goto fail;
+    if (s->use_linux_aio) {
+        if (!(s->open_flags & O_DIRECT)) {
+            error_setg(errp, "aio=native was specified, but it requires "
+                             "cache.direct=on, which was not specified.");
+            ret = -EINVAL;
+            goto fail;
+        }
+        if (!aio_setup_linux_aio(bdrv_get_aio_context(bs), errp)) {
+            error_prepend(errp, "Unable to use native AIO: ");
+            goto fail;
+        }
     }
 #else
     if (s->use_linux_aio) {
@@ -1723,6 +1729,22 @@ static BlockAIOCB *raw_aio_flush(BlockDriverState *bs,
     return paio_submit(bs, s->fd, 0, NULL, 0, cb, opaque, QEMU_AIO_FLUSH);
 }
 
+static void raw_aio_attach_aio_context(BlockDriverState *bs,
+                                       AioContext *new_context)
+{
+#ifdef CONFIG_LINUX_AIO
+    BDRVRawState *s = bs->opaque;
+    if (s->use_linux_aio) {
+        Error *local_err;
+        if (!aio_setup_linux_aio(new_context, &local_err)) {
+            error_reportf_err(local_err, "Unable to use native AIO, "
+                                         "falling back to thread pool: ");
+            s->use_linux_aio = false;
+        }
+    }
+#endif
+}
+
 static void raw_close(BlockDriverState *bs)
 {
     BDRVRawState *s = bs->opaque;
@@ -2601,6 +2623,7 @@ BlockDriver bdrv_file = {
     .bdrv_refresh_limits = raw_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
+    .bdrv_attach_aio_context = raw_aio_attach_aio_context,
 
     .bdrv_truncate = raw_truncate,
     .bdrv_getlength = raw_getlength,
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 88b8d55ec7..19eb922fdd 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -15,6 +15,7 @@
 #include "block/raw-aio.h"
 #include "qemu/event_notifier.h"
 #include "qemu/coroutine.h"
+#include "qapi/error.h"
 
 #include <libaio.h>
 
@@ -470,16 +471,21 @@ void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context)
                            qemu_laio_poll_cb);
 }
 
-LinuxAioState *laio_init(void)
+LinuxAioState *laio_init(Error **errp)
 {
+    int rc;
     LinuxAioState *s;
 
     s = g_malloc0(sizeof(*s));
-    if (event_notifier_init(&s->e, false) < 0) {
+    rc = event_notifier_init(&s->e, false);
+    if (rc < 0) {
+        error_setg_errno(errp, -rc, "failed to to initialize event notifier");
         goto out_free_state;
     }
 
-    if (io_setup(MAX_EVENTS, &s->ctx) != 0) {
+    rc = io_setup(MAX_EVENTS, &s->ctx);
+    if (rc < 0) {
+        error_setg_errno(errp, -rc, "failed to create linux AIO context");
         goto out_close_efd;
     }
 
diff --git a/stubs/linux-aio.c b/stubs/linux-aio.c
index ed47bd443c..84d1f784ae 100644
--- a/stubs/linux-aio.c
+++ b/stubs/linux-aio.c
@@ -21,7 +21,7 @@ void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context)
     abort();
 }
 
-LinuxAioState *laio_init(void)
+LinuxAioState *laio_init(Error **errp)
 {
     abort();
 }
diff --git a/util/async.c b/util/async.c
index 03f62787f2..05979f8014 100644
--- a/util/async.c
+++ b/util/async.c
@@ -323,14 +323,22 @@ ThreadPool *aio_get_thread_pool(AioContext *ctx)
 }
 
 #ifdef CONFIG_LINUX_AIO
-LinuxAioState *aio_get_linux_aio(AioContext *ctx)
+LinuxAioState *aio_setup_linux_aio(AioContext *ctx, Error **errp)
 {
     if (!ctx->linux_aio) {
-        ctx->linux_aio = laio_init();
-        laio_attach_aio_context(ctx->linux_aio, ctx);
+        ctx->linux_aio = laio_init(errp);
+        if (ctx->linux_aio) {
+            laio_attach_aio_context(ctx->linux_aio, ctx);
+        }
     }
     return ctx->linux_aio;
 }
+
+LinuxAioState *aio_get_linux_aio(AioContext *ctx)
+{
+    assert(ctx->linux_aio);
+    return ctx->linux_aio;
+}
 #endif
 
 void aio_notify(AioContext *ctx)
-- 
2.17.1
