Received: from eggs.gnu.org ([2001:4830:134:3::10]:41319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8G2-0005Za-Lo
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:09:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8G0-0001Jy-LH
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:09:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eg8G0-0001Iz-GA
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:09:52 -0500
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 29 Jan 2018 13:09:23 +0100
Message-Id: <20180129120932.12874-5-quintela@redhat.com>
In-Reply-To: <20180129120932.12874-1-quintela@redhat.com>
References: <20180129120932.12874-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 04/13] migration: use s->threshold_size inside
 migration_update_counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Wei Wang <wei.w.wang@intel.com>

From: Wei Wang <wei.w.wang@intel.com>

Fixes: b15df1ae50 ("migration: cleanup stats update into function")
The threshold size is changed to be recorded in s->threshold_size.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1fbd304c66..44cbfb0ddd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2169,7 +2169,6 @@ static void migration_update_counters(MigrationState *s,
                                       int64_t current_time)
 {
     uint64_t transferred, time_spent;
-    int64_t threshold_size;
     double bandwidth;
 
     if (current_time < s->iteration_start_time + BUFFER_DELAY) {
@@ -2179,7 +2178,7 @@ static void migration_update_counters(MigrationState *s,
     transferred = qemu_ftell(s->to_dst_file) - s->iteration_initial_bytes;
     time_spent = current_time - s->iteration_start_time;
     bandwidth = (double)transferred / time_spent;
-    threshold_size = bandwidth * s->parameters.downtime_limit;
+    s->threshold_size = bandwidth * s->parameters.downtime_limit;
 
     s->mbps = (((double) transferred * 8.0) /
                ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
@@ -2199,7 +2198,7 @@ static void migration_update_counters(MigrationState *s,
     s->iteration_initial_bytes = qemu_ftell(s->to_dst_file);
 
     trace_migrate_transferred(transferred, time_spent,
-                              bandwidth, threshold_size);
+                              bandwidth, s->threshold_size);
 }
 
 /* Migration thread iteration status */
-- 
2.14.3
