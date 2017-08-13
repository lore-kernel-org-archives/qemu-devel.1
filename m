Received: from eggs.gnu.org ([2001:4830:134:3::10]:40059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dgvIA-0000QR-Hp
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 11:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dgvI6-0003lU-Nr
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 11:59:06 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dgvI6-0003ka-Dr
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 11:59:02 -0400
Received: by mail-wm0-x242.google.com with SMTP id t138so11858908wmt.4
	for <qemu-devel@nongnu.org>; Sun, 13 Aug 2017 08:59:02 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 13 Aug 2017 18:58:49 +0300
Message-Id: <20170813155849.11368-4-sameeh@daynix.com>
In-Reply-To: <20170813155849.11368-1-sameeh@daynix.com>
References: <20170813155849.11368-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH 3/3] qga: Prevent qemu-ga exit if serial
 doesn't exist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Cc: yan@daynix.com

From: Sameeh Jubran <sjubran@redhat.com>

Currently whenever the qemu-ga's service doesn't find the virtio-serial
it terminates. This commit addresses this issue by listening to the serial events
by registering for notifications for the chosen serial and it handles channel
initialization accordingily.

A list of possible scenarios of which could lead to this behavour:

* qemu-ga's service is started while the virtio-serial driver hasn't been installed yet
* hotplug/ unplug of the virtio-serial device
* upgrading the virtio-serial driver

Note: This problem is much more common on Windows as the virtio-serial
driver should be installed by the user and isn't shipped with the Windows OS.

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 Makefile            |   4 +
 qga/main.c          | 240 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 qga/service-win32.h |   4 +
 3 files changed, 239 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index ef72148..82f26d5 100644
--- a/Makefile
+++ b/Makefile
@@ -203,6 +203,10 @@ $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
+ifndef CONFIG_WIN32
+LIBS_QGA+=-ludev
+endif
+
 HELPERS-$(CONFIG_LINUX) = qemu-bridge-helper$(EXESUF)
 
 ifdef BUILD_DOCS
diff --git a/qga/main.c b/qga/main.c
index cf312b9..d727880 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -16,6 +16,8 @@
 #ifndef _WIN32
 #include <syslog.h>
 #include <sys/wait.h>
+#include <libudev.h>
+#include <sys/types.h>
 #endif
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/json-parser.h"
@@ -30,6 +32,7 @@
 #include "qemu/sockets.h"
 #include "qemu/systemd.h"
 #ifdef _WIN32
+#include <dbt.h>
 #include "qga/service-win32.h"
 #include "qga/vss-win32.h"
 #endif
