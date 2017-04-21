Received: from eggs.gnu.org ([2001:4830:134:3::10]:46025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XD8-0003Y1-Pk
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XD7-0007uY-Ta
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1XD7-0007uM-NU
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 99B6451440
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 11:58:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 21 Apr 2017 13:56:41 +0200
Message-Id: <20170421115646.15544-61-quintela@redhat.com>
In-Reply-To: <20170421115646.15544-1-quintela@redhat.com>
References: <20170421115646.15544-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 60/65] migration: don't close a file descriptor
 while it can be in use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, Laurent Vivier <lvivier@redhat.com>

From: Laurent Vivier <lvivier@redhat.com>

If we close the QEMUFile descriptor in process_incoming_migration_co()
while it has been stopped by an error, the postcopy_ram_listen_thread()
can try to continue to use it. And as the memory has been freed
it is working with an invalid pointer and crashes.

Fix this by releasing the memory after having managed the error
case (which, in fact, calls exit())

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by:  Amit Shah <amit@kernel.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a92d7f7..31e8141 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -435,17 +435,17 @@ static void process_incoming_migration_co(void *opaque)
         qemu_thread_join(&mis->colo_incoming_thread);
     }
 
+    if (ret < 0) {
+        migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_FAILED);
+        error_report("load of migration failed: %s", strerror(-ret));
+        migrate_decompress_threads_join();
+        exit(EXIT_FAILURE);
+    }
+
     qemu_fclose(f);
     free_xbzrle_decoded_buf();
 
-    if (ret < 0) {
-        migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
-        error_report("load of migration failed: %s", strerror(-ret));
-        migrate_decompress_threads_join();
-        exit(EXIT_FAILURE);
-    }
-
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
     qemu_bh_schedule(mis->bh);
 }
-- 
2.9.3
