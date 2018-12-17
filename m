Received: from eggs.gnu.org ([2001:4830:134:3::10]:55218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYo0H-0002dt-NQ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYo0E-0007yV-2Z
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:53 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYo0D-0007x3-Kh
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:49 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 17 Dec 2018 10:10:43 +0200
Message-Id: <20181217081047.2039-20-yuval.shaia@oracle.com>
In-Reply-To: <20181217081047.2039-1-yuval.shaia@oracle.com>
References: <20181217081047.2039-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v7 19/23] vl: Introduce shutdown_notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

Notifier will be used for signaling shutdown event to inform system is
shutdown. This will allow devices and other component to run some
cleanup code needed before VM is shutdown.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 include/sysemu/sysemu.h |  1 +
 vl.c                    | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 8d6095d98b..0d15f16492 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -80,6 +80,7 @@ void qemu_register_wakeup_notifier(Notifier *notifier);
 void qemu_system_shutdown_request(ShutdownCause reason);
 void qemu_system_powerdown_request(void);
 void qemu_register_powerdown_notifier(Notifier *notifier);
+void qemu_register_shutdown_notifier(Notifier *notifier);
 void qemu_system_debug_request(void);
 void qemu_system_vmstop_request(RunState reason);
 void qemu_system_vmstop_request_prepare(void);
diff --git a/vl.c b/vl.c
index fa25d1ae2d..48177f7dd1 100644
--- a/vl.c
+++ b/vl.c
@@ -1578,6 +1578,8 @@ static NotifierList suspend_notifiers =
     NOTIFIER_LIST_INITIALIZER(suspend_notifiers);
 static NotifierList wakeup_notifiers =
     NOTIFIER_LIST_INITIALIZER(wakeup_notifiers);
+static NotifierList shutdown_notifiers =
+    NOTIFIER_LIST_INITIALIZER(shutdown_notifiers);
 static uint32_t wakeup_reason_mask = ~(1 << QEMU_WAKEUP_REASON_NONE);
 
 ShutdownCause qemu_shutdown_requested_get(void)
@@ -1809,6 +1811,12 @@ static void qemu_system_powerdown(void)
     notifier_list_notify(&powerdown_notifiers, NULL);
 }
 
+static void qemu_system_shutdown(ShutdownCause cause)
+{
+    qapi_event_send_shutdown(shutdown_caused_by_guest(cause));
+    notifier_list_notify(&shutdown_notifiers, &cause);
+}
+
 void qemu_system_powerdown_request(void)
 {
     trace_qemu_system_powerdown_request();
@@ -1821,6 +1829,11 @@ void qemu_register_powerdown_notifier(Notifier *notifier)
     notifier_list_add(&powerdown_notifiers, notifier);
 }
 
+void qemu_register_shutdown_notifier(Notifier *notifier)
+{
+    notifier_list_add(&shutdown_notifiers, notifier);
+}
+
 void qemu_system_debug_request(void)
 {
     debug_requested = 1;
@@ -1848,7 +1861,7 @@ static bool main_loop_should_exit(void)
     request = qemu_shutdown_requested();
     if (request) {
         qemu_kill_report();
-        qapi_event_send_shutdown(shutdown_caused_by_guest(request));
+        qemu_system_shutdown(request);
         if (no_shutdown) {
             vm_stop(RUN_STATE_SHUTDOWN);
         } else {
-- 
2.17.2
