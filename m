Received: from eggs.gnu.org ([209.51.188.92]:51897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hG47b-0007Xc-Rq
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hG47a-0003Ob-Vb
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:06:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hG47a-0003Md-Nt
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:06:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 274ACC0578F2
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 16:06:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 15 Apr 2019 18:06:09 +0200
Message-Id: <20190415160609.24240-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] socket: allow wait=false for client socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Commit 767abe7 ("chardev: forbid 'wait' option with client sockets")
is a bit too strict. Current libvirt always set wait=3Dfalse, and will
thus fail to add client chardev.

Make the code more permissive, allowing wait=3Dfalse with client socket
chardevs.

Fixes: 767abe7f49e8be14d29da5db3527817b5d696a52
Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 3916505d67..ebc1adb83e 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1263,9 +1263,13 @@ static bool qmp_chardev_validate_socket(ChardevSoc=
ket *sock,
             return false;
         }
         if (sock->has_wait) {
-            error_setg(errp, "%s",
-                       "'wait' option is incompatible with "
-                       "socket in client connect mode");
+            warn_report("'wait' option is deprecated with "
+                        "socket in client connect mode");
+            if (sock->wait) {
+                error_setg(errp, "%s",
+                           "'wait' option is incompatible with "
+                           "socket in client connect mode");
+            }
             return false;
         }
     }
--=20
2.21.0.313.ge35b8cb8e2
