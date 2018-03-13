Received: from eggs.gnu.org ([2001:4830:134:3::10]:34648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFx-0000lS-FP
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFv-0005lo-SZ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1evrFv-0005lU-MU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:47 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 13 Mar 2018 17:14:33 -0400
Message-Id: <20180313211441.5179-6-jsnow@redhat.com>
In-Reply-To: <20180313211441.5179-1-jsnow@redhat.com>
References: <20180313211441.5179-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 05/13] migration: introduce postcopy-only pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

There would be savevm states (dirty-bitmap) which can migrate only in
postcopy stage. The corresponding pending is introduced here.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-id: 20180313180320.339796-6-vsementsov@virtuozzo.com
---
 hw/s390x/s390-stattrib.c     |  7 ++++---
 include/migration/register.h | 17 +++++++++++++++--
 migration/block.c            |  7 ++++---
 migration/migration.c        | 12 ++++++------
 migration/ram.c              |  9 +++++----
 migration/savevm.c           | 13 ++++++++-----
 migration/savevm.h           |  5 +++--
 migration/trace-events       |  2 +-
 8 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index adf07ef312..70b95550a8 100644
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
diff --git a/migration/block.c b/migration/block.c
index 41b95d1dd8..5c03632257 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -864,8 +864,9 @@ static int block_save_complete(QEMUFile *f, void *opaque)
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
@@ -886,7 +887,7 @@ static void block_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
 
     DPRINTF("Enter save live pending  %" PRIu64 "\n", pending);
     /* We don't do postcopy */
-    *non_postcopiable_pending += pending;
+    *res_precopy_only += pending;
 }
 
 static int block_load(QEMUFile *f, void *opaque, int version_id)
diff --git a/migration/migration.c b/migration/migration.c
index 6a4780ef6f..90307f8ab5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2242,20 +2242,20 @@ typedef enum {
  */
 static MigIterateState migration_iteration_run(MigrationState *s)
 {
-    uint64_t pending_size, pend_post, pend_nonpost;
+    uint64_t pending_size, pend_pre, pend_compat, pend_post;
     bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
 
-    qemu_savevm_state_pending(s->to_dst_file, s->threshold_size,
-                              &pend_nonpost, &pend_post);
-    pending_size = pend_nonpost + pend_post;
+    qemu_savevm_state_pending(s->to_dst_file, s->threshold_size, &pend_pre,
+                              &pend_compat, &pend_post);
+    pending_size = pend_pre + pend_compat + pend_post;
 
     trace_migrate_pending(pending_size, s->threshold_size,
-                          pend_post, pend_nonpost);
+                          pend_pre, pend_compat, pend_post);
 
     if (pending_size && pending_size >= s->threshold_size) {
         /* Still a significant amount to transfer */
         if (migrate_postcopy() && !in_postcopy &&
-            pend_nonpost <= s->threshold_size &&
+            pend_pre <= s->threshold_size &&
             atomic_read(&s->start_postcopy)) {
             if (postcopy_start(s)) {
                 error_report("%s: postcopy failed to start", __func__);
diff --git a/migration/ram.c b/migration/ram.c
index 7266351fd0..590fceb7e9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2370,8 +2370,9 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
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
@@ -2391,9 +2392,9 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
 
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
index 358c5b51e2..cd5944b81f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1220,13 +1220,15 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
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
@@ -1239,7 +1241,8 @@ void qemu_savevm_state_pending(QEMUFile *f, uint64_t threshold_size,
             }
         }
         se->ops->save_live_pending(f, se->opaque, threshold_size,
-                                   res_non_postcopiable, res_postcopiable);
+                                   res_precopy_only, res_compatible,
+                                   res_postcopy_only);
     }
 }
 
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
diff --git a/migration/trace-events b/migration/trace-events
index 93961dea16..8ec84d82fd 100644
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
2.14.3
