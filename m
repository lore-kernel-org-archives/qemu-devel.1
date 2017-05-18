Received: from eggs.gnu.org ([2001:4830:134:3::10]:57664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPCA-0001Dm-To
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPC7-000716-OW
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBPC7-00070P-F8
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7FC7480C01
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 17:26:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 19:25:41 +0200
Message-Id: <20170518172543.32694-10-quintela@redhat.com>
In-Reply-To: <20170518172543.32694-1-quintela@redhat.com>
References: <20170518172543.32694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 09/11] migration: Create include for migration
 snapshots
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

Start removing migration code from sysemu/sysemu.h.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                        |  5 +++--
 include/block/block_int.h    |  4 ++--
 include/migration/snapshot.h | 20 ++++++++++++++++++++
 include/sysemu/sysemu.h      |  3 ---
 migration/savevm.c           |  5 +++--
 replay/replay-snapshot.c     |  5 +++--
 vl.c                         |  3 ++-
 7 files changed, 33 insertions(+), 12 deletions(-)
 create mode 100644 include/migration/snapshot.h

diff --git a/hmp.c b/hmp.c
index 20f5dab..ad72390 100644
--- a/hmp.c
+++ b/hmp.c
@@ -42,6 +42,7 @@
 #include "qemu/error-report.h"
 #include "exec/ramlist.h"
 #include "hw/intc/intc.h"
+#include "migration/snapshot.h"
 
 #ifdef CONFIG_SPICE
 #include <spice/enums.h>
@@ -1284,7 +1285,7 @@ void hmp_loadvm(Monitor *mon, const QDict *qdict)
 
     vm_stop(RUN_STATE_RESTORE_VM);
 
-    if (load_vmstate(name, &err) == 0 && saved_vm_running) {
+    if (load_snapshot(name, &err) == 0 && saved_vm_running) {
         vm_start();
     }
     hmp_handle_error(mon, &err);
@@ -1294,7 +1295,7 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
-    save_vmstate(qdict_get_try_str(qdict, "name"), &err);
+    save_snapshot(qdict_get_try_str(qdict, "name"), &err);
     hmp_handle_error(mon, &err);
 }
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 8d3724c..e761077 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -601,8 +601,8 @@ struct BlockDriverState {
     int copy_on_read;
 
     /* If we are reading a disk image, give its size in sectors.
-     * Generally read-only; it is written to by load_vmstate and save_vmstate,
-     * but the block layer is quiescent during those.
+     * Generally read-only; it is written to by load_snapshot and
+     * save_snaphost, but the block layer is quiescent during those.
      */
     int64_t total_sectors;
 
diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
new file mode 100644
index 0000000..79062b5
--- /dev/null
+++ b/include/migration/snapshot.h
@@ -0,0 +1,20 @@
+/*
+ * QEMU live migration
+ *
+ * Copyright IBM, Corp. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_MIGRATION_SAVEVM_H
+#define QEMU_MIGRATION_SAVEVM_H
+
+int save_snapshot(const char *name, Error **errp);
+int load_snapshot(const char *name, Error **errp);
+
+#endif
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 73baea1..4dc6651 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -74,9 +74,6 @@ void qemu_remove_exit_notifier(Notifier *notify);
 void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
-int save_vmstate(const char *name, Error **errp);
-int load_vmstate(const char *name, Error **errp);
-
 void qemu_announce_self(void);
 
 extern int autostart;
diff --git a/migration/savevm.c b/migration/savevm.c
index 0a32474..10731ea 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -35,6 +35,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/timer.h"
 #include "migration/migration.h"
+#include "migration/snapshot.h"
 #include "qemu-file-channel.h"
 #include "qemu-file.h"
 #include "savevm.h"
@@ -2087,7 +2088,7 @@ int qemu_loadvm_state(QEMUFile *f)
     return ret;
 }
 
-int save_vmstate(const char *name, Error **errp)
+int save_snapshot(const char *name, Error **errp)
 {
     BlockDriverState *bs, *bs1;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
@@ -2244,7 +2245,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     migration_incoming_state_destroy();
 }
 
-int load_vmstate(const char *name, Error **errp)
+int load_snapshot(const char *name, Error **errp)
 {
     BlockDriverState *bs, *bs_vm_state;
     QEMUSnapshotInfo sn;
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index c75cd38..a4ded29 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -19,6 +19,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qemu/error-report.h"
 #include "migration/vmstate.h"
+#include "migration/snapshot.h"
 
 static void replay_pre_save(void *opaque)
 {
@@ -66,13 +67,13 @@ void replay_vmstate_init(void)
 
     if (replay_snapshot) {
         if (replay_mode == REPLAY_MODE_RECORD) {
-            if (save_vmstate(replay_snapshot, &err) != 0) {
+            if (save_snapshot(replay_snapshot, &err) != 0) {
                 error_report_err(err);
                 error_report("Could not create snapshot for icount record");
                 exit(1);
             }
         } else if (replay_mode == REPLAY_MODE_PLAY) {
-            if (load_vmstate(replay_snapshot, &err) != 0) {
+            if (load_snapshot(replay_snapshot, &err) != 0) {
                 error_report_err(err);
                 error_report("Could not load snapshot for icount replay");
                 exit(1);
diff --git a/vl.c b/vl.c
index 1512df6..478ebce 100644
--- a/vl.c
+++ b/vl.c
@@ -87,6 +87,7 @@ int main(int argc, char **argv)
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
 #include "migration/block.h"
+#include "migration/snapshot.h"
 #include "sysemu/tpm.h"
 #include "sysemu/dma.h"
 #include "audio/audio.h"
@@ -4702,7 +4703,7 @@ int main(int argc, char **argv, char **envp)
         replay_vmstate_init();
     } else if (loadvm) {
         Error *local_err = NULL;
-        if (load_vmstate(loadvm, &local_err) < 0) {
+        if (load_snapshot(loadvm, &local_err) < 0) {
             error_report_err(local_err);
             autostart = 0;
         }
-- 
2.9.3
