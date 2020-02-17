Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC76C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5F820801
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5F820801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3i8X-00029i-W2
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvk-0004yN-UT
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvj-0007aK-29
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:28 -0500
Received: from relay.sw.ru ([185.231.240.75]:47534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvi-0007RU-Px; Mon, 17 Feb 2020 10:03:26 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvC-0007Zt-KZ; Mon, 17 Feb 2020 18:02:54 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/22] migration/block-dirty-bitmap: rename state structure
 types
Date: Mon, 17 Feb 2020 18:02:26 +0300
Message-Id: <20200217150246.29180-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200217150246.29180-1-vsementsov@virtuozzo.com>
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
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
Cc: Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, andrey.shinkevich@virtuozzo.com,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename types to be symmetrical for load/save part and shorter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 68 ++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 16f1793ee3..73792ab005 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -100,23 +100,25 @@
 /* 0x04 was "AUTOLOAD" flags on elder versions, no it is ignored */
 #define DIRTY_BITMAP_MIG_START_FLAG_RESERVED_MASK    0xf8
 
-typedef struct DirtyBitmapMigBitmapState {
+/* State of one bitmap during save process */
+typedef struct SaveBitmapState {
     /* Written during setup phase. */
     BlockDriverState *bs;
     const char *node_name;
     BdrvDirtyBitmap *bitmap;
     uint64_t total_sectors;
     uint64_t sectors_per_chunk;
-    QSIMPLEQ_ENTRY(DirtyBitmapMigBitmapState) entry;
+    QSIMPLEQ_ENTRY(SaveBitmapState) entry;
     uint8_t flags;
 
     /* For bulk phase. */
     bool bulk_completed;
     uint64_t cur_sector;
-} DirtyBitmapMigBitmapState;
+} SaveBitmapState;
 
-typedef struct DirtyBitmapMigState {
-    QSIMPLEQ_HEAD(, DirtyBitmapMigBitmapState) dbms_list;
+/* State of the dirty bitmap migration (DBM) during save process */
+typedef struct DBMSaveState {
+    QSIMPLEQ_HEAD(, SaveBitmapState) dbms_list;
 
     bool bulk_completed;
     bool no_bitmaps;
@@ -124,23 +126,25 @@ typedef struct DirtyBitmapMigState {
     /* for send_bitmap_bits() */
     BlockDriverState *prev_bs;
     BdrvDirtyBitmap *prev_bitmap;
-} DirtyBitmapMigState;
+} DBMSaveState;
 
-typedef struct DirtyBitmapLoadState {
+/* State of the dirty bitmap migration (DBM) during load process */
+typedef struct DBMLoadState {
     uint32_t flags;
     char node_name[256];
     char bitmap_name[256];
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
-} DirtyBitmapLoadState;
+} DBMLoadState;
 
-static DirtyBitmapMigState dirty_bitmap_mig_state;
+static DBMSaveState dirty_bitmap_mig_state;
 
-typedef struct DirtyBitmapLoadBitmapState {
+/* State of one bitmap during load process */
+typedef struct LoadBitmapState {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
     bool migrated;
-} DirtyBitmapLoadBitmapState;
+} LoadBitmapState;
 static GSList *enabled_bitmaps;
 QemuMutex finish_lock;
 
@@ -170,7 +174,7 @@ static void qemu_put_bitmap_flags(QEMUFile *f, uint32_t flags)
     qemu_put_byte(f, flags);
 }
 
