Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1E6C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF1320872
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF1320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYxpB-0006eX-Eu
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 15:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53352)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hYxlF-0004T3-W5
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 15:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hYxLT-0000R8-FG
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 14:42:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hYxLG-0007qf-OM; Thu, 06 Jun 2019 14:42:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED22830832CE;
 Thu,  6 Jun 2019 18:42:06 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-177.bos.redhat.com [10.18.17.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 089115C2EB;
 Thu,  6 Jun 2019 18:42:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 14:41:56 -0400
Message-Id: <20190606184159.979-3-jsnow@redhat.com>
In-Reply-To: <20190606184159.979-1-jsnow@redhat.com>
References: <20190606184159.979-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 06 Jun 2019 18:42:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/5] block/dirty-bitmap: Refactor
 bdrv_can_store_new_bitmap
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

Instead of bdrv_can_store_new_bitmap, rework this as
bdrv_add_persistent_dirty_bitmap. This makes a more obvious symmetry
with bdrv_remove_persistent_dirty_bitmap. Most importantly, we are free
to modify the driver state because we know we ARE adding a bitmap
instead of simply being asked if we CAN store one.

As part of this symmetry, move this function next to
bdrv_remove_persistent_bitmap in block/dirty-bitmap.c.

To cement this semantic distinction, use a bitmap object instead of the
(name, granularity) pair as this allows us to set persistence as a
condition of the "add" succeeding.

Notably, the qcow2 implementation still does not actually store the new
bitmap at add time, but merely ensures that it will be able to at store
time.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.h                |  5 ++---
 include/block/block.h        |  2 --
 include/block/block_int.h    |  5 ++---
 include/block/dirty-bitmap.h |  3 +++
 block.c                      | 22 ---------------------
 block/dirty-bitmap.c         | 38 ++++++++++++++++++++++++++++++++++++
 block/qcow2-bitmap.c         | 24 ++++++++++++++---------
 block/qcow2.c                |  2 +-
 blockdev.c                   | 19 +++++++-----------
 9 files changed, 68 insertions(+), 52 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index fc1b0d3c1e..95d723d3c0 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -742,9 +742,8 @@ int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Err=
or **errp);
 int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **=
errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
-bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
-                                      const char *name,
-                                      uint32_t granularity,
+int qcow2_add_persistent_dirty_bitmap(BlockDriverState *bs,
+                                      BdrvDirtyBitmap *bitmap,
                                       Error **errp);
 void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                           const char *name,
diff --git a/include/block/block.h b/include/block/block.h
index f9415ed740..6d520f3b59 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -683,8 +683,6 @@ void bdrv_add_child(BlockDriverState *parent, BlockDr=
iverState *child,
                     Error **errp);
 void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **=
errp);
=20
-bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *n=
ame,
-                                     uint32_t granularity, Error **errp)=
;
 /**
  *
  * bdrv_register_buf/bdrv_unregister_buf:
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 06df2bda1b..93bbb66cd0 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -537,9 +537,8 @@ struct BlockDriver {
      * field of BlockDirtyBitmap's in case of success.
      */
     int (*bdrv_reopen_bitmaps_rw)(BlockDriverState *bs, Error **errp);
-    bool (*bdrv_can_store_new_dirty_bitmap)(BlockDriverState *bs,
-                                            const char *name,
-                                            uint32_t granularity,
+    int (*bdrv_add_persistent_dirty_bitmap)(BlockDriverState *bs,
+                                            BdrvDirtyBitmap *bitmap,
                                             Error **errp);
     void (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
                                                 const char *name,
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 8044ace63e..c37edbe05f 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -38,6 +38,9 @@ int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *bitm=
ap, uint32_t flags,
                             Error **errp);
 void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bi=
tmap);
 void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
+int bdrv_add_persistent_dirty_bitmap(BlockDriverState *bs,
+                                      BdrvDirtyBitmap *bitmap,
+                                      Error **errp);
 void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                          const char *name,
                                          Error **errp);
diff --git a/block.c b/block.c
index e3e77feee0..6aec36b7c9 100644
--- a/block.c
+++ b/block.c
@@ -6379,25 +6379,3 @@ void bdrv_del_child(BlockDriverState *parent_bs, B=
drvChild *child, Error **errp)
=20
     parent_bs->drv->bdrv_del_child(parent_bs, child, errp);
 }
-
-bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *n=
ame,
-                                     uint32_t granularity, Error **errp)
-{
-    BlockDriver *drv =3D bs->drv;
-
-    if (!drv) {
-        error_setg_errno(errp, ENOMEDIUM,
-                         "Can't store persistent bitmaps to %s",
-                         bdrv_get_device_or_node_name(bs));
-        return false;
-    }
-
-    if (!drv->bdrv_can_store_new_dirty_bitmap) {
-        error_setg_errno(errp, ENOTSUP,
-                         "Can't store persistent bitmaps to %s",
-                         bdrv_get_device_or_node_name(bs));
-        return false;
-    }
-
-    return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, e=
rrp);
-}
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 49646a30e6..615f8480b2 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -466,6 +466,44 @@ void bdrv_remove_persistent_dirty_bitmap(BlockDriver=
State *bs,
     }
 }
