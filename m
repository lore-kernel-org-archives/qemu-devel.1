Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7059AC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B10420868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B10420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55492 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYy0N-00051C-H9
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 15:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53567)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hYxlN-0004dY-2q
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 15:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hYxLI-0000D6-Lp
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 14:42:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hYxLE-0007ii-KO; Thu, 06 Jun 2019 14:42:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2337530821EC;
 Thu,  6 Jun 2019 18:42:09 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-177.bos.redhat.com [10.18.17.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3014CBABF;
 Thu,  6 Jun 2019 18:42:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 14:41:58 -0400
Message-Id: <20190606184159.979-5-jsnow@redhat.com>
In-Reply-To: <20190606184159.979-1-jsnow@redhat.com>
References: <20190606184159.979-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 06 Jun 2019 18:42:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/5] block/qcow2-bitmap: Count queued bitmaps
 towards nb_bitmaps
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

When we check to see if we can store a bitmap, we don't check how many
we've queued up. This can cause a problem saving bitmaps on close
instead of when we request them to be added. With the stricter add
interface, prohibit these bitmaps specifically.

To match, make the remove interface more strict as well; now rejecting
any requests to remove bitmaps that were never queued for storage.

We don't need to "find" the bitmap when the interface has been given the
bitmap explicitly, but this is done to make sure that the bitmap given
actually does belong to the bs we were passed as a paranoia check to
enforce consistency.

---

"What about directory size?" Please see the following patch.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.h        |  1 +
 block/dirty-bitmap.c |  8 +++-----
 block/qcow2-bitmap.c | 31 ++++++++++++++++++++++++++-----
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index ce07f003f7..ebf60ac236 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -317,6 +317,7 @@ typedef struct BDRVQcow2State {
     QCowSnapshot *snapshots;
=20
     uint32_t nb_bitmaps;
+    uint32_t nb_queued_bitmaps;
     uint64_t bitmap_directory_size;
     uint64_t bitmap_directory_offset;
=20
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 4667f9e65a..084c42af57 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -450,11 +450,9 @@ void bdrv_release_named_dirty_bitmaps(BlockDriverSta=
te *bs)
 }
=20
 /**
- * Remove persistent dirty bitmap from the storage if it exists.
- * Absence of bitmap is not an error, because we have the following scen=
ario:
- * BdrvDirtyBitmap can have .persistent =3D true but not yet saved and h=
ave no
- * stored version. For such bitmap bdrv_remove_persistent_dirty_bitmap()=
 should
- * not fail.
+ * Remove a persistent dirty bitmap from storage,
+ * or dequeue it from being stored if it is enqueued.
+ *
  * This function doesn't release the corresponding BdrvDirtyBitmap.
  */
 int bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 930a6c91ff..7193c66787 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1402,6 +1402,23 @@ static Qcow2Bitmap *find_bitmap_by_name(Qcow2Bitma=
pList *bm_list,
     return NULL;
 }
=20
+static int qcow2_remove_queued_dirty_bitmap(
+    BlockDriverState *bs, const char *name, Error **errp)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    BdrvDirtyBitmap *bitmap =3D bdrv_find_dirty_bitmap(bs, name);
+    if (!bitmap) {
+        error_setg(errp, "Node '%s' has no stored or enqueued bitmap '%s=
'",
+                   bdrv_get_node_name(bs), name);
+        return -ENOENT;
+    }
+    assert(s->nb_queued_bitmaps > 0);
+    assert(bdrv_dirty_bitmap_get_persistence(bitmap));
+    s->nb_queued_bitmaps -=3D 1;
+
+    return 0;
+}
+
 int qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                          BdrvDirtyBitmap *bitmap,
                                          Error **errp)
@@ -1413,9 +1430,7 @@ int qcow2_remove_persistent_dirty_bitmap(BlockDrive=
rState *bs,
     const char *name =3D bdrv_dirty_bitmap_name(bitmap);
=20
     if (s->nb_bitmaps =3D=3D 0) {
-        /* Absence of the bitmap is not an error: see explanation above
-         * bdrv_remove_persistent_dirty_bitmap() definition. */
-        return 0;
+        return qcow2_remove_queued_dirty_bitmap(bs, name, errp);
     }
=20
     if ((ret =3D bitmap_list_load(bs, &bm_list, errp))) {
@@ -1424,6 +1439,7 @@ int qcow2_remove_persistent_dirty_bitmap(BlockDrive=
rState *bs,
=20
     bm =3D find_bitmap_by_name(bm_list, name);
     if (bm =3D=3D NULL) {
+        ret =3D qcow2_remove_queued_dirty_bitmap(bs, name, errp);
         goto fail;
     }
=20
@@ -1544,6 +1560,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriv=
erState *bs, Error **errp)
         error_setg_errno(errp, -ret, "Failed to update bitmap extension"=
);
         goto fail;
     }
+    s->nb_queued_bitmaps =3D 0;
=20
     /* Bitmap directory was successfully updated, so, old data can be dr=
opped.
      * TODO it is better to reuse these clusters */
@@ -1618,6 +1635,7 @@ int qcow2_add_persistent_dirty_bitmap(BlockDriverSt=
ate *bs,
     Qcow2BitmapList *bm_list;
     const char *name =3D bdrv_dirty_bitmap_name(bitmap);
     uint32_t granularity =3D bdrv_dirty_bitmap_granularity(bitmap);
+    uint32_t nb_bitmaps;
     int ret =3D 0;
=20
     if (s->qcow_version < 3) {
@@ -1636,11 +1654,12 @@ int qcow2_add_persistent_dirty_bitmap(BlockDriver=
State *bs,
         goto fail;
     }
=20
-    if (s->nb_bitmaps =3D=3D 0) {
+    nb_bitmaps =3D s->nb_bitmaps + s->nb_queued_bitmaps;
+    if (nb_bitmaps =3D=3D 0) {
         return 0;
     }
=20
-    if (s->nb_bitmaps >=3D QCOW2_MAX_BITMAPS) {
+    if (nb_bitmaps >=3D QCOW2_MAX_BITMAPS) {
         error_setg(errp,
                    "Maximum number of persistent bitmaps is already reac=
hed");
         ret =3D -EOVERFLOW;
@@ -1667,6 +1686,8 @@ int qcow2_add_persistent_dirty_bitmap(BlockDriverSt=
ate *bs,
         goto fail;
     }
=20
+    s->nb_queued_bitmaps +=3D 1;
+
     return 0;
 fail:
     error_prepend(errp, "Can't make bitmap '%s' persistent in '%s': ",
--=20
2.20.1


