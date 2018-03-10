Received: from eggs.gnu.org ([2001:4830:134:3::10]:48460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eulx6-0002Qq-Of
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eulx4-0003Lt-Qd
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:22:52 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:38237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eulx4-0003Ld-Hn
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:22:50 -0500
Received: by mail-pf0-x242.google.com with SMTP id d26so2721660pfn.5
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 13:22:50 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 11 Mar 2018 05:21:56 +0800
Message-Id: <1520716927-17068-7-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1520716927-17068-1-git-send-email-zhangckid@gmail.com>
References: <1520716927-17068-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V5 06/17] COLO: Remove colo_state migration
 struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

We need to know if migration is going into COLO state for
incoming side before start normal migration.

Instead by using the VMStateDescription to send colo_state
from source side to destination side, we use MIG_CMD_ENABLE_COLO
to indicate whether COLO is enabled or not.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/migration/colo.h |  5 ++--
 migration/Makefile.objs  |  2 +-
 migration/colo-comm.c    | 76 ------------------------------------------------
 migration/colo.c         | 13 ++++++++-
 migration/migration.c    | 23 ++++++++++++++-
 migration/savevm.c       | 19 ++++++++++++
 migration/savevm.h       |  1 +
 migration/trace-events   |  1 +
 vl.c                     |  2 --
 9 files changed, 59 insertions(+), 83 deletions(-)
 delete mode 100644 migration/colo-comm.c

diff --git a/include/migration/colo.h b/include/migration/colo.h
index fefb2fc..99ce17a 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -28,8 +28,9 @@ void migrate_start_colo_process(MigrationState *s);
 bool migration_in_colo_state(void);
 
 /* loadvm */
-bool migration_incoming_enable_colo(void);
-void migration_incoming_exit_colo(void);
+void migration_incoming_enable_colo(void);
+void migration_incoming_disable_colo(void);
+bool migration_incoming_colo_enabled(void);
 void *colo_process_incoming_thread(void *opaque);
 bool migration_incoming_in_colo_state(void);
 
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index 99e0380..3099eec 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -1,6 +1,6 @@
 common-obj-y += migration.o socket.o fd.o exec.o
 common-obj-y += tls.o channel.o savevm.o
-common-obj-y += colo-comm.o colo.o colo-failover.o
+common-obj-y += colo.o colo-failover.o
 common-obj-y += vmstate.o vmstate-types.o page_cache.o
 common-obj-y += qemu-file.o global_state.o
 common-obj-y += qemu-file-channel.o
diff --git a/migration/colo-comm.c b/migration/colo-comm.c
deleted file mode 100644
index df26e4d..0000000
--- a/migration/colo-comm.c
+++ /dev/null
@@ -1,76 +0,0 @@
-/*
- * COarse-grain LOck-stepping Virtual Machines for Non-stop Service (COLO)
- * (a.k.a. Fault Tolerance or Continuous Replication)
- *
- * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
- * Copyright (c) 2016 FUJITSU LIMITED
- * Copyright (c) 2016 Intel Corporation
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or
- * later. See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "migration.h"
-#include "migration/colo.h"
-#include "migration/vmstate.h"
-#include "trace.h"
-
-typedef struct {
-     bool colo_requested;
-} COLOInfo;
-
-static COLOInfo colo_info;
-
-COLOMode get_colo_mode(void)
-{
-    if (migration_in_colo_state()) {
-        return COLO_MODE_PRIMARY;
-    } else if (migration_incoming_in_colo_state()) {
-        return COLO_MODE_SECONDARY;
-    } else {
-        return COLO_MODE_UNKNOWN;
-    }
-}
-
-static int colo_info_pre_save(void *opaque)
-{
-    COLOInfo *s = opaque;
-
-    s->colo_requested = migrate_colo_enabled();
-
-    return 0;
-}
-
-static bool colo_info_need(void *opaque)
-{
-   return migrate_colo_enabled();
-}
-
-static const VMStateDescription colo_state = {
-    .name = "COLOState",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .pre_save = colo_info_pre_save,
-    .needed = colo_info_need,
-    .fields = (VMStateField[]) {
-        VMSTATE_BOOL(colo_requested, COLOInfo),
-        VMSTATE_END_OF_LIST()
-    },
-};
-
-void colo_info_init(void)
-{
-    vmstate_register(NULL, 0, &colo_state, &colo_info);
-}
-
-bool migration_incoming_enable_colo(void)
-{
-    return colo_info.colo_requested;
-}
-
-void migration_incoming_exit_colo(void)
-{
-    colo_info.colo_requested = false;
-}
diff --git a/migration/colo.c b/migration/colo.c
index e06640c..c083d36 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -152,6 +152,17 @@ static void primary_vm_do_failover(void)
     qemu_sem_post(&s->colo_exit_sem);
 }
 
+COLOMode get_colo_mode(void)
+{
+    if (migration_in_colo_state()) {
+        return COLO_MODE_PRIMARY;
+    } else if (migration_incoming_in_colo_state()) {
+        return COLO_MODE_SECONDARY;
+    } else {
+        return COLO_MODE_UNKNOWN;
+    }
+}
+
 void colo_do_failover(MigrationState *s)
 {
     /* Make sure VM stopped while failover happened. */
