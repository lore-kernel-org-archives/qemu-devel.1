Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE75C3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8597D24125
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8597D24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuG54-0006F4-CI
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 08:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iuFyx-0006nv-Hi
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iuFyv-0002NF-WC
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:23:43 -0500
Received: from relay.sw.ru ([185.231.240.75]:42294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iuFys-0002I0-Mu; Wed, 22 Jan 2020 08:23:38 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iuFyj-00057B-8h; Wed, 22 Jan 2020 16:23:29 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/7] migration/block-dirty-bitmap: refactor incoming state to
 be one struct
Date: Wed, 22 Jan 2020 16:23:22 +0300
Message-Id: <20200122132328.31156-2-vsementsov@virtuozzo.com>
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

Move enabled_bitmaps and finish_lock, which are part of incoming state
to DirtyBitmapLoadState, and make static global variable to store state
instead of static local one.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 77 +++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 7eafface61..281d20f41d 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -125,6 +125,13 @@ typedef struct DirtyBitmapMigState {
     BlockDriverState *prev_bs;
     BdrvDirtyBitmap *prev_bitmap;
 } DirtyBitmapMigState;
+static DirtyBitmapMigState dirty_bitmap_mig_state;
+
+typedef struct DirtyBitmapLoadBitmapState {
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
+    bool migrated;
+} DirtyBitmapLoadBitmapState;
 
 typedef struct DirtyBitmapLoadState {
     uint32_t flags;
@@ -132,21 +139,15 @@ typedef struct DirtyBitmapLoadState {
     char bitmap_name[256];
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
-} DirtyBitmapLoadState;
 
-static DirtyBitmapMigState dirty_bitmap_mig_state;
-
-typedef struct DirtyBitmapLoadBitmapState {
-    BlockDriverState *bs;
-    BdrvDirtyBitmap *bitmap;
-    bool migrated;
-} DirtyBitmapLoadBitmapState;
-static GSList *enabled_bitmaps;
-QemuMutex finish_lock;
+    GSList *enabled_bitmaps;
+    QemuMutex finish_lock;
+} DirtyBitmapLoadState;
+static DirtyBitmapLoadState dbm_load_state;
 
 void init_dirty_bitmap_incoming_migration(void)
 {
-    qemu_mutex_init(&finish_lock);
+    qemu_mutex_init(&dbm_load_state.finish_lock);
 }
 
 static uint32_t qemu_get_bitmap_flags(QEMUFile *f)
@@ -439,8 +440,9 @@ static void dirty_bitmap_save_pending(QEMUFile *f, void *opaque,
 }
 
 /* First occurrence of this bitmap. It should be created if doesn't exist */
-static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
+static int dirty_bitmap_load_start(QEMUFile *f)
 {
+    DirtyBitmapLoadState *s = &dbm_load_state;
     Error *local_err = NULL;
     uint32_t granularity = qemu_get_be32(f);
     uint8_t flags = qemu_get_byte(f);
@@ -482,7 +484,8 @@ static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
         b->bs = s->bs;
         b->bitmap = s->bitmap;
         b->migrated = false;
-        enabled_bitmaps = g_slist_prepend(enabled_bitmaps, b);
+        dbm_load_state.enabled_bitmaps =
+            g_slist_prepend(dbm_load_state.enabled_bitmaps, b);
     }
 
     return 0;
