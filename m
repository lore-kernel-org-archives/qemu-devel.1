Received: from eggs.gnu.org ([2001:4830:134:3::10]:42659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9EfA-0003ry-8P
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9Ef5-0003CZ-Fy
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:19:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 30 Oct 2017 21:19:39 +0300
Message-Id: <20171030181939.130103-1-vsementsov@virtuozzo.com>
In-Reply-To: <20171030163309.75770-6-vsementsov@virtuozzo.com>
References: <20171030163309.75770-6-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v8.1 05/14] migration: introduce postcopy-only
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

8.1: add new version for cmma_save_pending too.


 include/migration/register.h | 17 +++++++++++++++--
 migration/savevm.h           |  5 +++--
 hw/s390x/s390-stattrib.c     |  7 ++++---
 migration/block.c            |  7 ++++---
 migration/migration.c        | 15 ++++++++-------
 migration/ram.c              |  9 +++++----
 migration/savevm.c           | 13 ++++++++-----
 migration/trace-events       |  2 +-
 8 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index f4f7bdc177..9436a87678 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -37,8 +37,21 @@ typedef struct SaveVMHandlers {
     int (*save_setup)(QEMUFile *f, void *opaque);
     void (*save_live_pending)(QEMUFile *f, void *opaque,
                               uint64_t threshold_size,
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
     int (*load_setup)(QEMUFile *f, void *opaque);
     int (*load_cleanup)(void *opaque);
diff --git a/migration/savevm.h b/migration/savevm.h
index 295c4a1f2c..cf4f0d37ca 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -38,8 +38,9 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f);
 int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
                                        bool inactivate_disks);
 void qemu_savevm_state_pending(QEMUFile *f, uint64_t max_size,
-                               uint64_t *res_non_postcopiable,
-                               uint64_t *res_postcopiable);
+                               uint64_t *res_precopy_only,
+                               uint64_t *res_compatible,
+                               uint64_t *res_postcopy_only);
 void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
 void qemu_savevm_send_open_return_path(QEMUFile *f);
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 2902f54f11..dd3fbfd1eb 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -183,15 +183,16 @@ static int cmma_save_setup(QEMUFile *f, void *opaque)
 }
 
 static void cmma_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
-                             uint64_t *non_postcopiable_pending,
-                             uint64_t *postcopiable_pending)
+                              uint64_t *res_precopy_only,
+                              uint64_t *res_compatible,
+                              uint64_t *res_postcopy_only)
 {
     S390StAttribState *sas = S390_STATTRIB(opaque);
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
     long long res = sac->get_dirtycount(sas);
 
     if (res >= 0) {
-        *non_postcopiable_pending += res;
+        *res_precopy_only += res;
     }
 }
 
diff --git a/migration/block.c b/migration/block.c
index 3282809583..39dfa567e8 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -865,8 +865,9 @@ static int block_save_complete(QEMUFile *f, void *opaque)
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
@@ -887,7 +888,7 @@ static void block_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
 
     DPRINTF("Enter save live pending  %" PRIu64 "\n", pending);
     /* We don't do postcopy */
-    *non_postcopiable_pending += pending;
+    *res_precopy_only += pending;
 }
 
 static int block_load(QEMUFile *f, void *opaque, int version_id)
diff --git a/migration/migration.c b/migration/migration.c
index 4de3b551fe..e6c9be3cca 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2216,20 +2216,21 @@ static void *migration_thread(void *opaque)
         uint64_t pending_size;
 
         if (!qemu_file_rate_limit(s->to_dst_file)) {
-            uint64_t pend_post, pend_nonpost;
+            uint64_t pend_pre, pend_compat, pend_post;
 
-            qemu_savevm_state_pending(s->to_dst_file, threshold_size,
-                                      &pend_nonpost, &pend_post);
-            pending_size = pend_nonpost + pend_post;
+            qemu_savevm_state_pending(s->to_dst_file, threshold_size, &pend_pre,
+                                      &pend_compat, &pend_post);
+            pending_size = pend_pre + pend_compat + pend_post;
             trace_migrate_pending(pending_size, threshold_size,
-                                  pend_post, pend_nonpost);
+                                  pend_pre, pend_compat, pend_post);
             if (pending_size && pending_size >= threshold_size) {
                 /* Still a significant amount to transfer */
 
                 if (migrate_postcopy() &&
                     s->state != MIGRATION_STATUS_POSTCOPY_ACTIVE &&
-                    pend_nonpost <= threshold_size &&
-                    atomic_read(&s->start_postcopy)) {
+                    pend_pre <= threshold_size &&
+                    (atomic_read(&s->start_postcopy) ||
+                     (pend_pre + pend_compat <= threshold_size))) {
 
                     if (!postcopy_start(s, &old_vm_running)) {
                         current_active_state = MIGRATION_STATUS_POSTCOPY_ACTIVE;
diff --git a/migration/ram.c b/migration/ram.c
index 8620aa400a..1b664a2d9a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2358,8 +2358,9 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 }
 
 static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
-                             uint64_t *non_postcopiable_pending,
-                             uint64_t *postcopiable_pending)
+                             uint64_t *res_precopy_only,
+                             uint64_t *res_compatible,
+                             uint64_t *res_postcopy_only)
 {
     RAMState **temp = opaque;
     RAMState *rs = *temp;
@@ -2379,9 +2380,9 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
 
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
index 4a88228614..f6b62cb202 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1218,13 +1218,15 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
  * for units that can't do postcopy.
  */
 void qemu_savevm_state_pending(QEMUFile *f, uint64_t threshold_size,
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
@@ -1237,7 +1239,8 @@ void qemu_savevm_state_pending(QEMUFile *f, uint64_t threshold_size,
             }
         }
         se->ops->save_live_pending(f, se->opaque, threshold_size,
-                                   res_non_postcopiable, res_postcopiable);
+                                   res_precopy_only, res_compatible,
+                                   res_postcopy_only);
     }
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index 6f29fcc686..a04fffb877 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -86,7 +86,7 @@ migrate_fd_cleanup(void) ""
 migrate_fd_error(const char *error_desc) "error=%s"
 migrate_fd_cancel(void) ""
 migrate_handle_rp_req_pages(const char *rbname, size_t start, size_t len) "in %s at 0x%zx len 0x%zx"
-migrate_pending(uint64_t size, uint64_t max, uint64_t post, uint64_t nonpost) "pending size %" PRIu64 " max %" PRIu64 " (post=%" PRIu64 " nonpost=%" PRIu64 ")"
+migrate_pending(uint64_t size, uint64_t max, uint64_t pre, uint64_t compat, uint64_t post) "pending size %" PRIu64 " max %" PRIu64 " (pre = %" PRIu64 " compat=%" PRIu64 " post=%" PRIu64 ")"
 migrate_send_rp_message(int msg_type, uint16_t len) "%d: len %d"
 migration_completion_file_err(void) ""
 migration_completion_postcopy_end(void) ""
-- 
2.11.1
