Received: from eggs.gnu.org ([2001:4830:134:3::10]:56615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fwgh6-0002Lg-GY
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fwgh2-0006Bo-Jl
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:42:32 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fwgh2-0006Bc-DE
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:42:28 -0400
Received: by mail-pg1-x543.google.com with SMTP id b129-v6so8003135pga.13
	for <qemu-devel@nongnu.org>; Sun, 02 Sep 2018 21:42:28 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon,  3 Sep 2018 12:38:58 +0800
Message-Id: <20180903043900.28592-18-zhangckid@gmail.com>
In-Reply-To: <20180903043900.28592-1-zhangckid@gmail.com>
References: <20180903043900.28592-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V12 17/19] COLO: notify net filters about
 checkpoint/failover event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

Notify all net filters about the checkpoint and failover event.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 25d279decf..365e913e51 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -31,6 +31,7 @@
 #include "qapi/qapi-events-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/cpus.h"
+#include "net/filter.h"
 
 static bool vmstate_loading;
 static Notifier packets_compare_notifier;
@@ -83,6 +84,12 @@ static void secondary_vm_do_failover(void)
         error_report_err(local_err);
     }
 
+    /* Notify all filters of all NIC to do checkpoint */
+    colo_notify_filters_event(COLO_EVENT_FAILOVER, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
+
     if (!autostart) {
         error_report("\"-S\" qemu option will be ignored in secondary side");
         /* recover runstate to normal migration finish state */
@@ -782,6 +789,14 @@ void *colo_process_incoming_thread(void *opaque)
             goto out;
         }
 
+        /* Notify all filters of all NIC to do checkpoint */
+        colo_notify_filters_event(COLO_EVENT_CHECKPOINT, &local_err);
+
+        if (local_err) {
+            qemu_mutex_unlock_iothread();
+            goto out;
+        }
+
         vmstate_loading = false;
         vm_start();
         trace_colo_vm_state_change("stop", "run");
-- 
2.17.GIT
