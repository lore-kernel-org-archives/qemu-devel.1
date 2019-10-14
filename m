Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED576ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DD2217F9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DD2217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK68I-0003Fj-IS
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 15:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iK62U-0005xu-9u
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iK62R-0002ix-So
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:29:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iK62N-0002c0-J4; Mon, 14 Oct 2019 15:29:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C6DD68AC6F9;
 Mon, 14 Oct 2019 19:29:46 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-152.bos.redhat.com [10.18.17.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E24360BE2;
 Mon, 14 Oct 2019 19:29:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 06/19] block/dirty-bitmap: add bs link
Date: Mon, 14 Oct 2019 15:28:56 -0400
Message-Id: <20191014192909.16044-7-jsnow@redhat.com>
In-Reply-To: <20191014192909.16044-1-jsnow@redhat.com>
References: <20191014192909.16044-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Mon, 14 Oct 2019 19:29:46 +0000 (UTC)
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
 John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add bs field to BdrvDirtyBitmap structure. Drop BlockDriverState
parameter from bitmap APIs where possible.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20190916141911.5255-3-vsementsov@virtuozzo.com
[Rebased on top of block-copy. --js]
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/block/dirty-bitmap.h   | 14 +++++---------
 block/backup.c                 |  8 ++++----
 block/block-copy.c             |  2 +-
 block/dirty-bitmap.c           | 24 ++++++++++++------------
 block/mirror.c                 |  4 ++--
 block/qcow2-bitmap.c           |  6 +++---
 blockdev.c                     |  6 +++---
 migration/block-dirty-bitmap.c |  7 +++----
 migration/block.c              |  4 ++--
 9 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 973056778a..2f9b088e11 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -18,21 +18,18 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriver=
State *bs,
                                           uint32_t granularity,
                                           const char *name,
                                           Error **errp);
-int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
-                                       BdrvDirtyBitmap *bitmap,
+int bdrv_dirty_bitmap_create_successor(BdrvDirtyBitmap *bitmap,
                                        Error **errp);
-BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
-                                            BdrvDirtyBitmap *bitmap,
+BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BdrvDirtyBitmap *bitmap,
                                             Error **errp);
-BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
-                                           BdrvDirtyBitmap *bitmap,
+BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                                            Error **errp);
 void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap);
 BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
                                         const char *name);
 int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *bitmap, uint32_t flag=
s,
                             Error **errp);
-void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bi=
tmap);
+void bdrv_release_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
 int bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char=
 *name,
                                         Error **errp);
@@ -106,8 +103,7 @@ int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *=
bitmap, uint64_t offset,
                                     uint64_t bytes);
 bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
                                        uint64_t *offset, uint64_t *bytes=
);
-BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
-                                                  BdrvDirtyBitmap *bitma=
p,
+BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BdrvDirtyBitmap *bitma=
p,
                                                   Error **errp);
=20
 #endif
diff --git a/block/backup.c b/block/backup.c
index 46978c1785..dddcf77f53 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -98,13 +98,13 @@ static void backup_cleanup_sync_bitmap(BackupBlockJob=
 *job, int ret)
          * We succeeded, or we always intended to sync the bitmap.
          * Delete this bitmap and install the child.
          */
-        bm =3D bdrv_dirty_bitmap_abdicate(job->source_bs, job->sync_bitm=
ap, NULL);
+        bm =3D bdrv_dirty_bitmap_abdicate(job->sync_bitmap, NULL);
     } else {
         /*
          * We failed, or we never intended to sync the bitmap anyway.
          * Merge the successor back into the parent, keeping all data.
          */
-        bm =3D bdrv_reclaim_dirty_bitmap(job->source_bs, job->sync_bitma=
p, NULL);
+        bm =3D bdrv_reclaim_dirty_bitmap(job->sync_bitmap, NULL);
     }
=20
     assert(bm);
@@ -402,7 +402,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
         }
=20
         /* Create a new bitmap, and freeze/disable this one. */
-        if (bdrv_dirty_bitmap_create_successor(bs, sync_bitmap, errp) < =
0) {
+        if (bdrv_dirty_bitmap_create_successor(sync_bitmap, errp) < 0) {
             return NULL;
         }
     }
@@ -472,7 +472,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
=20
  error:
     if (sync_bitmap) {
-        bdrv_reclaim_dirty_bitmap(bs, sync_bitmap, NULL);
+        bdrv_reclaim_dirty_bitmap(sync_bitmap, NULL);
     }
     if (job) {
         backup_clean(&job->common.job);
diff --git a/block/block-copy.c b/block/block-copy.c
index 0f76ea1e63..066e3a7274 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -60,7 +60,7 @@ void block_copy_state_free(BlockCopyState *s)
         return;
     }
