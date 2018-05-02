Received: from eggs.gnu.org ([2001:4830:134:3::10]:34894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpJE-0006bj-5b
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpJD-0002vO-0w
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDpJC-0002v6-S0
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:26 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 May 2018 18:47:26 +0800
Message-Id: <20180502104740.12123-11-peterx@redhat.com>
In-Reply-To: <20180502104740.12123-1-peterx@redhat.com>
References: <20180502104740.12123-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 10/24] migration: wakeup dst ram-load-thread
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
index 304e8bf2af..32f6d686b7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -440,8 +440,34 @@ static void migration_incoming_process(void)
 
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
2.14.3
