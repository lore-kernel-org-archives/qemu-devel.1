Received: from eggs.gnu.org ([2001:4830:134:3::10]:39053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6KhR-0006mi-Mg
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6KhQ-0007Q3-Po
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:37:57 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  4 May 2017 12:37:45 -0500
Message-Id: <20170504173745.27414-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Simplify BDRV_BLOCK_RAW recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

Since we are already in coroutine context during the body of
bdrv_co_get_block_status(), we can shave off a few layers of
wrappers when recursing to query the protocol when a format driver
returned BDRV_BLOCK_RAW.

Note that we are already using the correct recursion later on in
the same function, when probing whether the protocol layer is sparse
in order to find out if we can add BDRV_BLOCK_ZERO to an existing
BDRV_BLOCK_DATA|BDRV_BLOCK_OFFSET_VALID.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index 40bd94f..fdd7485 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1784,8 +1784,8 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,

     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID);
-        ret = bdrv_get_block_status(*file, ret >> BDRV_SECTOR_BITS,
-                                    *pnum, pnum, file);
+        ret = bdrv_co_get_block_status(*file, ret >> BDRV_SECTOR_BITS,
+                                       *pnum, pnum, file);
         goto out;
     }

-- 
2.9.3
