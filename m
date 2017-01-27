Received: from eggs.gnu.org ([2001:4830:134:3::10]:33300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6ql-0004qv-0L
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qj-0003oa-TN
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:45:59 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6qj-0003o7-NB
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:45:57 -0500
Received: by mail-wm0-x243.google.com with SMTP id c85so58231103wmi.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:45:57 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:12 +0100
Message-Id: <1485524749-118532-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/41] savevm: add public save_vmstate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch introduces save_vmstate function to allow saving and loading
vmstates from the replay module.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <20170124071741.4572.13714.stgit@PASHA-ISP>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/sysemu.h |  1 +
 migration/savevm.c      | 33 ++++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index ff8ffb5..4ef2eb0 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -74,6 +74,7 @@ void qemu_add_machine_init_done_notifier(Notifier *notify);
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
-- 
1.8.3.1
