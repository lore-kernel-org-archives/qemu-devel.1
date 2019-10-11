Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDC6C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6BC206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6BC206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ2XM-0008Lf-Pe
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 17:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iJ2QM-0002Di-8Y
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iJ2QK-00010h-Qy
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:26:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47968)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iJ2QH-0000z2-JH; Fri, 11 Oct 2019 17:26:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B892E368DA;
 Fri, 11 Oct 2019 21:26:04 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-173.bos.redhat.com [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B51B4530;
 Fri, 11 Oct 2019 21:26:03 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 03/19] block/dirty-bitmap: return int from
 bdrv_remove_persistent_dirty_bitmap
Date: Fri, 11 Oct 2019 17:25:34 -0400
Message-Id: <20191011212550.27269-4-jsnow@redhat.com>
In-Reply-To: <20191011212550.27269-1-jsnow@redhat.com>
References: <20191011212550.27269-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 11 Oct 2019 21:26:04 +0000 (UTC)
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

It's more comfortable to not deal with local_err.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20190920082543.23444-3-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.h                |  5 ++---
 include/block/block_int.h    |  6 +++---
 include/block/dirty-bitmap.h |  5 ++---
 block/dirty-bitmap.c         |  9 +++++----
 block/qcow2-bitmap.c         | 18 ++++++++++--------
 blockdev.c                   |  7 +++----
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index a488d761ff0..2ed54821635 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -747,9 +747,8 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverStat=
e *bs,
                                       const char *name,
                                       uint32_t granularity,
                                       Error **errp);
-void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
-                                          const char *name,
-                                          Error **errp);
+int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs, const cha=
r *name,
+                                         Error **errp);
=20
 ssize_t coroutine_fn
 qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 0422acdf1c4..503ac9e3cd2 100644
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
=20
     /**
      * Register/unregister a buffer for I/O. For example, when the drive=
r is
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 4b4b731b469..07503b03b53 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -37,9 +37,8 @@ int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *bitm=
ap, uint32_t flags,
                             Error **errp);
 void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bi=
tmap);
 void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
-void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
-                                         const char *name,
-                                         Error **errp);
+int bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char=
 *name,
+                                        Error **errp);
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 void bdrv_enable_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 8f42015db95..d1ae2e19229 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -455,13 +455,14 @@ void bdrv_release_named_dirty_bitmaps(BlockDriverSt=
ate *bs)
  * not fail.
  * This function doesn't release corresponding BdrvDirtyBitmap.
  */
-void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
-                                         const char *name,
-                                         Error **errp)
+int bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs, const char=
 *name,
+                                        Error **errp)
 {
     if (bs->drv && bs->drv->bdrv_remove_persistent_dirty_bitmap) {
-        bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, name, errp);
+        return bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, name, er=
rp);
     }
+
+    return 0;
 }
=20
 bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *n=
ame,
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index b2487101ede..9821c1628f5 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1404,9 +1404,8 @@ static Qcow2Bitmap *find_bitmap_by_name(Qcow2Bitmap=
List *bm_list,
     return NULL;
 }
=20
-void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
-                                          const char *name,
-                                          Error **errp)
+int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs, const cha=
r *name,
+                                         Error **errp)
 {
     int ret;
     BDRVQcow2State *s =3D bs->opaque;
@@ -1416,18 +1415,19 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDr=
iverState *bs,
     if (s->nb_bitmaps =3D=3D 0) {
         /* Absence of the bitmap is not an error: see explanation above
          * bdrv_remove_persistent_dirty_bitmap() definition. */
-        return;
+        return 0;
     }
=20
     bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
                                s->bitmap_directory_size, errp);
     if (bm_list =3D=3D NULL) {
-        return;
+        return -EIO;
     }
=20
     bm =3D find_bitmap_by_name(bm_list, name);
     if (bm =3D=3D NULL) {
-        goto fail;
+        ret =3D -EINVAL;
+        goto out;
     }
=20
     QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
@@ -1435,14 +1435,16 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDr=
iverState *bs,
     ret =3D update_ext_header_and_dir(bs, bm_list);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to update bitmap extension"=
);
-        goto fail;
+        goto out;
     }
=20
     free_bitmap_clusters(bs, &bm->table);
=20
-fail:
+out:
     bitmap_free(bm);
     bitmap_list_free(bm_list);
+
+    return ret;
 }
=20
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **=
errp)
diff --git a/blockdev.c b/blockdev.c
index fbef6845c84..0813adfb2b1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2940,15 +2940,14 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_rem=
ove(
     }
=20
     if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
+        int ret;
         AioContext *aio_context =3D bdrv_get_aio_context(bs);
-        Error *local_err =3D NULL;
=20
         aio_context_acquire(aio_context);
-        bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
+        ret =3D bdrv_remove_persistent_dirty_bitmap(bs, name, errp);
         aio_context_release(aio_context);
=20
-        if (local_err !=3D NULL) {
-            error_propagate(errp, local_err);
+        if (ret < 0) {
             return NULL;
         }
     }
--=20
2.21.0


