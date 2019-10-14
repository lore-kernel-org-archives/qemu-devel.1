Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F21C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E48E2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E48E2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyuW-0000j9-Vv
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJysx-0008AQ-I5
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJysw-0005lE-AZ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:51:35 -0400
Received: from relay.sw.ru ([185.231.240.75]:57684)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iJyst-0005eV-Oo; Mon, 14 Oct 2019 07:51:31 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iJysp-0002Oa-Tn; Mon, 14 Oct 2019 14:51:28 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 1/2] qcow2-bitmaps: fix qcow2_can_store_new_dirty_bitmap
Date: Mon, 14 Oct 2019 14:51:25 +0300
Message-Id: <20191014115126.15360-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191014115126.15360-1-vsementsov@virtuozzo.com>
References: <20191014115126.15360-1-vsementsov@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
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
 block/qcow2-bitmap.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 98294a7696..d5131181a3 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1671,8 +1671,14 @@ bool coroutine_fn qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
                                                       Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
-    bool found;
-    Qcow2BitmapList *bm_list;
+    BdrvDirtyBitmap *bitmap;
+    uint64_t bitmap_directory_size = 0;
+    uint32_t nb_bitmaps = 0;
+
+    if (bdrv_find_dirty_bitmap(bs, name)) {
+        error_setg(errp, "Bitmap already exists: %s", name);
+        return false;
+    }
 
     if (s->qcow_version < 3) {
         /* Without autoclear_features, we would always have to assume
@@ -1688,38 +1694,27 @@ bool coroutine_fn qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
         goto fail;
     }
 
-    if (s->nb_bitmaps == 0) {
-        return true;
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
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
 
-    qemu_co_mutex_lock(&s->lock);
-    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, errp);
-    qemu_co_mutex_unlock(&s->lock);
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
2.21.0


