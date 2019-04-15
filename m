Received: from eggs.gnu.org ([209.51.188.92]:56202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hG4MW-0006Y7-JC
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hG4MV-0006CI-Jj
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:21:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hG4MT-000675-07
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:21:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 451FC309E979
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 16:21:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 15 Apr 2019 18:21:29 +0200
Message-Id: <20190415162129.30511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] socket: allow wait=false for client socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "reviewer:Incompatible changes" <libvir-list@redhat.com>

Commit 767abe7 ("chardev: forbid 'wait' option with client sockets")
is a bit too strict. Current libvirt always set wait=3Dfalse, and will
thus fail to add client chardev.

Make the code more permissive, allowing wait=3Dfalse with client socket
chardevs. Deprecate usage of 'wait' with client sockets.

Fixes: 767abe7f49e8be14d29da5db3527817b5d696a52
Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 10 +++++++---
 qemu-deprecated.texi  |  5 +++++
 2 files changed, 12 insertions(+), 3 deletions(-)

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
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 2219386769..842e71b11d 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -105,6 +105,11 @@ details.
 The ``query-events'' command has been superseded by the more powerful
 and accurate ``query-qmp-schema'' command.
=20
+@subsection chardev client socket with 'wait' option (since 4.0)
+
+Character devices creating sockets in client mode should not specify
+the 'wait' field, which is only applicable to sockets in server mode
+
 @section Human Monitor Protocol (HMP) commands
=20
 @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (si=
nce 3.1)
--=20
2.21.0.313.ge35b8cb8e2
