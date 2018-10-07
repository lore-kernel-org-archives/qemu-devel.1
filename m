Received: from eggs.gnu.org ([2001:4830:134:3::10]:47125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g96pf-0005AW-NY
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g96pc-0007Rg-Dn
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:54937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bishara@daynix.com>) id 1g96pa-0007Qi-Lf
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id r63-v6so5487361wma.4
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 04:02:38 -0700 (PDT)
From: Bishara AbuHattoum <bishara@daynix.com>
Date: Sun,  7 Oct 2018 14:02:23 +0300
Message-Id: <20181007110223.129692-8-bishara@daynix.com>
In-Reply-To: <20181007110223.129692-1-bishara@daynix.com>
References: <20181007110223.129692-1-bishara@daynix.com>
Subject: [Qemu-devel] [PATCH v2 7/7] qga-win: changing --retry-path option
 behavior
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

Currently whenever the qemu-ga's service doesn't find the virtio-serial
the run_agent() loops in a QGA_RETRY_INTERVAL (default 5 seconds)
intervals and try to restart the qemu-ga which causes a synchronous loop.
Changed to wait and listen for the serial events by registering for
notifications a proper serial event handler that deals with events:
  DBT_DEVICEARRIVAL        indicates that the device has been inserted and
                           is available
  DBT_DEVICEREMOVECOMPLETE indicates that the devive has been removed
Which allow us to determine when the channel path is available for the
qemu-ga to restart.

Signed-off-by: Bishara AbuHattoum <bishara@daynix.com>
Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
---
 qga/main.c          | 86 ++++++++++++++++++++++++++++++++++++++++++++-
 qga/service-win32.h |  4 +++
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/qga/main.c b/qga/main.c
index f359499aaa..c5bb063b1c 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -34,6 +34,7 @@
 #include "qemu/systemd.h"
 #include "qemu-version.h"
 #ifdef _WIN32
+#include <dbt.h>
 #include "qga/service-win32.h"
 #include "qga/vss-win32.h"
 #endif
@@ -101,6 +102,7 @@ struct GAState {
     bool logging_enabled;
 #ifdef _WIN32
     GAService service;
+    HANDLE wakeup_event;
 #endif
     bool delimit_response;
     bool frozen;
@@ -137,6 +139,7 @@ static const char *ga_freeze_whitelist[] = {
 #ifdef _WIN32
 DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
                                   LPVOID ctx);
+DWORD WINAPI handle_serial_device_events(DWORD type, LPVOID data);
 VOID WINAPI service_main(DWORD argc, TCHAR *argv[]);
 #endif
 static int run_agent(GAState *s);
@@ -695,6 +698,36 @@ static gboolean channel_init(GAState *s, const gchar *method, const gchar *path,
 }
 
 #ifdef _WIN32
+DWORD WINAPI handle_serial_device_events(DWORD type, LPVOID data)
+{
+    DWORD ret = NO_ERROR;
+    PDEV_BROADCAST_HDR broadcast_header = (PDEV_BROADCAST_HDR)data;
+
+    if (broadcast_header->dbch_devicetype == DBT_DEVTYP_DEVICEINTERFACE) {
+        switch (type) {
+            /* Device inserted */
+        case DBT_DEVICEARRIVAL:
+            /* Start QEMU-ga's service */
+            if (!SetEvent(ga_state->wakeup_event)) {
+                ret = GetLastError();
+            }
+            break;
+            /* Device removed */
+        case DBT_DEVICEQUERYREMOVE:
+        case DBT_DEVICEREMOVEPENDING:
+        case DBT_DEVICEREMOVECOMPLETE:
+            /* Stop QEMU-ga's service */
+            if (!ResetEvent(ga_state->wakeup_event)) {
+                ret = GetLastError();
+            }
+            break;
+        default:
+            ret = ERROR_CALL_NOT_IMPLEMENTED;
+        }
+    }
+    return ret;
+}
+
 DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
                                   LPVOID ctx)
 {
@@ -706,9 +739,13 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
         case SERVICE_CONTROL_STOP:
         case SERVICE_CONTROL_SHUTDOWN:
             quit_handler(SIGTERM);
+            SetEvent(ga_state->wakeup_event);
             service->status.dwCurrentState = SERVICE_STOP_PENDING;
             SetServiceStatus(service->status_handle, &service->status);
             break;
+        case SERVICE_CONTROL_DEVICEEVENT:
+            handle_serial_device_events(type, data);
+            break;
 
         default:
             ret = ERROR_CALL_NOT_IMPLEMENTED;
@@ -735,10 +772,24 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
     service->status.dwServiceSpecificExitCode = NO_ERROR;
     service->status.dwCheckPoint = 0;
     service->status.dwWaitHint = 0;
+    DEV_BROADCAST_DEVICEINTERFACE notification_filter;
+    ZeroMemory(&notification_filter, sizeof(notification_filter));
+    notification_filter.dbcc_devicetype = DBT_DEVTYP_DEVICEINTERFACE;
+    notification_filter.dbcc_size = sizeof(DEV_BROADCAST_DEVICEINTERFACE);
+    notification_filter.dbcc_classguid = GUID_VIOSERIAL_PORT;
+
+    service->device_notification_handle =
+        RegisterDeviceNotification(service->status_handle,
+            &notification_filter, DEVICE_NOTIFY_SERVICE_HANDLE);
+    if (!service->device_notification_handle) {
+        g_critical("Failed to register device notification handle!\n");
+        return;
+    }
     SetServiceStatus(service->status_handle, &service->status);
 
     run_agent(ga_state);
 
+    UnregisterDeviceNotification(service->device_notification_handle);
     service->status.dwCurrentState = SERVICE_STOPPED;
     SetServiceStatus(service->status_handle, &service->status);
 }
