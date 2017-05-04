Received: from eggs.gnu.org ([2001:4830:134:3::10]:45273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6DFz-0008ES-83
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6DFy-0000en-1F
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d6DFx-0000eK-OA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80BAD7D4E2
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 09:41:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  4 May 2017 11:40:47 +0200
Message-Id: <20170504094053.2329-5-quintela@redhat.com>
In-Reply-To: <20170504094053.2329-1-quintela@redhat.com>
References: <20170504094053.2329-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 04/10] monitor: Remove monitor parameter from
 save_vmstate
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

load_vmstate() already use error_report, so be consistent.  There is
an identical error message in load_vmstate() that ends in a
period. Remove it.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/sysemu/sysemu.h  |  2 +-
 migration/savevm.c       | 20 ++++++++++----------
 replay/replay-snapshot.c |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 16175f7..b6daf9d 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -76,7 +76,7 @@ void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
 void hmp_savevm(Monitor *mon, const QDict *qdict);
-int save_vmstate(Monitor *mon, const char *name);
+int save_vmstate(const char *name);
 int load_vmstate(const char *name);
 void hmp_delvm(Monitor *mon, const QDict *qdict);
 void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
diff --git a/migration/savevm.c b/migration/savevm.c
index 03ae1bd..a89af80 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2070,7 +2070,7 @@ int qemu_loadvm_state(QEMUFile *f)
     return ret;
 }
 
-int save_vmstate(Monitor *mon, const char *name)
+int save_vmstate(const char *name)
 {
     BlockDriverState *bs, *bs1;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
@@ -2084,8 +2084,8 @@ int save_vmstate(Monitor *mon, const char *name)
     AioContext *aio_context;
 
     if (!bdrv_all_can_snapshot(&bs)) {
-        monitor_printf(mon, "Device '%s' is writable but does not "
-                       "support snapshots.\n", bdrv_get_device_name(bs));
+        error_report("Device '%s' is writable but does not support snapshots",
+                     bdrv_get_device_name(bs));
         return ret;
     }
 
@@ -2102,7 +2102,7 @@ int save_vmstate(Monitor *mon, const char *name)
 
     bs = bdrv_all_find_vmstate_bs();
     if (bs == NULL) {
-        monitor_printf(mon, "No block device can accept snapshots\n");
+        error_report("No block device can accept snapshots");
         return ret;
     }
     aio_context = bdrv_get_aio_context(bs);
@@ -2111,7 +2111,7 @@ int save_vmstate(Monitor *mon, const char *name)
 
     ret = global_state_store();
     if (ret) {
-        monitor_printf(mon, "Error saving global state\n");
+        error_report("Error saving global state");
         return ret;
     }
     vm_stop(RUN_STATE_SAVE_VM);
@@ -2143,7 +2143,7 @@ int save_vmstate(Monitor *mon, const char *name)
     /* save the VM state */
     f = qemu_fopen_bdrv(bs, 1);
     if (!f) {
-        monitor_printf(mon, "Could not open VM state file\n");
+        error_report("Could not open VM state file");
         goto the_end;
     }
     ret = qemu_savevm_state(f, &local_err);
@@ -2156,8 +2156,8 @@ int save_vmstate(Monitor *mon, const char *name)
 
     ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, &bs);
     if (ret < 0) {
-        monitor_printf(mon, "Error while creating snapshot on '%s'\n",
-                       bdrv_get_device_name(bs));
+        error_report("Error while creating snapshot on '%s'",
+                     bdrv_get_device_name(bs));
         goto the_end;
     }
 
@@ -2173,7 +2173,7 @@ int save_vmstate(Monitor *mon, const char *name)
 
 void hmp_savevm(Monitor *mon, const QDict *qdict)
 {
-    save_vmstate(mon, qdict_get_try_str(qdict, "name"));
+    save_vmstate(qdict_get_try_str(qdict, "name"));
 }
 
 void qmp_xen_save_devices_state(const char *filename, Error **errp)
@@ -2245,7 +2245,7 @@ int load_vmstate(const char *name)
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     if (!bdrv_all_can_snapshot(&bs)) {
-        error_report("Device '%s' is writable but does not support snapshots.",
+        error_report("Device '%s' is writable but does not support snapshots",
                      bdrv_get_device_name(bs));
         return -ENOTSUP;
     }
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 65e2d37..8cced46 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -64,7 +64,7 @@ void replay_vmstate_init(void)
 {
     if (replay_snapshot) {
         if (replay_mode == REPLAY_MODE_RECORD) {
-            if (save_vmstate(cur_mon, replay_snapshot) != 0) {
+            if (save_vmstate(replay_snapshot) != 0) {
                 error_report("Could not create snapshot for icount record");
                 exit(1);
             }
-- 
2.9.3
