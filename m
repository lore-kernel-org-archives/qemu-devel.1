Received: from eggs.gnu.org ([2001:4830:134:3::10]:43273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dDYQP-0005Iw-RF
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dDYQM-0000aA-N3
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:42:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dDYQM-0000Yo-H2
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:42:10 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 24 May 2017 16:42:05 +0100
Message-Id: <20170524154205.1914-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] sockets: report error if UNIX socket path is
 too long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Simon <qemu.bugs@whitewinterwolf.com>, "Daniel P. Berrange" <berrange@redhat.com>

The 'struct sockaddr_un' only allows 108 bytes for the socket
path. Currently QEMU uses snprintf() and so silently truncates
the socket path provided by the user. This is undesirable because
the user will then be unable to connect to the path they asked
for. This change makes QEMU bounds check and report an explicit
error message.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 util/qemu-sockets.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index d8183f7..e249dbe 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -855,6 +855,12 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
     memset(&un, 0, sizeof(un));
     un.sun_family = AF_UNIX;
     if (saddr->path && strlen(saddr->path)) {
+        if (strlen(saddr->path) > sizeof(un.sun_path)) {
+            error_setg(errp, "UNIX socket path '%s' is too long", saddr->path);
+            error_append_hint(errp, "Path must be less than %zu bytes\n",
+                              sizeof(un.sun_path));
+            return -1;
+        }
         snprintf(un.sun_path, sizeof(un.sun_path), "%s", saddr->path);
     } else {
         const char *tmpdir = getenv("TMPDIR");
-- 
2.9.3
