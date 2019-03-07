Received: from eggs.gnu.org ([209.51.188.92]:60259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMj-0002t5-Nd
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMh-0005sZ-MN
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:53 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMg-0005mn-59
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:50 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:34 -0800
Message-Id: <20190307072234.9503-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 28/37] multi-process: remote:
 use fd for socket from parent process
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
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 remote/remote-main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index 52da3c8..fa32f2a 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -63,6 +63,7 @@
 #include "block/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu/log.h"
+#include "qemu/cutils.h"
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
@@ -437,6 +438,7 @@ int main(int argc, char *argv[])
 {
     Error *err = NULL;
     QemuThread main_loop_thread;
+    int fd = -1;
 
     module_call_init(MODULE_INIT_QOM);
 
@@ -461,7 +463,13 @@ int main(int argc, char *argv[])
         return -1;
     }
 
-    proxy_link_set_sock(proxy_link, STDIN_FILENO);
+    fd = qemu_parse_fd(argv[1]);
+    if (fd == -1) {
+        printf("Failed to parse fd for remote process.\n");
+        return -EINVAL;
+    }
+
+    proxy_link_set_sock(proxy_link, fd);
     proxy_link_set_callback(proxy_link, process_msg);
 
     qemu_thread_create(&main_loop_thread, "remote-main-loop", remote_main_loop,
-- 
1.8.3.1
