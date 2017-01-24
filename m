Received: from eggs.gnu.org ([2001:4830:134:3::10]:55424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68J-0001Mw-SU
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68H-0006s4-9n
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cW68H-0006re-4L
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:53 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44F7E14BFE2
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 18:47:53 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-116-204.ams2.redhat.com
	[10.36.116.204])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0OIlhUw020536
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 13:47:52 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jan 2017 18:47:37 +0000
Message-Id: <20170124184742.1639-11-dgilbert@redhat.com>
In-Reply-To: <20170124184742.1639-1-dgilbert@redhat.com>
References: <20170124184742.1639-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 10/15] migration: Fail migration blocker for
 --only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Ashijeet Acharya <ashijeetacharya@gmail.com>

migrate_add_blocker should rightly fail if the '--only-migratable'
option was specified and the device in use should not be able to
perform the action which results in an unmigratable VM.

Make migrate_add_blocker return -EACCES in this case.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
Message-Id: <1484566314-3987-6-git-send-email-ashijeetacharya@gmail.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/migration.h | 2 +-
 migration/migration.c         | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index bcbdb03..7881e89 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -291,7 +291,7 @@ int ram_postcopy_incoming_init(MigrationIncomingState *mis);
  *
  * @errp - [out] The reason (if any) we cannot block migration right now.
  *
- * @returns - 0 on success, -EBUSY on failure, with errp set.
+ * @returns - 0 on success, -EBUSY/-EACCES on failure, with errp set.
  */
 int migrate_add_blocker(Error *reason, Error **errp);
 
diff --git a/migration/migration.c b/migration/migration.c
index 0d88286..7dcb7d7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1113,6 +1113,13 @@ static GSList *migration_blockers;
 
 int migrate_add_blocker(Error *reason, Error **errp)
 {
+    if (only_migratable) {
+        error_propagate(errp, error_copy(reason));
+        error_prepend(errp, "disallowing migration blocker "
+                          "(--only_migratable) for: ");
+        return -EACCES;
+    }
+
     if (migration_is_idle(NULL)) {
         migration_blockers = g_slist_prepend(migration_blockers, reason);
         return 0;
-- 
2.9.3
