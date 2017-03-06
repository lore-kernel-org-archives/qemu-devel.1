Received: from eggs.gnu.org ([2001:4830:134:3::10]:60379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cknec-0002iZ-OB
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ckneZ-0006VC-9s
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:06:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ckneY-0006Uc-Oj
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:05:59 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2683oVg140887
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 03:05:57 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 290u3hkymr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 03:05:57 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 6 Mar 2017 01:05:56 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  6 Mar 2017 02:03:40 -0600
In-Reply-To: <1488787422-30487-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1488787422-30487-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1488787422-30487-2-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL for-2.9 1/3] qga: add systemd socket activation
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

AF_UNIX and AF_VSOCK listen sockets can be passed in by systemd on
startup.  This allows systemd to manage the listen socket until the
first client connects and between restarts.  Advantages of socket
activation are that parallel startup of network services becomes
possible and that unused daemons do not consume memory.

The key to achieving this is the LISTEN_FDS environment variable, which
is a stable ABI as shown here:
https://www.freedesktop.org/wiki/Software/systemd/InterfacePortabilityAndStabilityChart/

We could link against libsystemd and use sd_listen_fds(3) but it's easy
to implement the tiny LISTEN_FDS ABI so that qemu-ga does not depend on
libsystemd.  Some systems may not have systemd installed and wish to
avoid the dependency.  Other init systems or socket activation servers
may implement the same ABI without systemd involvement.

Test as follows:

  $ cat ~/.config/systemd/user/qga.service
  [Unit]
  Description=qga

  [Service]
  WorkingDirectory=/tmp
  ExecStart=/path/to/qemu-ga --logfile=/tmp/qga.log --pidfile=/tmp/qga.pid --statedir=/tmp

  $ cat ~/.config/systemd/user/qga.socket
  [Socket]
  ListenStream=/tmp/qga.sock

  [Install]
  WantedBy=default.target

  $ systemctl --user daemon-reload
  $ systemctl --user start qga.socket
  $ nc -U /tmp/qga.sock

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/channel-posix.c | 68 ++++++++++++++++++++++++++----------------------
 qga/channel-win32.c |  2 +-
 qga/channel.h       |  3 ++-
 qga/main.c          | 74 +++++++++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 110 insertions(+), 37 deletions(-)

diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 71582e0..3f34465 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -118,14 +118,16 @@ static int ga_channel_client_add(GAChannel *c, int fd)
     return 0;
 }
 
