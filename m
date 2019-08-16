Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E06DC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F1442077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1442077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyleo-00025W-WC
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylPq-0006hL-Bb
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylPo-00067Y-M2
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylPk-0005yH-0O; Fri, 16 Aug 2019 19:13:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 48831309BF21;
 Fri, 16 Aug 2019 23:13:42 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 813B419C6A;
 Fri, 16 Aug 2019 23:13:41 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:13:02 -0400
Message-Id: <20190816231318.8650-21-jsnow@redhat.com>
In-Reply-To: <20190816231318.8650-1-jsnow@redhat.com>
References: <20190816231318.8650-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 16 Aug 2019 23:13:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 20/36] qapi: implement block-dirty-bitmap-remove
 transaction action
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
Cc: peter.maydell@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is used to do transactional movement of the bitmap (which is
possible in conjunction with merge command). Transactional bitmap
movement is needed in scenarios with external snapshot, when we don't
want to leave copy of the bitmap in the base image.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190708220502.12977-3-jsnow@redhat.com
[Edited "since" version to 4.2 --js]
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block.c                        |  2 +-
 block/dirty-bitmap.c           | 15 +++----
 blockdev.c                     | 79 +++++++++++++++++++++++++++++++---
 include/block/dirty-bitmap.h   |  2 +-
 migration/block-dirty-bitmap.c |  2 +-
 qapi/transaction.json          |  2 +
 6 files changed, 85 insertions(+), 17 deletions(-)

diff --git a/block.c b/block.c
index 2a2d0696672..3e698e9cabd 100644
--- a/block.c
+++ b/block.c
@@ -5346,7 +5346,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(B=
lockDriverState *bs,
     for (bm =3D bdrv_dirty_bitmap_next(bs, NULL); bm;
          bm =3D bdrv_dirty_bitmap_next(bs, bm))
     {
-        bdrv_dirty_bitmap_set_migration(bm, false);
+        bdrv_dirty_bitmap_skip_store(bm, false);
     }
=20
     ret =3D refresh_total_sectors(bs, bs->total_sectors);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 75a5daf116f..134e0c9a0c8 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -48,10 +48,9 @@ struct BdrvDirtyBitmap {
     bool inconsistent;          /* bitmap is persistent, but inconsisten=
t.
                                    It cannot be used at all in any way, =
except
                                    a QMP user can remove it. */
-    bool migration;             /* Bitmap is selected for migration, it =
should
-                                   not be stored on the next inactivatio=
n
-                                   (persistent flag doesn't matter until=
 next
-                                   invalidation).*/
+    bool skip_store;            /* We are either migrating or deleting t=
his
+                                 * bitmap; it should not be stored on th=
e next
+                                 * inactivation. */
     QLIST_ENTRY(BdrvDirtyBitmap) list;
 };
=20
@@ -762,16 +761,16 @@ void bdrv_dirty_bitmap_set_inconsistent(BdrvDirtyBi=
tmap *bitmap)
 }
=20
 /* Called with BQL taken. */
-void bdrv_dirty_bitmap_set_migration(BdrvDirtyBitmap *bitmap, bool migra=
tion)
+void bdrv_dirty_bitmap_skip_store(BdrvDirtyBitmap *bitmap, bool skip)
 {
     qemu_mutex_lock(bitmap->mutex);
-    bitmap->migration =3D migration;
+    bitmap->skip_store =3D skip;
     qemu_mutex_unlock(bitmap->mutex);
 }
=20
 bool bdrv_dirty_bitmap_get_persistence(BdrvDirtyBitmap *bitmap)
 {
-    return bitmap->persistent && !bitmap->migration;
+    return bitmap->persistent && !bitmap->skip_store;
 }
=20
 bool bdrv_dirty_bitmap_inconsistent(const BdrvDirtyBitmap *bitmap)
@@ -783,7 +782,7 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDriverS=
tate *bs)
 {
     BdrvDirtyBitmap *bm;
     QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
-        if (bm->persistent && !bm->readonly && !bm->migration) {
+        if (bm->persistent && !bm->readonly && !bm->skip_store) {
             return true;
         }
     }
diff --git a/blockdev.c b/blockdev.c
index bcd766a1a24..210226d8290 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2136,6 +2136,51 @@ static void block_dirty_bitmap_merge_prepare(BlkAc=
tionState *common,
                                                 errp);
 }
