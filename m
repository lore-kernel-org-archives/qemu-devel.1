Received: from eggs.gnu.org ([2001:4830:134:3::10]:44825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fFiK5-0006Od-60
	for qemu-devel@nongnu.org; Mon, 07 May 2018 11:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fFiJz-0005pK-Jc
	for qemu-devel@nongnu.org; Mon, 07 May 2018 11:45:09 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  7 May 2018 18:44:56 +0300
Message-Id: <20180507154458.73945-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180507154458.73945-1-vsementsov@virtuozzo.com>
References: <20180507154458.73945-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/5] block/nbd-client: split connection from
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
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Split connection code to reuse it for reconnect.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 6ff505c4b8..14b42f31df 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -999,12 +999,12 @@ static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
     return sioc;
 }
 
-int nbd_client_init(BlockDriverState *bs,
-                    SocketAddress *saddr,
-                    const char *export,
-                    QCryptoTLSCreds *tlscreds,
-                    const char *hostname,
-                    Error **errp)
+static int nbd_client_connect(BlockDriverState *bs,
+                              SocketAddress *saddr,
+                              const char *export,
+                              QCryptoTLSCreds *tlscreds,
+                              const char *hostname,
+                              Error **errp)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
     int ret;
@@ -1048,8 +1048,6 @@ int nbd_client_init(BlockDriverState *bs,
         bs->supported_zero_flags |= BDRV_REQ_MAY_UNMAP;
     }
 
-    qemu_co_mutex_init(&client->send_mutex);
-    qemu_co_queue_init(&client->free_sema);
     client->sioc = sioc;
 
     if (!client->ioc) {
@@ -1066,3 +1064,18 @@ int nbd_client_init(BlockDriverState *bs,
     logout("Established connection with NBD server\n");
     return 0;
 }
+
+int nbd_client_init(BlockDriverState *bs,
+                    SocketAddress *saddr,
+                    const char *export,
+                    QCryptoTLSCreds *tlscreds,
+                    const char *hostname,
+                    Error **errp)
+{
+    NBDClientSession *client = nbd_get_client_session(bs);
+
+    qemu_co_mutex_init(&client->send_mutex);
+    qemu_co_queue_init(&client->free_sema);
+
+    return nbd_client_connect(bs, saddr, export, tlscreds, hostname, errp);
+}
-- 
2.11.1
