Received: from eggs.gnu.org ([2001:4830:134:3::10]:45444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLU9B-0006QB-OY
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:22:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLTxG-0000RA-RF
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:09:45 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:60400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gLTxG-0000H4-Du
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:09:42 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 10 Nov 2018 15:09:25 +0100
Message-Id: <20181110140925.22457-5-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181110140925.22457-1-samuel.thibault@ens-lyon.org>
References: <20181110140925.22457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] slirp: fork_exec(): create and connect
 child socket before fork()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Peter Maydell <peter.maydell@linaro.org>

Currently fork_exec() fork()s, and then creates and connects the
child socket which it uses for communication with the parent in
the child process. This is awkward because the child has no
mechanism to report failure back to the parent, which might end
up blocked forever in accept(). The child code also has an issue
pointed out by Coverity (CID 1005727), where if the qemu_socket()
call fails it will pass -1 as a file descriptor to connect().

Fix these issues by moving the creation of the child's end of
the socket to before the fork(), where we are in a position to
handle a possible failure.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/misc.c | 55 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index 260187b6b6..57bdd808e2 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -85,9 +85,10 @@ fork_exec(struct socket *so, const char *ex, int do_pt=
y)
 int
 fork_exec(struct socket *so, const char *ex, int do_pty)
 {
-	int s;
-	struct sockaddr_in addr;
+        int s, cs;
+        struct sockaddr_in addr, csaddr;
 	socklen_t addrlen =3D sizeof(addr);
+        socklen_t csaddrlen =3D sizeof(csaddr);
 	int opt;
 	const char *argv[256];
 	/* don't want to clobber the original */
@@ -120,10 +121,35 @@ fork_exec(struct socket *so, const char *ex, int do=
_pty)
 		}
 	}
=20
+        if (getsockname(s, (struct sockaddr *)&csaddr, &csaddrlen) < 0) =
{
+            closesocket(s);
+            return 0;
+        }
+        cs =3D qemu_socket(AF_INET, SOCK_STREAM, 0);
+        if (cs < 0) {
+            closesocket(s);
+            return 0;
+        }
+        csaddr.sin_addr =3D loopback_addr;
+        /*
+         * This connect won't block because we've already listen()ed on
+         * the server end (even though we won't accept() the connection
+         * until later on).
+         */
+        do {
+            ret =3D connect(cs, (struct sockaddr *)&csaddr, csaddrlen);
+        } while (ret < 0 && errno =3D=3D EINTR);
+        if (ret < 0) {
+            closesocket(s);
+            closesocket(cs);
+            return 0;
+        }
+
 	pid =3D fork();
 	switch(pid) {
 	 case -1:
 		error_report("Error: fork failed: %s", strerror(errno));
+                closesocket(cs);
 		close(s);
 		return 0;
=20
@@ -131,21 +157,10 @@ fork_exec(struct socket *so, const char *ex, int do=
_pty)
                 setsid();
=20
 		/* Set the DISPLAY */
-                getsockname(s, (struct sockaddr *)&addr, &addrlen);
                 close(s);
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
+                dup2(cs, 0);
+                dup2(cs, 1);
+                dup2(cs, 2);
 		for (s =3D getdtablesize() - 1; s >=3D 3; s--)
 		   close(s);
=20
@@ -178,12 +193,10 @@ fork_exec(struct socket *so, const char *ex, int do=
_pty)
=20
 	 default:
 		qemu_add_child_watch(pid);
+                closesocket(cs);
                 /*
-                 * XXX this could block us...
-                 * XXX Should set a timer here, and if accept() doesn't
-                 * return after X seconds, declare it a failure
-                 * The only reason this will block forever is if socket(=
)
-                 * of connect() fail in the child process
+                 * This should never block, because we already connect()=
ed
+                 * on the child end before we forked.
                  */
                 do {
                     so->s =3D accept(s, (struct sockaddr *)&addr, &addrl=
en);
--=20
2.19.1
