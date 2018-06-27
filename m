Received: from eggs.gnu.org ([2001:4830:134:3::10]:55753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYAPY-0005zj-BU
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYAPV-0003g8-6s
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:23:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fYAPV-0003fh-3D
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:23:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7128805A530
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 13:23:00 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 27 Jun 2018 21:22:45 +0800
Message-Id: <20180627132246.5576-4-peterx@redhat.com>
In-Reply-To: <20180627132246.5576-1-peterx@redhat.com>
References: <20180627132246.5576-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/4] migration: unbreak postcopy recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

The whole postcopy recovery logic was accidentally broken.  We need to
fix it in two steps.

This is the first step that we should do the recovery when needed.  It
was bypassed before after commit 36c2f8be2c.

Introduce postcopy_try_recovery() helper for the postcopy recovery
logic.  Call it both in migration_fd_process_incoming() and
migration_ioc_process_incoming().

Fixes: 36c2f8be2c ("migration: Delay start of migration main routines")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 6ecea2de30..0a0db49817 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -466,7 +466,8 @@ void migration_incoming_process(void)
     qemu_coroutine_enter(co);
 }
 
-void migration_fd_process_incoming(QEMUFile *f)
+/* Returns true if recovered from a paused migration, otherwise false */
+static bool postcopy_try_recover(QEMUFile *f)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -491,11 +492,20 @@ void migration_fd_process_incoming(QEMUFile *f)
          * that source is ready to reply to page requests.
          */
         qemu_sem_post(&mis->postcopy_pause_sem_dst);
-    } else {
-        /* New incoming migration */
-        migration_incoming_setup(f);
-        migration_incoming_process();
+        return true;
+    }
+
+    return false;
+}
+
+void migration_fd_process_incoming(QEMUFile *f)
+{
+    if (postcopy_try_recover(f)) {
+        return;
     }
+
+    migration_incoming_setup(f);
+    migration_incoming_process();
 }
 
 void migration_ioc_process_incoming(QIOChannel *ioc)
@@ -504,6 +514,9 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
 
     if (!mis->from_src_file) {
         QEMUFile *f = qemu_fopen_channel_input(ioc);
+        if (postcopy_try_recover(f)) {
+            return;
+        }
         migration_incoming_setup(f);
         return;
     }
-- 
2.17.1
