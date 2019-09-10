Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973D4C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E61208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E61208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7j4d-00014T-Ei
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7izM-0004rz-BV
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7izL-0003Ue-0K
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:27:32 -0400
Received: from relay.sw.ru ([185.231.240.75]:44314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7izH-0003Q7-Bd; Tue, 10 Sep 2019 12:27:27 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7izE-0001NT-D4; Tue, 10 Sep 2019 19:27:24 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 19:27:23 +0300
Message-Id: <20190910162724.79574-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190910162724.79574-1-vsementsov@virtuozzo.com>
References: <20190910162724.79574-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 2/3] block/dirty-bitmap: return int from
 bdrv_remove_persistent_dirty_bitmap
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
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's more comfortable to not deal with local_err.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h                |  5 ++---
 include/block/block_int.h    |  6 +++---
 include/block/dirty-bitmap.h |  5 ++---
 block/dirty-bitmap.c         |  9 +++++----
 block/qcow2-bitmap.c         | 20 +++++++++++---------
 blockdev.c                   |  7 +++----
 6 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 998bcdaef1..99ee88f802 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -747,9 +747,8 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
                                       const char *name,
                                       uint32_t granularity,
                                       Error **errp);
-void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
-                                          const char *name,
-                                          Error **errp);
+int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                         Error **errp);
 
 ssize_t coroutine_fn
 qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 0422acdf1c..503ac9e3cd 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -556,9 +556,9 @@ struct BlockDriver {
                                             const char *name,
                                             uint32_t granularity,
                                             Error **errp);
-    void (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
-                                                const char *name,
-                                                Error **errp);
+    int (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
+                                               const char *name,
+                                               Error **errp);
 
     /**
      * Register/unregister a buffer for I/O. For example, when the driver is
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 4b4b731b46..07503b03b5 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -37,9 +37,8 @@ int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *bitmap, uint32_t flags,
                             Error **errp);
 void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap);
 void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
-void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
-                                         const char *name,
-                                         Error **errp);
+int bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                        Error **errp);
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 void bdrv_enable_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 8f42015db9..a52b83b619 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -455,13 +455,14 @@ void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
  * not fail.
  * This function doesn't release corresponding BdrvDirtyBitmap.
  */
-void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
-                                         const char *name,
-                                         Error **errp)
+int bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                        Error **errp)
 {
     if (bs->drv && bs->drv->bdrv_remove_persistent_dirty_bitmap) {
-        bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, name, errp);
+        return bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, name, errp);
     }
+
+    return -ENOTSUP;
 }
 
 bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index b2487101ed..1aaedb3b55 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1404,11 +1404,10 @@ static Qcow2Bitmap *find_bitmap_by_name(Qcow2BitmapList *bm_list,
     return NULL;
 }
 
-void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
-                                          const char *name,
-                                          Error **errp)
+int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                         Error **errp)
 {
-    int ret;
+    int ret = 0;
     BDRVQcow2State *s = bs->opaque;
     Qcow2Bitmap *bm;
     Qcow2BitmapList *bm_list;
@@ -1416,18 +1415,19 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
     if (s->nb_bitmaps == 0) {
         /* Absence of the bitmap is not an error: see explanation above
          * bdrv_remove_persistent_dirty_bitmap() definition. */
-        return;
+        return 0;
     }
 
     bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
                                s->bitmap_directory_size, errp);
     if (bm_list == NULL) {
-        return;
+        return -EIO;
     }
 
     bm = find_bitmap_by_name(bm_list, name);
     if (bm == NULL) {
-        goto fail;
+        ret = -EINVAL;
+        goto out;
     }
 
     QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
@@ -1435,14 +1435,16 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
     ret = update_ext_header_and_dir(bs, bm_list);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to update bitmap extension");
-        goto fail;
+        goto out;
     }
 
     free_bitmap_clusters(bs, &bm->table);
 
-fail:
+out:
     bitmap_free(bm);
     bitmap_list_free(bm_list);
+
+    return ret;
 }
 
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
diff --git a/blockdev.c b/blockdev.c
index fbef6845c8..0813adfb2b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2940,15 +2940,14 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_remove(
     }
 
     if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
+        int ret;
         AioContext *aio_context = bdrv_get_aio_context(bs);
-        Error *local_err = NULL;
 
         aio_context_acquire(aio_context);
-        bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
+        ret = bdrv_remove_persistent_dirty_bitmap(bs, name, errp);
         aio_context_release(aio_context);
 
-        if (local_err != NULL) {
-            error_propagate(errp, local_err);
+        if (ret < 0) {
             return NULL;
         }
     }
-- 
2.18.0


