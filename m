Received: from eggs.gnu.org ([2001:4830:134:3::10]:33284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cYBsL-0001Ap-5U
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:20:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cYBsF-000107-Ur
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:20:05 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:38666 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cYBsF-0000zf-Jf
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:19:59 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Mon, 30 Jan 2017 16:19:56 +0300
Message-Id: <1485782396-22341-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/1] io: ignore case in WebSocket HTTP header
 #PSBM-57554
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, "Daniel P . Berrange" <berrange@redhat.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

According to RFC7230 Section 3.2, header field name is case-insensitive.

The haystack string length is limited by 4096 bytes by
qio_channel_websock_handshake_read().

Further, handshake_process() dups and NULL-terminates the string
so it is safe to call non length-limited functions like strcasestr().

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index d5a4ed3..991925a 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -108,18 +108,16 @@ enum {
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
@@ -170,12 +168,14 @@ static int qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
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
@@ -213,6 +213,7 @@ static int qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
     ret = qio_channel_websock_handshake_send_response(ioc, key, errp);
 
  cleanup:
+    g_free(handshake);
     g_free(protocols);
     g_free(version);
     g_free(key);
@@ -248,10 +249,12 @@ static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
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
2.7.4
