Received: from eggs.gnu.org ([2001:4830:134:3::10]:34518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmyRy-0007uw-7Z
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmyRt-0003dZ-5H
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:34:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmyRs-0003dE-Vd
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:34:09 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 30 Aug 2017 16:32:15 +0800
Message-Id: <1504081950-2528-19-git-send-email-peterx@redhat.com>
In-Reply-To: <1504081950-2528-1-git-send-email-peterx@redhat.com>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 18/33] migration: wakeup dst ram-load-thread
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
Cc: Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

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
 migration/migration.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 30dd566..1370c70 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -389,10 +389,37 @@ static void process_incoming_migration_co(void *opaque)
 
 void migration_fd_process_incoming(QEMUFile *f)
 {
-    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, f);
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    Coroutine *co;
+
+    mis->from_src_file = f;
+
+    if (mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+        /* Resumed from a paused postcopy migration */
+
+        /* Postcopy has standalone thread to do vm load */
+        qemu_file_set_blocking(f, true);
+
+        /* Re-configure the return path */
+        mis->to_src_file = qemu_file_get_return_path(f);
 
-    qemu_file_set_blocking(f, false);
-    qemu_coroutine_enter(co);
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
+        qemu_file_set_blocking(f, false);
+        co = qemu_coroutine_create(process_incoming_migration_co, f);
+        qemu_coroutine_enter(co);
+    }
 }
 
 /*
-- 
2.7.4
