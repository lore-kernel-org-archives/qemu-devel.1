Received: from eggs.gnu.org ([209.51.188.92]:50415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTm-0004ZF-Nu
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTl-0003bQ-Mk
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:14 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 11 Apr 2019 20:27:03 +0300
Message-Id: <20190411172709.205032-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190411172709.205032-1-vsementsov@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v6 1/7] block/nbd-client: split connection_co
 start out of nbd_client_connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

nbd_client_connect is going to be used from connection_co, so, let's
refactor nbd_client_connect in advance, leaving io channel
configuration all in nbd_client_connect.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 790ecc1ee1..facf8f8099 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -1180,12 +1180,8 @@ static int nbd_client_connect(BlockDriverState *bs,
         object_ref(OBJECT(client->ioc));
     }
 
-    /* Now that we're connected, set the socket to be non-blocking and
-     * kick the reply mechanism.  */
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    client->connection_co = qemu_coroutine_create(nbd_connection_entry, client);
-    bdrv_inc_in_flight(bs);
-    nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
+    qio_channel_attach_aio_context(client->ioc, bdrv_get_aio_context(bs));
 
     logout("Established connection with NBD server\n");
     return 0;
@@ -1215,12 +1211,22 @@ int nbd_client_init(BlockDriverState *bs,
                     const char *x_dirty_bitmap,
                     Error **errp)
 {
+    int ret;
     NBDClientSession *client = nbd_get_client_session(bs);
 
     client->bs = bs;
     qemu_co_mutex_init(&client->send_mutex);
     qemu_co_queue_init(&client->free_sema);
 
-    return nbd_client_connect(bs, saddr, export, tlscreds, hostname,
-                              x_dirty_bitmap, errp);
+    ret = nbd_client_connect(bs, saddr, export, tlscreds, hostname,
+                             x_dirty_bitmap, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    client->connection_co = qemu_coroutine_create(nbd_connection_entry, client);
+    bdrv_inc_in_flight(bs);
+    aio_co_schedule(bdrv_get_aio_context(bs), client->connection_co);
+
+    return 0;
 }
-- 
2.18.0
