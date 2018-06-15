Received: from eggs.gnu.org ([2001:4830:134:3::10]:60312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fTsox-0003W4-GB
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fTsou-0007TQ-DC
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:47:35 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <naravamudan@digitalocean.com>)
	id 1fTsou-0007Sd-3y
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:47:32 -0400
Received: by mail-pg0-x243.google.com with SMTP id e11-v6so4742546pgq.0
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 10:47:31 -0700 (PDT)
From: Nishanth Aravamudan <naravamudan@digitalocean.com>
Date: Fri, 15 Jun 2018 10:47:29 -0700
Message-Id: <20180615174729.20544-1-naravamudan@digitalocean.com>
In-Reply-To: <20180614232119.31669-1-naravamudan@digitalocean.com>
References: <20180614232119.31669-1-naravamudan@digitalocean.com>
Subject: [Qemu-devel] [PATCH] [RFC v2] aio: properly bubble up errors from
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
Cc: qemu-block@nongnu.org

laio_init() can fail for a couple of reasons, which will lead to a NULL
pointer dereference in laio_attach_aio_context().

To solve this, add a aio_setup_linux_aio() function which is called
before aio_get_linux_aio() where it is called currently, and which
propogates setup errors up. The signature of aio_get_linux_aio() was not
modified, because it seems preferable to return the actual errno from
the possible failing initialization calls.

With respect to the error-handling in the file-posix.c, we properly
bubble any errors up in raw_co_prw and in the case s of
raw_aio_{,un}plug, the result is the same as if s->use_linux_aio was not
set (but there is no bubbling up). In all three cases, if the setup
function fails, we fallback to the thread pool and an error message is
emitted.

It is trivial to make qemu segfault in my testing. Set
/proc/sys/fs/aio-max-nr to 0 and start a guest with
aio=native,cache=directsync. With this patch, the guest successfully
starts (but obviously isn't using native AIO). Setting aio-max-nr back
up to a reasonable value, AIO contexts are consumed normally.

Signed-off-by: Nishanth Aravamudan <naravamudan@digitalocean.com>

---

Changes from v1 -> v2:

Rather than affect virtio-scsi/blk at all, make all the changes internal
to file-posix.c. Thanks to Kevin Wolf for the suggested change.
---
 block/file-posix.c      | 24 ++++++++++++++++++++++++
 block/linux-aio.c       | 15 ++++++++++-----
 include/block/aio.h     |  3 +++
 include/block/raw-aio.h |  2 +-
 stubs/linux-aio.c       |  2 +-
 util/async.c            | 15 ++++++++++++---
 6 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 07bb061fe4..2415d09bf1 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1665,6 +1665,14 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
             type |= QEMU_AIO_MISALIGNED;
 #ifdef CONFIG_LINUX_AIO
         } else if (s->use_linux_aio) {
+            int rc;
+            rc = aio_setup_linux_aio(bdrv_get_aio_context(bs));
+            if (rc != 0) {
+                error_report("Unable to use native AIO, falling back to "
+                             "thread pool.");
+                s->use_linux_aio = 0;
+                return rc;
+            }
             LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
             assert(qiov->size == bytes);
             return laio_co_submit(bs, aio, s->fd, offset, qiov, type);
@@ -1695,6 +1703,14 @@ static void raw_aio_plug(BlockDriverState *bs)
 #ifdef CONFIG_LINUX_AIO
     BDRVRawState *s = bs->opaque;
     if (s->use_linux_aio) {
+        int rc;
+        rc = aio_setup_linux_aio(bdrv_get_aio_context(bs));
+        if (rc != 0) {
+            error_report("Unable to use native AIO, falling back to "
+                         "thread pool.");
+            s->use_linux_aio = 0;
+            return;
+        }
         LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
         laio_io_plug(bs, aio);
     }
@@ -1706,6 +1722,14 @@ static void raw_aio_unplug(BlockDriverState *bs)
 #ifdef CONFIG_LINUX_AIO
     BDRVRawState *s = bs->opaque;
     if (s->use_linux_aio) {
+        int rc;
+        rc = aio_setup_linux_aio(bdrv_get_aio_context(bs));
+        if (rc != 0) {
+            error_report("Unable to use native AIO, falling back to "
+                         "thread pool.");
+            s->use_linux_aio = 0;
+            return;
+        }
         LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
         laio_io_unplug(bs, aio);
     }
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
index 03f62787f2..b3fb67af3c 100644
--- a/util/async.c
+++ b/util/async.c
@@ -323,12 +323,21 @@ ThreadPool *aio_get_thread_pool(AioContext *ctx)
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
     return ctx->linux_aio;
 }
 #endif
-- 
2.17.1
