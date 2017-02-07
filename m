Received: from eggs.gnu.org ([2001:4830:134:3::10]:58008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cb7LG-0000c2-2S
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cb7L5-0007AD-1x
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:06:02 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  7 Feb 2017 18:05:27 +0300
Message-Id: <1486479940-163258-5-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1486479940-163258-1-git-send-email-vsementsov@virtuozzo.com>
References: <1486479940-163258-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 04/17] migration: introduce postcopy-only
 pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

There would be savevm states (dirty-bitmap) which can migrate only in
postcopy stage. The corresponding pending is introduced here.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/vmstate.h | 17 +++++++++++++++--
 include/sysemu/sysemu.h     |  5 +++--
 migration/block.c           |  7 ++++---
 migration/migration.c       | 15 ++++++++-------
 migration/ram.c             |  9 +++++----
 migration/savevm.c          | 14 ++++++++------
 migration/trace-events      |  2 +-
 7 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1eadcf0..da62a73 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -58,8 +58,21 @@ typedef struct SaveVMHandlers {
     /* This runs outside the iothread lock!  */
     int (*save_live_setup)(QEMUFile *f, void *opaque);
     void (*save_live_pending)(QEMUFile *f, void *opaque, uint64_t max_size,
-                              uint64_t *non_postcopiable_pending,
-                              uint64_t *postcopiable_pending);
+                              uint64_t *res_precopy_only,
+                              uint64_t *res_compatible,
+                              uint64_t *res_postcopy_only);
+    /* Note for save_live_pending:
+     * - res_precopy_only is for data which must be migrated in precopy phase
+     *     or in stopped state, in other words - before target vm start
+     * - res_compatible is for data which may be migrated in any phase
+     * - res_postcopy_only is for data which must be migrated in postcopy phase
+     *     or in stopped state, in other words - after source vm stop
+     *
+     * Sum of res_postcopy_only, res_compatible and res_postcopy_only is the
+     * whole amount of pending data.
+     */
+
+
     LoadStateHandler *load_state;
 } SaveVMHandlers;
 
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 4d50694..5d59d35 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -111,8 +111,9 @@ void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
 void qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only);
 void qemu_savevm_state_pending(QEMUFile *f, uint64_t max_size,
-                               uint64_t *res_non_postcopiable,
-                               uint64_t *res_postcopiable);
+                               uint64_t *res_precopy_only,
+                               uint64_t *res_compatible,
+                               uint64_t *res_postcopy_only);
 void qemu_savevm_command_send(QEMUFile *f, enum qemu_vm_cmd command,
                               uint16_t len, uint8_t *data);
 void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
diff --git a/migration/block.c b/migration/block.c
index ebc10e6..83b0785 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -830,8 +830,9 @@ static int block_save_complete(QEMUFile *f, void *opaque)
 }
 
 static void block_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
-                               uint64_t *non_postcopiable_pending,
-                               uint64_t *postcopiable_pending)
+                               uint64_t *res_precopy_only,
+                               uint64_t *res_compatible,
+                               uint64_t *res_postcopy_only)
 {
     /* Estimate pending number of bytes to send */
     uint64_t pending;
@@ -852,7 +853,7 @@ static void block_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
 
     DPRINTF("Enter save live pending  %" PRIu64 "\n", pending);
     /* We don't do postcopy */
-    *non_postcopiable_pending += pending;
+    *res_precopy_only += pending;
 }
 
 static int block_load(QEMUFile *f, void *opaque, int version_id)