@@ -1326,12 +1377,24 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
 
     s->config = config;
     s->socket_activation = socket_activation;
+
+#ifdef _WIN32
+    s->wakeup_event = CreateEvent(NULL, TRUE, FALSE, TEXT("WakeUp"));
+    if (s->wakeup_event == NULL) {
+        g_critical("CreateEvent failed");
+        return NULL;
+    }
+#endif
+
     ga_state = s;
     return s;
 }
 
 static void cleanup_agent(GAState *s)
 {
+#ifdef _WIN32
+    CloseHandle(s->wakeup_event);
+#endif
     if (s->command_state) {
         ga_command_state_cleanup_all(s->command_state);
         ga_command_state_free(s->command_state);
@@ -1363,6 +1426,27 @@ static int run_agent_once(GAState *s)
     return EXIT_SUCCESS;
 }
 
+static void wait_for_channel_availability(GAState *s)
+{
+    g_warning("waiting for channel path...");
+#ifndef _WIN32
+    sleep(QGA_RETRY_INTERVAL);
+#else
+    DWORD dwWaitResult;
+
+    dwWaitResult = WaitForSingleObject(s->wakeup_event, INFINITE);
+
+    switch (dwWaitResult) {
+    case WAIT_OBJECT_0:
+        break;
+    case WAIT_TIMEOUT:
+        break;
+    default:
+        g_critical("WaitForSingleObject failed");
+    }
+#endif
+}
+
 static int run_agent(GAState *s)
 {
     int ret = EXIT_SUCCESS;
@@ -1373,7 +1457,7 @@ static int run_agent(GAState *s)
         ret = run_agent_once(s);
         if (s->config->retry_path && !s->force_exit) {
             g_warning("agent stopped unexpectedly, restarting...");
-            sleep(QGA_RETRY_INTERVAL);
+            wait_for_channel_availability(s);
         }
     } while (s->config->retry_path && !s->force_exit);
 
diff --git a/qga/service-win32.h b/qga/service-win32.h
index 89e99dfede..7b16d69b57 100644
--- a/qga/service-win32.h
+++ b/qga/service-win32.h
@@ -20,9 +20,13 @@
 #define QGA_SERVICE_NAME         "qemu-ga"
 #define QGA_SERVICE_DESCRIPTION  "Enables integration with QEMU machine emulator and virtualizer."
 
+static const GUID GUID_VIOSERIAL_PORT = { 0x6fde7521, 0x1b65, 0x48ae,
+{ 0xb6, 0x28, 0x80, 0xbe, 0x62, 0x1, 0x60, 0x26 } };
+
 typedef struct GAService {
     SERVICE_STATUS status;
     SERVICE_STATUS_HANDLE status_handle;
+    HDEVNOTIFY device_notification_handle;
 } GAService;
 
 int ga_install_service(const char *path, const char *logfile,
-- 
2.17.0
