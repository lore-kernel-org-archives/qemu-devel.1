Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77CEC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998C3206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998C3206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sBd-0004BA-T9
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9rqb-0007E0-Jj
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9rqZ-0007v9-Lg
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:19:21 -0400
Received: from relay.sw.ru ([185.231.240.75]:58096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9rqV-0007sh-Bc; Mon, 16 Sep 2019 10:19:15 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9rqS-0003EA-PU; Mon, 16 Sep 2019 17:19:12 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Mon, 16 Sep 2019 17:19:10 +0300
Message-Id: <20190916141911.5255-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916141911.5255-1-vsementsov@virtuozzo.com>
References: <20190916141911.5255-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 3/4] block/dirty-bitmap: drop
 BdrvDirtyBitmap.mutex
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

mutex field is just a pointer to bs->dirty_bitmap_mutex, so no needs
to store it in BdrvDirtyBitmap when we have bs pointer in it (since
previous patch).

Drop mutex field. Constantly use bdrv_dirty_bitmaps_lock/unlock in
block/dirty-bitmap.c to make it more obvious that it's not per-bitmap
lock. Still, for simplicity, leave bdrv_dirty_bitmap_lock/unlock
functions as an external API.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/dirty-bitmap.c | 84 +++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index f3dc7b3ca5..76a8e59e61 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -28,7 +28,6 @@
 #include "block/blockjob.h"
 
 struct BdrvDirtyBitmap {
-    QemuMutex *mutex;
     BlockDriverState *bs;
     HBitmap *bitmap;            /* Dirty bitmap implementation */
     bool busy;                  /* Bitmap is busy, it can't be used via QMP */
@@ -71,12 +70,12 @@ static inline void bdrv_dirty_bitmaps_unlock(BlockDriverState *bs)
 
 void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap)
 {
-    qemu_mutex_lock(bitmap->mutex);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
 }
 
 void bdrv_dirty_bitmap_unlock(BdrvDirtyBitmap *bitmap)
 {
-    qemu_mutex_unlock(bitmap->mutex);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
 
 /* Called with BQL or dirty_bitmap lock taken.  */
@@ -116,7 +115,6 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
     }
     bitmap = g_new0(BdrvDirtyBitmap, 1);
     bitmap->bs = bs;
-    bitmap->mutex = &bs->dirty_bitmap_mutex;
     bitmap->bitmap = hbitmap_alloc(bitmap_size, ctz32(granularity));
     bitmap->size = bitmap_size;
     bitmap->name = g_strdup(name);
@@ -150,9 +148,9 @@ static bool bdrv_dirty_bitmap_busy(const BdrvDirtyBitmap *bitmap)
 
 void bdrv_dirty_bitmap_set_busy(BdrvDirtyBitmap *bitmap, bool busy)
 {
-    qemu_mutex_lock(bitmap->mutex);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bitmap->busy = busy;
-    qemu_mutex_unlock(bitmap->mutex);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
 
 /* Called with BQL taken.  */
@@ -277,10 +275,10 @@ void bdrv_enable_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap)
 /* Called with BQL taken. */
 void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap)
 {
-    assert(bitmap->mutex == bitmap->successor->mutex);
-    qemu_mutex_lock(bitmap->mutex);
+    assert(bitmap->bs == bitmap->successor->bs);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bdrv_enable_dirty_bitmap_locked(bitmap->successor);
-    qemu_mutex_unlock(bitmap->mutex);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
 
 /* Called within bdrv_dirty_bitmap_lock..unlock and with BQL taken.  */
@@ -360,9 +358,9 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BdrvDirtyBitmap *parent,
 {
     BdrvDirtyBitmap *ret;
 
-    qemu_mutex_lock(parent->mutex);
+    bdrv_dirty_bitmaps_lock(parent->bs);
     ret = bdrv_reclaim_dirty_bitmap_locked(parent, errp);
-    qemu_mutex_unlock(parent->mutex);
+    bdrv_dirty_bitmaps_unlock(parent->bs);
 
     return ret;
 }
@@ -434,16 +432,16 @@ void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
 
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
-    bdrv_dirty_bitmap_lock(bitmap);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bitmap->disabled = true;
-    bdrv_dirty_bitmap_unlock(bitmap);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
 
 void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
-    bdrv_dirty_bitmap_lock(bitmap);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bdrv_enable_dirty_bitmap_locked(bitmap);
-    bdrv_dirty_bitmap_unlock(bitmap);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
 
 BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
@@ -484,9 +482,9 @@ bool bdrv_dirty_bitmap_get_locked(BdrvDirtyBitmap *bitmap, int64_t offset)
 bool bdrv_dirty_bitmap_get(BdrvDirtyBitmap *bitmap, int64_t offset)
 {
     bool ret;
-    bdrv_dirty_bitmap_lock(bitmap);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     ret = bdrv_dirty_bitmap_get_locked(bitmap, offset);
-    bdrv_dirty_bitmap_unlock(bitmap);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 
     return ret;
 }
@@ -551,9 +549,9 @@ void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
 void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                            int64_t offset, int64_t bytes)
 {
-    bdrv_dirty_bitmap_lock(bitmap);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bdrv_set_dirty_bitmap_locked(bitmap, offset, bytes);
-    bdrv_dirty_bitmap_unlock(bitmap);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
 
 /* Called within bdrv_dirty_bitmap_lock..unlock */
@@ -567,15 +565,15 @@ void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
 void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                              int64_t offset, int64_t bytes)
 {
-    bdrv_dirty_bitmap_lock(bitmap);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bdrv_reset_dirty_bitmap_locked(bitmap, offset, bytes);
-    bdrv_dirty_bitmap_unlock(bitmap);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
 
 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
 {
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
-    bdrv_dirty_bitmap_lock(bitmap);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     if (!out) {
         hbitmap_reset_all(bitmap->bitmap);
     } else {
@@ -584,7 +582,7 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
                                        hbitmap_granularity(backup));
         *out = backup;
     }
-    bdrv_dirty_bitmap_unlock(bitmap);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
 
 void bdrv_restore_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *backup)
