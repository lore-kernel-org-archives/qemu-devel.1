Received: from eggs.gnu.org ([2001:4830:134:3::10]:58018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fPLEj-0000gF-5J
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 01:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fPLEf-0001BM-UA
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 01:07:25 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fPLEf-0001Aq-OD
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 01:07:21 -0400
Received: by mail-pg0-x244.google.com with SMTP id a13-v6so12987705pgu.4
	for <qemu-devel@nongnu.org>; Sat, 02 Jun 2018 22:07:21 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun,  3 Jun 2018 13:05:45 +0800
Message-Id: <20180603050546.6827-17-zhangckid@gmail.com>
In-Reply-To: <20180603050546.6827-1-zhangckid@gmail.com>
References: <20180603050546.6827-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V8 16/17] COLO: notify net filters about
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
 migration/colo.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 0bff21d9e5..e3824d139a 100644
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
@@ -813,6 +818,13 @@ void *colo_process_incoming_thread(void *opaque)
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
2.17.GIT
