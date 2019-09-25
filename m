Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA24FC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 17:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85581207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 17:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85581207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDAe4-0002GT-S5
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 13:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDAcs-0001Yr-Ta
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDAcr-0007Uk-Ou
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:58:50 -0400
Received: from relay.sw.ru ([185.231.240.75]:49928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDAcp-0007Tv-2N; Wed, 25 Sep 2019 12:58:47 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDAcm-0007W3-3e; Wed, 25 Sep 2019 19:58:44 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 16/15 v13] block/block-copy: fix block_copy
Date: Wed, 25 Sep 2019 19:58:08 +0300
Message-Id: <20190925165808.20950-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142056.12778-1-vsementsov@virtuozzo.com>
References: <20190920142056.12778-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

block_copy_reset_unallocated may yield, and during this yield someone
may handle dirty bits which we are handling. Calling block_copy_with_*
functions on non-dirty region will lead to copying updated data, which
is wrong.

To be sure, that we call block_copy_with_* functions on dirty region,
check dirty bitmap _after_ block_copy_reset_unallocated.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi!

Suddenly I understand that there is a bug in

[PATCH v13 15/15] block/backup: use backup-top instead of write notifiers
(queued at Max's https://git.xanclic.moe/XanClic/qemu/commits/branch/block)

And here is a fix, which may be squashed to
"block/backup: use backup-top instead of write notifiers" commit.

 block/block-copy.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 55bc360d22..430b88124f 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -292,7 +292,7 @@ int coroutine_fn block_copy(BlockCopyState *s,
     assert(QEMU_IS_ALIGNED(end, s->cluster_size));
 
     while (start < end) {
-        int64_t dirty_end;
+        int64_t chunk_end = end, dirty_end;
 
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, start)) {
             trace_block_copy_skip(s, start);
@@ -300,12 +300,6 @@ int coroutine_fn block_copy(BlockCopyState *s,
             continue; /* already copied */
         }
 
-        dirty_end = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
-                                                (end - start));
-        if (dirty_end < 0) {
-            dirty_end = end;
-        }
-
         if (s->skip_unallocated) {
             ret = block_copy_reset_unallocated(s, start, &status_bytes);
             if (ret == 0) {
@@ -313,20 +307,37 @@ int coroutine_fn block_copy(BlockCopyState *s,
                 start += status_bytes;
                 continue;
             }
+
+            if (!bdrv_dirty_bitmap_get(s->copy_bitmap, start)) {
+                /*
+                 * Someone already handled this bit during yield in
+                 * block_copy_reset_unallocated.
+                 */
+                trace_block_copy_skip(s, start);
+                start += s->cluster_size;
+                continue;
+            }
+
             /* Clamp to known allocated region */
-            dirty_end = MIN(dirty_end, start + status_bytes);
+            chunk_end = MIN(chunk_end, start + status_bytes);
+        }
+
+        dirty_end = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
+                                                chunk_end - start);
+        if (dirty_end >= 0) {
+            chunk_end = MIN(chunk_end, dirty_end);
         }
 
         trace_block_copy_process(s, start);
 
         if (s->use_copy_range) {
-            ret = block_copy_with_offload(s, start, dirty_end);
+            ret = block_copy_with_offload(s, start, chunk_end);
             if (ret < 0) {
                 s->use_copy_range = false;
             }
         }
         if (!s->use_copy_range) {
-            ret = block_copy_with_bounce_buffer(s, start, dirty_end,
+            ret = block_copy_with_bounce_buffer(s, start, chunk_end,
                                                 error_is_read, &bounce_buffer);
         }
         if (ret < 0) {
-- 
2.21.0


