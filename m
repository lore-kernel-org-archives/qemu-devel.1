Received: from eggs.gnu.org ([2001:4830:134:3::10]:49903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dkPWO-0002U3-TQ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dkPWO-0007dX-56
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:52:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dkPWN-0007dH-VP
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:52:12 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 23 Aug 2017 14:51:11 +0800
Message-Id: <1503471071-2233-9-git-send-email-peterx@redhat.com>
In-Reply-To: <1503471071-2233-1-git-send-email-peterx@redhat.com>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 8/8] migration: add incoming mgmt lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Now at least migrate_incoming can be run in parallel.  Let's provide a
migration lock to protect it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 6 ++++++
 migration/migration.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index c3fe0ed..32058f7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -145,6 +145,7 @@ MigrationIncomingState *migration_incoming_get_current(void)
         mis_current.state = MIGRATION_STATUS_NONE;
         memset(&mis_current, 0, sizeof(MigrationIncomingState));
         qemu_mutex_init(&mis_current.rp_mutex);
+        qemu_mutex_init(&mis_current.mgmt_mutex);
         qemu_event_init(&mis_current.main_thread_load_event, false);
         once = true;
     }
@@ -1171,6 +1172,7 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
 {
     Error *local_err = NULL;
     static bool once = true;
+    MigrationIncomingState *mis = migration_incoming_get_current();
 
     if (!deferred_incoming) {
         error_setg(errp, "For use with '-incoming defer'");
@@ -1180,8 +1182,12 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
         error_setg(errp, "The incoming migration has already been started");
     }
 
+    qemu_mutex_lock(&mis->mgmt_mutex);
+
     qemu_start_incoming_migration(uri, &local_err);
 
+    qemu_mutex_unlock(&mis->mgmt_mutex);
+
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/migration/migration.h b/migration/migration.h
index 148c9fa..95f077b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -58,6 +58,9 @@ struct MigrationIncomingState {
     /* The coroutine we should enter (back) after failover */
     Coroutine *migration_incoming_co;
     QemuSemaphore colo_incoming_sem;
+
+    /* Migration incoming management lock */
+    QemuMutex mgmt_mutex;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
-- 
2.7.4
