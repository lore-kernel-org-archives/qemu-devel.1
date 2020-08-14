Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7500DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 14:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438E220855
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 14:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ddMVjsFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438E220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bB3-0007Kg-GF
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 10:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k6bA3-0006NZ-Nj; Fri, 14 Aug 2020 10:58:27 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k6bA0-0003v6-Bi; Fri, 14 Aug 2020 10:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=ovdgE73f1ipNwRiFdggQarMim1KeTu5FasgyhunEZfM=; 
 b=ddMVjsFIPF73AHBoBDf0qFEcfELyXbyO0SNs0lrFxvHmvmMqcVvRFQXEPxtElAkO7zyz5jL9HSIu2bvn5kYl4bTomm1YG9aPgkrO2/nUCTCDBL9BeK7HpX+Jfz+NFp0wn5BcZdWrEOSqImQAXlSkoMOYHcHg/UbR5UmWd4kgnEGUQw0Bs/Py1IBrPKsfAI2T4QYDEvrBr1t7mVQCChOLSV4QvU+SPdwhrI+/4QSdNUuPqtrnqZwAls3Cf8KjIQAz/2EP2K5Tcag+bKh92tKfpaa6gbIW8AEMC40mHFouVh8K/7XUsfSlYR6LNEAXoia5dm8qmxlk9lQea7oU6ZPbVA==;
Received: from [81.0.33.30] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1k6b9b-00038c-D1; Fri, 14 Aug 2020 16:57:59 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1k6b9O-00039c-Ju; Fri, 14 Aug 2020 16:57:46 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] qcow2: Skip copy-on-write when allocating a zero cluster
Date: Fri, 14 Aug 2020 16:57:41 +0200
Message-Id: <8d0ca4de285ec56fa24ea43b8763f305816a0acc.1597416317.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1597416317.git.berto@igalia.com>
References: <cover.1597416317.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 10:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit c8bb23cbdbe32f5c326365e0a82e1b0e68cdcd8a when a write
request results in a new allocation QEMU first tries to see if the
rest of the cluster outside the written area contains only zeroes.

In that case, instead of doing a normal copy-on-write operation and
writing explicit zero buffers to disk, the code zeroes the whole
cluster efficiently using pwrite_zeroes() with BDRV_REQ_NO_FALLBACK.

This improves performance very significantly but it only happens when
we are writing to an area that was completely unallocated before. Zero
clusters (QCOW2_CLUSTER_ZERO_*) are treated like normal clusters and
are therefore slower to allocate.

This happens because the code uses bdrv_is_allocated_above() rather
bdrv_block_status_above(). The former is not as accurate for this
purpose but it is faster. However in the case of qcow2 the underlying
call does already report zero clusters just fine so there is no reason
why we cannot use that information.

After testing 4KB writes on an image that only contains zero clusters
this patch results in almost five times more IOPS.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 include/block/block.h |  2 +-
 block/commit.c        |  2 +-
 block/io.c            | 20 +++++++++++++++++---
 block/mirror.c        |  3 ++-
 block/qcow2.c         | 26 ++++++++++++++++----------
 block/replication.c   |  2 +-
 block/stream.c        |  2 +-
 qemu-img.c            |  2 +-
 8 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 6e36154061..314ce6f425 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -495,7 +495,7 @@ int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
                       int64_t *pnum);
 int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
                             bool include_base, int64_t offset, int64_t bytes,
-                            int64_t *pnum);
+                            int64_t *pnum, bool *is_zero);
 
 bool bdrv_is_read_only(BlockDriverState *bs);
 int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
diff --git a/block/commit.c b/block/commit.c
index 7732d02dfe..9932a9cf90 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -154,7 +154,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
         }
         /* Copy if allocated above the base */
         ret = bdrv_is_allocated_above(blk_bs(s->top), blk_bs(s->base), false,
-                                      offset, COMMIT_BUFFER_SIZE, &n);
+                                      offset, COMMIT_BUFFER_SIZE, &n, NULL);
         copy = (ret == 1);
         trace_commit_one_iteration(s, offset, n, ret);
         if (copy) {
diff --git a/block/io.c b/block/io.c
index ad3a51ed53..4dc92dc933 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2588,11 +2588,19 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
  * words, the result is not necessarily the maximum possible range);
  * but 'pnum' will only be 0 when end of file is reached.
  *
