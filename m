Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D316C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FDE208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FDE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jByh9-00013i-Dt
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 06:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jByd9-0002vx-Q1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jByd8-0001Xq-0O
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:30:27 -0400
Received: from relay.sw.ru ([185.231.240.75]:33058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jByd3-0001Rc-NX; Wed, 11 Mar 2020 06:30:21 -0400
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1jBycz-0005cJ-At; Wed, 11 Mar 2020 13:30:17 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 8/9] block/block-copy: reduce intersecting request lock
Date: Wed, 11 Mar 2020 13:30:03 +0300
Message-Id: <20200311103004.7649-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200311103004.7649-1-vsementsov@virtuozzo.com>
References: <20200311103004.7649-1-vsementsov@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, block_copy operation lock the whole requested region. But
there is no reason to lock clusters, which are already copied, it will
disturb other parallel block_copy requests for no reason.

Let's instead do the following:

Lock only sub-region, which we are going to operate on. Then, after
copying all dirty sub-regions, we should wait for intersecting
requests block-copy, if they failed, we should retry these new dirty
clusters.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/block-copy.c | 129 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 105 insertions(+), 24 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 8b91fa0b06..44a64a94c8 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -39,29 +39,72 @@ static BlockCopyInFlightReq *find_conflicting_inflight_req(BlockCopyState *s,
     return NULL;
 }
 
-static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s,
-                                                       int64_t offset,
-                                                       int64_t bytes)
+/*
+ * If there are no intersecting requests return false. Otherwise, wait for the
+ * first found intersecting request to finish and return true.
+ */
+static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t offset,
+                                             int64_t bytes)
 {
-    BlockCopyInFlightReq *req;
+    BlockCopyInFlightReq *req = find_conflicting_inflight_req(s, offset, bytes);
 
-    while ((req = find_conflicting_inflight_req(s, offset, bytes))) {
-        qemu_co_queue_wait(&req->wait_queue, NULL);
+    if (!req) {
+        return false;
     }
+
+    qemu_co_queue_wait(&req->wait_queue, NULL);
+
+    return true;
 }
 
+/* Called only on full-dirty region */
 static void block_copy_inflight_req_begin(BlockCopyState *s,
                                           BlockCopyInFlightReq *req,
                                           int64_t offset, int64_t bytes)
 {
+    assert(!find_conflicting_inflight_req(s, offset, bytes));
+
+    bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
+    s->in_flight_bytes += bytes;
+
     req->offset = offset;
     req->bytes = bytes;
     qemu_co_queue_init(&req->wait_queue);
     QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
 }
 
-static void coroutine_fn block_copy_inflight_req_end(BlockCopyInFlightReq *req)
+/*
+ * block_copy_inflight_req_shrink
+ *
+ * Drop the tail of the request to be handled later. Set dirty bits back and
+ * wake up all requests waiting for us (may be some of them are not intersecting
+ * with shrunk request)
+ */
+static void coroutine_fn block_copy_inflight_req_shrink(BlockCopyState *s,
+        BlockCopyInFlightReq *req, int64_t new_bytes)
 {
+    if (new_bytes == req->bytes) {
+        return;
+    }
+
+    assert(new_bytes > 0 && new_bytes < req->bytes);
+
+    s->in_flight_bytes -= req->bytes - new_bytes;
+    bdrv_set_dirty_bitmap(s->copy_bitmap,
+                          req->offset + new_bytes, req->bytes - new_bytes);
+
+    req->bytes = new_bytes;
+    qemu_co_queue_restart_all(&req->wait_queue);
+}
+
+static void coroutine_fn block_copy_inflight_req_end(BlockCopyState *s,
+                                                     BlockCopyInFlightReq *req,
+                                                     int ret)
+{
+    s->in_flight_bytes -= req->bytes;
+    if (ret < 0) {
+        bdrv_set_dirty_bitmap(s->copy_bitmap, req->offset, req->bytes);
+    }
     QLIST_REMOVE(req, list);
     qemu_co_queue_restart_all(&req->wait_queue);
 }
@@ -357,12 +400,19 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
     return ret;
 }
 
