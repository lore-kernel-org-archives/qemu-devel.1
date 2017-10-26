Received: from eggs.gnu.org ([2001:4830:134:3::10]:54796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7rcU-0000hT-5i
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7rcP-0005Qu-Tk
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7rcP-0005PP-Ko
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:21 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9QNV6S6125981
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:31:17 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dusba089w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:31:17 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 19:31:15 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 18:30:51 -0500
In-Reply-To: <20171026233054.21133-1-mdroth@linux.vnet.ibm.com>
References: <20171026233054.21133-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171026233054.21133-4-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/6] qga: move w32 service handling out of
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
Cc: sameeh@daynix.com, yan@daynix.com, daniel@daynix.com

Eventually we want a w32 service to be able to restart the qga main
loop from within service_main(). To allow for this we move service
handling out of run_agent() such that service_main() calls
run_agent() instead of the reverse.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/main.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 6826cd5f45..2422ccf2f8 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -133,6 +133,7 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
                                   LPVOID ctx);
 VOID WINAPI service_main(DWORD argc, TCHAR *argv[]);
 #endif
+static int run_agent(GAState *s);
 
 static void
 init_dfl_pathnames(void)
@@ -768,7 +769,7 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
     service->status.dwWaitHint = 0;
     SetServiceStatus(service->status_handle, &service->status);
 
-    g_main_loop_run(ga_state->main_loop);
+    run_agent(ga_state);
 
     service->status.dwCurrentState = SERVICE_STOPPED;
     SetServiceStatus(service->status_handle, &service->status);
@@ -1377,17 +1378,8 @@ static int run_agent(GAState *s)
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
@@ -1473,7 +1465,18 @@ int main(int argc, char **argv)
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
+#endif
     ret = run_agent(s);
+
     cleanup_agent(s);
 
 end:
-- 
2.11.0
