Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9AFC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5146220679
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5146220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3hyg-00025Z-Fk
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvX-0004HH-J9
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvU-0007VI-Bt
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:15 -0500
Received: from relay.sw.ru ([185.231.240.75]:47400)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvU-0007L3-4U
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:12 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvF-0007Zt-7m; Mon, 17 Feb 2020 18:02:57 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/22] migration/savevm: don't worry if bitmap migration
 postcopy failed
Date: Mon, 17 Feb 2020 18:02:35 +0300
Message-Id: <20200217150246.29180-12-vsementsov@virtuozzo.com>
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
Cc: andrey.shinkevich@virtuozzo.com, vsementsov@virtuozzo.com,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

First, if only bitmaps postcopy enabled (not ram postcopy)
postcopy_pause_incoming crashes on assertion assert(mis->to_src_file).

And anyway, bitmaps postcopy is not prepared to be somehow recovered.
The original idea instead is that if bitmaps postcopy failed, we just
loss some bitmaps, which is not critical. So, on failure we just need
to remove unfinished bitmaps and guest should continue execution on
destination.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/savevm.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 1d4220ece8..7e9dd58ccb 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1812,6 +1812,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
     MigrationIncomingState *mis = migration_incoming_get_current();
     QEMUFile *f = mis->from_src_file;
     int load_res;
+    MigrationState *migr = migrate_get_current();
+
+    object_ref(OBJECT(migr));
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                                    MIGRATION_STATUS_POSTCOPY_ACTIVE);
@@ -1838,11 +1841,24 @@ static void *postcopy_ram_listen_thread(void *opaque)
 
     trace_postcopy_ram_listen_thread_exit();
     if (load_res < 0) {
-        error_report("%s: loadvm failed: %d", __func__, load_res);
         qemu_file_set_error(f, load_res);
-        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                                       MIGRATION_STATUS_FAILED);
-    } else {
+        dirty_bitmap_mig_cancel_incoming();
+        if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
+            !migrate_postcopy_ram() && migrate_dirty_bitmaps())
+        {
+            error_report("%s: loadvm failed during postcopy: %d. All state is "
+                         "migrated except for dirty bitmaps. Some dirty "
+                         "bitmaps may be lost, and present migrated dirty "
+                         "bitmaps are correctly migrated and valid.",
+                         __func__, load_res);
+            load_res = 0; /* prevent further exit() */
+        } else {
+            error_report("%s: loadvm failed: %d", __func__, load_res);
+            migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                                           MIGRATION_STATUS_FAILED);
+        }
+    }
+    if (load_res >= 0) {
         /*
          * This looks good, but it's possible that the device loading in the
          * main thread hasn't finished yet, and so we might not be in 'RUN'
@@ -1878,6 +1894,8 @@ static void *postcopy_ram_listen_thread(void *opaque)
     mis->have_listen_thread = false;
     postcopy_state_set(POSTCOPY_INCOMING_END);
 
+    object_unref(OBJECT(migr));
+
     return NULL;
 }
 
@@ -2429,6 +2447,8 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
 {
     trace_postcopy_pause_incoming();
 
+    assert(migrate_postcopy_ram());
+
     /* Clear the triggered bit to allow one recovery */
     mis->postcopy_recover_triggered = false;
 
@@ -2513,15 +2533,22 @@ out:
     if (ret < 0) {
         qemu_file_set_error(f, ret);
 
+        /* Cancel bitmaps incoming regardless of recovery */
+        dirty_bitmap_mig_cancel_incoming();
+
         /*
          * If we are during an active postcopy, then we pause instead
          * of bail out to at least keep the VM's dirty data.  Note
          * that POSTCOPY_INCOMING_LISTENING stage is still not enough,
          * during which we're still receiving device states and we
          * still haven't yet started the VM on destination.
+         *
+         * Only RAM postcopy supports recovery. Still, if RAM postcopy is
+         * enabled, canceled bitmaps postcopy will not affect RAM postcopy
+         * recovering.
          */
         if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
-            postcopy_pause_incoming(mis)) {
+            migrate_postcopy_ram() && postcopy_pause_incoming(mis)) {
             /* Reset f to point to the newly created channel */
             f = mis->from_src_file;
             goto retry;
-- 
2.21.0