@@ -74,6 +77,10 @@ struct GAState {
     GLogLevelFlags log_level;
     FILE *log_file;
     bool logging_enabled;
+    bool serial_connected;
+#ifndef _WIN32
+    struct udev_monitor *udev_monitor;
+#endif
 #ifdef _WIN32
     GAService service;
 #endif
@@ -130,9 +137,15 @@ static const char *ga_freeze_whitelist[] = {
 #ifdef _WIN32
 DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
                                   LPVOID ctx);
+DWORD WINAPI handle_serial_device_events(DWORD type, LPVOID data);
 VOID WINAPI service_main(DWORD argc, TCHAR *argv[]);
 #endif
 
+static bool get_channel_method(GAChannelMethod *channel_method,
+    const gchar *method, GAState *s);
+static gboolean channel_init(GAState *s, const gchar *method, const gchar *path,
+    int listen_fd, bool *serial_connected);
+
 static void
 init_dfl_pathnames(void)
 {
@@ -186,6 +199,136 @@ static void quit_handler(int sig)
 }
 
 #ifndef _WIN32
+static int get_method_udev_subsystem(const char **serial_subsystem)
+{
+    if (strcmp(ga_config->method, "virtio-serial") == 0) {
+        *serial_subsystem = SUBSYSTEM_VIRTIO_SERIAL;
+    } else if (strcmp(ga_config->method, "isa-serial") == 0) {
+        /* try the default path for the serial port - COM1 */
+        *serial_subsystem = SUBSYSTEM_ISA_SERIAL;
+    } else {
+        serial_subsystem = NULL;
+        return -1;
+    }
+    return 0;
+}
+
+static gboolean serial_event_callback(GIOChannel *source,
+    GIOCondition condition, gpointer data)
+{
+    struct udev_monitor *mon = ga_state->udev_monitor;
+    const char *serial_subsystem = NULL;
+    struct udev_device *dev;
+
+    if (get_method_udev_subsystem(&serial_subsystem) == -1) {
+        return false;
+    }
+    dev = udev_monitor_receive_device(mon);
+
+    if (dev && serial_subsystem && strcmp(udev_device_get_subsystem(dev),
+        serial_subsystem) ==  0) {
+
+        GAChannelMethod channel_method;
+        get_channel_method(&channel_method, ga_config->method, ga_state);
+        if (ga_channel_was_serial_attached(channel_method,
+            ga_config->channel_path, ga_state->serial_connected)) {
+            ga_state->serial_connected = true;
+            if (!channel_init(ga_state,
+                ga_config->method, ga_config->channel_path,
+                ga_socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1,
+                &ga_state->serial_connected)) {
+                g_critical("failed to initialize guest agent channel");
+            }
+        }
+
+        if (ga_channel_was_serial_detached(channel_method,
+            ga_config->channel_path, ga_state->serial_connected)) {
+            ga_state->serial_connected = false;
+            ga_channel_free(ga_state->channel);
+        }
+        udev_device_unref(dev);
+    }
+    return true;
+}
+
+static int monitor_serial_events(void)
+{
+    int ret = 0;
+    const char *serial_subsystem = NULL;
+    struct udev *udev = NULL;
+    ga_state->udev_monitor = NULL;
+    GIOChannel *channel = NULL;
+    GSource *watch_source = NULL;
+    if (get_method_udev_subsystem(&serial_subsystem) == -1) {
+        ret = -1;
+        goto out;
+    }
+
+    udev = udev_new();
+    if (!udev) {
+        g_error("Couldn't create udev\n");
+        ret = -1;
+        goto out;
+    }
+
+    ga_state->udev_monitor =
+        udev_monitor_new_from_netlink(udev, "udev");
+    if (!ga_state->udev_monitor) {
+        ret = -1;
+        goto out;
+    } else {
+        /* We don't want the udev_monitor to be freed on out, so increase
+         * ref count
+         */
+        udev_monitor_ref(ga_state->udev_monitor);
+    }
+
+    if (udev_monitor_filter_add_match_subsystem_devtype(ga_state->udev_monitor,
+        serial_subsystem, NULL) < 0 ||
+        udev_monitor_enable_receiving(ga_state->udev_monitor) < 0) {
+        ret = -1;
+        goto out;
+    }
+
+    channel =
+        g_io_channel_unix_new(udev_monitor_get_fd(ga_state->udev_monitor));
+    if (!channel) {
+        ret = -1;
+        goto out;
+    }
+    watch_source = g_io_create_watch(channel, G_IO_IN);
+    if (!watch_source) {
+        ret = -1;
+        goto out;
+    }
+    g_source_set_callback(watch_source, (GSourceFunc)serial_event_callback,
+        ga_state->udev_monitor, NULL);
+    g_source_attach(watch_source, g_main_loop_get_context(ga_state->main_loop));
+
+out:
+    if (udev) {
+        udev_unref(udev);
+    }
+    if (ga_state->udev_monitor) {
+        udev_monitor_unref(ga_state->udev_monitor);
+    }
+    if (channel) {
+        g_io_channel_unref(channel);
+    }
+    if (watch_source) {
+        g_source_unref(watch_source);
+    }
+
+    return ret;
+}
+
+static void free_monitor_resources(void)
+{
+    if (ga_state->udev_monitor) {
+        udev_monitor_unref(ga_state->udev_monitor);
+    }
+}
+
 static gboolean register_signal_handlers(void)
 {
     struct sigaction sigact;
@@ -694,24 +837,38 @@ static gboolean channel_event_cb(GIOCondition condition, gpointer data)
     return true;
 }
 
-static gboolean channel_init(GAState *s, const gchar *method, const gchar *path,
-                             int listen_fd)
+static bool get_channel_method(GAChannelMethod *channel_method,
+    const gchar *method, GAState *s)
 {
-    GAChannelMethod channel_method;
+    assert(channel_method);
+    assert(method);
 
     if (strcmp(method, "virtio-serial") == 0) {
+        assert(s);
         s->virtio = true; /* virtio requires special handling in some cases */
-        channel_method = GA_CHANNEL_VIRTIO_SERIAL;
+        *channel_method = GA_CHANNEL_VIRTIO_SERIAL;
     } else if (strcmp(method, "isa-serial") == 0) {
-        channel_method = GA_CHANNEL_ISA_SERIAL;
+        *channel_method = GA_CHANNEL_ISA_SERIAL;
     } else if (strcmp(method, "unix-listen") == 0) {
-        channel_method = GA_CHANNEL_UNIX_LISTEN;
+        *channel_method = GA_CHANNEL_UNIX_LISTEN;
     } else if (strcmp(method, "vsock-listen") == 0) {
-        channel_method = GA_CHANNEL_VSOCK_LISTEN;
+        *channel_method = GA_CHANNEL_VSOCK_LISTEN;
     } else {
         g_critical("unsupported channel method/type: %s", method);
         return false;
     }
+    return true;
+}
+
+static gboolean channel_init(GAState *s, const gchar *method, const gchar *path,
+                             int listen_fd, bool *serial_connected)
+{
+    assert(serial_connected);
+    GAChannelMethod channel_method;
+    if (!get_channel_method(&channel_method, method, s)) {
+        return false;
+    }
+    *serial_connected = ga_channel_serial_is_present(channel_method, path);
 
     s->channel = ga_channel_new(channel_method, path, listen_fd,
                                 channel_event_cb, s);
@@ -724,6 +881,48 @@ static gboolean channel_init(GAState *s, const gchar *method, const gchar *path,
 }
 
 #ifdef _WIN32
+DWORD WINAPI handle_serial_device_events(DWORD type, LPVOID data)
+{
+    DWORD ret = NO_ERROR;
+    PDEV_BROADCAST_HDR broadcast_header = (PDEV_BROADCAST_HDR)data;
+    GAChannelMethod channel_method;
+
+    if (broadcast_header->dbch_devicetype == DBT_DEVTYP_DEVICEINTERFACE) {
+        get_channel_method(&channel_method, ga_config->method, ga_state);
+        switch (type) {
+            /* Device inserted */
+        case DBT_DEVICEARRIVAL:
+            /* Start QEMU-ga's service */
+            if (ga_channel_was_serial_attached(channel_method,
+                ga_config->channel_path, ga_state->serial_connected)) {
+                if (!channel_init(ga_state,
+                    ga_config->method, ga_config->channel_path,
+                    ga_socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1,
+                    &ga_state->serial_connected)) {
+                    g_critical("failed to initialize guest agent channel");
+                    ret = EXIT_FAILURE;
+                }
+            }
+            break;
+            /* Device removed */
+        case DBT_DEVICEQUERYREMOVE:
+        case DBT_DEVICEREMOVEPENDING:
+        case DBT_DEVICEREMOVECOMPLETE:
+
+            /* Stop QEMU-ga's service */
+            if (ga_channel_was_serial_detached(channel_method,
+                ga_config->channel_path, ga_state->serial_connected)) {
+                ga_state->serial_connected = false;
+                ga_channel_free(ga_state->channel);
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
@@ -738,6 +937,9 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
             service->status.dwCurrentState = SERVICE_STOP_PENDING;
             SetServiceStatus(service->status_handle, &service->status);
             break;
+        case SERVICE_CONTROL_DEVICEEVENT:
+            handle_serial_device_events(type, data);
+            break;
 
         default:
             ret = ERROR_CALL_NOT_IMPLEMENTED;
@@ -764,10 +966,24 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
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
 
     g_main_loop_run(ga_state->main_loop);
 
+    UnregisterDeviceNotification(service->device_notification_handle);
     service->status.dwCurrentState = SERVICE_STOPPED;
     SetServiceStatus(service->status_handle, &service->status);
 }
@@ -1330,20 +1546,26 @@ static int run_agent(GAState *s, GAConfig *config, int socket_activation)
 #endif
 
     s->main_loop = g_main_loop_new(NULL, false);
-
     if (!channel_init(ga_state, config->method, config->channel_path,
-                      socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {
+                      socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1,
+                      &ga_state->serial_connected) &&
+                      ga_state->serial_connected) {
         g_critical("failed to initialize guest agent channel");
         return EXIT_FAILURE;
     }
 #ifndef _WIN32
+    monitor_serial_events();
     g_main_loop_run(ga_state->main_loop);
+    free_monitor_resources();
 #else
     if (config->daemonize) {
         SERVICE_TABLE_ENTRY service_table[] = {
             { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL } };
         StartServiceCtrlDispatcher(service_table);
     } else {
+        if (!ga_state->serial_connected) {
+            return EXIT_FAILURE;
+        }
         g_main_loop_run(ga_state->main_loop);
     }
 #endif
diff --git a/qga/service-win32.h b/qga/service-win32.h
index 89e99df..7b16d69 100644
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
2.9.4
