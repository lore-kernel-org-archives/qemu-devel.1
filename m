Received: from eggs.gnu.org ([2001:4830:134:3::10]:57001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dSf8k-0004XI-1D
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dSf8h-0006uv-RU
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:54:26 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dSf8h-0006uf-KK
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:54:23 -0400
Received: by mail-wm0-x243.google.com with SMTP id y5so30601550wmh.3
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:54:23 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed,  5 Jul 2017 10:54:08 +0300
Message-Id: <20170705075411.6556-3-sameeh@daynix.com>
In-Reply-To: <20170705075411.6556-1-sameeh@daynix.com>
References: <20170705075411.6556-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH 2/5] qga-win: service-win32: Add start_service
 and stop_service functions
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

This commits adds two functions which handle service's start and stop
process in Windows.

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 qga/service-win32.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 qga/service-win32.h |  2 ++
 2 files changed, 54 insertions(+)

diff --git a/qga/service-win32.c b/qga/service-win32.c
index fd434e3..dc41d63 100644
--- a/qga/service-win32.c
+++ b/qga/service-win32.c
@@ -95,6 +95,26 @@ static const char *win_escape_arg(const char *to_escape, GString *buffer)
     return buffer->str;
 }
 
+
+static int get_service(const char *service_name, SC_HANDLE* service)
+{
+    SC_HANDLE manager = NULL;
+    manager = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
+    if (manager == NULL) {
+        printf_win_error("No handle to service control manager");
+        return EXIT_FAILURE;
+    }
+
+    *service = OpenService(manager, service_name, SERVICE_ALL_ACCESS);
+    if (service == NULL) {
+        printf_win_error("Failed to open service");
+        return EXIT_FAILURE;
+    }
+
+    CloseServiceHandle(manager);
+    return EXIT_SUCCESS;
+}
+
 int ga_install_service(const char *path, const char *logfile,
                        const char *state_dir)
 {
@@ -188,3 +208,35 @@ int ga_uninstall_service(void)
 
     return EXIT_SUCCESS;
 }
+
+int start_service(const char *service_name)
+{
+    int ret = EXIT_FAILURE;
+    SC_HANDLE service = NULL;
+    ret = get_service(service_name, &service);
+    if (ret != EXIT_SUCCESS) {
+        return ret;
+    }
+    ret = StartService(service, 0 , NULL) ? EXIT_SUCCESS : GetLastError();
+
+    CloseServiceHandle(service);
+    return ret;
+}
+
+int stop_service(const char *service_name)
+{
+    int ret = EXIT_FAILURE;
+    SC_HANDLE service = NULL;
+
+    SERVICE_STATUS service_status;
+    ret = get_service(service_name, &service);
+
+    if (ret != EXIT_SUCCESS) {
+        return ret;
+    }
+    ret = ControlService(service, SERVICE_CONTROL_STOP, &service_status) ?
+        EXIT_SUCCESS : GetLastError();
+
+    CloseServiceHandle(service);
+    return ret;
+}
diff --git a/qga/service-win32.h b/qga/service-win32.h
index 89e99df..65248ea 100644
--- a/qga/service-win32.h
+++ b/qga/service-win32.h
@@ -28,5 +28,7 @@ typedef struct GAService {
 int ga_install_service(const char *path, const char *logfile,
                        const char *state_dir);
 int ga_uninstall_service(void);
+int start_service(const char *service_name);
+int stop_service(const char *service_name);
 
 #endif
-- 
2.9.4
