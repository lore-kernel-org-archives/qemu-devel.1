Received: from eggs.gnu.org ([2001:4830:134:3::10]:54116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dG0yd-0004lX-JJ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dG0yc-0002Aq-FP
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:35:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dG0yc-0002AU-70
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:35:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E04237EEE
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 10:35:41 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 31 May 2017 18:35:34 +0800
Message-Id: <1496226934-29752-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH] migration: isolate return path on src
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

There are some places that binded "return path" with postcopy. Let's be
prepared for its usage even without postcopy. This patch mainly did this
on source side.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
standalone patch isolated from the return path series. ok to be picked
up in case one day we'll re-face the return path enablement.
With it, we are ready on source side. The dst side change has been queued.
---
 migration/migration.c  | 11 ++++++-----
 migration/trace-events |  4 ++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ad29e53..96e549e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1850,13 +1850,12 @@ static void migration_completion(MigrationState *s, int current_active_state,
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
@@ -1931,13 +1930,15 @@ static void *migration_thread(void *opaque)
 
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
