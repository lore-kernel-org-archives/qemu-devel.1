Received: from eggs.gnu.org ([2001:4830:134:3::10]:47619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKIEY-0007pH-KG
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKIEV-0002KB-JH
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:54:22 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 20 May 2018 09:15:05 +0300
Message-Id: <f5bdd781316d2ba140323cb98392e44cac54017d.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/22] gdbstub: Use qemu_set_cloexec()
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

Use the utility routine qemu_set_cloexec() rather than
manually calling fcntl(). This lets us drop the #ifndef _WIN32
guards and also means Coverity doesn't complain that we're
ignoring the fcntl error return (CID 1005665, CID 1005667).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 gdbstub.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 9682e16ef7..b99980d2e2 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1828,9 +1828,7 @@ static void gdb_accept(void)
             perror("accept");
             return;
         } else if (fd >=3D 0) {
-#ifndef _WIN32
-            fcntl(fd, F_SETFD, FD_CLOEXEC);
-#endif
+            qemu_set_cloexec(fd);
             break;
         }
     }
@@ -1857,9 +1855,7 @@ static int gdbserver_open(int port)
         perror("socket");
         return -1;
     }
-#ifndef _WIN32
-    fcntl(fd, F_SETFD, FD_CLOEXEC);
-#endif
+    qemu_set_cloexec(fd);
=20
     socket_set_fast_reuse(fd);
=20
--=20
2.11.0
