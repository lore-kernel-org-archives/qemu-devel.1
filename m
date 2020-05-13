Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F312CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 09:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF8F20753
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 09:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF8F20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYo84-0000Tz-DO
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 05:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYo32-0006oB-40; Wed, 13 May 2020 05:51:32 -0400
Received: from relay.sw.ru ([185.231.240.75]:54004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYo2z-0003ZB-2o; Wed, 13 May 2020 05:51:31 -0400
Received: from dhcp-172-16-25-136.sw.ru ([172.16.25.136] helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYo2V-0001e4-MS; Wed, 13 May 2020 12:50:59 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 06/15] block: Use CAFs in block status functions
Date: Wed, 13 May 2020 12:50:47 +0300
Message-Id: <1589363456-1035571-7-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589363456-1035571-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1589363456-1035571-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 05:51:06
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, mreitz@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Use the child access functions in the block status inquiry functions as
appropriate.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/block/io.c b/block/io.c
index 7d30e61..47d8096 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2387,11 +2387,12 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
         ret |= BDRV_BLOCK_ALLOCATED;
     } else if (want_zero) {
+        BlockDriverState *cow_bs = bdrv_filtered_cow_bs(bs);
+
         if (bdrv_unallocated_blocks_are_zero(bs)) {
             ret |= BDRV_BLOCK_ZERO;
-        } else if (bs->backing) {
-            BlockDriverState *bs2 = bs->backing->bs;
-            int64_t size2 = bdrv_getlength(bs2);
+        } else if (cow_bs) {
+            int64_t size2 = bdrv_getlength(cow_bs);
 
             if (size2 >= 0 && offset >= size2) {
                 ret |= BDRV_BLOCK_ZERO;
@@ -2457,7 +2458,7 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
     bool first = true;
 
     assert(bs != base);
-    for (p = bs; p != base; p = backing_bs(p)) {
+    for (p = bs; p != base; p = bdrv_filtered_bs(p)) {
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
                                    file);
         if (ret < 0) {
@@ -2543,7 +2544,7 @@ int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
 int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
                       int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
-    return bdrv_block_status_above(bs, backing_bs(bs),
+    return bdrv_block_status_above(bs, bdrv_filtered_bs(bs),
                                    offset, bytes, pnum, map, file);
 }
 
@@ -2553,9 +2554,9 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
     int ret;
     int64_t dummy;
 
-    ret = bdrv_common_block_status_above(bs, backing_bs(bs), false, offset,
-                                         bytes, pnum ? pnum : &dummy, NULL,
-                                         NULL);
+    ret = bdrv_common_block_status_above(bs, bdrv_filtered_bs(bs), false,
+                                         offset, bytes, pnum ? pnum : &dummy,
+                                         NULL, NULL);
     if (ret < 0) {
         return ret;
     }
@@ -2618,7 +2619,7 @@ int bdrv_is_allocated_above(BlockDriverState *top,
             break;
         }
 
-        intermediate = backing_bs(intermediate);
+        intermediate = bdrv_filtered_bs(intermediate);
     }
 
     *pnum = n;
-- 
1.8.3.1


