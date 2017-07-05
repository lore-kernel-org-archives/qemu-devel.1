Received: from eggs.gnu.org ([2001:4830:134:3::10]:46267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWX-0004Mj-Ks
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWU-0007PY-Bs
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:57 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:06 +0200
Message-Id: <1499238885-26161-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/42] nbd: fix NBD over TLS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

When attaching the NBD QIOChannel to an AioContext, the TLS channel should
be used, not the underlying socket channel.  This is because, trivially,
the TLS channel will be the one that we read/write to and thus the one
that will get the qio_channel_yield() call.

Fixes: ff82911cd3f69f028f2537825c9720ff78bc3f19
Cc: qemu-stable@nongnu.org
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Tested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/nbd-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 02e9281..208f907 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -345,14 +345,14 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
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
1.8.3.1
