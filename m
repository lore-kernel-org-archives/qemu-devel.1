Received: from eggs.gnu.org ([2001:4830:134:3::10]:58684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDI-0004iI-Vf
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDH-0001Pi-Ma
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGNDH-0001PO-J6
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3369AA1BD4
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:24:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:23:48 +0200
Message-Id: <20180509112406.6183-24-quintela@redhat.com>
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 23/41] migration: wakeup dst ram-load-thread for
 recover
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

From: Peter Xu <peterx@redhat.com>

On the destination side, we cannot wake up all the threads when we got
reconnected. The first thing to do is to wake up the main load thread,
so that we can continue to receive valid messages from source again and
reply when needed.

At this point, we switch the destination VM state from postcopy-paused
back to postcopy-recover.

Now we are finally ready to do the resume logic.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-11-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4ab637a1fe..ec3bc9ae20 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -440,8 +440,34 @@ void migration_incoming_process(void)
 
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
2.17.0
