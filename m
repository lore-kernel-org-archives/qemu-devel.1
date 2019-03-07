Received: from eggs.gnu.org ([209.51.188.92]:60160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMb-0002nK-Ry
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMa-0005kY-GB
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:45 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMY-0005hl-Ea
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:42 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:24 -0800
Message-Id: <20190307072224.9316-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 24/37] multi-process: pass
 proxy link socket fd to remote process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 hw/proxy/qemu-proxy.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index d1560d9..f519beb 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -201,7 +201,7 @@ static void setup_irqfd(PCIProxyDev *dev)
 
 static void init_emulation_process(PCIProxyDev *pdev, char *command, Error **errp)
 {
-    char *args[2];
+    char *args[3];
     pid_t rpid;
     int fd[2];
 
@@ -221,16 +221,12 @@ static void init_emulation_process(PCIProxyDev *pdev, char *command, Error **err
     }
 
     if (rpid == 0) {
-        if (dup2(fd[1], STDIN_FILENO) != STDIN_FILENO) {
-            perror("Failed to acquire socket.");
-            exit(1);
-        }
-
         close(fd[0]);
-        close(fd[1]);
 
         args[0] = g_strdup(command);
-        args[1] = NULL;
+        args[1] = g_strdup_printf("%d", fd[1]);
+        args[2] = NULL;
+
         execvp(args[0], (char *const *)args);
         exit(1);
     }
-- 
1.8.3.1
