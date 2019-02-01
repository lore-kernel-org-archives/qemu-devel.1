Received: from eggs.gnu.org ([209.51.188.92]:38595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gpYS9-0007TJ-ST
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gpYS6-0002xq-Jq
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:01:52 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  1 Feb 2019 16:01:35 +0300
Message-Id: <20190201130138.94525-4-vsementsov@virtuozzo.com>
In-Reply-To: <20190201130138.94525-1-vsementsov@virtuozzo.com>
References: <20190201130138.94525-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 3/6] block/nbd-client: split connection from
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com

Split connection code to reuse it for reconnect.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 641666d3bc..a8ce0824c2 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -1014,13 +1014,13 @@ static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
     return sioc;
 }
 
-int nbd_client_init(BlockDriverState *bs,
-                    SocketAddress *saddr,
-                    const char *export,
-                    QCryptoTLSCreds *tlscreds,
-                    const char *hostname,
-                    const char *x_dirty_bitmap,
-                    Error **errp)
+static int nbd_client_connect(BlockDriverState *bs,
+                              SocketAddress *saddr,
+                              const char *export,
+                              QCryptoTLSCreds *tlscreds,
+                              const char *hostname,
+                              const char *x_dirty_bitmap,
+                              Error **errp)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
     int ret;
@@ -1073,8 +1073,6 @@ int nbd_client_init(BlockDriverState *bs,
         bs->supported_zero_flags |= BDRV_REQ_MAY_UNMAP;
     }
 
-    qemu_co_mutex_init(&client->send_mutex);
-    qemu_co_queue_init(&client->free_sema);
     client->sioc = sioc;
 
     if (!client->ioc) {
@@ -1107,3 +1105,20 @@ int nbd_client_init(BlockDriverState *bs,
         return ret;
     }
 }
+
+int nbd_client_init(BlockDriverState *bs,
+                    SocketAddress *saddr,
+                    const char *export,
+                    QCryptoTLSCreds *tlscreds,
+                    const char *hostname,
+                    const char *x_dirty_bitmap,
+                    Error **errp)
+{
+    NBDClientSession *client = nbd_get_client_session(bs);
+
+    qemu_co_mutex_init(&client->send_mutex);
+    qemu_co_queue_init(&client->free_sema);
+
+    return nbd_client_connect(bs, saddr, export, tlscreds, hostname,
+                              x_dirty_bitmap, errp);
+}
-- 
2.18.0
