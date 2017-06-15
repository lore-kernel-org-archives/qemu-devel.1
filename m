Received: from eggs.gnu.org ([2001:4830:134:3::10]:49939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLaoR-0000RM-CW
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 15:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLaoO-0007Ey-SY
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 15:52:15 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 21:52:09 +0200
Message-Id: <20170615195209.17720-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] nbd: fix NBD over TLS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org

When attaching the NBD QIOChannel to an AioContext, the TLS channel should
be used, not the underlying socket channel.  This is because, trivially,
the TLS channel will be the one that we read/write to and thus the one
that will get the qio_channel_yield() call.

Fixes: ff82911cd3f69f028f2537825c9720ff78bc3f19
Cc: qemu-stable@nongnu.org
Cc: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/nbd-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 1e2952fdae..56eb0e2e16 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -352,14 +352,14 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
 void nbd_client_detach_aio_context(BlockDriverState *bs)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
-    qio_channel_detach_aio_context(QIO_CHANNEL(client->sioc));
+    qio_channel_detach_aio_context(QIO_CHANNEL(client->ioc));
 }
 
 void nbd_client_attach_aio_context(BlockDriverState *bs,
                                    AioContext *new_context)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
-    qio_channel_attach_aio_context(QIO_CHANNEL(client->sioc), new_context);
+    qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context);
     aio_co_schedule(new_context, client->read_reply_co);
 }
 
-- 
2.13.0
