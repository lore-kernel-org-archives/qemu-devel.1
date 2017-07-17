Received: from eggs.gnu.org ([2001:4830:134:3::10]:45956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6IX-0003mS-UG
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6IW-0005Jr-US
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:42:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX6IW-0005Jd-LY
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:42:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BC2762647
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 13:42:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Jul 2017 15:42:23 +0200
Message-Id: <20170717134238.1966-3-quintela@redhat.com>
In-Reply-To: <20170717134238.1966-1-quintela@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v5 02/17] migration: Create
 migration_ioc_process_incoming()
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

We need to receive the ioc to be able to implement multifd.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/channel.c   |  3 +--
 migration/migration.c | 16 +++++++++++++---
 migration/migration.h |  2 ++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 719055d..5b777ef 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -36,8 +36,7 @@ gboolean migration_channel_process_incoming(QIOChannel *ioc)
             error_report_err(local_err);
         }
     } else {
-        QEMUFile *f = qemu_fopen_channel_input(ioc);
-        migration_fd_process_incoming(f);
+        return migration_ioc_process_incoming(ioc);
     }
     return FALSE; /* unregister */
 }
diff --git a/migration/migration.c b/migration/migration.c
index a0db40d..c24ad03 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -299,17 +299,15 @@ static void process_incoming_migration_bh(void *opaque)
 
 static void process_incoming_migration_co(void *opaque)
 {
-    QEMUFile *f = opaque;
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyState ps;
     int ret;
 
-    mis->from_src_file = f;
     mis->largest_page_size = qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
                       MIGRATION_STATUS_ACTIVE);
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(mis->from_src_file);
 
     ps = postcopy_state_get();
     trace_process_incoming_migration_co_end(ret, ps);
@@ -362,6 +360,18 @@ void migration_fd_process_incoming(QEMUFile *f)
     qemu_coroutine_enter(co);
 }
 
+gboolean migration_ioc_process_incoming(QIOChannel *ioc)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    if (!mis->from_src_file) {
+        QEMUFile *f = qemu_fopen_channel_input(ioc);
+        mis->from_src_file = f;
+        migration_fd_process_incoming(f);
+    }
+    return FALSE; /* unregister */
+}
+
 /*
  * Send a 'SHUT' message on the return channel with the given value
  * to indicate that we've finished with the RP.  Non-0 value indicates
diff --git a/migration/migration.h b/migration/migration.h
index 148c9fa..5a18aea 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -20,6 +20,7 @@
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
 #include "hw/qdev.h"
+#include "io/channel.h"
 
 /* State for the incoming migration */
 struct MigrationIncomingState {
@@ -152,6 +153,7 @@ struct MigrationState
 void migrate_set_state(int *state, int old_state, int new_state);
 
 void migration_fd_process_incoming(QEMUFile *f);
+gboolean migration_ioc_process_incoming(QIOChannel *ioc);
 
 uint64_t migrate_max_downtime(void);
 
-- 
2.9.4