=20
+static BdrvDirtyBitmap *do_block_dirty_bitmap_remove(
+        const char *node, const char *name, bool release,
+        BlockDriverState **bitmap_bs, Error **errp);
+
+static void block_dirty_bitmap_remove_prepare(BlkActionState *common,
+                                              Error **errp)
+{
+    BlockDirtyBitmap *action;
+    BlockDirtyBitmapState *state =3D DO_UPCAST(BlockDirtyBitmapState,
+                                             common, common);
+
+    if (action_check_completion_mode(common, errp) < 0) {
+        return;
+    }
+
+    action =3D common->action->u.block_dirty_bitmap_remove.data;
+
+    state->bitmap =3D do_block_dirty_bitmap_remove(action->node, action-=
>name,
+                                                 false, &state->bs, errp=
);
+    if (state->bitmap) {
+        bdrv_dirty_bitmap_skip_store(state->bitmap, true);
+        bdrv_dirty_bitmap_set_busy(state->bitmap, true);
+    }
+}
+
+static void block_dirty_bitmap_remove_abort(BlkActionState *common)
+{
+    BlockDirtyBitmapState *state =3D DO_UPCAST(BlockDirtyBitmapState,
+                                             common, common);
+
+    if (state->bitmap) {
+        bdrv_dirty_bitmap_skip_store(state->bitmap, false);
+        bdrv_dirty_bitmap_set_busy(state->bitmap, false);
+    }
+}
+
+static void block_dirty_bitmap_remove_commit(BlkActionState *common)
+{
+    BlockDirtyBitmapState *state =3D DO_UPCAST(BlockDirtyBitmapState,
+                                             common, common);
+
+    bdrv_dirty_bitmap_set_busy(state->bitmap, false);
+    bdrv_release_dirty_bitmap(state->bs, state->bitmap);
+}
+
 static void abort_prepare(BlkActionState *common, Error **errp)
 {
     error_setg(errp, "Transaction aborted using Abort action");
@@ -2213,6 +2258,12 @@ static const BlkActionOps actions[] =3D {
         .commit =3D block_dirty_bitmap_free_backup,
         .abort =3D block_dirty_bitmap_restore,
     },
+    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_REMOVE] =3D {
+        .instance_size =3D sizeof(BlockDirtyBitmapState),
+        .prepare =3D block_dirty_bitmap_remove_prepare,
+        .commit =3D block_dirty_bitmap_remove_commit,
+        .abort =3D block_dirty_bitmap_remove_abort,
+    },
     /* Where are transactions for MIRROR, COMMIT and STREAM?
      * Although these blockjobs use transaction callbacks like the backu=
p job,
      * these jobs do not necessarily adhere to transaction semantics.
@@ -2871,20 +2922,21 @@ void qmp_block_dirty_bitmap_add(const char *node,=
 const char *name,
     bdrv_dirty_bitmap_set_persistence(bitmap, persistent);
 }
=20
-void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
-                                   Error **errp)
+static BdrvDirtyBitmap *do_block_dirty_bitmap_remove(
+        const char *node, const char *name, bool release,
+        BlockDriverState **bitmap_bs, Error **errp)
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
=20
     bitmap =3D block_dirty_bitmap_lookup(node, name, &bs, errp);
     if (!bitmap || !bs) {
-        return;
+        return NULL;
     }
=20
     if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_BUSY | BDRV_BITMAP_R=
O,
                                 errp)) {
-        return;
+        return NULL;
     }
=20
     if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
@@ -2894,13 +2946,28 @@ void qmp_block_dirty_bitmap_remove(const char *no=
de, const char *name,
         aio_context_acquire(aio_context);
         bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
         aio_context_release(aio_context);
+
         if (local_err !=3D NULL) {
             error_propagate(errp, local_err);
-            return;
+            return NULL;
         }
     }
=20
-    bdrv_release_dirty_bitmap(bs, bitmap);
+    if (release) {
+        bdrv_release_dirty_bitmap(bs, bitmap);
+    }
+
+    if (bitmap_bs) {
+        *bitmap_bs =3D bs;
+    }
+
+    return release ? NULL : bitmap;
+}
+
+void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
+                                   Error **errp)
+{
+    do_block_dirty_bitmap_remove(node, name, true, NULL, errp);
 }
=20
 /**
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 0120ef3f05a..4b4b731b469 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -83,7 +83,7 @@ void bdrv_dirty_bitmap_set_inconsistent(BdrvDirtyBitmap=
 *bitmap);
 void bdrv_dirty_bitmap_set_busy(BdrvDirtyBitmap *bitmap, bool busy);
 void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitma=
p *src,
                              HBitmap **backup, Error **errp);
-void bdrv_dirty_bitmap_set_migration(BdrvDirtyBitmap *bitmap, bool migra=
tion);
+void bdrv_dirty_bitmap_skip_store(BdrvDirtyBitmap *bitmap, bool skip);
 bool bdrv_dirty_bitmap_get(BdrvDirtyBitmap *bitmap, int64_t offset);
=20
 /* Functions that require manual locking.  */
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitma=
p.c
index a09a893c023..dd40724b9e5 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -326,7 +326,7 @@ static int init_dirty_bitmap_migration(void)
=20
     /* unset migration flags here, to not roll back it */
     QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
-        bdrv_dirty_bitmap_set_migration(dbms->bitmap, true);
+        bdrv_dirty_bitmap_skip_store(dbms->bitmap, true);
     }
=20
     if (QSIMPLEQ_EMPTY(&dirty_bitmap_mig_state.dbms_list)) {
diff --git a/qapi/transaction.json b/qapi/transaction.json
index 95edb782278..0590dbcd1ae 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -45,6 +45,7 @@
 #
 # - @abort: since 1.6
 # - @block-dirty-bitmap-add: since 2.5
+# - @block-dirty-bitmap-remove: since 4.2
 # - @block-dirty-bitmap-clear: since 2.5
 # - @block-dirty-bitmap-enable: since 4.0
 # - @block-dirty-bitmap-disable: since 4.0
@@ -61,6 +62,7 @@
   'data': {
        'abort': 'Abort',
        'block-dirty-bitmap-add': 'BlockDirtyBitmapAdd',
+       'block-dirty-bitmap-remove': 'BlockDirtyBitmap',
        'block-dirty-bitmap-clear': 'BlockDirtyBitmap',
        'block-dirty-bitmap-enable': 'BlockDirtyBitmap',
        'block-dirty-bitmap-disable': 'BlockDirtyBitmap',
--=20
2.21.0


