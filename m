Received: from eggs.gnu.org ([2001:4830:134:3::10]:53524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fXsZ9-000382-Ss
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fXsZ8-0001ig-38
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:19:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47798 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fXsZ7-0001ib-VE
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:19:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 918DC818F02E
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 18:19:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 26 Jun 2018 20:19:22 +0200
Message-Id: <20180626181932.11909-4-quintela@redhat.com>
In-Reply-To: <20180626181932.11909-1-quintela@redhat.com>
References: <20180626181932.11909-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v16 04/14] migration: Abstract the number of
 bytes sent
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

Right now we use the "position" inside the QEMUFile, but things like
RDMA already do weird things to be able to maintain that counter
right, and multifd will have some similar problems.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d3e6da9bfe..264f3ce84e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2704,9 +2704,15 @@ static MigThrError migration_detect_error(MigrationState *s)
     }
 }
 
+/* How many bytes have we transferred since the beggining of the migration */
+static uint64_t migration_total_bytes(MigrationState *s)
+{
+    return qemu_ftell(s->to_dst_file);
+}
+
 static void migration_calculate_complete(MigrationState *s)
 {
-    uint64_t bytes = qemu_ftell(s->to_dst_file);
+    uint64_t bytes = migration_total_bytes(s);
     int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     int64_t transfer_time;
 
@@ -2729,13 +2735,15 @@ static void migration_update_counters(MigrationState *s,
                                       int64_t current_time)
 {
     uint64_t transferred, time_spent;
+    uint64_t current_bytes; /* bytes transferred since the beginning */
     double bandwidth;
 
     if (current_time < s->iteration_start_time + BUFFER_DELAY) {
         return;
     }
 
-    transferred = qemu_ftell(s->to_dst_file) - s->iteration_initial_bytes;
+    current_bytes = migration_total_bytes(s);
+    transferred = current_bytes - s->iteration_initial_bytes;
     time_spent = current_time - s->iteration_start_time;
     bandwidth = (double)transferred / time_spent;
     s->threshold_size = bandwidth * s->parameters.downtime_limit;
@@ -2754,7 +2762,7 @@ static void migration_update_counters(MigrationState *s,
     qemu_file_reset_rate_limit(s->to_dst_file);
 
     s->iteration_start_time = current_time;
-    s->iteration_initial_bytes = qemu_ftell(s->to_dst_file);
+    s->iteration_initial_bytes = current_bytes;
 
     trace_migrate_transferred(transferred, time_spent,
                               bandwidth, s->threshold_size);
-- 
2.17.1
