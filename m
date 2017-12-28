Received: from eggs.gnu.org ([2001:4830:134:3::10]:39269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1eUUc0-0005o9-6r
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 04:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1eUUbv-0004gb-5u
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 04:36:28 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:37458 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1eUUbu-0004VP-Q2
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 04:36:23 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Thu, 28 Dec 2017 12:36:18 +0300
Message-Id: <1514453778-5363-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/1] io/channel-websock: handle continuous
 reads without any data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, "Daniel P . Berrange" <berrange@redhat.com>

From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>

According to the current implementation of websocket protocol in QEMU,
qio_channel_websock_handshake_io tries to read handshake from the
channel to start communication over tcp socket. But this subroutine
doesn't cover scenario when socket was closed while handshaking. Therefore,
if G_IO_IN is caught and qio_channel_websock_handshake_read returns
zero, error has to be set and connection has to be done.

Such behaviour causes 100% CPU load in main QEMU loop, because main loop
poll continues to receive and handle G_IO_IN events from websocket.

Step to reproduce 100% CPU load:
- start qemu with the simplest configuration
    $ qemu -vnc [::1]:1,websocket=7500
2) open any vnc listener (which doesn't follow websocket protocol)
    $ vncviewer :7500
3) kill listener
4) qemu main thread eats 100% CPU usage

Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 87ebdeb..71f046a 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -581,9 +581,11 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
         return FALSE;
     }
     if (ret == 0) {
-        trace_qio_channel_websock_handshake_pending(ioc, G_IO_IN);
-        /* need more data still */
-        return TRUE;
+        /* If G_IN_IO happened and there is no data to read, close connection */
+        error_setg(&err, "connection was closed");
+        qio_task_set_error(task, err);
+        qio_task_complete(task);
+        return FALSE;
     }
 
     if (err) {
-- 
2.7.4
