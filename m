Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0979FC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93FC320862
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FC320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia22l-0007qJ-Bv
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia1kB-0006dy-1h
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia1k9-0003sk-Mu
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:08:50 -0500
Received: from relay.sw.ru ([185.231.240.75]:49980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia1k6-0003ip-4O; Wed, 27 Nov 2019 13:08:46 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia1k0-0002UU-P5; Wed, 27 Nov 2019 21:08:40 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/7] block/block-copy: use block_status
Date: Wed, 27 Nov 2019 21:08:35 +0300
Message-Id: <20191127180840.11937-3-vsementsov@virtuozzo.com>
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

Use bdrv_block_status_above to chose effective chunk size and to handle
zeroes effectively.

This substitutes checking for just being allocated or not, and drops
old code path for it. Assistance by backup job is dropped too, as
caching block-status information is more difficult than just caching
is-allocated information in our dirty bitmap, and backup job is not
good place for this caching anyway.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 67 +++++++++++++++++++++++++++++++++++++---------
 block/trace-events |  1 +
 2 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 8602e2cae7..74295d93d5 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -152,7 +152,7 @@ void block_copy_set_callbacks(
  */
 static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
                                            int64_t start, int64_t end,
-                                           bool *error_is_read)
+                                           bool zeroes, bool *error_is_read)
 {
     int ret;
     int nbytes = MIN(end, s->len) - start;
@@ -162,6 +162,18 @@ static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
     assert(QEMU_IS_ALIGNED(end, s->cluster_size));
     assert(end < s->len || end == QEMU_ALIGN_UP(s->len, s->cluster_size));
 
+    if (zeroes) {
+        ret = bdrv_co_pwrite_zeroes(s->target, start, nbytes, s->write_flags &
+                                    ~BDRV_REQ_WRITE_COMPRESSED);
+        if (ret < 0) {
+            trace_block_copy_write_zeroes_fail(s, start, ret);
+            if (error_is_read) {
+                *error_is_read = false;
+            }
+        }
+        return ret;
+    }
+
     if (s->use_copy_range) {
         ret = bdrv_co_copy_range(s->source, start, s->target, start, nbytes,
                                  0, s->write_flags);
@@ -225,6 +237,34 @@ out:
     return ret;
 }
 
+static int block_copy_block_status(BlockCopyState *s, int64_t offset,
+                                   int64_t bytes, int64_t *pnum)
+{
+    int64_t num;
+    BlockDriverState *base;
+    int ret;
+
+    if (s->skip_unallocated && s->source->bs->backing) {
+        base = s->source->bs->backing->bs;
+    } else {
+        base = NULL;
+    }
+
+    ret = bdrv_block_status_above(s->source->bs, base, offset, bytes, &num,
+                                  NULL, NULL);
+    if (ret < 0 || num < s->cluster_size) {
+        num = s->cluster_size;
+        ret = BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_DATA;
+    } else if (offset + num == s->len) {
+        num = QEMU_ALIGN_UP(num, s->cluster_size);
+    } else {
+        num = QEMU_ALIGN_DOWN(num, s->cluster_size);
+    }
+
+    *pnum = num;
+    return ret;
+}
+
 /*
  * Check if the cluster starting at offset is allocated or not.
  * return via pnum the number of contiguous clusters sharing this allocation.
@@ -301,7 +341,6 @@ int coroutine_fn block_copy(BlockCopyState *s,
 {
     int ret = 0;
     int64_t end = bytes + start; /* bytes */
-    int64_t status_bytes;
     BlockCopyInFlightReq req;
 
     /*
@@ -318,7 +357,7 @@ int coroutine_fn block_copy(BlockCopyState *s,
     block_copy_inflight_req_begin(s, &req, start, end);
 
     while (start < end) {
-        int64_t next_zero, chunk_end;
+        int64_t next_zero, chunk_end, status_bytes;
 
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, start)) {
             trace_block_copy_skip(s, start);
@@ -336,23 +375,25 @@ int coroutine_fn block_copy(BlockCopyState *s,
             chunk_end = next_zero;
         }
 
-        if (s->skip_unallocated) {
-            ret = block_copy_reset_unallocated(s, start, &status_bytes);
-            if (ret == 0) {
-                trace_block_copy_skip_range(s, start, status_bytes);
-                start += status_bytes;
-                continue;
-            }
-            /* Clamp to known allocated region */
-            chunk_end = MIN(chunk_end, start + status_bytes);
+        ret = block_copy_block_status(s, start, chunk_end - start,
+                                      &status_bytes);
+        if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
+            bdrv_reset_dirty_bitmap(s->copy_bitmap, start, status_bytes);
+            s->progress_reset_callback(s->progress_opaque);
+            trace_block_copy_skip_range(s, start, status_bytes);
+            start += status_bytes;
+            continue;
         }
 
+        chunk_end = MIN(chunk_end, start + status_bytes);
+
         trace_block_copy_process(s, start);
 
         bdrv_reset_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
 
         co_get_from_shres(s->mem, chunk_end - start);
-        ret = block_copy_do_copy(s, start, chunk_end, error_is_read);
+        ret = block_copy_do_copy(s, start, chunk_end, ret & BDRV_BLOCK_ZERO,
+                                 error_is_read);
         co_put_to_shres(s->mem, chunk_end - start);
         if (ret < 0) {
             bdrv_set_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
diff --git a/block/trace-events b/block/trace-events
index 6ba86decca..346537a1d2 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -48,6 +48,7 @@ block_copy_process(void *bcs, int64_t start) "bcs %p start %"PRId64
 block_copy_copy_range_fail(void *bcs, int64_t start, int ret) "bcs %p start %"PRId64" ret %d"
 block_copy_read_fail(void *bcs, int64_t start, int ret) "bcs %p start %"PRId64" ret %d"
 block_copy_write_fail(void *bcs, int64_t start, int ret) "bcs %p start %"PRId64" ret %d"
+block_copy_write_zeroes_fail(void *bcs, int64_t start, int ret) "bcs %p start %"PRId64" ret %d"
 
 # ../blockdev.c
 qmp_block_job_cancel(void *job) "job %p"
-- 
2.21.0


