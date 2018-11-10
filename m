Received: from eggs.gnu.org ([2001:4830:134:3::10]:36442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLTb7-0004YX-82
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:46:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLTat-00080u-9t
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:46:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gLTaf-000729-La
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:46:24 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 10 Nov 2018 17:45:38 +0400
Message-Id: <20181110134548.14741-4-marcandre.lureau@redhat.com>
In-Reply-To: <20181110134548.14741-1-marcandre.lureau@redhat.com>
References: <20181110134548.14741-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 03/13] slirp: replace ex_pty with
 ex_chardev
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

do_pty =3D=3D 3 means to talk to a chardev.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/misc.h     | 2 +-
 slirp/misc.c     | 2 +-
 slirp/slirp.c    | 4 ++--
 slirp/tcp_subr.c | 4 +---
 4 files changed, 5 insertions(+), 7 deletions(-)

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
diff --git a/slirp/misc.c b/slirp/misc.c
index ec5d5ec073..aa3c4b9771 100644
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
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 878d6174a2..eb468facb1 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1444,7 +1444,7 @@ static void slirp_state_save(QEMUFile *f, void *opa=
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
@@ -1482,7 +1482,7 @@ static int slirp_state_load(QEMUFile *f, void *opaq=
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
index a82efe78d7..c534b0224b 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -956,7 +956,6 @@ int tcp_ctl(struct socket *so)
     Slirp *slirp =3D so->slirp;
     struct sbuf *sb =3D &so->so_snd;
     struct ex_list *ex_ptr;
-    int do_pty;
=20
     DEBUG_CALL("tcp_ctl");
     DEBUG_ARG("so =3D %p", so);
@@ -966,12 +965,11 @@ int tcp_ctl(struct socket *so)
         for (ex_ptr =3D slirp->exec_list; ex_ptr; ex_ptr =3D ex_ptr->ex_=
next) {
             if (ex_ptr->ex_fport =3D=3D so->so_fport &&
                 so->so_faddr.s_addr =3D=3D ex_ptr->ex_addr.s_addr) {
-                if (ex_ptr->ex_pty =3D=3D 3) {
+                if (ex_ptr->ex_chardev) {
                     so->s =3D -1;
                     so->extra =3D (void *)ex_ptr->ex_exec;
                     return 1;
                 }
-                do_pty =3D ex_ptr->ex_pty;
                 DEBUG_MISC((dfd, " executing %s\n", ex_ptr->ex_exec));
                 return fork_exec(so, ex_ptr->ex_exec);
             }
--=20
2.19.1.708.g4ede3d42df
