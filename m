Received: from eggs.gnu.org ([2001:4830:134:3::10]:40007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQB-0007wM-LV
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQ5-00043r-OQ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:00 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQ1-0003yX-P2
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:04:55 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:03:41 +0100
Message-Id: <20181218230442.27887-4-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/64] slirp: replace ex_pty with ex_chardev
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

do_pty =3D=3D 3 means to talk to a chardev.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/misc.c     | 2 +-
 slirp/misc.h     | 2 +-
 slirp/slirp.c    | 4 ++--
 slirp/tcp_subr.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index e69d5f42c3..8f0b6004bd 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -53,7 +53,7 @@ int add_exec(struct ex_list **ex_ptr, int do_pty, char =
*exec,
 	*ex_ptr =3D g_new(struct ex_list, 1);
 	(*ex_ptr)->ex_fport =3D port;
 	(*ex_ptr)->ex_addr =3D addr;
-	(*ex_ptr)->ex_pty =3D do_pty;
+	(*ex_ptr)->ex_chardev =3D do_pty =3D=3D 3;
 	(*ex_ptr)->ex_exec =3D (do_pty =3D=3D 3) ? exec : g_strdup(exec);
 	(*ex_ptr)->ex_next =3D tmp_ptr;
 	return 0;
diff --git a/slirp/misc.h b/slirp/misc.h
index 897650aea1..1f8d11def6 100644
--- a/slirp/misc.h
+++ b/slirp/misc.h
@@ -9,7 +9,7 @@
 #define MISC_H
=20
 struct ex_list {
-	int ex_pty;			/* Do we want a pty? */
+	int ex_chardev;
 	struct in_addr ex_addr;		/* Server address */
 	int ex_fport;                   /* Port to telnet to */
 	const char *ex_exec;            /* Command line of what to exec */
diff --git a/slirp/slirp.c b/slirp/slirp.c
index b0380c5eaa..fd0b17e0d9 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1455,7 +1455,7 @@ static void slirp_state_save(QEMUFile *f, void *opa=
que)
     struct ex_list *ex_ptr;
=20
     for (ex_ptr =3D slirp->exec_list; ex_ptr; ex_ptr =3D ex_ptr->ex_next=
)
-        if (ex_ptr->ex_pty =3D=3D 3) {
+        if (ex_ptr->ex_chardev) {
             struct socket *so;
             so =3D slirp_find_ctl_socket(slirp, ex_ptr->ex_addr,
                                        ntohs(ex_ptr->ex_fport));
@@ -1490,7 +1490,7 @@ static int slirp_state_load(QEMUFile *f, void *opaq=
ue, int version_id)
             return -EINVAL;
         }
         for (ex_ptr =3D slirp->exec_list; ex_ptr; ex_ptr =3D ex_ptr->ex_=
next) {
-            if (ex_ptr->ex_pty =3D=3D 3 &&
+            if (ex_ptr->ex_chardev &&
                 so->so_faddr.s_addr =3D=3D ex_ptr->ex_addr.s_addr &&
                 so->so_fport =3D=3D ex_ptr->ex_fport) {
                 break;
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 0ccd8e1a96..dc19eea55a 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -960,7 +960,7 @@ int tcp_ctl(struct socket *so)
         for (ex_ptr =3D slirp->exec_list; ex_ptr; ex_ptr =3D ex_ptr->ex_=
next) {
             if (ex_ptr->ex_fport =3D=3D so->so_fport &&
                 so->so_faddr.s_addr =3D=3D ex_ptr->ex_addr.s_addr) {
-                if (ex_ptr->ex_pty =3D=3D 3) {
+                if (ex_ptr->ex_chardev) {
                     so->s =3D -1;
                     so->extra =3D (void *)ex_ptr->ex_exec;
                     return 1;
--=20
2.19.2
