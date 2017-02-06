Received: from eggs.gnu.org ([2001:4830:134:3::10]:35228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1camWO-00047R-6G
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1camWM-0005kG-0x
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1camWL-0005jq-Of
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:05 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF3B480F9B
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 16:52:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon,  6 Feb 2017 17:51:44 +0100
Message-Id: <1486399909-16338-2-git-send-email-quintela@redhat.com>
In-Reply-To: <1486399909-16338-1-git-send-email-quintela@redhat.com>
References: <1486399909-16338-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] migration: create Migration Incoming State
 at init time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <1485207141-1941-3-git-send-email-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |  1 -
 migration/migration.c         | 38 +++++++++++++++++---------------------
 migration/savevm.c            |  4 ++--
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index af9135f..7528cc2 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -122,7 +122,6 @@ struct MigrationIncomingState {
 };

 MigrationIncomingState *migration_incoming_get_current(void);
-MigrationIncomingState *migration_incoming_state_new(QEMUFile *f);
 void migration_incoming_state_destroy(void);

 /*
diff --git a/migration/migration.c b/migration/migration.c
index 2766d2f..619ccc4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -111,32 +111,28 @@ MigrationState *migrate_get_current(void)
     return &current_migration;
 }

-/* For incoming */
-static MigrationIncomingState *mis_current;
-
 MigrationIncomingState *migration_incoming_get_current(void)
 {
-    return mis_current;
-}
+    static bool once;
+    static MigrationIncomingState mis_current;

-MigrationIncomingState *migration_incoming_state_new(QEMUFile* f)
-{
-    mis_current = g_new0(MigrationIncomingState, 1);
-    mis_current->from_src_file = f;
-    mis_current->state = MIGRATION_STATUS_NONE;
-    QLIST_INIT(&mis_current->loadvm_handlers);
-    qemu_mutex_init(&mis_current->rp_mutex);
-    qemu_event_init(&mis_current->main_thread_load_event, false);
-
-    return mis_current;
+    if (!once) {
+        mis_current.state = MIGRATION_STATUS_NONE;
+        memset(&mis_current, 0, sizeof(MigrationIncomingState));
+        QLIST_INIT(&mis_current.loadvm_handlers);
+        qemu_mutex_init(&mis_current.rp_mutex);
+        qemu_event_init(&mis_current.main_thread_load_event, false);
+        once = true;
+    }
+    return &mis_current;
 }

 void migration_incoming_state_destroy(void)
 {
-    qemu_event_destroy(&mis_current->main_thread_load_event);
-    loadvm_free_handlers(mis_current);
-    g_free(mis_current);
-    mis_current = NULL;
+    struct MigrationIncomingState *mis = migration_incoming_get_current();
+
+    qemu_event_destroy(&mis->main_thread_load_event);
+    loadvm_free_handlers(mis);
 }


@@ -382,11 +378,11 @@ static void process_incoming_migration_bh(void *opaque)
 static void process_incoming_migration_co(void *opaque)
 {
     QEMUFile *f = opaque;
-    MigrationIncomingState *mis;
+    MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyState ps;
     int ret;

-    mis = migration_incoming_state_new(f);
+    mis->from_src_file = f;
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
                       MIGRATION_STATUS_ACTIVE);
diff --git a/migration/savevm.c b/migration/savevm.c
index 204012e..f3644ca 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2199,7 +2199,6 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     qio_channel_set_name(QIO_CHANNEL(ioc), "migration-xen-load-state");
     f = qemu_fopen_channel_input(QIO_CHANNEL(ioc));

-    migration_incoming_state_new(f);
     ret = qemu_loadvm_state(f);
     qemu_fclose(f);
     if (ret < 0) {
@@ -2215,6 +2214,7 @@ int load_vmstate(const char *name)
     QEMUFile *f;
     int ret;
     AioContext *aio_context;
+    MigrationIncomingState *mis = migration_incoming_get_current();

     if (!bdrv_all_can_snapshot(&bs)) {
         error_report("Device '%s' is writable but does not support snapshots.",
@@ -2265,7 +2265,7 @@ int load_vmstate(const char *name)
     }

     qemu_system_reset(VMRESET_SILENT);
-    migration_incoming_state_new(f);
+    mis->from_src_file = f;

     aio_context_acquire(aio_context);
     ret = qemu_loadvm_state(f);
-- 
2.7.4