=20
+int bdrv_add_persistent_dirty_bitmap(BlockDriverState *bs,
+                                     BdrvDirtyBitmap *bitmap,
+                                     Error **errp)
+{
+    BlockDriver *drv =3D bs->drv;
+    int ret;
+
+    if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
+        error_setg(errp, "Bitmap '%s' is already persistent, "
+                   "and cannot be re-added to node '%s'",
+                   bdrv_dirty_bitmap_name(bitmap),
+                   bdrv_get_device_or_node_name(bs));
+        return -EINVAL;
+    }
+
+    if (!drv) {
+        error_setg_errno(errp, ENOMEDIUM,
+                         "Can't store persistent bitmaps to %s",
+                         bdrv_get_device_or_node_name(bs));
+        return -ENOMEDIUM;
+    }
+
+    if (!drv->bdrv_add_persistent_dirty_bitmap) {
+        error_setg_errno(errp, ENOTSUP,
+                         "Can't store persistent bitmaps to %s",
+                         bdrv_get_device_or_node_name(bs));
+        return -ENOTSUP;
+    }
+
+    ret =3D drv->bdrv_add_persistent_dirty_bitmap(bs, bitmap, errp);
+    if (ret =3D=3D 0) {
+        bdrv_dirty_bitmap_set_persistence(bitmap, true);
+    }
+
+    return ret;
+}
+
+
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
     bdrv_dirty_bitmap_lock(bitmap);
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 83aee1a42a..c3a72ca782 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1607,14 +1607,16 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs,=
 Error **errp)
     return 0;
 }
=20
-bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
-                                      const char *name,
-                                      uint32_t granularity,
+int qcow2_add_persistent_dirty_bitmap(BlockDriverState *bs,
+                                      BdrvDirtyBitmap *bitmap,
                                       Error **errp)
 {
     BDRVQcow2State *s =3D bs->opaque;
     bool found;
     Qcow2BitmapList *bm_list;
+    const char *name =3D bdrv_dirty_bitmap_name(bitmap);
+    uint32_t granularity =3D bdrv_dirty_bitmap_granularity(bitmap);
+    int ret =3D 0;
=20
     if (s->qcow_version < 3) {
         /* Without autoclear_features, we would always have to assume
@@ -1623,20 +1625,23 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriver=
State *bs,
          * have to drop all dirty bitmaps (defeating their purpose).
          */
         error_setg(errp, "Cannot store dirty bitmaps in qcow2 v2 files")=
;
+        ret =3D -ENOTSUP;
         goto fail;
     }
=20
-    if (check_constraints_on_bitmap(bs, name, granularity, errp) !=3D 0)=
 {
+    ret =3D check_constraints_on_bitmap(bs, name, granularity, errp);
+    if (ret) {
         goto fail;
     }
=20
     if (s->nb_bitmaps =3D=3D 0) {
-        return true;
+        return 0;
     }
=20
     if (s->nb_bitmaps >=3D QCOW2_MAX_BITMAPS) {
         error_setg(errp,
                    "Maximum number of persistent bitmaps is already reac=
hed");
+        ret =3D -EOVERFLOW;
         goto fail;
     }
=20
@@ -1644,24 +1649,25 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriver=
State *bs,
         QCOW2_MAX_BITMAP_DIRECTORY_SIZE)
     {
         error_setg(errp, "Not enough space in the bitmap directory");
+        ret =3D -EOVERFLOW;
         goto fail;
     }
=20
-    if (bitmap_list_load(bs, &bm_list, errp)) {
+    if ((ret =3D bitmap_list_load(bs, &bm_list, errp))) {
         goto fail;
     }
=20
     found =3D find_bitmap_by_name(bm_list, name);
     bitmap_list_free(bm_list);
     if (found) {
+        ret =3D -EEXIST;
         error_setg(errp, "Bitmap with the same name is already stored");
         goto fail;
     }
=20
-    return true;
-
+    return 0;
 fail:
     error_prepend(errp, "Can't make bitmap '%s' persistent in '%s': ",
                   name, bdrv_get_device_or_node_name(bs));
-    return false;
+    return ret;
 }
diff --git a/block/qcow2.c b/block/qcow2.c
index 9396d490d5..1c78eba71b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5229,7 +5229,7 @@ BlockDriver bdrv_qcow2 =3D {
     .bdrv_attach_aio_context  =3D qcow2_attach_aio_context,
=20
     .bdrv_reopen_bitmaps_rw =3D qcow2_reopen_bitmaps_rw,
-    .bdrv_can_store_new_dirty_bitmap =3D qcow2_can_store_new_dirty_bitma=
p,
+    .bdrv_add_persistent_dirty_bitmap =3D qcow2_add_persistent_dirty_bit=
map,
     .bdrv_remove_persistent_dirty_bitmap =3D qcow2_remove_persistent_dir=
ty_bitmap,
 };
=20
diff --git a/blockdev.c b/blockdev.c
index 3f44b891eb..169a8da831 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2851,26 +2851,21 @@ void qmp_block_dirty_bitmap_add(const char *node,=
 const char *name,
         disabled =3D false;
     }
=20
-    if (persistent) {
-        aio_context =3D bdrv_get_aio_context(bs);
-        aio_context_acquire(aio_context);
-        if (!bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp=
)) {
-            goto out;
-        }
-    }
-
     bitmap =3D bdrv_create_dirty_bitmap(bs, granularity, name, errp);
     if (bitmap =3D=3D NULL) {
-        goto out;
+        return;
     }
=20
     if (disabled) {
         bdrv_disable_dirty_bitmap(bitmap);
     }
=20
-    bdrv_dirty_bitmap_set_persistence(bitmap, persistent);
- out:
-    if (aio_context) {
+    if (persistent) {
+        aio_context =3D bdrv_get_aio_context(bs);
+        aio_context_acquire(aio_context);
+        if (bdrv_add_persistent_dirty_bitmap(bs, bitmap, errp)) {
+            bdrv_release_dirty_bitmap(bs, bitmap);
+        }
         aio_context_release(aio_context);
     }
 }
--=20
2.20.1


