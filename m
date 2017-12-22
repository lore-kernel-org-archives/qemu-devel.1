Received: from eggs.gnu.org ([2001:4830:134:3::10]:47788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSNeM-0006Wm-8x
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSNeL-00034B-BV
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:46:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eSNeL-00033U-2e
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:46:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D14C4B9A
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 13:46:08 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 22 Dec 2017 13:45:26 +0000
Message-Id: <20171222134527.14467-8-berrange@redhat.com>
In-Reply-To: <20171222134527.14467-1-berrange@redhat.com>
References: <20171222134527.14467-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 7/8] char: refactor parsing of socket
 address information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

To prepare for handling more address types, refactor the parsing of
socket address information to make it more robust and extensible.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 chardev/char-socket.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 6013972f72..9113ea0169 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -987,21 +987,25 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     SocketAddressLegacy *addr;
     ChardevSocket *sock;
 
+    if ((!!path + !!host) != 1) {
+        error_setg(errp,
+                   "Exactly one of 'path' or 'host' required");
+        return;
+    }
+
     backend->type = CHARDEV_BACKEND_KIND_SOCKET;
-    if (!path) {
-        if (!host) {
-            error_setg(errp, "chardev: socket: no host given");
+    if (path) {
+        if (tls_creds) {
+            error_setg(errp, "TLS can only be used over TCP socket");
             return;
         }
+    } else if (host) {
         if (!port) {
             error_setg(errp, "chardev: socket: no port given");
             return;
         }
     } else {
-        if (tls_creds) {
-            error_setg(errp, "TLS can only be used over TCP socket");
-            return;
-        }
+        g_assert_not_reached();
     }
 
     sock = backend->u.socket.data = g_new0(ChardevSocket, 1);
@@ -1027,7 +1031,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
         q_unix = addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
         q_unix->path = g_strdup(path);
-    } else {
+    } else if (host) {
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
         addr->u.inet.data = g_new(InetSocketAddress, 1);
         *addr->u.inet.data = (InetSocketAddress) {
@@ -1040,6 +1044,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
             .has_ipv6 = qemu_opt_get(opts, "ipv6"),
             .ipv6 = qemu_opt_get_bool(opts, "ipv6", 0),
         };
+    } else {
+        g_assert_not_reached();
     }
     sock->addr = addr;
 }
-- 
2.14.3