diff --git a/migration/migration.c b/migration/migration.c
index 0a5fd38..2fb734e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1896,20 +1896,21 @@ static void *migration_thread(void *opaque)
         uint64_t pending_size;
 
         if (!qemu_file_rate_limit(s->to_dst_file)) {
-            uint64_t pend_post, pend_nonpost;
+            uint64_t pend_pre, pend_compat, pend_post;
 
-            qemu_savevm_state_pending(s->to_dst_file, max_size, &pend_nonpost,
-                                      &pend_post);
-            pending_size = pend_nonpost + pend_post;
+            qemu_savevm_state_pending(s->to_dst_file, max_size, &pend_pre,
+                                      &pend_compat, &pend_post);
+            pending_size = pend_pre + pend_compat + pend_post;
             trace_migrate_pending(pending_size, max_size,
-                                  pend_post, pend_nonpost);
+                                  pend_pre, pend_compat, pend_post);
             if (pending_size && pending_size >= max_size) {
                 /* Still a significant amount to transfer */
 
                 if (migrate_postcopy() &&
                     s->state != MIGRATION_STATUS_POSTCOPY_ACTIVE &&
-                    pend_nonpost <= max_size &&
-                    atomic_read(&s->start_postcopy)) {
+                    pend_pre <= max_size &&
+                    (atomic_read(&s->start_postcopy) ||
+                     (pend_pre + pend_compat <= max_size))) {
 
                     if (!postcopy_start(s, &old_vm_running)) {
                         current_active_state = MIGRATION_STATUS_POSTCOPY_ACTIVE;
diff --git a/migration/ram.c b/migration/ram.c
index 5d0bbfd..3b60010 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2074,8 +2074,9 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 }
 
 static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
-                             uint64_t *non_postcopiable_pending,
-                             uint64_t *postcopiable_pending)
+                             uint64_t *res_precopy_only,
+                             uint64_t *res_compatible,
+                             uint64_t *res_postcopy_only)
 {
     uint64_t remaining_size;
 
@@ -2093,9 +2094,9 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
 
     if (migrate_postcopy_ram()) {
         /* We can do postcopy, and all the data is postcopiable */
-        *postcopiable_pending += remaining_size;
+        *res_compatible += remaining_size;
     } else {
-        *non_postcopiable_pending += remaining_size;
+        *res_precopy_only += remaining_size;
     }
 }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 965a58c..d1bab59 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1209,13 +1209,15 @@ void qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
  * for units that can't do postcopy.
  */
 void qemu_savevm_state_pending(QEMUFile *f, uint64_t max_size,
-                               uint64_t *res_non_postcopiable,
-                               uint64_t *res_postcopiable)
+                               uint64_t *res_precopy_only,
+                               uint64_t *res_compatible,
+                               uint64_t *res_postcopy_only)
 {
     SaveStateEntry *se;
 
-    *res_non_postcopiable = 0;
-    *res_postcopiable = 0;
+    *res_precopy_only = 0;
+    *res_compatible = 0;
+    *res_postcopy_only = 0;
 
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
@@ -1227,8 +1229,8 @@ void qemu_savevm_state_pending(QEMUFile *f, uint64_t max_size,
                 continue;
             }
         }
-        se->ops->save_live_pending(f, se->opaque, max_size,
-                                   res_non_postcopiable, res_postcopiable);
+        se->ops->save_live_pending(f, se->opaque, max_size, res_precopy_only,
+                                   res_compatible, res_postcopy_only);
     }
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index fa660e3..0212929 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -80,7 +80,7 @@ migrate_fd_cleanup(void) ""
 migrate_fd_error(const char *error_desc) "error=%s"
 migrate_fd_cancel(void) ""
 migrate_handle_rp_req_pages(const char *rbname, size_t start, size_t len) "in %s at %zx len %zx"
-migrate_pending(uint64_t size, uint64_t max, uint64_t post, uint64_t nonpost) "pending size %" PRIu64 " max %" PRIu64 " (post=%" PRIu64 " nonpost=%" PRIu64 ")"
+migrate_pending(uint64_t size, uint64_t max, uint64_t pre, uint64_t compat, uint64_t post) "pending size %" PRIu64 " max %" PRIu64 " (pre = %" PRIu64 " compat=%" PRIu64 " post=%" PRIu64 ")"
 migrate_send_rp_message(int msg_type, uint16_t len) "%d: len %d"
 migration_completion_file_err(void) ""
 migration_completion_postcopy_end(void) ""
-- 
1.8.3.1
