Received: from eggs.gnu.org ([2001:4830:134:3::10]:47390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cZKzs-0008Mx-0J
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 12:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cZKzq-0002Gb-Nu
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 12:16:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1cZKzq-0002G0-Ef
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 12:16:34 -0500
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Thu,  2 Feb 2017 17:16:25 +0000
Message-Id: <20170202171625.28502-2-rjones@redhat.com>
In-Reply-To: <20170202171625.28502-1-rjones@redhat.com>
References: <20170202171625.28502-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2] qemu-nbd: Implement socket activation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, den@openvz.org, rkagan@virtuozzo.com, dplotnikov@virtuozzo.com, berrange@redhat.com, stefanha@gmail.com

Socket activation (sometimes known as systemd socket activation)
allows an Internet superserver to pass a pre-opened listening socket
to the process, instead of having qemu-nbd open a socket itself.  This
is done via the LISTEN_FDS and LISTEN_PID environment variables, and a
standard file descriptor range.

This change partially implements socket activation for qemu-nbd.  If
the environment variables are set correctly, then socket activation
will happen automatically, otherwise everything works as before.  The
limitation is that LISTEN_FDS must be 1.

Signed-off-by: Richard W.M. Jones.
---
 qemu-nbd.c | 172 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 163 insertions(+), 9 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index c734f62..b3088d0 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -463,6 +463,135 @@ static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, Error **errp)
     return creds;
 }
 
