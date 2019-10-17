Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D50FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2547C21D7A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2547C21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLDyV-0000gF-GR
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 18:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iLDk3-0007cr-Mh
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iLDk2-0002gn-7i
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:55:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52568)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iLDjy-0002eL-5b; Thu, 17 Oct 2019 17:55:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56AF73086E20;
 Thu, 17 Oct 2019 21:55:25 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-173.bos.redhat.com [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F01F05D9CA;
 Thu, 17 Oct 2019 21:55:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, jsnow@redhat.com,
 qemu-devel@nongnu.org
Subject: [PULL v3 14/19] block/qcow2-bitmap: do not remove bitmaps on reopen-ro
Date: Thu, 17 Oct 2019 17:54:31 -0400
Message-Id: <20191017215436.14252-15-jsnow@redhat.com>
In-Reply-To: <20191017215436.14252-1-jsnow@redhat.com>
References: <20191017215436.14252-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 17 Oct 2019 21:55:25 +0000 (UTC)
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

qcow2_reopen_bitmaps_ro wants to store bitmaps and then mark them all
readonly. But the latter don't work, as
qcow2_store_persistent_dirty_bitmaps removes bitmaps after storing.
It's OK for inactivation but bad idea for reopen-ro. And this leads to
the following bug:

Assume we have persistent bitmap 'bitmap0'.
Create external snapshot
  bitmap0 is stored and therefore removed
Commit snapshot
  now we have no bitmaps
Do some writes from guest (*)
  they are not marked in bitmap
Shutdown
Start
  bitmap0 is loaded as valid, but it is actually broken! It misses
  writes (*)
Incremental backup
  it will be inconsistent

So, let's stop removing bitmaps on reopen-ro. But don't rejoice:
reopening bitmaps to rw is broken too, so the whole scenario will not
work after this patch and we can't enable corresponding test cases in
260 iotests still. Reopening bitmaps rw will be fixed in the following
patches.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20190927122355.7344-7-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.h        |  3 ++-
 block/qcow2-bitmap.c | 49 ++++++++++++++++++++++++++++++--------------
 block/qcow2.c        |  2 +-
 3 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 23a9898a54..5cccd87162 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -742,7 +742,8 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(Block=
DriverState *bs,
                                                 Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
-void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **=
errp);
+void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
+                                          bool release_stored, Error **e=
rrp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
 bool qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
                                          const char *name,
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index ebc1afccd3..f7dfb40256 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1440,7 +1440,32 @@ out:
     return ret;
 }
=20
-void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **=
errp)
+/*
+ * qcow2_store_persistent_dirty_bitmaps
+ *
+ * Stores persistent BdrvDirtyBitmap objects.
+ *
+ * @release_stored: if true, release BdrvDirtyBitmap's after storing to =
the
+ * image. This is used in two cases, both via qcow2_inactivate:
+ * 1. bdrv_close: It's correct to remove bitmaps on close.
+ * 2. migration: If bitmaps are migrated through migration channel via
+ *    'dirty-bitmaps' migration capability they are not handled by this =
code.
+ *    Otherwise, it's OK to drop BdrvDirtyBitmap's and reload them on
+ *    invalidation.
+ *
+ * Anyway, it's correct to remove BdrvDirtyBitmap's on inactivation, as
+ * inactivation means that we lose control on disk, and therefore on bit=
maps,
+ * we should sync them and do not touch more.
+ *
+ * Contrariwise, we don't want to release any bitmaps on just reopen-to-=
ro,
+ * when we need to store them, as image is still under our control, and =
it's
+ * good to keep all the bitmaps in read-only mode. Moreover, keeping the=
m
+ * read-only is correct because this is what would happen if we opened t=
he node
+ * readonly to begin with, and whether we opened directly or reopened to=
 that
+ * state shouldn't matter for the state we get afterward.
+ */
+void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
+                                          bool release_stored, Error **e=
rrp)
 {
     BdrvDirtyBitmap *bitmap;
     BDRVQcow2State *s =3D bs->opaque;
@@ -1551,20 +1576,14 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDr=
iverState *bs, Error **errp)
         g_free(tb);
     }
=20
-    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        /* For safety, we remove bitmap after storing.
-         * We may be here in two cases:
-         * 1. bdrv_close. It's ok to drop bitmap.
-         * 2. inactivation. It means migration without 'dirty-bitmaps'
-         *    capability, so bitmaps are not marked with
-         *    BdrvDirtyBitmap.migration flags. It's not bad to drop them=
 too,
-         *    and reload on invalidation.
-         */
-        if (bm->dirty_bitmap =3D=3D NULL) {
-            continue;
-        }
+    if (release_stored) {
+        QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+            if (bm->dirty_bitmap =3D=3D NULL) {
+                continue;
+            }
=20
-        bdrv_release_dirty_bitmap(bm->dirty_bitmap);
+            bdrv_release_dirty_bitmap(bm->dirty_bitmap);
+        }
     }
=20
 success:
@@ -1592,7 +1611,7 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, E=
rror **errp)
     BdrvDirtyBitmap *bitmap;
     Error *local_err =3D NULL;
=20
-    qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
+    qcow2_store_persistent_dirty_bitmaps(bs, false, &local_err);
     if (local_err !=3D NULL) {
         error_propagate(errp, local_err);
         return -EINVAL;
diff --git a/block/qcow2.c b/block/qcow2.c
index 7062eccaee..53a025703e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2503,7 +2503,7 @@ static int qcow2_inactivate(BlockDriverState *bs)
     int ret, result =3D 0;
     Error *local_err =3D NULL;
=20
-    qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
+    qcow2_store_persistent_dirty_bitmaps(bs, true, &local_err);
     if (local_err !=3D NULL) {
         result =3D -EINVAL;
         error_reportf_err(local_err, "Lost persistent bitmaps during "
--=20
2.21.0


