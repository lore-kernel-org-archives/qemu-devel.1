Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BA6C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28305217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28305217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDrYM-00077m-91
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDqD0-0003r8-GP
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDqCw-0000QB-8n
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:22:51 -0400
Received: from relay.sw.ru ([185.231.240.75]:49752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDqCt-0000IU-Hv; Fri, 27 Sep 2019 09:22:47 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDpHy-0003za-8q; Fri, 27 Sep 2019 15:23:58 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 4/9] block/qcow2-bitmap: get rid of
 bdrv_has_changed_persistent_bitmaps
Date: Fri, 27 Sep 2019 15:23:50 +0300
Message-Id: <20190927122355.7344-5-vsementsov@virtuozzo.com>
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

Firstly, no reason to optimize failure path. Then, function name is
ambiguous: it checks for readonly and similar things, but someone may
think that it will ignore normal bitmaps which was just unchanged, and
this is in bad relation with the fact that we should drop IN_USE flag
for unchanged bitmaps in the image.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 include/block/dirty-bitmap.h |  1 -
 block/dirty-bitmap.c         | 12 ------------
 block/qcow2-bitmap.c         | 23 +++++++++++++----------
 3 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 4b4b731b46..6644da3e23 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -104,7 +104,6 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_get_persistence(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_inconsistent(const BdrvDirtyBitmap *bitmap);
-bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap);
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 134e0c9a0c..82cb4f9d8f 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -778,18 +778,6 @@ bool bdrv_dirty_bitmap_inconsistent(const BdrvDirtyBitmap *bitmap)
     return bitmap->inconsistent;
 }
 
-bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)
-{
-    BdrvDirtyBitmap *bm;
-    QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
-        if (bm->persistent && !bm->readonly && !bm->skip_store) {
-            return true;
-        }
-    }
-
-    return false;
-}
-
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap)
 {
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index b2487101ed..60b79f1dac 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1456,16 +1456,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
     Qcow2Bitmap *bm;
     QSIMPLEQ_HEAD(, Qcow2BitmapTable) drop_tables;
     Qcow2BitmapTable *tb, *tb_next;
-
-    if (!bdrv_has_changed_persistent_bitmaps(bs)) {
-        /* nothing to do */
-        return;
-    }
-
-    if (!can_write(bs)) {
-        error_setg(errp, "No write access");
-        return;
-    }
+    bool need_write = false;
 
     QSIMPLEQ_INIT(&drop_tables);
 
@@ -1493,6 +1484,8 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
             continue;
         }
 
+        need_write = true;
+
         if (check_constraints_on_bitmap(bs, name, granularity, errp) < 0) {
             error_prepend(errp, "Bitmap '%s' doesn't satisfy the constraints: ",
                           name);
@@ -1531,6 +1524,15 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
         bm->dirty_bitmap = bitmap;
     }
 
+    if (!need_write) {
+        goto success;
+    }
+
+    if (!can_write(bs)) {
+        error_setg(errp, "No write access");
+        goto fail;
+    }
+
     /* allocate clusters and store bitmaps */
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
         if (bm->dirty_bitmap == NULL) {
@@ -1572,6 +1574,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
         bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
     }
 
+success:
     bitmap_list_free(bm_list);
     return;
 
-- 
2.21.0


