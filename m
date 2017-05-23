Received: from eggs.gnu.org ([2001:4830:134:3::10]:46663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dD7ux-0000AY-Ew
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dD7us-0000Ho-Go
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:23:59 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 23 May 2017 13:22:56 +0200
Message-Id: <504d7d07c4227d4615b72f46deb34ba77efbea2c.1495536228.git.berto@igalia.com>
In-Reply-To: <cover.1495536228.git.berto@igalia.com>
References: <cover.1495536228.git.berto@igalia.com>
In-Reply-To: <cover.1495536228.git.berto@igalia.com>
References: <cover.1495536228.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/7] qcow2: Remove unused Error in
 do_perform_cow()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>

qcow2_encrypt_sectors() does not need an Error parameter, and we're
not checking its value anyway, so we can safely remove it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 347d94b0d2..3dc170e421 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -440,16 +440,14 @@ static int coroutine_fn do_perform_cow(BlockDriverState *bs,
     }
 
     if (bs->encrypted) {
-        Error *err = NULL;
         int64_t sector = (src_cluster_offset + offset_in_cluster)
                          >> BDRV_SECTOR_BITS;
         assert(s->cipher);
         assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
         assert((bytes & ~BDRV_SECTOR_MASK) == 0);
         if (qcow2_encrypt_sectors(s, sector, iov.iov_base, iov.iov_base,
-                                  bytes >> BDRV_SECTOR_BITS, true, &err) < 0) {
+                                  bytes >> BDRV_SECTOR_BITS, true, NULL) < 0) {
             ret = -EIO;
-            error_free(err);
             goto out;
         }
     }
-- 
2.11.0
