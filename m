Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B1AECE58D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D70206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D70206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ2cu-0004zh-N6
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 17:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iJ2Rf-0003fG-6s
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iJ2Rd-0001OO-3K
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:27:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iJ2RY-0001Le-N4; Fri, 11 Oct 2019 17:27:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E27E13003A49;
 Fri, 11 Oct 2019 21:27:23 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-173.bos.redhat.com [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23338261AA;
 Fri, 11 Oct 2019 21:27:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 12/19] block/qcow2-bitmap: get rid of
 bdrv_has_changed_persistent_bitmaps
Date: Fri, 11 Oct 2019 17:25:43 -0400
Message-Id: <20191011212550.27269-13-jsnow@redhat.com>
In-Reply-To: <20191011212550.27269-1-jsnow@redhat.com>
References: <20191011212550.27269-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 11 Oct 2019 21:27:23 +0000 (UTC)
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

Firstly, no reason to optimize failure path. Then, function name is
ambiguous: it checks for readonly and similar things, but someone may
think that it will ignore normal bitmaps which was just unchanged, and
this is in bad relation with the fact that we should drop IN_USE flag
for unchanged bitmaps in the image.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20190927122355.7344-5-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/block/dirty-bitmap.h |  1 -
 block/dirty-bitmap.c         | 12 ------------
 block/qcow2-bitmap.c         | 23 +++++++++++++----------
 3 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 257f0f67046..958e7474fb5 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -95,7 +95,6 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_get_persistence(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_inconsistent(const BdrvDirtyBitmap *bitmap);
-bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
=20
 BdrvDirtyBitmap *bdrv_dirty_bitmap_first(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 6065db80949..4bbb251b2c9 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -839,18 +839,6 @@ bool bdrv_dirty_bitmap_inconsistent(const BdrvDirtyB=
itmap *bitmap)
     return bitmap->inconsistent;
 }
=20
-bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)
-{
-    BdrvDirtyBitmap *bm;
-    QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
-        if (bm->persistent && !bm->readonly && !bm->skip_store) {
-            return true;
-        }
-    }
-
-    return false;
-}
-
 BdrvDirtyBitmap *bdrv_dirty_bitmap_first(BlockDriverState *bs)
 {
     return QLIST_FIRST(&bs->dirty_bitmaps);
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 99812b418b8..6dfc0835485 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1464,16 +1464,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDri=
verState *bs, Error **errp)
     Qcow2Bitmap *bm;
     QSIMPLEQ_HEAD(, Qcow2BitmapTable) drop_tables;
     Qcow2BitmapTable *tb, *tb_next;
-
-    if (!bdrv_has_changed_persistent_bitmaps(bs)) {
-        /* nothing to do */
-        return;
-    }
-
-    if (!can_write(bs)) {
-        error_setg(errp, "No write access");
-        return;
-    }
+    bool need_write =3D false;
=20
     QSIMPLEQ_INIT(&drop_tables);
=20
@@ -1499,6 +1490,8 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriv=
erState *bs, Error **errp)
             continue;
         }
=20
+        need_write =3D true;
+
         if (check_constraints_on_bitmap(bs, name, granularity, errp) < 0=
) {
             error_prepend(errp, "Bitmap '%s' doesn't satisfy the constra=
ints: ",
                           name);
@@ -1537,6 +1530,15 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDri=
verState *bs, Error **errp)
         bm->dirty_bitmap =3D bitmap;
     }
=20
+    if (!need_write) {
+        goto success;
+    }
+
+    if (!can_write(bs)) {
+        error_setg(errp, "No write access");
+        goto fail;
+    }
+
     /* allocate clusters and store bitmaps */
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
         if (bm->dirty_bitmap =3D=3D NULL) {
@@ -1578,6 +1580,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriv=
erState *bs, Error **errp)
         bdrv_release_dirty_bitmap(bm->dirty_bitmap);
     }
=20
+success:
     bitmap_list_free(bm_list);
     return;
=20
--=20
2.21.0


