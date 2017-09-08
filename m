Received: from eggs.gnu.org ([2001:4830:134:3::10]:56371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqGYN-0005dQ-Pt
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqGYI-0006ej-CW
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:30:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqGYI-0006dr-7j
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:30:22 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  8 Sep 2017 11:30:11 +0100
Message-Id: <20170908103011.25821-4-berrange@redhat.com>
In-Reply-To: <20170908103011.25821-1-berrange@redhat.com>
References: <20170908103011.25821-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] io: use case insensitive check for
 Connection & Upgrade websock headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Brian Rak <brak@vultr.com>, "Daniel P. Berrange" <berrange@redhat.com>

When checking the value of the Connection and Upgrade HTTP headers
the websock RFC (6455) requires the comparison to be case insensitive.
The Connection value should be an exact match not a substring.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index aed7a6c9b3..ab332ec907 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -427,12 +427,12 @@ static void qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
         goto bad_request;
     }
 
-    if (!g_strrstr(connection, QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE)) {
+    if (strcasecmp(connection, QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE) != 0) {
         error_setg(errp, "No connection upgrade requested '%s'", connection);
         goto bad_request;
     }
 
-    if (!g_str_equal(upgrade, QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET)) {
+    if (strcasecmp(upgrade, QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET) != 0) {
         error_setg(errp, "Incorrect upgrade method '%s'", upgrade);
         goto bad_request;
     }
-- 
2.13.5
