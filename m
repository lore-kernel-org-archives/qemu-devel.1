Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41928C4CEC9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B47B2080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B47B2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBEGf-0001lS-Ui
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 04:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBEEj-0008Gn-2w
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBEEg-0005Pw-VQ
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:25:52 -0400
Received: from relay.sw.ru ([185.231.240.75]:60534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBEEc-0005Ne-PU; Fri, 20 Sep 2019 04:25:46 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBEEZ-0004DS-QJ; Fri, 20 Sep 2019 11:25:43 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 3/3] block/qcow2: proper locking on bitmap add/remove paths
Date: Fri, 20 Sep 2019 11:25:43 +0300
Message-Id: <20190920082543.23444-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920082543.23444-1-vsementsov@virtuozzo.com>
References: <20190920082543.23444-1-vsementsov@virtuozzo.com>
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qmp_block_dirty_bitmap_add and do_block_dirty_bitmap_remove do acquire
aio context since 0a6c86d024c52b. But this is not enough: we also must
lock qcow2 mutex when access in-image metadata. Especially it concerns
freeing qcow2 clusters.

To achieve this, move qcow2_can_store_new_dirty_bitmap and
qcow2_remove_persistent_dirty_bitmap to coroutine context.

Since we work in coroutines in correct aio context, we don't need
context acquiring in blockdev.c anymore, drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.h             |  11 ++--
 include/block/block_int.h |  10 ++--
 block/dirty-bitmap.c      | 102 +++++++++++++++++++++++++++++++++++---
 block/qcow2-bitmap.c      |  24 ++++++---
 block/qcow2.c             |   5 +-
 blockdev.c                |  27 +++-------
 6 files changed, 131 insertions(+), 48 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 2ed5482163..113d99bf52 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -743,12 +743,13 @@ int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
-bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
-                                      const char *name,
-                                      uint32_t granularity,
-                                      Error **errp);
-int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
+bool qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
+                                         const char *name,
+                                         uint32_t granularity,
                                          Error **errp);
+int qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
+                                            const char *name,
+                                            Error **errp);
 
 ssize_t coroutine_fn
 qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 503ac9e3cd..1e54486ad1 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -552,13 +552,13 @@ struct BlockDriver {
      * field of BlockDirtyBitmap's in case of success.
      */
     int (*bdrv_reopen_bitmaps_rw)(BlockDriverState *bs, Error **errp);
-    bool (*bdrv_can_store_new_dirty_bitmap)(BlockDriverState *bs,
-                                            const char *name,
-                                            uint32_t granularity,
-                                            Error **errp);
-    int (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
+    bool (*bdrv_co_can_store_new_dirty_bitmap)(BlockDriverState *bs,
                                                const char *name,
+                                               uint32_t granularity,
                                                Error **errp);
+    int (*bdrv_co_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
+                                                  const char *name,
+                                                  Error **errp);
 
     /**
      * Register/unregister a buffer for I/O. For example, when the driver is
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index d1ae2e1922..03e0872b97 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -26,6 +26,7 @@
 #include "trace.h"
 #include "block/block_int.h"
 #include "block/blockjob.h"
+#include "qemu/main-loop.h"
 
 struct BdrvDirtyBitmap {
     QemuMutex *mutex;
@@ -455,18 +456,59 @@ void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
  * not fail.
  * This function doesn't release corresponding BdrvDirtyBitmap.
  */
-int bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
-                                        Error **errp)
+static int coroutine_fn
+bdrv_co_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                       Error **errp)
 {
-    if (bs->drv && bs->drv->bdrv_remove_persistent_dirty_bitmap) {
-        return bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, name, errp);
+    if (bs->drv && bs->drv->bdrv_co_remove_persistent_dirty_bitmap) {
+        return bs->drv->bdrv_co_remove_persistent_dirty_bitmap(bs, name, errp);
     }
 
     return 0;
 }
 
-bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
-                                     uint32_t granularity, Error **errp)
+typedef struct BdrvRemovePersistentDirtyBitmapCo {
+    BlockDriverState *bs;
+    const char *name;
+    Error **errp;
+    int ret;
+} BdrvRemovePersistentDirtyBitmapCo;
+
+static void coroutine_fn
+bdrv_co_remove_persistent_dirty_bitmap_entry(void *opaque)
+{
+    BdrvRemovePersistentDirtyBitmapCo *s = opaque;
+
+    s->ret = bdrv_co_remove_persistent_dirty_bitmap(s->bs, s->name, s->errp);
+    aio_wait_kick();
+}
+
+int bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                        Error **errp)
+{
+    if (qemu_in_coroutine()) {
+        return bdrv_co_remove_persistent_dirty_bitmap(bs, name, errp);
+    } else {
+        Coroutine *co;
+        BdrvRemovePersistentDirtyBitmapCo s = {
+            .bs = bs,
+            .name = name,
+            .errp = errp,
+            .ret = -EINPROGRESS,
+        };
+
+        co = qemu_coroutine_create(bdrv_co_remove_persistent_dirty_bitmap_entry,
+                                   &s);
+        bdrv_coroutine_enter(bs, co);
+        BDRV_POLL_WHILE(bs, s.ret == -EINPROGRESS);
+
+        return s.ret;
+    }
+}
+
+static bool coroutine_fn
+bdrv_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                   uint32_t granularity, Error **errp)
 {
     BlockDriver *drv = bs->drv;
 
@@ -477,14 +519,58 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
         return false;
     }
 
