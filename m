Received: from eggs.gnu.org ([2001:4830:134:3::10]:43097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIHJJ-0007AD-1N
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIHJI-00066v-8F
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:30:57 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 18:30:43 +0100
Message-Id: <20180514173044.5025-2-peter.maydell@linaro.org>
In-Reply-To: <20180514173044.5025-1-peter.maydell@linaro.org>
References: <20180514173044.5025-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] gdbstub: Use qemu_set_cloexec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

Use the utility routine qemu_set_cloexec() rather than
manually calling fcntl(). This lets us drop the #ifndef _WIN32
guards and also means Coverity doesn't complain that we're
ignoring the fcntl error return (CID 1005665, CID 1005667).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 3c3807358c..cc7626c790 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1818,9 +1818,7 @@ static void gdb_accept(void)
             perror("accept");
             return;
         } else if (fd >= 0) {
-#ifndef _WIN32
-            fcntl(fd, F_SETFD, FD_CLOEXEC);
-#endif
+            qemu_set_cloexec(fd);
             break;
         }
     }
@@ -1847,9 +1845,7 @@ static int gdbserver_open(int port)
         perror("socket");
         return -1;
     }
-#ifndef _WIN32
-    fcntl(fd, F_SETFD, FD_CLOEXEC);
-#endif
+    qemu_set_cloexec(fd);
 
     socket_set_fast_reuse(fd);
 
-- 
2.17.0
