Received: from eggs.gnu.org ([2001:4830:134:3::10]:58545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1eZITa-0000T4-Lk
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:39:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1eZITX-0006ud-Hu
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:39:38 -0500
Received: from mail-ve1eur01on0701.outbound.protection.outlook.com
	([2a01:111:f400:fe1f::701]:37790
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1eZITX-0006ts-6m
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:39:35 -0500
From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Date: Wed, 10 Jan 2018 18:39:24 +0300
Message-Id: <20180110153924.17391-1-edgar.kaziakhmedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/1] io/channel-websock: handle continuous
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
Cc: den@openvz.org, berrange@redhat.com

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
---
 io/channel-websock.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 87ebdebfc0..1152715535 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -502,9 +502,12 @@ static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
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
2.11.0
