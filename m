Received: from eggs.gnu.org ([2001:4830:134:3::10]:47071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g96pY-00053k-A8
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g96pW-0007PL-Bb
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:35 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:35114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bishara@daynix.com>) id 1g96pW-0007Oc-31
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id w5-v6so17745658wrt.2
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 04:02:33 -0700 (PDT)
From: Bishara AbuHattoum <bishara@daynix.com>
Date: Sun,  7 Oct 2018 14:02:19 +0300
Message-Id: <20181007110223.129692-4-bishara@daynix.com>
In-Reply-To: <20181007110223.129692-1-bishara@daynix.com>
References: <20181007110223.129692-1-bishara@daynix.com>
Subject: [Qemu-devel] [PATCH v2 3/7] qga: move w32 service handling out of
 run_agent()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Sameeh Jubran <sameeh@daynix.com>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

Eventually we want a w32 service to be able to restart the qga main
loop from within service_main(). To allow for this we move service
handling out of run_agent() such that service_main() calls
run_agent() instead of the reverse.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Bishara AbuHattoum <bishara@daynix.com>
---
 qga/main.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 9f4dc0b2c5..23a0a46b84 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -136,6 +136,7 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
                                   LPVOID ctx);
 VOID WINAPI service_main(DWORD argc, TCHAR *argv[]);
 #endif
+static int run_agent(GAState *s);
 
 static void
 init_dfl_pathnames(void)
@@ -729,7 +730,7 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
     service->status.dwWaitHint = 0;
     SetServiceStatus(service->status_handle, &service->status);
 
-    g_main_loop_run(ga_state->main_loop);
+    run_agent(ga_state);
 
     service->status.dwCurrentState = SERVICE_STOPPED;
     SetServiceStatus(service->status_handle, &service->status);
@@ -1338,17 +1339,8 @@ static int run_agent(GAState *s)
         g_critical("failed to initialize guest agent channel");
         return EXIT_FAILURE;
     }
-#ifndef _WIN32
+
     g_main_loop_run(ga_state->main_loop);
-#else
-    if (config->daemonize) {
-        SERVICE_TABLE_ENTRY service_table[] = {
-            { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL } };
-        StartServiceCtrlDispatcher(service_table);
-    } else {
-        g_main_loop_run(ga_state->main_loop);
-    }
-#endif
 
     return EXIT_SUCCESS;
 }
@@ -1434,7 +1426,19 @@ int main(int argc, char **argv)
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
2.17.0
