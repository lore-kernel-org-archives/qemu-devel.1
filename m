Received: from eggs.gnu.org ([2001:4830:134:3::10]:57125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cY9YT-0005kD-Dt
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cY9YQ-0002Xw-AI
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:51:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cY9YQ-0002VB-4a
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:51:22 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 30 Jan 2017 10:51:16 +0000
Message-Id: <20170130105116.29337-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] io: fix decoding when multiple websockets
 frames arrive at once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brian Rak <brak@gameservers.com>, "Daniel P. Berrange" <berrange@redhat.com>

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
