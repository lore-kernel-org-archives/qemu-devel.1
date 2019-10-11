Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CB2ECE58D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B6B2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B6B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ2pN-0002yx-JD
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 17:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iJ2Rk-0003jN-Is
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iJ2Rj-0001R9-50
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:27:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iJ2Rf-0001Oj-5A; Fri, 11 Oct 2019 17:27:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 07CE52D0FC7;
 Fri, 11 Oct 2019 21:27:30 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-173.bos.redhat.com [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A566525263;
 Fri, 11 Oct 2019 21:27:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 16/19] block/qcow2-bitmap: fix and improve
 qcow2_reopen_bitmaps_rw
Date: Fri, 11 Oct 2019 17:25:47 -0400
Message-Id: <20191011212550.27269-17-jsnow@redhat.com>
In-Reply-To: <20191011212550.27269-1-jsnow@redhat.com>
References: <20191011212550.27269-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 11 Oct 2019 21:27:30 +0000 (UTC)
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

- Correct check for write access to file child, and in correct place
  (only if we want to write).
- Support reopen rw -> rw (which will be used in following commit),
  for example, !bdrv_dirty_bitmap_readonly() is not a corruption if
  bitmap is marked IN_USE in the image.
- Consider unexpected bitmap as a corruption and check other
  combinations of in-image and in-RAM bitmaps.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190927122355.7344-9-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2-bitmap.c | 77 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 19 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index f7dfb40256e..98294a76965 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1108,18 +1108,14 @@ int qcow2_reopen_bitmaps_rw(BlockDriverState *bs,=
 Error **errp)
     Qcow2BitmapList *bm_list;
     Qcow2Bitmap *bm;
     GSList *ro_dirty_bitmaps =3D NULL;
-    int ret =3D 0;
+    int ret =3D -EINVAL;
+    bool need_header_update =3D false;
=20
     if (s->nb_bitmaps =3D=3D 0) {
         /* No bitmaps - nothing to do */
         return 0;
     }
=20
-    if (!can_write(bs)) {
-        error_setg(errp, "Can't write to the image on reopening bitmaps =
rw");
-        return -EINVAL;
-    }
-
     bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
                                s->bitmap_directory_size, errp);
     if (bm_list =3D=3D NULL) {
@@ -1128,32 +1124,75 @@ int qcow2_reopen_bitmaps_rw(BlockDriverState *bs,=
 Error **errp)
=20
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
         BdrvDirtyBitmap *bitmap =3D bdrv_find_dirty_bitmap(bs, bm->name)=
;
-        if (bitmap =3D=3D NULL) {
-            continue;
-        }
=20
-        if (!bdrv_dirty_bitmap_readonly(bitmap)) {
-            error_setg(errp, "Bitmap %s was loaded prior to rw-reopen, b=
ut was "
-                       "not marked as readonly. This is a bug, something=
 went "
-                       "wrong. All of the bitmaps may be corrupted", bm-=
>name);
-            ret =3D -EINVAL;
+        if (!bitmap) {
+            error_setg(errp, "Unexpected bitmap '%s' in image '%s'",
+                       bm->name, bs->filename);
             goto out;
         }
=20
-        bm->flags |=3D BME_FLAG_IN_USE;
-        ro_dirty_bitmaps =3D g_slist_append(ro_dirty_bitmaps, bitmap);
+        if (!(bm->flags & BME_FLAG_IN_USE)) {
+            if (!bdrv_dirty_bitmap_readonly(bitmap)) {
+                error_setg(errp, "Corruption: bitmap '%s' is not marked =
IN_USE "
+                           "in the image '%s' and not marked readonly in=
 RAM",
+                           bm->name, bs->filename);
+                goto out;
+            }
+            if (bdrv_dirty_bitmap_inconsistent(bitmap)) {
+                error_setg(errp, "Corruption: bitmap '%s' is inconsisten=
t but "
+                           "is not marked IN_USE in the image '%s'", bm-=
>name,
+                           bs->filename);
+                goto out;
+            }
+
+            bm->flags |=3D BME_FLAG_IN_USE;
+            need_header_update =3D true;
+        } else {
+            /*
+             * What if flags already has BME_FLAG_IN_USE ?
+             *
+             * 1. if we are reopening RW -> RW it's OK, of course.
+             * 2. if we are reopening RO -> RW:
+             *   2.1 if @bitmap is inconsistent, it's OK. It means that =
it was
+             *       inconsistent (IN_USE) when we loaded it
+             *   2.2 if @bitmap is not inconsistent. This seems to be im=
possible
+             *       and implies third party interaction. Let's error-ou=
t for
+             *       safety.
+             */
+            if (bdrv_dirty_bitmap_readonly(bitmap) &&
+                !bdrv_dirty_bitmap_inconsistent(bitmap))
+            {
+                error_setg(errp, "Corruption: bitmap '%s' is marked IN_U=
SE "
+                           "in the image '%s' but it is readonly and "
+                           "consistent in RAM",
+                           bm->name, bs->filename);
+                goto out;
+            }
+        }
+
+        if (bdrv_dirty_bitmap_readonly(bitmap)) {
+            ro_dirty_bitmaps =3D g_slist_append(ro_dirty_bitmaps, bitmap=
);
+        }
     }
=20
-    if (ro_dirty_bitmaps !=3D NULL) {
+    if (need_header_update) {
+        if (!can_write(bs->file->bs) || !(bs->file->perm & BLK_PERM_WRIT=
E)) {
+            error_setg(errp, "Failed to reopen bitmaps rw: no write acce=
ss "
+                       "the protocol file");
+            goto out;
+        }
+
         /* in_use flags must be updated */
         ret =3D update_ext_header_and_dir_in_place(bs, bm_list);
         if (ret < 0) {
-            error_setg_errno(errp, -ret, "Can't update bitmap directory"=
);
+            error_setg_errno(errp, -ret, "Cannot update bitmap directory=
");
             goto out;
         }
-        g_slist_foreach(ro_dirty_bitmaps, set_readonly_helper, false);
     }
=20
+    g_slist_foreach(ro_dirty_bitmaps, set_readonly_helper, false);
+    ret =3D 0;
+
 out:
     g_slist_free(ro_dirty_bitmaps);
     bitmap_list_free(bm_list);
--=20
2.21.0


