Received: from eggs.gnu.org ([2001:4830:134:3::10]:50872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e5TG2-0005nY-AV
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e5TFz-0004FW-BE
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:06:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e5TFz-0004FA-2p
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:06:19 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 20 Oct 2017 10:05:56 +0100
Message-Id: <20171020090556.18631-8-dgilbert@redhat.com>
In-Reply-To: <20171020090556.18631-1-dgilbert@redhat.com>
References: <20171020090556.18631-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 7/7] migration: pause-before-switchover for
 postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com, wangjie88@huawei.com, quintela@redhat.com, peterx@redhat.com, mreitz@redhat.com
Cc: berrange@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add pause-before-switchover support for postcopy.
After starting postcopy it will transition
    active->pre-switchover->postcopy_active

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 756deb3e2c..af587377e9 100644
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
@@ -1830,8 +1833,11 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
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
@@ -1845,6 +1851,12 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
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
@@ -1987,7 +1999,9 @@ fail:
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
@@ -2008,11 +2022,11 @@ static int migration_maybe_pause(MigrationState *s, int *current_active_state)
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
@@ -2041,7 +2055,8 @@ static void migration_completion(MigrationState *s, int current_active_state,
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
