Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403D4C43141
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1002072D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1002072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVcW3-000595-Ad
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNf-000584-Cn
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNd-0002B3-KN
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:23 -0500
Received: from relay.sw.ru ([185.231.240.75]:47424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNa-0001rp-5o; Fri, 15 Nov 2019 09:15:18 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcN4-0006WW-PJ; Fri, 15 Nov 2019 17:14:46 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [RFC 08/24] block/block-copy: rename in-flight requests to tasks
Date: Fri, 15 Nov 2019 17:14:28 +0300
Message-Id: <20191115141444.24155-9-vsementsov@virtuozzo.com>
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

We are going to use aio-task-pool API and extend in-flight request
structure to be a successor of AioTask, so rename things appropriately.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 82 ++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 42 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 7e14e86a2d..b00cbfc841 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -24,12 +24,12 @@
 #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
 
-typedef struct BlockCopyInFlightReq {
+typedef struct BlockCopyTask {
     int64_t offset;
     int64_t bytes;
-    QLIST_ENTRY(BlockCopyInFlightReq) list;
-    CoQueue wait_queue; /* coroutines blocked on this request */
-} BlockCopyInFlightReq;
+    QLIST_ENTRY(BlockCopyTask) list;
+    CoQueue wait_queue; /* coroutines blocked on this task */
+} BlockCopyTask;
 
 typedef struct BlockCopyState {
     /*
@@ -44,7 +44,7 @@ typedef struct BlockCopyState {
     bool use_copy_range;
     int64_t copy_size;
     uint64_t len;
-    QLIST_HEAD(, BlockCopyInFlightReq) inflight_reqs;
+    QLIST_HEAD(, BlockCopyTask) tasks;
 
     BdrvRequestFlags write_flags;
 
@@ -78,15 +78,14 @@ typedef struct BlockCopyState {
     SharedResource *mem;
 } BlockCopyState;
 
-static BlockCopyInFlightReq *block_copy_find_inflight_req(BlockCopyState *s,
-                                                          int64_t offset,
-                                                          int64_t bytes)
+static BlockCopyTask *block_copy_find_task(BlockCopyState *s,
+                                           int64_t offset, int64_t bytes)
 {
-    BlockCopyInFlightReq *req;
+    BlockCopyTask *t;
 
-    QLIST_FOREACH(req, &s->inflight_reqs, list) {
-        if (offset + bytes > req->offset && offset < req->offset + req->bytes) {
-            return req;
+    QLIST_FOREACH(t, &s->tasks, list) {
+        if (offset + bytes > t->offset && offset < t->offset + t->bytes) {
+            return t;
         }
     }
 
@@ -100,57 +99,56 @@ static BlockCopyInFlightReq *block_copy_find_inflight_req(BlockCopyState *s,
 static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t start,
                                              int64_t end)
 {
-    BlockCopyInFlightReq *req = block_copy_find_inflight_req(s, start, end);
+    BlockCopyTask *task = block_copy_find_task(s, start, end);
 
-    if (!req) {
+    if (!task) {
         return false;
     }
 
-    qemu_co_queue_wait(&req->wait_queue, NULL);
+    qemu_co_queue_wait(&task->wait_queue, NULL);
 
     return true;
 }
 
 /* Called only on full-dirty region */
-static void block_copy_inflight_req_begin(BlockCopyState *s,
-                                          BlockCopyInFlightReq *req,
-                                          int64_t offset, int64_t bytes)
+static void block_copy_task_begin(BlockCopyState *s, BlockCopyTask *task,
+                                  int64_t offset, int64_t bytes)
 {
-    assert(!block_copy_find_inflight_req(s, offset, bytes));
+    assert(!block_copy_find_task(s, offset, bytes));
 
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
 
-    req->offset = offset;
-    req->bytes = bytes;
-    qemu_co_queue_init(&req->wait_queue);
-    QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
+    task->offset = offset;
+    task->bytes = bytes;
+    qemu_co_queue_init(&task->wait_queue);
+    QLIST_INSERT_HEAD(&s->tasks, task, list);
 }
 
-static void coroutine_fn block_copy_inflight_req_shrink(BlockCopyState *s,
-        BlockCopyInFlightReq *req, int64_t new_bytes)
+static void coroutine_fn block_copy_task_shrink(BlockCopyState *s,
+                                                BlockCopyTask *task,
+                                                int64_t new_bytes)
 {
-    if (new_bytes == req->bytes) {
+    if (new_bytes == task->bytes) {
         return;
     }
 
-    assert(new_bytes > 0 && new_bytes < req->bytes);
+    assert(new_bytes > 0 && new_bytes < task->bytes);
 
     bdrv_set_dirty_bitmap(s->copy_bitmap,
-                          req->offset + new_bytes, req->bytes - new_bytes);
+                          task->offset + new_bytes, task->bytes - new_bytes);
 
-    req->bytes = new_bytes;
-    qemu_co_queue_restart_all(&req->wait_queue);
+    task->bytes = new_bytes;
+    qemu_co_queue_restart_all(&task->wait_queue);
 }
 
-static void coroutine_fn block_copy_inflight_req_end(BlockCopyState *s,
-                                                     BlockCopyInFlightReq *req,
-                                                     int ret)
+static void coroutine_fn block_copy_task_end(BlockCopyState *s,
+                                             BlockCopyTask *task, int ret)
 {
     if (ret < 0) {
-        bdrv_set_dirty_bitmap(s->copy_bitmap, req->offset, req->bytes);
+        bdrv_set_dirty_bitmap(s->copy_bitmap, task->offset, task->bytes);
     }
-    QLIST_REMOVE(req, list);
-    qemu_co_queue_restart_all(&req->wait_queue);
+    QLIST_REMOVE(task, list);
+    qemu_co_queue_restart_all(&task->wait_queue);
 }
 
 void block_copy_state_free(BlockCopyState *s)
@@ -218,7 +216,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
         s->copy_size = MAX(s->cluster_size, BLOCK_COPY_MAX_BUFFER);
     }
 
-    QLIST_INIT(&s->inflight_reqs);
+    QLIST_INIT(&s->tasks);
 
     return s;
 }
@@ -456,7 +454,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
 
     while (bytes) {
-        BlockCopyInFlightReq req;
+        BlockCopyTask task;
         int64_t next_zero, cur_bytes, status_bytes;
 
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
@@ -477,12 +475,12 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
             assert(next_zero < offset + cur_bytes); /* no need to do MIN() */
             cur_bytes = next_zero - offset;
         }
-        block_copy_inflight_req_begin(s, &req, offset, cur_bytes);
+        block_copy_task_begin(s, &task, offset, cur_bytes);
 
         ret = block_copy_block_status(s, offset, cur_bytes, &status_bytes);
-        block_copy_inflight_req_shrink(s, &req, status_bytes);
+        block_copy_task_shrink(s, &task, status_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
-            block_copy_inflight_req_end(s, &req, 0);
+            block_copy_task_end(s, &task, 0);
             s->progress_reset_callback(s->progress_opaque);
             trace_block_copy_skip_range(s, offset, status_bytes);
             offset += status_bytes;
@@ -498,7 +496,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
         ret = block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_ZERO,
                                  error_is_read);
         co_put_to_shres(s->mem, cur_bytes);
-        block_copy_inflight_req_end(s, &req, ret);
+        block_copy_task_end(s, &task, ret);
         if (ret < 0) {
             return ret;
         }
-- 
2.21.0


