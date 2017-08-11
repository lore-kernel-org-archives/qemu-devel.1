Received: from eggs.gnu.org ([2001:4830:134:3::10]:60453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfzq0-00067O-23
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 22:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfzpz-00056y-0f
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 22:38:12 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 10 Aug 2017 21:37:57 -0500
Message-Id: <20170811023759.26390-2-eblake@redhat.com>
In-Reply-To: <20170811023759.26390-1-eblake@redhat.com>
References: <20170811023759.26390-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] nbd: Drop connection if broken server is
 detected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

As soon as the server is sending us garbage, we should quit
trying to send further messages to the server, and allow all
pending coroutines for any remaining replies to error out.
Failure to do so can let a malicious server cause the client
to hang, for example, if the server sends an invalid magic
number in its response.

Reported by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 25dd28406b..802d50b636 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -68,7 +68,8 @@ static void nbd_teardown_connection(BlockDriverState *bs)

 static coroutine_fn void nbd_read_reply_entry(void *opaque)
 {
-    NBDClientSession *s = opaque;
+    BlockDriverState *bs = opaque;
+    NBDClientSession *s = nbd_get_client_session(bs);
     uint64_t i;
     int ret;
     Error *local_err = NULL;
@@ -107,8 +108,12 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
         qemu_coroutine_yield();
     }

+    s->reply.handle = 0;
     nbd_recv_coroutines_enter_all(s);
     s->read_reply_co = NULL;
+    if (ret < 0) {
+        nbd_teardown_connection(bs);
+    }
 }

 static int nbd_co_send_request(BlockDriverState *bs,
@@ -416,7 +421,7 @@ int nbd_client_init(BlockDriverState *bs,
     /* Now that we're connected, set the socket to be non-blocking and
      * kick the reply mechanism.  */
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    client->read_reply_co = qemu_coroutine_create(nbd_read_reply_entry, client);
+    client->read_reply_co = qemu_coroutine_create(nbd_read_reply_entry, bs);
     nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));

     logout("Established connection with NBD server\n");
-- 
2.13.4
