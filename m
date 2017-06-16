Received: from eggs.gnu.org ([2001:4830:134:3::10]:52539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dLtmG-0000z6-2r
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dLtmB-0000gl-9N
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:07:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dLtmB-0000ga-0v
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:07:11 -0400
From: Fam Zheng <famz@redhat.com>
Date: Sat, 17 Jun 2017 00:06:58 +0800
Message-Id: <20170616160658.32290-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] migration: Fix race of image locking between
 src and dst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, mreitz@redhat.com, stefanha@redhat.com, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jsnow@redhat.com

Previously, dst side will immediately try to lock the write byte upon
receiving QEMU_VM_EOF, but at src side, bdrv_inactivate_all() is only
done after sending it. If the src host is under load, dst may fail to
acquire the lock due to racing with the src unlocking it.

Fix this by hoisting the bdrv_inactivate_all() operation before
QEMU_VM_EOF.

N.B. A further improvement could possibly be done to cleanly handover
locks between src and dst, so that there is no window where a third QEMU
could steal the locks and prevent src and dst from running.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 migration/colo.c      |  2 +-
 migration/migration.c | 19 +++++++------------
 migration/savevm.c    | 19 +++++++++++++++----
 migration/savevm.h    |  3 ++-
 4 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index c436d63..c4ba4c3 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -352,7 +352,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     qemu_savevm_state_header(fb);
     qemu_savevm_state_begin(fb);
     qemu_mutex_lock_iothread();
-    qemu_savevm_state_complete_precopy(fb, false);
+    qemu_savevm_state_complete_precopy(fb, false, false);
     qemu_mutex_unlock_iothread();
 
     qemu_fflush(fb);
diff --git a/migration/migration.c b/migration/migration.c
index b9d8798..f588329 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1553,7 +1553,7 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
      * Cause any non-postcopiable, but iterative devices to
      * send out their final data.
      */
-    qemu_savevm_state_complete_precopy(ms->to_dst_file, true);
+    qemu_savevm_state_complete_precopy(ms->to_dst_file, true, false);
 
     /*
      * in Finish migrate and with the io-lock held everything should
@@ -1597,7 +1597,7 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
      */
     qemu_savevm_send_postcopy_listen(fb);
 
-    qemu_savevm_state_complete_precopy(fb, false);
+    qemu_savevm_state_complete_precopy(fb, false, false);
     qemu_savevm_send_ping(fb, 3);
 
     qemu_savevm_send_postcopy_run(fb);
@@ -1695,20 +1695,15 @@ static void migration_completion(MigrationState *s, int current_active_state,
         ret = global_state_store();
 
         if (!ret) {
+            bool inactivate = !migrate_colo_enabled();
             ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
             if (ret >= 0) {
                 qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
-                qemu_savevm_state_complete_precopy(s->to_dst_file, false);
+                ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
+                                                         inactivate);
             }
-            /*
-             * Don't mark the image with BDRV_O_INACTIVE flag if
-             * we will go into COLO stage later.
-             */
-            if (ret >= 0 && !migrate_colo_enabled()) {
-                ret = bdrv_inactivate_all();
-                if (ret >= 0) {
-                    s->block_inactive = true;
-                }
+            if (inactivate && ret >= 0) {
+                s->block_inactive = true;
             }
         }
         qemu_mutex_unlock_iothread();
diff --git a/migration/savevm.c b/migration/savevm.c
index f32a82d..6bfd489 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1104,7 +1104,8 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     qemu_fflush(f);
 }
 
-void qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
+int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
+                                       bool inactivate_disks)
 {
     QJSON *vmdesc;
     int vmdesc_len;
@@ -1138,12 +1139,12 @@ void qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
         save_section_footer(f, se);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
-            return;
+            return -1;
         }
     }
 
     if (iterable_only) {
-        return;
+        return 0;
     }
 
     vmdesc = qjson_new();
@@ -1173,6 +1174,15 @@ void qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
         json_end_object(vmdesc);
     }
 
+    if (inactivate_disks) {
+        /* Inactivate before sending QEMU_VM_EOF so that the
+         * bdrv_invalidate_cache_all() on the other end won't fail. */
+        ret = bdrv_inactivate_all();
+        if (ret) {
+            qemu_file_set_error(f, ret);
+            return ret;
+        }
+    }
     if (!in_postcopy) {
         /* Postcopy stream will still be going */
         qemu_put_byte(f, QEMU_VM_EOF);
@@ -1190,6 +1200,7 @@ void qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
     qjson_destroy(vmdesc);
 
     qemu_fflush(f);
+    return 0;
 }
 
 /* Give an estimate of the amount left to be transferred,
@@ -1263,7 +1274,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
 
     ret = qemu_file_get_error(f);
     if (ret == 0) {
-        qemu_savevm_state_complete_precopy(f, false);
+        qemu_savevm_state_complete_precopy(f, false, false);
         ret = qemu_file_get_error(f);
     }
     qemu_savevm_state_cleanup();
diff --git a/migration/savevm.h b/migration/savevm.h
index 45b59c1..5a2ed11 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -35,7 +35,8 @@ void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
-void qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only);
+int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
+                                       bool inactivate_disks);
 void qemu_savevm_state_pending(QEMUFile *f, uint64_t max_size,
                                uint64_t *res_non_postcopiable,
                                uint64_t *res_postcopiable);
-- 
2.9.4
