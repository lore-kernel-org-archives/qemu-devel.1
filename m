Received: from eggs.gnu.org ([2001:4830:134:3::10]:41757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadw6-0006PQ-QX
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadw6-0006Xb-1a
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:10 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadw5-0006X9-RX
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:09 -0500
Received: by mail-wm1-x342.google.com with SMTP id p6so7871999wmc.1
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:51:09 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:25 +0200
Message-Id: <20181222095036.29743-21-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel]  [PATCH PULL 20/31] vl: Introduce shutdown_notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, pjp@fedoraproject.org

From: Yuval Shaia <yuval.shaia@oracle.com>

Notifier will be used for signaling shutdown event to inform system is
shutdown. This will allow devices and other component to run some
cleanup code needed before VM is shutdown.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 include/sysemu/sysemu.h |  1 +
 vl.c                    | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index c8efdeb376..e0d15da937 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -62,6 +62,7 @@ void qemu_register_wakeup_support(void);
 void qemu_system_shutdown_request(ShutdownCause reason);
 void qemu_system_powerdown_request(void);
 void qemu_register_powerdown_notifier(Notifier *notifier);
+void qemu_register_shutdown_notifier(Notifier *notifier);
 void qemu_system_debug_request(void);
 void qemu_system_vmstop_request(RunState reason);
 void qemu_system_vmstop_request_prepare(void);
diff --git a/vl.c b/vl.c
index 46ebf813b3..8353d3c718 100644
--- a/vl.c
+++ b/vl.c
@@ -1577,6 +1577,8 @@ static NotifierList suspend_notifiers =
     NOTIFIER_LIST_INITIALIZER(suspend_notifiers);
 static NotifierList wakeup_notifiers =
     NOTIFIER_LIST_INITIALIZER(wakeup_notifiers);
+static NotifierList shutdown_notifiers =
+    NOTIFIER_LIST_INITIALIZER(shutdown_notifiers);
 static uint32_t wakeup_reason_mask = ~(1 << QEMU_WAKEUP_REASON_NONE);
 
 ShutdownCause qemu_shutdown_requested_get(void)
@@ -1828,6 +1830,12 @@ static void qemu_system_powerdown(void)
     notifier_list_notify(&powerdown_notifiers, NULL);
 }
 
+static void qemu_system_shutdown(ShutdownCause cause)
+{
+    qapi_event_send_shutdown(shutdown_caused_by_guest(cause), cause);
+    notifier_list_notify(&shutdown_notifiers, &cause);
+}
+
 void qemu_system_powerdown_request(void)
 {
     trace_qemu_system_powerdown_request();
@@ -1840,6 +1848,11 @@ void qemu_register_powerdown_notifier(Notifier *notifier)
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
@@ -1867,7 +1880,7 @@ static bool main_loop_should_exit(void)
     request = qemu_shutdown_requested();
     if (request) {
         qemu_kill_report();
-        qapi_event_send_shutdown(shutdown_caused_by_guest(request), request);
+        qemu_system_shutdown(request);
         if (no_shutdown) {
             vm_stop(RUN_STATE_SHUTDOWN);
         } else {
-- 
2.17.1
