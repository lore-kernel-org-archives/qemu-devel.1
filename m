Received: from eggs.gnu.org ([2001:4830:134:3::10]:58794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2UU3-0003Cd-Ij
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 23:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2UU2-0007yx-ON
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 23:48:31 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 11 Oct 2017 22:47:19 -0500
Message-Id: <20171012034720.11947-24-eblake@redhat.com>
In-Reply-To: <20171012034720.11947-1-eblake@redhat.com>
References: <20171012034720.11947-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 23/24] qcow2: Relax is_zero() assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, Max Reitz <mreitz@redhat.com>

Now that bdrv_is_allocated accepts non-aligned inputs, we can
remove the TODO added in earlier refactoring.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v6: new patch [Kevin]
---
 block/qcow2.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 092a3cabdb..92cb9f9bfa 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3003,22 +3003,16 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
     int64_t nr;
     int res;
-    int64_t start;
-
-    /* TODO: Widening to sector boundaries should only be needed as
-     * long as we can't query finer granularity. */
-    start = QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
-    bytes = QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE) - start;

     /* Clamp to image length, before checking status of underlying sectors */
-    if (start + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) {
-        bytes = bs->total_sectors * BDRV_SECTOR_SIZE - start;
+    if (offset + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) {
+        bytes = bs->total_sectors * BDRV_SECTOR_SIZE - offset;
     }

     if (!bytes) {
         return true;
     }
-    res = bdrv_block_status_above(bs, NULL, start, bytes, &nr, NULL, NULL);
+    res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
     return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
 }

-- 
2.13.6
