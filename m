Received: from eggs.gnu.org ([2001:4830:134:3::10]:43915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coYOP-0000XH-Jd
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coYOM-0005tH-9b
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:36:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1coYOM-0005t4-0c
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:36:46 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09996C04BD45
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 16:36:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Mar 2017 17:36:40 +0100
Message-Id: <20170316163640.5597-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2] qemu-ga: obey LISTEN_PID when using systemd
 socket activation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

qemu-ga's socket activation support was not obeying the LISTEN_PID
environment variable, which avoids that a process uses a socket-activation
file descriptor meant for its parent.

Mess can for example ensue if a process forks a children before consuming
the socket-activation file descriptor and therefore setting O_CLOEXEC
on it.

Luckily, qemu-nbd also got socket activation code, and its copy does
support LISTEN_PID.  Some extra fixups are needed to ensure that the
code can be used for both, but that's what this patch does.  The
main change is to replace get_listen_fds's "consume" argument with
the FIRST_SOCKET_ACTIVATION_FD macro from the qemu-nbd code.

Cc: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/systemd.h |  26 +++++++++++++
 qemu-nbd.c             | 100 ++++---------------------------------------------
 qga/main.c             |  51 +++++++------------------
 util/Makefile.objs     |   1 +
 util/systemd.c         |  77 +++++++++++++++++++++++++++++++++++++
 5 files changed, 125 insertions(+), 130 deletions(-)
 create mode 100644 include/qemu/systemd.h
 create mode 100644 util/systemd.c

diff --git a/include/qemu/systemd.h b/include/qemu/systemd.h
new file mode 100644
index 0000000..e6a877e
--- /dev/null
+++ b/include/qemu/systemd.h
@@ -0,0 +1,26 @@
+/*
+ * systemd socket activation support
+ *
+ * Copyright 2017 Red Hat, Inc. and/or its affiliates
+ *
+ * Authors:
+ *  Richard W.M. Jones <rjones@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_SYSTEMD_H
+#define QEMU_SYSTEMD_H 1
+
+#define FIRST_SOCKET_ACTIVATION_FD 3 /* defined by systemd ABI */
+
+/*
+ * Check if socket activation was requested via use of the
+ * LISTEN_FDS and LISTEN_PID environment variables.
+ *
+ * Returns 0 if no socket activation, or the number of FDs.
+ */
+unsigned int check_socket_activation(void);
+
+#endif
diff --git a/qemu-nbd.c b/qemu-nbd.c
index e4fede6..e080fb7 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -28,6 +28,7 @@
 #include "qemu/config-file.h"
 #include "qemu/bswap.h"
 #include "qemu/log.h"
+#include "qemu/systemd.h"
 #include "block/snapshot.h"
 #include "qapi/util.h"
 #include "qapi/qmp/qstring.h"
@@ -474,98 +475,6 @@ static void setup_address_and_port(const char **address, const char **port)
     }
 }
 
-#define FIRST_SOCKET_ACTIVATION_FD 3 /* defined by systemd ABI */
-
-#ifndef _WIN32
-/*
- * Check if socket activation was requested via use of the
- * LISTEN_FDS and LISTEN_PID environment variables.
- *
- * Returns 0 if no socket activation, or the number of FDs.
- */
-static unsigned int check_socket_activation(void)
-{
-    const char *s;
-    unsigned long pid;
-    unsigned long nr_fds;
-    unsigned int i;
-    int fd;
-    int err;
-
-    s = getenv("LISTEN_PID");
-    if (s == NULL) {
-        return 0;
-    }
-    err = qemu_strtoul(s, NULL, 10, &pid);
-    if (err) {
-        if (verbose) {
-            fprintf(stderr, "malformed %s environment variable (ignored)\n",
-                    "LISTEN_PID");
-        }
-        return 0;
-    }
-    if (pid != getpid()) {
-        if (verbose) {
-            fprintf(stderr, "%s was not for us (ignored)\n",
-                    "LISTEN_PID");
-        }
-        return 0;
-    }
-
-    s = getenv("LISTEN_FDS");
-    if (s == NULL) {
-        return 0;
-    }
-    err = qemu_strtoul(s, NULL, 10, &nr_fds);
-    if (err) {
-        if (verbose) {
-            fprintf(stderr, "malformed %s environment variable (ignored)\n",
-                    "LISTEN_FDS");
-        }
-        return 0;
-    }
-    assert(nr_fds <= UINT_MAX);
-
-    /* A limitation of current qemu-nbd is that it can only listen on
-     * a single socket.  When that limitation is lifted, we can change
-     * this function to allow LISTEN_FDS > 1, and remove the assertion
-     * in the main function below.
-     */
-    if (nr_fds > 1) {
-        error_report("qemu-nbd does not support socket activation with %s > 1",
-                     "LISTEN_FDS");
-        exit(EXIT_FAILURE);
-    }
-
-    /* So these are not passed to any child processes we might start. */
-    unsetenv("LISTEN_FDS");
-    unsetenv("LISTEN_PID");
-
-    /* So the file descriptors don't leak into child processes. */
-    for (i = 0; i < nr_fds; ++i) {
-        fd = FIRST_SOCKET_ACTIVATION_FD + i;
-        if (fcntl(fd, F_SETFD, FD_CLOEXEC) == -1) {
-            /* If we cannot set FD_CLOEXEC then it probably means the file
-             * descriptor is invalid, so socket activation has gone wrong
-             * and we should exit.
-             */
-            error_report("Socket activation failed: "
-                         "invalid file descriptor fd = %d: %m",
-                         fd);
-            exit(EXIT_FAILURE);
-        }
-    }
-
-    return (unsigned int) nr_fds;
-}
-
-#else /* !_WIN32 */
-static unsigned int check_socket_activation(void)
-{
-    return 0;
-}
-#endif
-
 /*
  * Check socket parameters compatibility when socket activation is used.
  */
