Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078F3C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 15:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C082E206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 15:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C082E206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyeFF-0003PY-RB
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 11:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyeBO-0007oW-Vg
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 11:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyeBM-0001b0-Et
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 11:30:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:60444)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hyeBH-0001Qb-0u; Fri, 16 Aug 2019 11:30:19 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hyeBD-0007x1-Vn; Fri, 16 Aug 2019 18:30:16 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Fri, 16 Aug 2019 18:30:15 +0300
Message-Id: <20190816153015.447957-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190816153015.447957-1-vsementsov@virtuozzo.com>
References: <20190816153015.447957-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v4 5/5] block/qcow2: introduce parallel
 subrequest handling in read and write
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It improves performance for fragmented qcow2 images. It also affect 026
iotest, increasing leaked clusters number, which is not surprising when
we run several sub-requests of qcow2 request in parallel.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h                      |   3 +
 block/qcow2.c                      | 125 ++++++++++++++++++++++++++---
 block/trace-events                 |   1 +
 tests/qemu-iotests/026.out         |  18 +++--
 tests/qemu-iotests/026.out.nocache |  20 ++---
 5 files changed, 138 insertions(+), 29 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 998bcdaef1..fdfa9c31cd 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -65,6 +65,9 @@
 #define QCOW2_MAX_BITMAPS 65535
 #define QCOW2_MAX_BITMAP_DIRECTORY_SIZE (1024 * QCOW2_MAX_BITMAPS)
 
+/* Maximum of parallel sub-request per guest request */
+#define QCOW2_MAX_WORKERS 8
+
 /* indicate that the refcount of the referenced cluster is exactly one. */
 #define QCOW_OFLAG_COPIED     (1ULL << 63)
 /* indicate that the cluster is compressed (they never have the copied flag) */
diff --git a/block/qcow2.c b/block/qcow2.c
index 3aaa180e2b..36b41e8536 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -40,6 +40,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "crypto.h"
+#include "block/aio_task.h"
 
 /*
   Differences with QCOW:
@@ -2017,6 +2018,60 @@ fail:
     return ret;
 }
 
+typedef struct Qcow2AioTask {
+    AioTask task;
+
+    BlockDriverState *bs;
+    QCow2ClusterType cluster_type; /* only for read */
+    uint64_t file_cluster_offset;
+    uint64_t offset;
+    uint64_t bytes;
+    QEMUIOVector *qiov;
+    uint64_t qiov_offset;
+    QCowL2Meta *l2meta; /* only for write */
+} Qcow2AioTask;
+
+static coroutine_fn int qcow2_co_preadv_task_entry(AioTask *task);
+static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
+                                       AioTaskPool *pool,
+                                       AioTaskFunc func,
+                                       QCow2ClusterType cluster_type,
+                                       uint64_t file_cluster_offset,
+                                       uint64_t offset,
+                                       uint64_t bytes,
+                                       QEMUIOVector *qiov,
+                                       size_t qiov_offset,
+                                       QCowL2Meta *l2meta)
+{
+    Qcow2AioTask local_task;
+    Qcow2AioTask *task = pool ? g_new(Qcow2AioTask, 1) : &local_task;
+
+    *task = (Qcow2AioTask) {
+        .task.func = func,
+        .bs = bs,
+        .cluster_type = cluster_type,
+        .qiov = qiov,
+        .file_cluster_offset = file_cluster_offset,
+        .offset = offset,
+        .bytes = bytes,
+        .qiov_offset = qiov_offset,
+        .l2meta = l2meta,
+    };
+
+    trace_qcow2_add_task(qemu_coroutine_self(), bs, pool,
+                         func == qcow2_co_preadv_task_entry ? "read" : "write",
+                         cluster_type, file_cluster_offset, offset, bytes,
+                         qiov, qiov_offset);
+
+    if (!pool) {
+        return func(&task->task);
+    }
+
+    aio_task_pool_start_task(pool, &task->task);
+
+    return 0;
+}
+
 static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
                                              QCow2ClusterType cluster_type,
                                              uint64_t file_cluster_offset,
