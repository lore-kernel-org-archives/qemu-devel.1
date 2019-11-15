Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE88FC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B5F2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B5F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVckG-0005j3-0l
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNj-0005B7-Lk
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNe-0002CX-QI
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:27 -0500
Received: from relay.sw.ru ([185.231.240.75]:47490)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNb-0001tW-DY; Fri, 15 Nov 2019 09:15:19 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNA-0006WW-EX; Fri, 15 Nov 2019 17:14:52 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [RFC 13/24] block/block-copy: use aio-task-pool API
Date: Fri, 15 Nov 2019 17:14:33 +0300
Message-Id: <20191115141444.24155-14-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115141444.24155-1-vsementsov@virtuozzo.com>
References: <20191115141444.24155-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, ehabkost@redhat.com,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 qemu-devel@nongnu.org, jsnow@redhat.com, crosa@redhat.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Run block_copy iterations in parallel in aio tasks.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 102 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 90 insertions(+), 12 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 4e8c64a45d..b2e7825b53 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -19,15 +19,27 @@
 #include "block/block-copy.h"
 #include "sysemu/block-backend.h"
 #include "qemu/units.h"
+#include "qemu/coroutine.h"
+#include "block/aio_task.h"
 
 #define BLOCK_COPY_MAX_COPY_RANGE (16 * MiB)
 #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
+#define BLOCK_COPY_MAX_WORKERS 64
+
+typedef struct BlockCopyCallState {
+    bool failed;
+    bool error_is_read;
+} BlockCopyCallState;
 
 typedef struct BlockCopyTask {
+    AioTask task;
+
     BlockCopyState *s;
+    BlockCopyCallState *call_state;
     int64_t offset;
     int64_t bytes;
+    bool zeroes;
     QLIST_ENTRY(BlockCopyTask) list;
     CoQueue wait_queue; /* coroutines blocked on this task */
 } BlockCopyTask;
@@ -217,6 +229,30 @@ void block_copy_set_callbacks(
     s->progress_opaque = progress_opaque;
 }
 
+/* Takes ownership on @task */
+static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
+                                            BlockCopyTask *task)
+{
+    if (!pool) {
+        int ret = task->task.func(&task->task);
+
+        g_free(task);
+        return ret;
+    }
+
+    aio_task_pool_wait_slot(pool);
+    if (aio_task_pool_status(pool) < 0) {
+        co_put_to_shres(task->s->mem, task->bytes);
+        block_copy_task_end(task, -EAGAIN);
+        g_free(task);
+        return aio_task_pool_status(pool);
+    }
+
+    aio_task_pool_start_task(pool, &task->task);
+
+    return 0;
+}
+
 /*
  * block_copy_do_copy
  *
@@ -316,8 +352,31 @@ out:
     return ret;
 }
 
+static coroutine_fn int block_copy_task_entry(AioTask *task)
+{
+    BlockCopyTask *t = container_of(task, BlockCopyTask, task);
+    bool error_is_read;
+    int ret;
+
+    ret = block_copy_do_copy(t->s, t->offset, t->bytes, t->zeroes,
+                             &error_is_read);
+    if (ret < 0 && !t->call_state->failed) {
+        t->call_state->failed = true;
+        t->call_state->error_is_read = error_is_read;
+    } else {
+        t->s->progress_bytes_callback(t->bytes, t->s->progress_opaque);
+    }
+    co_put_to_shres(t->s->mem, t->bytes);
+    block_copy_task_end(t, ret);
+
+    return ret;
+}
+
+/* Called only on full-dirty region */
 static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
-                                             int64_t offset, int64_t bytes)
+                                             BlockCopyCallState *call_state,
+                                             int64_t offset,
+                                             int64_t bytes)
 {
     int64_t next_zero;
     BlockCopyTask *task = g_new(BlockCopyTask, 1);
@@ -338,7 +397,9 @@ static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
 
     *task = (BlockCopyTask) {
+        .task.func = block_copy_task_entry,
         .s = s,
+        .call_state = call_state,
         .offset = offset,
         .bytes = bytes,
     };
@@ -459,6 +520,8 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
 {
     int ret = 0;
     bool found_dirty = false;
+    AioTaskPool *aio = NULL;
+    BlockCopyCallState call_state = {false, false};
 
     /*
      * block_copy() user is responsible for keeping source and target in same
@@ -470,8 +533,8 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
 
-    while (bytes) {
-        g_autofree BlockCopyTask *task = NULL;
+    while (bytes && aio_task_pool_status(aio) == 0) {
+        BlockCopyTask *task;
         int64_t status_bytes;
 
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
@@ -483,36 +546,51 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
 
         found_dirty = true;
 
-        task = block_copy_task_create(s, offset, bytes);
+        task = block_copy_task_create(s, &call_state, offset, bytes);
 
         ret = block_copy_block_status(s, offset, task->bytes, &status_bytes);
         block_copy_task_shrink(task, status_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
             block_copy_task_end(task, 0);
+            g_free(task);
             s->progress_reset_callback(s->progress_opaque);
             trace_block_copy_skip_range(s, offset, status_bytes);
             offset += status_bytes;
             bytes -= status_bytes;
             continue;
         }
+        task->zeroes = ret & BDRV_BLOCK_ZERO;
 
         trace_block_copy_process(s, offset);
 
         co_get_from_shres(s->mem, task->bytes);
-        ret = block_copy_do_copy(s, offset, task->bytes, ret & BDRV_BLOCK_ZERO,
-                                 error_is_read);
-        co_put_to_shres(s->mem, task->bytes);
-        block_copy_task_end(task, ret);
-        if (ret < 0) {
-            return ret;
+
+        if (!aio && task->bytes != bytes) {
+            aio = aio_task_pool_new(BLOCK_COPY_MAX_WORKERS);
         }
 
-        s->progress_bytes_callback(task->bytes, s->progress_opaque);
         offset += task->bytes;
         bytes -= task->bytes;
+
+        ret = block_copy_task_run(aio, task);
+        if (ret < 0) {
+            goto out;
+        }
+    }
+
+out:
+    if (aio) {
+        aio_task_pool_wait_all(aio);
+        if (ret == 0) {
+            ret = aio_task_pool_status(aio);
+        }
+        g_free(aio);
+    }
+    if (error_is_read && ret < 0) {
+        *error_is_read = call_state.error_is_read;
     }
 
-    return found_dirty;
+    return ret < 0 ? ret : found_dirty;
 }
 
 int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t bytes,
-- 
2.21.0


