Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50982C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254702146E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254702146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jByhU-0001Pd-AX
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 06:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jByd9-0002v7-8S
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jByd7-0001XL-Iw
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:30:27 -0400
Received: from relay.sw.ru ([185.231.240.75]:33046)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jByd3-0001RY-I7; Wed, 11 Mar 2020 06:30:21 -0400
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1jBycy-0005cJ-P0; Wed, 11 Mar 2020 13:30:16 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 6/9] block/block-copy: refactor interfaces to use bytes
 instead of end
Date: Wed, 11 Mar 2020 13:30:01 +0300
Message-Id: <20200311103004.7649-7-vsementsov@virtuozzo.com>
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

We have a lot of "chunk_end - start" invocations, let's switch to
bytes/cur_bytes scheme instead.

While being here, improve check on block_copy_do_copy parameters to not
overflow when calculating nbytes and use int64_t for bytes in
block_copy for consistency.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block-copy.h |  6 +--
 block/block-copy.c         | 78 ++++++++++++++++++++------------------
 2 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 9def00068c..7fd36e528b 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -19,8 +19,8 @@
 #include "qemu/co-shared-resource.h"
 
 typedef struct BlockCopyInFlightReq {
-    int64_t start_byte;
-    int64_t end_byte;
+    int64_t start;
+    int64_t bytes;
     QLIST_ENTRY(BlockCopyInFlightReq) list;
     CoQueue wait_queue; /* coroutines blocked on this request */
 } BlockCopyInFlightReq;
@@ -85,7 +85,7 @@ void block_copy_state_free(BlockCopyState *s);
 int64_t block_copy_reset_unallocated(BlockCopyState *s,
                                      int64_t offset, int64_t *count);
 
-int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t bytes,
+int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t bytes,
                             bool *error_is_read);
 
 #endif /* BLOCK_COPY_H */
diff --git a/block/block-copy.c b/block/block-copy.c
index 251d415a2c..4c947e548b 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -26,12 +26,12 @@
 
 static BlockCopyInFlightReq *find_conflicting_inflight_req(BlockCopyState *s,
                                                            int64_t start,
-                                                           int64_t end)
+                                                           int64_t bytes)
 {
     BlockCopyInFlightReq *req;
 
     QLIST_FOREACH(req, &s->inflight_reqs, list) {
-        if (end > req->start_byte && start < req->end_byte) {
+        if (start + bytes > req->start && start < req->start + req->bytes) {
             return req;
         }
     }
@@ -41,21 +41,21 @@ static BlockCopyInFlightReq *find_conflicting_inflight_req(BlockCopyState *s,
 
 static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s,
                                                        int64_t start,
-                                                       int64_t end)
+                                                       int64_t bytes)
 {
     BlockCopyInFlightReq *req;
 
-    while ((req = find_conflicting_inflight_req(s, start, end))) {
+    while ((req = find_conflicting_inflight_req(s, start, bytes))) {
         qemu_co_queue_wait(&req->wait_queue, NULL);
     }
 }
 
 static void block_copy_inflight_req_begin(BlockCopyState *s,
                                           BlockCopyInFlightReq *req,
-                                          int64_t start, int64_t end)
+                                          int64_t start, int64_t bytes)
 {
-    req->start_byte = start;
-    req->end_byte = end;
+    req->start = start;
+    req->bytes = bytes;
     qemu_co_queue_init(&req->wait_queue);
     QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
 }
@@ -153,24 +153,28 @@ void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm)
 /*
  * block_copy_do_copy
  *
- * Do copy of cluser-aligned chunk. @end is allowed to exceed s->len only to
- * cover last cluster when s->len is not aligned to clusters.
+ * Do copy of cluster-aligned chunk. Requested region is allowed to exceed
+ * s->len only to cover last cluster when s->len is not aligned to clusters.
  *
  * No sync here: nor bitmap neighter intersecting requests handling, only copy.
  *
  * Returns 0 on success.
  */
 static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
