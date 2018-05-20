Received: from eggs.gnu.org ([2001:4830:134:3::10]:44889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHlW-0007n5-RP
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHlT-0008JR-Mj
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:24:22 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 20 May 2018 09:15:06 +0300
Message-Id: <2f652224f76c115f6c991766b7acac1e22580954.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/22] gdbstub: Handle errors in gdb_accept()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Peter Maydell <peter.maydell@linaro.org>

In gdb_accept(), we both fail to check all errors (notably
that from socket_set_nodelay(), as Coverity notes in CID 1005666),
and fail to return an error status back to our caller. Correct
both of these things, so that errors in accept() result in our
stopping with a useful error message rather than ignoring it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 gdbstub.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index b99980d2e2..e4ece2f5bc 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1814,7 +1814,7 @@ void gdb_signalled(CPUArchState *env, int sig)
     put_packet(s, buf);
 }
=20
-static void gdb_accept(void)
+static bool gdb_accept(void)
 {
     GDBState *s;
     struct sockaddr_in sockaddr;
@@ -1826,7 +1826,7 @@ static void gdb_accept(void)
         fd =3D accept(gdbserver_fd, (struct sockaddr *)&sockaddr, &len);
         if (fd < 0 && errno !=3D EINTR) {
             perror("accept");
-            return;
+            return false;
         } else if (fd >=3D 0) {
             qemu_set_cloexec(fd);
             break;
@@ -1834,7 +1834,10 @@ static void gdb_accept(void)
     }
=20
     /* set short latency */
-    socket_set_nodelay(fd);
+    if (socket_set_nodelay(fd)) {
+        perror("setsockopt");
+        return false;
+    }
=20
     s =3D g_malloc0(sizeof(GDBState));
     s->c_cpu =3D first_cpu;
@@ -1843,6 +1846,7 @@ static void gdb_accept(void)
     gdb_has_xml =3D false;
=20
     gdbserver_state =3D s;
+    return true;
 }
=20
 static int gdbserver_open(int port)
@@ -1883,7 +1887,11 @@ int gdbserver_start(int port)
     if (gdbserver_fd < 0)
         return -1;
     /* accept connections */
-    gdb_accept();
+    if (!gdb_accept()) {
+        close(gdbserver_fd);
+        gdbserver_fd =3D -1;
+        return -1;
+    }
     return 0;
 }
=20
--=20
2.11.0
