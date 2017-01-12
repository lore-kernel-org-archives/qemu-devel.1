Received: from eggs.gnu.org ([2001:4830:134:3::10]:36910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cRhgi-00016c-US
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:53:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cRhge-0001SZ-EN
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:53:17 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cRhge-0001SQ-9E
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:53:12 -0500
Received: by mail-pf0-x241.google.com with SMTP id f144so4072537pfa.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 07:53:12 -0800 (PST)
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 12 Jan 2017 21:22:34 +0530
Message-Id: <1484236354-9640-5-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1484236354-9640-1-git-send-email-ashijeetacharya@gmail.com>
References: <1484236354-9640-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v5 4/4] migration: Fail migration blocker for
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
 migration/migration.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index cca820e..054048d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1113,6 +1113,14 @@ static GSList *migration_blockers;
 
 int migrate_add_blocker(Error *reason, Error **errp)
 {
+    if (only_migratable) {
+        error_propagate(errp, reason);
+        error_prepend(errp, "disallowing migration blocker "
+                          "(--only_migratable) for: ");
+        error_free(reason);
+        return -EACCES;
+    }
+
     if (migration_is_idle(NULL)) {
         migration_blockers = g_slist_prepend(migration_blockers, reason);
         return 0;
-- 
2.6.2