@@ -745,7 +756,7 @@ out:
     if (mis->to_src_file) {
         qemu_fclose(mis->to_src_file);
     }
-    migration_incoming_exit_colo();
+    migration_incoming_disable_colo();
 
     return NULL;
 }
diff --git a/migration/migration.c b/migration/migration.c
index 128daaa..47328df 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -268,6 +268,22 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
     return migrate_send_rp_message(mis, msg_type, msglen, bufc);
 }
 
+static bool migration_colo_enabled;
+bool migration_incoming_colo_enabled(void)
+{
+    return migration_colo_enabled;
+}
+
+void migration_incoming_disable_colo(void)
+{
+    migration_colo_enabled = false;
+}
+
+void migration_incoming_enable_colo(void)
+{
+    migration_colo_enabled = true;
+}
+
 void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p;
@@ -377,7 +393,7 @@ static void process_incoming_migration_co(void *opaque)
     }
 
     /* we get COLO info, and know if we are in COLO mode */
-    if (!ret && migration_incoming_enable_colo()) {
+    if (!ret && migration_incoming_colo_enabled()) {
         /* Make sure all file formats flush their mutable metadata */
         bdrv_invalidate_cache_all(&local_err);
         if (local_err) {
@@ -2365,6 +2381,11 @@ static void *migration_thread(void *opaque)
         qemu_savevm_send_postcopy_advise(s->to_dst_file);
     }
 
+    if (migrate_colo_enabled()) {
+        /* Notify migration destination that we enable COLO */
+        qemu_savevm_send_colo_enable(s->to_dst_file);
+    }
+
     qemu_savevm_state_setup(s->to_dst_file);
 
     s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
diff --git a/migration/savevm.c b/migration/savevm.c
index 358c5b5..10a6676 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -54,6 +54,7 @@
 #include "qemu/cutils.h"
 #include "io/channel-buffer.h"
 #include "io/channel-file.h"
+#include "migration/colo.h"
 
 #ifndef ETH_P_RARP
 #define ETH_P_RARP 0x8035
@@ -80,6 +81,9 @@ enum qemu_vm_cmd {
                                       were previously sent during
                                       precopy but are dirty. */
     MIG_CMD_PACKAGED,          /* Send a wrapped stream within this stream */
+
+    MIG_CMD_ENABLE_COLO, /* Enable COLO */
+
     MIG_CMD_MAX
 };
 
@@ -835,6 +839,12 @@ static void qemu_savevm_command_send(QEMUFile *f,
     qemu_fflush(f);
 }
 
+void qemu_savevm_send_colo_enable(QEMUFile *f)
+{
+    trace_savevm_send_colo_enable();
+    qemu_savevm_command_send(f, MIG_CMD_ENABLE_COLO, 0, NULL);
+}
+
 void qemu_savevm_send_ping(QEMUFile *f, uint32_t value)
 {
     uint32_t buf;
@@ -1769,6 +1779,12 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     return ret;
 }
 
+static int loadvm_process_enable_colo(MigrationIncomingState *mis)
+{
+    migration_incoming_enable_colo();
+    return 0;
+}
+
 /*
  * Process an incoming 'QEMU_VM_COMMAND'
  * 0           just a normal return
@@ -1842,6 +1858,9 @@ static int loadvm_process_command(QEMUFile *f)
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
         return loadvm_postcopy_ram_handle_discard(mis, len);
+
+    case MIG_CMD_ENABLE_COLO:
+        return loadvm_process_enable_colo(mis);
     }
 
     return 0;
diff --git a/migration/savevm.h b/migration/savevm.h
index 295c4a1..041d23c 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -51,6 +51,7 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
                                            uint16_t len,
                                            uint64_t *start_list,
                                            uint64_t *length_list);
+void qemu_savevm_send_colo_enable(QEMUFile *f);
 
 int qemu_loadvm_state(QEMUFile *f);
 void qemu_loadvm_state_cleanup(void);
diff --git a/migration/trace-events b/migration/trace-events
index 93961de..b27a3a0 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -34,6 +34,7 @@ savevm_send_open_return_path(void) ""
 savevm_send_ping(uint32_t val) "0x%x"
 savevm_send_postcopy_listen(void) ""
 savevm_send_postcopy_run(void) ""
+savevm_send_colo_enable(void) ""
 savevm_state_setup(void) ""
 savevm_state_header(void) ""
 savevm_state_iterate(void) ""
diff --git a/vl.c b/vl.c
index dae986b..e67750d 100644
--- a/vl.c
+++ b/vl.c
@@ -4471,8 +4471,6 @@ int main(int argc, char **argv, char **envp)
 #endif
     }
 
-    colo_info_init();
-
     if (net_init_clients(&err) < 0) {
         error_report_err(err);
         exit(1);
-- 
2.7.4
