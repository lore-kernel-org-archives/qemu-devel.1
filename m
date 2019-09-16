Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19264C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7782171F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7782171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sMk-0005sy-M2
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9rqa-0007CW-Ex
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9rqZ-0007ur-0m
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:19:20 -0400
Received: from relay.sw.ru ([185.231.240.75]:58094)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9rqV-0007sf-Bk; Mon, 16 Sep 2019 10:19:15 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9rqS-0003EA-U7; Mon, 16 Sep 2019 17:19:13 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Mon, 16 Sep 2019 17:19:11 +0300
Message-Id: <20190916141911.5255-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916141911.5255-1-vsementsov@virtuozzo.com>
References: <20190916141911.5255-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 4/4] block/dirty-bitmap: refactor
 bdrv_dirty_bitmap_next
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com, jsnow@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_dirty_bitmap_next is always used in same pattern. So, split it
into _next and _first, instead of combining two functions into one and
add FOR_EACH_DIRTY_BITMAP macro.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/dirty-bitmap.h   |  9 +++++++--
 block.c                        |  4 +---
 block/dirty-bitmap.c           | 11 +++++++----
 block/qcow2-bitmap.c           |  8 ++------
 migration/block-dirty-bitmap.c |  4 +---
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 4c58d922e4..89e52db7ec 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -97,8 +97,13 @@ bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_get_persistence(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_inconsistent(const BdrvDirtyBitmap *bitmap);
 bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
-BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
-                                        BdrvDirtyBitmap *bitmap);
+
+BdrvDirtyBitmap *bdrv_dirty_bitmap_first(BlockDriverState *bs);
+BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BdrvDirtyBitmap *bitmap);
+#define FOR_EACH_DIRTY_BITMAP(bs, bitmap) \
+for (bitmap = bdrv_dirty_bitmap_first(bs); bitmap; \
+     bitmap = bdrv_dirty_bitmap_next(bitmap))
+
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
 int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset,
                                     uint64_t bytes);
diff --git a/block.c b/block.c
index 5944124845..96c2c5ae2d 100644
--- a/block.c
+++ b/block.c
@@ -5363,9 +5363,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
         }
     }
 
-    for (bm = bdrv_dirty_bitmap_next(bs, NULL); bm;
-         bm = bdrv_dirty_bitmap_next(bs, bm))
-    {
+    FOR_EACH_DIRTY_BITMAP(bs, bm) {
         bdrv_dirty_bitmap_skip_store(bm, false);
     }
 
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 76a8e59e61..e2df82af01 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -742,11 +742,14 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)
     return false;
 }
 
-BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
-                                        BdrvDirtyBitmap *bitmap)
+BdrvDirtyBitmap *bdrv_dirty_bitmap_first(BlockDriverState *bs)
 {
-    return bitmap == NULL ? QLIST_FIRST(&bs->dirty_bitmaps) :
-                            QLIST_NEXT(bitmap, list);
+    return QLIST_FIRST(&bs->dirty_bitmaps);
+}
+
+BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BdrvDirtyBitmap *bitmap)
+{
+    return QLIST_NEXT(bitmap, list);
 }
 
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp)
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 6d795a2255..73ebd2ff6a 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1480,9 +1480,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
     }
 
     /* check constraints and names */
-    for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap != NULL;
-         bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
-    {
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
         const char *name = bdrv_dirty_bitmap_name(bitmap);
         uint32_t granularity = bdrv_dirty_bitmap_granularity(bitmap);
         Qcow2Bitmap *bm;
@@ -1602,9 +1600,7 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
         return -EINVAL;
     }
 
-    for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap != NULL;
-         bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
-    {
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
         if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
             bdrv_dirty_bitmap_set_readonly(bitmap, true);
         }
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 793f249aa5..7eafface61 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -283,9 +283,7 @@ static int init_dirty_bitmap_migration(void)
     for (bs = bdrv_next_all_states(NULL); bs; bs = bdrv_next_all_states(bs)) {
         const char *name = bdrv_get_device_or_node_name(bs);
 
-        for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap;
-             bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
-        {
+        FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
             if (!bdrv_dirty_bitmap_name(bitmap)) {
                 continue;
             }
-- 
2.21.0


