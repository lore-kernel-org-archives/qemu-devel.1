Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E07BECE58C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393B52089C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393B52089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK6C4-0007w6-6Q
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 15:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iK62U-0005yD-IP
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iK62S-0002jT-Kz
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:29:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iK62P-0002gZ-1m; Mon, 14 Oct 2019 15:29:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4AFA7A3CD82;
 Mon, 14 Oct 2019 19:29:48 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-152.bos.redhat.com [10.18.17.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E610A60C18;
 Mon, 14 Oct 2019 19:29:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 07/19] block/dirty-bitmap: drop BdrvDirtyBitmap.mutex
Date: Mon, 14 Oct 2019 15:28:57 -0400
Message-Id: <20191014192909.16044-8-jsnow@redhat.com>
In-Reply-To: <20191014192909.16044-1-jsnow@redhat.com>
References: <20191014192909.16044-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 14 Oct 2019 19:29:48 +0000 (UTC)
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

mutex field is just a pointer to bs->dirty_bitmap_mutex, so no needs
to store it in BdrvDirtyBitmap when we have bs pointer in it (since
previous patch).

Drop mutex field. Constantly use bdrv_dirty_bitmaps_lock/unlock in
block/dirty-bitmap.c to make it more obvious that it's not per-bitmap
lock. Still, for simplicity, leave bdrv_dirty_bitmap_lock/unlock
functions as an external API.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20190916141911.5255-4-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 84 +++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 44453ff824..4e5c87a907 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -29,7 +29,6 @@
 #include "qemu/main-loop.h"
=20
 struct BdrvDirtyBitmap {
-    QemuMutex *mutex;
     BlockDriverState *bs;
     HBitmap *bitmap;            /* Dirty bitmap implementation */
     bool busy;                  /* Bitmap is busy, it can't be used via =
QMP */
@@ -72,12 +71,12 @@ static inline void bdrv_dirty_bitmaps_unlock(BlockDri=
verState *bs)
=20
 void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap)
 {
-    qemu_mutex_lock(bitmap->mutex);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
 }
=20
 void bdrv_dirty_bitmap_unlock(BdrvDirtyBitmap *bitmap)
 {
-    qemu_mutex_unlock(bitmap->mutex);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
=20
 /* Called with BQL or dirty_bitmap lock taken.  */
@@ -117,7 +116,6 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriver=
State *bs,
     }
     bitmap =3D g_new0(BdrvDirtyBitmap, 1);
     bitmap->bs =3D bs;
-    bitmap->mutex =3D &bs->dirty_bitmap_mutex;
     bitmap->bitmap =3D hbitmap_alloc(bitmap_size, ctz32(granularity));
     bitmap->size =3D bitmap_size;
     bitmap->name =3D g_strdup(name);
@@ -151,9 +149,9 @@ static bool bdrv_dirty_bitmap_busy(const BdrvDirtyBit=
map *bitmap)
=20
 void bdrv_dirty_bitmap_set_busy(BdrvDirtyBitmap *bitmap, bool busy)
 {
-    qemu_mutex_lock(bitmap->mutex);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bitmap->busy =3D busy;
-    qemu_mutex_unlock(bitmap->mutex);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
=20
 /* Called with BQL taken.  */
@@ -278,10 +276,10 @@ void bdrv_enable_dirty_bitmap_locked(BdrvDirtyBitma=
p *bitmap)
 /* Called with BQL taken. */
 void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap)
 {
-    assert(bitmap->mutex =3D=3D bitmap->successor->mutex);
-    qemu_mutex_lock(bitmap->mutex);
+    assert(bitmap->bs =3D=3D bitmap->successor->bs);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bdrv_enable_dirty_bitmap_locked(bitmap->successor);
-    qemu_mutex_unlock(bitmap->mutex);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
=20
 /* Called within bdrv_dirty_bitmap_lock..unlock and with BQL taken.  */
@@ -361,9 +359,9 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BdrvDirtyB=
itmap *parent,
 {
     BdrvDirtyBitmap *ret;
=20
-    qemu_mutex_lock(parent->mutex);
+    bdrv_dirty_bitmaps_lock(parent->bs);
     ret =3D bdrv_reclaim_dirty_bitmap_locked(parent, errp);
-    qemu_mutex_unlock(parent->mutex);
+    bdrv_dirty_bitmaps_unlock(parent->bs);
=20
     return ret;
 }
@@ -543,16 +541,16 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverSta=
te *bs, const char *name,
=20
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
-    bdrv_dirty_bitmap_lock(bitmap);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bitmap->disabled =3D true;
-    bdrv_dirty_bitmap_unlock(bitmap);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
=20
 void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
-    bdrv_dirty_bitmap_lock(bitmap);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bdrv_enable_dirty_bitmap_locked(bitmap);
-    bdrv_dirty_bitmap_unlock(bitmap);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
=20
 BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
@@ -593,9 +591,9 @@ bool bdrv_dirty_bitmap_get_locked(BdrvDirtyBitmap *bi=
tmap, int64_t offset)
 bool bdrv_dirty_bitmap_get(BdrvDirtyBitmap *bitmap, int64_t offset)
 {
     bool ret;
-    bdrv_dirty_bitmap_lock(bitmap);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     ret =3D bdrv_dirty_bitmap_get_locked(bitmap, offset);
-    bdrv_dirty_bitmap_unlock(bitmap);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
=20
     return ret;
 }
@@ -660,9 +658,9 @@ void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bi=
tmap,
 void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                            int64_t offset, int64_t bytes)
 {
-    bdrv_dirty_bitmap_lock(bitmap);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bdrv_set_dirty_bitmap_locked(bitmap, offset, bytes);
-    bdrv_dirty_bitmap_unlock(bitmap);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
=20
 /* Called within bdrv_dirty_bitmap_lock..unlock */
@@ -676,15 +674,15 @@ void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap=
 *bitmap,
 void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                              int64_t offset, int64_t bytes)
 {
-    bdrv_dirty_bitmap_lock(bitmap);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bdrv_reset_dirty_bitmap_locked(bitmap, offset, bytes);
-    bdrv_dirty_bitmap_unlock(bitmap);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
=20
 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
 {
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
-    bdrv_dirty_bitmap_lock(bitmap);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     if (!out) {
         hbitmap_reset_all(bitmap->bitmap);
     } else {
@@ -693,7 +691,7 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap,=
 HBitmap **out)
                                        hbitmap_granularity(backup));
         *out =3D backup;
     }
