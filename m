Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF92ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A111F21D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A111F21D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLDoe-00043K-1H
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 18:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iLDjY-0006v9-NZ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iLDjW-0002Jm-T9
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:55:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23895)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iLDjS-0002HK-LL; Thu, 17 Oct 2019 17:54:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D3A4918C426B;
 Thu, 17 Oct 2019 21:54:53 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-173.bos.redhat.com [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AD735D9DC;
 Thu, 17 Oct 2019 21:54:52 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, jsnow@redhat.com,
 qemu-devel@nongnu.org
Subject: [PULL v3 04/19] block/qcow2: proper locking on bitmap add/remove paths
Date: Thu, 17 Oct 2019 17:54:21 -0400
Message-Id: <20191017215436.14252-5-jsnow@redhat.com>
In-Reply-To: <20191017215436.14252-1-jsnow@redhat.com>
References: <20191017215436.14252-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Thu, 17 Oct 2019 21:54:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

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
Message-id: 20190920082543.23444-4-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.h             |  11 ++--
 include/block/block_int.h |  10 ++--
 block/dirty-bitmap.c      | 102 +++++++++++++++++++++++++++++++++++---
 block/qcow2-bitmap.c      |  24 ++++++---
 block/qcow2.c             |   5 +-
 blockdev.c                |  27 +++-------
 6 files changed, 131 insertions(+), 48 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 08b4c15dc4..0f3d9b088e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -746,12 +746,13 @@ int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, E=
rror **errp);
 int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **=
errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
-bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
-                                      const char *name,
-                                      uint32_t granularity,
-                                      Error **errp);
-int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs, const cha=
r *name,
+bool qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
+                                         const char *name,
+                                         uint32_t granularity,
                                          Error **errp);
+int qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
+                                            const char *name,
+                                            Error **errp);
=20
 ssize_t coroutine_fn
 qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 6b511dd889..32fb493cbb 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -553,13 +553,13 @@ struct BlockDriver {
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
=20
     /**
      * Register/unregister a buffer for I/O. For example, when the drive=
r is
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index d1ae2e1922..03e0872b97 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -26,6 +26,7 @@
 #include "trace.h"
 #include "block/block_int.h"
 #include "block/blockjob.h"
+#include "qemu/main-loop.h"
=20
 struct BdrvDirtyBitmap {
     QemuMutex *mutex;
@@ -455,18 +456,59 @@ void bdrv_release_named_dirty_bitmaps(BlockDriverSt=
ate *bs)
  * not fail.
  * This function doesn't release corresponding BdrvDirtyBitmap.
  */
+static int coroutine_fn
+bdrv_co_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char =
*name,
+                                       Error **errp)
+{
+    if (bs->drv && bs->drv->bdrv_co_remove_persistent_dirty_bitmap) {
+        return bs->drv->bdrv_co_remove_persistent_dirty_bitmap(bs, name,=
 errp);
+    }
+
+    return 0;
+}
+
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
+    BdrvRemovePersistentDirtyBitmapCo *s =3D opaque;
+
+    s->ret =3D bdrv_co_remove_persistent_dirty_bitmap(s->bs, s->name, s-=
>errp);
+    aio_wait_kick();
+}
+
 int bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char=
 *name,
                                         Error **errp)
 {
-    if (bs->drv && bs->drv->bdrv_remove_persistent_dirty_bitmap) {
-        return bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, name, er=
rp);
+    if (qemu_in_coroutine()) {
+        return bdrv_co_remove_persistent_dirty_bitmap(bs, name, errp);
+    } else {
+        Coroutine *co;
+        BdrvRemovePersistentDirtyBitmapCo s =3D {
+            .bs =3D bs,
+            .name =3D name,
+            .errp =3D errp,
+            .ret =3D -EINPROGRESS,
+        };
+
+        co =3D qemu_coroutine_create(bdrv_co_remove_persistent_dirty_bit=
map_entry,
+                                   &s);
+        bdrv_coroutine_enter(bs, co);
+        BDRV_POLL_WHILE(bs, s.ret =3D=3D -EINPROGRESS);
+
+        return s.ret;
     }
-
-    return 0;
 }
=20
-bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *n=
ame,
-                                     uint32_t granularity, Error **errp)
+static bool coroutine_fn
+bdrv_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *nam=
e,
+                                   uint32_t granularity, Error **errp)
 {
     BlockDriver *drv =3D bs->drv;
=20
@@ -477,14 +519,58 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverSta=
te *bs, const char *name,
         return false;
     }
=20
-    if (!drv->bdrv_can_store_new_dirty_bitmap) {
+    if (!drv->bdrv_co_can_store_new_dirty_bitmap) {
         error_setg_errno(errp, ENOTSUP,
                          "Can't store persistent bitmaps to %s",
                          bdrv_get_device_or_node_name(bs));
         return false;
     }
=20
-    return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, e=
rrp);
+    return drv->bdrv_co_can_store_new_dirty_bitmap(bs, name, granularity=
, errp);
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
+static void coroutine_fn bdrv_co_can_store_new_dirty_bitmap_entry(void *=
opaque)
+{
+    BdrvCanStoreNewDirtyBitmapCo *s =3D opaque;
+
+    s->ret =3D bdrv_co_can_store_new_dirty_bitmap(s->bs, s->name, s->gra=
nularity,
+                                                s->errp);
+    s->in_progress =3D false;
+    aio_wait_kick();
+}
+
+bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *n=
ame,
+                                     uint32_t granularity, Error **errp)
+{
+    if (qemu_in_coroutine()) {
+        return bdrv_co_can_store_new_dirty_bitmap(bs, name, granularity,=
 errp);
+    } else {
+        Coroutine *co;
+        BdrvCanStoreNewDirtyBitmapCo s =3D {
+            .bs =3D bs,
+            .name =3D name,
+            .granularity =3D granularity,
+            .errp =3D errp,
+            .in_progress =3D true,
+        };
+
+        co =3D qemu_coroutine_create(bdrv_co_can_store_new_dirty_bitmap_=
entry,
+                                   &s);
+        bdrv_coroutine_enter(bs, co);
+        BDRV_POLL_WHILE(bs, s.in_progress);
+
+        return s.ret;
+    }
 }
