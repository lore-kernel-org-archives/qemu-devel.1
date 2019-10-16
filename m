Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB2AFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 17:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517A52067D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 17:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517A52067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKmrO-0001ja-Ep
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 13:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iKmnb-0005xx-Uu
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 13:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iKmna-0003UV-2A
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 13:09:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:52724)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iKmnS-0003Pf-9s; Wed, 16 Oct 2019 13:09:14 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iKmnM-0002PI-49; Wed, 16 Oct 2019 20:09:08 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 3/6] block/block-copy: refactor copying
Date: Wed, 16 Oct 2019 20:09:02 +0300
Message-Id: <20191016170905.8325-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016170905.8325-1-vsementsov@virtuozzo.com>
References: <20191016170905.8325-1-vsementsov@virtuozzo.com>
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

Merge copying code into one function block_copy_do_copy, which only
calls bdrv_ io functions and don't do any synchronization (like dirty
bitmap set/reset).

Refactor block_copy() function so that it takes full decision about
size of chunk to be copied and does all the synchronization (checking
intersecting requests, set/reset dirty bitmaps).

It will help:
 - introduce parallel processing of block_copy iterations: we need to
   calculate chunk size, start async chunk copying and go to the next
   iteration
 - simplify synchronization improvement (like memory limiting in
   further commit and reducing critical section (now we lock the whole
   requested range, when actually we need to lock only dirty region
   which we handle at the moment))

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 118 ++++++++++++++++++++-------------------------
 block/trace-events |   6 +--
 2 files changed, 54 insertions(+), 70 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index e37dfbfd03..c21db48734 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -126,79 +126,64 @@ void block_copy_set_callbacks(
 }
 
 /*
- * Copy range to target with a bounce buffer and return the bytes copied. If
- * error occurred, return a negative error number
+ * block_copy_do_copy
+ *
+ * Do copy of cluser-aligned chunk. @end is allowed to exceed s->len only to
+ * cover last cluster when s->len is not aligned to clusters.
+ *
+ * No sync here: nor bitmap neighter intersecting requests handling, only copy.
+ *
+ * Returns 0 on success.
  */
-static int coroutine_fn block_copy_with_bounce_buffer(BlockCopyState *s,
-                                                      int64_t start,
-                                                      int64_t end,
-                                                      bool *error_is_read)
+static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
+                                           int64_t start, int64_t end,
+                                           bool *error_is_read)
 {
     int ret;
-    int nbytes;
-    void *bounce_buffer = qemu_blockalign(s->source->bs, s->cluster_size);
+    int nbytes = MIN(end, s->len) - start;
+    void *bounce_buffer = NULL;
 
     assert(QEMU_IS_ALIGNED(start, s->cluster_size));
-    bdrv_reset_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
-    nbytes = MIN(s->cluster_size, s->len - start);
+    assert(QEMU_IS_ALIGNED(end, s->cluster_size));
+    assert(end < s->len || end == QEMU_ALIGN_UP(s->len, s->cluster_size));
+
+    if (s->use_copy_range) {
+        ret = bdrv_co_copy_range(s->source, start, s->target, start, nbytes,
+                                 0, s->write_flags);
+        if (ret < 0) {
+            trace_block_copy_copy_range_fail(s, start, ret);
+            s->use_copy_range = false;
+            /* Fallback to read+write with allocated buffer */
+        } else {
+            goto out;
+        }
+    }
+
+    bounce_buffer = qemu_blockalign(s->source->bs, nbytes);
 
     ret = bdrv_co_pread(s->source, start, nbytes, bounce_buffer, 0);
     if (ret < 0) {
-        trace_block_copy_with_bounce_buffer_read_fail(s, start, ret);
+        trace_block_copy_read_fail(s, start, ret);
         if (error_is_read) {
             *error_is_read = true;
         }
-        goto fail;
+        goto out;
     }
 
     ret = bdrv_co_pwrite(s->target, start, nbytes, bounce_buffer,
                          s->write_flags);
     if (ret < 0) {
-        trace_block_copy_with_bounce_buffer_write_fail(s, start, ret);
+        trace_block_copy_write_fail(s, start, ret);
         if (error_is_read) {
             *error_is_read = false;
         }
-        goto fail;
+        goto out;
     }
 
+out:
     qemu_vfree(bounce_buffer);
 
-    return nbytes;
-fail:
-    qemu_vfree(bounce_buffer);
-    bdrv_set_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
     return ret;
-
-}
-
-/*
- * Copy range to target and return the bytes copied. If error occurred, return a
- * negative error number.
- */
-static int coroutine_fn block_copy_with_offload(BlockCopyState *s,
-                                                int64_t start,
-                                                int64_t end)
-{
-    int ret;
-    int nr_clusters;
-    int nbytes;
-
-    assert(QEMU_IS_ALIGNED(s->copy_range_size, s->cluster_size));
-    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
-    nbytes = MIN(s->copy_range_size, MIN(end, s->len) - start);
-    nr_clusters = DIV_ROUND_UP(nbytes, s->cluster_size);
-    bdrv_reset_dirty_bitmap(s->copy_bitmap, start,
-                            s->cluster_size * nr_clusters);
-    ret = bdrv_co_copy_range(s->source, start, s->target, start, nbytes,
-                             0, s->write_flags);
-    if (ret < 0) {
-        trace_block_copy_with_offload_fail(s, start, ret);
-        bdrv_set_dirty_bitmap(s->copy_bitmap, start,
-                              s->cluster_size * nr_clusters);
-        return ret;
-    }
-
-    return nbytes;
 }
 
 /*
@@ -294,7 +279,7 @@ int coroutine_fn block_copy(BlockCopyState *s,
     block_copy_inflight_req_begin(s, &req, start, end);
 
     while (start < end) {
-        int64_t dirty_end;
+        int64_t next_zero, chunk_end;
 
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, start)) {
             trace_block_copy_skip(s, start);
@@ -302,10 +287,15 @@ int coroutine_fn block_copy(BlockCopyState *s,
             continue; /* already copied */
         }
 