+static void setup_address_and_port(const char **address, const char **port)
+{
+    if (*address == NULL) {
+        *address = "0.0.0.0";
+    }
+
+    if (*port == NULL) {
+        *port = g_strdup_printf("%d", NBD_DEFAULT_PORT);;
+    }
+}
+
+#define FIRST_SOCKET_ACTIVATION_FD 3 /* defined by systemd ABI */
+
+#ifndef _WIN32
+/*
+ * Check if socket activation was requested via use of the
+ * LISTEN_FDS and LISTEN_PID environment variables.
+ *
+ * Returns 0 if no socket activation, or the number of FDs.
+ */
+static unsigned int check_socket_activation(void)
+{
+    const char *s;
+    unsigned long pid;
+    unsigned long nr_fds;
+    unsigned int i;
+    int fd;
+    int err;
+
+    s = getenv("LISTEN_PID");
+    if (s == NULL) {
+        return 0;
+    }
+    err = qemu_strtoul(s, NULL, 10, &pid);
+    if (err) {
+        if (verbose) {
+            fprintf(stderr, "malformed %s environment variable (ignored)\n",
+                    "LISTEN_PID");
+        }
+        return 0;
+    }
+    if (pid != getpid()) {
+        if (verbose) {
+            fprintf(stderr, "%s was not for us (ignored)\n",
+                    "LISTEN_PID");
+        }
+        return 0;
+    }
+
+    s = getenv("LISTEN_FDS");
+    if (s == NULL) {
+        return 0;
+    }
+    err = qemu_strtoul(s, NULL, 10, &nr_fds);
+    if (err) {
+        if (verbose) {
+            fprintf(stderr, "malformed %s environment variable (ignored)\n",
+                    "LISTEN_FDS");
+        }
+        return 0;
+    }
+    assert(nr_fds <= UINT_MAX);
+
+    /* A limitation of current qemu-nbd is that it can only listen on
+     * a single socket.  When that limitation is lifted, we can change
+     * this function to allow LISTEN_FDS > 1, and remove the assertion
+     * in the main function below.
+     */
+    if (nr_fds > 1) {
+        error_report("qemu-nbd does not support socket activation with %s > 1",
+                     "LISTEN_FDS");
+        exit(EXIT_FAILURE);
+    }
+
+    /* So these are not passed to any child processes we might start. */
+    unsetenv("LISTEN_FDS");
+    unsetenv("LISTEN_PID");
+
+    /* So the file descriptors don't leak into child processes. */
+    for (i = 0; i < nr_fds; ++i) {
+        fd = FIRST_SOCKET_ACTIVATION_FD + i;
+        if (fcntl(fd, F_SETFD, FD_CLOEXEC) == -1) {
+            /* If we cannot set FD_CLOEXEC then it probably means the file
+             * descriptor is invalid, so socket activation has gone wrong
+             * and we should exit.
+             */
+            error_report("Socket activation failed: "
+                         "invalid file descriptor fd = %d: %m",
+                         fd);
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    return (unsigned int) nr_fds;
+}
+
+#else /* !_WIN32 */
+static unsigned int check_socket_activation(void)
+{
+    return 0;
+}
+#endif
+
+/*
+ * Check socket parameters compatibility when socket activation is used.
+ */
+static const char *socket_activation_validate_opts(const char *device,
+                                                   const char *sockpath,
+                                                   const char *address,
+                                                   const char *port)
+{
+    if (device != NULL) {
+        return "NBD device can't be set when using socket activation";
+    }
+
+    if (sockpath != NULL) {
+        return "Unix socket can't be set when using socket activation";
+    }
+
+    if (address != NULL) {
+        return "The interface can't be set when using socket activation";
+    }
+
+    if (port != NULL) {
+        return "TCP port number can't be set when using socket activation";
+    }
+
+    return NULL;
+}
 
 int main(int argc, char **argv)
 {
@@ -471,7 +600,7 @@ int main(int argc, char **argv)
     off_t dev_offset = 0;
     uint16_t nbdflags = 0;
     bool disconnect = false;
-    const char *bindto = "0.0.0.0";
+    const char *bindto = NULL;
     const char *port = NULL;
     char *sockpath = NULL;
     char *device = NULL;
@@ -533,6 +662,7 @@ int main(int argc, char **argv)
     char *trace_file = NULL;
     bool fork_process = false;
     int old_stderr = -1;
+    unsigned socket_activation;
 
     /* The client thread uses SIGTERM to interrupt the server.  A signal
      * handler ensures that "qemu-nbd -v -c" exits with a nice status code.
@@ -751,6 +881,19 @@ int main(int argc, char **argv)
     trace_init_file(trace_file);
     qemu_set_log(LOG_TRACE);
 
+    socket_activation = check_socket_activation();
+    if (socket_activation == 0) {
+        setup_address_and_port(&bindto, &port);
+    } else {
+        /* Using socket activation - check user didn't use -p etc. */
+        const char *err_msg = socket_activation_validate_opts(device, sockpath,
+                                                              bindto, port);
+        if (err_msg != NULL) {
+            error_report("%s", err_msg);
+            exit(EXIT_FAILURE);
+        }
+    }
+
     if (tlscredsid) {
         if (sockpath) {
             error_report("TLS is only supported with IPv4/IPv6");
@@ -855,7 +998,25 @@ int main(int argc, char **argv)
         snprintf(sockpath, 128, SOCKET_PATH, basename(device));
     }
 
-    saddr = nbd_build_socket_address(sockpath, bindto, port);
+    if (socket_activation == 0) {
+        server_ioc = qio_channel_socket_new();
+        saddr = nbd_build_socket_address(sockpath, bindto, port);
+        if (qio_channel_socket_listen_sync(server_ioc, saddr, &local_err) < 0) {
+            object_unref(OBJECT(server_ioc));
+            error_report_err(local_err);
+            return 1;
+        }
+    } else {
+        /* See comment in check_socket_activation above. */
+        assert(socket_activation == 1);
+        server_ioc = qio_channel_socket_new_fd(FIRST_SOCKET_ACTIVATION_FD,
+                                               &local_err);
+        if (server_ioc == NULL) {
+            error_report("Failed to use socket activation: %s",
+                         error_get_pretty(local_err));
+            exit(EXIT_FAILURE);
+        }
+    }
 
     if (qemu_init_main_loop(&local_err)) {
         error_report_err(local_err);
@@ -950,13 +1111,6 @@ int main(int argc, char **argv)
         exit(EXIT_FAILURE);
     }
 
-    server_ioc = qio_channel_socket_new();
-    if (qio_channel_socket_listen_sync(server_ioc, saddr, &local_err) < 0) {
-        object_unref(OBJECT(server_ioc));
-        error_report_err(local_err);
-        return 1;
-    }
-
     if (device) {
         int ret;
 
-- 
2.10.2
