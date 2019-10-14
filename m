Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA3FC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 917262089C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917262089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK6BI-0007IX-8Z
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 15:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iK62U-0005yp-Mw
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iK62T-0002kB-BB
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:29:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iK62Q-0002iB-IY; Mon, 14 Oct 2019 15:29:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C380C4E924;
 Mon, 14 Oct 2019 19:29:49 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-152.bos.redhat.com [10.18.17.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D94760BE2;
 Mon, 14 Oct 2019 19:29:48 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 08/19] block/dirty-bitmap: refactor bdrv_dirty_bitmap_next
Date: Mon, 14 Oct 2019 15:28:58 -0400
Message-Id: <20191014192909.16044-9-jsnow@redhat.com>
In-Reply-To: <20191014192909.16044-1-jsnow@redhat.com>
References: <20191014192909.16044-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 14 Oct 2019 19:29:49 +0000 (UTC)
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

bdrv_dirty_bitmap_next is always used in same pattern. So, split it
into _next and _first, instead of combining two functions into one and
add FOR_EACH_DIRTY_BITMAP macro.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20190916141911.5255-5-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/block/dirty-bitmap.h   |  9 +++++++--
 block.c                        |  4 +---
 block/dirty-bitmap.c           | 11 +++++++----
 block/qcow2-bitmap.c           |  8 ++------
 migration/block-dirty-bitmap.c |  4 +---
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 2f9b088e11..257f0f6704 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -96,8 +96,13 @@ bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBit=
map *bitmap);
 bool bdrv_dirty_bitmap_get_persistence(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_inconsistent(const BdrvDirtyBitmap *bitmap);
 bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
-BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
-                                        BdrvDirtyBitmap *bitmap);
+
+BdrvDirtyBitmap *bdrv_dirty_bitmap_first(BlockDriverState *bs);
+BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BdrvDirtyBitmap *bitmap);
+#define FOR_EACH_DIRTY_BITMAP(bs, bitmap) \
+for (bitmap =3D bdrv_dirty_bitmap_first(bs); bitmap; \
+     bitmap =3D bdrv_dirty_bitmap_next(bitmap))
+
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **er=
rp);
 int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t of=
fset,
                                     uint64_t bytes);
diff --git a/block.c b/block.c
index d19a4781a3..5721441697 100644
--- a/block.c
+++ b/block.c
@@ -5390,9 +5390,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(B=
lockDriverState *bs,
         }
     }
=20
-    for (bm =3D bdrv_dirty_bitmap_next(bs, NULL); bm;
-         bm =3D bdrv_dirty_bitmap_next(bs, bm))
-    {
+    FOR_EACH_DIRTY_BITMAP(bs, bm) {
         bdrv_dirty_bitmap_skip_store(bm, false);
     }
=20
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 4e5c87a907..6065db8094 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -851,11 +851,14 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDrive=
rState *bs)
     return false;
 }
=20
-BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
-                                        BdrvDirtyBitmap *bitmap)
+BdrvDirtyBitmap *bdrv_dirty_bitmap_first(BlockDriverState *bs)
 {
-    return bitmap =3D=3D NULL ? QLIST_FIRST(&bs->dirty_bitmaps) :
-                            QLIST_NEXT(bitmap, list);
+    return QLIST_FIRST(&bs->dirty_bitmaps);
+}
+
+BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BdrvDirtyBitmap *bitmap)
+{
+    return QLIST_NEXT(bitmap, list);
 }
=20
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **er=
rp)
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 687087d2bc..99812b418b 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1488,9 +1488,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriv=
erState *bs, Error **errp)
     }
=20
     /* check constraints and names */
-    for (bitmap =3D bdrv_dirty_bitmap_next(bs, NULL); bitmap !=3D NULL;
-         bitmap =3D bdrv_dirty_bitmap_next(bs, bitmap))
-    {
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
         const char *name =3D bdrv_dirty_bitmap_name(bitmap);
         uint32_t granularity =3D bdrv_dirty_bitmap_granularity(bitmap);
         Qcow2Bitmap *bm;
@@ -1610,9 +1608,7 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, E=
rror **errp)
         return -EINVAL;
     }
=20
-    for (bitmap =3D bdrv_dirty_bitmap_next(bs, NULL); bitmap !=3D NULL;
-         bitmap =3D bdrv_dirty_bitmap_next(bs, bitmap))
-    {
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
         if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
             bdrv_dirty_bitmap_set_readonly(bitmap, true);
         }
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitma=
p.c
index 793f249aa5..7eafface61 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -283,9 +283,7 @@ static int init_dirty_bitmap_migration(void)
     for (bs =3D bdrv_next_all_states(NULL); bs; bs =3D bdrv_next_all_sta=
tes(bs)) {
         const char *name =3D bdrv_get_device_or_node_name(bs);
=20
-        for (bitmap =3D bdrv_dirty_bitmap_next(bs, NULL); bitmap;
-             bitmap =3D bdrv_dirty_bitmap_next(bs, bitmap))
-        {
+        FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
             if (!bdrv_dirty_bitmap_name(bitmap)) {
                 continue;
             }
--=20
2.21.0


