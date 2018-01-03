Received: from eggs.gnu.org ([2001:4830:134:3::10]:56663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi28-0006gF-2N
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi24-00022E-UQ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWi24-00021Q-Oi
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F073C49007
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 12:20:31 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  3 Jan 2018 20:20:08 +0800
Message-Id: <20180103122017.14794-5-peterx@redhat.com>
In-Reply-To: <20180103122017.14794-1-peterx@redhat.com>
References: <20180103122017.14794-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/13] migration: split use of
 MigrationState.total_time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

It was used either to:

1. store initial timestamp of migration start, and
2. store total time used by last migration

Let's provide two parameters for each of them.  Mix use of the two is
slightly misleading.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 7 ++++---
 migration/migration.h | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 9ba96ae301..343368c089 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -613,7 +613,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
         info->has_status = true;
         info->has_total_time = true;
         info->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME)
-            - s->total_time;
+            - s->start_time;
         info->has_expected_downtime = true;
         info->expected_downtime = s->expected_downtime;
         info->has_setup_time = true;
@@ -1270,7 +1270,8 @@ MigrationState *migrate_init(void)
 
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
 
-    s->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    s->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    s->total_time = 0;
     return s;
 }
 
@@ -2293,7 +2294,7 @@ static void *migration_thread(void *opaque)
     qemu_mutex_lock_iothread();
     if (s->state == MIGRATION_STATUS_COMPLETED) {
         uint64_t transferred_bytes = qemu_ftell(s->to_dst_file);
-        s->total_time = end_time - s->total_time;
+        s->total_time = end_time - s->start_time;
         if (!entered_postcopy) {
             s->downtime = end_time - start_time;
         }
diff --git a/migration/migration.h b/migration/migration.h
index 663415fe48..233ad68705 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -103,6 +103,9 @@ struct MigrationState
     } rp_state;
 
     double mbps;
+    /* Timestamp when recent migration starts (ms) */
+    int64_t start_time;
+    /* Total time used by latest migration (ms) */
     int64_t total_time;
     int64_t downtime;
     int64_t expected_downtime;
-- 
2.14.3
