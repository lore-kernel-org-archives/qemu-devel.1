Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014CCC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 20:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF57208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 20:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF57208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52726 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZLDK-00028y-MI
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 16:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56073)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZJwM-0003bE-AC
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:50:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZJwJ-0005hc-Vw
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:50:14 -0400
Received: from relay.sw.ru ([185.231.240.75]:50914)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hZJwH-0003N3-Vj; Fri, 07 Jun 2019 14:50:11 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.91)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hZJuF-00018q-5Y; Fri, 07 Jun 2019 21:48:03 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri,  7 Jun 2019 21:48:02 +0300
Message-Id: <20190607184802.100945-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH] qcow2-bitmaps: fix
 qcow2_can_store_new_dirty_bitmap
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qcow2_can_store_new_dirty_bitmap works wrong, as it considers only
bitmaps already stored in the qcow2 image and ignores persistent
BdrvDirtyBitmap objects.

So, let's instead count persistent BdrvDirtyBitmaps. We load all qcow2
bitmaps on open, so there should not be any bitmap in the image for
which we don't have BdrvDirtyBitmaps version. If it is - it's a kind of
corruption, and no reason to check for corruptions here (open() and
close() are better places for it).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi!

Patch is better than discussing I thing, so here is my counter-suggestion for
"[PATCH 0/5] block/dirty-bitmap: check number and size constraints against queued bitmaps"
by John.

It's of course needs some additional refactoring, as first assert shows bad design,
I just wrote it in such manner to make minimum changes to fix the bug.

Of course,
Reported-by: aihua liang <aliang@redhat.com>
may be applied here (if I understood correctly), and I hope that
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1712636
too.

 block/qcow2-bitmap.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index b2487101ed..7d1b3eeb2b 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1619,8 +1619,11 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
                                       Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
-    bool found;
-    Qcow2BitmapList *bm_list;
+    BdrvDirtyBitmap *bitmap;
+    uint64_t bitmap_directory_size = 0;
+    uint32_t nb_bitmaps = 0;
+
+    assert(!bdrv_find_dirty_bitmap(bs, name));
 
     if (s->qcow_version < 3) {
         /* Without autoclear_features, we would always have to assume
@@ -1636,36 +1639,29 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
         goto fail;
     }
 
-    if (s->nb_bitmaps == 0) {
-        return true;
+    for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap != NULL;
+         bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
+    {
+        if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
+            nb_bitmaps++;
+            bitmap_directory_size +=
+                calc_dir_entry_size(strlen(bdrv_dirty_bitmap_name(bitmap)), 0);
+        }
     }
+    nb_bitmaps++;
+    bitmap_directory_size += calc_dir_entry_size(strlen(name), 0);
 
-    if (s->nb_bitmaps >= QCOW2_MAX_BITMAPS) {
+    if (nb_bitmaps > QCOW2_MAX_BITMAPS) {
         error_setg(errp,
                    "Maximum number of persistent bitmaps is already reached");
         goto fail;
     }
 
-    if (s->bitmap_directory_size + calc_dir_entry_size(strlen(name), 0) >
-        QCOW2_MAX_BITMAP_DIRECTORY_SIZE)
-    {
+    if (bitmap_directory_size > QCOW2_MAX_BITMAP_DIRECTORY_SIZE) {
         error_setg(errp, "Not enough space in the bitmap directory");
         goto fail;
     }
 
-    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, errp);
-    if (bm_list == NULL) {
-        goto fail;
-    }
-
-    found = find_bitmap_by_name(bm_list, name);
-    bitmap_list_free(bm_list);
-    if (found) {
-        error_setg(errp, "Bitmap with the same name is already stored");
-        goto fail;
-    }
-
     return true;
 
 fail:
-- 
2.18.0


