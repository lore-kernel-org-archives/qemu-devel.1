Received: from eggs.gnu.org ([2001:4830:134:3::10]:46047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0alR-0001NG-RY
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 17:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0alR-0002QJ-2B
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 17:34:21 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 18 Apr 2017 16:34:04 -0500
Message-Id: <20170418213404.6455-1-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-7-eblake@redhat.com>
References: <20170418013356.3578-7-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v1.5 06.5/31] fixup! block: Convert
 bdrv_get_block_status() to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

[adjust a paragraph of the original commit message]
...
Note that we have an inherent limitation in the BDRV_BLOCK_* return
values: BDRV_BLOCK_OFFSET_VALID can only return the start of a
sector, even if we later relax the interface to query for the status
starting at an intermediate byte; document the obvious interpretation
that valid offsets are always sector-relative.  Furthermore, note that
many callers are expecting sector-aligned answers, especially since
bdrv_getlength() is sector-aligned even when it exceeds the actual
file size; so we intentionally lie and state that any partial sector
at the end of a file has the same status for the entire sector,
rather than a literal interpretation of a hole starting at a
mid-sector location due to end-of-file.
...

Signed-off-by: Eric Blake <eblake@redhat.com>
---

This was sufficient to avoid failure of qemu-iotests 109 after patch
13/31 adjusts file-posix.c to clamp EOF numbers to mid-sector locations.

 block/io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/io.c b/block/io.c
index 361eeb8..bee6c71 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1769,6 +1769,14 @@ static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
                                  bs->bl.request_alignment) - aligned_offset;
         ret = bs->drv->bdrv_co_block_status(bs, aligned_offset, aligned_bytes,
                                             &n, file);
+
+        /* total_size is always sector-aligned, by sometimes exceeding actual
+         * file size. Expand n if it lands mid-sector due to end-of-file. */
+        if (ret >= 0 && QEMU_ALIGN_UP(n + aligned_offset,
+                                      BDRV_SECTOR_SIZE) == total_size) {
+            n = total_size - aligned_offset;
+        }
+
         /* Clamp pnum and ret to original request */
         if (aligned_offset != offset && ret >= 0) {
             int sectors = DIV_ROUND_UP(offset, BDRV_SECTOR_SIZE) -
-- 
2.9.3
