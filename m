Received: from eggs.gnu.org ([2001:4830:134:3::10]:51622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gWdrh-0002W5-6h
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 03:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gWdrf-0006Jq-AZ
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 03:58:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:27021)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gWdre-0006FH-UQ
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 03:58:03 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue, 11 Dec 2018 16:24:51 +0800
Message-Id: <1544516693-5395-6-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1544516693-5395-1-git-send-email-wei.w.wang@intel.com>
References: <1544516693-5395-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v11 5/7] migration/ram.c: add a notifier chain
 for precopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Cc: pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com, wei.w.wang@intel.com

This patch adds a notifier chain for the memory precopy. This enables various
precopy optimizations to be invoked at specific places.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 19 ++++++++++++++++++
 migration/ram.c          | 51 +++++++++++++++++++++++++++++++++++++++++++++---
 migration/savevm.c       | 15 ++++++++++++++
 vl.c                     |  1 +
 4 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 113320e..15f8d00 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -19,6 +19,25 @@
 
 /* migration/ram.c */
 
+typedef enum PrecopyNotifyReason {
+    PRECOPY_NOTIFY_SETUP = 0,
+    PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC = 1,
+    PRECOPY_NOTIFY_AFTER_BITMAP_SYNC = 2,
+    PRECOPY_NOTIFY_COMPLETE = 3,
+    PRECOPY_NOTIFY_CLEANUP = 4,
+    PRECOPY_NOTIFY_MAX = 5,
+} PrecopyNotifyReason;
+
+typedef struct PrecopyNotifyData {
+    enum PrecopyNotifyReason reason;
+    Error **errp;
+} PrecopyNotifyData;
+
+void precopy_infrastructure_init(void);
+void precopy_add_notifier(NotifierWithReturn *n);
+void precopy_remove_notifier(NotifierWithReturn *n);
+int precopy_notify(PrecopyNotifyReason reason, Error **errp);
+
 void ram_mig_init(void);
 void qemu_guest_free_page_hint(void *addr, size_t len);
 
diff --git a/migration/ram.c b/migration/ram.c
index c13b44f..1e00d92 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -328,6 +328,32 @@ typedef struct RAMState RAMState;
 
 static RAMState *ram_state;
 
+static NotifierWithReturnList precopy_notifier_list;
+
+void precopy_infrastructure_init(void)
+{
+    notifier_with_return_list_init(&precopy_notifier_list);
+}
+
+void precopy_add_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_list_add(&precopy_notifier_list, n);
+}
+
+void precopy_remove_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_remove(n);
+}
+
+int precopy_notify(PrecopyNotifyReason reason, Error **errp)
+{
+    PrecopyNotifyData pnd;
+    pnd.reason = reason;
+    pnd.errp = errp;
+
+    return notifier_with_return_list_notify(&precopy_notifier_list, &pnd);
+}
+
 uint64_t ram_bytes_remaining(void)
 {
     return ram_state ? (ram_state->migration_dirty_pages * TARGET_PAGE_SIZE) :
@@ -1701,6 +1727,25 @@ static void migration_bitmap_sync(RAMState *rs)
     }
 }
 
+static void migration_bitmap_sync_precopy(RAMState *rs)
+{
+    Error *local_err = NULL;
+
+    /*
+     * The current notifier usage is just an optimization to migration, so we
+     * don't stop the normal migration process in the error case.
+     */
+    if (precopy_notify(PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC, &local_err)) {
+        error_report_err(local_err);
+    }
+
+    migration_bitmap_sync(rs);
+
+    if (precopy_notify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC, &local_err)) {
+        error_report_err(local_err);
+    }
+}
+
 /**
  * save_zero_page_to_file: send the zero page to the file
  *
@@ -3072,7 +3117,7 @@ static void ram_init_bitmaps(RAMState *rs)
 
     ram_list_init_bitmaps();
     memory_global_dirty_log_start();
-    migration_bitmap_sync(rs);
+    migration_bitmap_sync_precopy(rs);
 
     rcu_read_unlock();
     qemu_mutex_unlock_ramlist();
@@ -3348,7 +3393,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     rcu_read_lock();
 
     if (!migration_in_postcopy()) {
-        migration_bitmap_sync(rs);
+        migration_bitmap_sync_precopy(rs);
     }
 
     ram_control_before_iterate(f, RAM_CONTROL_FINISH);
@@ -3397,7 +3442,7 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
         remaining_size < max_size) {
         qemu_mutex_lock_iothread();
         rcu_read_lock();
-        migration_bitmap_sync(rs);
+        migration_bitmap_sync_precopy(rs);
         rcu_read_unlock();
         qemu_mutex_unlock_iothread();
         remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
diff --git a/migration/savevm.c b/migration/savevm.c
index 9e45fb4..ec74f44 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1018,6 +1018,7 @@ void qemu_savevm_state_header(QEMUFile *f)
 void qemu_savevm_state_setup(QEMUFile *f)
 {
     SaveStateEntry *se;
+    Error *local_err = NULL;
     int ret;
 
     trace_savevm_state_setup();
@@ -1039,6 +1040,10 @@ void qemu_savevm_state_setup(QEMUFile *f)
             break;
         }
     }
+
+    if (precopy_notify(PRECOPY_NOTIFY_SETUP, &local_err)) {
+        error_report_err(local_err);
+    }
 }
 
 int qemu_savevm_state_resume_prepare(MigrationState *s)
@@ -1181,6 +1186,11 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
     SaveStateEntry *se;
     int ret;
     bool in_postcopy = migration_in_postcopy();
+    Error *local_err = NULL;
+
+    if (precopy_notify(PRECOPY_NOTIFY_COMPLETE, &local_err)) {
+        error_report_err(local_err);
+    }
 
     trace_savevm_state_complete_precopy();
 
@@ -1313,6 +1323,11 @@ void qemu_savevm_state_pending(QEMUFile *f, uint64_t threshold_size,
 void qemu_savevm_state_cleanup(void)
 {
     SaveStateEntry *se;
+    Error *local_err = NULL;
+
+    if (precopy_notify(PRECOPY_NOTIFY_CLEANUP, &local_err)) {
+        error_report_err(local_err);
+    }
 
     trace_savevm_state_cleanup();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
diff --git a/vl.c b/vl.c
index a5ae5f2..1621e1c 100644
--- a/vl.c
+++ b/vl.c
@@ -3062,6 +3062,7 @@ int main(int argc, char **argv, char **envp)
     module_call_init(MODULE_INIT_OPTS);
 
     runstate_init();
+    precopy_infrastructure_init();
     postcopy_infrastructure_init();
     monitor_init_globals();
 
-- 
1.8.3.1
