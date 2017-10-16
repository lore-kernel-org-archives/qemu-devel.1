Received: from eggs.gnu.org ([2001:4830:134:3::10]:44558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4BpA-0004mY-Vb
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4BpA-0000NL-48
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:17:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21459)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e4Bp9-0000Mx-UO
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:17:20 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 16 Oct 2017 21:16:50 +0100
Message-Id: <20171016201650.18399-12-berrange@redhat.com>
In-Reply-To: <20171016201650.18399-1-berrange@redhat.com>
References: <20171016201650.18399-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 11/11] io: fix mem leak in websock error path
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

Coverity pointed out the 'date' is not free()d in the error
path

Reviewed-by: Eric Blake <eblake@redhat.com>
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
