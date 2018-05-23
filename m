Received: from eggs.gnu.org ([2001:4830:134:3::10]:50851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fLRmm-0006F6-7s
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fLRml-0007CS-D3
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:18:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fLRml-0007CK-99
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:18:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7633195478
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 11:18:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 23 May 2018 13:18:09 +0200
Message-Id: <20180523111817.1463-5-quintela@redhat.com>
In-Reply-To: <20180523111817.1463-1-quintela@redhat.com>
References: <20180523111817.1463-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v13 04/12] migration: Calculate transferred ram
 correctly
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

On multifd we send data from more places that main channel.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 05aec2c905..55d7b64e24 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2679,12 +2679,19 @@ static void migration_update_counters(MigrationState *s,
 {
     uint64_t transferred, time_spent;
     double bandwidth;
+    uint64_t now;
 
     if (current_time < s->iteration_start_time + BUFFER_DELAY) {
         return;
     }
 
-    transferred = qemu_ftell(s->to_dst_file) - s->iteration_initial_bytes;
+    if (migrate_use_multifd()) {
+        now = ram_counters.normal * qemu_target_page_size()
+            + qemu_ftell(s->to_dst_file);
+    } else {
+        now = qemu_ftell(s->to_dst_file);
+    }
+    transferred = now - s->iteration_initial_bytes;
     time_spent = current_time - s->iteration_start_time;
     bandwidth = (double)transferred / time_spent;
     s->threshold_size = bandwidth * s->parameters.downtime_limit;
@@ -2704,7 +2711,7 @@ static void migration_update_counters(MigrationState *s,
     qemu_file_reset_rate_limit(s->to_dst_file);
 
     s->iteration_start_time = current_time;
-    s->iteration_initial_bytes = qemu_ftell(s->to_dst_file);
+    s->iteration_initial_bytes = now;
 
     trace_migrate_transferred(transferred, time_spent,
                               bandwidth, s->threshold_size);
-- 
2.17.0
