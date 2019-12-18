Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E482C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC6D2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC6D2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZ9Y-0002jU-1K
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihYrN-0002ks-82
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihYrL-0002yN-34
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:55:24 -0500
Received: from relay.sw.ru ([185.231.240.75]:46600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ihYrK-0002mv-Pa
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:55:23 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1ihYrD-0005hS-5O; Wed, 18 Dec 2019 15:55:15 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [RFC] migration: introduce failed-unrecovarable status
Date: Wed, 18 Dec 2019 15:55:12 +0300
Message-Id: <20191218125512.5446-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
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
Cc: vsementsov@virtuozzo.com, quintela@redhat.com, armbru@redhat.com,
 dgilbert@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should not start source vm automatically, if the error occured after
target accessed disks, or if we failed to invalidate nodes.

Also, fix, that we need invalidate even if bdrv_inactivate_all()
failed, as in this case it still may successfully inactivate some of
the nodes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi all!

It's an investigation on top of old thread
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg02355.html

Either I'm missing something, or we need this patch. It's a draft, may
be need to split it into 2-3 small patches. Still I'd like to get
general approval at first, may be I'm doing something wrong.

Also, there may be other migration failure cases like this.

 qapi/migration.json   |  7 +++++--
 migration/migration.c | 36 ++++++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index b7348d0c8b..90fa625cbb 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -125,6 +125,9 @@
 #
 # @failed: some error occurred during migration process.
 #
+# @failed-unrecoverable: postcopy failed after no return point, when disks may
+#                        already be accessed by target Qemu process. (since 5.0)
+#
 # @colo: VM is in the process of fault tolerance, VM can not get into this
 #        state unless colo capability is enabled for migration. (since 2.8)
 #
@@ -142,8 +145,8 @@
 { 'enum': 'MigrationStatus',
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
             'active', 'postcopy-active', 'postcopy-paused',
-            'postcopy-recover', 'completed', 'failed', 'colo',
-            'pre-switchover', 'device', 'wait-unplug' ] }
+            'postcopy-recover', 'completed', 'failed', 'failed-unrecoverable',
+            'colo', 'pre-switchover', 'device', 'wait-unplug' ] }
 
 ##
 # @MigrationInfo:
diff --git a/migration/migration.c b/migration/migration.c
index 354ad072fa..00684fdef8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2576,7 +2576,14 @@ static int postcopy_start(MigrationState *ms)
     QEMUFile *fb;
     int64_t time_at_stop = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     int64_t bandwidth = migrate_max_postcopy_bandwidth();
-    bool restart_block = false;
+
+    /*
+     * recoverable_failure
+     * A failure happened early enough that we know the destination hasn't
+     * accessed block devices, so we're safe to recover.
+     */
+    bool recoverable_failure = true;
+    bool inactivated = false;
     int cur_state = MIGRATION_STATUS_ACTIVE;
     if (!migrate_pause_before_switchover()) {
         migrate_set_state(&ms->state, MIGRATION_STATUS_ACTIVE,
@@ -2600,11 +2607,11 @@ static int postcopy_start(MigrationState *ms)
         goto fail;
     }
 
+    inactivated = true;
     ret = bdrv_inactivate_all();
     if (ret < 0) {
         goto fail;
     }
-    restart_block = true;
 
     /*
      * Cause any non-postcopiable, but iterative devices to
@@ -2682,7 +2689,7 @@ static int postcopy_start(MigrationState *ms)
         goto fail_closefb;
     }
 
-    restart_block = false;
+    recoverable_failure = false;
 
     /* Now send that blob */
     if (qemu_savevm_send_packaged(ms->to_dst_file, bioc->data, bioc->usage)) {
@@ -2716,26 +2723,28 @@ static int postcopy_start(MigrationState *ms)
     ret = qemu_file_get_error(ms->to_dst_file);
     if (ret) {
         error_report("postcopy_start: Migration stream errored");
-        migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                              MIGRATION_STATUS_FAILED);
+        goto fail;
     }
 
-    return ret;
+    return 0;
 
 fail_closefb:
     qemu_fclose(fb);
 fail:
     migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
-    if (restart_block) {
-        /* A failure happened early enough that we know the destination hasn't
-         * accessed block devices, so we're safe to recover.
-         */
+                      recoverable_failure ? MIGRATION_STATUS_FAILED :
+                      MIGRATION_STATUS_FAILED_UNRECOVERABLE);
+    if (recoverable_failure && inactivated) {
         Error *local_err = NULL;
 
         bdrv_invalidate_cache_all(&local_err);
         if (local_err) {
             error_report_err(local_err);
+            /*
+             * We failed to invalidate, so we must not start vm automatically.
+             * User may retry invalidation and start by cont qmp command.
+             */
+            ms->vm_was_running = false;
         }
     }
     qemu_mutex_unlock_iothread();
@@ -3194,9 +3203,12 @@ static void migration_iteration_finish(MigrationState *s)
         s->vm_was_running = true;
         /* Fallthrough */
     case MIGRATION_STATUS_FAILED:
+    case MIGRATION_STATUS_FAILED_UNRECOVERABLE:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_CANCELLING:
-        if (s->vm_was_running) {
+        if (s->vm_was_running &&
+            s->state != MIGRATION_STATUS_FAILED_UNRECOVERABLE)
+        {
             vm_start();
         } else {
             if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
-- 
2.21.0


