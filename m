Received: from eggs.gnu.org ([2001:4830:134:3::10]:41846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTTMG-0002dj-QT
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:59:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTTMC-0003Kn-Nd
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:59:28 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:55585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTTMB-0003J8-RN
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:59:24 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Tue, 17 Jan 2017 20:57:44 +0800
Message-ID: <1484657864-21708-4-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1484657864-21708-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1484657864-21708-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/3] COLO: Don't process failover request while
 loading VM's state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, quintela@redhat.com, dgilbert@redhat.com, eddie.dong@intel.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Eric Blake <eblake@redhat.com>

We should not do failover work while the main thread is loading
VM's state. Otherwise the consistent of VM's memory and
device state will be broken.

We will restart the loading process after jump over the stage,
The new failover status 'RELAUNCH' will help to record if we
need to restart the process.

Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c | 26 ++++++++++++++++++++++++++
 qapi-schema.json |  4 +++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/migration/colo.c b/migration/colo.c
index 3222812..712308e 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -20,6 +20,8 @@
 #include "qapi/error.h"
 #include "migration/failover.h"
 
+static bool vmstate_loading;
+
 #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
 
 bool colo_supported(void)
@@ -51,6 +53,19 @@ static void secondary_vm_do_failover(void)
     int old_state;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
+    /* Can not do failover during the process of VM's loading VMstate, Or
+     * it will break the secondary VM.
+     */
+    if (vmstate_loading) {
+        old_state = failover_set_state(FAILOVER_STATUS_ACTIVE,
+                        FAILOVER_STATUS_RELAUNCH);
+        if (old_state != FAILOVER_STATUS_ACTIVE) {
+            error_report("Unknown error while do failover for secondary VM,"
+                         "old_state: %s", FailoverStatus_lookup[old_state]);
+        }
+        return;
+    }
+
     migrate_set_state(&mis->state, MIGRATION_STATUS_COLO,
                       MIGRATION_STATUS_COMPLETED);
 
@@ -548,13 +563,23 @@ void *colo_process_incoming_thread(void *opaque)
 
         qemu_mutex_lock_iothread();
         qemu_system_reset(VMRESET_SILENT);
+        vmstate_loading = true;
         if (qemu_loadvm_state(fb) < 0) {
             error_report("COLO: loadvm failed");
             qemu_mutex_unlock_iothread();
             goto out;
         }
+
+        vmstate_loading = false;
         qemu_mutex_unlock_iothread();
 
+        if (failover_get_state() == FAILOVER_STATUS_RELAUNCH) {
+            failover_set_state(FAILOVER_STATUS_RELAUNCH,
+                            FAILOVER_STATUS_NONE);
+            failover_request_active(NULL);
+            goto out;
+        }
+
         colo_send_message(mis->to_src_file, COLO_MESSAGE_VMSTATE_LOADED,
                      &local_err);
         if (local_err) {
@@ -563,6 +588,7 @@ void *colo_process_incoming_thread(void *opaque)
     }
 
 out:
+    vmstate_loading = false;
     /* Throw the unreported error message after exited from loop */
     if (local_err) {
         error_report_err(local_err);
diff --git a/qapi-schema.json b/qapi-schema.json
index ce20f16..97210c7 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -856,10 +856,12 @@
 #
 # @completed: finish the process of failover
 #
+# @relaunch: restart the failover process, from 'none' -> 'completed'
+#
 # Since: 2.8
 ##
 { 'enum': 'FailoverStatus',
-  'data': [ 'none', 'require', 'active', 'completed'] }
+  'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
 
 ##
 # @x-colo-lost-heartbeat:
-- 
1.8.3.1
