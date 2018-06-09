Received: from eggs.gnu.org ([2001:4830:134:3::10]:37502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRfk1-0008N0-Fx
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRfjv-0007hV-9s
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:25:21 -0400
Received: from relay.sw.ru ([195.214.232.25]:52220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1fRfjv-0007gt-1D
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:25:15 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat,  9 Jun 2018 17:14:57 +0300
Message-Id: <20180609141457.6283-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] migration: invalidate cache before source start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com

Invalidate cache before source start in case of failed migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

 migration/migration.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1e99ec9b7e..8f39e0dc02 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2806,7 +2806,14 @@ static void migration_iteration_finish(MigrationState *s)
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_CANCELLED:
         if (s->vm_was_running) {
-            vm_start();
+            Error *local_err = NULL;
+            bdrv_invalidate_cache_all(&local_err);
+            if (local_err) {
+                error_reportf_err(local_err, "Can't invalidate disks before "
+                                  "source vm start");
+            } else {
+                vm_start();
+            }
         } else {
             if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
                 runstate_set(RUN_STATE_POSTMIGRATE);
-- 
2.11.1
