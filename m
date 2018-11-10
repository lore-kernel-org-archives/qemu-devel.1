Received: from eggs.gnu.org ([2001:4830:134:3::10]:36536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLTbC-0004dq-CL
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLTb8-0008Sg-Iu
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:46:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gLTb8-00087D-8Q
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:46:50 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 10 Nov 2018 17:45:41 +0400
Message-Id: <20181110134548.14741-7-marcandre.lureau@redhat.com>
In-Reply-To: <20181110134548.14741-1-marcandre.lureau@redhat.com>
References: <20181110134548.14741-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 06/13] slirp: rename /extra/chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Now it's only used for the chardev pointer.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/socket.h   | 2 +-
 slirp/slirp.c    | 4 ++--
 slirp/tcp_subr.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/slirp/socket.h b/slirp/socket.h
index 2f224bc34f..930ed95972 100644
--- a/slirp/socket.h
+++ b/slirp/socket.h
@@ -67,7 +67,7 @@ struct socket {
=20
   struct sbuf so_rcv;		/* Receive buffer */
   struct sbuf so_snd;		/* Send buffer */
-  void * extra;			/* Extra pointer */
+  void * chardev;
 };
=20
=20
diff --git a/slirp/slirp.c b/slirp/slirp.c
index daa0d5d4bd..d6623a2bbf 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1088,10 +1088,10 @@ int slirp_add_exec(Slirp *slirp, void *chardev, c=
onst char *cmdline,
=20
 ssize_t slirp_send(struct socket *so, const void *buf, size_t len, int f=
lags)
 {
-    if (so->s =3D=3D -1 && so->extra) {
+    if (so->s =3D=3D -1 && so->chardev) {
         /* XXX this blocks entire thread. Rewrite to use
          * qemu_chr_fe_write and background I/O callbacks */
-        qemu_chr_fe_write_all(so->extra, buf, len);
+        qemu_chr_fe_write_all(so->chardev, buf, len);
         return len;
     }
=20
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index eb894b6527..9b8a11159d 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -966,7 +966,7 @@ int tcp_ctl(struct socket *so)
                 so->so_faddr.s_addr =3D=3D ex_ptr->ex_addr.s_addr) {
                 if (ex_ptr->ex_chardev) {
                     so->s =3D -1;
-                    so->extra =3D ex_ptr->ex_chardev;
+                    so->chardev =3D ex_ptr->ex_chardev;
                     return 1;
                 }
                 DEBUG_MISC((dfd, " executing %s\n", ex_ptr->ex_exec));
--=20
2.19.1.708.g4ede3d42df