=20
-    bdrv_release_dirty_bitmap(s->source->bs, s->copy_bitmap);
+    bdrv_release_dirty_bitmap(s->copy_bitmap);
     g_free(s);
 }
=20
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 4ecf18d5df..44453ff824 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -30,6 +30,7 @@
=20
 struct BdrvDirtyBitmap {
     QemuMutex *mutex;
+    BlockDriverState *bs;
     HBitmap *bitmap;            /* Dirty bitmap implementation */
     bool busy;                  /* Bitmap is busy, it can't be used via =
QMP */
     BdrvDirtyBitmap *successor; /* Anonymous child, if any. */
@@ -115,6 +116,7 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriver=
State *bs,
         return NULL;
     }
     bitmap =3D g_new0(BdrvDirtyBitmap, 1);
+    bitmap->bs =3D bs;
     bitmap->mutex =3D &bs->dirty_bitmap_mutex;
     bitmap->bitmap =3D hbitmap_alloc(bitmap_size, ctz32(granularity));
     bitmap->size =3D bitmap_size;
@@ -237,8 +239,7 @@ int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *bi=
tmap, uint32_t flags,
  * The successor will be enabled if the parent bitmap was.
  * Called with BQL taken.
  */
-int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
-                                       BdrvDirtyBitmap *bitmap, Error **=
errp)
+int bdrv_dirty_bitmap_create_successor(BdrvDirtyBitmap *bitmap, Error **=
errp)
 {
     uint64_t granularity;
     BdrvDirtyBitmap *child;
@@ -254,7 +255,7 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverSta=
te *bs,
=20
     /* Create an anonymous successor */
     granularity =3D bdrv_dirty_bitmap_granularity(bitmap);
-    child =3D bdrv_create_dirty_bitmap(bs, granularity, NULL, errp);
+    child =3D bdrv_create_dirty_bitmap(bitmap->bs, granularity, NULL, er=
rp);
     if (!child) {
         return -1;
     }
@@ -300,8 +301,7 @@ static void bdrv_release_dirty_bitmap_locked(BdrvDirt=
yBitmap *bitmap)
  * delete the old bitmap, and return a handle to the new bitmap.
  * Called with BQL taken.
  */
-BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
-                                            BdrvDirtyBitmap *bitmap,
+BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BdrvDirtyBitmap *bitmap,
                                             Error **errp)
 {
     char *name;
@@ -320,7 +320,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriv=
erState *bs,
     successor->persistent =3D bitmap->persistent;
     bitmap->persistent =3D false;
     bitmap->busy =3D false;
-    bdrv_release_dirty_bitmap(bs, bitmap);
+    bdrv_release_dirty_bitmap(bitmap);
=20
     return successor;
 }
@@ -332,8 +332,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriv=
erState *bs,
  * The marged parent will be enabled if and only if the successor was en=
abled.
  * Called within bdrv_dirty_bitmap_lock..unlock and with BQL taken.
  */
-BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
-                                                  BdrvDirtyBitmap *paren=
t,
+BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BdrvDirtyBitmap *paren=
t,
                                                   Error **errp)
 {
     BdrvDirtyBitmap *successor =3D parent->successor;
@@ -357,14 +356,13 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(B=
lockDriverState *bs,
 }
=20
 /* Called with BQL taken. */
-BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
-                                           BdrvDirtyBitmap *parent,
+BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BdrvDirtyBitmap *parent,
                                            Error **errp)
 {
     BdrvDirtyBitmap *ret;
=20
     qemu_mutex_lock(parent->mutex);
-    ret =3D bdrv_reclaim_dirty_bitmap_locked(bs, parent, errp);
+    ret =3D bdrv_reclaim_dirty_bitmap_locked(parent, errp);
     qemu_mutex_unlock(parent->mutex);
=20
     return ret;
@@ -390,8 +388,10 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs=
, int64_t bytes)
 }
=20
 /* Called with BQL taken.  */
-void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bi=
tmap)
+void bdrv_release_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
+    BlockDriverState *bs =3D bitmap->bs;
+
     bdrv_dirty_bitmaps_lock(bs);
     bdrv_release_dirty_bitmap_locked(bitmap);
     bdrv_dirty_bitmaps_unlock(bs);
diff --git a/block/mirror.c b/block/mirror.c
index fe984efb90..a6c50caea4 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -638,7 +638,7 @@ static int mirror_exit_common(Job *job)
         bdrv_unfreeze_backing_chain(mirror_top_bs, target_bs);
     }
=20
-    bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
+    bdrv_release_dirty_bitmap(s->dirty_bitmap);
=20
     /* Make sure that the source BDS doesn't go away during bdrv_replace=
_node,
      * before we can call bdrv_drained_end */
