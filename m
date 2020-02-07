Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651B8C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3763A21775
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3763A21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06G1-0007hy-D3
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j06FN-00069y-Rl
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j06FM-0005Bx-La
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:12:49 -0500
Received: from relay.sw.ru ([185.231.240.75]:39030)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j06FJ-00057A-Lj; Fri, 07 Feb 2020 11:12:45 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j06F9-0006NQ-QL; Fri, 07 Feb 2020 19:12:36 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3] block/backup-top: fix flags handling
Date: Fri,  7 Feb 2020 19:12:31 +0300
Message-Id: <20200207161231.32707-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
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
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

backup-top "supports" write-unchanged, by skipping CBW operation in
backup_top_co_pwritev. But it forgets to do the same in
backup_top_co_pwrite_zeroes, as well as declare support for
BDRV_REQ_WRITE_UNCHANGED.

Fix this, and, while being here, declare also support for flags
supported by source child.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

v3: rebase on master, keep state initialization after check top != NULL.

v2: restrict flags propagation like it is done in other filters [Eric]
    move state variable initialization to the top
 block/backup-top.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/block/backup-top.c b/block/backup-top.c
index fa78f3256d..1bfb360bd3 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -48,11 +48,17 @@ static coroutine_fn int backup_top_co_preadv(
 }
 
 static coroutine_fn int backup_top_cbw(BlockDriverState *bs, uint64_t offset,
-                                       uint64_t bytes)
+                                       uint64_t bytes, BdrvRequestFlags flags)
 {
     BDRVBackupTopState *s = bs->opaque;
-    uint64_t end = QEMU_ALIGN_UP(offset + bytes, s->bcs->cluster_size);
-    uint64_t off = QEMU_ALIGN_DOWN(offset, s->bcs->cluster_size);
+    uint64_t off, end;
+
+    if (flags & BDRV_REQ_WRITE_UNCHANGED) {
+        return 0;
+    }
+
+    off = QEMU_ALIGN_DOWN(offset, s->bcs->cluster_size);
+    end = QEMU_ALIGN_UP(offset + bytes, s->bcs->cluster_size);
 
     return block_copy(s->bcs, off, end - off, NULL);
 }
@@ -60,7 +66,7 @@ static coroutine_fn int backup_top_cbw(BlockDriverState *bs, uint64_t offset,
 static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
                                                int64_t offset, int bytes)
 {
-    int ret = backup_top_cbw(bs, offset, bytes);
+    int ret = backup_top_cbw(bs, offset, bytes, 0);
     if (ret < 0) {
         return ret;
     }
@@ -71,7 +77,7 @@ static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
 static int coroutine_fn backup_top_co_pwrite_zeroes(BlockDriverState *bs,
         int64_t offset, int bytes, BdrvRequestFlags flags)
 {
-    int ret = backup_top_cbw(bs, offset, bytes);
+    int ret = backup_top_cbw(bs, offset, bytes, flags);
     if (ret < 0) {
         return ret;
     }
@@ -84,11 +90,9 @@ static coroutine_fn int backup_top_co_pwritev(BlockDriverState *bs,
                                               uint64_t bytes,
                                               QEMUIOVector *qiov, int flags)
 {
-    if (!(flags & BDRV_REQ_WRITE_UNCHANGED)) {
-        int ret = backup_top_cbw(bs, offset, bytes);
-        if (ret < 0) {
-            return ret;
-        }
+    int ret = backup_top_cbw(bs, offset, bytes, flags);
+    if (ret < 0) {
+        return ret;
     }
 
     return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
@@ -196,8 +200,13 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
         return NULL;
     }
 
-    top->total_sectors = source->total_sectors;
     state = top->opaque;
+    top->total_sectors = source->total_sectors;
+    top->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED |
+            (BDRV_REQ_FUA & source->supported_write_flags);
+    top->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED |
+            ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
+             source->supported_zero_flags);
 
     bdrv_ref(target);
     state->target = bdrv_attach_child(top, target, "target", &child_file, errp);
-- 
2.21.0


