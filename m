Received: from eggs.gnu.org ([2001:4830:134:3::10]:32782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTqdV-00022H-9p
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTqdU-0004zo-CK
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:59:53 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Dec 2018 09:59:36 -0600
Message-Id: <20181203155936.114526-4-eblake@redhat.com>
In-Reply-To: <20181203155936.114526-1-eblake@redhat.com>
References: <20181203155936.114526-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] nbd/client: Send NBD_CMD_DISC if open fails
 after connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

If nbd_client_init() fails after we are already connected,
then the server will spam logs with:

Disconnect client, due to: Unexpected end-of-file before all bytes were read

unless we gracefully disconnect before closing the connection.

Ways to trigger this:

$ opts=driver=nbd,export=foo,server.type=inet,server.host=localhost,server.port=10809
$  qemu-img map --output=json --image-opts $opts,read-only=off
$  qemu-img map --output=json --image-opts $opts,x-dirty-bitmap=nosuch:

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181130023232.3079982-4-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index e6e27dafa6a..fc5b7eda8ee 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -995,12 +995,13 @@ int nbd_client_init(BlockDriverState *bs,
     if (x_dirty_bitmap && !client->info.base_allocation) {
         error_setg(errp, "requested x-dirty-bitmap %s not found",
                    x_dirty_bitmap);
-        return -EINVAL;
+        ret = -EINVAL;
+        goto fail;
     }
     if (client->info.flags & NBD_FLAG_READ_ONLY) {
         ret = bdrv_apply_auto_read_only(bs, "NBD export is read-only", errp);
         if (ret < 0) {
-            return ret;
+            goto fail;
         }
     }
     if (client->info.flags & NBD_FLAG_SEND_FUA) {
@@ -1029,4 +1030,17 @@ int nbd_client_init(BlockDriverState *bs,

     logout("Established connection with NBD server\n");
     return 0;
+
+ fail:
+    /*
+     * We have connected, but must fail for other reasons. The
+     * connection is still blocking; send NBD_CMD_DISC as a courtesy
+     * to the server.
+     */
+    {
+        NBDRequest request = { .type = NBD_CMD_DISC };
+
+        nbd_send_request(client->ioc ?: QIO_CHANNEL(sioc), &request);
+        return ret;
+    }
 }
-- 
2.17.2
