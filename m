Received: from eggs.gnu.org ([2001:4830:134:3::10]:44853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cT5WQ-0000Dk-Hr
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cT5WP-0002eW-Q4
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:32:22 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cT5WP-0002e8-KF
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:32:21 -0500
Received: by mail-pg0-x241.google.com with SMTP id t6so1111405pgt.1
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 03:32:21 -0800 (PST)
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Mon, 16 Jan 2017 17:01:54 +0530
Message-Id: <1484566314-3987-6-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1484566314-3987-1-git-send-email-ashijeetacharya@gmail.com>
References: <1484566314-3987-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v6 5/5] migration: Fail migration blocker for
 --only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: jsnow@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, quintela@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

migrate_add_blocker should rightly fail if the '--only-migratable'
option was specified and the device in use should not be able to
perform the action which results in an unmigratable VM.

Make migrate_add_blocker return -EACCES in this case.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
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
2.6.2
