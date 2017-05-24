Received: from eggs.gnu.org ([2001:4830:134:3::10]:44541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDS4o-0007a8-OL
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDS4n-00071I-LF
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:55:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dDS4n-00070p-CZ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:55:29 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 24 May 2017 10:55:18 +0200
Message-Id: <20170524085519.22856-3-quintela@redhat.com>
In-Reply-To: <20170524085519.22856-1-quintela@redhat.com>
References: <20170524085519.22856-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] migration: loadvm handlers are not used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Juan Quintela <quintela@trasno.org>

From: Juan Quintela <quintela@trasno.org>

So we remove all traces of them.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |  5 -----
 include/migration/vmstate.h   |  2 --
 include/qemu/typedefs.h       |  1 -
 migration/migration.c         |  2 --
 migration/savevm.c            | 28 +---------------------------
 5 files changed, 1 insertion(+), 37 deletions(-)

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
index ad29e53..891a260 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -121,7 +121,6 @@ MigrationIncomingState *migration_incoming_get_current(void)
     if (!once) {
         mis_current.state = MIGRATION_STATUS_NONE;
         memset(&mis_current, 0, sizeof(MigrationIncomingState));
-        QLIST_INIT(&mis_current.loadvm_handlers);
         qemu_mutex_init(&mis_current.rp_mutex);
         qemu_event_init(&mis_current.main_thread_load_event, false);
         once = true;
@@ -134,7 +133,6 @@ void migration_incoming_state_destroy(void)
     struct MigrationIncomingState *mis = migration_incoming_get_current();
 
     qemu_event_destroy(&mis->main_thread_load_event);
-    loadvm_free_handlers(mis);
 }
 
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 55ac8c1..96b7173 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1779,13 +1779,6 @@ static int loadvm_process_command(QEMUFile *f)
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
@@ -1821,22 +1814,11 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
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
 
@@ -1873,15 +1855,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
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
-    ret = vmstate_load(f, le->se, le->version_id);
+    ret = vmstate_load(f, se, se->version_id);
     if (ret < 0) {
         error_report("error while loading state for instance 0x%x of"
                      " device '%s'", instance_id, idstr);
-- 
2.9.3
