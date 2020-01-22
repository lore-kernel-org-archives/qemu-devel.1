Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C725C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1474A2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1474A2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuG50-00068g-1H
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 08:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iuFyx-0006n4-0N
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iuFyv-0002Mu-M5
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:23:42 -0500
Received: from relay.sw.ru ([185.231.240.75]:42280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iuFys-0002Hv-Ny; Wed, 22 Jan 2020 08:23:38 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iuFyk-00057B-8v; Wed, 22 Jan 2020 16:23:30 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 5/7] migration/block-dirty-bitmap: cancel migration on shutdown
Date: Wed, 22 Jan 2020 16:23:26 +0300
Message-Id: <20200122132328.31156-6-vsementsov@virtuozzo.com>
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

If target is turned of prior to postcopy finished, we crash because
busy bitmaps are found at shutdown.

Let's fix it by removing all unfinished bitmaps on shutdown.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/migration.h          |  1 +
 migration/block-dirty-bitmap.c | 44 ++++++++++++++++++++++++++++++----
 migration/migration.c          |  7 ++++++
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index aa9ff6f27b..a3927b93bb 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -331,6 +331,7 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
 void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
 
 void dirty_bitmap_mig_before_vm_start(void);
+void dirty_bitmap_mig_cancel_incoming(void);
 void init_dirty_bitmap_incoming_migration(void);
 void migrate_add_address(SocketAddress *address);
 
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index f96458113c..5a98543672 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -143,6 +143,7 @@ typedef struct DirtyBitmapLoadState {
 
     bool bitmaps_enabled; /* set in dirty_bitmap_mig_before_vm_start */
     bool stream_ended; /* set when all migrated data handled */
+    bool cancelled;
 
     GSList *bitmaps;
     QemuMutex lock; /* protect bitmaps */
@@ -533,8 +534,6 @@ static void dirty_bitmap_load_complete(QEMUFile *f)
     trace_dirty_bitmap_load_complete();
     bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
 
-    qemu_mutex_lock(&dbm_load_state.lock);
-
     if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
         bdrv_reclaim_dirty_bitmap(s->bitmap, &error_abort);
     }
@@ -547,8 +546,6 @@ static void dirty_bitmap_load_complete(QEMUFile *f)
             break;
         }
     }
-
-    qemu_mutex_unlock(&dbm_load_state.lock);
 }
 
 static int dirty_bitmap_load_bits(QEMUFile *f)
@@ -656,6 +653,13 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
     }
 
     do {
+        qemu_mutex_lock(&dbm_load_state.lock);
+
+        if (dbm_load_state.cancelled) {
+            qemu_mutex_unlock(&dbm_load_state.lock);
+            break;
+        }
+
         ret = dirty_bitmap_load_header(f);
         if (ret < 0) {
             return ret;
@@ -676,6 +680,8 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
         if (ret) {
             return ret;
         }
+
+        qemu_mutex_unlock(&dbm_load_state.lock);
     } while (!(dbm_load_state.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
 
     qemu_mutex_lock(&dbm_load_state.lock);
@@ -692,6 +698,36 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
     return 0;
 }
 
+void dirty_bitmap_mig_cancel_incoming(void)
+{
+    GSList *item;
+
+    qemu_mutex_lock(&dbm_load_state.lock);
+
+    if (dbm_load_state.bitmaps_enabled && dbm_load_state.stream_ended) {
+        qemu_mutex_unlock(&dbm_load_state.lock);
+        return;
+    }
+
+    dbm_load_state.cancelled = true;
+
+    for (item = dbm_load_state.bitmaps; item; item = g_slist_next(item)) {
+        DirtyBitmapLoadBitmapState *b = item->data;
+
+        if (!dbm_load_state.bitmaps_enabled || !b->migrated) {
+            if (bdrv_dirty_bitmap_has_successor(b->bitmap)) {
+                bdrv_reclaim_dirty_bitmap(b->bitmap, &error_abort);
+            }
+            bdrv_release_dirty_bitmap(b->bitmap);
+        }
+    }
+
+    g_slist_free_full(dbm_load_state.bitmaps, g_free);
+    dbm_load_state.bitmaps = NULL;
+
+    qemu_mutex_unlock(&dbm_load_state.lock);
+}
+
 static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
 {
     DirtyBitmapMigBitmapState *dbms = NULL;
diff --git a/migration/migration.c b/migration/migration.c
index 990bff00c0..12d161165d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -182,6 +182,13 @@ void migration_shutdown(void)
      */
     migrate_fd_cancel(current_migration);
     object_unref(OBJECT(current_migration));
+
+    /*
+     * Cancel incoming migration of dirty bitmaps. Dirty bitmaps
+     * are non-critical data, and their loss never considered as
+     * something serious.
+     */
+    dirty_bitmap_mig_cancel_incoming();
 }
 
 /* For outgoing */
-- 
2.21.0