-static void send_bitmap_header(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
+static void send_bitmap_header(QEMUFile *f, SaveBitmapState *dbms,
                                uint32_t additional_flags)
 {
     BlockDriverState *bs = dbms->bs;
@@ -199,19 +203,19 @@ static void send_bitmap_header(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
     }
 }
 
-static void send_bitmap_start(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
+static void send_bitmap_start(QEMUFile *f, SaveBitmapState *dbms)
 {
     send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_START);
     qemu_put_be32(f, bdrv_dirty_bitmap_granularity(dbms->bitmap));
     qemu_put_byte(f, dbms->flags);
 }
 
-static void send_bitmap_complete(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
+static void send_bitmap_complete(QEMUFile *f, SaveBitmapState *dbms)
 {
     send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_COMPLETE);
 }
 
-static void send_bitmap_bits(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
+static void send_bitmap_bits(QEMUFile *f, SaveBitmapState *dbms,
                              uint64_t start_sector, uint32_t nr_sectors)
 {
     /* align for buffer_is_zero() */
@@ -257,7 +261,7 @@ static void send_bitmap_bits(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
 /* Called with iothread lock taken.  */
 static void dirty_bitmap_mig_cleanup(void)
 {
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;
 
     while ((dbms = QSIMPLEQ_FIRST(&dirty_bitmap_mig_state.dbms_list)) != NULL) {
         QSIMPLEQ_REMOVE_HEAD(&dirty_bitmap_mig_state.dbms_list, entry);
@@ -272,7 +276,7 @@ static int init_dirty_bitmap_migration(void)
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;
     Error *local_err = NULL;
 
     dirty_bitmap_mig_state.bulk_completed = false;
@@ -303,7 +307,7 @@ static int init_dirty_bitmap_migration(void)
             bdrv_ref(bs);
             bdrv_dirty_bitmap_set_busy(bitmap, true);
 
-            dbms = g_new0(DirtyBitmapMigBitmapState, 1);
+            dbms = g_new0(SaveBitmapState, 1);
             dbms->bs = bs;
             dbms->node_name = name;
             dbms->bitmap = bitmap;
@@ -340,7 +344,7 @@ fail:
 }
 
 /* Called with no lock taken.  */
-static void bulk_phase_send_chunk(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
+static void bulk_phase_send_chunk(QEMUFile *f, SaveBitmapState *dbms)
 {
     uint32_t nr_sectors = MIN(dbms->total_sectors - dbms->cur_sector,
                              dbms->sectors_per_chunk);
@@ -356,7 +360,7 @@ static void bulk_phase_send_chunk(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
 /* Called with no lock taken.  */
 static void bulk_phase(QEMUFile *f, bool limit)
 {
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;
 
     QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
         while (!dbms->bulk_completed) {
@@ -393,7 +397,7 @@ static int dirty_bitmap_save_iterate(QEMUFile *f, void *opaque)
 
 static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
 {
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;
     trace_dirty_bitmap_save_complete_enter();
 
     if (!dirty_bitmap_mig_state.bulk_completed) {
@@ -418,7 +422,7 @@ static void dirty_bitmap_save_pending(QEMUFile *f, void *opaque,
                                       uint64_t *res_compatible,
                                       uint64_t *res_postcopy_only)
 {
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;
     uint64_t pending = 0;
 
     qemu_mutex_lock_iothread();
@@ -439,7 +443,7 @@ static void dirty_bitmap_save_pending(QEMUFile *f, void *opaque,
 }
 
 /* First occurrence of this bitmap. It should be created if doesn't exist */
-static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
+static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
 {
     Error *local_err = NULL;
     uint32_t granularity = qemu_get_be32(f);
@@ -470,7 +474,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
 
     bdrv_disable_dirty_bitmap(s->bitmap);
     if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
-        DirtyBitmapLoadBitmapState *b;
+        LoadBitmapState *b;
 
         bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
         if (local_err) {
@@ -478,7 +482,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
             return -EINVAL;
         }
 
-        b = g_new(DirtyBitmapLoadBitmapState, 1);
+        b = g_new(LoadBitmapState, 1);
         b->bs = s->bs;
         b->bitmap = s->bitmap;
         b->migrated = false;
@@ -495,7 +499,7 @@ void dirty_bitmap_mig_before_vm_start(void)
     qemu_mutex_lock(&finish_lock);
 
     for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
-        DirtyBitmapLoadBitmapState *b = item->data;
+        LoadBitmapState *b = item->data;
 
         if (b->migrated) {
             bdrv_enable_dirty_bitmap(b->bitmap);
@@ -512,7 +516,7 @@ void dirty_bitmap_mig_before_vm_start(void)
     qemu_mutex_unlock(&finish_lock);
 }
 
-static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
+static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
 {
     GSList *item;
     trace_dirty_bitmap_load_complete();
@@ -521,7 +525,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
     qemu_mutex_lock(&finish_lock);
 
     for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
-        DirtyBitmapLoadBitmapState *b = item->data;
+        LoadBitmapState *b = item->data;
 
         if (b->bitmap == s->bitmap) {
             b->migrated = true;
@@ -553,7 +557,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
     qemu_mutex_unlock(&finish_lock);
 }
 
-static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
+static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
 {
     uint64_t first_byte = qemu_get_be64(f) << BDRV_SECTOR_BITS;
     uint64_t nr_bytes = (uint64_t)qemu_get_be32(f) << BDRV_SECTOR_BITS;
@@ -598,7 +602,7 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
     return 0;
 }
 
-static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
+static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
 {
     Error *local_err = NULL;
     bool nothing;
@@ -647,7 +651,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
 
 static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
 {
-    static DirtyBitmapLoadState s;
+    static DBMLoadState s;
     int ret = 0;
 
     trace_dirty_bitmap_load_enter();
@@ -685,7 +689,7 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
 
 static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
 {
-    DirtyBitmapMigBitmapState *dbms = NULL;
+    SaveBitmapState *dbms = NULL;
     if (init_dirty_bitmap_migration() < 0) {
         return -1;
     }
-- 
2.21.0


