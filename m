Received: from eggs.gnu.org ([2001:4830:134:3::10]:55614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eiifi-0006pE-Kq
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:27:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eiifh-0003hn-MF
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:27:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eiifh-0003fA-Gw
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:27:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A562CC0568E3
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 15:27:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon,  5 Feb 2018 15:24:54 +0000
Message-Id: <20180205152455.12088-9-berrange@redhat.com>
In-Reply-To: <20180205152455.12088-1-berrange@redhat.com>
References: <20180205152455.12088-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 8/9] char: refactor parsing of socket
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

From: "Daniel P. Berrange" <berrange@redhat.com>

To prepare for handling more address types, refactor the parsing of
socket address information to make it more robust and extensible.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 chardev/char-socket.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 5c46a89200..7d0e608e60 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -982,21 +982,25 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
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
@@ -1022,7 +1026,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
         addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_UNIX;
         q_unix =3D addr->u.q_unix.data =3D g_new0(UnixSocketAddress, 1);
         q_unix->path =3D g_strdup(path);
-    } else {
+    } else if (host) {
         addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_INET;
         addr->u.inet.data =3D g_new(InetSocketAddress, 1);
         *addr->u.inet.data =3D (InetSocketAddress) {
@@ -1035,6 +1039,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
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