-    bdrv_dirty_bitmap_unlock(bitmap);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
=20
 void bdrv_restore_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *backup)
@@ -788,9 +786,9 @@ bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap=
 *bitmap)
 /* Called with BQL taken. */
 void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value)
 {
-    qemu_mutex_lock(bitmap->mutex);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bitmap->readonly =3D value;
-    qemu_mutex_unlock(bitmap->mutex);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
=20
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
@@ -808,27 +806,27 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *bs=
)
 /* Called with BQL taken. */
 void bdrv_dirty_bitmap_set_persistence(BdrvDirtyBitmap *bitmap, bool per=
sistent)
 {
-    qemu_mutex_lock(bitmap->mutex);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bitmap->persistent =3D persistent;
-    qemu_mutex_unlock(bitmap->mutex);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
=20
 /* Called with BQL taken. */
 void bdrv_dirty_bitmap_set_inconsistent(BdrvDirtyBitmap *bitmap)
 {
-    qemu_mutex_lock(bitmap->mutex);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     assert(bitmap->persistent =3D=3D true);
     bitmap->inconsistent =3D true;
     bitmap->disabled =3D true;
-    qemu_mutex_unlock(bitmap->mutex);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
=20
 /* Called with BQL taken. */
 void bdrv_dirty_bitmap_skip_store(BdrvDirtyBitmap *bitmap, bool skip)
 {
-    qemu_mutex_lock(bitmap->mutex);
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
     bitmap->skip_store =3D skip;
-    qemu_mutex_unlock(bitmap->mutex);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
 }
=20
 bool bdrv_dirty_bitmap_get_persistence(BdrvDirtyBitmap *bitmap)
@@ -888,9 +886,9 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, c=
onst BdrvDirtyBitmap *src,
 {
     bool ret;
=20
-    qemu_mutex_lock(dest->mutex);
-    if (src->mutex !=3D dest->mutex) {
-        qemu_mutex_lock(src->mutex);
+    bdrv_dirty_bitmaps_lock(dest->bs);
+    if (src->bs !=3D dest->bs) {
+        bdrv_dirty_bitmaps_lock(src->bs);
     }
=20
     if (bdrv_dirty_bitmap_check(dest, BDRV_BITMAP_DEFAULT, errp)) {
@@ -910,9 +908,9 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, c=
onst BdrvDirtyBitmap *src,
     assert(ret);
=20
 out:
-    qemu_mutex_unlock(dest->mutex);
-    if (src->mutex !=3D dest->mutex) {
-        qemu_mutex_unlock(src->mutex);
+    bdrv_dirty_bitmaps_unlock(dest->bs);
+    if (src->bs !=3D dest->bs) {
+        bdrv_dirty_bitmaps_unlock(src->bs);
     }
 }
=20
@@ -936,9 +934,9 @@ bool bdrv_dirty_bitmap_merge_internal(BdrvDirtyBitmap=
 *dest,
     assert(!bdrv_dirty_bitmap_inconsistent(src));
=20
     if (lock) {
-        qemu_mutex_lock(dest->mutex);
-        if (src->mutex !=3D dest->mutex) {
-            qemu_mutex_lock(src->mutex);
+        bdrv_dirty_bitmaps_lock(dest->bs);
+        if (src->bs !=3D dest->bs) {
+            bdrv_dirty_bitmaps_lock(src->bs);
         }
     }
=20
@@ -951,9 +949,9 @@ bool bdrv_dirty_bitmap_merge_internal(BdrvDirtyBitmap=
 *dest,
     }
=20
     if (lock) {
-        qemu_mutex_unlock(dest->mutex);
-        if (src->mutex !=3D dest->mutex) {
-            qemu_mutex_unlock(src->mutex);
+        bdrv_dirty_bitmaps_unlock(dest->bs);
+        if (src->bs !=3D dest->bs) {
+            bdrv_dirty_bitmaps_unlock(src->bs);
         }
     }
=20
--=20
2.21.0


