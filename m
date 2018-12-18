Received: from eggs.gnu.org ([2001:4830:134:3::10]:40205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQI-00081V-LO
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQE-0004Dl-1u
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:08 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQC-00044j-DM
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:05 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:03:51 +0100
Message-Id: <20181218230442.27887-14-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/64] slirp: move socket pair creation in
 helper function
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

Originally, the patch was fixing a bunch of issues, but Peter beat me
to it with earlier commit "slirp: fork_exec(): create and connect
child socket before fork()".

Factor out socket pair creation, to simplify the fork_exec() code.
Use the name socketpair_with_oob() since the code is actually similar
to what socketpair() would do, except that it uses TCP sockets, for
SLIRP to be able to call send with MSG_OOB (since SO_OOBINLINE is set,
this could probably be faked instead on regular unix sockets though).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/misc.c | 142 +++++++++++++++++++++++++--------------------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index 4840187750..7362e14339 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -73,85 +73,92 @@ fork_exec(struct socket *so, const char *ex)
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
+    /*
+     * This connect won't block because we've already listen()ed on
+     * the server end (even though we won't accept() the connection
+     * until later on).
+     */
+    do {
+        ret =3D connect(sv[1], (struct sockaddr *)&addr, addrlen);
+    } while (ret < 0 && errno =3D=3D EINTR);
+    if (ret < 0) {
+        goto err;
+    }
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
-        int s, cs;
-        struct sockaddr_in addr, csaddr;
-	socklen_t addrlen =3D sizeof(addr);
-        socklen_t csaddrlen =3D sizeof(csaddr);
-	int opt;
 	char **argv;
-	int ret;
+	int opt, c, sp[2];
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
-        if (getsockname(s, (struct sockaddr *)&csaddr, &csaddrlen) < 0) =
{
-            closesocket(s);
-            return 0;
-        }
-        cs =3D qemu_socket(AF_INET, SOCK_STREAM, 0);
-        if (cs < 0) {
-            closesocket(s);
-            return 0;
-        }
-        csaddr.sin_addr =3D loopback_addr;
-        /*
-         * This connect won't block because we've already listen()ed on
-         * the server end (even though we won't accept() the connection
-         * until later on).
-         */
-        do {
-            ret =3D connect(cs, (struct sockaddr *)&csaddr, csaddrlen);
-        } while (ret < 0 && errno =3D=3D EINTR);
-        if (ret < 0) {
-            closesocket(s);
-            closesocket(cs);
-            return 0;
-        }
-
 	pid =3D fork();
 	switch(pid) {
 	 case -1:
 		error_report("Error: fork failed: %s", strerror(errno));
-                closesocket(cs);
-		close(s);
+		closesocket(sp[0]);
+		closesocket(sp[1]);
 		return 0;
=20
 	 case 0:
-                setsid();
-
-		/* Set the DISPLAY */
-                close(s);
-                dup2(cs, 0);
-                dup2(cs, 1);
-                dup2(cs, 2);
-		for (s =3D getdtablesize() - 1; s >=3D 3; s--)
-		   close(s);
+		setsid();
+		dup2(sp[1], 0);
+		dup2(sp[1], 1);
+		dup2(sp[1], 2);
+		for (c =3D getdtablesize() - 1; c >=3D 3; c--)
+		   close(c);
=20
                 argv =3D g_strsplit(ex, " ", -1);
 		execvp(argv[0], (char **)argv);
@@ -163,19 +170,12 @@ fork_exec(struct socket *so, const char *ex)
 		exit(1);
=20
 	 default:
+		so->s =3D sp[0];
+		closesocket(sp[1]);
 		qemu_add_child_watch(pid);
-                closesocket(cs);
-                /*
-                 * This should never block, because we already connect()=
ed
-                 * on the child end before we forked.
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
+		socket_set_fast_reuse(so->s);
+		opt =3D 1;
+		qemu_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
 		qemu_set_nonblock(so->s);
 		return 1;
 	}
--=20
2.19.2
