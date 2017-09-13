Received: from eggs.gnu.org ([2001:4830:134:3::10]:41754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds5Ok-0005os-5a
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds5Oi-00060g-HP
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ds5Oi-0005zp-9k
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54DF5C0587DD
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 10:59:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 13 Sep 2017 12:59:34 +0200
Message-Id: <20170913105953.13760-2-quintela@redhat.com>
In-Reply-To: <20170913105953.13760-1-quintela@redhat.com>
References: <20170913105953.13760-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v8 01/20] migration: Create
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

We pass the ioc instead of the fd.  This will allow us to have more
than one channel open.  We also make sure that we set the
from_src_file sooner, so we don't need to pass it as a parameter.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

--

Do not assing mis->from_src_file (peterxu)
---
 migration/channel.c   |  3 +--
 migration/migration.c | 22 ++++++++++++++++++----
 migration/migration.h |  2 ++
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 3b7252f5a2..edceebdb7b 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -36,8 +36,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
             error_report_err(local_err);
         }
     } else {
-        QEMUFile *f = qemu_fopen_channel_input(ioc);
-        migration_fd_process_incoming(f);
+        migration_ioc_process_incoming(ioc);
     }
 }
 
diff --git a/migration/migration.c b/migration/migration.c
index 959e8ec88e..2d4c56e612 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -306,17 +306,16 @@ static void process_incoming_migration_bh(void *opaque)
 
 static void process_incoming_migration_co(void *opaque)
 {
-    QEMUFile *f = opaque;
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyState ps;
     int ret;
 
-    mis->from_src_file = f;
+    assert(mis->from_src_file);
     mis->largest_page_size = qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
                       MIGRATION_STATUS_ACTIVE);
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(mis->from_src_file);
 
     ps = postcopy_state_get();
     trace_process_incoming_migration_co_end(ret, ps);
@@ -364,12 +363,27 @@ static void process_incoming_migration_co(void *opaque)
 
 void migration_fd_process_incoming(QEMUFile *f)
 {
-    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, f);
+    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
+    MigrationIncomingState *mis = migration_incoming_get_current();
 
+    if (!mis->from_src_file) {
+        mis->from_src_file = f;
+    }
     qemu_file_set_blocking(f, false);
     qemu_coroutine_enter(co);
 }
 
+void migration_ioc_process_incoming(QIOChannel *ioc)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    if (!mis->from_src_file) {
+        QEMUFile *f = qemu_fopen_channel_input(ioc);
+        migration_fd_process_incoming(f);
+    }
+    /* We still only have a single channel.  Nothing to do here yet */
+}
+
 /*
  * Send a 'SHUT' message on the return channel with the given value
  * to indicate that we've finished with the RP.  Non-0 value indicates
diff --git a/migration/migration.h b/migration/migration.h
index 148c9facbc..99c398d484 100644
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
+void migration_ioc_process_incoming(QIOChannel *ioc);
 
 uint64_t migrate_max_downtime(void);
 
-- 
2.13.5
