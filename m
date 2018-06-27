Received: from eggs.gnu.org ([2001:4830:134:3::10]:47623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fY831-000690-5v
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fY82u-0002yp-Pl
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:51:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60646 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fY82u-0002xc-KK
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:51:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05D3A40201CE
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 10:51:32 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 27 Jun 2018 18:51:11 +0800
Message-Id: <20180627105112.31401-5-peterx@redhat.com>
In-Reply-To: <20180627105112.31401-1-peterx@redhat.com>
References: <20180627105112.31401-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/5] migration: unbreak postcopy recovery
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

Since at it, rename the function migration_fd_process_incoming() into
postcopy_try_recover(), and make sure it only contain the recovery
logic (we don't need the removed lines any more since that's only used
by RDMA before and now RDMA code has got rid of it).

Fixes: 36c2f8be2c ("migration: Delay start of migration main routines")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 6ecea2de30..5e13b529fd 100644
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
 
@@ -491,11 +492,10 @@ void migration_fd_process_incoming(QEMUFile *f)
          * that source is ready to reply to page requests.
          */
         qemu_sem_post(&mis->postcopy_pause_sem_dst);
-    } else {
-        /* New incoming migration */
-        migration_incoming_setup(f);
-        migration_incoming_process();
+        return true;
     }
+
+    return false;
 }
 
 void migration_ioc_process_incoming(QIOChannel *ioc)
@@ -504,6 +504,9 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
 
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
