Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E72BECE58C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECEA9217F9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEA9217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK68d-0003Y0-Kl
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 15:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iK62Q-0005rE-7t
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iK62O-0002h1-U3
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:29:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52244)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iK62M-0002Zh-2U; Mon, 14 Oct 2019 15:29:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D27410CC1FC;
 Mon, 14 Oct 2019 19:29:45 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-152.bos.redhat.com [10.18.17.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01CB960BE2;
 Mon, 14 Oct 2019 19:29:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 05/19] block/dirty-bitmap: drop meta
Date: Mon, 14 Oct 2019 15:28:55 -0400
Message-Id: <20191014192909.16044-6-jsnow@redhat.com>
In-Reply-To: <20191014192909.16044-1-jsnow@redhat.com>
References: <20191014192909.16044-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Mon, 14 Oct 2019 19:29:45 +0000 (UTC)
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

Drop meta bitmaps, as they are unused.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20190916141911.5255-2-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/block/dirty-bitmap.h |  5 ----
 block/dirty-bitmap.c         | 46 ------------------------------------
 2 files changed, 51 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 07503b03b5..973056778a 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -18,9 +18,6 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverSt=
ate *bs,
                                           uint32_t granularity,
                                           const char *name,
                                           Error **errp);
-void bdrv_create_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap,
-                                   int chunk_size);
-void bdrv_release_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
                                        BdrvDirtyBitmap *bitmap,
                                        Error **errp);
@@ -54,7 +51,6 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                            int64_t offset, int64_t bytes);
 void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                              int64_t offset, int64_t bytes);
-BdrvDirtyBitmapIter *bdrv_dirty_meta_iter_new(BdrvDirtyBitmap *bitmap);
 BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter);
=20
@@ -96,7 +92,6 @@ void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bi=
tmap,
 int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
 void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t offset);
 int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
-int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes);
 bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 03e0872b97..4ecf18d5df 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -31,7 +31,6 @@
 struct BdrvDirtyBitmap {
     QemuMutex *mutex;
     HBitmap *bitmap;            /* Dirty bitmap implementation */
-    HBitmap *meta;              /* Meta dirty bitmap */
     bool busy;                  /* Bitmap is busy, it can't be used via =
QMP */
     BdrvDirtyBitmap *successor; /* Anonymous child, if any. */
     char *name;                 /* Optional non-empty unique ID */
@@ -127,36 +126,6 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDrive=
rState *bs,
     return bitmap;
 }
=20
-/* bdrv_create_meta_dirty_bitmap
- *
- * Create a meta dirty bitmap that tracks the changes of bits in @bitmap=
. I.e.
- * when a dirty status bit in @bitmap is changed (either from reset to s=
et or
- * the other way around), its respective meta dirty bitmap bit will be m=
arked
- * dirty as well.
- *
- * @bitmap: the block dirty bitmap for which to create a meta dirty bitm=
ap.
- * @chunk_size: how many bytes of bitmap data does each bit in the meta =
bitmap
- * track.
- */
-void bdrv_create_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap,
-                                   int chunk_size)
-{
-    assert(!bitmap->meta);
-    qemu_mutex_lock(bitmap->mutex);
-    bitmap->meta =3D hbitmap_create_meta(bitmap->bitmap,
-                                       chunk_size * BITS_PER_BYTE);
-    qemu_mutex_unlock(bitmap->mutex);
-}
-
-void bdrv_release_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap)
-{
-    assert(bitmap->meta);
-    qemu_mutex_lock(bitmap->mutex);
-    hbitmap_free_meta(bitmap->bitmap);
-    bitmap->meta =3D NULL;
-    qemu_mutex_unlock(bitmap->mutex);
-}
-
 int64_t bdrv_dirty_bitmap_size(const BdrvDirtyBitmap *bitmap)
 {
     return bitmap->size;
@@ -320,7 +289,6 @@ static void bdrv_release_dirty_bitmap_locked(BdrvDirt=
yBitmap *bitmap)
     assert(!bitmap->active_iterators);
     assert(!bdrv_dirty_bitmap_busy(bitmap));
     assert(!bdrv_dirty_bitmap_has_successor(bitmap));
-    assert(!bitmap->meta);
     QLIST_REMOVE(bitmap, list);
     hbitmap_free(bitmap->bitmap);
     g_free(bitmap->name);
@@ -666,15 +634,6 @@ BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBi=
tmap *bitmap)
     return iter;
 }
=20
-BdrvDirtyBitmapIter *bdrv_dirty_meta_iter_new(BdrvDirtyBitmap *bitmap)
-{
-    BdrvDirtyBitmapIter *iter =3D g_new(BdrvDirtyBitmapIter, 1);
-    hbitmap_iter_init(&iter->hbi, bitmap->meta, 0);
-    iter->bitmap =3D bitmap;
-    bitmap->active_iterators++;
-    return iter;
-}
-
 void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter)
 {
     if (!iter) {
@@ -821,11 +780,6 @@ int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap=
)
     return hbitmap_count(bitmap->bitmap);
 }
=20
-int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
-{
-    return hbitmap_count(bitmap->meta);
-}
-
 bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap)
 {
     return bitmap->readonly;
--=20
2.21.0


