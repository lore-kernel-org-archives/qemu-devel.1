Received: from eggs.gnu.org ([2001:4830:134:3::10]:59784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNR-0001jJ-2u
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNO-0000hG-3i
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:45 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3467
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNN-0000gb-94
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:42 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:25:52 +0800
Message-ID: <1492849558-17540-13-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 12/18] savevm: split the process of
 different stages for loadvm/savevm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, gilbert@redhat.com
Cc: quintela@redhat.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

There are several stages during loadvm/savevm process. In different stage,
migration incoming processes different types of sections.
We want to control these stages more accuracy, it will benefit COLO
performance, we don't have to save type of QEMU_VM_SECTION_START
sections everytime while do checkpoint, besides, we want to separate
the process of saving/loading memory and devices state.

So we add three new helper functions: qemu_loadvm_state_begin(),
qemu_load_device_state() and qemu_savevm_live_state() to achieve
different process during migration.

Besides, we make qemu_loadvm_state_main() and qemu_save_device_state()
public, and simplify the codes of qemu_save_device_state() by calling the
wrapper qemu_savevm_state_header().

Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
v2:
 - Use the wrapper qemu_savevm_state_header() to simplify the codes
  of qemu_save_device_state() (Dave's suggestion)
---
 include/sysemu/sysemu.h |  6 ++++++
 migration/savevm.c      | 54 ++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 8054f53..0255c4e 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -132,7 +132,13 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
                                            uint64_t *start_list,
                                            uint64_t *length_list);
 
+void qemu_savevm_live_state(QEMUFile *f);
+int qemu_save_device_state(QEMUFile *f);
+
 int qemu_loadvm_state(QEMUFile *f);
+int qemu_loadvm_state_begin(QEMUFile *f);
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
+int qemu_load_device_state(QEMUFile *f);
 
 extern int autostart;
 
diff --git a/migration/savevm.c b/migration/savevm.c
index f87cd8d..8c2ce0b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -54,6 +54,7 @@
 #include "qemu/cutils.h"
 #include "io/channel-buffer.h"
 #include "io/channel-file.h"
+#include "migration/colo.h"
 
 #ifndef ETH_P_RARP
 #define ETH_P_RARP 0x8035
@@ -1285,13 +1286,20 @@ done:
     return ret;
 }
 
-static int qemu_save_device_state(QEMUFile *f)
+void qemu_savevm_live_state(QEMUFile *f)
 {
-    SaveStateEntry *se;
+    /* save QEMU_VM_SECTION_END section */
+    qemu_savevm_state_complete_precopy(f, true);
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
@@ -1342,8 +1350,6 @@ enum LoadVMExitCodes {
     LOADVM_QUIT     =  1,
 };
 
-static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
-
 /* ------ incoming postcopy messages ------ */
 /* 'advise' arrives before any transfers just to tell us that a postcopy
  * *might* happen - it might be skipped if precopy transferred everything
@@ -1957,7 +1963,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
     return 0;
 }
 
-static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
 {
     uint8_t section_type;
     int ret = 0;
@@ -2095,6 +2101,40 @@ int qemu_loadvm_state(QEMUFile *f)
     return ret;
 }
 
+int qemu_loadvm_state_begin(QEMUFile *f)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    Error *local_err = NULL;
+    int ret;
+
+    if (qemu_savevm_state_blocked(&local_err)) {
+        error_report_err(local_err);
+        return -EINVAL;
+    }
+    /* Load QEMU_VM_SECTION_START section */
+    ret = qemu_loadvm_state_main(f, mis);
+    if (ret < 0) {
+        error_report("Failed to loadvm begin work: %d", ret);
+    }
+    return ret;
+}
+
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
 int save_vmstate(Monitor *mon, const char *name)
 {
     BlockDriverState *bs, *bs1;
-- 
1.8.3.1
