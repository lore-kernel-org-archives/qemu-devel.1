Received: from eggs.gnu.org ([2001:4830:134:3::10]:52586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fI6kx-00060s-7W
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fI477-0000zJ-DU
	for qemu-devel@nongnu.org; Sun, 13 May 2018 23:25:30 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:37404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fI476-0000xq-Ja
	for qemu-devel@nongnu.org; Sun, 13 May 2018 23:25:28 -0400
Received: by mail-pl0-x241.google.com with SMTP id w19-v6so3895626plq.4
	for <qemu-devel@nongnu.org>; Sun, 13 May 2018 20:25:28 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 14 May 2018 11:23:47 +0800
Message-Id: <1526268228-27951-17-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1526268228-27951-1-git-send-email-zhangckid@gmail.com>
References: <1526268228-27951-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V7 16/17] COLO: notify net filters about
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
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

Notify all net filters about the checkpoint and failover event.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 migration/colo.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 5e517dc..d67bdc2 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -88,6 +88,11 @@ static void secondary_vm_do_failover(void)
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
@@ -799,6 +804,13 @@ void *colo_process_incoming_thread(void *opaque)
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
