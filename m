Received: from eggs.gnu.org ([2001:4830:134:3::10]:59025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dVbDM-00052I-O1
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dVbDI-0007wU-P9
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:19:20 -0400
Received: from mail-co1nam03on0056.outbound.protection.outlook.com
	([104.47.40.56]:28375
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dVbDI-0007vC-1M
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:19:16 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 13 Jul 2017 03:15:49 -0700
Message-ID: <468425bd8090e3a9fd7fc791db42e24d6c75315c.1499940552.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/1] io/channel-watch.c: Only select on what
 we are actually waiting for
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

When calling WAEventSelect() only wait on events as specified by the
condition variable. This requires that the condition variable is set
correctly for the specific events that we need to wait for.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 io/channel-watch.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/io/channel-watch.c b/io/channel-watch.c
index 8640d1c464..d80722f496 100644
--- a/io/channel-watch.c
+++ b/io/channel-watch.c
@@ -286,9 +286,21 @@ GSource *qio_channel_create_socket_watch(QIOChannel *ioc,
     QIOChannelSocketSource *ssource;
 
 #ifdef WIN32
-    WSAEventSelect(socket, ioc->event,
-                   FD_READ | FD_ACCEPT | FD_CLOSE |
-                   FD_CONNECT | FD_WRITE | FD_OOB);
+    long bitmask = 0;
+
+    if (condition & (G_IO_IN | G_IO_PRI)) {
+        bitmask |= FD_READ | FD_ACCEPT;
+    }
+
+    if (condition & G_IO_HUP) {
+        bitmask |= FD_CLOSE;
+    }
+
+    if (condition & G_IO_OUT) {
+        bitmask |= FD_WRITE | FD_CONNECT;
+    }
+
+    WSAEventSelect(socket, ioc->event, bitmask);
 #endif
 
     source = g_source_new(&qio_channel_socket_source_funcs,
-- 
2.11.0
