Received: from eggs.gnu.org ([2001:4830:134:3::10]:44180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d9BhB-0004bg-Fb
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d9BhA-0004jm-Mg
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:37:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d9BhA-0004jY-GK
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:37:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 12 May 2017 10:37:16 -0400
Message-Id: <20170512143717.30391-3-stefanha@redhat.com>
In-Reply-To: <20170512143717.30391-1-stefanha@redhat.com>
References: <20170512143717.30391-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 2/3] block: Simplify BDRV_BLOCK_RAW
 recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Eric Blake <eblake@redhat.com>

Since we are already in coroutine context during the body of
bdrv_co_get_block_status(), we can shave off a few layers of
wrappers when recursing to query the protocol when a format driver
returned BDRV_BLOCK_RAW.

Note that we are already using the correct recursion later on in
the same function, when probing whether the protocol layer is sparse
in order to find out if we can add BDRV_BLOCK_ZERO to an existing
BDRV_BLOCK_DATA|BDRV_BLOCK_OFFSET_VALID.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20170504173745.27414-1-eblake@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