-                                           int64_t start, int64_t end,
+                                           int64_t start, int64_t bytes,
                                            bool zeroes, bool *error_is_read)
 {
     int ret;
-    int nbytes = MIN(end, s->len) - start;
+    int64_t nbytes = MIN(start + bytes, s->len) - start;
     void *bounce_buffer = NULL;
 
+    assert(start >= 0 && bytes > 0 && INT64_MAX - start >= bytes);
     assert(QEMU_IS_ALIGNED(start, s->cluster_size));
-    assert(QEMU_IS_ALIGNED(end, s->cluster_size));
-    assert(end < s->len || end == QEMU_ALIGN_UP(s->len, s->cluster_size));
+    assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
+    assert(start < s->len);
+    assert(start + bytes <= s->len ||
+           start + bytes == QEMU_ALIGN_UP(s->len, s->cluster_size));
+    assert(nbytes < INT_MAX);
 
     if (zeroes) {
         ret = bdrv_co_pwrite_zeroes(s->target, start, nbytes, s->write_flags &
@@ -354,11 +358,10 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
 }
 
 int coroutine_fn block_copy(BlockCopyState *s,
-                            int64_t start, uint64_t bytes,
+                            int64_t start, int64_t bytes,
                             bool *error_is_read)
 {
     int ret = 0;
-    int64_t end = bytes + start; /* bytes */
     BlockCopyInFlightReq req;
 
     /*
@@ -369,32 +372,32 @@ int coroutine_fn block_copy(BlockCopyState *s,
            bdrv_get_aio_context(s->target->bs));
 
     assert(QEMU_IS_ALIGNED(start, s->cluster_size));
-    assert(QEMU_IS_ALIGNED(end, s->cluster_size));
+    assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
 
     block_copy_wait_inflight_reqs(s, start, bytes);
-    block_copy_inflight_req_begin(s, &req, start, end);
+    block_copy_inflight_req_begin(s, &req, start, bytes);
 
-    while (start < end) {
-        int64_t next_zero, chunk_end, status_bytes;
+    while (bytes) {
+        int64_t next_zero, cur_bytes, status_bytes;
 
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, start)) {
             trace_block_copy_skip(s, start);
             start += s->cluster_size;
+            bytes -= s->cluster_size;
             continue; /* already copied */
         }
 
-        chunk_end = MIN(end, start + s->copy_size);
+        cur_bytes = MIN(bytes, s->copy_size);
 
         next_zero = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
-                                                chunk_end - start);
+                                                cur_bytes);
         if (next_zero >= 0) {
             assert(next_zero > start); /* start is dirty */
-            assert(next_zero < chunk_end); /* no need to do MIN() */
-            chunk_end = next_zero;
+            assert(next_zero < start + cur_bytes); /* no need to do MIN() */
+            cur_bytes = next_zero - start;
         }
 
-        ret = block_copy_block_status(s, start, chunk_end - start,
-                                      &status_bytes);
+        ret = block_copy_block_status(s, start, cur_bytes, &status_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
             bdrv_reset_dirty_bitmap(s->copy_bitmap, start, status_bytes);
             progress_set_remaining(s->progress,
@@ -402,30 +405,31 @@ int coroutine_fn block_copy(BlockCopyState *s,
                                    s->in_flight_bytes);
             trace_block_copy_skip_range(s, start, status_bytes);
             start += status_bytes;
+            bytes -= status_bytes;
             continue;
         }
 
-        chunk_end = MIN(chunk_end, start + status_bytes);
+        cur_bytes = MIN(cur_bytes, status_bytes);
 
         trace_block_copy_process(s, start);
 
-        bdrv_reset_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
-        s->in_flight_bytes += chunk_end - start;
+        bdrv_reset_dirty_bitmap(s->copy_bitmap, start, cur_bytes);
+        s->in_flight_bytes += cur_bytes;
 
-        co_get_from_shres(s->mem, chunk_end - start);
-        ret = block_copy_do_copy(s, start, chunk_end, ret & BDRV_BLOCK_ZERO,
+        co_get_from_shres(s->mem, cur_bytes);
+        ret = block_copy_do_copy(s, start, cur_bytes, ret & BDRV_BLOCK_ZERO,
                                  error_is_read);
-        co_put_to_shres(s->mem, chunk_end - start);
-        s->in_flight_bytes -= chunk_end - start;
+        co_put_to_shres(s->mem, cur_bytes);
+        s->in_flight_bytes -= cur_bytes;
         if (ret < 0) {
-            bdrv_set_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
+            bdrv_set_dirty_bitmap(s->copy_bitmap, start, cur_bytes);
             break;
         }
 
-        progress_work_done(s->progress, chunk_end - start);
-        s->progress_bytes_callback(chunk_end - start, s->progress_opaque);
-        start = chunk_end;
-        ret = 0;
+        progress_work_done(s->progress, cur_bytes);
+        s->progress_bytes_callback(cur_bytes, s->progress_opaque);
+        start += cur_bytes;
+        bytes -= cur_bytes;
     }
 
     block_copy_inflight_req_end(&req);
-- 
2.21.0


