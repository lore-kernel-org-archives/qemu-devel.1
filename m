Received: from eggs.gnu.org ([2001:4830:134:3::10]:39942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2J5x-0004FW-T9
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2J5t-0005Fk-0Y
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:38:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2J5s-0005F6-QV
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:38:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E95983D0A
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 15:38:46 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 11 Oct 2017 16:38:43 +0100
Message-Id: <20171011153843.9876-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] io: fix mem leak in websock error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Coverity pointed out the 'date' is not free()d in the error
path

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index aa35ef3274..a1c10ab719 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -355,6 +355,7 @@ static void qio_channel_websock_handshake_send_res_ok(QIOChannelWebsock *ioc,
                             QIO_CHANNEL_WEBSOCK_GUID_LEN,
                             &accept,
                             errp) < 0) {
+        g_free(date);
         qio_channel_websock_handshake_send_res_err(
             ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_SERVER_ERR);
         return;
-- 
2.13.5
