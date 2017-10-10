Received: from eggs.gnu.org ([2001:4830:134:3::10]:47640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1whC-0002gD-Mn
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1whB-00038S-Vz
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:43:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e1whB-000388-Q3
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:43:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CCDCD9D0FE
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 15:43:48 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 10 Oct 2017 16:43:27 +0100
Message-Id: <20171010154328.8419-7-berrange@redhat.com>
In-Reply-To: <20171010154328.8419-1-berrange@redhat.com>
References: <20171010154328.8419-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 6/7] io: cope with websock 'Connection'
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

The noVNC server sends a header "Connection: keep-alive, Upgrade" which
fails our simple equality test. Split the header on ',', trim whitespace
and then check for 'upgrade' token.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 455f5e322c..a21915881d 100644
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
