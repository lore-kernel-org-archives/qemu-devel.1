Received: from eggs.gnu.org ([2001:4830:134:3::10]:50059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1edagi-0007wq-7r
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1edagf-0002TD-6y
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:54:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:46677)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1edage-0002SK-UT
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:54:53 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 22 Jan 2018 19:36:39 +0800
Message-Id: <1516620999-25669-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2] migration: use s->threshold_size inside
 migration_update_counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: Wei Wang <wei.w.wang@intel.com>

Fixes: b15df1ae50 ("migration: cleanup stats update into function")
The threshold size is changed to be recorded in s->threshold_size.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

v1->v2 change:
	only commit log description change

diff --git a/migration/migration.c b/migration/migration.c
index d3a1c49..bfd1a16 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2212,7 +2212,6 @@ static void migration_update_counters(MigrationState *s,
                                       int64_t current_time)
 {
     uint64_t transferred, time_spent;
-    int64_t threshold_size;
     double bandwidth;
 
     if (current_time < s->iteration_start_time + BUFFER_DELAY) {
@@ -2222,7 +2221,7 @@ static void migration_update_counters(MigrationState *s,
     transferred = qemu_ftell(s->to_dst_file) - s->iteration_initial_bytes;
     time_spent = current_time - s->iteration_start_time;
     bandwidth = (double)transferred / time_spent;
-    threshold_size = bandwidth * s->parameters.downtime_limit;
+    s->threshold_size = bandwidth * s->parameters.downtime_limit;
 
     s->mbps = (((double) transferred * 8.0) /
                ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
@@ -2242,7 +2241,7 @@ static void migration_update_counters(MigrationState *s,
     s->iteration_initial_bytes = qemu_ftell(s->to_dst_file);
 
     trace_migrate_transferred(transferred, time_spent,
-                              bandwidth, threshold_size);
+                              bandwidth, s->threshold_size);
 }
 
 /* Migration thread iteration status */
-- 
1.8.3.1
