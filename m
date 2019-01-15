Received: from eggs.gnu.org ([209.51.188.92]:46488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjQ64-0004ud-08
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjQ62-0004Vk-6H
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:53:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjQ61-0004RL-SV
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:53:42 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 15 Jan 2019 14:52:48 +0000
Message-Id: <20190115145256.9593-5-berrange@redhat.com>
In-Reply-To: <20190115145256.9593-1-berrange@redhat.com>
References: <20190115145256.9593-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/12] chardev: remove many local variables in
 qemu_chr_parse_socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Now that all validation is separated off into a separate method,
we can directly populate the ChardevSocket struct from the
QemuOpts values, avoiding many local variables.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 233f16f72d..ba86284ea9 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1186,18 +1186,10 @@ error:
 static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backen=
d,
                                   Error **errp)
 {
-    bool is_listen      =3D qemu_opt_get_bool(opts, "server", false);
-    bool is_waitconnect =3D is_listen && qemu_opt_get_bool(opts, "wait",=
 true);
-    bool is_telnet      =3D qemu_opt_get_bool(opts, "telnet", false);
-    bool is_tn3270      =3D qemu_opt_get_bool(opts, "tn3270", false);
-    bool is_websock     =3D qemu_opt_get_bool(opts, "websocket", false);
-    bool do_nodelay     =3D !qemu_opt_get_bool(opts, "delay", true);
-    int64_t reconnect   =3D qemu_opt_get_number(opts, "reconnect", 0);
     const char *path =3D qemu_opt_get(opts, "path");
     const char *host =3D qemu_opt_get(opts, "host");
     const char *port =3D qemu_opt_get(opts, "port");
     const char *fd =3D qemu_opt_get(opts, "fd");
-    const char *tls_creds =3D qemu_opt_get(opts, "tls-creds");
     SocketAddressLegacy *addr;
     ChardevSocket *sock;
=20
@@ -1216,26 +1208,30 @@ static void qemu_chr_parse_socket(QemuOpts *opts,=
 ChardevBackend *backend,
     sock =3D backend->u.socket.data =3D g_new0(ChardevSocket, 1);
     qemu_chr_parse_common(opts, qapi_ChardevSocket_base(sock));
=20
-    sock->has_nodelay =3D true;
-    sock->nodelay =3D do_nodelay;
+    sock->has_nodelay =3D qemu_opt_get(opts, "delay");
+    sock->nodelay =3D !qemu_opt_get_bool(opts, "delay", true);
+    /*
+     * We have different default to QMP for 'server', hence
+     * we can't just check for existance of 'server'
+     */
     sock->has_server =3D true;
-    sock->server =3D is_listen;
-    sock->has_telnet =3D true;
-    sock->telnet =3D is_telnet;
-    sock->has_tn3270 =3D true;
-    sock->tn3270 =3D is_tn3270;
-    sock->has_websocket =3D true;
-    sock->websocket =3D is_websock;
+    sock->server =3D qemu_opt_get_bool(opts, "server", false);
+    sock->has_telnet =3D qemu_opt_get(opts, "telnet");
+    sock->telnet =3D qemu_opt_get_bool(opts, "telnet", false);
+    sock->has_tn3270 =3D qemu_opt_get(opts, "tn3270");
+    sock->tn3270 =3D qemu_opt_get_bool(opts, "tn3270", false);
+    sock->has_websocket =3D qemu_opt_get(opts, "websocket");
+    sock->websocket =3D qemu_opt_get_bool(opts, "websocket", false);
     /*
      * We have different default to QMP for 'wait' when 'server'
      * is set, hence we can't just check for existance of 'wait'
      */
-    sock->has_wait =3D qemu_opt_find(opts, "wait") || is_listen;
-    sock->wait =3D is_waitconnect;
+    sock->has_wait =3D qemu_opt_find(opts, "wait") || sock->server;
+    sock->wait =3D qemu_opt_get_bool(opts, "wait", true);
     sock->has_reconnect =3D qemu_opt_find(opts, "reconnect");
-    sock->reconnect =3D reconnect;
-    sock->has_tls_creds =3D tls_creds;
-    sock->tls_creds =3D g_strdup(tls_creds);
+    sock->reconnect =3D qemu_opt_get_number(opts, "reconnect", 0);
+    sock->has_tls_creds =3D qemu_opt_get(opts, "tls-creds");
+    sock->tls_creds =3D g_strdup(qemu_opt_get(opts, "tls-creds"));
=20
     addr =3D g_new0(SocketAddressLegacy, 1);
     if (path) {
--=20
2.20.1
