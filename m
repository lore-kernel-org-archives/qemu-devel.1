Received: from eggs.gnu.org ([2001:4830:134:3::10]:44525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4Bp9-0004kq-6c
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4Bp5-0000KF-UO
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:17:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e4Bp5-0000Ih-PB
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:17:15 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 16 Oct 2017 21:16:48 +0100
Message-Id: <20171016201650.18399-10-berrange@redhat.com>
In-Reply-To: <20171016201650.18399-1-berrange@redhat.com>
References: <20171016201650.18399-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 09/11] io: cope with websock 'Connection'
 header having multiple values
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

The noVNC server sends a header "Connection: keep-alive, Upgrade" which
fails our simple equality test. Split the header on ',', trim whitespace
and then check for 'upgrade' token.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index e82b1beab3..0354845e52 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -374,6 +374,9 @@ static void qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
     size_t nhdrs = G_N_ELEMENTS(hdrs);
     const char *protocols = NULL, *version = NULL, *key = NULL,
         *host = NULL, *connection = NULL, *upgrade = NULL;
+    char **connectionv;
+    bool upgraded = false;
+    size_t i;
 
     nhdrs = qio_channel_websock_extract_headers(ioc, buffer, hdrs, nhdrs, errp);
     if (!nhdrs) {
@@ -440,7 +443,16 @@ static void qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
         goto bad_request;
     }
 
-    if (strcasecmp(connection, QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE) != 0) {
+    connectionv = g_strsplit(connection, ",", 0);
+    for (i = 0; connectionv != NULL && connectionv[i] != NULL; i++) {
+        g_strstrip(connectionv[i]);
+        if (strcasecmp(connectionv[i],
+                       QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE) == 0) {
+            upgraded = true;
+        }
+    }
+    g_strfreev(connectionv);
+    if (!upgraded) {
         error_setg(errp, "No connection upgrade requested '%s'", connection);
         goto bad_request;
     }
-- 
2.13.5