-    if (!drv->bdrv_can_store_new_dirty_bitmap) {
+    if (!drv->bdrv_co_can_store_new_dirty_bitmap) {
         error_setg_errno(errp, ENOTSUP,
                          "Can't store persistent bitmaps to %s",
                          bdrv_get_device_or_node_name(bs));
         return false;
     }
 
-    return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp);
+    return drv->bdrv_co_can_store_new_dirty_bitmap(bs, name, granularity, errp);
+}
+
+typedef struct BdrvCanStoreNewDirtyBitmapCo {
+    BlockDriverState *bs;
+    const char *name;
+    uint32_t granularity;
+    Error **errp;
+    bool ret;
+
+    bool in_progress;
+} BdrvCanStoreNewDirtyBitmapCo;
+
+static void coroutine_fn bdrv_co_can_store_new_dirty_bitmap_entry(void *opaque)
+{
+    BdrvCanStoreNewDirtyBitmapCo *s = opaque;
+
+    s->ret = bdrv_co_can_store_new_dirty_bitmap(s->bs, s->name, s->granularity,
+                                                s->errp);
+    s->in_progress = false;
+    aio_wait_kick();
+}
+
+bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                     uint32_t granularity, Error **errp)
+{
+    if (qemu_in_coroutine()) {
+        return bdrv_co_can_store_new_dirty_bitmap(bs, name, granularity, errp);
+    } else {
+        Coroutine *co;
+        BdrvCanStoreNewDirtyBitmapCo s = {
+            .bs = bs,
+            .name = name,
+            .granularity = granularity,
+            .errp = errp,
+            .in_progress = true,
+        };
+
+        co = qemu_coroutine_create(bdrv_co_can_store_new_dirty_bitmap_entry,
+                                   &s);
+        bdrv_coroutine_enter(bs, co);
+        BDRV_POLL_WHILE(bs, s.in_progress);
+
+        return s.ret;
+    }
 }
 
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 9821c1628f..644837eb03 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1404,12 +1404,13 @@ static Qcow2Bitmap *find_bitmap_by_name(Qcow2BitmapList *bm_list,
     return NULL;
 }
 
-int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
-                                         Error **errp)
+int coroutine_fn qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
+                                                         const char *name,
+                                                         Error **errp)
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
-    Qcow2Bitmap *bm;
+    Qcow2Bitmap *bm = NULL;
     Qcow2BitmapList *bm_list;
 
     if (s->nb_bitmaps == 0) {
@@ -1418,10 +1419,13 @@ int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
         return 0;
     }
 
+    qemu_co_mutex_lock(&s->lock);
+
     bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
                                s->bitmap_directory_size, errp);
     if (bm_list == NULL) {
-        return -EIO;
+        ret = -EIO;
+        goto out;
     }
 
     bm = find_bitmap_by_name(bm_list, name);
@@ -1441,6 +1445,8 @@ int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char *name,
     free_bitmap_clusters(bs, &bm->table);
 
 out:
+    qemu_co_mutex_unlock(&s->lock);
+
     bitmap_free(bm);
     bitmap_list_free(bm_list);
 
@@ -1615,10 +1621,10 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
     return 0;
 }
 
-bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
-                                      const char *name,
-                                      uint32_t granularity,
-                                      Error **errp)
+bool coroutine_fn qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
+                                                      const char *name,
+                                                      uint32_t granularity,
+                                                      Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     bool found;
@@ -1655,8 +1661,10 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
         goto fail;
     }
 
+    qemu_co_mutex_lock(&s->lock);
     bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
                                s->bitmap_directory_size, errp);
+    qemu_co_mutex_unlock(&s->lock);
     if (bm_list == NULL) {
         goto fail;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 4d16393e61..43a6cc423d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5263,8 +5263,9 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_attach_aio_context  = qcow2_attach_aio_context,
 
     .bdrv_reopen_bitmaps_rw = qcow2_reopen_bitmaps_rw,
-    .bdrv_can_store_new_dirty_bitmap = qcow2_can_store_new_dirty_bitmap,
-    .bdrv_remove_persistent_dirty_bitmap = qcow2_remove_persistent_dirty_bitmap,
+    .bdrv_co_can_store_new_dirty_bitmap = qcow2_co_can_store_new_dirty_bitmap,
+    .bdrv_co_remove_persistent_dirty_bitmap =
+            qcow2_co_remove_persistent_dirty_bitmap,
 };
 
 static void bdrv_qcow2_init(void)
diff --git a/blockdev.c b/blockdev.c
index 0813adfb2b..228ce94a88 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2898,16 +2898,10 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
         disabled = false;
     }
 
-    if (persistent) {
-        AioContext *aio_context = bdrv_get_aio_context(bs);
-        bool ok;
-
-        aio_context_acquire(aio_context);
-        ok = bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp);
-        aio_context_release(aio_context);
-        if (!ok) {
-            return;
-        }
+    if (persistent &&
+        !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
+    {
+        return;
     }
 
     bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
@@ -2939,17 +2933,10 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_remove(
         return NULL;
     }
 
-    if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
-        int ret;
-        AioContext *aio_context = bdrv_get_aio_context(bs);
-
-        aio_context_acquire(aio_context);
-        ret = bdrv_remove_persistent_dirty_bitmap(bs, name, errp);
-        aio_context_release(aio_context);
-
-        if (ret < 0) {
+    if (bdrv_dirty_bitmap_get_persistence(bitmap) &&
+        bdrv_remove_persistent_dirty_bitmap(bs, name, errp) < 0)
+    {
             return NULL;
-        }
     }
 
     if (release) {
-- 
2.21.0


