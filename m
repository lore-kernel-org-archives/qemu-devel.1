Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473E1C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B92521E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B92521E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMhy-0004Wo-AJ
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36638)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvMg8-0007nt-Ks
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvMg7-0003Kk-EL
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:12:36 -0400
Received: from relay.sw.ru ([185.231.240.75]:40638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvMg4-0003D0-Bh; Wed, 07 Aug 2019 10:12:32 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvMg0-0005oH-8Q; Wed, 07 Aug 2019 17:12:28 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed,  7 Aug 2019 17:12:25 +0300
Message-Id: <20190807141226.193501-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807141226.193501-1-vsementsov@virtuozzo.com>
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v4 09/10] block/qcow2-bitmap: fix and improve
 qcow2_reopen_bitmaps_rw
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
 block/qcow2-bitmap.c | 56 +++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index a636dc50ca..e276a95154 100644
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
@@ -1128,32 +1124,54 @@ int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
 
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
+            error_setg(errp, "Unexpected bitmap '%s' in the image '%s'",
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
2.18.0


