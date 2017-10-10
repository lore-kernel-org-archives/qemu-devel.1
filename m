Received: from eggs.gnu.org ([2001:4830:134:3::10]:47623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1whB-0002fD-Fr
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1whA-00037o-HB
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:43:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e1whA-00037A-8n
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:43:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B9123C5D
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 15:43:47 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 10 Oct 2017 16:43:26 +0100
Message-Id: <20171010154328.8419-6-berrange@redhat.com>
In-Reply-To: <20171010154328.8419-1-berrange@redhat.com>
References: <20171010154328.8419-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 5/7] io: get rid of bounce buffering in
 websock write path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently most outbound I/O on the websock channel gets copied into the
rawoutput buffer, and then immediately copied again into the encoutput
buffer, with a header prepended. Now that qio_channel_websock_encode
accepts a struct iovec, we can trivially remove this bounce buffering
and write directly to encoutput.

In doing so, we also now correctly validate the encoutput size against
the QIO_CHANNEL_WEBSOCK_MAX_BUFFER limit.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/io/channel-websock.h |  1 -
 io/channel-websock.c         | 64 +++++++++++++++++++-------------------------
 2 files changed, 28 insertions(+), 37 deletions(-)

diff --git a/include/io/channel-websock.h b/include/io/channel-websock.h
index 3f92535cae..f2ac0fdad1 100644
--- a/include/io/channel-websock.h
+++ b/include/io/channel-websock.h
@@ -59,7 +59,6 @@ struct QIOChannelWebsock {
     Buffer encinput;
     Buffer encoutput;
     Buffer rawinput;
-    Buffer rawoutput;
     size_t payload_remain;
     size_t ping_remain;
     QIOChannelWebsockMask mask;
diff --git a/io/channel-websock.c b/io/channel-websock.c
index ad62dda479..455f5e322c 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -24,6 +24,7 @@
 #include "io/channel-websock.h"
 #include "crypto/hash.h"
 #include "trace.h"
+#include "qemu/iov.h"
 
 #include <time.h>
 
@@ -631,19 +632,22 @@ static ssize_t qio_channel_websock_write_wire(QIOChannelWebsock *, Error **);
 static void qio_channel_websock_write_close(QIOChannelWebsock *ioc,
                                             uint16_t code, const char *reason)
 {
-    struct iovec iov;
-    buffer_reserve(&ioc->rawoutput, 2 + (reason ? strlen(reason) : 0));
-    *(uint16_t *)(ioc->rawoutput.buffer + ioc->rawoutput.offset) =
-        cpu_to_be16(code);
-    ioc->rawoutput.offset += 2;
+    struct iovec iov[2] = {
+        { .iov_base = &code, .iov_len = sizeof(code) },
+    };
+    size_t niov = 1;
+    size_t size = iov[0].iov_len;
+
+    cpu_to_be16s(&code);
+
     if (reason) {
-        buffer_append(&ioc->rawoutput, reason, strlen(reason));
+        iov[1].iov_base = (void *)reason;
+        iov[1].iov_len = strlen(reason);
+        size += iov[1].iov_len;
+        niov++;
     }
-    iov.iov_base = ioc->rawoutput.buffer;
-    iov.iov_len = ioc->rawoutput.offset;
     qio_channel_websock_encode(ioc, QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE,
-                               &iov, 1, iov.iov_len);
-    buffer_reset(&ioc->rawoutput);
+                               iov, niov, size);
     qio_channel_websock_write_wire(ioc, NULL);
     qio_channel_shutdown(ioc->master, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
 }
@@ -891,7 +895,6 @@ static void qio_channel_websock_finalize(Object *obj)
     buffer_free(&ioc->encinput);
     buffer_free(&ioc->encoutput);
     buffer_free(&ioc->rawinput);
-    buffer_free(&ioc->rawoutput);
     object_unref(OBJECT(ioc->master));
     if (ioc->io_tag) {
         g_source_remove(ioc->io_tag);
@@ -1101,8 +1104,8 @@ static ssize_t qio_channel_websock_writev(QIOChannel *ioc,
                                           Error **errp)
 {
     QIOChannelWebsock *wioc = QIO_CHANNEL_WEBSOCK(ioc);
-    size_t i;
-    ssize_t done = 0;
+    ssize_t want = iov_size(iov, niov);
+    ssize_t avail;
     ssize_t ret;
 
     if (wioc->io_err) {
@@ -1115,32 +1118,21 @@ static ssize_t qio_channel_websock_writev(QIOChannel *ioc,
         return -1;
     }
 
-    for (i = 0; i < niov; i++) {
-        size_t want = iov[i].iov_len;
-        if ((want + wioc->rawoutput.offset) > QIO_CHANNEL_WEBSOCK_MAX_BUFFER) {
-            want = (QIO_CHANNEL_WEBSOCK_MAX_BUFFER - wioc->rawoutput.offset);
-        }
-        if (want == 0) {
-            goto done;
-        }
-
-        buffer_reserve(&wioc->rawoutput, want);
-        buffer_append(&wioc->rawoutput, iov[i].iov_base, want);
-        done += want;
-        if (want < iov[i].iov_len) {
-            break;
-        }
+    avail = wioc->encoutput.offset >= QIO_CHANNEL_WEBSOCK_MAX_BUFFER ?
+        0 : (QIO_CHANNEL_WEBSOCK_MAX_BUFFER - wioc->encoutput.offset);
+    if (want > avail) {
+        want = avail;
     }
 
- done:
-    if (wioc->rawoutput.offset) {
-        struct iovec iov = { .iov_base = wioc->rawoutput.buffer,
-                             .iov_len = wioc->rawoutput.offset };
+    if (want) {
         qio_channel_websock_encode(wioc,
                                    QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME,
-                                   &iov, 1, iov.iov_len);
-        buffer_reset(&wioc->rawoutput);
+                                   iov, niov, want);
     }
+
+    /* Even if want == 0, we'll try write_wire in case there's
+     * pending data we could usefully flush out
+     */
     ret = qio_channel_websock_write_wire(wioc, errp);
     if (ret < 0 &&
         ret != QIO_CHANNEL_ERR_BLOCK) {
@@ -1150,11 +1142,11 @@ static ssize_t qio_channel_websock_writev(QIOChannel *ioc,
 
     qio_channel_websock_set_watch(wioc);
 
-    if (done == 0) {
+    if (want == 0) {
         return QIO_CHANNEL_ERR_BLOCK;
     }
 
-    return done;
+    return want;
 }
 
 static int qio_channel_websock_set_blocking(QIOChannel *ioc,
-- 
2.13.5
