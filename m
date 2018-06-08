Received: from eggs.gnu.org ([2001:4830:134:3::10]:38864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRMwA-0006fP-57
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 15:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRMw5-0004mU-BI
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 15:20:38 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  8 Jun 2018 22:20:27 +0300
Message-Id: <20180608192027.284601-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180608192027.284601-1-vsementsov@virtuozzo.com>
References: <20180608192027.284601-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/3] qcow2: add compress threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, stefanha@gmail.com, pl@kamp.de, vsementsov@virtuozzo.com, den@openvz.org

Do data compression in separate threads. This significantly improve
performance for qemu-img convert with -W (allow async writes) and -c
(compressed) options.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h |  3 +++
 block/qcow2.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 01b5250415..0bd21623c2 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -326,6 +326,9 @@ typedef struct BDRVQcow2State {
      * override) */
     char *image_backing_file;
     char *image_backing_format;
+
+    CoQueue compress_wait_queue;
+    int nb_compress_threads;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/block/qcow2.c b/block/qcow2.c
index d4dbe329ab..91465893e2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -42,6 +42,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "crypto.h"
+#include "block/thread-pool.h"
 
 /*
   Differences with QCOW:
@@ -1544,6 +1545,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         qcow2_check_refcounts(bs, &result, 0);
     }
 #endif
+
+    qemu_co_queue_init(&s->compress_wait_queue);
+
     return ret;
 
  fail:
@@ -3715,6 +3719,62 @@ static ssize_t qcow2_compress(void *dest, const void *src, size_t size)
     return ret;
 }
 
+#define MAX_COMPRESS_THREADS 4
+
+typedef struct Qcow2CompressData {
+    void *dest;
+    const void *src;
+    size_t size;
+    ssize_t ret;
+} Qcow2CompressData;
+
+static int qcow2_compress_pool_func(void *opaque)
+{
+    Qcow2CompressData *data = opaque;
+
+    data->ret = qcow2_compress(data->dest, data->src, data->size);
+
+    return 0;
+}
+
+static void qcow2_compress_complete(void *opaque, int ret)
+{
+    qemu_coroutine_enter(opaque);
+}
+
+/* See qcow2_compress definition for parameters description */
+static ssize_t qcow2_co_compress(BlockDriverState *bs,
+                                 void *dest, const void *src, size_t size)
+{
+    BDRVQcow2State *s = bs->opaque;
+    BlockAIOCB *acb;
+    ThreadPool *pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
+    Qcow2CompressData arg = {
+        .dest = dest,
+        .src = src,
+        .size = size,
+    };
+
+    while (s->nb_compress_threads >= MAX_COMPRESS_THREADS) {
+        qemu_co_queue_wait(&s->compress_wait_queue, NULL);
+    }
+
+    s->nb_compress_threads++;
+    acb = thread_pool_submit_aio(pool, qcow2_compress_pool_func, &arg,
+                                 qcow2_compress_complete,
+                                 qemu_coroutine_self());
+
+    if (!acb) {
+        s->nb_compress_threads--;
+        return -EINVAL;
+    }
+    qemu_coroutine_yield();
+    s->nb_compress_threads--;
+    qemu_co_queue_next(&s->compress_wait_queue);
+
+    return arg.ret;
+}
+
 /* XXX: put compressed sectors first, then all the cluster aligned
    tables to avoid losing bytes in alignment */
 static coroutine_fn int
@@ -3758,7 +3818,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
 
     out_buf = g_malloc(s->cluster_size);
 
-    out_len = qcow2_compress(out_buf, buf, s->cluster_size);
+    out_len = qcow2_co_compress(bs, out_buf, buf, s->cluster_size);
     if (out_len == -2) {
         ret = -EINVAL;
         goto fail;
-- 
2.11.1
