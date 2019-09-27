Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6203C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B503207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B503207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDrGr-0006VB-OA
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDqCd-0003PT-2y
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDqCb-0000Ja-Jv
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:22:30 -0400
Received: from relay.sw.ru ([185.231.240.75]:49752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDqCW-0000IU-PM; Fri, 27 Sep 2019 09:22:24 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDpHy-0003za-SU; Fri, 27 Sep 2019 15:23:58 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 6/9] block/qcow2-bitmap: do not remove bitmaps on reopen-ro
Date: Fri, 27 Sep 2019 15:23:52 +0300
Message-Id: <20190927122355.7344-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927122355.7344-1-vsementsov@virtuozzo.com>
References: <20190927122355.7344-1-vsementsov@virtuozzo.com>
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qcow2_reopen_bitmaps_ro wants to store bitmaps and then mark them all
readonly. But the latter don't work, as
qcow2_store_persistent_dirty_bitmaps removes bitmaps after storing.
It's OK for inactivation but bad idea for reopen-ro. And this leads to
the following bug:

Assume we have persistent bitmap 'bitmap0'.
Create external snapshot
  bitmap0 is stored and therefore removed
Commit snapshot
  now we have no bitmaps
Do some writes from guest (*)
  they are not marked in bitmap
Shutdown
Start
  bitmap0 is loaded as valid, but it is actually broken! It misses
  writes (*)
Incremental backup
  it will be inconsistent

So, let's stop removing bitmaps on reopen-ro. But don't rejoice:
reopening bitmaps to rw is broken too, so the whole scenario will not
work after this patch and we can't enable corresponding test cases in
260 iotests still. Reopening bitmaps rw will be fixed in the following
patches.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.h        |  3 ++-
 block/qcow2-bitmap.c | 49 ++++++++++++++++++++++++++++++--------------
 block/qcow2.c        |  2 +-
 3 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index ee6b367807..d472c1ee0c 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -739,7 +739,8 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
                                                 Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
-void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
+                                          bool release_stored, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
 bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
                                       const char *name,
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index fbeee37243..a636dc50ca 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1432,7 +1432,32 @@ fail:
     bitmap_list_free(bm_list);
 }
 
-void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
+/*
+ * qcow2_store_persistent_dirty_bitmaps
+ *
+ * Stores persistent BdrvDirtyBitmap objects.
+ *
+ * @release_stored: if true, release BdrvDirtyBitmap's after storing to the
+ * image. This is used in two cases, both via qcow2_inactivate:
+ * 1. bdrv_close: It's correct to remove bitmaps on close.
+ * 2. migration: If bitmaps are migrated through migration channel via
+ *    'dirty-bitmaps' migration capability they are not handled by this code.
+ *    Otherwise, it's OK to drop BdrvDirtyBitmap's and reload them on
+ *    invalidation.
+ *
+ * Anyway, it's correct to remove BdrvDirtyBitmap's on inactivation, as
+ * inactivation means that we lose control on disk, and therefore on bitmaps,
+ * we should sync them and do not touch more.
+ *
+ * Contrariwise, we don't want to release any bitmaps on just reopen-to-ro,
+ * when we need to store them, as image is still under our control, and it's
+ * good to keep all the bitmaps in read-only mode. Moreover, keeping them
+ * read-only is correct because this is what would happen if we opened the node
+ * readonly to begin with, and whether we opened directly or reopened to that
+ * state shouldn't matter for the state we get afterward.
+ */
+void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
+                                          bool release_stored, Error **errp)
 {
     BdrvDirtyBitmap *bitmap;
     BDRVQcow2State *s = bs->opaque;
@@ -1545,20 +1570,14 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
         g_free(tb);
     }
 
-    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        /* For safety, we remove bitmap after storing.
-         * We may be here in two cases:
-         * 1. bdrv_close. It's ok to drop bitmap.
-         * 2. inactivation. It means migration without 'dirty-bitmaps'
-         *    capability, so bitmaps are not marked with
-         *    BdrvDirtyBitmap.migration flags. It's not bad to drop them too,
-         *    and reload on invalidation.
-         */
-        if (bm->dirty_bitmap == NULL) {
-            continue;
-        }
+    if (release_stored) {
+        QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+            if (bm->dirty_bitmap == NULL) {
+                continue;
+            }
 
-        bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
+            bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
+        }
     }
 
 success:
@@ -1586,7 +1605,7 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
     BdrvDirtyBitmap *bitmap;
     Error *local_err = NULL;
 
-    qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
+    qcow2_store_persistent_dirty_bitmaps(bs, false, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return -EINVAL;
diff --git a/block/qcow2.c b/block/qcow2.c
index 4d16393e61..a3d672e9b2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2359,7 +2359,7 @@ static int qcow2_inactivate(BlockDriverState *bs)
     int ret, result = 0;
     Error *local_err = NULL;
 
-    qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
+    qcow2_store_persistent_dirty_bitmaps(bs, true, &local_err);
     if (local_err != NULL) {
         result = -EINVAL;
         error_reportf_err(local_err, "Lost persistent bitmaps during "
-- 
2.21.0


