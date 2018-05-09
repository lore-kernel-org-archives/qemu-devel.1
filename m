Received: from eggs.gnu.org ([2001:4830:134:3::10]:58793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDU-0004yU-Bc
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDT-0001lz-EB
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:25:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53784 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGNDT-0001lY-8w
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:25:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD5AB818F6EB
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:25:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:23:57 +0200
Message-Id: <20180509112406.6183-33-quintela@redhat.com>
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 32/41] migration: init dst in
 migration_object_init too
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

Though we may not need it, now we init both the src/dst migration
objects in migration_object_init() so that even incoming migration
object would be thread safe (it was not).

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-20-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 240960d951..c1832b0263 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -106,6 +106,7 @@ enum mig_rp_message_type {
    dynamic creation of migration */
 
 static MigrationState *current_migration;
+static MigrationIncomingState *current_incoming;
 
 static bool migration_object_check(MigrationState *ms, Error **errp);
 static int migration_maybe_pause(MigrationState *s,
@@ -121,6 +122,22 @@ void migration_object_init(void)
     assert(!current_migration);
     current_migration = MIGRATION_OBJ(object_new(TYPE_MIGRATION));
 
+    /*
+     * Init the migrate incoming object as well no matter whether
+     * we'll use it or not.
+     */
+    assert(!current_incoming);
+    current_incoming = g_new0(MigrationIncomingState, 1);
+    current_incoming->state = MIGRATION_STATUS_NONE;
+    current_incoming->postcopy_remote_fds =
+        g_array_new(FALSE, TRUE, sizeof(struct PostCopyFD));
+    qemu_mutex_init(&current_incoming->rp_mutex);
+    qemu_event_init(&current_incoming->main_thread_load_event, false);
+    qemu_sem_init(&current_incoming->postcopy_pause_sem_dst, 0);
+    qemu_sem_init(&current_incoming->postcopy_pause_sem_fault, 0);
+
+    init_dirty_bitmap_incoming_migration();
+
     if (!migration_object_check(current_migration, &err)) {
         error_report_err(err);
         exit(1);
@@ -151,24 +168,8 @@ MigrationState *migrate_get_current(void)
 
 MigrationIncomingState *migration_incoming_get_current(void)
 {
-    static bool once;
-    static MigrationIncomingState mis_current;
-
-    if (!once) {
-        mis_current.state = MIGRATION_STATUS_NONE;
-        memset(&mis_current, 0, sizeof(MigrationIncomingState));
-        mis_current.postcopy_remote_fds = g_array_new(FALSE, TRUE,
-                                                   sizeof(struct PostCopyFD));
-        qemu_mutex_init(&mis_current.rp_mutex);
-        qemu_event_init(&mis_current.main_thread_load_event, false);
-        qemu_sem_init(&mis_current.postcopy_pause_sem_dst, 0);
-        qemu_sem_init(&mis_current.postcopy_pause_sem_fault, 0);
-
-        init_dirty_bitmap_incoming_migration();
-
-        once = true;
-    }
-    return &mis_current;
+    assert(current_incoming);
+    return current_incoming;
 }
 
 void migration_incoming_state_destroy(void)
-- 
2.17.0
