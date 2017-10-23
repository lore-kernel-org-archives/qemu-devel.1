Received: from eggs.gnu.org ([2001:4830:134:3::10]:35838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHM-0005js-E6
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHJ-0000Fd-U1
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6fHJ-0000EM-LD
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C890015565
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 16:08:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Oct 2017 18:07:51 +0200
Message-Id: <20171023160800.20540-13-quintela@redhat.com>
In-Reply-To: <20171023160800.20540-1-quintela@redhat.com>
References: <20171023160800.20540-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 12/21] migration: pause-before-switchover for
 postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add pause-before-switchover support for postcopy.
After starting postcopy it will transition
    active->pre-switchover->postcopy_active

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b523d8f215..a058f8b46d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -104,6 +104,9 @@ enum mig_rp_message_type {
 static MigrationState *current_migration;
 
 static bool migration_object_check(MigrationState *ms, Error **errp);
+static int migration_maybe_pause(MigrationState *s,
+                                 int *current_active_state,
+                                 int new_state);
 
 void migration_object_init(void)
 {
@@ -1820,8 +1823,11 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
     QEMUFile *fb;
     int64_t time_at_stop = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     bool restart_block = false;
-    migrate_set_state(&ms->state, MIGRATION_STATUS_ACTIVE,
-                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    int cur_state = MIGRATION_STATUS_ACTIVE;
+    if (!migrate_pause_before_switchover()) {
+        migrate_set_state(&ms->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    }
 
     trace_postcopy_start();
     qemu_mutex_lock_iothread();
@@ -1835,6 +1841,12 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
         goto fail;
     }
 
+    ret = migration_maybe_pause(ms, &cur_state,
+                                MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    if (ret < 0) {
+        goto fail;
+    }
+
     ret = bdrv_inactivate_all();
     if (ret < 0) {
         goto fail;
@@ -1977,7 +1989,9 @@ fail:
  * migrate_pause_before_switchover called with the iothread locked
  * Returns: 0 on success
  */
-static int migration_maybe_pause(MigrationState *s, int *current_active_state)
+static int migration_maybe_pause(MigrationState *s,
+                                 int *current_active_state,
+                                 int new_state)
 {
     if (!migrate_pause_before_switchover()) {
         return 0;
@@ -1998,11 +2012,11 @@ static int migration_maybe_pause(MigrationState *s, int *current_active_state)
                       MIGRATION_STATUS_PRE_SWITCHOVER);
     qemu_sem_wait(&s->pause_sem);
     migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
-                      MIGRATION_STATUS_DEVICE);
-    *current_active_state = MIGRATION_STATUS_DEVICE;
+                      new_state);
+    *current_active_state = new_state;
     qemu_mutex_lock_iothread();
 
-    return s->state == MIGRATION_STATUS_DEVICE ? 0 : -EINVAL;
+    return s->state == new_state ? 0 : -EINVAL;
 }
 
 /**
@@ -2031,7 +2045,8 @@ static void migration_completion(MigrationState *s, int current_active_state,
             bool inactivate = !migrate_colo_enabled();
             ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
             if (ret >= 0) {
-                ret = migration_maybe_pause(s, &current_active_state);
+                ret = migration_maybe_pause(s, &current_active_state,
+                                            MIGRATION_STATUS_DEVICE);
             }
             if (ret >= 0) {
                 qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
-- 
2.13.6
