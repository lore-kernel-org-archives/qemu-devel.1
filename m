Received: from eggs.gnu.org ([2001:4830:134:3::10]:33634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dEGNv-0007nZ-Im
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dEGNt-0000g2-F9
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:38:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dEGNt-0000ce-3d
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:38:33 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EE0CC05AA54
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 14:38:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 May 2017 16:38:26 +0200
Message-Id: <20170526143826.27780-4-pbonzini@redhat.com>
In-Reply-To: <20170526143826.27780-1-pbonzini@redhat.com>
References: <20170526143826.27780-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/22] sockets: improve error reporting if UNIX
 socket path is too long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Daniel P. Berrange" <berrange@redhat.com>

The 'struct sockaddr_un' only allows 108 bytes for the socket
path.

If the user supplies a path, QEMU uses snprintf() to silently
truncate it when too long. This is undesirable because the user
will then be unable to connect to the path they asked for.

If the user doesn't supply a path, QEMU builds one based on
TMPDIR, but if that leads to an overlong path, it mistakenly
uses error_setg_errno() with a stale errno value, because
snprintf() does not set errno on truncation.

In solving this the code needed some refactoring to ensure we
don't pass 'un.sun_path' directly to any APIs which expect
NUL-terminated strings, because the path is not required to
be terminated.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20170525155300.22743-1-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-sockets.c | 68 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 22 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index d8183f79d7..dfaf4e1d82 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -845,6 +845,8 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
 {
     struct sockaddr_un un;
     int sock, fd;
+    char *pathbuf = NULL;
+    const char *path;
 
     sock = qemu_socket(PF_UNIX, SOCK_STREAM, 0);
     if (sock < 0) {
@@ -852,20 +854,22 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
         return -1;
     }
 
-    memset(&un, 0, sizeof(un));
-    un.sun_family = AF_UNIX;
-    if (saddr->path && strlen(saddr->path)) {
-        snprintf(un.sun_path, sizeof(un.sun_path), "%s", saddr->path);
+    if (saddr->path && saddr->path[0]) {
+        path = saddr->path;
     } else {
         const char *tmpdir = getenv("TMPDIR");
         tmpdir = tmpdir ? tmpdir : "/tmp";
-        if (snprintf(un.sun_path, sizeof(un.sun_path), "%s/qemu-socket-XXXXXX",
-                     tmpdir) >= sizeof(un.sun_path)) {
-            error_setg_errno(errp, errno,
-                             "TMPDIR environment variable (%s) too large", tmpdir);
-            goto err;
-        }
+        path = pathbuf = g_strdup_printf("%s/qemu-socket-XXXXXX", tmpdir);
+    }
 
+    if (strlen(path) > sizeof(un.sun_path)) {
+        error_setg(errp, "UNIX socket path '%s' is too long", path);
+        error_append_hint(errp, "Path must be less than %zu bytes\n",
+                          sizeof(un.sun_path));
+        goto err;
+    }
+
+    if (pathbuf != NULL) {
         /*
          * This dummy fd usage silences the mktemp() unsecure warning.
          * Using mkstemp() doesn't make things more secure here
@@ -873,24 +877,25 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
          * to unlink first and thus re-open the race window.  The
          * worst case possible is bind() failing, i.e. a DoS attack.
          */
-        fd = mkstemp(un.sun_path);
+        fd = mkstemp(pathbuf);
         if (fd < 0) {
             error_setg_errno(errp, errno,
-                             "Failed to make a temporary socket name in %s", tmpdir);
+                             "Failed to make a temporary socket %s", pathbuf);
             goto err;
         }
         close(fd);
-        if (update_addr) {
-            g_free(saddr->path);
-            saddr->path = g_strdup(un.sun_path);
-        }
     }
 
-    if (unlink(un.sun_path) < 0 && errno != ENOENT) {
+    if (unlink(path) < 0 && errno != ENOENT) {
         error_setg_errno(errp, errno,
-                         "Failed to unlink socket %s", un.sun_path);
+                         "Failed to unlink socket %s", path);
         goto err;
     }
+
+    memset(&un, 0, sizeof(un));
+    un.sun_family = AF_UNIX;
+    strncpy(un.sun_path, path, sizeof(un.sun_path));
+
     if (bind(sock, (struct sockaddr*) &un, sizeof(un)) < 0) {
         error_setg_errno(errp, errno, "Failed to bind socket to %s", un.sun_path);
         goto err;
@@ -900,9 +905,16 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
         goto err;
     }
 
+    if (update_addr && pathbuf) {
+        g_free(saddr->path);
+        saddr->path = pathbuf;
+    } else {
+        g_free(pathbuf);
+    }
     return sock;
 
 err:
+    g_free(pathbuf);
     closesocket(sock);
     return -1;
 }
@@ -932,9 +944,16 @@ static int unix_connect_saddr(UnixSocketAddress *saddr,
         qemu_set_nonblock(sock);
     }
 
+    if (strlen(saddr->path) > sizeof(un.sun_path)) {
+        error_setg(errp, "UNIX socket path '%s' is too long", saddr->path);
+        error_append_hint(errp, "Path must be less than %zu bytes\n",
+                          sizeof(un.sun_path));
+        goto err;
+    }
+
     memset(&un, 0, sizeof(un));
     un.sun_family = AF_UNIX;
-    snprintf(un.sun_path, sizeof(un.sun_path), "%s", saddr->path);
+    strncpy(un.sun_path, saddr->path, sizeof(un.sun_path));
 
     /* connect to peer */
     do {
@@ -956,13 +975,18 @@ static int unix_connect_saddr(UnixSocketAddress *saddr,
     }
 
     if (rc < 0) {
-        error_setg_errno(errp, -rc, "Failed to connect socket");
-        close(sock);
-        sock = -1;
+        error_setg_errno(errp, -rc, "Failed to connect socket %s",
+                         saddr->path);
+        goto err;
     }
 
     g_free(connect_state);
     return sock;
+
+ err:
+    close(sock);
+    g_free(connect_state);
+    return -1;
 }
 
 #else
-- 
2.13.0
