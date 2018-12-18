Received: from eggs.gnu.org ([2001:4830:134:3::10]:40224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQI-00081z-TG
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQD-0004D1-S1
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:10 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:41398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQC-00044I-41
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:05 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:03:44 +0100
Message-Id: <20181218230442.27887-7-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/64] slirp: rename /extra/chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Now it's only used for the chardev pointer.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/slirp.c    | 4 ++--
 slirp/socket.h   | 2 +-
 slirp/tcp_subr.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index e5968d9aea..4c9ba9d428 100644
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
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index fd7521854e..4b40850c7a 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -961,7 +961,7 @@ int tcp_ctl(struct socket *so)
                 so->so_faddr.s_addr =3D=3D ex_ptr->ex_addr.s_addr) {
                 if (ex_ptr->ex_chardev) {
                     so->s =3D -1;
-                    so->extra =3D ex_ptr->ex_chardev;
+                    so->chardev =3D ex_ptr->ex_chardev;
                     return 1;
                 }
                 DEBUG_MISC((dfd, " executing %s\n", ex_ptr->ex_exec));
--=20
2.19.2
