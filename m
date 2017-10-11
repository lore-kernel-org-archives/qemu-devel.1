Received: from eggs.gnu.org ([2001:4830:134:3::10]:60421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2Dxw-0004q8-2u
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2Dxp-0001tr-Ml
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:10:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2Dxp-0001rj-EQ
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:10:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 334912C96CA
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 10:10:08 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 11 Oct 2017 11:09:55 +0100
Message-Id: <20171011100959.29326-4-berrange@redhat.com>
In-Reply-To: <20171011100959.29326-1-berrange@redhat.com>
References: <20171011100959.29326-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/7] io: get rid of
 qio_channel_websock_encode helper method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The qio_channel_websock_encode method is only used in one place,
everything else calls qio_channel_websock_encode_buffer directly.
It can also be pushed up a level into the qio_channel_websock_writev
method, since every other caller of qio_channel_websock_write_wire
has already filled encoutput.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 6083f74c9b..700f5bea22 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -616,18 +616,6 @@ static void qio_channel_websock_encode_buffer(QIOChannelWebsock *ioc,
 }
 
 
-static void qio_channel_websock_encode(QIOChannelWebsock *ioc)
-{
-    if (!ioc->rawoutput.offset) {
-        return;
-    }
-    qio_channel_websock_encode_buffer(
-        ioc, &ioc->encoutput, QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME,
-        &ioc->rawoutput);
-    buffer_reset(&ioc->rawoutput);
-}
-
-
 static ssize_t qio_channel_websock_write_wire(QIOChannelWebsock *, Error **);
 
 
@@ -948,8 +936,6 @@ static ssize_t qio_channel_websock_write_wire(QIOChannelWebsock *ioc,
     ssize_t ret;
     ssize_t done = 0;
 
-    qio_channel_websock_encode(ioc);
-
     while (ioc->encoutput.offset > 0) {
         ret = qio_channel_write(ioc->master,
                                 (char *)ioc->encoutput.buffer,
@@ -1134,6 +1120,12 @@ static ssize_t qio_channel_websock_writev(QIOChannel *ioc,
     }
 
  done:
+    if (ioc->rawoutput.offset) {
+        qio_channel_websock_encode_buffer(
+            ioc, &ioc->encoutput, QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME,
+            &ioc->rawoutput);
+        buffer_reset(&ioc->rawoutput);
+    }
     ret = qio_channel_websock_write_wire(wioc, errp);
     if (ret < 0 &&
         ret != QIO_CHANNEL_ERR_BLOCK) {
-- 
2.13.5
