Received: from eggs.gnu.org ([2001:4830:134:3::10]:34286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cPBsi-0006JN-MG
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cPBsg-0008IO-VI
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:31:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cPBsg-0008HX-NB
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:31:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  5 Jan 2017 17:31:07 +0000
Message-Id: <20170105173107.5426-3-stefanha@redhat.com>
In-Reply-To: <20170105173107.5426-1-stefanha@redhat.com>
References: <20170105173107.5426-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qga: add systemd socket activation support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

AF_UNIX and AF_VSOCK listen sockets can be passed in by systemd on
startup.  This allows systemd to manage the listen socket until the
first client connects and between restarts.  Advantages of socket
activation are that parallel startup of network services becomes
possible and that unused daemons do not consume memory.

The key to achieving this is the sd_listen_fds(3) API provided by
libsystemd.  It returns zero if there are no passed listen fds.  When
passed fds are present they override the qga method/path options.

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
---
 qga/Makefile.objs   |  3 +++
 qga/channel.h       |  3 ++-
 qga/channel-posix.c | 66 ++++++++++++++++++++++++++++++-----------------------
 qga/channel-win32.c |  2 +-
 qga/main.c          | 45 ++++++++++++++++++++++++++++++++----
 5 files changed, 84 insertions(+), 35 deletions(-)

diff --git a/qga/Makefile.objs b/qga/Makefile.objs
index 1c5986c..96fa36f 100644
--- a/qga/Makefile.objs
+++ b/qga/Makefile.objs
@@ -6,3 +6,6 @@ qga-obj-y += qapi-generated/qga-qapi-types.o qapi-generated/qga-qapi-visit.o
 qga-obj-y += qapi-generated/qga-qmp-marshal.o
 
 qga-vss-dll-obj-$(CONFIG_QGA_VSS) += vss-win32/
+
+main.o-cflags := $(SYSTEMD_CFLAGS)
+main.o-libs   := $(SYSTEMD_LIBS)
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
+        if (fd < 0) {
+            Error *local_err = NULL;
+            SocketAddress *addr;
+            char *addr_str;
 
-        addr_str = g_strdup_printf("vsock:%s", path);
-        addr = socket_parse(addr_str, &local_err);
-        g_free(addr_str);
-        if (local_err != NULL) {
-            g_critical("%s", error_get_pretty(local_err));
-            error_free(local_err);
-            return false;
-        }
+            addr_str = g_strdup_printf("vsock:%s", path);
+            addr = socket_parse(addr_str, &local_err);
+            g_free(addr_str);
+            if (local_err != NULL) {
+                g_critical("%s", error_get_pretty(local_err));
+                error_free(local_err);
+                return false;
+            }
 
-        fd = socket_listen(addr, &local_err);
-        qapi_free_SocketAddress(addr);
-        if (local_err != NULL) {
-            g_critical("%s", error_get_pretty(local_err));
-            error_free(local_err);
-            return false;
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
diff --git a/qga/main.c b/qga/main.c
index 6caf215..4dfc787 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -17,6 +17,9 @@
 #include <syslog.h>
 #include <sys/wait.h>
 #endif
+#ifdef CONFIG_SYSTEMD
+#include <systemd/sd-daemon.h>
+#endif
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qint.h"
@@ -648,7 +651,8 @@ static gboolean channel_event_cb(GIOCondition condition, gpointer data)
     return true;
 }
 
-static gboolean channel_init(GAState *s, const gchar *method, const gchar *path)
+static gboolean channel_init(GAState *s, const gchar *method, const gchar *path,
+                             int listen_fd)
 {
     GAChannelMethod channel_method;
 
@@ -666,7 +670,8 @@ static gboolean channel_init(GAState *s, const gchar *method, const gchar *path)
         return false;
     }
 
-    s->channel = ga_channel_new(channel_method, path, channel_event_cb, s);
+    s->channel = ga_channel_new(channel_method, path, listen_fd,
+                                channel_event_cb, s);
     if (!s->channel) {
         g_critical("failed to create guest agent channel");
         return false;
@@ -1025,7 +1030,9 @@ static void config_dump(GAConfig *config)
 
     g_key_file_set_boolean(keyfile, "general", "daemon", config->daemonize);
     g_key_file_set_string(keyfile, "general", "method", config->method);
-    g_key_file_set_string(keyfile, "general", "path", config->channel_path);
+    if (config->channel_path) {
+        g_key_file_set_string(keyfile, "general", "path", config->channel_path);
+    }
     if (config->log_filepath) {
         g_key_file_set_string(keyfile, "general", "logfile",
                               config->log_filepath);
@@ -1216,6 +1223,8 @@ static bool check_is_frozen(GAState *s)
 
 static int run_agent(GAState *s, GAConfig *config)
 {
+    int listen_fd = -1;
+
     ga_state = s;
 
     g_log_set_default_handler(ga_log, s);
@@ -1294,7 +1303,15 @@ static int run_agent(GAState *s, GAConfig *config)
 #endif
 
     s->main_loop = g_main_loop_new(NULL, false);
-    if (!channel_init(ga_state, config->method, config->channel_path)) {
+
+#ifdef CONFIG_SYSTEMD
+    if (sd_listen_fds(1) > 0) {
+        listen_fd = SD_LISTEN_FDS_START;
+    }
+#endif
+
+    if (!channel_init(ga_state, config->method, config->channel_path,
+                      listen_fd)) {
         g_critical("failed to initialize guest agent channel");
         return EXIT_FAILURE;
     }
@@ -1339,6 +1356,26 @@ int main(int argc, char **argv)
         config->method = g_strdup("virtio-serial");
     }
 
+#ifdef CONFIG_SYSTEMD
+    if (sd_listen_fds(0) > 0) {
+        int fd = SD_LISTEN_FDS_START;
+
+        g_free(config->method);
+        g_free(config->channel_path);
+        config->method = NULL;
+        config->channel_path = NULL;
+
+        if (sd_is_socket(fd, AF_UNIX, SOCK_STREAM, 1)) {
+            config->method = g_strdup("unix-listen");
+        } else if (sd_is_socket(fd, AF_VSOCK, SOCK_STREAM, 1)) {
+            config->method = g_strdup("vsock-listen");
+        } else {
+            g_critical("unsupported listen fd type");
+            ret = EXIT_FAILURE;
+            goto end;
+        }
+    } else /* fall-through */
+#endif
     if (config->channel_path == NULL) {
         if (strcmp(config->method, "virtio-serial") == 0) {
             /* try the default path for the virtio-serial port */
-- 
2.9.3
