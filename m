Received: from eggs.gnu.org ([2001:4830:134:3::10]:47080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cq1Gb-0003Ai-Fn
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cq1GY-00019n-Hv
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:38:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cq1GY-000199-Ab
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:38:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CB424E048
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 17:38:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 20 Mar 2017 17:38:39 +0000
Message-Id: <20170320173840.3626-2-dgilbert@redhat.com>
In-Reply-To: <20170320173840.3626-1-dgilbert@redhat.com>
References: <20170320173840.3626-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] save_vmstate: Convert to Error** from
 Monitor *
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com
Cc: kraxel@redhat.com, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

A bit more consistent and it removes one of the less necessary uses
of cur_mon.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/sysemu/sysemu.h  |  2 +-
 migration/savevm.c       | 31 ++++++++++++++++++-------------
 replay/replay-snapshot.c |  6 ++++--
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 576c7ce..26e1a7e 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -76,7 +76,7 @@ void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
 void hmp_savevm(Monitor *mon, const QDict *qdict);
-int save_vmstate(Monitor *mon, const char *name);
+int save_vmstate(const char *name, Error **errp);
 int load_vmstate(const char *name);
 void hmp_delvm(Monitor *mon, const QDict *qdict);
 void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
diff --git a/migration/savevm.c b/migration/savevm.c
index 3b19a4a..361a926 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2071,7 +2071,7 @@ int qemu_loadvm_state(QEMUFile *f)
     return ret;
 }
 
-int save_vmstate(Monitor *mon, const char *name)
+int save_vmstate(const char *name, Error **errp)
 {
     BlockDriverState *bs, *bs1;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
@@ -2085,8 +2085,8 @@ int save_vmstate(Monitor *mon, const char *name)
     AioContext *aio_context;
 
     if (!bdrv_all_can_snapshot(&bs)) {
-        monitor_printf(mon, "Device '%s' is writable but does not "
-                       "support snapshots.\n", bdrv_get_device_name(bs));
+        error_setg(errp, "Device '%s' is writable but does not "
+                   "support snapshots", bdrv_get_device_name(bs));
         return ret;
     }
 
@@ -2094,16 +2094,17 @@ int save_vmstate(Monitor *mon, const char *name)
     if (name) {
         ret = bdrv_all_delete_snapshot(name, &bs1, &local_err);
         if (ret < 0) {
-            error_reportf_err(local_err,
-                              "Error while deleting snapshot on device '%s': ",
-                              bdrv_get_device_name(bs1));
+            error_propagate(errp, local_err);
+            error_prepend(errp,
+                          "Error while deleting snapshot on device '%s': ",
+                          bdrv_get_device_name(bs1));
             return ret;
         }
     }
 
     bs = bdrv_all_find_vmstate_bs();
     if (bs == NULL) {
-        monitor_printf(mon, "No block device can accept snapshots\n");
+        error_setg(errp, "No block device can accept snapshots");
         return ret;
     }
     aio_context = bdrv_get_aio_context(bs);
@@ -2112,7 +2113,7 @@ int save_vmstate(Monitor *mon, const char *name)
 
     ret = global_state_store();
     if (ret) {
-        monitor_printf(mon, "Error saving global state\n");
+        error_setg(errp, "Error saving global state");
         return ret;
     }
     vm_stop(RUN_STATE_SAVE_VM);
@@ -2144,21 +2145,21 @@ int save_vmstate(Monitor *mon, const char *name)
     /* save the VM state */
     f = qemu_fopen_bdrv(bs, 1);
     if (!f) {
-        monitor_printf(mon, "Could not open VM state file\n");
+        error_setg(errp, "Could not open VM state file");
         goto the_end;
     }
     ret = qemu_savevm_state(f, &local_err);
     vm_state_size = qemu_ftell(f);
     qemu_fclose(f);
     if (ret < 0) {
-        error_report_err(local_err);
+        error_propagate(errp, local_err);
         goto the_end;
     }
 
     ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, &bs);
     if (ret < 0) {
-        monitor_printf(mon, "Error while creating snapshot on '%s'\n",
-                       bdrv_get_device_name(bs));
+        error_setg(errp, "Error while creating snapshot on '%s'",
+                   bdrv_get_device_name(bs));
         goto the_end;
     }
 
@@ -2174,7 +2175,11 @@ int save_vmstate(Monitor *mon, const char *name)
 
 void hmp_savevm(Monitor *mon, const QDict *qdict)
 {
-    save_vmstate(mon, qdict_get_try_str(qdict, "name"));
+    Error *local_err = NULL;
+    save_vmstate(qdict_get_try_str(qdict, "name"), &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
 }
 
 void qmp_xen_save_devices_state(const char *filename, Error **errp)
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 65e2d37..49b21f0 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -64,8 +64,10 @@ void replay_vmstate_init(void)
 {
     if (replay_snapshot) {
         if (replay_mode == REPLAY_MODE_RECORD) {
-            if (save_vmstate(cur_mon, replay_snapshot) != 0) {
-                error_report("Could not create snapshot for icount record");
+            Error *local_err = NULL;
+            if (save_vmstate(replay_snapshot, &local_err) != 0) {
+                error_reportf_err(local_err,
+                              "Could not create snapshot for icount record: ");
                 exit(1);
             }
         } else if (replay_mode == REPLAY_MODE_PLAY) {
-- 
2.9.3
