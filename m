Received: from eggs.gnu.org ([2001:4830:134:3::10]:46078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6Iv-00045K-Gu
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6Ir-0005Pe-R4
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX6Ir-0005PY-L8
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D6D72F86E0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 13:43:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Jul 2017 15:42:29 +0200
Message-Id: <20170717134238.1966-9-quintela@redhat.com>
In-Reply-To: <20170717134238.1966-1-quintela@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v5 08/17] migration: Split
 migration_fd_process_incomming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

We need that on posterior patches.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5a82c1c..b81c498 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -356,19 +356,31 @@ static void process_incoming_migration_co(void *opaque)
     qemu_bh_schedule(mis->bh);
 }
 
-void migration_fd_process_incoming(QEMUFile *f)
+static void migration_incoming_setup(QEMUFile *f)
 {
-    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, f);
+    MigrationIncomingState *mis = migration_incoming_get_current();
 
     if (multifd_load_setup() != 0) {
         /* We haven't been able to create multifd threads
            nothing better to do */
         exit(EXIT_FAILURE);
     }
+    mis->from_src_file = f;
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
 gboolean migration_ioc_process_incoming(QIOChannel *ioc)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
-- 
2.9.4