+ * If 'is_zero' is not NULL and the range is allocated (i.e. this
+ * function returns 1) then *is_zero will be updated to indicate if
+ * the range is known to read back as zeroes (but note however that
+ * *is_zero == false does not guarantee non-zero data).
+ * If the range is not allocated then 'is_zero' is ignored and left
+ * unset.
+ *
  */
 int bdrv_is_allocated_above(BlockDriverState *top,
                             BlockDriverState *base,
                             bool include_base, int64_t offset,
-                            int64_t bytes, int64_t *pnum)
+                            int64_t bytes, int64_t *pnum,
+                            bool *is_zero)
 {
     BlockDriverState *intermediate;
     int ret;
@@ -2606,11 +2614,17 @@ int bdrv_is_allocated_above(BlockDriverState *top,
         int64_t size_inter;
 
         assert(intermediate);
-        ret = bdrv_is_allocated(intermediate, offset, bytes, &pnum_inter);
+        ret = bdrv_common_block_status_above(intermediate,
+                                             backing_bs(intermediate),
+                                             false, offset, bytes,
+                                             &pnum_inter, NULL, NULL);
         if (ret < 0) {
             return ret;
         }
-        if (ret) {
+        if (ret & BDRV_BLOCK_ALLOCATED) {
+            if (is_zero) {
+                *is_zero = !!(ret & BDRV_BLOCK_ZERO);
+            }
             *pnum = pnum_inter;
             return 1;
         }
diff --git a/block/mirror.c b/block/mirror.c
index e8e8844afc..b42d32ca48 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -837,7 +837,8 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
             return 0;
         }
 
-        ret = bdrv_is_allocated_above(bs, base, false, offset, bytes, &count);
+        ret = bdrv_is_allocated_above(bs, base, false, offset, bytes, &count,
+                                      NULL);
         if (ret < 0) {
             return ret;
         }
diff --git a/block/qcow2.c b/block/qcow2.c
index 6ad6bdc166..aaf3d5dddf 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2377,12 +2377,18 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
     return false;
 }
 
-static bool is_unallocated(BlockDriverState *bs, int64_t offset, int64_t bytes)
+static bool is_unallocated_or_zero(BlockDriverState *bs, int64_t offset,
+                                   int64_t bytes)
 {
+    int is_allocated;
+    bool is_zero;
     int64_t nr;
-    return !bytes ||
-        (!bdrv_is_allocated_above(bs, NULL, false, offset, bytes, &nr) &&
-         nr == bytes);
+    if (!bytes) {
+        return true;
+    }
+    is_allocated = bdrv_is_allocated_above(bs, NULL, false, offset, bytes,
+                                           &nr, &is_zero);
+    return ((!is_allocated || is_zero) && nr == bytes);
 }
 
 static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
@@ -2390,13 +2396,13 @@ static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
     /*
      * This check is designed for optimization shortcut so it must be
      * efficient.
-     * Instead of is_zero(), use is_unallocated() as it is faster (but not
-     * as accurate and can result in false negatives).
+     * Instead of is_zero(), use is_unallocated_or_zero() as it is faster
+     * (but not as accurate and can result in false negatives).
      */
-    return is_unallocated(bs, m->offset + m->cow_start.offset,
-                          m->cow_start.nb_bytes) &&
-           is_unallocated(bs, m->offset + m->cow_end.offset,
-                          m->cow_end.nb_bytes);
+    return is_unallocated_or_zero(bs, m->offset + m->cow_start.offset,
+                                  m->cow_start.nb_bytes) &&
+           is_unallocated_or_zero(bs, m->offset + m->cow_end.offset,
+                                  m->cow_end.nb_bytes);
 }
 
 static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
diff --git a/block/replication.c b/block/replication.c
index 0c70215784..cd3950a13b 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -279,7 +279,7 @@ static coroutine_fn int replication_co_writev(BlockDriverState *bs,
         ret = bdrv_is_allocated_above(top->bs, base->bs, false,
                                       sector_num * BDRV_SECTOR_SIZE,
                                       remaining_sectors * BDRV_SECTOR_SIZE,
-                                      &count);
+                                      &count, NULL);
         if (ret < 0) {
             goto out1;
         }
diff --git a/block/stream.c b/block/stream.c
index 310ccbaa4c..68aa651603 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -157,7 +157,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
             /* Copy if allocated in the intermediate images.  Limit to the
              * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).  */
             ret = bdrv_is_allocated_above(backing_bs(bs), s->bottom, true,
-                                          offset, n, &n);
+                                          offset, n, &n, NULL);
             /* Finish early if end of backing file has been reached */
             if (ret == 0 && n == 0) {
                 n = len - offset;
diff --git a/qemu-img.c b/qemu-img.c
index 5308773811..0099e3675d 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3726,7 +3726,7 @@ static int img_rebase(int argc, char **argv)
                  * to take action
                  */
                 ret = bdrv_is_allocated_above(backing_bs(bs), prefix_chain_bs,
-                                              false, offset, n, &n);
+                                              false, offset, n, &n, NULL);
                 if (ret < 0) {
                     error_report("error while reading image metadata: %s",
                                  strerror(-ret));
-- 
2.20.1


