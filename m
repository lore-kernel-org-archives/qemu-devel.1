Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F542C18E5A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A02208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A02208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jByeu-0005Xz-BH
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 06:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jByd8-0002to-6H
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jByd6-0001Wz-VF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:30:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:33054)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jByd3-0001Rb-IP; Wed, 11 Mar 2020 06:30:21 -0400
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1jBycy-0005cJ-3u; Wed, 11 Mar 2020 13:30:16 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 3/9] block/block-copy: specialcase first copy_range request
Date: Wed, 11 Mar 2020 13:29:58 +0300
Message-Id: <20200311103004.7649-4-vsementsov@virtuozzo.com>
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

In block_copy_do_copy we fallback to read+write if copy_range failed.
In this case copy_size is larger than defined for buffered IO, and
there is corresponding commit. Still, backup copies data cluster by
cluster, and most of requests are limited to one cluster anyway, so the
only source of this one bad-limited request is copy-before-write
operation.

Further patch will move backup to use block_copy directly, than for
cases where copy_range is not supported, first request will be
oversized in each backup. It's not good, let's change it now.

Fix is simple: just limit first copy_range request like buffer-based
request. If it succeed, set larger copy_range limit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index e2d7b3b887..ddd61c1652 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -70,16 +70,19 @@ void block_copy_state_free(BlockCopyState *s)
     g_free(s);
 }
 
+static uint32_t block_copy_max_transfer(BdrvChild *source, BdrvChild *target)
+{
+    return MIN_NON_ZERO(INT_MAX,
+                        MIN_NON_ZERO(source->bs->bl.max_transfer,
+                                     target->bs->bl.max_transfer));
+}
+
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      int64_t cluster_size,
                                      BdrvRequestFlags write_flags, Error **errp)
 {
     BlockCopyState *s;
     BdrvDirtyBitmap *copy_bitmap;
-    uint32_t max_transfer =
-            MIN_NON_ZERO(INT_MAX,
-                         MIN_NON_ZERO(source->bs->bl.max_transfer,
-                                      target->bs->bl.max_transfer));
 
     copy_bitmap = bdrv_create_dirty_bitmap(source->bs, cluster_size, NULL,
                                            errp);
@@ -99,7 +102,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
         .mem = shres_create(BLOCK_COPY_MAX_MEM),
     };
 
-    if (max_transfer < cluster_size) {
+    if (block_copy_max_transfer(source, target) < cluster_size) {
         /*
          * copy_range does not respect max_transfer. We don't want to bother
          * with requests smaller than block-copy cluster size, so fallback to
@@ -114,12 +117,11 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
         s->copy_size = cluster_size;
     } else {
         /*
-         * copy_range does not respect max_transfer (it's a TODO), so we factor
-         * that in here.
+         * We enable copy-range, but keep small copy_size, until first
+         * successful copy_range (look at block_copy_do_copy).
          */
         s->use_copy_range = true;
-        s->copy_size = MIN(MAX(cluster_size, BLOCK_COPY_MAX_COPY_RANGE),
-                           QEMU_ALIGN_DOWN(max_transfer, cluster_size));
+        s->copy_size = MAX(s->cluster_size, BLOCK_COPY_MAX_BUFFER);
     }
 
     QLIST_INIT(&s->inflight_reqs);
@@ -172,6 +174,22 @@ static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
             s->copy_size = MAX(s->cluster_size, BLOCK_COPY_MAX_BUFFER);
             /* Fallback to read+write with allocated buffer */
         } else {
+            if (s->use_copy_range) {
+                /*
+                 * Successful copy-range. Now increase copy_size.  copy_range
+                 * does not respect max_transfer (it's a TODO), so we factor
+                 * that in here.
+                 *
+                 * Note: we double-check s->use_copy_range for the case when
+                 * parallel block-copy request unsets it during previous
+                 * bdrv_co_copy_range call.
+                 */
+                s->copy_size =
+                        MIN(MAX(s->cluster_size, BLOCK_COPY_MAX_COPY_RANGE),
+                            QEMU_ALIGN_DOWN(block_copy_max_transfer(s->source,
+                                                                    s->target),
+                                            s->cluster_size));
+            }
             goto out;
         }
     }
@@ -179,7 +197,10 @@ static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
     /*
      * In case of failed copy_range request above, we may proceed with buffered
      * request larger than BLOCK_COPY_MAX_BUFFER. Still, further requests will
-     * be properly limited, so don't care too much.
+     * be properly limited, so don't care too much. Moreover the most likely
+     * case (copy_range is unsupported for the configuration, so the very first
+     * copy_range request fails) is handled by setting large copy_size only
+     * after first successful copy_range.
      */
 
     bounce_buffer = qemu_blockalign(s->source->bs, nbytes);
-- 
2.21.0