-        dirty_end = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
-                                                (end - start));
-        if (dirty_end < 0) {
-            dirty_end = end;
+        chunk_end = MIN(end, start + (s->use_copy_range ?
+                                      s->copy_range_size : s->cluster_size));
+
+        next_zero = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
+                                                chunk_end - start);
+        if (next_zero >= 0) {
+            assert(next_zero > start); /* start is dirty */
+            assert(next_zero < chunk_end); /* no need to do MIN() */
+            chunk_end = next_zero;
         }
 
         if (s->skip_unallocated) {
@@ -316,27 +306,21 @@ int coroutine_fn block_copy(BlockCopyState *s,
                 continue;
             }
             /* Clamp to known allocated region */
-            dirty_end = MIN(dirty_end, start + status_bytes);
+            chunk_end = MIN(chunk_end, start + status_bytes);
         }
 
         trace_block_copy_process(s, start);
 
-        if (s->use_copy_range) {
-            ret = block_copy_with_offload(s, start, dirty_end);
-            if (ret < 0) {
-                s->use_copy_range = false;
-            }
-        }
-        if (!s->use_copy_range) {
-            ret = block_copy_with_bounce_buffer(s, start, dirty_end,
-                                                error_is_read);
-        }
+        bdrv_reset_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
+
+        ret = block_copy_do_copy(s, start, chunk_end, error_is_read);
         if (ret < 0) {
+            bdrv_set_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
             break;
         }
 
-        start += ret;
-        s->progress_bytes_callback(ret, s->progress_opaque);
+        s->progress_bytes_callback(chunk_end - start, s->progress_opaque);
+        start = chunk_end;
         ret = 0;
     }
 
diff --git a/block/trace-events b/block/trace-events
index b8d70f5242..ccde15a14c 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -45,9 +45,9 @@ backup_do_cow_return(void *job, int64_t offset, uint64_t bytes, int ret) "job %p
 block_copy_skip(void *bcs, int64_t start) "bcs %p start %"PRId64
 block_copy_skip_range(void *bcs, int64_t start, uint64_t bytes) "bcs %p start %"PRId64" bytes %"PRId64
 block_copy_process(void *bcs, int64_t start) "bcs %p start %"PRId64
-block_copy_with_bounce_buffer_read_fail(void *bcs, int64_t start, int ret) "bcs %p start %"PRId64" ret %d"
-block_copy_with_bounce_buffer_write_fail(void *bcs, int64_t start, int ret) "bcs %p start %"PRId64" ret %d"
-block_copy_with_offload_fail(void *bcs, int64_t start, int ret) "bcs %p start %"PRId64" ret %d"
+block_copy_copy_range_fail(void *bcs, int64_t start, int ret) "bcs %p start %"PRId64" ret %d"
+block_copy_read_fail(void *bcs, int64_t start, int ret) "bcs %p start %"PRId64" ret %d"
+block_copy_write_fail(void *bcs, int64_t start, int ret) "bcs %p start %"PRId64" ret %d"
 
 # ../blockdev.c
 qmp_block_job_cancel(void *job) "job %p"
-- 
2.21.0


