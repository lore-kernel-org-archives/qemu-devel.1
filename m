Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34F2C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6773A20868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6773A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYy13-00058m-NC
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 15:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53577)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hYxlF-0004e6-Tu
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 15:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hYxLU-0000Rk-5h
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 14:42:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46740)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hYxLG-0007o5-OE; Thu, 06 Jun 2019 14:42:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D9490307D840;
 Thu,  6 Jun 2019 18:42:05 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-177.bos.redhat.com [10.18.17.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E58615C2EC;
 Thu,  6 Jun 2019 18:42:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 14:41:55 -0400
Message-Id: <20190606184159.979-2-jsnow@redhat.com>
In-Reply-To: <20190606184159.979-1-jsnow@redhat.com>
References: <20190606184159.979-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 06 Jun 2019 18:42:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/5] block/qcow2-bitmap: allow bitmap_list_load
 to return an error code
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

This simply makes this function a little more convenient to call, and in
a forthcoming patch gives us a return code we can report to the
caller. (Which in turn makes THOSE functions easier to call.)

While we're here, remove the offset+size arguments which are only ever
called with the same values that can be determined inside this helper.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2-bitmap.c | 64 +++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 36 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index b2487101ed..83aee1a42a 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -547,30 +547,33 @@ static uint32_t bitmap_list_count(Qcow2BitmapList *=
bm_list)
  * Get bitmap list from qcow2 image. Actually reads bitmap directory,
  * checks it and convert to bitmap list.
  */
-static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, uint64_t =
offset,
-                                         uint64_t size, Error **errp)
+static int bitmap_list_load(BlockDriverState *bs, Qcow2BitmapList **bm_l=
ist_out,
+                            Error **errp)
 {
-    int ret;
+    int ret =3D 0;
     BDRVQcow2State *s =3D bs->opaque;
     uint8_t *dir, *dir_end;
     Qcow2BitmapDirEntry *e;
     uint32_t nb_dir_entries =3D 0;
     Qcow2BitmapList *bm_list =3D NULL;
=20
+    uint64_t offset =3D s->bitmap_directory_offset;
+    uint64_t size =3D s->bitmap_directory_size;
+
     if (size =3D=3D 0) {
-        error_setg(errp, "Requested bitmap directory size is zero");
-        return NULL;
+        error_setg(errp, "Cannot load a bitmap directory of size 0");
+        return -EINVAL;
     }
=20
     if (size > QCOW2_MAX_BITMAP_DIRECTORY_SIZE) {
         error_setg(errp, "Requested bitmap directory size is too big");
-        return NULL;
+        return -EINVAL;
     }
=20
     dir =3D g_try_malloc(size);
     if (dir =3D=3D NULL) {
         error_setg(errp, "Failed to allocate space for bitmap directory"=
);
-        return NULL;
+        return -ENOMEM;
     }
     dir_end =3D dir + size;
=20
@@ -594,6 +597,7 @@ static Qcow2BitmapList *bitmap_list_load(BlockDriverS=
tate *bs, uint64_t offset,
         if (++nb_dir_entries > s->nb_bitmaps) {
             error_setg(errp, "More bitmaps found than specified in heade=
r"
                        " extension");
+            ret =3D -EINVAL;
             goto fail;
         }
         bitmap_dir_entry_to_cpu(e);
@@ -604,6 +608,7 @@ static Qcow2BitmapList *bitmap_list_load(BlockDriverS=
tate *bs, uint64_t offset,
=20
         if (e->extra_data_size !=3D 0) {
             error_setg(errp, "Bitmap extra data is not supported");
+            ret =3D -ENOTSUP;
             goto fail;
         }
=20
@@ -626,6 +631,7 @@ static Qcow2BitmapList *bitmap_list_load(BlockDriverS=
tate *bs, uint64_t offset,
     if (nb_dir_entries !=3D s->nb_bitmaps) {
         error_setg(errp, "Less bitmaps found than specified in header"
                          " extension");
+        ret =3D -EINVAL;
         goto fail;
     }
=20
@@ -634,7 +640,8 @@ static Qcow2BitmapList *bitmap_list_load(BlockDriverS=
tate *bs, uint64_t offset,
     }
=20
     g_free(dir);
-    return bm_list;
+    *bm_list_out =3D bm_list;
+    return ret;
=20
 broken_dir:
     ret =3D -EINVAL;
@@ -644,7 +651,7 @@ fail:
     g_free(dir);
     bitmap_list_free(bm_list);
=20
-    return NULL;
+    return ret;
 }
=20
 int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult =
*res,
@@ -667,11 +674,10 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState =
*bs, BdrvCheckResult *res,
         return ret;
     }
=20
-    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, NULL);
-    if (bm_list =3D=3D NULL) {
+    ret =3D bitmap_list_load(bs, &bm_list, NULL);
+    if (ret) {
         res->corruptions++;
-        return -EINVAL;
+        return ret;
     }
=20
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
@@ -971,9 +977,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, E=
rror **errp)
         return false;
     }
=20
-    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, errp);
-    if (bm_list =3D=3D NULL) {
+    if (bitmap_list_load(bs, &bm_list, errp)) {
         return false;
     }
=20
@@ -1080,9 +1084,7 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(Blo=
ckDriverState *bs,
         return NULL;
     }
=20
-    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, errp);
-    if (bm_list =3D=3D NULL) {
+    if (bitmap_list_load(bs, &bm_list, errp)) {
         return NULL;
     }
=20
@@ -1125,10 +1127,8 @@ int qcow2_reopen_bitmaps_rw_hint(BlockDriverState =
*bs, bool *header_updated,
         return -EINVAL;
     }
=20
-    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, errp);
-    if (bm_list =3D=3D NULL) {
-        return -EINVAL;
+    if ((ret =3D bitmap_list_load(bs, &bm_list, errp))) {
+        return ret;
     }
=20
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
@@ -1186,10 +1186,8 @@ int qcow2_truncate_bitmaps_check(BlockDriverState =
*bs, Error **errp)
         return 0;
     }
=20
-    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, errp);
-    if (bm_list =3D=3D NULL) {
-        return -EINVAL;
+    if ((ret =3D bitmap_list_load(bs, &bm_list, errp))) {
+        return ret;
     }
=20
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
@@ -1419,9 +1417,7 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriv=
erState *bs,
         return;
     }
=20
-    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, errp);
-    if (bm_list =3D=3D NULL) {
+    if (bitmap_list_load(bs, &bm_list, errp)) {
         return;
     }
=20
@@ -1472,9 +1468,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriv=
erState *bs, Error **errp)
     if (s->nb_bitmaps =3D=3D 0) {
         bm_list =3D bitmap_list_new();
     } else {
-        bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
-                                   s->bitmap_directory_size, errp);
-        if (bm_list =3D=3D NULL) {
+        if (bitmap_list_load(bs, &bm_list, errp)) {
             return;
         }
     }
@@ -1653,9 +1647,7 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverSt=
ate *bs,
         goto fail;
     }
=20
-    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, errp);
-    if (bm_list =3D=3D NULL) {
+    if (bitmap_list_load(bs, &bm_list, errp)) {
         goto fail;
     }
=20
--=20
2.20.1


