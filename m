Received: from eggs.gnu.org ([2001:4830:134:3::10]:57041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dSf8l-0004YO-Qy
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dSf8l-0006wK-07
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:54:27 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dSf8k-0006vp-QR
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:54:26 -0400
Received: by mail-wr0-x244.google.com with SMTP id k67so49070999wrc.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:54:26 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed,  5 Jul 2017 10:54:11 +0300
Message-Id: <20170705075411.6556-6-sameeh@daynix.com>
In-Reply-To: <20170705075411.6556-1-sameeh@daynix.com>
References: <20170705075411.6556-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH 5/5] qga-win: service-win32: Use get_service
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>

From: Sameeh Jubran <sjubran@redhat.com>

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 qga/service-win32.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/qga/service-win32.c b/qga/service-win32.c
index 861f9fc..c17e0eb 100644
--- a/qga/service-win32.c
+++ b/qga/service-win32.c
@@ -198,20 +198,12 @@ int ga_install_service(const char *path, const char *logfile,
 
 static int uninstall_service(LPCTSTR service_name)
 {
-    SC_HANDLE manager;
-    SC_HANDLE service;
-
-    manager = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
-    if (manager == NULL) {
-        printf_win_error("No handle to service control manager");
-        return EXIT_FAILURE;
-    }
+    int ret = EXIT_FAILURE;
+    SC_HANDLE service = NULL;
+    ret = get_service(service_name, &service);
 
-    service = OpenService(manager, service_name, DELETE);
-    if (service == NULL) {
-        printf_win_error("No handle to service");
-        CloseServiceHandle(manager);
-        return EXIT_FAILURE;
+    if (ret != EXIT_SUCCESS) {
+        return ret;
     }
 
     if (DeleteService(service) == FALSE) {
@@ -221,7 +213,6 @@ static int uninstall_service(LPCTSTR service_name)
     }
 
     CloseServiceHandle(service);
-    CloseServiceHandle(manager);
 
     return EXIT_SUCCESS;
 }
-- 
2.9.4
