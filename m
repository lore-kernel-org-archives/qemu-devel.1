Received: from eggs.gnu.org ([2001:4830:134:3::10]:36744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLTbY-0004uz-Ql
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLTbW-0001CB-9R
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:47:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gLTbV-00014v-7J
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:47:13 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 10 Nov 2018 17:45:45 +0400
Message-Id: <20181110134548.14741-11-marcandre.lureau@redhat.com>
In-Reply-To: <20181110134548.14741-1-marcandre.lureau@redhat.com>
References: <20181110134548.14741-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 10/13] slirp: improve subprocess socket
 creation
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

Fix a bunch of error handling issues by creating the "TCP socketpair"
from the parent process. (the code is currently disabled on Windows:
at first I thought a socketpair() could be used, but I realized that
slirp calls MSG_OOB on the socket, which isn't implemented on Linux)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/misc.c | 133 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 72 insertions(+), 61 deletions(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index 54edc0b0b9..d9804f2a6d 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -73,42 +73,75 @@ fork_exec(struct socket *so, const char *ex)
=20
 #else
=20
-/*
- * XXX This is ugly
- * We create and bind a socket, then fork off to another
- * process, which connects to this socket, after which we
- * exec the wanted program.  If something (strange) happens,
- * the accept() call could block us forever.
- */
+static int
+slirp_socketpair_with_oob(int sv[2])
+{
+    struct sockaddr_in addr =3D {
+        .sin_family =3D AF_INET,
+        .sin_port =3D 0,
+        .sin_addr.s_addr =3D INADDR_ANY,
+    };
+    socklen_t addrlen =3D sizeof(addr);
+    int ret, s;
+
+    sv[1] =3D -1;
+    s =3D qemu_socket(AF_INET, SOCK_STREAM, 0);
+    if (s < 0 || bind(s, (struct sockaddr *)&addr, addrlen) < 0 ||
+        listen(s, 1) < 0 ||
+        getsockname(s, (struct sockaddr *)&addr, &addrlen) < 0) {
+        goto err;
+    }
+
+    sv[1] =3D qemu_socket(AF_INET, SOCK_STREAM, 0);
+    if (sv[1] < 0) {
+        goto err;
+    }
+
+    qemu_set_nonblock(sv[1]);
+    do {
+        ret =3D connect(sv[1], (struct sockaddr *)&addr, addrlen);
+    } while (ret < 0 && errno =3D=3D EINTR);
+    if (ret =3D=3D -1 && errno !=3D EINPROGRESS) {
+        goto err;
+    }
+    qemu_set_block(sv[1]);
+
+    do {
+        sv[0] =3D accept(s, (struct sockaddr *)&addr, &addrlen);
+    } while (sv[0] < 0 && errno =3D=3D EINTR);
+    if (sv[0] < 0) {
+        goto err;
+    }
+
+    closesocket(s);
+    return 0;
+
+err:
+    error_report("Error: slirp_socketpair(): %s", strerror(errno));
+    if (s >=3D 0) {
+        closesocket(s);
+    }
+    if (sv[1] >=3D 0) {
+        closesocket(sv[1]);
+    }
+    return -1;
+}
+
 int
 fork_exec(struct socket *so, const char *ex)
 {
-	int s;
-	struct sockaddr_in addr;
-	socklen_t addrlen =3D sizeof(addr);
-	int opt;
 	const char *argv[256];
 	/* don't want to clobber the original */
 	char *bptr;
 	const char *curarg;
-	int c, i, ret;
+	int opt, c, i, sp[2];
 	pid_t pid;
=20
 	DEBUG_CALL("fork_exec");
 	DEBUG_ARG("so =3D %p", so);
 	DEBUG_ARG("ex =3D %p", ex);
=20
-    addr.sin_family =3D AF_INET;
-    addr.sin_port =3D 0;
-    addr.sin_addr.s_addr =3D INADDR_ANY;
-
-    s =3D qemu_socket(AF_INET, SOCK_STREAM, 0);
-    if (s < 0 || bind(s, (struct sockaddr *)&addr, addrlen) < 0 ||
-        listen(s, 1) < 0) {
-        error_report("Error: inet socket: %s", strerror(errno));
-        if (s >=3D 0) {
-            closesocket(s);
-        }
+    if (slirp_socketpair_with_oob(sp) < 0) {
         return 0;
     }
=20
@@ -116,30 +149,17 @@ fork_exec(struct socket *so, const char *ex)
 	switch(pid) {
 	 case -1:
 		error_report("Error: fork failed: %s", strerror(errno));
-		close(s);
+		closesocket(sp[0]);
+		closesocket(sp[1]);
 		return 0;
=20
 	 case 0:
-                setsid();
-
-		/* Set the DISPLAY */
-                getsockname(s, (struct sockaddr *)&addr, &addrlen);
-                close(s);
-                /*
-                 * Connect to the socket
-                 * XXX If any of these fail, we're in trouble!
-                 */
-                s =3D qemu_socket(AF_INET, SOCK_STREAM, 0);
-                addr.sin_addr =3D loopback_addr;
-                do {
-                    ret =3D connect(s, (struct sockaddr *)&addr, addrlen=
);
-                } while (ret < 0 && errno =3D=3D EINTR);
-
-		dup2(s, 0);
-		dup2(s, 1);
-		dup2(s, 2);
-		for (s =3D getdtablesize() - 1; s >=3D 3; s--)
-		   close(s);
+         setsid();
+		dup2(sp[1], 0);
+		dup2(sp[1], 1);
+		dup2(sp[1], 2);
+		for (c =3D getdtablesize() - 1; c >=3D 3; c--)
+		   close(c);
=20
 		i =3D 0;
 		bptr =3D g_strdup(ex); /* No need to free() this */
@@ -163,23 +183,14 @@ fork_exec(struct socket *so, const char *ex)
 		exit(1);
=20
 	 default:
-		qemu_add_child_watch(pid);
-                /*
-                 * XXX this could block us...
-                 * XXX Should set a timer here, and if accept() doesn't
-                 * return after X seconds, declare it a failure
-                 * The only reason this will block forever is if socket(=
)
-                 * of connect() fail in the child process
-                 */
-                do {
-                    so->s =3D accept(s, (struct sockaddr *)&addr, &addrl=
en);
-                } while (so->s < 0 && errno =3D=3D EINTR);
-                closesocket(s);
-                socket_set_fast_reuse(so->s);
-                opt =3D 1;
-                qemu_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, s=
izeof(int));
-		qemu_set_nonblock(so->s);
-		return 1;
+         so->s =3D sp[0];
+         closesocket(sp[1]);
+         qemu_add_child_watch(pid);
+         socket_set_fast_reuse(so->s);
+         opt =3D 1;
+         qemu_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(i=
nt));
+         qemu_set_nonblock(so->s);
+         return 1;
 	}
 }
 #endif
--=20
2.19.1.708.g4ede3d42df
