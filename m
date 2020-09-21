Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06915C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93AEA2220C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X5naWv+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AEA2220C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMwD-000834-Pe
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kKMqa-0003hn-HU; Mon, 21 Sep 2020 10:31:16 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:47070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kKMqV-000488-Ja; Mon, 21 Sep 2020 10:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=8MSD+kShelfQs8Qfb7zJ8s9z9wACV8Cb3xSSkIL2i+w=; 
 b=X5naWv+19Zzk5JbLrKYrVqANGKKZyITaHZihlN9pslZTdYT76BKh4fhWtUbD+wwOTw3gect3MFB3wncEL/Z8fDf9gUif5bchgjS2rsjfUOpixkw0mwsgNoOjF+3eoy3C0mtHoXKsXCGcQ14pgbf6niN2dM2bEFLyljlvv4nebD9aojqZj3avstBAElsXbJ3fpNiJJrXszmv/qukVq/MNqq2ILdioa7EXNcTh4Q5HomZVWVWSgsyO+1KfSlFExdZcDQMHeIPeH+a140Ca4i4hzijjhdHEk7zst3KGNtVMqUDvnfZ8uQeilEABJNaRzRMUM300j3MEf213ePf9FN+h1w==;
Received: from [81.0.34.134] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kKMqQ-0000We-AF; Mon, 21 Sep 2020 16:31:06 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kKMqD-0005yX-4m; Mon, 21 Sep 2020 16:30:53 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/2] qcow2: Skip copy-on-write when allocating a zero
 cluster
Date: Mon, 21 Sep 2020 16:30:50 +0200
Message-Id: <318f33908c9d78577d9afbd5dee252f2785492dc.1600698425.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1600698425.git.berto@igalia.com>
References: <cover.1600698425.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 10:31:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h |  2 ++
 block/io.c            | 27 +++++++++++++++++++++++++++
 block/qcow2.c         | 35 +++++++++++++++++++----------------
 3 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 981ab5b314..26ada4445b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -496,6 +496,8 @@ int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
 int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
                             bool include_base, int64_t offset, int64_t bytes,
                             int64_t *pnum);
+int coroutine_fn bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset,
+                                      int64_t bytes);
 
 bool bdrv_is_read_only(BlockDriverState *bs);
 int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
diff --git a/block/io.c b/block/io.c
index ef1ea806e8..8084dec522 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2541,6 +2541,33 @@ int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
                                    offset, bytes, pnum, map, file);
 }
 
+/*
+ * Check @bs (and its backing chain) to see if the range defined
+ * by @offset and @bytes is known to read as zeroes.
+ * Return 1 if that is the case, 0 otherwise and -errno on error.
+ * This test is meant to be fast rather than accurate so returning 0
+ * does not guarantee non-zero data.
+ */
+int coroutine_fn bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset,
+                                      int64_t bytes)
+{
+    int ret;
+    int64_t pnum = bytes;
+
+    if (!bytes) {
+        return 1;
+    }
+
+    ret = bdrv_common_block_status_above(bs, NULL, false, offset,
+                                         bytes, &pnum, NULL, NULL);
+
+    if (ret < 0) {
+        return ret;
+    }
+
+    return (pnum == bytes) && (ret & BDRV_BLOCK_ZERO);
+}
+
 int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
                                    int64_t bytes, int64_t *pnum)
 {
diff --git a/block/qcow2.c b/block/qcow2.c
index b05512718c..114526ce62 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2387,26 +2387,26 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
     return false;
 }
 
-static bool is_unallocated(BlockDriverState *bs, int64_t offset, int64_t bytes)
-{
-    int64_t nr;
-    return !bytes ||
-        (!bdrv_is_allocated_above(bs, NULL, false, offset, bytes, &nr) &&
-         nr == bytes);
-}
-
-static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
+/*
+ * Return 1 if the COW regions read as zeroes, 0 if not, < 0 on error.
+ * Note that returning 0 does not guarantee non-zero data.
+ */
+static int is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
 {
     /*
      * This check is designed for optimization shortcut so it must be
      * efficient.
-     * Instead of is_zero(), use is_unallocated() as it is faster (but not
-     * as accurate and can result in false negatives).
+     * Instead of is_zero(), use bdrv_co_is_zero_fast() as it is
+     * faster (but not as accurate and can result in false negatives).
      */
-    return is_unallocated(bs, m->offset + m->cow_start.offset,
-                          m->cow_start.nb_bytes) &&
-           is_unallocated(bs, m->offset + m->cow_end.offset,
-                          m->cow_end.nb_bytes);
+    int ret = bdrv_co_is_zero_fast(bs, m->offset + m->cow_start.offset,
+                                   m->cow_start.nb_bytes);
+    if (ret <= 0) {
+        return ret;
+    }
+
+    return bdrv_co_is_zero_fast(bs, m->offset + m->cow_end.offset,
+                                m->cow_end.nb_bytes);
 }
 
 static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
@@ -2432,7 +2432,10 @@ static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
             continue;
         }
 
-        if (!is_zero_cow(bs, m)) {
+        ret = is_zero_cow(bs, m);
+        if (ret < 0) {
+            return ret;
+        } else if (ret == 0) {
             continue;
         }
 
-- 
2.20.1