-int coroutine_fn block_copy(BlockCopyState *s,
-                            int64_t offset, int64_t bytes,
-                            bool *error_is_read)
+/*
+ * block_copy_dirty_clusters
+ *
+ * Copy dirty clusters in @offset/@bytes range.
+ * Returns 1 if dirty clusters found and successfully copied, 0 if no dirty
+ * clusters found and -errno on failure.
+ */
+static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
+                                                  int64_t offset, int64_t bytes,
+                                                  bool *error_is_read)
 {
     int ret = 0;
-    BlockCopyInFlightReq req;
+    bool found_dirty = false;
 
     /*
      * block_copy() user is responsible for keeping source and target in same
@@ -374,10 +424,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
 
-    block_copy_wait_inflight_reqs(s, offset, bytes);
-    block_copy_inflight_req_begin(s, &req, offset, bytes);
-
     while (bytes) {
+        BlockCopyInFlightReq req;
         int64_t next_zero, cur_bytes, status_bytes;
 
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
@@ -387,6 +435,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
             continue; /* already copied */
         }
 
+        found_dirty = true;
+
         cur_bytes = MIN(bytes, s->copy_size);
 
         next_zero = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset,
@@ -396,10 +446,14 @@ int coroutine_fn block_copy(BlockCopyState *s,
             assert(next_zero < offset + cur_bytes); /* no need to do MIN() */
             cur_bytes = next_zero - offset;
         }
+        block_copy_inflight_req_begin(s, &req, offset, cur_bytes);
 
         ret = block_copy_block_status(s, offset, cur_bytes, &status_bytes);
+        assert(ret >= 0); /* never fail */
+        cur_bytes = MIN(cur_bytes, status_bytes);
+        block_copy_inflight_req_shrink(s, &req, cur_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
-            bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, status_bytes);
+            block_copy_inflight_req_end(s, &req, 0);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
@@ -409,21 +463,15 @@ int coroutine_fn block_copy(BlockCopyState *s,
             continue;
         }
 
-        cur_bytes = MIN(cur_bytes, status_bytes);
-
         trace_block_copy_process(s, offset);
 
-        bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
-        s->in_flight_bytes += cur_bytes;
-
         co_get_from_shres(s->mem, cur_bytes);
         ret = block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_ZERO,
                                  error_is_read);
         co_put_to_shres(s->mem, cur_bytes);
-        s->in_flight_bytes -= cur_bytes;
+        block_copy_inflight_req_end(s, &req, ret);
         if (ret < 0) {
-            bdrv_set_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
-            break;
+            return ret;
         }
 
         progress_work_done(s->progress, cur_bytes);
@@ -432,7 +480,40 @@ int coroutine_fn block_copy(BlockCopyState *s,
         bytes -= cur_bytes;
     }
 
-    block_copy_inflight_req_end(&req);
+    return found_dirty;
+}
+
+/*
+ * block_copy
+ *
+ * Copy requested region, accordingly to dirty bitmap.
+ * Collaborate with parallel block_copy requests: if they succeed it will help
+ * us. If they fail, we will retry not-copied regions. So, if we return error,
+ * it means that some I/O operation failed in context of _this_ block_copy call,
+ * not some parallel operation.
+ */
+int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
+                            bool *error_is_read)
+{
+    int ret;
+
+    do {
+        ret = block_copy_dirty_clusters(s, offset, bytes, error_is_read);
+
+        if (ret == 0) {
+            ret = block_copy_wait_one(s, offset, bytes);
+        }
+
+        /*
+         * We retry in two cases:
+         * 1. Some progress done
+         *    Something was copied, which means that there were yield points
+         *    and some new dirty bits may have appeared (due to failed parallel
+         *    block-copy requests).
+         * 2. We have waited for some intersecting block-copy request
+         *    It may have failed and produced new dirty bits.
+         */
+    } while (ret > 0);
 
     return ret;
 }
-- 
2.21.0


