Received: from eggs.gnu.org ([2001:4830:134:3::10]:36324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJST-0000g7-8G
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJSS-0007Cl-Cw
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJSS-0007Ca-7L
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:28 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:27 +0800
Message-Id: <20171108060130.3772-30-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 29/32] migration: init dst in
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
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Though we may not need it, now we init both the src/dst migration
objects in migration_object_init() so that even incoming migration
object would be thread safe (it was not).

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 9b7fc56ed8..536a771803 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -104,6 +104,7 @@ enum mig_rp_message_type {
    dynamic creation of migration */
 
 static MigrationState *current_migration;
+static MigrationIncomingState *current_incoming;
 
 static bool migration_object_check(MigrationState *ms, Error **errp);
 static int migration_maybe_pause(MigrationState *s,
@@ -119,6 +120,18 @@ void migration_object_init(void)
     assert(!current_migration);
     current_migration = MIGRATION_OBJ(object_new(TYPE_MIGRATION));
 
+    /*
+     * Init the migrate incoming object as well no matter whether
+     * we'll use it or not.
+     */
+    assert(!current_incoming);
+    current_incoming = g_new0(MigrationIncomingState, 1);
+    current_incoming->state = MIGRATION_STATUS_NONE;
+    qemu_mutex_init(&current_incoming->rp_mutex);
+    qemu_event_init(&current_incoming->main_thread_load_event, false);
+    qemu_sem_init(&current_incoming->postcopy_pause_sem_dst, 0);
+    qemu_sem_init(&current_incoming->postcopy_pause_sem_fault, 0);
+
     if (!migration_object_check(current_migration, &err)) {
         error_report_err(err);
         exit(1);
@@ -144,19 +157,8 @@ MigrationState *migrate_get_current(void)
 
 MigrationIncomingState *migration_incoming_get_current(void)
 {
-    static bool once;
-    static MigrationIncomingState mis_current;
-
-    if (!once) {
-        mis_current.state = MIGRATION_STATUS_NONE;
-        memset(&mis_current, 0, sizeof(MigrationIncomingState));
-        qemu_mutex_init(&mis_current.rp_mutex);
-        qemu_event_init(&mis_current.main_thread_load_event, false);
-        qemu_sem_init(&mis_current.postcopy_pause_sem_dst, 0);
-        qemu_sem_init(&mis_current.postcopy_pause_sem_fault, 0);
-        once = true;
-    }
-    return &mis_current;
+    assert(current_incoming);
+    return current_incoming;
 }
 
 void migration_incoming_state_destroy(void)
-- 
2.13.6
