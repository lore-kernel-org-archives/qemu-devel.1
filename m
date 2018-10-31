Received: from eggs.gnu.org ([2001:4830:134:3::10]:33453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHrMf-0000vA-7O
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHrMb-0007E2-93
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:20:55 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:42968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHrMb-0007Dm-2Z
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:20:53 -0400
Received: by mail-oi1-x22f.google.com with SMTP id h23-v6so13725839oih.9
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 07:20:53 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 31 Oct 2018 09:19:21 -0500
Message-Id: <20181031141925.30026-21-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181031141925.30026-1-mdroth@linux.vnet.ibm.com>
References: <20181031141925.30026-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v3 20/24] qga: move w32 service handling out of
 run_agent()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Bishara AbuHattoum <bishara@daynix.com>

Eventually we want a w32 service to be able to restart the qga main
loop from within service_main(). To allow for this we move service
handling out of run_agent() such that service_main() calls
run_agent() instead of the reverse.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Bishara AbuHattoum <bishara@daynix.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/main.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index eb31f99b38..761007deb4 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -119,6 +119,7 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
                                   LPVOID ctx);
 VOID WINAPI service_main(DWORD argc, TCHAR *argv[]);
 #endif
+static int run_agent(GAState *s);
 
 static void
 init_dfl_pathnames(void)
@@ -712,7 +713,7 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
     service->status.dwWaitHint = 0;
     SetServiceStatus(service->status_handle, &service->status);
 
-    g_main_loop_run(ga_state->main_loop);
+    run_agent(ga_state);
 
     service->status.dwCurrentState = SERVICE_STOPPED;
     SetServiceStatus(service->status_handle, &service->status);
@@ -1340,17 +1341,8 @@ static int run_agent(GAState *s)
         g_critical("failed to initialize guest agent channel");
         return EXIT_FAILURE;
     }
-#ifndef _WIN32
+
     g_main_loop_run(ga_state->main_loop);
-#else
-    if (s->config->daemonize) {
-        SERVICE_TABLE_ENTRY service_table[] = {
-            { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL } };
-        StartServiceCtrlDispatcher(service_table);
-    } else {
-        g_main_loop_run(ga_state->main_loop);
-    }
-#endif
 
     return EXIT_SUCCESS;
 }
@@ -1436,7 +1428,19 @@ int main(int argc, char **argv)
         g_critical("error initializing guest agent");
         goto end;
     }
+
+#ifdef _WIN32
+    if (config->daemonize) {
+        SERVICE_TABLE_ENTRY service_table[] = {
+            { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL } };
+        StartServiceCtrlDispatcher(service_table);
+    } else {
+        ret = run_agent(s);
+    }
+#else
     ret = run_agent(s);
+#endif
+
     cleanup_agent(s);
 
 end:
-- 
2.17.1
