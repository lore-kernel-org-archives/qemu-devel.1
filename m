Received: from eggs.gnu.org ([2001:4830:134:3::10]:59985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qO1-0002Bh-Ei
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNt-0000vu-UT
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:27:17 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3509
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNt-0000va-JG
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:27:13 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:25:58 +0800
Message-ID: <1492849558-17540-19-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 18/18] COLO: notify net filters about
 checkpoint/failover event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, gilbert@redhat.com
Cc: quintela@redhat.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Jason Wang <jasowang@redhat.com>

Notify all net filters about the checkpoint and failover event.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 migration/colo.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 66bb5b2..62f58c6 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -26,6 +26,7 @@
 #include "qapi-event.h"
 #include "block/block.h"
 #include "replication.h"
+#include "net/filter.h"
 
 static bool vmstate_loading;
 static Notifier packets_compare_notifier;
@@ -82,6 +83,11 @@ static void secondary_vm_do_failover(void)
     if (local_err) {
         error_report_err(local_err);
     }
+    /* Notify all filters of all NIC to do checkpoint */
+    colo_notify_filters_event(COLO_FAILOVER, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
 
     if (!autostart) {
         error_report("\"-S\" qemu option will be ignored in secondary side");
@@ -794,6 +800,13 @@ void *colo_process_incoming_thread(void *opaque)
             goto out;
         }
 
+        /* Notify all filters of all NIC to do checkpoint */
+        colo_notify_filters_event(COLO_CHECKPOINT, &local_err);
+        if (local_err) {
+            qemu_mutex_unlock_iothread();
+            goto out;
+        }
+
         vmstate_loading = false;
         vm_start();
         trace_colo_vm_state_change("stop", "run");
-- 
1.8.3.1
