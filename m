Received: from eggs.gnu.org ([2001:4830:134:3::10]:36664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAwu9-0002Ki-Nb
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAwu8-0002D9-7J
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:14:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dAwu7-0002Cm-UB
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:14:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC948C049D57
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 11:14:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 17 May 2017 13:13:41 +0200
Message-Id: <20170517111346.21450-3-quintela@redhat.com>
In-Reply-To: <20170517111346.21450-1-quintela@redhat.com>
References: <20170517111346.21450-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] migration: Pass Error ** argument to {save,
 load}_vmstate
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

This way we use the "normal" way of printing errors for hmp commands.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 hmp.c                    |  9 +++++++--
 include/sysemu/sysemu.h  |  4 ++--
 migration/savevm.c       | 51 ++++++++++++++++++++++++------------------------
 replay/replay-snapshot.c |  8 ++++++--
 vl.c                     |  4 +++-
 5 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/hmp.c b/hmp.c
index 524e589..b9dd933 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1274,17 +1274,22 @@ void hmp_loadvm(Monitor *mon, const QDict *qdict)
 {
     int saved_vm_running  = runstate_is_running();
     const char *name = qdict_get_str(qdict, "name");
+    Error *err = NULL;
 
     vm_stop(RUN_STATE_RESTORE_VM);
 
-    if (load_vmstate(name) == 0 && saved_vm_running) {
+    if (load_vmstate(name, &err) == 0 && saved_vm_running) {
         vm_start();
     }
+    hmp_handle_error(mon, &err);
 }
 
 void hmp_savevm(Monitor *mon, const QDict *qdict)
 {
-    save_vmstate(qdict_get_try_str(qdict, "name"));
+    Error *err = NULL;
+
+    save_vmstate(qdict_get_try_str(qdict, "name"), &err);
+    hmp_handle_error(mon, &err);
 }
 
 void hmp_delvm(Monitor *mon, const QDict *qdict)
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index be9e22c..282f6bc 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -75,8 +75,8 @@ void qemu_remove_exit_notifier(Notifier *notify);
 void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
-int save_vmstate(const char *name);
-int load_vmstate(const char *name);
+int save_vmstate(const char *name, Error **errp);
+int load_vmstate(const char *name, Error **errp);
 
 void qemu_announce_self(void);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 7f66d58..b4f736f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2069,7 +2069,7 @@ int qemu_loadvm_state(QEMUFile *f)
     return ret;
 }
 
-int save_vmstate(const char *name)
+int save_vmstate(const char *name, Error **errp)
 {
     BlockDriverState *bs, *bs1;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
@@ -2079,29 +2079,27 @@ int save_vmstate(const char *name)
     uint64_t vm_state_size;
     qemu_timeval tv;
     struct tm tm;
-    Error *local_err = NULL;
     AioContext *aio_context;
 
     if (!bdrv_all_can_snapshot(&bs)) {
-        error_report("Device '%s' is writable but does not support snapshots",
-                     bdrv_get_device_name(bs));
+        error_setg(errp, "Device '%s' is writable but does not support "
+                   "snapshots", bdrv_get_device_name(bs));
         return ret;
     }
 
     /* Delete old snapshots of the same name */
     if (name) {
-        ret = bdrv_all_delete_snapshot(name, &bs1, &local_err);
+        ret = bdrv_all_delete_snapshot(name, &bs1, errp);
         if (ret < 0) {
-            error_reportf_err(local_err,
-                              "Error while deleting snapshot on device '%s': ",
-                              bdrv_get_device_name(bs1));
+            error_prepend(errp, "Error while deleting snapshot on device "
+                          "'%s': ", bdrv_get_device_name(bs1));
             return ret;
         }
     }
 
     bs = bdrv_all_find_vmstate_bs();
     if (bs == NULL) {
-        error_report("No block device can accept snapshots");
+        error_setg(errp, "No block device can accept snapshots");
         return ret;
     }
     aio_context = bdrv_get_aio_context(bs);
@@ -2110,7 +2108,7 @@ int save_vmstate(const char *name)
 
     ret = global_state_store();
     if (ret) {
-        error_report("Error saving global state");
+        error_setg(errp, "Error saving global state");
         return ret;
     }
     vm_stop(RUN_STATE_SAVE_VM);
@@ -2142,21 +2140,20 @@ int save_vmstate(const char *name)
     /* save the VM state */
     f = qemu_fopen_bdrv(bs, 1);
     if (!f) {
-        error_report("Could not open VM state file");
+        error_setg(errp, "Could not open VM state file");
         goto the_end;
     }
-    ret = qemu_savevm_state(f, &local_err);
+    ret = qemu_savevm_state(f, errp);
     vm_state_size = qemu_ftell(f);
     qemu_fclose(f);
     if (ret < 0) {
-        error_report_err(local_err);
         goto the_end;
     }
 
     ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, &bs);
     if (ret < 0) {
-        error_report("Error while creating snapshot on '%s'",
-                     bdrv_get_device_name(bs));
+        error_setg(errp, "Error while creating snapshot on '%s'",
+                   bdrv_get_device_name(bs));
         goto the_end;
     }
 
