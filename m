Received: from eggs.gnu.org ([2001:4830:134:3::10]:58825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df7Jq-0000Ra-2b
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df7Jm-0006v5-0Y
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:25:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df7Jl-0006ue-Qj
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:25:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B96987C852
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 16:25:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue,  8 Aug 2017 18:22:15 +0200
Message-Id: <20170808162224.32419-11-quintela@redhat.com>
In-Reply-To: <20170808162224.32419-1-quintela@redhat.com>
References: <20170808162224.32419-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v6 10/19] migration: Split
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
---
 migration/migration.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d031c93..e36e880 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -366,9 +366,8 @@ static void process_incoming_migration_co(void *opaque)
     qemu_bh_schedule(mis->bh);
 }
 
-void migration_fd_process_incoming(QEMUFile *f)
+static void migration_incoming_setup(QEMUFile *f)
 {
-    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     if (multifd_load_setup() != 0) {
@@ -380,9 +379,20 @@ void migration_fd_process_incoming(QEMUFile *f)
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
2.9.4