@@ -2066,18 +2121,28 @@ static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
     g_assert_not_reached();
 }
 
+static coroutine_fn int qcow2_co_preadv_task_entry(AioTask *task)
+{
+    Qcow2AioTask *t = container_of(task, Qcow2AioTask, task);
+
+    assert(!t->l2meta);
+
+    return qcow2_co_preadv_task(t->bs, t->cluster_type, t->file_cluster_offset,
+                                t->offset, t->bytes, t->qiov, t->qiov_offset);
+}
+
 static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
                                              uint64_t offset, uint64_t bytes,
                                              QEMUIOVector *qiov,
                                              size_t qiov_offset, int flags)
 {
     BDRVQcow2State *s = bs->opaque;
-    int ret;
+    int ret = 0;
     unsigned int cur_bytes; /* number of bytes in current iteration */
     uint64_t cluster_offset = 0;
+    AioTaskPool *aio = NULL;
 
-    while (bytes != 0) {
-
+    while (bytes != 0 && aio_task_pool_status(aio) == 0) {
         /* prepare next request */
         cur_bytes = MIN(bytes, INT_MAX);
         if (s->crypto) {
@@ -2089,7 +2154,7 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
         ret = qcow2_get_cluster_offset(bs, offset, &cur_bytes, &cluster_offset);
         qemu_co_mutex_unlock(&s->lock);
         if (ret < 0) {
-            return ret;
+            goto out;
         }
 
         if (ret == QCOW2_CLUSTER_ZERO_PLAIN ||
@@ -2098,11 +2163,14 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
         {
             qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
         } else {
-            ret = qcow2_co_preadv_task(bs, ret,
-                                       cluster_offset, offset, cur_bytes,
-                                       qiov, qiov_offset);
+            if (!aio && cur_bytes != bytes) {
+                aio = aio_task_pool_new(QCOW2_MAX_WORKERS);
+            }
+            ret = qcow2_add_task(bs, aio, qcow2_co_preadv_task_entry, ret,
+                                 cluster_offset, offset, cur_bytes,
+                                 qiov, qiov_offset, NULL);
             if (ret < 0) {
-                return ret;
+                goto out;
             }
         }
 
@@ -2111,7 +2179,16 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
         qiov_offset += cur_bytes;
     }
 
-    return 0;
+out:
+    if (aio) {
+        aio_task_pool_wait_all(aio);
+        if (ret == 0) {
+            ret = aio_task_pool_status(aio);
+        }
+        g_free(aio);
+    }
+
+    return ret;
 }
 
 /* Check if it's possible to merge a write request with the writing of
@@ -2315,6 +2392,17 @@ out_locked:
     return ret;
 }
 
+static coroutine_fn int qcow2_co_pwritev_task_entry(AioTask *task)
+{
+    Qcow2AioTask *t = container_of(task, Qcow2AioTask, task);
+
+    assert(!t->cluster_type);
+
+    return qcow2_co_pwritev_task(t->bs, t->file_cluster_offset,
+                                 t->offset, t->bytes, t->qiov, t->qiov_offset,
+                                 t->l2meta);
+}
+
 static coroutine_fn int qcow2_co_pwritev_part(
         BlockDriverState *bs, uint64_t offset, uint64_t bytes,
         QEMUIOVector *qiov, size_t qiov_offset, int flags)
@@ -2325,10 +2413,11 @@ static coroutine_fn int qcow2_co_pwritev_part(
     unsigned int cur_bytes; /* number of sectors in current iteration */
     uint64_t cluster_offset;
     QCowL2Meta *l2meta = NULL;
+    AioTaskPool *aio = NULL;
 
     trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);
 
-    while (bytes != 0) {
+    while (bytes != 0 && aio_task_pool_status(aio) == 0) {
 
         l2meta = NULL;
 
@@ -2360,8 +2449,12 @@ static coroutine_fn int qcow2_co_pwritev_part(
 
         qemu_co_mutex_unlock(&s->lock);
 
-        ret = qcow2_co_pwritev_task(bs, cluster_offset, offset, cur_bytes,
-                                    qiov, qiov_offset, l2meta);
+        if (!aio && cur_bytes != bytes) {
+            aio = aio_task_pool_new(QCOW2_MAX_WORKERS);
+        }
+        ret = qcow2_add_task(bs, aio, qcow2_co_pwritev_task_entry, 0,
+                             cluster_offset, offset, cur_bytes,
+                             qiov, qiov_offset, l2meta);
         l2meta = NULL; /* l2meta is consumed by qcow2_co_pwritev_task() */
         if (ret < 0) {
             goto fail_nometa;
@@ -2382,6 +2475,14 @@ out_locked:
     qemu_co_mutex_unlock(&s->lock);
 
 fail_nometa:
+    if (aio) {
+        aio_task_pool_wait_all(aio);
+        if (ret == 0) {
+            ret = aio_task_pool_status(aio);
+        }
+        g_free(aio);
+    }
+
     trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
 
     return ret;
diff --git a/block/trace-events b/block/trace-events
index d724df0117..7f51550ba3 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -61,6 +61,7 @@ file_paio_submit(void *acb, void *opaque, int64_t offset, int count, int type) "
 file_copy_file_range(void *bs, int src, int64_t src_off, int dst, int64_t dst_off, int64_t bytes, int flags, int64_t ret) "bs %p src_fd %d offset %"PRIu64" dst_fd %d offset %"PRIu64" bytes %"PRIu64" flags %d ret %"PRId64
 
 # qcow2.c
+qcow2_add_task(void *co, void *bs, void *pool, const char *action, int cluster_type, uint64_t file_cluster_offset, uint64_t offset, uint64_t bytes, void *qiov, size_t qiov_offset) "co %p bs %p pool %p: %s: cluster_type %d file_cluster_offset %" PRIu64 " offset %" PRIu64 " bytes %" PRIu64 " qiov %p qiov_offset %zu"
 qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
 qcow2_writev_done_req(void *co, int ret) "co %p ret %d"
 qcow2_writev_start_part(void *co) "co %p"
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index fb89b8480c..4849c9c90a 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -481,7 +481,7 @@ qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-55 leaked clusters were found on the image.
+119 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -508,7 +508,9 @@ Event: refblock_alloc_write; errno: 28; imm: off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-No errors were found on the image.
+
+64 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write -b
@@ -533,7 +535,7 @@ qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-10 leaked clusters were found on the image.
+74 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -542,7 +544,7 @@ qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-23 leaked clusters were found on the image.
+87 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -561,7 +563,7 @@ qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-10 leaked clusters were found on the image.
+74 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -570,7 +572,7 @@ qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-23 leaked clusters were found on the image.
+87 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -589,7 +591,7 @@ qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-10 leaked clusters were found on the image.
+74 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -598,7 +600,7 @@ qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-23 leaked clusters were found on the image.
+87 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 
 === L1 growth tests ===
diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.out.nocache
index 6dda95dfb4..6b56df7788 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -489,7 +489,7 @@ qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-55 leaked clusters were found on the image.
+119 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -516,8 +516,10 @@ Event: refblock_alloc_write; errno: 28; imm: off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-No errors were found on the image.
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
+
+64 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
@@ -541,7 +543,7 @@ qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-10 leaked clusters were found on the image.
+74 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -550,7 +552,7 @@ qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-23 leaked clusters were found on the image.
+87 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -569,7 +571,7 @@ qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-10 leaked clusters were found on the image.
+74 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -578,7 +580,7 @@ qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-23 leaked clusters were found on the image.
+87 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -597,7 +599,7 @@ qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-10 leaked clusters were found on the image.
+74 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -606,7 +608,7 @@ qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-23 leaked clusters were found on the image.
+87 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 
 === L1 growth tests ===
-- 
2.18.0