@@ -492,9 +495,11 @@ void dirty_bitmap_mig_before_vm_start(void)
 {
     GSList *item;
 
-    qemu_mutex_lock(&finish_lock);
+    qemu_mutex_lock(&dbm_load_state.finish_lock);
 
-    for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
+    for (item = dbm_load_state.enabled_bitmaps; item;
+         item = g_slist_next(item))
+    {
         DirtyBitmapLoadBitmapState *b = item->data;
 
         if (b->migrated) {
@@ -506,21 +511,24 @@ void dirty_bitmap_mig_before_vm_start(void)
         g_free(b);
     }
 
-    g_slist_free(enabled_bitmaps);
-    enabled_bitmaps = NULL;
+    g_slist_free(dbm_load_state.enabled_bitmaps);
+    dbm_load_state.enabled_bitmaps = NULL;
 
-    qemu_mutex_unlock(&finish_lock);
+    qemu_mutex_unlock(&dbm_load_state.finish_lock);
 }
 
-static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
+static void dirty_bitmap_load_complete(QEMUFile *f)
 {
+    DirtyBitmapLoadState *s = &dbm_load_state;
     GSList *item;
     trace_dirty_bitmap_load_complete();
     bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
 
-    qemu_mutex_lock(&finish_lock);
+    qemu_mutex_lock(&dbm_load_state.finish_lock);
 
-    for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
+    for (item = dbm_load_state.enabled_bitmaps; item;
+         item = g_slist_next(item))
+    {
         DirtyBitmapLoadBitmapState *b = item->data;
 
         if (b->bitmap == s->bitmap) {
@@ -531,7 +539,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
 
     if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
         bdrv_dirty_bitmap_lock(s->bitmap);
-        if (enabled_bitmaps == NULL) {
+        if (dbm_load_state.enabled_bitmaps == NULL) {
             /* in postcopy */
             bdrv_reclaim_dirty_bitmap_locked(s->bitmap, &error_abort);
             bdrv_enable_dirty_bitmap_locked(s->bitmap);
@@ -550,11 +558,12 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
         bdrv_dirty_bitmap_unlock(s->bitmap);
     }
 
-    qemu_mutex_unlock(&finish_lock);
+    qemu_mutex_unlock(&dbm_load_state.finish_lock);
 }
 
-static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
+static int dirty_bitmap_load_bits(QEMUFile *f)
 {
+    DirtyBitmapLoadState *s = &dbm_load_state;
     uint64_t first_byte = qemu_get_be64(f) << BDRV_SECTOR_BITS;
     uint64_t nr_bytes = (uint64_t)qemu_get_be32(f) << BDRV_SECTOR_BITS;
     trace_dirty_bitmap_load_bits_enter(first_byte >> BDRV_SECTOR_BITS,
@@ -598,8 +607,9 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
     return 0;
 }
 
-static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
+static int dirty_bitmap_load_header(QEMUFile *f)
 {
+    DirtyBitmapLoadState *s = &dbm_load_state;
     Error *local_err = NULL;
     bool nothing;
     s->flags = qemu_get_bitmap_flags(f);
@@ -647,7 +657,6 @@ static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
 
 static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
 {
-    static DirtyBitmapLoadState s;
     int ret = 0;
 
     trace_dirty_bitmap_load_enter();
@@ -657,17 +666,17 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
     }
 
     do {
-        ret = dirty_bitmap_load_header(f, &s);
+        ret = dirty_bitmap_load_header(f);
         if (ret < 0) {
             return ret;
         }
 
-        if (s.flags & DIRTY_BITMAP_MIG_FLAG_START) {
-            ret = dirty_bitmap_load_start(f, &s);
-        } else if (s.flags & DIRTY_BITMAP_MIG_FLAG_COMPLETE) {
-            dirty_bitmap_load_complete(f, &s);
-        } else if (s.flags & DIRTY_BITMAP_MIG_FLAG_BITS) {
-            ret = dirty_bitmap_load_bits(f, &s);
+        if (dbm_load_state.flags & DIRTY_BITMAP_MIG_FLAG_START) {
+            ret = dirty_bitmap_load_start(f);
+        } else if (dbm_load_state.flags & DIRTY_BITMAP_MIG_FLAG_COMPLETE) {
+            dirty_bitmap_load_complete(f);
+        } else if (dbm_load_state.flags & DIRTY_BITMAP_MIG_FLAG_BITS) {
+            ret = dirty_bitmap_load_bits(f);
         }
 
         if (!ret) {
@@ -677,7 +686,7 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
         if (ret) {
             return ret;
         }
-    } while (!(s.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
+    } while (!(dbm_load_state.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
 
     trace_dirty_bitmap_load_success();
     return 0;
-- 
2.21.0