@@ -679,9 +677,9 @@ bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap)
 /* Called with BQL taken. */
 void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value)
 {
-    qemu_mutex_lock(bitmap->mutex);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bitmap->readonly = value;
-    qemu_mutex_unlock(bitmap->mutex);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
 
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
@@ -699,27 +697,27 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
 /* Called with BQL taken. */
 void bdrv_dirty_bitmap_set_persistence(BdrvDirtyBitmap *bitmap, bool persistent)
 {
-    qemu_mutex_lock(bitmap->mutex);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bitmap->persistent = persistent;
-    qemu_mutex_unlock(bitmap->mutex);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
 
 /* Called with BQL taken. */
 void bdrv_dirty_bitmap_set_inconsistent(BdrvDirtyBitmap *bitmap)
 {
-    qemu_mutex_lock(bitmap->mutex);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     assert(bitmap->persistent == true);
     bitmap->inconsistent = true;
     bitmap->disabled = true;
-    qemu_mutex_unlock(bitmap->mutex);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
 
 /* Called with BQL taken. */
 void bdrv_dirty_bitmap_skip_store(BdrvDirtyBitmap *bitmap, bool skip)
 {
-    qemu_mutex_lock(bitmap->mutex);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bitmap->skip_store = skip;
-    qemu_mutex_unlock(bitmap->mutex);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
 
 bool bdrv_dirty_bitmap_get_persistence(BdrvDirtyBitmap *bitmap)
@@ -779,9 +777,9 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
 {
     bool ret;
 
-    qemu_mutex_lock(dest->mutex);
-    if (src->mutex != dest->mutex) {
-        qemu_mutex_lock(src->mutex);
+    bdrv_dirty_bitmaps_lock(dest->bs);
+    if (src->bs != dest->bs) {
+        bdrv_dirty_bitmaps_lock(src->bs);
     }
 
     if (bdrv_dirty_bitmap_check(dest, BDRV_BITMAP_DEFAULT, errp)) {
@@ -801,9 +799,9 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
     assert(ret);
 
 out:
-    qemu_mutex_unlock(dest->mutex);
-    if (src->mutex != dest->mutex) {
-        qemu_mutex_unlock(src->mutex);
+    bdrv_dirty_bitmaps_unlock(dest->bs);
+    if (src->bs != dest->bs) {
+        bdrv_dirty_bitmaps_unlock(src->bs);
     }
 }
 
@@ -827,9 +825,9 @@ bool bdrv_dirty_bitmap_merge_internal(BdrvDirtyBitmap *dest,
     assert(!bdrv_dirty_bitmap_inconsistent(src));
 
     if (lock) {
-        qemu_mutex_lock(dest->mutex);
-        if (src->mutex != dest->mutex) {
-            qemu_mutex_lock(src->mutex);
+        bdrv_dirty_bitmaps_lock(dest->bs);
+        if (src->bs != dest->bs) {
+            bdrv_dirty_bitmaps_lock(src->bs);
         }
     }
 
@@ -842,9 +840,9 @@ bool bdrv_dirty_bitmap_merge_internal(BdrvDirtyBitmap *dest,
     }
 
     if (lock) {
-        qemu_mutex_unlock(dest->mutex);
-        if (src->mutex != dest->mutex) {
-            qemu_mutex_unlock(src->mutex);
+        bdrv_dirty_bitmaps_unlock(dest->bs);
+        if (src->bs != dest->bs) {
+            bdrv_dirty_bitmaps_unlock(src->bs);
         }
     }
 
-- 
2.21.0


