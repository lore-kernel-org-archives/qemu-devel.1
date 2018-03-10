Received: from eggs.gnu.org ([2001:4830:134:3::10]:48694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eulxj-0003Aw-JV
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eulxi-0003Ta-MK
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:23:31 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eulxi-0003TS-Fu
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:23:30 -0500
Received: by mail-pg0-x243.google.com with SMTP id m19so4937137pgn.1
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 13:23:30 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 11 Mar 2018 05:22:06 +0800
Message-Id: <1520716927-17068-17-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1520716927-17068-1-git-send-email-zhangckid@gmail.com>
References: <1520716927-17068-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V5 16/17] COLO: notify net filters about
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

Notify all net filters about the checkpoint and failover event.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 migration/colo.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 6834f3d..5fb4d8c 100644
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
@@ -800,6 +805,13 @@ void *colo_process_incoming_thread(void *opaque)
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
