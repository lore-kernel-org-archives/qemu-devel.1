Received: from eggs.gnu.org ([209.51.188.92]:51095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqrrL-0000gP-4T
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:57:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqrrJ-0002p1-SB
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:57:18 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  4 Feb 2019 21:57:01 -0600
Message-Id: <20190205035704.26014-6-eblake@redhat.com>
In-Reply-To: <20190205035704.26014-1-eblake@redhat.com>
References: <20190205035704.26014-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/8] block/nbd-client: split connection from
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Split connection code to reuse it for reconnect.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190201130138.94525-4-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 80dc8cff473..d7d88297698 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -1012,13 +1012,13 @@ static QIOChannelSocket *nbd_establish_connection=
(SocketAddress *saddr,
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
     NBDClientSession *client =3D nbd_get_client_session(bs);
     int ret;
@@ -1071,8 +1071,6 @@ int nbd_client_init(BlockDriverState *bs,
         bs->supported_zero_flags |=3D BDRV_REQ_MAY_UNMAP;
     }

-    qemu_co_mutex_init(&client->send_mutex);
-    qemu_co_queue_init(&client->free_sema);
     client->sioc =3D sioc;

     if (!client->ioc) {
@@ -1105,3 +1103,20 @@ int nbd_client_init(BlockDriverState *bs,
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
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+
+    qemu_co_mutex_init(&client->send_mutex);
+    qemu_co_queue_init(&client->free_sema);
+
+    return nbd_client_connect(bs, saddr, export, tlscreds, hostname,
+                              x_dirty_bitmap, errp);
+}
--=20
2.20.1
