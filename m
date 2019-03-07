Received: from eggs.gnu.org ([209.51.188.92]:60257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMj-0002t0-KT
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMh-0005tF-Oc
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:52 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMg-0005nJ-Ft
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:51 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:43 -0800
Message-Id: <20190307072243.9685-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 32/37] multi-process: handle
 heartbit messages in remote process
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

and reply back to proxy object.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 remote/remote-main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index 3fa6cbd..1e45105 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -339,6 +339,7 @@ static void process_msg(GIOCondition cond)
 {
     ProcMsg *msg = NULL;
     Error *err = NULL;
+    int wait;
 
     if ((cond & G_IO_HUP) || (cond & G_IO_ERR)) {
         error_setg(&err, "socket closed, cond is %d", cond);
@@ -418,6 +419,11 @@ static void process_msg(GIOCondition cond)
     case DEVICE_DEL:
         process_device_del_msg(msg);
         break;
+    case PROXY_PING:
+        wait = msg->fds[0];
+        notify_proxy(wait, (uint32_t)getpid());
+        PUT_REMOTE_WAIT(wait);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
1.8.3.1