@@ -1709,7 +1709,7 @@ fail:
         blk_unref(s->target);
         bs_opaque->job =3D NULL;
         if (s->dirty_bitmap) {
-            bdrv_release_dirty_bitmap(bs, s->dirty_bitmap);
+            bdrv_release_dirty_bitmap(s->dirty_bitmap);
         }
         job_early_fail(&s->common.job);
     }
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 644837eb03..687087d2bc 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -374,7 +374,7 @@ static BdrvDirtyBitmap *load_bitmap(BlockDriverState =
*bs,
 fail:
     g_free(bitmap_table);
     if (bitmap !=3D NULL) {
-        bdrv_release_dirty_bitmap(bs, bitmap);
+        bdrv_release_dirty_bitmap(bitmap);
     }
=20
     return NULL;
@@ -941,7 +941,7 @@ fail:
 static void release_dirty_bitmap_helper(gpointer bitmap,
                                         gpointer bs)
 {
-    bdrv_release_dirty_bitmap(bs, bitmap);
+    bdrv_release_dirty_bitmap(bitmap);
 }
=20
 /* for g_slist_foreach for GSList of BdrvDirtyBitmap* elements */
@@ -1577,7 +1577,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriv=
erState *bs, Error **errp)
             continue;
         }
=20
-        bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
+        bdrv_release_dirty_bitmap(bm->dirty_bitmap);
     }
=20
     bitmap_list_free(bm_list);
diff --git a/blockdev.c b/blockdev.c
index 7e12919724..d77e809623 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2178,7 +2178,7 @@ static void block_dirty_bitmap_remove_commit(BlkAct=
ionState *common)
                                              common, common);
=20
     bdrv_dirty_bitmap_set_busy(state->bitmap, false);
-    bdrv_release_dirty_bitmap(state->bs, state->bitmap);
+    bdrv_release_dirty_bitmap(state->bitmap);
 }
=20
 static void abort_prepare(BlkActionState *common, Error **errp)
@@ -2940,7 +2940,7 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_remov=
e(
     }
=20
     if (release) {
-        bdrv_release_dirty_bitmap(bs, bitmap);
+        bdrv_release_dirty_bitmap(bitmap);
     }
=20
     if (bitmap_bs) {
@@ -3072,7 +3072,7 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_merge=
(
     bdrv_merge_dirty_bitmap(dst, anon, backup, errp);
=20
  out:
-    bdrv_release_dirty_bitmap(bs, anon);
+    bdrv_release_dirty_bitmap(anon);
     return dst;
 }
=20
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitma=
p.c
index 5121f86d73..793f249aa5 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -474,7 +474,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, Dirty=
BitmapLoadState *s)
     if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
         DirtyBitmapLoadBitmapState *b;
=20
-        bdrv_dirty_bitmap_create_successor(s->bs, s->bitmap, &local_err)=
;
+        bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
         if (local_err) {
             error_report_err(local_err);
             return -EINVAL;
@@ -535,13 +535,12 @@ static void dirty_bitmap_load_complete(QEMUFile *f,=
 DirtyBitmapLoadState *s)
         bdrv_dirty_bitmap_lock(s->bitmap);
         if (enabled_bitmaps =3D=3D NULL) {
             /* in postcopy */
-            bdrv_reclaim_dirty_bitmap_locked(s->bs, s->bitmap, &error_ab=
ort);
+            bdrv_reclaim_dirty_bitmap_locked(s->bitmap, &error_abort);
             bdrv_enable_dirty_bitmap_locked(s->bitmap);
         } else {
             /* target not started, successor must be empty */
             int64_t count =3D bdrv_get_dirty_count(s->bitmap);
-            BdrvDirtyBitmap *ret =3D bdrv_reclaim_dirty_bitmap_locked(s-=
>bs,
-                                                                    s->b=
itmap,
+            BdrvDirtyBitmap *ret =3D bdrv_reclaim_dirty_bitmap_locked(s-=
>bitmap,
                                                                     NULL=
);
             /* bdrv_reclaim_dirty_bitmap can fail only on no successor (=
it
              * must be) or on merge fail, but merge can't fail when seco=
nd
diff --git a/migration/block.c b/migration/block.c
index 8e49382070..c90288ed29 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -361,7 +361,7 @@ static int set_dirty_tracking(void)
 fail:
     QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
         if (bmds->dirty_bitmap) {
-            bdrv_release_dirty_bitmap(blk_bs(bmds->blk), bmds->dirty_bit=
map);
+            bdrv_release_dirty_bitmap(bmds->dirty_bitmap);
         }
     }
     return ret;
@@ -374,7 +374,7 @@ static void unset_dirty_tracking(void)
     BlkMigDevState *bmds;
=20
     QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        bdrv_release_dirty_bitmap(blk_bs(bmds->blk), bmds->dirty_bitmap)=
;
+        bdrv_release_dirty_bitmap(bmds->dirty_bitmap);
     }
 }
=20
--=20
2.21.0


