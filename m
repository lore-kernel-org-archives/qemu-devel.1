Received: from eggs.gnu.org ([2001:4830:134:3::10]:40001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQB-0007wJ-Hd
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQ5-00043s-OW
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:00 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQ1-0003yT-Ow
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:04:55 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:03:40 +0100
Message-Id: <20181218230442.27887-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/64] slirp: remove do_pty from fork_exec()
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

QEMU uses fork_exec() with do_pty values 0 or 3.
Let's clean up some unused code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/misc.c     | 55 ++++++++++++++----------------------------------
 slirp/misc.h     |  2 +-
 slirp/tcp_subr.c |  4 +---
 3 files changed, 18 insertions(+), 43 deletions(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index 57bdd808e2..e69d5f42c3 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -63,7 +63,7 @@ int add_exec(struct ex_list **ex_ptr, int do_pty, char =
*exec,
 #ifdef _WIN32
=20
 int
-fork_exec(struct socket *so, const char *ex, int do_pty)
+fork_exec(struct socket *so, const char *ex)
 {
     /* not implemented */
     return 0;
@@ -77,13 +77,9 @@ fork_exec(struct socket *so, const char *ex, int do_pt=
y)
  * process, which connects to this socket, after which we
  * exec the wanted program.  If something (strange) happens,
  * the accept() call could block us forever.
- *
- * do_pty =3D 0   Fork/exec inetd style
- * do_pty =3D 1   Fork/exec using slirp.telnetd
- * do_ptr =3D 2   Fork/exec using pty
  */
 int
-fork_exec(struct socket *so, const char *ex, int do_pty)
+fork_exec(struct socket *so, const char *ex)
 {
         int s, cs;
         struct sockaddr_in addr, csaddr;
@@ -100,26 +96,20 @@ fork_exec(struct socket *so, const char *ex, int do_=
pty)
 	DEBUG_CALL("fork_exec");
 	DEBUG_ARG("so =3D %p", so);
 	DEBUG_ARG("ex =3D %p", ex);
-	DEBUG_ARG("do_pty =3D %x", do_pty);
-
-	if (do_pty =3D=3D 2) {
-                return 0;
-	} else {
-		addr.sin_family =3D AF_INET;
-		addr.sin_port =3D 0;
-		addr.sin_addr.s_addr =3D INADDR_ANY;
=20
-		if ((s =3D qemu_socket(AF_INET, SOCK_STREAM, 0)) < 0 ||
-		    bind(s, (struct sockaddr *)&addr, addrlen) < 0 ||
-		    listen(s, 1) < 0) {
-			error_report("Error: inet socket: %s", strerror(errno));
-			if (s >=3D 0) {
-			    closesocket(s);
-			}
+    addr.sin_family =3D AF_INET;
+    addr.sin_port =3D 0;
+    addr.sin_addr.s_addr =3D INADDR_ANY;
=20
-			return 0;
-		}
-	}
+    s =3D qemu_socket(AF_INET, SOCK_STREAM, 0);
+    if (s < 0 || bind(s, (struct sockaddr *)&addr, addrlen) < 0 ||
+        listen(s, 1) < 0) {
+        error_report("Error: inet socket: %s", strerror(errno));
+        if (s >=3D 0) {
+            closesocket(s);
+        }
+        return 0;
+    }
=20
         if (getsockname(s, (struct sockaddr *)&csaddr, &csaddrlen) < 0) =
{
             closesocket(s);
@@ -166,13 +156,7 @@ fork_exec(struct socket *so, const char *ex, int do_=
pty)
=20
 		i =3D 0;
 		bptr =3D g_strdup(ex); /* No need to free() this */
-		if (do_pty =3D=3D 1) {
-			/* Setup "slirp.telnetd -x" */
-			argv[i++] =3D "slirp.telnetd";
-			argv[i++] =3D "-x";
-			argv[i++] =3D bptr;
-		} else
-		   do {
+        do {
 			/* Change the string into argv[] */
 			curarg =3D bptr;
 			while (*bptr !=3D ' ' && *bptr !=3D (char)0)
@@ -180,7 +164,7 @@ fork_exec(struct socket *so, const char *ex, int do_p=
ty)
 			c =3D *bptr;
 			*bptr++ =3D (char)0;
 			argv[i++] =3D g_strdup(curarg);
-		   } while (c);
+        } while (c);
=20
                 argv[i] =3D NULL;
 		execvp(argv[0], (char **)argv);
@@ -206,13 +190,6 @@ fork_exec(struct socket *so, const char *ex, int do_=
pty)
                 opt =3D 1;
                 qemu_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, s=
izeof(int));
 		qemu_set_nonblock(so->s);
-
-		/* Append the telnet options now */
-                if (so->so_m !=3D NULL && do_pty =3D=3D 1)  {
-			sbappend(so, so->so_m);
-                        so->so_m =3D NULL;
-		}
-
 		return 1;
 	}
 }
diff --git a/slirp/misc.h b/slirp/misc.h
index 5211bbd30a..897650aea1 100644
--- a/slirp/misc.h
+++ b/slirp/misc.h
@@ -53,6 +53,6 @@ struct slirp_quehead {
 void slirp_insque(void *, void *);
 void slirp_remque(void *);
 int add_exec(struct ex_list **, int, char *, struct in_addr, int);
-int fork_exec(struct socket *so, const char *ex, int do_pty);
+int fork_exec(struct socket *so, const char *ex);
=20
 #endif
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index fa61349cbb..0ccd8e1a96 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -951,7 +951,6 @@ int tcp_ctl(struct socket *so)
     Slirp *slirp =3D so->slirp;
     struct sbuf *sb =3D &so->so_snd;
     struct ex_list *ex_ptr;
-    int do_pty;
=20
     DEBUG_CALL("tcp_ctl");
     DEBUG_ARG("so =3D %p", so);
@@ -966,9 +965,8 @@ int tcp_ctl(struct socket *so)
                     so->extra =3D (void *)ex_ptr->ex_exec;
                     return 1;
                 }
-                do_pty =3D ex_ptr->ex_pty;
                 DEBUG_MISC((dfd, " executing %s\n", ex_ptr->ex_exec));
-                return fork_exec(so, ex_ptr->ex_exec, do_pty);
+                return fork_exec(so, ex_ptr->ex_exec);
             }
         }
     }
--=20
2.19.2