@@ -2229,7 +2226,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     migration_incoming_state_destroy();
 }
 
-int load_vmstate(const char *name)
+int load_vmstate(const char *name, Error **errp)
 {
     BlockDriverState *bs, *bs_vm_state;
     QEMUSnapshotInfo sn;
@@ -2239,20 +2236,22 @@ int load_vmstate(const char *name)
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     if (!bdrv_all_can_snapshot(&bs)) {
-        error_report("Device '%s' is writable but does not support snapshots",
-                     bdrv_get_device_name(bs));
+        error_setg(errp,
+                   "Device '%s' is writable but does not support snapshots",
+                   bdrv_get_device_name(bs));
         return -ENOTSUP;
     }
     ret = bdrv_all_find_snapshot(name, &bs);
     if (ret < 0) {
-        error_report("Device '%s' does not have the requested snapshot '%s'",
-                     bdrv_get_device_name(bs), name);
+        error_setg(errp,
+                   "Device '%s' does not have the requested snapshot '%s'",
+                   bdrv_get_device_name(bs), name);
         return ret;
     }
 
     bs_vm_state = bdrv_all_find_vmstate_bs();
     if (!bs_vm_state) {
-        error_report("No block device supports snapshots");
+        error_setg(errp, "No block device supports snapshots");
         return -ENOTSUP;
     }
     aio_context = bdrv_get_aio_context(bs_vm_state);
@@ -2264,8 +2263,8 @@ int load_vmstate(const char *name)
     if (ret < 0) {
         return ret;
     } else if (sn.vm_state_size == 0) {
-        error_report("This is a disk-only snapshot. Revert to it offline "
-            "using qemu-img.");
+        error_setg(errp, "This is a disk-only snapshot. Revert to it "
+                   " offline using qemu-img");
         return -EINVAL;
     }
 
@@ -2274,7 +2273,7 @@ int load_vmstate(const char *name)
 
     ret = bdrv_all_goto_snapshot(name, &bs);
     if (ret < 0) {
-        error_report("Error %d while activating snapshot '%s' on '%s'",
+        error_setg(errp, "Error %d while activating snapshot '%s' on '%s'",
                      ret, name, bdrv_get_device_name(bs));
         return ret;
     }
@@ -2282,7 +2281,7 @@ int load_vmstate(const char *name)
     /* restore the VM state */
     f = qemu_fopen_bdrv(bs_vm_state, 0);
     if (!f) {
-        error_report("Could not open VM state file");
+        error_setg(errp, "Could not open VM state file");
         return -EINVAL;
     }
 
@@ -2296,7 +2295,7 @@ int load_vmstate(const char *name)
 
     migration_incoming_state_destroy();
     if (ret < 0) {
-        error_report("Error %d while loading VM state", ret);
+        error_setg(errp, "Error %d while loading VM state", ret);
         return ret;
     }
 
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 8cced46..c75cd38 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -62,14 +62,18 @@ void replay_vmstate_register(void)
 
 void replay_vmstate_init(void)
 {
+    Error *err = NULL;
+
     if (replay_snapshot) {
         if (replay_mode == REPLAY_MODE_RECORD) {
-            if (save_vmstate(replay_snapshot) != 0) {
+            if (save_vmstate(replay_snapshot, &err) != 0) {
+                error_report_err(err);
                 error_report("Could not create snapshot for icount record");
                 exit(1);
             }
         } else if (replay_mode == REPLAY_MODE_PLAY) {
-            if (load_vmstate(replay_snapshot) != 0) {
+            if (load_vmstate(replay_snapshot, &err) != 0) {
+                error_report_err(err);
                 error_report("Could not load snapshot for icount replay");
                 exit(1);
             }
diff --git a/vl.c b/vl.c
index 5c9b40e..1512df6 100644
--- a/vl.c
+++ b/vl.c
@@ -4701,7 +4701,9 @@ int main(int argc, char **argv, char **envp)
     if (replay_mode != REPLAY_MODE_NONE) {
         replay_vmstate_init();
     } else if (loadvm) {
-        if (load_vmstate(loadvm) < 0) {
+        Error *local_err = NULL;
+        if (load_vmstate(loadvm, &local_err) < 0) {
+            error_report_err(local_err);
             autostart = 0;
         }
     }
-- 
2.9.3
