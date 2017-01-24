Received: from eggs.gnu.org ([2001:4830:134:3::10]:35339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvML-0006Ph-CB
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvMK-00060e-8X
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:41 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38624)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvMJ-00060L-Te
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:40 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 24 Jan 2017 10:17:41 +0300
Message-ID: <20170124071741.4572.13714.stgit@PASHA-ISP>
In-Reply-To: <20170124071654.4572.41407.stgit@PASHA-ISP>
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 08/14] savevm: add public save_vmstate
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, dovgaluk@ispras.ru, kraxel@redhat.com, pbonzini@redhat.com

This patch introduces save_vmstate function to allow saving and loading
vmstates from the replay module.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 include/sysemu/sysemu.h |    1 +
 migration/savevm.c      |   33 ++++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index cccde56..4cdba34 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -75,6 +75,7 @@ void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
 void hmp_savevm(Monitor *mon, const QDict *qdict);
+int save_vmstate(Monitor *mon, const char *name);
 int load_vmstate(const char *name);
 void hmp_delvm(Monitor *mon, const QDict *qdict);
 void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
diff --git a/migration/savevm.c b/migration/savevm.c
index f9c06e9..1e69225 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2039,38 +2039,40 @@ int qemu_loadvm_state(QEMUFile *f)
     return ret;
 }
 
-void hmp_savevm(Monitor *mon, const QDict *qdict)
+int save_vmstate(Monitor *mon, const char *name)
 {
     BlockDriverState *bs, *bs1;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
-    int ret;
+    int ret = -1;
     QEMUFile *f;
     int saved_vm_running;
     uint64_t vm_state_size;
     qemu_timeval tv;
     struct tm tm;
-    const char *name = qdict_get_try_str(qdict, "name");
     Error *local_err = NULL;
     AioContext *aio_context;
 
     if (!bdrv_all_can_snapshot(&bs)) {
         monitor_printf(mon, "Device '%s' is writable but does not "
                        "support snapshots.\n", bdrv_get_device_name(bs));
-        return;
+        return ret;
     }
 
     /* Delete old snapshots of the same name */
-    if (name && bdrv_all_delete_snapshot(name, &bs1, &local_err) < 0) {
-        error_reportf_err(local_err,
-                          "Error while deleting snapshot on device '%s': ",
-                          bdrv_get_device_name(bs1));
-        return;
+    if (name) {
+        ret = bdrv_all_delete_snapshot(name, &bs1, &local_err);
+        if (ret < 0) {
+            error_reportf_err(local_err,
+                              "Error while deleting snapshot on device '%s': ",
+                              bdrv_get_device_name(bs1));
+            return ret;
+        }
     }
 
     bs = bdrv_all_find_vmstate_bs();
     if (bs == NULL) {
         monitor_printf(mon, "No block device can accept snapshots\n");
-        return;
+        return ret;
     }
     aio_context = bdrv_get_aio_context(bs);
 
@@ -2079,7 +2081,7 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
     ret = global_state_store();
     if (ret) {
         monitor_printf(mon, "Error saving global state\n");
-        return;
+        return ret;
     }
     vm_stop(RUN_STATE_SAVE_VM);
 
@@ -2125,13 +2127,22 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
     if (ret < 0) {
         monitor_printf(mon, "Error while creating snapshot on '%s'\n",
                        bdrv_get_device_name(bs));
+        goto the_end;
     }
 
+    ret = 0;
+
  the_end:
     aio_context_release(aio_context);
     if (saved_vm_running) {
         vm_start();
     }
+    return ret;
+}
+
+void hmp_savevm(Monitor *mon, const QDict *qdict)
+{
+    save_vmstate(mon, qdict_get_try_str(qdict, "name"));
 }
 
 void qmp_xen_save_devices_state(const char *filename, Error **errp)
