Received: from eggs.gnu.org ([2001:4830:134:3::10]:34039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvAaG-0005pf-M2
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvAaD-0001bX-Gj
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11725)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dvAaD-0001ad-AI
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AF5ACD16F
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 23:08:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 22 Sep 2017 01:08:03 +0200
Message-Id: <20170921230812.7095-10-quintela@redhat.com>
In-Reply-To: <20170921230812.7095-1-quintela@redhat.com>
References: <20170921230812.7095-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 09/18] migration: Split
 migration_fd_process_incoming
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

We need that on later patches.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
---
 migration/migration.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 336da038f5..067dd929c4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -372,9 +372,8 @@ static void process_incoming_migration_co(void *opaque)
     qemu_bh_schedule(mis->bh);
 }
 
-void migration_fd_process_incoming(QEMUFile *f)
+static void migration_incoming_setup(QEMUFile *f)
 {
-    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     if (multifd_load_setup() != 0) {
@@ -387,9 +386,20 @@ void migration_fd_process_incoming(QEMUFile *f)
         mis->from_src_file = f;
     }
     qemu_file_set_blocking(f, false);
+}
+
+static void migration_incoming_process(void)
+{
+    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
     qemu_coroutine_enter(co);
 }
 
+void migration_fd_process_incoming(QEMUFile *f)
+{
+    migration_incoming_setup(f);
+    migration_incoming_process();
+}
+
 void migration_ioc_process_incoming(QIOChannel *ioc)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
-- 
2.13.5
