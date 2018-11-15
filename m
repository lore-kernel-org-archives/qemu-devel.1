Received: from eggs.gnu.org ([2001:4830:134:3::10]:57635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gNF5G-0003l7-Es
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gNF5F-0000st-IJ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:41:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:14567)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gNF5F-0000oM-A1
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:41:13 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu, 15 Nov 2018 18:08:01 +0800
Message-Id: <1542276484-25508-6-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v9 5/8] migration/ram.c: add a notifier chain
 for precopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: peterx@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com, wei.w.wang@intel.com

This patch adds a notifier chain for the memory precopy. This enables various
precopy optimizations to be invoked at specific places.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 12 ++++++++++++
 migration/ram.c          | 31 +++++++++++++++++++++++++++++++
 vl.c                     |  1 +
 3 files changed, 44 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 113320e..0bac623 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -19,6 +19,18 @@
 
 /* migration/ram.c */
 
+typedef enum PrecopyNotifyReason {
+    PRECOPY_NOTIFY_ERR = 0,
+    PRECOPY_NOTIFY_START_ITERATION = 1,
+    PRECOPY_NOTIFY_BEFORE_SYNC_BITMAP = 2,
+    PRECOPY_NOTIFY_AFTER_SYNC_BITMAP = 3,
+    PRECOPY_NOTIFY_MAX = 4,
+} PrecopyNotifyReason;
+
+void precopy_infrastructure_init(void);
+void precopy_add_notifier(Notifier *n);
+void precopy_remove_notifier(Notifier *n);
+
 void ram_mig_init(void);
 void qemu_guest_free_page_hint(void *addr, size_t len);
 
diff --git a/migration/ram.c b/migration/ram.c
index 229b791..65b1223 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -292,6 +292,8 @@ struct RAMState {
     bool ram_bulk_stage;
     /* How many times we have dirty too many pages */
     int dirty_rate_high_cnt;
+    /* ram save states used for notifiers */
+    int ram_save_state;
     /* these variables are used for bitmap sync */
     /* last time we did a full bitmap_sync */
     int64_t time_last_bitmap_sync;
@@ -328,6 +330,28 @@ typedef struct RAMState RAMState;
 
 static RAMState *ram_state;
 
+static NotifierList precopy_notifier_list;
+
+void precopy_infrastructure_init(void)
+{
+    notifier_list_init(&precopy_notifier_list);
+}
+
+void precopy_add_notifier(Notifier *n)
+{
+    notifier_list_add(&precopy_notifier_list, n);
+}
+
+void precopy_remove_notifier(Notifier *n)
+{
+    notifier_remove(n);
+}
+
+static void precopy_notify(PrecopyNotifyReason reason)
+{
+    notifier_list_notify(&precopy_notifier_list, &reason);
+}
+
 uint64_t ram_bytes_remaining(void)
 {
     return ram_state ? (ram_state->migration_dirty_pages * TARGET_PAGE_SIZE) :
@@ -1642,6 +1666,8 @@ static void migration_bitmap_sync(RAMState *rs)
     int64_t end_time;
     uint64_t bytes_xfer_now;
 
+    precopy_notify(PRECOPY_NOTIFY_BEFORE_SYNC_BITMAP);
+
     ram_counters.dirty_sync_count++;
 
     if (!rs->time_last_bitmap_sync) {
@@ -1699,6 +1725,8 @@ static void migration_bitmap_sync(RAMState *rs)
     if (migrate_use_events()) {
         qapi_event_send_migration_pass(ram_counters.dirty_sync_count);
     }
+
+    precopy_notify(PRECOPY_NOTIFY_AFTER_SYNC_BITMAP);
 }
 
 /**
@@ -2555,6 +2583,8 @@ static void ram_state_reset(RAMState *rs)
     rs->last_page = 0;
     rs->last_version = ram_list.version;
     rs->ram_bulk_stage = true;
+
+    precopy_notify(PRECOPY_NOTIFY_START_ITERATION);
 }
 
 #define MAX_WAIT 50 /* ms, half buffered_file limit */
@@ -3324,6 +3354,7 @@ out:
 
     ret = qemu_file_get_error(f);
     if (ret < 0) {
+        precopy_notify(PRECOPY_NOTIFY_ERR);
         return ret;
     }
 
diff --git a/vl.c b/vl.c
index fa25d1a..48ae0e8 100644
--- a/vl.c
+++ b/vl.c
@@ -3057,6 +3057,7 @@ int main(int argc, char **argv, char **envp)
     module_call_init(MODULE_INIT_OPTS);
 
     runstate_init();
+    precopy_infrastructure_init();
     postcopy_infrastructure_init();
     monitor_init_globals();
 
-- 
1.8.3.1
