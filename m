Received: from eggs.gnu.org ([2001:4830:134:3::10]:36930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTs-0001Ue-9P
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTo-0004Et-48
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:44 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 31 Jul 2018 20:30:26 +0300
Message-Id: <20180731173033.75467-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-1-vsementsov@virtuozzo.com>
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 03/10] block/nbd-client: split connection
 from initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Split connection code to reuse it for reconnect.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index a0d8f2523e..a1813cbfe1 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -999,13 +999,13 @@ static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
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
@@ -1051,8 +1051,6 @@ int nbd_client_init(BlockDriverState *bs,
         bs->supported_zero_flags |= BDRV_REQ_MAY_UNMAP;
     }
 
-    qemu_co_mutex_init(&client->send_mutex);
-    qemu_co_queue_init(&client->free_sema);
     client->sioc = sioc;
 
     if (!client->ioc) {
@@ -1069,3 +1067,20 @@ int nbd_client_init(BlockDriverState *bs,
     logout("Established connection with NBD server\n");
     return 0;
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
2.11.1