=20
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 9821c1628f..644837eb03 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1404,12 +1404,13 @@ static Qcow2Bitmap *find_bitmap_by_name(Qcow2Bitm=
apList *bm_list,
     return NULL;
 }
=20
-int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs, const cha=
r *name,
-                                         Error **errp)
+int coroutine_fn qcow2_co_remove_persistent_dirty_bitmap(BlockDriverStat=
e *bs,
+                                                         const char *nam=
e,
+                                                         Error **errp)
 {
     int ret;
     BDRVQcow2State *s =3D bs->opaque;
-    Qcow2Bitmap *bm;
+    Qcow2Bitmap *bm =3D NULL;
     Qcow2BitmapList *bm_list;
=20
     if (s->nb_bitmaps =3D=3D 0) {
@@ -1418,10 +1419,13 @@ int qcow2_remove_persistent_dirty_bitmap(BlockDri=
verState *bs, const char *name,
         return 0;
     }
=20
+    qemu_co_mutex_lock(&s->lock);
+
     bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
                                s->bitmap_directory_size, errp);
     if (bm_list =3D=3D NULL) {
-        return -EIO;
+        ret =3D -EIO;
+        goto out;
     }
=20
     bm =3D find_bitmap_by_name(bm_list, name);
@@ -1441,6 +1445,8 @@ int qcow2_remove_persistent_dirty_bitmap(BlockDrive=
rState *bs, const char *name,
     free_bitmap_clusters(bs, &bm->table);
=20
 out:
+    qemu_co_mutex_unlock(&s->lock);
+
     bitmap_free(bm);
     bitmap_list_free(bm_list);
=20
@@ -1615,10 +1621,10 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs,=
 Error **errp)
     return 0;
 }
=20
-bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
-                                      const char *name,
-                                      uint32_t granularity,
-                                      Error **errp)
+bool coroutine_fn qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *=
bs,
+                                                      const char *name,
+                                                      uint32_t granulari=
ty,
+                                                      Error **errp)
 {
     BDRVQcow2State *s =3D bs->opaque;
     bool found;
@@ -1655,8 +1661,10 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverS=
tate *bs,
         goto fail;
     }
=20
+    qemu_co_mutex_lock(&s->lock);
     bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
                                s->bitmap_directory_size, errp);
+    qemu_co_mutex_unlock(&s->lock);
     if (bm_list =3D=3D NULL) {
         goto fail;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 7961c05783..7062eccaee 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5407,8 +5407,9 @@ BlockDriver bdrv_qcow2 =3D {
     .bdrv_attach_aio_context  =3D qcow2_attach_aio_context,
=20
     .bdrv_reopen_bitmaps_rw =3D qcow2_reopen_bitmaps_rw,
-    .bdrv_can_store_new_dirty_bitmap =3D qcow2_can_store_new_dirty_bitma=
p,
-    .bdrv_remove_persistent_dirty_bitmap =3D qcow2_remove_persistent_dir=
ty_bitmap,
+    .bdrv_co_can_store_new_dirty_bitmap =3D qcow2_co_can_store_new_dirty=
_bitmap,
+    .bdrv_co_remove_persistent_dirty_bitmap =3D
+            qcow2_co_remove_persistent_dirty_bitmap,
 };
=20
 static void bdrv_qcow2_init(void)
diff --git a/blockdev.c b/blockdev.c
index a45458a60a..7e12919724 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2898,16 +2898,10 @@ void qmp_block_dirty_bitmap_add(const char *node,=
 const char *name,
         disabled =3D false;
     }
=20
-    if (persistent) {
-        AioContext *aio_context =3D bdrv_get_aio_context(bs);
-        bool ok;
-
-        aio_context_acquire(aio_context);
-        ok =3D bdrv_can_store_new_dirty_bitmap(bs, name, granularity, er=
rp);
-        aio_context_release(aio_context);
-        if (!ok) {
-            return;
-        }
+    if (persistent &&
+        !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
+    {
+        return;
     }
=20
     bitmap =3D bdrv_create_dirty_bitmap(bs, granularity, name, errp);
@@ -2939,17 +2933,10 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_rem=
ove(
         return NULL;
     }
=20
-    if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
-        int ret;
-        AioContext *aio_context =3D bdrv_get_aio_context(bs);
-
-        aio_context_acquire(aio_context);
-        ret =3D bdrv_remove_persistent_dirty_bitmap(bs, name, errp);
-        aio_context_release(aio_context);
-
-        if (ret < 0) {
+    if (bdrv_dirty_bitmap_get_persistence(bitmap) &&
+        bdrv_remove_persistent_dirty_bitmap(bs, name, errp) < 0)
+    {
             return NULL;
-        }
     }
=20
     if (release) {
--=20
2.21.0


