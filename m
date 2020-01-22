Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A61C33CB6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F60B2467B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F60B2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42055 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuG14-00012m-HA
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 08:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iuFyx-0006nO-9i
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iuFyv-0002N6-QF
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:23:43 -0500
Received: from relay.sw.ru ([185.231.240.75]:42292)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iuFys-0002Hy-GT; Wed, 22 Jan 2020 08:23:38 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iuFyk-00057B-1u; Wed, 22 Jan 2020 16:23:30 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/7] migration/block-dirty-bitmap: keep bitmap state for all
 bitmaps
Date: Wed, 22 Jan 2020 16:23:25 +0300
Message-Id: <20200122132328.31156-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200122132328.31156-1-vsementsov@virtuozzo.com>
References: <20200122132328.31156-1-vsementsov@virtuozzo.com>
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Keep bitmap state for disabled bitmaps too. Keep the state until the
end of the process. It's needed for the following commit to implement
bitmap postcopy canceling.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 59 ++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index eeaab2174e..f96458113c 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -131,6 +131,7 @@ typedef struct DirtyBitmapLoadBitmapState {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
     bool migrated;
+    bool enabled;
 } DirtyBitmapLoadBitmapState;
 
 typedef struct DirtyBitmapLoadState {
@@ -140,8 +141,11 @@ typedef struct DirtyBitmapLoadState {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
 
-    GSList *enabled_bitmaps;
-    QemuMutex lock; /* protect enabled_bitmaps */
+    bool bitmaps_enabled; /* set in dirty_bitmap_mig_before_vm_start */
+    bool stream_ended; /* set when all migrated data handled */
+
+    GSList *bitmaps;
+    QemuMutex lock; /* protect bitmaps */
 } DirtyBitmapLoadState;
 static DirtyBitmapLoadState dbm_load_state;
 
@@ -446,6 +450,7 @@ static int dirty_bitmap_load_start(QEMUFile *f)
     Error *local_err = NULL;
     uint32_t granularity = qemu_get_be32(f);
     uint8_t flags = qemu_get_byte(f);
+    DirtyBitmapLoadBitmapState *b;
 
     if (s->bitmap) {
         error_report("Bitmap with the same name ('%s') already exists on "
@@ -472,22 +477,23 @@ static int dirty_bitmap_load_start(QEMUFile *f)
 
     bdrv_disable_dirty_bitmap(s->bitmap);
     if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
-        DirtyBitmapLoadBitmapState *b;
-
         bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
         if (local_err) {
             error_report_err(local_err);
             return -EINVAL;
         }
-
-        b = g_new(DirtyBitmapLoadBitmapState, 1);
-        b->bs = s->bs;
-        b->bitmap = s->bitmap;
-        b->migrated = false;
-        dbm_load_state.enabled_bitmaps =
-            g_slist_prepend(dbm_load_state.enabled_bitmaps, b);
     }
 
+    b = g_new(DirtyBitmapLoadBitmapState, 1);
+    *b = (DirtyBitmapLoadBitmapState) {
+        .bs = s->bs,
+        .bitmap = s->bitmap,
+        .migrated = false,
+        .enabled = flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED,
+    };
+
+    dbm_load_state.bitmaps = g_slist_prepend(dbm_load_state.bitmaps, b);
+
     return 0;
 }
 
@@ -497,22 +503,25 @@ void dirty_bitmap_mig_before_vm_start(void)
 
     qemu_mutex_lock(&dbm_load_state.lock);
 
-    for (item = dbm_load_state.enabled_bitmaps; item;
-         item = g_slist_next(item))
-    {
+    for (item = dbm_load_state.bitmaps; item; item = g_slist_next(item)) {
         DirtyBitmapLoadBitmapState *b = item->data;
 
+        if (!b->enabled) {
+            continue;
+        }
+
         if (b->migrated) {
             bdrv_enable_dirty_bitmap_locked(b->bitmap);
         } else {
             bdrv_dirty_bitmap_enable_successor(b->bitmap);
         }
-
-        g_free(b);
     }
 
-    g_slist_free(dbm_load_state.enabled_bitmaps);
-    dbm_load_state.enabled_bitmaps = NULL;
+    dbm_load_state.bitmaps_enabled = true;
+    if (dbm_load_state.stream_ended) {
+        g_slist_free_full(dbm_load_state.bitmaps, g_free);
+        dbm_load_state.bitmaps = NULL;
+    }
 
     qemu_mutex_unlock(&dbm_load_state.lock);
 }
@@ -530,9 +539,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f)
         bdrv_reclaim_dirty_bitmap(s->bitmap, &error_abort);
     }
 
-    for (item = dbm_load_state.enabled_bitmaps; item;
-         item = g_slist_next(item))
-    {
+    for (item = dbm_load_state.bitmaps; item; item = g_slist_next(item)) {
         DirtyBitmapLoadBitmapState *b = item->data;
 
         if (b->bitmap == s->bitmap) {
@@ -671,6 +678,16 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
         }
     } while (!(dbm_load_state.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
 
+    qemu_mutex_lock(&dbm_load_state.lock);
+
+    dbm_load_state.stream_ended = true;
+    if (dbm_load_state.bitmaps_enabled) {
+        g_slist_free_full(dbm_load_state.bitmaps, g_free);
+        dbm_load_state.bitmaps = NULL;
+    }
+
+    qemu_mutex_unlock(&dbm_load_state.lock);
+
     trace_dirty_bitmap_load_success();
     return 0;
 }
-- 
2.21.0


