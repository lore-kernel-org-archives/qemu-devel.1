Received: from eggs.gnu.org ([2001:4830:134:3::10]:52866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fW7xs-00056G-Df
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 18:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fW7xq-0008IR-45
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 18:22:04 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:44473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <naravamudan@digitalocean.com>)
	id 1fW7xp-0008Hi-Rn
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 18:22:02 -0400
Received: by mail-pf0-x242.google.com with SMTP id h12-v6so2186850pfk.11
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 15:22:01 -0700 (PDT)
From: Nishanth Aravamudan <naravamudan@digitalocean.com>
Date: Thu, 21 Jun 2018 15:21:42 -0700
Message-Id: <20180621222143.27266-2-naravamudan@digitalocean.com>
In-Reply-To: <20180621222143.27266-1-naravamudan@digitalocean.com>
References: <20180621222143.27266-1-naravamudan@digitalocean.com>
Subject: [Qemu-devel] [PATCH v3 1/2] linux-aio: properly bubble up errors
 from initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: naravamudan@digitalocean.com
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

laio_init() can fail for a couple of reasons, which will lead to a NULL
pointer dereference in laio_attach_aio_context().

To solve this, add a aio_setup_linux_aio() function which is called
early in raw_open_common. If this fails, propagate the error up. The
signature of aio_get_linux_aio() was not modified, because it seems
preferable to return the actual errno from the possible failing
initialization calls.

Add an assert that aio_get_linux_aio() cannot return NULL.

Signed-off-by: Nishanth Aravamudan <naravamudan@digitalocean.com>
---
Changes from v2 -> v3 (thanks to Eric Blake and Kevin Wolf for review):

Use a boolean false rather than 0 in assignment to use_linux_aio.
Drop ending '.' from error_report() calls.
Fix typo in commit message (propogates -> propagates).
Move aio_setup_linux_aio call to raw_open_common.

Changes from v1 -> v2 (thanks to Kevin Wolf for review):

Rather than affect virtio-scsi/blk at all, make all the changes internal
to file-posix.c. Thanks to Kevin Wolf for the suggested change.

 block/file-posix.c      | 17 ++++++++++++-----
 block/linux-aio.c       | 15 ++++++++++-----
 include/block/aio.h     |  3 +++
 include/block/raw-aio.h |  2 +-
 stubs/linux-aio.c       |  2 +-
 util/async.c            | 16 +++++++++++++---
 6 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 07bb061fe4..6a1714d4a8 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -545,11 +545,18 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
 
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
+        ret = aio_setup_linux_aio(bdrv_get_aio_context(bs));
+        if (ret != 0) {
+            error_setg(errp, "Unable to setup native AIO context.");
+            goto fail;
+        }
     }
 #else
     if (s->use_linux_aio) {
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
diff --git a/include/block/aio.h b/include/block/aio.h
index ae6f354e6c..8900516ac5 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -381,6 +381,9 @@ GSource *aio_get_g_source(AioContext *ctx);
 /* Return the ThreadPool bound to this AioContext */
 struct ThreadPool *aio_get_thread_pool(AioContext *ctx);
 
+/* Setup the LinuxAioState bound to this AioContext */
+int aio_setup_linux_aio(AioContext *ctx);
+
 /* Return the LinuxAioState bound to this AioContext */
 struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);
 
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
index 03f62787f2..ae88c931d0 100644
--- a/util/async.c
+++ b/util/async.c
@@ -323,12 +323,22 @@ ThreadPool *aio_get_thread_pool(AioContext *ctx)
 }
 
 #ifdef CONFIG_LINUX_AIO
-LinuxAioState *aio_get_linux_aio(AioContext *ctx)
+int aio_setup_linux_aio(AioContext *ctx)
 {
+    int rc;
+    rc = 0;
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
+    assert(ctx->linux_aio);
     return ctx->linux_aio;
 }
 #endif
-- 
2.17.1
