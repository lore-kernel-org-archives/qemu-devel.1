Received: from eggs.gnu.org ([2001:4830:134:3::10]:47814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1dxwiW-0001vE-MS
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1dxwiT-0002pt-KH
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:56:40 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:11304 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1dxwiT-0002oS-8X
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:56:37 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Fri, 29 Sep 2017 17:56:29 +0300
Message-Id: <20170929145629.14766-1-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/1] websock: treat upgrade header in case
 insensitive way
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, "Daniel P . Berrange" <berrange@redhat.com>
List-ID: <qemu-devel.nongnu.org>

According to rfc6455 section 4.2.1. Reading the Client's Opening Handshake
  An |Upgrade| header field containing the value "websocket",
  treated as an ASCII case-insensitive value.

Current implementation in QEMU accepts this header in lower-case only,
which is revealed to have broken some real-life clients. We need to
convert the value of this header to lower case before comparison.
Unfortunately we can not do that for all headers. Only this specific one
should be converted this way.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 5a3badbec2..d925f0a275 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -123,6 +123,14 @@ enum {
     QIO_CHANNEL_WEBSOCK_OPCODE_PONG = 0xA
 };
 
+static void str_tolower(char *buffer)
+{
+    char *tmp;
+    for (tmp = buffer; *tmp; tmp++) {
+        *tmp = g_ascii_tolower(*tmp);
+    }
+}
+
 static size_t
 qio_channel_websock_extract_headers(char *buffer,
                                     QIOChannelWebsockHTTPHeader *hdrs,
@@ -221,9 +229,7 @@ qio_channel_websock_extract_headers(char *buffer,
         hdr->value = sep;
 
         /* Canonicalize header name for easier identification later */
-        for (tmp = hdr->name; *tmp; tmp++) {
-            *tmp = g_ascii_tolower(*tmp);
-        }
+        str_tolower(hdr->name);
 
         if (nl) {
             buffer = nl + strlen(QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
@@ -233,7 +239,7 @@ qio_channel_websock_extract_headers(char *buffer,
     return nhdrs;
 }
 
-static const char *
+static char *
 qio_channel_websock_find_header(QIOChannelWebsockHTTPHeader *hdrs,
                                 size_t nhdrs,
                                 const char *name)
@@ -291,7 +297,7 @@ static int qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
 {
     QIOChannelWebsockHTTPHeader hdrs[32];
     size_t nhdrs = G_N_ELEMENTS(hdrs);
-    const char *protocols = NULL, *version = NULL, *key = NULL,
+    char *protocols = NULL, *version = NULL, *key = NULL,
         *host = NULL, *connection = NULL, *upgrade = NULL;
 
     nhdrs = qio_channel_websock_extract_headers(buffer, hdrs, nhdrs, errp);
@@ -340,6 +346,7 @@ static int qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
         error_setg(errp, "Missing websocket upgrade header data");
         return -1;
     }
+    str_tolower(upgrade);
 
     if (!g_strrstr(protocols, QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY)) {
         error_setg(errp, "No '%s' protocol is supported by client '%s'",
-- 
2.11.0
