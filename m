Received: from eggs.gnu.org ([2001:4830:134:3::10]:36733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBbdg-0000YX-HJ
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBbdf-00049l-Dt
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:43:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBbdf-00049g-5L
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:43:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18D5A796E4
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:43:50 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 19 May 2017 14:43:28 +0800
Message-Id: <1495176212-14446-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1495176212-14446-1-git-send-email-peterx@redhat.com>
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 2/6] migration: isolate return path on src
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

There are some places that binded "return path" with postcopy. Let's be
prepared for its usage even without postcopy. This patch mainly did this
on source side.

This has no functional change. But it'll simplify further patches.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  | 50 +++++++++++++++++++++++++++++++++++---------------
 migration/trace-events |  4 ++--
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 0304c01..e4f4c8c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1817,13 +1817,12 @@ static void migration_completion(MigrationState *s, int current_active_state,
      * cleaning everything else up (since if there are no failures
      * it will wait for the destination to send it's status in
      * a SHUT command).
-     * Postcopy opens rp if enabled (even if it's not avtivated)
      */
-    if (migrate_postcopy_ram()) {
+    if (s->rp_state.from_dst_file) {
         int rp_error;
-        trace_migration_completion_postcopy_end_before_rp();
+        trace_migration_return_path_end_before();
         rp_error = await_return_path_close_on_source(s);
-        trace_migration_completion_postcopy_end_after_rp(rp_error);
+        trace_migration_return_path_end_after(rp_error);
         if (rp_error) {
             goto fail_invalidate;
         }
@@ -1898,13 +1897,15 @@ static void *migration_thread(void *opaque)
 
     qemu_savevm_state_header(s->to_dst_file);
 
-    if (migrate_postcopy_ram()) {
+    if (s->to_dst_file) {
         /* Now tell the dest that it should open its end so it can reply */
         qemu_savevm_send_open_return_path(s->to_dst_file);
 
         /* And do a ping that will make stuff easier to debug */
         qemu_savevm_send_ping(s->to_dst_file, 1);
+    }
 
+    if (migrate_postcopy_ram()) {
         /*
          * Tell the destination that we *might* want to do postcopy later;
          * if the other end can't do postcopy it should fail now, nice and
@@ -2044,6 +2045,29 @@ static void *migration_thread(void *opaque)
     return NULL;
 }
 
+/* Return true if success, otherwise false. */
+static bool migrate_return_path_create(MigrationState *s)
+{
+    /* Whether we should enable return path */
+    bool enable_return_path = false;
+    /* Whether we should force its success */
+    bool force_return_path = false;
+
+    if (migrate_postcopy_ram()) {
+        enable_return_path = true;
+        force_return_path = true;
+    }
+
+    if (enable_return_path) {
+        if (open_return_path_on_source(s) && force_return_path) {
+            error_report("Unable to open return-path");
+            return false;
+        }
+    }
+
+    return true;
+}
+
 void migrate_fd_connect(MigrationState *s)
 {
     s->expected_downtime = s->parameters.downtime_limit;
@@ -2057,17 +2081,13 @@ void migrate_fd_connect(MigrationState *s)
     notifier_list_notify(&migration_state_notifiers, s);
 
     /*
-     * Open the return path; currently for postcopy but other things might
-     * also want it.
+     * Open the return path.
      */
-    if (migrate_postcopy_ram()) {
-        if (open_return_path_on_source(s)) {
-            error_report("Unable to open return-path for postcopy");
-            migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                              MIGRATION_STATUS_FAILED);
-            migrate_fd_cleanup(s);
-            return;
-        }
+    if (!migrate_return_path_create(s)) {
+        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
+                          MIGRATION_STATUS_FAILED);
+        migrate_fd_cleanup(s);
+        return;
     }
 
     migrate_compress_threads_create();
diff --git a/migration/trace-events b/migration/trace-events
index 5b8ccf3..38345be 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -88,8 +88,8 @@ migrate_send_rp_message(int msg_type, uint16_t len) "%d: len %d"
 migration_completion_file_err(void) ""
 migration_completion_postcopy_end(void) ""
 migration_completion_postcopy_end_after_complete(void) ""
-migration_completion_postcopy_end_before_rp(void) ""
-migration_completion_postcopy_end_after_rp(int rp_error) "%d"
+migration_return_path_end_before(void) ""
+migration_return_path_end_after(int rp_error) "%d"
 migration_thread_after_loop(void) ""
 migration_thread_file_err(void) ""
 migration_thread_setup_complete(void) ""
-- 
2.7.4
