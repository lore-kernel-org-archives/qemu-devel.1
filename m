Received: from eggs.gnu.org ([2001:4830:134:3::10]:48944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY9zl-00018b-F9
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY9zh-0001YM-Or
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:56:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42132 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fY9zh-0001YD-Js
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:56:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DDC7857AB
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 12:56:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 27 Jun 2018 14:55:51 +0200
Message-Id: <20180627125604.15275-4-quintela@redhat.com>
In-Reply-To: <20180627125604.15275-1-quintela@redhat.com>
References: <20180627125604.15275-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 03/16] migration: Calculate mbps only during
 transfer time
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

We used to include in this calculation the setup time, but that can be
quite big in rdma or multifd.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e1eaa97df4..d3e6da9bfe 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2708,6 +2708,7 @@ static void migration_calculate_complete(MigrationState *s)
 {
     uint64_t bytes = qemu_ftell(s->to_dst_file);
     int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    int64_t transfer_time;
 
     s->total_time = end_time - s->start_time;
     if (!s->downtime) {
@@ -2718,8 +2719,9 @@ static void migration_calculate_complete(MigrationState *s)
         s->downtime = end_time - s->downtime_start;
     }
 
-    if (s->total_time) {
-        s->mbps = ((double) bytes * 8.0) / s->total_time / 1000;
+    transfer_time = s->total_time - s->setup_time;
+    if (transfer_time) {
+        s->mbps = ((double) bytes * 8.0) / transfer_time / 1000;
     }
 }
 
-- 
2.17.1
