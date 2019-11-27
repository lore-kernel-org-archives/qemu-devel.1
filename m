Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C4AC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8229A20862
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8229A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia1zp-0004wb-DG
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia1kB-0006eP-B9
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia1k9-0003sx-QJ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:08:51 -0500
Received: from relay.sw.ru ([185.231.240.75]:49994)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia1k5-0003in-Uz; Wed, 27 Nov 2019 13:08:46 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia1k1-0002UU-Cn; Wed, 27 Nov 2019 21:08:41 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 6/7] block/block-copy: reduce intersecting request lock
Date: Wed, 27 Nov 2019 21:08:39 +0300
Message-Id: <20191127180840.11937-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191127180840.11937-1-vsementsov@virtuozzo.com>
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
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
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
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
---
 block/block-copy.c | 116 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 95 insertions(+), 21 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 20068cd699..aca44b13fb 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -39,29 +39,62 @@ static BlockCopyInFlightReq *block_copy_find_inflight_req(BlockCopyState *s,
     return NULL;
 }
 
-static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s,
-                                                       int64_t offset,
-                                                       int64_t bytes)
+/*
+ * If there are no intersecting requests return false. Otherwise, wait for the
+ * first found intersecting request to finish and return true.
+ */
+static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t start,
+                                             int64_t end)
 {
-    BlockCopyInFlightReq *req;
+    BlockCopyInFlightReq *req = block_copy_find_inflight_req(s, start, end);
 
-    while ((req = block_copy_find_inflight_req(s, offset, bytes))) {
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
+    assert(!block_copy_find_inflight_req(s, offset, bytes));
+
+    bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
+
     req->offset = offset;
     req->bytes = bytes;
     qemu_co_queue_init(&req->wait_queue);
     QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
 }
 
-static void coroutine_fn block_copy_inflight_req_end(BlockCopyInFlightReq *req)
+static void coroutine_fn block_copy_inflight_req_shrink(BlockCopyState *s,
+        BlockCopyInFlightReq *req, int64_t new_bytes)
 {
+    if (new_bytes == req->bytes) {
+        return;
+    }
+
+    assert(new_bytes > 0 && new_bytes < req->bytes);
+
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
+    if (ret < 0) {
+        bdrv_set_dirty_bitmap(s->copy_bitmap, req->offset, req->bytes);
+    }
     QLIST_REMOVE(req, list);
     qemu_co_queue_restart_all(&req->wait_queue);
 }
@@ -344,12 +377,19 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
     return ret;
 }
 
-int coroutine_fn block_copy(BlockCopyState *s,
-                            int64_t offset, uint64_t bytes,
-                            bool *error_is_read)
+/*
+ * block_copy_dirty_clusters
+ *
+ * Copy dirty clusters in @start/@bytes range.
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
@@ -361,10 +401,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
 
-    block_copy_wait_inflight_reqs(s, offset, bytes);
-    block_copy_inflight_req_begin(s, &req, offset, bytes);
-
     while (bytes) {
+        BlockCopyInFlightReq req;
         int64_t next_zero, cur_bytes, status_bytes;
 
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
@@ -374,6 +412,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
             continue; /* already copied */
         }
 
+        found_dirty = true;
+
         cur_bytes = MIN(bytes, s->copy_size);
 
         next_zero = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset,
@@ -383,10 +423,12 @@ int coroutine_fn block_copy(BlockCopyState *s,
             assert(next_zero < offset + cur_bytes); /* no need to do MIN() */
             cur_bytes = next_zero - offset;
         }
+        block_copy_inflight_req_begin(s, &req, offset, cur_bytes);
 
         ret = block_copy_block_status(s, offset, cur_bytes, &status_bytes);
+        block_copy_inflight_req_shrink(s, &req, status_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
-            bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, status_bytes);
+            block_copy_inflight_req_end(s, &req, 0);
             s->progress_reset_callback(s->progress_opaque);
             trace_block_copy_skip_range(s, offset, status_bytes);
             offset += status_bytes;
@@ -398,15 +440,13 @@ int coroutine_fn block_copy(BlockCopyState *s,
 
         trace_block_copy_process(s, offset);
 
-        bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
-
         co_get_from_shres(s->mem, cur_bytes);
         ret = block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_ZERO,
                                  error_is_read);
         co_put_to_shres(s->mem, cur_bytes);
+        block_copy_inflight_req_end(s, &req, ret);
         if (ret < 0) {
-            bdrv_set_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
-            break;
+            return ret;
         }
 
         s->progress_bytes_callback(cur_bytes, s->progress_opaque);
@@ -414,7 +454,41 @@ int coroutine_fn block_copy(BlockCopyState *s,
         bytes -= cur_bytes;
     }
 
-    block_copy_inflight_req_end(&req);
+    return found_dirty;
+}
 
-    return ret;
+int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t bytes,
+                            bool *error_is_read)
+{
+    while (true) {
+        int ret = block_copy_dirty_clusters(s, start, bytes, error_is_read);
+
+        if (ret < 0) {
+            /*
+             * IO operation failed, which means the whole block_copy request
+             * failed.
+             */
+            return ret;
+        }
+        if (ret) {
+            /*
+             * Something was copied, which means that there were yield points
+             * and some new dirty bits may appered (due to failed parallel
+             * block-copy requests).
+             */
+            continue;
+        }
+
+        /*
+         * Here ret == 0, which means that there is no dirty clusters in
+         * requested region.
+         */
+
+        if (!block_copy_wait_one(s, start, bytes)) {
+            /* No dirty bits and nothing to wait: the whole request is done */
+            break;
+        }
+    }
+
+    return 0;
 }
-- 
2.21.0


