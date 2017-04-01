Received: from eggs.gnu.org ([2001:4830:134:3::10]:58026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cuEFW-0002y8-JM
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 04:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cuEFV-00048r-Cr
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 04:19:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cuEFV-00047t-3s
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 04:19:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D47D85365
	for <qemu-devel@nongnu.org>; Sat,  1 Apr 2017 08:19:04 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Sat,  1 Apr 2017 16:18:43 +0800
Message-Id: <1491034725-23968-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1491034725-23968-1-git-send-email-peterx@redhat.com>
References: <1491034725-23968-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] migration: rename max_size to
 threshold_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "\\  Dr . David Alan Gilbert \\ " <dgilbert@redhat.com>, peterx@redhat.com

In migration codes (especially in migration_thread()), max_size is used
in many place for the threshold value that we will start to do the final
flush and jump to the next stage to dump the whole rest things to
destination. However its name is confusing to first readers. Let's
rename it to "threshold_size" when proper and add a comment for it. No
functional change is made.

CC: Juan Quintela <quintela@redhat.com>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reviewed-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h |  3 ++-
 migration/migration.c       | 21 +++++++++++++--------
 migration/savevm.c          |  4 ++--
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f2dbf84..dad3984 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -56,7 +56,8 @@ typedef struct SaveVMHandlers {
 
     /* This runs outside the iothread lock!  */
     int (*save_live_setup)(QEMUFile *f, void *opaque);
-    void (*save_live_pending)(QEMUFile *f, void *opaque, uint64_t max_size,
+    void (*save_live_pending)(QEMUFile *f, void *opaque,
+                              uint64_t threshold_size,
                               uint64_t *non_postcopiable_pending,
                               uint64_t *postcopiable_pending);
     LoadStateHandler *load_state;
diff --git a/migration/migration.c b/migration/migration.c
index f9f4d98..2785c6c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1907,7 +1907,12 @@ static void *migration_thread(void *opaque)
     int64_t initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     int64_t initial_bytes = 0;
-    int64_t max_size = 0;
+    /*
+     * The final stage happens when the remaining data is smaller than
+     * this threshold; it's calculated from the requested downtime and
+     * measured bandwidth
+     */
+    int64_t threshold_size = 0;
     int64_t start_time = initial_time;
     int64_t end_time;
     bool old_vm_running = false;
@@ -1951,17 +1956,17 @@ static void *migration_thread(void *opaque)
         if (!qemu_file_rate_limit(s->to_dst_file)) {
             uint64_t pend_post, pend_nonpost;
 
-            qemu_savevm_state_pending(s->to_dst_file, max_size, &pend_nonpost,
-                                      &pend_post);
+            qemu_savevm_state_pending(s->to_dst_file, threshold_size,
+                                      &pend_nonpost, &pend_post);
             pending_size = pend_nonpost + pend_post;
-            trace_migrate_pending(pending_size, max_size,
+            trace_migrate_pending(pending_size, threshold_size,
                                   pend_post, pend_nonpost);
-            if (pending_size && pending_size >= max_size) {
+            if (pending_size && pending_size >= threshold_size) {
                 /* Still a significant amount to transfer */
 
                 if (migrate_postcopy_ram() &&
                     s->state != MIGRATION_STATUS_POSTCOPY_ACTIVE &&
-                    pend_nonpost <= max_size &&
+                    pend_nonpost <= threshold_size &&
                     atomic_read(&s->start_postcopy)) {
 
                     if (!postcopy_start(s, &old_vm_running)) {
@@ -1993,13 +1998,13 @@ static void *migration_thread(void *opaque)
                                          initial_bytes;
             uint64_t time_spent = current_time - initial_time;
             double bandwidth = (double)transferred_bytes / time_spent;
-            max_size = bandwidth * s->parameters.downtime_limit;
+            threshold_size = bandwidth * s->parameters.downtime_limit;
 
             s->mbps = (((double) transferred_bytes * 8.0) /
                     ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
 
             trace_migrate_transferred(transferred_bytes, time_spent,
-                                      bandwidth, max_size);
+                                      bandwidth, threshold_size);
             /* if we haven't sent anything, we don't want to recalculate
                10000 is a small enough number for our purposes */
             if (s->dirty_bytes_rate && transferred_bytes > 10000) {
diff --git a/migration/savevm.c b/migration/savevm.c
index 3b19a4a..59c04eb 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1197,7 +1197,7 @@ void qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
  * the result is split into the amount for units that can and
  * for units that can't do postcopy.
  */
-void qemu_savevm_state_pending(QEMUFile *f, uint64_t max_size,
+void qemu_savevm_state_pending(QEMUFile *f, uint64_t threshold_size,
                                uint64_t *res_non_postcopiable,
                                uint64_t *res_postcopiable)
 {
@@ -1216,7 +1216,7 @@ void qemu_savevm_state_pending(QEMUFile *f, uint64_t max_size,
                 continue;
             }
         }
-        se->ops->save_live_pending(f, se->opaque, max_size,
+        se->ops->save_live_pending(f, se->opaque, threshold_size,
                                    res_non_postcopiable, res_postcopiable);
     }
 }
-- 
2.7.4
