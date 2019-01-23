Received: from eggs.gnu.org ([209.51.188.92]:41950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMKV-0002xF-HG
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMKT-0002qL-NY
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmMKT-0002j7-DU
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:45 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 23 Jan 2019 17:27:32 +0000
Message-Id: <20190123172740.32452-9-berrange@redhat.com>
In-Reply-To: <20190123172740.32452-1-berrange@redhat.com>
References: <20190123172740.32452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/16] chardev: remove unused 'sioc'
 variable & cleanup paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Yongji Xie <elohimes@gmail.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The 'sioc' variable in qmp_chardev_open_socket was unused since

  commit 3e7d4d20d3a528b1ed10b1dc3d83119bfb0c5f24
  Author: Peter Xu <peterx@redhat.com>
  Date:   Tue Mar 6 13:33:17 2018 +0800

    chardev: use chardev's gcontext for async connect

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 8a6e203da7..8a5e5c2fe7 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1073,7 +1073,6 @@ static void qmp_chardev_open_socket(Chardev *chr,
     bool is_waitconnect =3D sock->has_wait    ? sock->wait    : false;
     bool is_websock     =3D sock->has_websocket ? sock->websocket : fals=
e;
     int64_t reconnect   =3D sock->has_reconnect ? sock->reconnect : 0;
-    QIOChannelSocket *sioc =3D NULL;
     SocketAddress *addr;
=20
     s->is_listen =3D is_listen;
@@ -1088,7 +1087,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
         if (!creds) {
             error_setg(errp, "No TLS credentials with id '%s'",
                        sock->tls_creds);
-            goto error;
+            return;
         }
         s->tls_creds =3D (QCryptoTLSCreds *)
             object_dynamic_cast(creds,
@@ -1096,20 +1095,20 @@ static void qmp_chardev_open_socket(Chardev *chr,
         if (!s->tls_creds) {
             error_setg(errp, "Object with id '%s' is not TLS credentials=
",
                        sock->tls_creds);
-            goto error;
+            return;
         }
         object_ref(OBJECT(s->tls_creds));
         if (is_listen) {
             if (s->tls_creds->endpoint !=3D QCRYPTO_TLS_CREDS_ENDPOINT_S=
ERVER) {
                 error_setg(errp, "%s",
                            "Expected TLS credentials for server endpoint=
");
-                goto error;
+                return;
             }
         } else {
             if (s->tls_creds->endpoint !=3D QCRYPTO_TLS_CREDS_ENDPOINT_C=
LIENT) {
                 error_setg(errp, "%s",
                            "Expected TLS credentials for client endpoint=
");
-                goto error;
+                return;
             }
         }
     }
@@ -1117,7 +1116,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     s->addr =3D addr =3D socket_address_flatten(sock->addr);
=20
     if (!qmp_chardev_validate_socket(sock, addr, errp)) {
-        goto error;
+        return;
     }
=20
     qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
@@ -1153,7 +1152,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
             if (qio_net_listener_open_sync(s->listener, s->addr, errp) <=
 0) {
                 object_unref(OBJECT(s->listener));
                 s->listener =3D NULL;
-                goto error;
+                return;
             }
=20
             qapi_free_SocketAddress(s->addr);
@@ -1171,16 +1170,9 @@ static void qmp_chardev_open_socket(Chardev *chr,
                                                       chr->gcontext);
             }
         } else if (qemu_chr_wait_connected(chr, errp) < 0) {
-            goto error;
+            return;
         }
     }
-
-    return;
-
-error:
-    if (sioc) {
-        object_unref(OBJECT(sioc));
-    }
 }
=20
 static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backen=
d,
--=20
2.20.1
