Received: from eggs.gnu.org ([2001:4830:134:3::10]:55283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38aR-0007Dd-1b
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38aN-0005Gn-IY
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38aN-0005GC-A5
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DCE8C0567A2
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:05:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:26 +0200
Message-Id: <20170425220451.6028-17-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 16/41] migration: Rename {save,
 load}_vmstate to {save, load}_snapshot
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

It reflects what they do.  And make it easier to not confuse with
vmstate_{save,load}_state.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                        | 4 ++--
 include/block/block_int.h    | 4 ++--
 include/migration/snapshot.h | 4 ++--
 migration/savevm.c           | 4 ++--
 replay/replay-snapshot.c     | 4 ++--
 vl.c                         | 2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hmp.c b/hmp.c
index 235cc2a..73f97bb 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1278,7 +1278,7 @@ void hmp_loadvm(Monitor *mon, const QDict *qdict)
 
     vm_stop(RUN_STATE_RESTORE_VM);
 
-    if (load_vmstate(name, &err) == 0 && saved_vm_running) {
+    if (load_snapshot(name, &err) == 0 && saved_vm_running) {
         vm_start();
     }
     hmp_handle_error(mon, &err);
@@ -1288,7 +1288,7 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
-    save_vmstate(qdict_get_try_str(qdict, "name"), &err);
+    save_snapshot(qdict_get_try_str(qdict, "name"), &err);
     hmp_handle_error(mon, &err);
 }
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4f8cd29..fa74559 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -587,8 +587,8 @@ struct BlockDriverState {
     int copy_on_read;
 
     /* If we are reading a disk image, give its size in sectors.
-     * Generally read-only; it is written to by load_vmstate and save_vmstate,
-     * but the block layer is quiescent during those.
+     * Generally read-only; it is written to by load_snapshot and
+     * save_snaphost, but the block layer is quiescent during those.
      */
     int64_t total_sectors;
 
diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
index a390fea..f04bd79 100644
--- a/include/migration/snapshot.h
+++ b/include/migration/snapshot.h
@@ -14,7 +14,7 @@
 #ifndef QEMU_MIGRATION_SAVEVM_H
 #define QEMU_MIGRATION_SAVEVM_H
 
-int save_vmstate(const char *name, Error **errp);
-int load_vmstate(const char *name, Error **errp);
+int save_snapshot(const char *name, Error **errp);
+int load_snapshot(const char *name, Error **errp);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 2f76a8a..a6bc1f9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2056,7 +2056,7 @@ int qemu_loadvm_state(QEMUFile *f)
     return ret;
 }
 
-int save_vmstate(const char *name, Error **errp)
+int save_snapshot(const char *name, Error **errp)
 {
     BlockDriverState *bs, *bs1;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
@@ -2213,7 +2213,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     migration_incoming_state_destroy();
 }
 
-int load_vmstate(const char *name, Error **errp)
+int load_snapshot(const char *name, Error **errp)
 {
     BlockDriverState *bs, *bs_vm_state;
     QEMUSnapshotInfo sn;
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 86ae8dd..0522cd2 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -67,12 +67,12 @@ void replay_vmstate_init(void)
 
     if (replay_snapshot) {
         if (replay_mode == REPLAY_MODE_RECORD) {
-            if (save_vmstate(replay_snapshot, &err) != 0) {
+            if (save_snapshot(replay_snapshot, &err) != 0) {
                 error_report("Could not create snapshot for icount record");
                 exit(1);
             }
         } else if (replay_mode == REPLAY_MODE_PLAY) {
-            if (load_vmstate(replay_snapshot, &err) != 0) {
+            if (load_snapshot(replay_snapshot, &err) != 0) {
                 error_report("Could not load snapshot for icount replay");
                 exit(1);
             }
diff --git a/vl.c b/vl.c
index 53a9d19..5b79f5b 100644
--- a/vl.c
+++ b/vl.c
@@ -4683,7 +4683,7 @@ int main(int argc, char **argv, char **envp)
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
