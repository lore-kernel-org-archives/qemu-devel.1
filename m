Received: from eggs.gnu.org ([2001:4830:134:3::10]:60998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTqdU-00020U-DP
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTqdS-0004ys-P3
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:59:52 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Dec 2018 09:59:35 -0600
Message-Id: <20181203155936.114526-3-eblake@redhat.com>
In-Reply-To: <20181203155936.114526-1-eblake@redhat.com>
References: <20181203155936.114526-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] nbd/client: Make x-dirty-bitmap more
 reliable
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

The implementation of x-dirty-bitmap in qemu 3.0 (commit 216ee365)
silently falls back to treating the server as not supporting
NBD_CMD_BLOCK_STATUS if a requested meta_context name was not
negotiated, which in turn means treating the _entire_ image as
data. Since our hack relied on using 'qemu-img map' to view
which portions of the image were dirty by seeing what the
redirected bdrv_block_status() treats as holes, this means
that our fallback treats the entire image as clean.  Better
would have been to treat the entire image as dirty, or to fail
to connect because the user's request for a specific context
could not be honored. This patch goes with the latter.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181130023232.3079982-3-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 76e9ca3abeb..e6e27dafa6a 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -992,6 +992,11 @@ int nbd_client_init(BlockDriverState *bs,
         logout("Failed to negotiate with the NBD server\n");
         return ret;
     }
+    if (x_dirty_bitmap && !client->info.base_allocation) {
+        error_setg(errp, "requested x-dirty-bitmap %s not found",
+                   x_dirty_bitmap);
+        return -EINVAL;
+    }
     if (client->info.flags & NBD_FLAG_READ_ONLY) {
         ret = bdrv_apply_auto_read_only(bs, "NBD export is read-only", errp);
         if (ret < 0) {
-- 
2.17.2