-static gboolean ga_channel_open(GAChannel *c, const gchar *path, GAChannelMethod method)
+static gboolean ga_channel_open(GAChannel *c, const gchar *path,
+                                GAChannelMethod method, int fd)
 {
     int ret;
     c->method = method;
 
     switch (c->method) {
     case GA_CHANNEL_VIRTIO_SERIAL: {
-        int fd = qemu_open(path, O_RDWR | O_NONBLOCK
+        assert(fd < 0);
+        fd = qemu_open(path, O_RDWR | O_NONBLOCK
 #ifndef CONFIG_SOLARIS
                            | O_ASYNC
 #endif
@@ -153,7 +155,9 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path, GAChannelMethod
     }
     case GA_CHANNEL_ISA_SERIAL: {
         struct termios tio;
-        int fd = qemu_open(path, O_RDWR | O_NOCTTY | O_NONBLOCK);
+
+        assert(fd < 0);
+        fd = qemu_open(path, O_RDWR | O_NOCTTY | O_NONBLOCK);
         if (fd == -1) {
             g_critical("error opening channel: %s", strerror(errno));
             return false;
@@ -183,37 +187,41 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path, GAChannelMethod
         break;
     }
     case GA_CHANNEL_UNIX_LISTEN: {
-        Error *local_err = NULL;
-        int fd = unix_listen(path, NULL, strlen(path), &local_err);
-        if (local_err != NULL) {
-            g_critical("%s", error_get_pretty(local_err));
-            error_free(local_err);
-            return false;
+        if (fd < 0) {
+            Error *local_err = NULL;
+
+            fd = unix_listen(path, NULL, strlen(path), &local_err);
+            if (local_err != NULL) {
+                g_critical("%s", error_get_pretty(local_err));
+                error_free(local_err);
+                return false;
+            }
         }
         ga_channel_listen_add(c, fd, true);
         break;
     }
     case GA_CHANNEL_VSOCK_LISTEN: {
-        Error *local_err = NULL;
-        SocketAddress *addr;
-        char *addr_str;
-        int fd;
-
-        addr_str = g_strdup_printf("vsock:%s", path);
-        addr = socket_parse(addr_str, &local_err);
-        g_free(addr_str);
-        if (local_err != NULL) {
-            g_critical("%s", error_get_pretty(local_err));
-            error_free(local_err);
-            return false;
-        }
+        if (fd < 0) {
+            Error *local_err = NULL;
+            SocketAddress *addr;
+            char *addr_str;
 
-        fd = socket_listen(addr, &local_err);
-        qapi_free_SocketAddress(addr);
-        if (local_err != NULL) {
-            g_critical("%s", error_get_pretty(local_err));
-            error_free(local_err);
-            return false;
+            addr_str = g_strdup_printf("vsock:%s", path);
+            addr = socket_parse(addr_str, &local_err);
+            g_free(addr_str);
+            if (local_err != NULL) {
+                g_critical("%s", error_get_pretty(local_err));
+                error_free(local_err);
+                return false;
+            }
+
+            fd = socket_listen(addr, &local_err);
+            qapi_free_SocketAddress(addr);
+            if (local_err != NULL) {
+                g_critical("%s", error_get_pretty(local_err));
+                error_free(local_err);
+                return false;
+            }
         }
         ga_channel_listen_add(c, fd, true);
         break;
@@ -262,13 +270,13 @@ GIOStatus ga_channel_read(GAChannel *c, gchar *buf, gsize size, gsize *count)
 }
 
 GAChannel *ga_channel_new(GAChannelMethod method, const gchar *path,
-                          GAChannelCallback cb, gpointer opaque)
+                          int listen_fd, GAChannelCallback cb, gpointer opaque)
 {
     GAChannel *c = g_new0(GAChannel, 1);
     c->event_cb = cb;
     c->user_data = opaque;
 
-    if (!ga_channel_open(c, path, method)) {
+    if (!ga_channel_open(c, path, method, listen_fd)) {
         g_critical("error opening channel");
         ga_channel_free(c);
         return NULL;
diff --git a/qga/channel-win32.c b/qga/channel-win32.c
index 21f9dee..7e6dc4d 100644
--- a/qga/channel-win32.c
+++ b/qga/channel-win32.c
@@ -316,7 +316,7 @@ static gboolean ga_channel_open(GAChannel *c, GAChannelMethod method,
 }
 
 GAChannel *ga_channel_new(GAChannelMethod method, const gchar *path,
-                          GAChannelCallback cb, gpointer opaque)
+                          int listen_fd, GAChannelCallback cb, gpointer opaque)
 {
     GAChannel *c = g_new0(GAChannel, 1);
     SECURITY_ATTRIBUTES sec_attrs;
diff --git a/qga/channel.h b/qga/channel.h
index 8fd0c8f..1778416 100644
--- a/qga/channel.h
+++ b/qga/channel.h
@@ -25,7 +25,8 @@ typedef enum {
 typedef gboolean (*GAChannelCallback)(GIOCondition condition, gpointer opaque);
 
 GAChannel *ga_channel_new(GAChannelMethod method, const gchar *path,
-                          GAChannelCallback cb, gpointer opaque);
+                          int listen_fd, GAChannelCallback cb,
+                          gpointer opaque);
 void ga_channel_free(GAChannel *c);
 GIOStatus ga_channel_read(GAChannel *c, gchar *buf, gsize size, gsize *count);
 GIOStatus ga_channel_write_all(GAChannel *c, const gchar *buf, gsize size);
diff --git a/qga/main.c b/qga/main.c
index 538e4ee..675ef81 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -28,6 +28,7 @@
 #include "qga/channel.h"
 #include "qemu/bswap.h"
 #include "qemu/help_option.h"
+#include "qemu/sockets.h"
 #ifdef _WIN32
 #include "qga/service-win32.h"
 #include "qga/vss-win32.h"
@@ -184,6 +185,37 @@ void reopen_fd_to_null(int fd)
 }
 #endif
 
+/**
+ * get_listen_fd:
+ * @consume: true to prevent future calls from succeeding
+ *
+ * Fetch a listen file descriptor that was passed via systemd socket
+ * activation.  Use @consume to prevent child processes from thinking a file
+ * descriptor was passed.
+ *
+ * Returns: file descriptor or -1 if no fd was passed
+ */
+static int get_listen_fd(bool consume)
+{
+#ifdef _WIN32
+    return -1; /* no fd passing expected, unsetenv(3) not available */
+#else
+    const char *listen_fds = getenv("LISTEN_FDS");
+    int fd = STDERR_FILENO + 1;
+
+    if (!listen_fds || strcmp(listen_fds, "1") != 0) {
+        return -1;
+    }
+
+    if (consume) {
+        unsetenv("LISTEN_FDS");
+    }
+
+    qemu_set_cloexec(fd);
+    return fd;
+#endif /* !_WIN32 */
+}
+
 static void usage(const char *cmd)
 {
     printf(
@@ -648,7 +680,8 @@ static gboolean channel_event_cb(GIOCondition condition, gpointer data)
     return true;
 }
 
-static gboolean channel_init(GAState *s, const gchar *method, const gchar *path)
+static gboolean channel_init(GAState *s, const gchar *method, const gchar *path,
+                             int listen_fd)
 {
     GAChannelMethod channel_method;
 
@@ -666,7 +699,8 @@ static gboolean channel_init(GAState *s, const gchar *method, const gchar *path)
         return false;
     }
 
-    s->channel = ga_channel_new(channel_method, path, channel_event_cb, s);
+    s->channel = ga_channel_new(channel_method, path, listen_fd,
+                                channel_event_cb, s);
     if (!s->channel) {
         g_critical("failed to create guest agent channel");
         return false;
@@ -1025,7 +1059,9 @@ static void config_dump(GAConfig *config)
 
     g_key_file_set_boolean(keyfile, "general", "daemon", config->daemonize);
     g_key_file_set_string(keyfile, "general", "method", config->method);
-    g_key_file_set_string(keyfile, "general", "path", config->channel_path);
+    if (config->channel_path) {
+        g_key_file_set_string(keyfile, "general", "path", config->channel_path);
+    }
     if (config->log_filepath) {
         g_key_file_set_string(keyfile, "general", "logfile",
                               config->log_filepath);
@@ -1294,7 +1330,9 @@ static int run_agent(GAState *s, GAConfig *config)
 #endif
 
     s->main_loop = g_main_loop_new(NULL, false);
-    if (!channel_init(ga_state, config->method, config->channel_path)) {
+
+    if (!channel_init(ga_state, config->method, config->channel_path,
+                      get_listen_fd(true))) {
         g_critical("failed to initialize guest agent channel");
         return EXIT_FAILURE;
     }
@@ -1318,6 +1356,7 @@ int main(int argc, char **argv)
     int ret = EXIT_SUCCESS;
     GAState *s = g_new0(GAState, 1);
     GAConfig *config = g_new0(GAConfig, 1);
+    int listen_fd;
 
     config->log_level = G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
 
@@ -1339,7 +1378,32 @@ int main(int argc, char **argv)
         config->method = g_strdup("virtio-serial");
     }
 
-    if (config->channel_path == NULL) {
+    listen_fd = get_listen_fd(false);
+    if (listen_fd >= 0) {
+        SocketAddress *addr;
+
+        g_free(config->method);
+        g_free(config->channel_path);
+        config->method = NULL;
+        config->channel_path = NULL;
+
+        addr = socket_local_address(listen_fd, NULL);
+        if (addr) {
+            if (addr->type == SOCKET_ADDRESS_KIND_UNIX) {
+                config->method = g_strdup("unix-listen");
+            } else if (addr->type == SOCKET_ADDRESS_KIND_VSOCK) {
+                config->method = g_strdup("vsock-listen");
+            }
+
+            qapi_free_SocketAddress(addr);
+        }
+
+        if (!config->method) {
+            g_critical("unsupported listen fd type");
+            ret = EXIT_FAILURE;
+            goto end;
+        }
+    } else if (config->channel_path == NULL) {
         if (strcmp(config->method, "virtio-serial") == 0) {
             /* try the default path for the virtio-serial port */
             config->channel_path = g_strdup(QGA_VIRTIO_PATH_DEFAULT);
-- 
2.7.4
