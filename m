Received: from eggs.gnu.org ([2001:4830:134:3::10]:40842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORC-0000Oo-P5
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORB-00055N-A3
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:06 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZORA-0004Zv-KA
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:04 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:22 +0100
Message-Id: <20181218230442.27887-45-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 44/64] slirp: simplify fork_exec()
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

Use g_spawn_async_with_fds() to setup the child.

GSpawn handles reaping the child, and closing parent file descriptors.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/misc.c | 75 +++++++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index ee3492a2ae..753b3da25b 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -129,56 +129,53 @@ err:
     return -1;
 }
=20
+static void
+fork_exec_child_setup(gpointer data)
+{
+    setsid();
+}
+
 int
 fork_exec(struct socket *so, const char *ex)
 {
-	char **argv;
-	int opt, c, sp[2];
-	pid_t pid;
+    GError *err =3D NULL;
+    char **argv;
+    int opt, sp[2];
=20
-	DEBUG_CALL("fork_exec");
-	DEBUG_ARG("so =3D %p", so);
-	DEBUG_ARG("ex =3D %p", ex);
+    DEBUG_CALL("fork_exec");
+    DEBUG_ARG("so =3D %p", so);
+    DEBUG_ARG("ex =3D %p", ex);
=20
     if (slirp_socketpair_with_oob(sp) < 0) {
         return 0;
     }
=20
-	pid =3D fork();
-	switch(pid) {
-	 case -1:
-		error_report("Error: fork failed: %s", strerror(errno));
-		closesocket(sp[0]);
-		closesocket(sp[1]);
-		return 0;
-
-	 case 0:
-		setsid();
-		dup2(sp[1], 0);
-		dup2(sp[1], 1);
-		dup2(sp[1], 2);
-		for (c =3D getdtablesize() - 1; c >=3D 3; c--)
-		   close(c);
+    argv =3D g_strsplit(ex, " ", -1);
+    g_spawn_async_with_fds(NULL /* cwd */,
+                           argv,
+                           NULL /* env */,
+                           G_SPAWN_SEARCH_PATH,
+                           fork_exec_child_setup, NULL /* data */,
+                           NULL /* child_pid */,
+                           sp[1], sp[1], sp[1],
+                           &err);
+    g_strfreev(argv);
=20
-                argv =3D g_strsplit(ex, " ", -1);
-		execvp(argv[0], (char **)argv);
-
-		/* Ooops, failed, let's tell the user why */
-        fprintf(stderr, "Error: execvp of %s failed: %s\n",
-                argv[0], strerror(errno));
-		close(0); close(1); close(2); /* XXX */
-		exit(1);
+    if (err) {
+        error_report("%s", err->message);
+        g_error_free(err);
+        closesocket(sp[0]);
+        closesocket(sp[1]);
+        return 0;
+    }
=20
-	 default:
-		so->s =3D sp[0];
-		closesocket(sp[1]);
-		qemu_add_child_watch(pid);
-		socket_set_fast_reuse(so->s);
-		opt =3D 1;
-		qemu_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
-		qemu_set_nonblock(so->s);
-		return 1;
-	}
+    so->s =3D sp[0];
+    closesocket(sp[1]);
+    socket_set_fast_reuse(so->s);
+    opt =3D 1;
+    qemu_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
+    qemu_set_nonblock(so->s);
+    return 1;
 }
 #endif
=20
--=20
2.19.2
