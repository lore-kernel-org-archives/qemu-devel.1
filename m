Received: from eggs.gnu.org ([2001:4830:134:3::10]:49121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrewjameswood@ymail.com>) id 1fHEif-0001UA-AG
	for qemu-devel@nongnu.org; Fri, 11 May 2018 16:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrewjameswood@ymail.com>) id 1fHEia-0004a0-Do
	for qemu-devel@nongnu.org; Fri, 11 May 2018 16:32:49 -0400
Received: from sonic305-21.consmr.mail.ir2.yahoo.com ([77.238.177.83]:37089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrewjameswood@ymail.com>)
	id 1fHEia-0004Yk-6k
	for qemu-devel@nongnu.org; Fri, 11 May 2018 16:32:44 -0400
From: andrewjameswood@ymail.com
Date: Fri, 11 May 2018 21:32:38 +0100
Message-Id: <20180511203238.22881-1-andrewjameswood@ymail.com>
Subject: [Qemu-devel] [PATCH] Added SIGPWR handler to send ACPI shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Andrew Wood <awood@comms.org.uk>

From: Andrew Wood <awood@comms.org.uk>

Signed-off-by: Andrew Wood <awood@comms.org.uk>
---
 os-posix.c |  1 +
 vl.c       | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/os-posix.c b/os-posix.c
index b9c2343b1e..68d70f269b 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -70,6 +70,7 @@ void os_setup_signal_handling(void)
     sigaction(SIGINT,  &act, NULL);
     sigaction(SIGHUP,  &act, NULL);
     sigaction(SIGTERM, &act, NULL);
+    sigaction(SIGPWR, &act, NULL);
 }
 
 /* Find a likely location for support files using the location of the binary.
diff --git a/vl.c b/vl.c
index fce1fd12d8..55c5e06858 100644
--- a/vl.c
+++ b/vl.c
@@ -1846,8 +1846,17 @@ void qemu_system_killed(int signal, pid_t pid)
     /* Cannot call qemu_system_shutdown_request directly because
      * we are in a signal handler.
      */
-    shutdown_requested = SHUTDOWN_CAUSE_HOST_SIGNAL;
-    qemu_notify_event();
+    if (signal==SIGPWR)
+    {
+	
+	powerdown_requested = 1;
+    	qemu_notify_event();
+    }
+    else
+    {
+    	shutdown_requested = SHUTDOWN_CAUSE_HOST_SIGNAL;
+    	qemu_notify_event();
+    }
 }
 
 void qemu_system_shutdown_request(ShutdownCause reason)
-- 
2.11.0
