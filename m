Received: from eggs.gnu.org ([2001:4830:134:3::10]:37021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybe-0003tC-Aq
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybc-0004LL-U2
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:22 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:45903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eWybc-0004KX-Ln
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:20 -0500
Received: by mail-pf0-x241.google.com with SMTP id u19so365692pfa.12
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 22:02:20 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu,  4 Jan 2018 14:01:10 +0800
Message-Id: <1515045675-6993-12-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
References: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH RESEND V3 11/16] savevm: split the process of
 different stages for loadvm/savevm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

There are several stages during loadvm/savevm process. In different stage,
migration incoming processes different types of sections.
We want to control these stages more accuracy, it will benefit COLO
performance, we don't have to save type of QEMU_VM_SECTION_START
sections everytime while do checkpoint, besides, we want to separate
the process of saving/loading memory and devices state.

So we add three new helper functions: qemu_load_device_state() and
qemu_savevm_live_state() to achieve different process during migration.

Besides, we make qemu_loadvm_state_main() and qemu_save_device_state()
public, and simplify the codes of qemu_save_device_state() by calling the
wrapper qemu_savevm_state_header().

Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c   | 37 +++++++++++++++++++++++++++++--------
 migration/savevm.c | 35 ++++++++++++++++++++++++++++-------
 migration/savevm.h |  4 ++++
 3 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 790b122..a931ff2 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -29,6 +29,7 @@
 #include "qapi-event.h"
 #include "block/block.h"
 #include "replication.h"
+#include "sysemu/cpus.h"
 
 static bool vmstate_loading;
 static Notifier packets_compare_notifier;
@@ -380,24 +381,31 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
 
     /* Disable block migration */
     migrate_set_block_enabled(false, &local_err);
-    qemu_savevm_state_header(fb);
-    qemu_savevm_state_setup(fb);
     qemu_mutex_lock_iothread();
     replication_do_checkpoint_all(&local_err);
     if (local_err) {
         qemu_mutex_unlock_iothread();
         goto out;
     }
-    qemu_savevm_state_complete_precopy(fb, false, false);
-    qemu_mutex_unlock_iothread();
-
-    qemu_fflush(fb);
 
     colo_send_message(s->to_dst_file, COLO_MESSAGE_VMSTATE_SEND, &local_err);
     if (local_err) {
         goto out;
     }
     /*
+     * Only save VM's live state, which not including device state.
+     * TODO: We may need a timeout mechanism to prevent COLO process
+     * to be blocked here.
+     */
+    qemu_savevm_live_state(s->to_dst_file);
+    /* Note: device state is saved into buffer */
+    ret = qemu_save_device_state(fb);
+
+    qemu_mutex_unlock_iothread();
+
+    qemu_fflush(fb);
+
+    /*
      * We need the size of the VMstate data in Secondary side,
      * With which we can decide how much data should be read.
      */
@@ -610,6 +618,7 @@ void *colo_process_incoming_thread(void *opaque)
     uint64_t total_size;
     uint64_t value;
     Error *local_err = NULL;
+    int ret;
 
     qemu_sem_init(&mis->colo_incoming_sem, 0);
 
@@ -682,6 +691,16 @@ void *colo_process_incoming_thread(void *opaque)
             goto out;
         }
 
+        qemu_mutex_lock_iothread();
+        cpu_synchronize_all_pre_loadvm();
+        ret = qemu_loadvm_state_main(mis->from_src_file, mis);
+        qemu_mutex_unlock_iothread();
+
+        if (ret < 0) {
+            error_report("Load VM's live state (ram) error");
+            goto out;
+        }
+
         value = colo_receive_message_value(mis->from_src_file,
                                  COLO_MESSAGE_VMSTATE_SIZE, &local_err);
         if (local_err) {
@@ -715,8 +734,9 @@ void *colo_process_incoming_thread(void *opaque)
         qemu_mutex_lock_iothread();
         qemu_system_reset(SHUTDOWN_CAUSE_NONE);
         vmstate_loading = true;
-        if (qemu_loadvm_state(fb) < 0) {
-            error_report("COLO: loadvm failed");
+        ret = qemu_load_device_state(fb);
+        if (ret < 0) {
+            error_report("COLO: load device state failed");
             qemu_mutex_unlock_iothread();
             goto out;
         }
@@ -777,6 +797,7 @@ out:
     if (mis->to_src_file) {
         qemu_fclose(mis->to_src_file);
     }
+    qemu_loadvm_state_cleanup();
     migration_incoming_disable_colo();
 
     return NULL;
diff --git a/migration/savevm.c b/migration/savevm.c
index c582716..30a3c77 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1317,13 +1317,20 @@ done:
     return ret;
 }
 
-static int qemu_save_device_state(QEMUFile *f)
+void qemu_savevm_live_state(QEMUFile *f)
 {
-    SaveStateEntry *se;
+    /* save QEMU_VM_SECTION_END section */
+    qemu_savevm_state_complete_precopy(f, true, false);
+    qemu_put_byte(f, QEMU_VM_EOF);
+}
 
-    qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
-    qemu_put_be32(f, QEMU_VM_FILE_VERSION);
+int qemu_save_device_state(QEMUFile *f)
+{
+    SaveStateEntry *se;
 
+    if (!migration_in_colo_state()) {
+        qemu_savevm_state_header(f);
+    }
     cpu_synchronize_all_states();
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
@@ -1379,8 +1386,6 @@ enum LoadVMExitCodes {
     LOADVM_QUIT     =  1,
 };
 
-static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
-
 /* ------ incoming postcopy messages ------ */
 /* 'advise' arrives before any transfers just to tell us that a postcopy
  * *might* happen - it might be skipped if precopy transferred everything
@@ -2003,7 +2008,7 @@ void qemu_loadvm_state_cleanup(void)
     }
 }
 
-static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
 {
     uint8_t section_type;
     int ret = 0;
@@ -2148,6 +2153,22 @@ int qemu_loadvm_state(QEMUFile *f)
     return ret;
 }
 
+int qemu_load_device_state(QEMUFile *f)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    int ret;
+
+    /* Load QEMU_VM_SECTION_FULL section */
+    ret = qemu_loadvm_state_main(f, mis);
+    if (ret < 0) {
+        error_report("Failed to load device state: %d", ret);
+        return ret;
+    }
+
+    cpu_synchronize_all_post_init();
+    return 0;
+}
+
 int save_snapshot(const char *name, Error **errp)
 {
     BlockDriverState *bs, *bs1;
diff --git a/migration/savevm.h b/migration/savevm.h
index 041d23c..8d463fd 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -52,8 +52,12 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
                                            uint64_t *start_list,
                                            uint64_t *length_list);
 void qemu_savevm_send_colo_enable(QEMUFile *f);
+void qemu_savevm_live_state(QEMUFile *f);
+int qemu_save_device_state(QEMUFile *f);
 
 int qemu_loadvm_state(QEMUFile *f);
 void qemu_loadvm_state_cleanup(void);
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
+int qemu_load_device_state(QEMUFile *f);
 
 #endif
-- 
2.7.4
