Received: from eggs.gnu.org ([2001:4830:134:3::10]:48295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhVAc-0005w5-7w
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhVAY-0001B9-VK
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:17:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dhVAY-0001At-MA
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:17:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1E84A036F
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 06:17:37 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 15 Aug 2017 14:17:07 +0800
Message-Id: <1502777827-18874-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1502777827-18874-1-git-send-email-peterx@redhat.com>
References: <1502777827-18874-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 6/6] migration: allow migrate_incoming for paused
 VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

migrate_incoming command is previously only used when we were providing
"-incoming defer" in the command line, to defer the incoming migration
channel creation.

However there is similar requirement when we are paused during postcopy
migration. The old incoming channel might have been destroyed already.
We may need another new channel for the recovery to happen.

This patch leveraged the same interface, but allows the user to specify
incoming migration channel even for paused postcopy.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index daf356b..696cc7c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1288,17 +1288,39 @@ void migrate_del_blocker(Error *reason)
     migration_blockers = g_slist_remove(migration_blockers, reason);
 }
 
+static bool migrate_incoming_detach_listen(MigrationIncomingState *mis)
+{
+    if (mis->listen_task_tag) {
+        /* Never fail */
+        g_source_remove(mis->listen_task_tag);
+        mis->listen_task_tag = 0;
+        return true;
+    }
+    return false;
+}
+
 void qmp_migrate_incoming(const char *uri, Error **errp)
 {
     Error *local_err = NULL;
-    static bool once = true;
+    MigrationIncomingState *mis = migration_incoming_get_current();
 
-    if (!deferred_incoming) {
-        error_setg(errp, "For use with '-incoming defer'");
+    if (!deferred_incoming &&
+        mis->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
+        error_setg(errp, "For use with '-incoming defer'"
+                   " or PAUSED postcopy migration only.");
         return;
     }
-    if (!once) {
-        error_setg(errp, "The incoming migration has already been started");
+
+    /*
+     * Destroy existing listening task if exist. Logically this should
+     * not really happen at all (for either deferred migration or
+     * postcopy migration, we should both detached the listening
+     * task). So raise an error but still we safely detach it.
+     */
+    if (migrate_incoming_detach_listen(mis)) {
+        error_report("%s: detected existing listen channel, "
+                     "while it should not exist", __func__);
+        /* Continue */
     }
 
     qemu_start_incoming_migration(uri, &local_err);
@@ -1307,8 +1329,6 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
-
-    once = false;
 }
 
 bool migration_is_blocked(Error **errp)
-- 
2.7.4
