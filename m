Received: from eggs.gnu.org ([2001:4830:134:3::10]:46933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1ecX0Y-0004D8-F6
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:47:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1ecX0X-0003mv-Ji
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:47:02 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:42575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1ecX0X-0003mi-Dk
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:47:01 -0500
Received: by mail-pf0-x242.google.com with SMTP id b25so1391686pfd.9
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 05:47:01 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 19 Jan 2018 21:44:44 +0800
Message-Id: <1516369485-5374-16-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1516369485-5374-1-git-send-email-zhangckid@gmail.com>
References: <1516369485-5374-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V4 15/16] COLO: notify net filters about
 checkpoint/failover event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Zhang Chen <zhangckid@gmail.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

Notify all net filters about the checkpoint and failover event.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 migration/colo.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 9eab4a3..10bc80c 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -87,6 +87,11 @@ static void secondary_vm_do_failover(void)
     if (local_err) {
         error_report_err(local_err);
     }
+    /* Notify all filters of all NIC to do checkpoint */
+    colo_notify_filters_event(COLO_EVENT_FAILOVER, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
 
     if (!autostart) {
         error_report("\"-S\" qemu option will be ignored in secondary side");
@@ -766,6 +771,13 @@ void *colo_process_incoming_thread(void *opaque)
             goto out;
         }
 
+        /* Notify all filters of all NIC to do checkpoint */
+        colo_notify_filters_event(COLO_EVENT_CHECKPOINT, &local_err);
+        if (local_err) {
+            qemu_mutex_unlock_iothread();
+            goto out;
+        }
+
         vmstate_loading = false;
         vm_start();
         trace_colo_vm_state_change("stop", "run");
-- 
2.7.4
