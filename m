Received: from eggs.gnu.org ([2001:4830:134:3::10]:49150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2dUo-00052V-Oz
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2dUl-0004bT-Cq
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:25:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2dUl-0004bE-6b
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:25:51 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 12 Oct 2017 14:25:46 +0100
Message-Id: <20171012132546.1741-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2] io: fix mem leak in websock error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>

Coverity pointed out the 'date' is not free()d in the error
path

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index aa35ef3274..df2c3a9f99 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -341,7 +341,7 @@ static void qio_channel_websock_handshake_send_res_ok(QIOChannelWebsock *ioc,
     char combined_key[QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN +
                       QIO_CHANNEL_WEBSOCK_GUID_LEN + 1];
     char *accept = NULL;
-    char *date = qio_channel_websock_date_str();
+    char *date = NULL;
 
     g_strlcpy(combined_key, key, QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN + 1);
     g_strlcat(combined_key, QIO_CHANNEL_WEBSOCK_GUID,
@@ -360,6 +360,7 @@ static void qio_channel_websock_handshake_send_res_ok(QIOChannelWebsock *ioc,
         return;
     }
 
+    date = qio_channel_websock_date_str();
     qio_channel_websock_handshake_send_res(
         ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK, date, accept);
 
-- 
2.13.5
