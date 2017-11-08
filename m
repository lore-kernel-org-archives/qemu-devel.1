Received: from eggs.gnu.org ([2001:4830:134:3::10]:38274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJZk-0006xE-HQ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJZj-00016o-9g
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:11:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJZj-00015N-2k
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:10:59 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:12 +0800
Message-Id: <20171108060130.3772-15-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 14/32] migration: wakeup dst ram-load-thread
 for recover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

On the destination side, we cannot wake up all the threads when we got
reconnected. The first thing to do is to wake up the main load thread,
so that we can continue to receive valid messages from source again and
reply when needed.

At this point, we switch the destination VM state from postcopy-paused
back to postcopy-recover.

Now we are finally ready to do the resume logic.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 0ba0ce1baf..32c036fa82 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -423,8 +423,34 @@ static void migration_incoming_process(void)
 
 void migration_fd_process_incoming(QEMUFile *f)
 {
-    migration_incoming_setup(f);
-    migration_incoming_process();
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    if (mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+        /* Resumed from a paused postcopy migration */
+
+        mis->from_src_file = f;
+        /* Postcopy has standalone thread to do vm load */
+        qemu_file_set_blocking(f, true);
+
+        /* Re-configure the return path */
+        mis->to_src_file = qemu_file_get_return_path(f);
+
+        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
+                          MIGRATION_STATUS_POSTCOPY_RECOVER);
+
+        /*
+         * Here, we only wake up the main loading thread (while the
+         * fault thread will still be waiting), so that we can receive
+         * commands from source now, and answer it if needed. The
+         * fault thread will be woken up afterwards until we are sure
+         * that source is ready to reply to page requests.
+         */
+        qemu_sem_post(&mis->postcopy_pause_sem_dst);
+    } else {
+        /* New incoming migration */
+        migration_incoming_setup(f);
+        migration_incoming_process();
+    }
 }
 
 void migration_ioc_process_incoming(QIOChannel *ioc)
-- 
2.13.6
