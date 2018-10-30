Received: from eggs.gnu.org ([2001:4830:134:3::10]:54079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gHXx7-000884-Ul
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gHXx1-0000M0-G3
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:37:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gHXx1-0000Ft-4j
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:37:11 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Oct 2018 21:36:22 +0400
Message-Id: <20181030173627.7711-3-marcandre.lureau@redhat.com>
In-Reply-To: <20181030173627.7711-1-marcandre.lureau@redhat.com>
References: <20181030173627.7711-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/7] char-socket: correctly set has_reconnect
 when parsing QemuOpts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

qemu_chr_parse_socket() fills all ChardevSocket fields, but that
doesn't reflect correctly the arguments given with the options / on
the command line. "reconnect" takes a number as argument, and the
default value is 0, which doesn't help to identify the missing
option. The other arguments have default values that are less
problematic, leave them set by default for now.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index a75b46d9fe..64e24cb2ab 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1117,7 +1117,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
     sock->tn3270 =3D is_tn3270;
     sock->has_wait =3D true;
     sock->wait =3D is_waitconnect;
-    sock->has_reconnect =3D true;
+    sock->has_reconnect =3D qemu_opt_find(opts, "reconnect");
     sock->reconnect =3D reconnect;
     sock->tls_creds =3D g_strdup(tls_creds);
=20
--=20
2.19.1.708.g4ede3d42df
