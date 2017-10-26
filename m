Received: from eggs.gnu.org ([2001:4830:134:3::10]:59134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3i-0000uL-Di
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3d-0002Lu-OH
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:54 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:30 +0200
Message-Id: <20171026131741.5059-25-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 24/35] block: Reduce bdrv_aligned_preadv()
 rounding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Now that bdrv_is_allocated accepts non-aligned inputs, we can
remove the TODO added in commit d6a644bb.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/io.c b/block/io.c
index d2cb20d872..3d5ef2cabe 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1124,18 +1124,14 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
     }
 
     if (flags & BDRV_REQ_COPY_ON_READ) {
-        /* TODO: Simplify further once bdrv_is_allocated no longer
-         * requires sector alignment */
-        int64_t start = QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
-        int64_t end = QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE);
         int64_t pnum;
 
-        ret = bdrv_is_allocated(bs, start, end - start, &pnum);
+        ret = bdrv_is_allocated(bs, offset, bytes, &pnum);
         if (ret < 0) {
             goto out;
         }
 
-        if (!ret || pnum != end - start) {
+        if (!ret || pnum != bytes) {
             ret = bdrv_co_do_copy_on_readv(child, offset, bytes, qiov);
             goto out;
         }
-- 
2.13.6
