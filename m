Received: from eggs.gnu.org ([2001:4830:134:3::10]:47564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1wh6-0002bz-Fu
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1wh5-00030g-Hs
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:43:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e1wh5-0002zu-8z
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:43:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47D725F2965
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 15:43:42 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 10 Oct 2017 16:43:23 +0100
Message-Id: <20171010154328.8419-3-berrange@redhat.com>
In-Reply-To: <20171010154328.8419-1-berrange@redhat.com>
References: <20171010154328.8419-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/7] io: simplify websocket ping reply
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We must ensure we don't get flooded with ping replies if the outbound
channel is slow. Currently we do this by keeping the ping reply in a
separate temporary buffer and only writing it if the encoutput buffer
is completely empty. This is overly pessimistic, as it is reasonable
to add a ping reply to the encoutput buffer even if it has previous
data in it, as long as that previous data doesn't include a ping
reply.

To track this better, put the ping reply directly into the encoutput
buffer, and then record the size of encoutput at this time in
ping_remain. As we write encoutput to the underlying channel, we
can decrement the ping_remain counter. Once it hits zero, we can
accept further ping replies for transmission.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/io/channel-websock.h |  2 +-
 io/channel-websock.c         | 28 +++++++++++++++-------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/io/channel-websock.h b/include/io/channel-websock.h
index ff32d8651b..3f92535cae 100644
--- a/include/io/channel-websock.h
+++ b/include/io/channel-websock.h
@@ -60,8 +60,8 @@ struct QIOChannelWebsock {
     Buffer encoutput;
     Buffer rawinput;
     Buffer rawoutput;
-    Buffer ping_reply;
     size_t payload_remain;
+    size_t ping_remain;
     QIOChannelWebsockMask mask;
     guint io_tag;
     Error *io_err;
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 04bcc059cd..1c34f68012 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -825,11 +825,14 @@ static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
         }
         return -1;
     } else if (ioc->opcode == QIO_CHANNEL_WEBSOCK_OPCODE_PING) {
-        /* ping frames produce an immediate reply */
-        buffer_reset(&ioc->ping_reply);
-        qio_channel_websock_encode_buffer(
-            ioc, &ioc->ping_reply, QIO_CHANNEL_WEBSOCK_OPCODE_PONG,
-            &ioc->encinput);
+        /* ping frames produce an immediate reply, as long as we've not still
+         * got a previous ping queued, in which case we drop the new pong */
+        if (ioc->ping_remain == 0) {
+            qio_channel_websock_encode_buffer(
+                ioc, &ioc->encoutput, QIO_CHANNEL_WEBSOCK_OPCODE_PONG,
+                &ioc->encinput);
+            ioc->ping_remain = ioc->encoutput.offset;
+        }
     }   /* pong frames are ignored */
 
     if (payload_len) {
@@ -888,7 +891,6 @@ static void qio_channel_websock_finalize(Object *obj)
     buffer_free(&ioc->encoutput);
     buffer_free(&ioc->rawinput);
     buffer_free(&ioc->rawoutput);
-    buffer_free(&ioc->ping_reply);
     object_unref(OBJECT(ioc->master));
     if (ioc->io_tag) {
         g_source_remove(ioc->io_tag);
@@ -946,12 +948,7 @@ static ssize_t qio_channel_websock_write_wire(QIOChannelWebsock *ioc,
     ssize_t ret;
     ssize_t done = 0;
 
-    /* ping replies take priority over binary data */
-    if (!ioc->ping_reply.offset) {
-        qio_channel_websock_encode(ioc);
-    } else if (!ioc->encoutput.offset) {
-        buffer_move_empty(&ioc->encoutput, &ioc->ping_reply);
-    }
+    qio_channel_websock_encode(ioc);
 
     while (ioc->encoutput.offset > 0) {
         ret = qio_channel_write(ioc->master,
@@ -968,6 +965,11 @@ static ssize_t qio_channel_websock_write_wire(QIOChannelWebsock *ioc,
         }
         buffer_advance(&ioc->encoutput, ret);
         done += ret;
+        if (ioc->ping_remain < ret) {
+            ioc->ping_remain = 0;
+        } else {
+            ioc->ping_remain -= ret;
+        }
     }
     return done;
 }
@@ -1026,7 +1028,7 @@ static void qio_channel_websock_set_watch(QIOChannelWebsock *ioc)
         return;
     }
 
-    if (ioc->encoutput.offset || ioc->ping_reply.offset) {
+    if (ioc->encoutput.offset) {
         cond |= G_IO_OUT;
     }
     if (ioc->encinput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER &&
-- 
2.13.5
