Received: from eggs.gnu.org ([2001:4830:134:3::10]:33746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFzkw-0000cW-Vd
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFzkv-0002Fa-Th
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:17:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFzkv-0002FB-LO
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:17:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8EDCC0099FD
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 09:17:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 31 May 2017 11:17:19 +0200
Message-Id: <20170531091720.21697-3-quintela@redhat.com>
In-Reply-To: <20170531091720.21697-1-quintela@redhat.com>
References: <20170531091720.21697-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/3] migration: loadvm handlers are not used
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

So we remove all traces of them.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/migration/migration.h |  5 -----
 include/migration/vmstate.h   |  2 --
 include/qemu/typedefs.h       |  1 -
 migration/migration.c         |  2 --
 migration/savevm.c            | 26 --------------------------
 5 files changed, 36 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 0e807b6..d1a353a 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -50,8 +50,6 @@ enum mig_rp_message_type {
     MIG_RP_MSG_MAX
 };
 
-typedef QLIST_HEAD(, LoadStateEntry) LoadStateEntry_Head;
-
 /* State for the incoming migration */
 struct MigrationIncomingState {
     QEMUFile *from_src_file;
@@ -89,9 +87,6 @@ struct MigrationIncomingState {
     /* The coroutine we should enter (back) after failover */
     Coroutine *migration_incoming_co;
     QemuSemaphore colo_incoming_sem;
-
-    /* See savevm.c */
-    LoadStateEntry_Head loadvm_handlers;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f97411d..6689562 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1020,8 +1020,6 @@ extern const VMStateInfo vmstate_info_qtailq;
 
 #define SELF_ANNOUNCE_ROUNDS 5
 
-void loadvm_free_handlers(MigrationIncomingState *mis);
-
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id);
 void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 33a6aa1..51958bf 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -39,7 +39,6 @@ typedef struct I2SCodec I2SCodec;
 typedef struct ISABus ISABus;
 typedef struct ISADevice ISADevice;
 typedef struct IsaDma IsaDma;
-typedef struct LoadStateEntry LoadStateEntry;
 typedef struct MACAddr MACAddr;
 typedef struct MachineClass MachineClass;
 typedef struct MachineState MachineState;
diff --git a/migration/migration.c b/migration/migration.c
index 7087d1a..c3218cd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -122,7 +122,6 @@ MigrationIncomingState *migration_incoming_get_current(void)
     if (!once) {
         mis_current.state = MIGRATION_STATUS_NONE;
         memset(&mis_current, 0, sizeof(MigrationIncomingState));
-        QLIST_INIT(&mis_current.loadvm_handlers);
         qemu_mutex_init(&mis_current.rp_mutex);
         qemu_event_init(&mis_current.main_thread_load_event, false);
         once = true;
@@ -135,7 +134,6 @@ void migration_incoming_state_destroy(void)
     struct MigrationIncomingState *mis = migration_incoming_get_current();
 
     qemu_event_destroy(&mis->main_thread_load_event);
-    loadvm_free_handlers(mis);
 }
 
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 07646f4..d96209b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1804,13 +1804,6 @@ static int loadvm_process_command(QEMUFile *f)
     return 0;
 }
 
-struct LoadStateEntry {
-    QLIST_ENTRY(LoadStateEntry) entry;
-    SaveStateEntry *se;
-    int section_id;
-    int version_id;
-};
-
 /*
  * Read a footer off the wire and check that it matches the expected section
  *
@@ -1846,22 +1839,11 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
     return true;
 }
 
-void loadvm_free_handlers(MigrationIncomingState *mis)
-{
-    LoadStateEntry *le, *new_le;
-
-    QLIST_FOREACH_SAFE(le, &mis->loadvm_handlers, entry, new_le) {
-        QLIST_REMOVE(le, entry);
-        g_free(le);
-    }
-}
-
 static int
 qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
 {
     uint32_t instance_id, version_id, section_id;
     SaveStateEntry *se;
-    LoadStateEntry *le;
     char idstr[256];
     int ret;
 
@@ -1900,14 +1882,6 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
         return -EINVAL;
     }
 
-    /* Add entry */
-    le = g_malloc0(sizeof(*le));
-
-    le->se = se;
-    le->section_id = section_id;
-    le->version_id = version_id;
-    QLIST_INSERT_HEAD(&mis->loadvm_handlers, le, entry);
-
     ret = vmstate_load(f, se, se->load_version_id);
     if (ret < 0) {
         error_report("error while loading state for instance 0x%x of"
-- 
2.9.4
