Received: from eggs.gnu.org ([2001:4830:134:3::10]:54015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNgT-00022n-Qr
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNgP-0003KY-2A
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1emNgO-0003Jh-SA
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:50:56 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 15 Feb 2018 17:50:39 +0000
Message-Id: <20180215175044.8159-3-berrange@redhat.com>
In-Reply-To: <20180215175044.8159-1-berrange@redhat.com>
References: <20180215175044.8159-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] io/channel-websock: handle continuous reads
 without any data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>

According to the current implementation of websocket protocol in QEMU,
qio_channel_websock_handshake_io tries to read handshake from the
channel to start communication over socket. But this approach
doesn't cover scenario when socket was closed while handshaking.
Therefore, if G_IO_IN is caught and qio_channel_read returns zero,
error has to be set and connection has to be done.

Such behaviour causes 100% CPU load in main QEMU loop, because main loop
poll continues to receive and handle G_IO_IN events from websocket.

Step to reproduce 100% CPU load:
1) start qemu with the simplest configuration
$ qemu -vnc [::1]:1,websocket=7500
2) open any vnc listener (which doesn't follow websocket
protocol)
$ vncviewer :7500
3) kill listener
4) qemu main thread eats 100% CPU

Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 7fd6bb68ba..ec48a305f0 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -499,9 +499,12 @@ static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
             error_setg(errp,
                        "End of headers not found in first 4096 bytes");
             return 1;
-        } else {
-            return 0;
+        } else if (ret == 0) {
+            error_setg(errp,
+                       "End of headers not found before connection closed");
+            return -1;
         }
+        return 0;
     }
     *handshake_end = '\0';
 
-- 
2.14.3
