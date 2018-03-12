Received: from eggs.gnu.org ([2001:4830:134:3::10]:41703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evMts-00058N-Jf
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evMtr-0007u3-Mq
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:50:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38952 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evMtr-0007tI-Hj
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:49:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BFAA4000B6E
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 12:49:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 12 Mar 2018 12:49:38 +0000
Message-Id: <20180312124939.20562-9-berrange@redhat.com>
In-Reply-To: <20180312124939.20562-1-berrange@redhat.com>
References: <20180312124939.20562-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 8/9] char: refactor parsing of socket
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
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

To prepare for handling more address types, refactor the parsing of
socket address information to make it more robust and extensible.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 chardev/char-socket.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 1a371b91ac..a916ef4012 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1012,21 +1012,25 @@ static void qemu_chr_parse_socket(QemuOpts *opts,=
 ChardevBackend *backend,
     SocketAddressLegacy *addr;
     ChardevSocket *sock;
=20
+    if ((!!path + !!host) !=3D 1) {
+        error_setg(errp,
+                   "Exactly one of 'path' or 'host' required");
+        return;
+    }
+
     backend->type =3D CHARDEV_BACKEND_KIND_SOCKET;
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
=20
     sock =3D backend->u.socket.data =3D g_new0(ChardevSocket, 1);
@@ -1052,7 +1056,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
         addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_UNIX;
         q_unix =3D addr->u.q_unix.data =3D g_new0(UnixSocketAddress, 1);
         q_unix->path =3D g_strdup(path);
-    } else {
+    } else if (host) {
         addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_INET;
         addr->u.inet.data =3D g_new(InetSocketAddress, 1);
         *addr->u.inet.data =3D (InetSocketAddress) {
@@ -1065,6 +1069,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
             .has_ipv6 =3D qemu_opt_get(opts, "ipv6"),
             .ipv6 =3D qemu_opt_get_bool(opts, "ipv6", 0),
         };
+    } else {
+        g_assert_not_reached();
     }
     sock->addr =3D addr;
 }
--=20
2.14.3
