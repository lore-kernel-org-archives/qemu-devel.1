Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30823C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A3320868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A3320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55286 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYxyp-0003Ph-Bg
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 15:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53260)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hYxlF-0004Qx-VO
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 15:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hYxLU-0000RZ-0y
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 14:42:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54506)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hYxLG-0007up-OI; Thu, 06 Jun 2019 14:42:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0DE722F8BCA;
 Thu,  6 Jun 2019 18:42:08 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-177.bos.redhat.com [10.18.17.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B42118129;
 Thu,  6 Jun 2019 18:42:07 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 14:41:57 -0400
Message-Id: <20190606184159.979-4-jsnow@redhat.com>
In-Reply-To: <20190606184159.979-1-jsnow@redhat.com>
References: <20190606184159.979-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 06 Jun 2019 18:42:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/5] block/dirty-bitmap: rework
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow propagating error code information from
bdrv_remove_persistent_dirty_bitmap as well.

Give it an interface that matches the newly revised
bdrv_add_persistent_dirty_bitmap, including removing the persistent flag
when the operation succeeds and refusing to operate on bitmaps that are
not persistent.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.h                |  6 +++---
 include/block/block_int.h    |  6 +++---
 include/block/dirty-bitmap.h |  6 +++---
 block/dirty-bitmap.c         | 25 ++++++++++++++++++++-----
 block/qcow2-bitmap.c         | 16 +++++++++-------
 blockdev.c                   | 15 ++++++---------
 6 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 95d723d3c0..ce07f003f7 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -745,9 +745,9 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Err=
or **errp);
 int qcow2_add_persistent_dirty_bitmap(BlockDriverState *bs,
                                       BdrvDirtyBitmap *bitmap,
                                       Error **errp);
-void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
-                                          const char *name,
-                                          Error **errp);
+int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
+                                         BdrvDirtyBitmap *bitmap,
+                                         Error **errp);
=20
 ssize_t coroutine_fn
 qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 93bbb66cd0..59f8cb9c12 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -540,9 +540,9 @@ struct BlockDriver {
     int (*bdrv_add_persistent_dirty_bitmap)(BlockDriverState *bs,
                                             BdrvDirtyBitmap *bitmap,
                                             Error **errp);
-    void (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
-                                                const char *name,
-                                                Error **errp);
+    int (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
+                                               BdrvDirtyBitmap *bitmap,
+                                               Error **errp);
=20
     /**
      * Register/unregister a buffer for I/O. For example, when the drive=
r is
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index c37edbe05f..88a9832ddc 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -41,9 +41,9 @@ void bdrv_release_named_dirty_bitmaps(BlockDriverState =
*bs);
 int bdrv_add_persistent_dirty_bitmap(BlockDriverState *bs,
                                       BdrvDirtyBitmap *bitmap,
                                       Error **errp);
-void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
-                                         const char *name,
-                                         Error **errp);
+int bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
+                                        BdrvDirtyBitmap *bitmap,
+                                        Error **errp);
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 void bdrv_enable_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 615f8480b2..4667f9e65a 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -455,15 +455,30 @@ void bdrv_release_named_dirty_bitmaps(BlockDriverSt=
ate *bs)
  * BdrvDirtyBitmap can have .persistent =3D true but not yet saved and h=
ave no
  * stored version. For such bitmap bdrv_remove_persistent_dirty_bitmap()=
 should
  * not fail.
- * This function doesn't release corresponding BdrvDirtyBitmap.
+ * This function doesn't release the corresponding BdrvDirtyBitmap.
  */
-void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
-                                         const char *name,
-                                         Error **errp)
+int bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
+                                        BdrvDirtyBitmap *bitmap,
+                                        Error **errp)
 {
+    int ret =3D 0;
+
+    if (!bdrv_dirty_bitmap_get_persistence(bitmap)) {
+        error_setg(errp, "Bitmap '%s' is not persistent, "
+                   "so it cannot be removed from node '%s'",
+                   bdrv_dirty_bitmap_name(bitmap),
+                   bdrv_get_device_or_node_name(bs));
+        return -EINVAL;
+    }
+
     if (bs->drv && bs->drv->bdrv_remove_persistent_dirty_bitmap) {
-        bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, name, errp);
+        ret =3D bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, bitmap,=
 errp);
     }
+    if (!ret) {
+        bdrv_dirty_bitmap_set_persistence(bitmap, false);
+    }
+
+    return ret;
 }
=20
 int bdrv_add_persistent_dirty_bitmap(BlockDriverState *bs,
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index c3a72ca782..930a6c91ff 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1402,23 +1402,24 @@ static Qcow2Bitmap *find_bitmap_by_name(Qcow2Bitm=
apList *bm_list,
     return NULL;
 }
=20
-void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
-                                          const char *name,
-                                          Error **errp)
+int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
+                                         BdrvDirtyBitmap *bitmap,
+                                         Error **errp)
 {
-    int ret;
+    int ret =3D 0;
     BDRVQcow2State *s =3D bs->opaque;
     Qcow2Bitmap *bm;
     Qcow2BitmapList *bm_list;
+    const char *name =3D bdrv_dirty_bitmap_name(bitmap);
=20
     if (s->nb_bitmaps =3D=3D 0) {
         /* Absence of the bitmap is not an error: see explanation above
          * bdrv_remove_persistent_dirty_bitmap() definition. */
-        return;
+        return 0;
     }
=20
-    if (bitmap_list_load(bs, &bm_list, errp)) {
-        return;
+    if ((ret =3D bitmap_list_load(bs, &bm_list, errp))) {
+        return ret;
     }
=20
     bm =3D find_bitmap_by_name(bm_list, name);
@@ -1439,6 +1440,7 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriv=
erState *bs,
 fail:
     bitmap_free(bm);
     bitmap_list_free(bm_list);
+    return ret;
 }
=20
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **=
errp)
diff --git a/blockdev.c b/blockdev.c
index 169a8da831..82f02d8e72 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2875,7 +2875,6 @@ void qmp_block_dirty_bitmap_remove(const char *node=
, const char *name,
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
-    Error *local_err =3D NULL;
     AioContext *aio_context =3D NULL;
=20
     bitmap =3D block_dirty_bitmap_lookup(node, name, &bs, errp);
@@ -2889,20 +2888,18 @@ void qmp_block_dirty_bitmap_remove(const char *no=
de, const char *name,
     }
=20
     if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
+        int ret;
+
         aio_context =3D bdrv_get_aio_context(bs);
         aio_context_acquire(aio_context);
-        bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
-        if (local_err !=3D NULL) {
-            error_propagate(errp, local_err);
-            goto out;
+        ret =3D bdrv_remove_persistent_dirty_bitmap(bs, bitmap, errp);
+        aio_context_release(aio_context);
+        if (ret) {
+            return;
         }
     }
=20
     bdrv_release_dirty_bitmap(bs, bitmap);
- out:
-    if (aio_context) {
-        aio_context_release(aio_context);
-    }
 }
=20
 /**
--=20
2.20.1


