Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27100C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D715C217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D715C217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDrU8-0003Fs-GL
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDqCu-0003lr-Nm
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDqCt-0000Pb-9c
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:22:48 -0400
Received: from relay.sw.ru ([185.231.240.75]:49752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDqCq-0000IU-Ay; Fri, 27 Sep 2019 09:22:44 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDpHz-0003za-91; Fri, 27 Sep 2019 15:23:59 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 8/9] block/qcow2-bitmap: fix and improve
 qcow2_reopen_bitmaps_rw
Date: Fri, 27 Sep 2019 15:23:54 +0300
Message-Id: <20190927122355.7344-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927122355.7344-1-vsementsov@virtuozzo.com>
References: <20190927122355.7344-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- Correct check for write access to file child, and in correct place
  (only if we want to write).
- Support reopen rw -> rw (which will be used in following commit),
  for example, !bdrv_dirty_bitmap_readonly() is not a corruption if
  bitmap is marked IN_USE in the image.
- Consider unexpected bitmap as a corruption and check other
  combinations of in-image and in-RAM bitmaps.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-bitmap.c | 77 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 19 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index a636dc50ca..6335d85244 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1108,18 +1108,14 @@ int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
     Qcow2BitmapList *bm_list;
     Qcow2Bitmap *bm;
     GSList *ro_dirty_bitmaps = NULL;
-    int ret = 0;
+    int ret = -EINVAL;
+    bool need_header_update = false;
 
     if (s->nb_bitmaps == 0) {
         /* No bitmaps - nothing to do */
         return 0;
     }
 
-    if (!can_write(bs)) {
-        error_setg(errp, "Can't write to the image on reopening bitmaps rw");
-        return -EINVAL;
-    }
-
     bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
                                s->bitmap_directory_size, errp);
     if (bm_list == NULL) {
@@ -1128,32 +1124,75 @@ int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
 
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
         BdrvDirtyBitmap *bitmap = bdrv_find_dirty_bitmap(bs, bm->name);
-        if (bitmap == NULL) {
-            continue;
-        }
 
-        if (!bdrv_dirty_bitmap_readonly(bitmap)) {
-            error_setg(errp, "Bitmap %s was loaded prior to rw-reopen, but was "
-                       "not marked as readonly. This is a bug, something went "
-                       "wrong. All of the bitmaps may be corrupted", bm->name);
-            ret = -EINVAL;
+        if (!bitmap) {
+            error_setg(errp, "Unexpected bitmap '%s' in image '%s'",
+                       bm->name, bs->filename);
             goto out;
         }
 
-        bm->flags |= BME_FLAG_IN_USE;
-        ro_dirty_bitmaps = g_slist_append(ro_dirty_bitmaps, bitmap);
+        if (!(bm->flags & BME_FLAG_IN_USE)) {
+            if (!bdrv_dirty_bitmap_readonly(bitmap)) {
+                error_setg(errp, "Corruption: bitmap '%s' is not marked IN_USE "
+                           "in the image '%s' and not marked readonly in RAM",
+                           bm->name, bs->filename);
+                goto out;
+            }
+            if (bdrv_dirty_bitmap_inconsistent(bitmap)) {
+                error_setg(errp, "Corruption: bitmap '%s' is inconsistent but "
+                           "is not marked IN_USE in the image '%s'", bm->name,
+                           bs->filename);
+                goto out;
+            }
+
+            bm->flags |= BME_FLAG_IN_USE;
+            need_header_update = true;
+        } else {
+            /*
+             * What if flags already has BME_FLAG_IN_USE ?
+             *
+             * 1. if we are reopening RW -> RW it's OK, of course.
+             * 2. if we are reopening RO -> RW:
+             *   2.1 if @bitmap is inconsistent, it's OK. It means that it was
+             *       inconsistent (IN_USE) when we loaded it
+             *   2.2 if @bitmap is not inconsistent. This seems to be impossible
+             *       and implies third party interaction. Let's error-out for
+             *       safety.
+             */
+            if (bdrv_dirty_bitmap_readonly(bitmap) &&
+                !bdrv_dirty_bitmap_inconsistent(bitmap))
+            {
+                error_setg(errp, "Corruption: bitmap '%s' is marked IN_USE "
+                           "in the image '%s' but it is readonly and "
+                           "consistent in RAM",
+                           bm->name, bs->filename);
+                goto out;
+            }
+        }
+
+        if (bdrv_dirty_bitmap_readonly(bitmap)) {
+            ro_dirty_bitmaps = g_slist_append(ro_dirty_bitmaps, bitmap);
+        }
     }
 
-    if (ro_dirty_bitmaps != NULL) {
+    if (need_header_update) {
+        if (!can_write(bs->file->bs) || !(bs->file->perm & BLK_PERM_WRITE)) {
+            error_setg(errp, "Failed to reopen bitmaps rw: no write access "
+                       "the protocol file");
+            goto out;
+        }
+
         /* in_use flags must be updated */
         ret = update_ext_header_and_dir_in_place(bs, bm_list);
         if (ret < 0) {
-            error_setg_errno(errp, -ret, "Can't update bitmap directory");
+            error_setg_errno(errp, -ret, "Cannot update bitmap directory");
             goto out;
         }
-        g_slist_foreach(ro_dirty_bitmaps, set_readonly_helper, false);
     }
 
+    g_slist_foreach(ro_dirty_bitmaps, set_readonly_helper, false);
+    ret = 0;
+
 out:
     g_slist_free(ro_dirty_bitmaps);
     bitmap_list_free(bm_list);
-- 
2.21.0


