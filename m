Received: from eggs.gnu.org ([2001:4830:134:3::10]:57013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiTy-00012b-IA
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiTw-0003IP-1y
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKiTv-0003IE-Qj
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4A68145F91
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:51:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 13 Jun 2017 11:51:07 +0200
Message-Id: <20170613095120.11373-2-quintela@redhat.com>
In-Reply-To: <20170613095120.11373-1-quintela@redhat.com>
References: <20170613095120.11373-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 01/14] migration: isolate return path on src
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

There are some places that binded "return path" with postcopy. Let's be
prepared for its usage even without postcopy. This patch mainly did this
on source side.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c  | 11 ++++++-----
 migration/trace-events |  4 ++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index fc95acb..9dfa19a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1857,13 +1857,12 @@ static void migration_completion(MigrationState *s, int current_active_state,
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
@@ -1938,13 +1937,15 @@ static void *migration_thread(void *opaque)
 
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
2.9.4
