Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEABFA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 17:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542FB21A4C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 17:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542FB21A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKmws-0005lf-R3
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 13:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iKmnb-0005xz-V4
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 13:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iKmna-0003UG-1m
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 13:09:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:52736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iKmnS-0003QL-AI; Wed, 16 Oct 2019 13:09:14 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iKmnN-0002PI-5C; Wed, 16 Oct 2019 20:09:09 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 6/6] block/block-copy: increase buffered copy request
Date: Wed, 16 Oct 2019 20:09:05 +0300
Message-Id: <20191016170905.8325-7-vsementsov@virtuozzo.com>
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

No reason to limit buffered copy to one cluster. Let's allow up to 1
MiB.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h |  2 +-
 block/block-copy.c         | 48 +++++++++++++++++++++++++-------------
 2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index edcdf0072d..0a161724d7 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -38,7 +38,7 @@ typedef struct BlockCopyState {
     BdrvDirtyBitmap *copy_bitmap;
     int64_t cluster_size;
     bool use_copy_range;
-    int64_t copy_range_size;
+    int64_t copy_size;
     uint64_t len;
     QLIST_HEAD(, BlockCopyInFlightReq) inflight_reqs;
 
diff --git a/block/block-copy.c b/block/block-copy.c
index d5042e46fd..74eb235972 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -21,6 +21,7 @@
 #include "qemu/units.h"
 
 #define BLOCK_COPY_MAX_COPY_RANGE (16 * MiB)
+#define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
 
 static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s,
@@ -75,10 +76,8 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
 {
     BlockCopyState *s;
     BdrvDirtyBitmap *copy_bitmap;
-
-    /* Ignore BLOCK_COPY_MAX_COPY_RANGE if requested cluster_size is larger */
     uint32_t max_transfer =
-            MIN_NON_ZERO(MAX(cluster_size, BLOCK_COPY_MAX_COPY_RANGE),
+            MIN_NON_ZERO(INT_MAX,
                          MIN_NON_ZERO(source->bs->bl.max_transfer,
                                       target->bs->bl.max_transfer));
 
@@ -100,17 +99,28 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
         .mem = shres_create(BLOCK_COPY_MAX_MEM),
     };
 
-    s->copy_range_size = QEMU_ALIGN_DOWN(max_transfer, cluster_size),
-    /*
-     * Set use_copy_range, consider the following:
-     * 1. Compression is not supported for copy_range.
-     * 2. copy_range does not respect max_transfer (it's a TODO), so we factor
-     *    that in here. If max_transfer is smaller than the job->cluster_size,
-     *    we do not use copy_range (in that case it's zero after aligning down
-     *    above).
-     */
-    s->use_copy_range =
-        !(write_flags & BDRV_REQ_WRITE_COMPRESSED) && s->copy_range_size > 0;
+    if (max_transfer < cluster_size) {
+        /*
+         * copy_range does not respect max_transfer. We don't want to bother
+         * with requests smaller than block-copy cluster size, so fallback to
+         * buffered copying (read and write respect max_transfer on their
+         * behalf).
+         */
+        s->use_copy_range = false;
+        s->copy_size = cluster_size;
+    } else if (write_flags & BDRV_REQ_WRITE_COMPRESSED) {
+        /* Compression is not supported for copy_range */
+        s->use_copy_range = false;
+        s->copy_size = MAX(cluster_size, BLOCK_COPY_MAX_BUFFER);
+    } else {
+        /*
+         * copy_range does not respect max_transfer (it's a TODO), so we factor
+         * that in here.
+         */
+        s->use_copy_range = true;
+        s->copy_size = MIN(MAX(cluster_size, BLOCK_COPY_MAX_COPY_RANGE),
+                           QEMU_ALIGN_DOWN(max_transfer, cluster_size));
+    }
 
     QLIST_INIT(&s->inflight_reqs);
 
@@ -156,12 +166,19 @@ static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
         if (ret < 0) {
             trace_block_copy_copy_range_fail(s, start, ret);
             s->use_copy_range = false;
+            s->copy_size = MAX(s->cluster_size, BLOCK_COPY_MAX_BUFFER);
             /* Fallback to read+write with allocated buffer */
         } else {
             goto out;
         }
     }
 
+    /*
+     * In case of failed copy_range request above, we may proceed with buffered
+     * request larger than BLOCK_COPY_MAX_BUFFER. Still, further requests will
+     * be properly limited, so don't care too much.
+     */
+
     bounce_buffer = qemu_blockalign(s->source->bs, nbytes);
 
     ret = bdrv_co_pread(s->source, start, nbytes, bounce_buffer, 0);
@@ -290,8 +307,7 @@ int coroutine_fn block_copy(BlockCopyState *s,
             continue; /* already copied */
         }
 
-        chunk_end = MIN(end, start + (s->use_copy_range ?
-                                      s->copy_range_size : s->cluster_size));
+        chunk_end = MIN(end, start + s->copy_size);
 
         next_zero = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
                                                 chunk_end - start);
-- 
2.21.0


