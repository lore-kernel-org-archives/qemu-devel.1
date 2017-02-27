Received: from eggs.gnu.org ([2001:4830:134:3::10]:51016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLT1-00040e-MD
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLT0-0007jG-GA
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:35:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ciLT0-0007is-2o
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:35:54 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 27 Feb 2017 13:35:30 +0000
Message-Id: <20170227133531.31874-3-berrange@redhat.com>
In-Reply-To: <20170227133531.31874-1-berrange@redhat.com>
References: <20170227133531.31874-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 2/3] io: ignore case in WebSocket HTTP header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, "Daniel P . Berrange" <berrange@redhat.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

According to RFC7230 Section 3.2, header field name is case-insensitive.

The haystack string length is limited by 4096 bytes by
qio_channel_websock_handshake_read().

Further, handshake_process() dups and NULL-terminates the string
so it is safe to call non length-limited functions like strcasestr().

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index a06a4a8..0757775 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -109,18 +109,16 @@ enum {
 };
 
 static char *qio_channel_websock_handshake_entry(const char *handshake,
-                                                 size_t handshake_len,
                                                  const char *name)
 {
     char *begin, *end, *ret = NULL;
     char *line = g_strdup_printf("%s%s: ",
                                  QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM,
                                  name);
-    begin = g_strstr_len(handshake, handshake_len, line);
+    begin = strcasestr(handshake, line);
     if (begin != NULL) {
         begin += strlen(line);
-        end = g_strstr_len(begin, handshake_len - (begin - handshake),
-                QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
+        end = strstr(begin, QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
         if (end != NULL) {
             ret = g_strndup(begin, end - begin);
         }
@@ -171,12 +169,14 @@ static int qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
                                                  Error **errp)
 {
     int ret = -1;
+    /* make it NULL-terminated */
+    char *handshake = g_strndup(line, size);
     char *protocols = qio_channel_websock_handshake_entry(
-        line, size, QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL);
+        handshake, QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL);
     char *version = qio_channel_websock_handshake_entry(
-        line, size, QIO_CHANNEL_WEBSOCK_HEADER_VERSION);
+        handshake, QIO_CHANNEL_WEBSOCK_HEADER_VERSION);
     char *key = qio_channel_websock_handshake_entry(
-        line, size, QIO_CHANNEL_WEBSOCK_HEADER_KEY);
+        handshake, QIO_CHANNEL_WEBSOCK_HEADER_KEY);
 
     if (!protocols) {
         error_setg(errp, "Missing websocket protocol header data");
@@ -214,6 +214,7 @@ static int qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
     ret = qio_channel_websock_handshake_send_response(ioc, key, errp);
 
  cleanup:
+    g_free(handshake);
     g_free(protocols);
     g_free(version);
     g_free(key);
@@ -249,10 +250,12 @@ static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
         }
     }
 
-    if (qio_channel_websock_handshake_process(ioc,
-                                              (char *)ioc->encinput.buffer,
-                                              ioc->encinput.offset,
-                                              errp) < 0) {
+    if (qio_channel_websock_handshake_process(
+            ioc,
+            (char *)ioc->encinput.buffer,
+            handshake_end - (char *)ioc->encinput.buffer
+            + strlen(QIO_CHANNEL_WEBSOCK_HANDSHAKE_END),
+            errp) < 0) {
         return -1;
     }
 
-- 
2.9.3