@@ -892,6 +801,13 @@ int main(int argc, char **argv)
             error_report("%s", err_msg);
             exit(EXIT_FAILURE);
         }
+
+        /* qemu-nbd can only listen on a single socket.  */
+        if (socket_activation > 1) {
+            error_report("qemu-nbd does not support socket activation with %s > 1",
+                         "LISTEN_FDS");
+            exit(EXIT_FAILURE);
+        }
     }
 
     if (tlscredsid) {
diff --git a/qga/main.c b/qga/main.c
index 92658bc..284dfbe 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -29,6 +29,7 @@
 #include "qemu/bswap.h"
 #include "qemu/help_option.h"
 #include "qemu/sockets.h"
+#include "qemu/systemd.h"
 #ifdef _WIN32
 #include "qga/service-win32.h"
 #include "qga/vss-win32.h"
@@ -186,37 +187,6 @@ void reopen_fd_to_null(int fd)
 }
 #endif
 
-/**
- * get_listen_fd:
- * @consume: true to prevent future calls from succeeding
- *
- * Fetch a listen file descriptor that was passed via systemd socket
- * activation.  Use @consume to prevent child processes from thinking a file
- * descriptor was passed.
- *
- * Returns: file descriptor or -1 if no fd was passed
- */
-static int get_listen_fd(bool consume)
-{
-#ifdef _WIN32
-    return -1; /* no fd passing expected, unsetenv(3) not available */
-#else
-    const char *listen_fds = getenv("LISTEN_FDS");
-    int fd = STDERR_FILENO + 1;
-
-    if (!listen_fds || strcmp(listen_fds, "1") != 0) {
-        return -1;
-    }
-
-    if (consume) {
-        unsetenv("LISTEN_FDS");
-    }
-
-    qemu_set_cloexec(fd);
-    return fd;
-#endif /* !_WIN32 */
-}
-
 static void usage(const char *cmd)
 {
     printf(
@@ -1251,7 +1221,7 @@ static bool check_is_frozen(GAState *s)
     return false;
 }
 
-static int run_agent(GAState *s, GAConfig *config)
+static int run_agent(GAState *s, GAConfig *config, int socket_activation)
 {
     ga_state = s;
 
@@ -1333,7 +1303,7 @@ static int run_agent(GAState *s, GAConfig *config)
     s->main_loop = g_main_loop_new(NULL, false);
 
     if (!channel_init(ga_state, config->method, config->channel_path,
-                      get_listen_fd(true))) {
+                      socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {
         g_critical("failed to initialize guest agent channel");
         return EXIT_FAILURE;
     }
@@ -1357,7 +1327,7 @@ int main(int argc, char **argv)
     int ret = EXIT_SUCCESS;
     GAState *s = g_new0(GAState, 1);
     GAConfig *config = g_new0(GAConfig, 1);
-    int listen_fd;
+    int socket_activation;
 
     config->log_level = G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
 
@@ -1379,8 +1349,13 @@ int main(int argc, char **argv)
         config->method = g_strdup("virtio-serial");
     }
 
-    listen_fd = get_listen_fd(false);
-    if (listen_fd >= 0) {
+    socket_activation = check_socket_activation();
+    if (socket_activation > 1) {
+        g_critical("qemu-ga only supports listening on one socket");
+        ret = EXIT_FAILURE;
+        goto end;
+    }
+    if (socket_activation) {
         SocketAddress *addr;
 
         g_free(config->method);
@@ -1388,7 +1363,7 @@ int main(int argc, char **argv)
         config->method = NULL;
         config->channel_path = NULL;
 
-        addr = socket_local_address(listen_fd, NULL);
+        addr = socket_local_address(FIRST_SOCKET_ACTIVATION_FD , NULL);
         if (addr) {
             if (addr->type == SOCKET_ADDRESS_KIND_UNIX) {
                 config->method = g_strdup("unix-listen");
@@ -1433,7 +1408,7 @@ int main(int argc, char **argv)
         goto end;
     }
 
-    ret = run_agent(s, config);
+    ret = run_agent(s, config, socket_activation);
 
 end:
     if (s->command_state) {
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 06366b5..c6205eb 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -42,3 +42,4 @@ util-obj-y += log.o
 util-obj-y += qdist.o
 util-obj-y += qht.o
 util-obj-y += range.o
+util-obj-y += systemd.o
diff --git a/util/systemd.c b/util/systemd.c
new file mode 100644
index 0000000..d22e86c
--- /dev/null
+++ b/util/systemd.c
@@ -0,0 +1,77 @@
+/*
+ * systemd socket activation support
+ *
+ * Copyright 2017 Red Hat, Inc. and/or its affiliates
+ *
+ * Authors:
+ *  Richard W.M. Jones <rjones@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/systemd.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+
+#ifndef _WIN32
+unsigned int check_socket_activation(void)
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
+        return 0;
+    }
+    if (pid != getpid()) {
+        return 0;
+    }
+
+    s = getenv("LISTEN_FDS");
+    if (s == NULL) {
+        return 0;
+    }
+    err = qemu_strtoul(s, NULL, 10, &nr_fds);
+    if (err) {
+        return 0;
+    }
+    assert(nr_fds <= UINT_MAX);
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
+unsigned int check_socket_activation(void)
+{
+    return 0;
+}
+#endif
-- 
2.9.3
