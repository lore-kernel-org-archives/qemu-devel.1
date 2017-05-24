Received: from eggs.gnu.org ([2001:4830:134:3::10]:57252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dDYzQ-0001zA-LY
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dDYzN-0005gz-Ct
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:18:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dDYzN-0005gY-5u
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:18:21 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 24 May 2017 17:18:12 +0100
Message-Id: <20170524161812.5886-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2] sockets: improve error reporting if UNIX
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
Cc: Eric Blake <eblake@redhat.com>, Simon <qemu.bugs@whitewinterwolf.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The 'struct sockaddr_un' only allows 108 bytes for the socket
path.

If the user supplies a path, QEMU uses snprintf() to silently
truncate it when too long. This is undesirable because the user
will then be unable to connect to the path they asked for.

If the user doesn't supply a path, QEMU builds one based on
TMPDIR, but if that leads to an overlong path, it mistakenly
uses error_setg_errno() with a stale errno value, because
snprintf() does not set errno on truncation.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 util/qemu-sockets.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index d8183f7..d565499 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -845,6 +845,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
 {
     struct sockaddr_un un;
     int sock, fd;
+    size_t pathlen;
 
     sock = qemu_socket(PF_UNIX, SOCK_STREAM, 0);
     if (sock < 0) {
@@ -854,15 +855,25 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
 
     memset(&un, 0, sizeof(un));
     un.sun_family = AF_UNIX;
-    if (saddr->path && strlen(saddr->path)) {
-        snprintf(un.sun_path, sizeof(un.sun_path), "%s", saddr->path);
+    pathlen = saddr->path ? strlen(saddr->path) : 0;
+    if (pathlen != 0) {
+        if (pathlen > sizeof(un.sun_path)) {
+            error_setg(errp, "UNIX socket path '%s' is too long", saddr->path);
+            error_append_hint(errp, "Path must be less than %zu bytes\n",
+                              sizeof(un.sun_path));
+            goto err;
+        }
+        strncpy(un.sun_path, saddr->path, sizeof(un.sun_path));
     } else {
+        const char *template = "qemu-socket-XXXXXX";
         const char *tmpdir = getenv("TMPDIR");
         tmpdir = tmpdir ? tmpdir : "/tmp";
-        if (snprintf(un.sun_path, sizeof(un.sun_path), "%s/qemu-socket-XXXXXX",
-                     tmpdir) >= sizeof(un.sun_path)) {
-            error_setg_errno(errp, errno,
-                             "TMPDIR environment variable (%s) too large", tmpdir);
+        if (snprintf(un.sun_path, sizeof(un.sun_path), "%s/%s",
+                     tmpdir, template) >= sizeof(un.sun_path)) {
+            error_setg(errp,
+                       "TMPDIR environment variable (%s) too large", tmpdir);
+            error_append_hint(errp, "Path must be less than %zu bytes\n",
+                              sizeof(un.sun_path) - strlen(template) - 1);
             goto err;
         }
 
-- 
2.9.3
