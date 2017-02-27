Received: from eggs.gnu.org ([2001:4830:134:3::10]:51004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLSz-0003zB-Td
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:35:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLSw-0007hB-0A
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:35:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ciLSv-0007h2-Qd
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:35:49 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 27 Feb 2017 13:35:29 +0000
Message-Id: <20170227133531.31874-2-berrange@redhat.com>
In-Reply-To: <20170227133531.31874-1-berrange@redhat.com>
References: <20170227133531.31874-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 1/3] io: fix decoding when multiple
 websockets frames arrive at once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The qio_channel_websock_read_wire() method will read upto 4096
bytes off the socket and then decode the websockets header and
payload. The code was only decoding a single websockets frame,
even if the buffered data contained multiple frames. This meant
that decoding of subsequent frames was delayed until further
input arrived on the socket. This backlog of delayed frames
gets worse & worse over time.

Symptom was that when connecting to the VNC server via the
built-in websockets server, mouse/keyboard interaction would
start out fine, but slowly get more & more delayed until it
was unusable.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index e47279a..a06a4a8 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -570,21 +570,24 @@ static ssize_t qio_channel_websock_read_wire(QIOChannelWebsock *ioc,
         ioc->encinput.offset += ret;
     }
 
-    if (ioc->payload_remain == 0) {
-        ret = qio_channel_websock_decode_header(ioc, errp);
+    while (ioc->encinput.offset != 0) {
+        if (ioc->payload_remain == 0) {
+            ret = qio_channel_websock_decode_header(ioc, errp);
+            if (ret < 0) {
+                return ret;
+            }
+            if (ret == 0) {
+                ioc->io_eof = TRUE;
+                break;
+            }
+        }
+
+        ret = qio_channel_websock_decode_payload(ioc, errp);
         if (ret < 0) {
             return ret;
         }
-        if (ret == 0) {
-            return 0;
-        }
     }
-
-    ret = qio_channel_websock_decode_payload(ioc, errp);
-    if (ret < 0) {
-        return ret;
-    }
-    return ret;
+    return 1;
 }
 
 
@@ -642,9 +645,6 @@ static gboolean qio_channel_websock_flush(QIOChannel *ioc,
         if (ret < 0) {
             goto cleanup;
         }
-        if (ret == 0) {
-            wioc->io_eof = TRUE;
-        }
     }
 
  cleanup:
-- 
2.9.3
