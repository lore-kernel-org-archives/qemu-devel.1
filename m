Received: from eggs.gnu.org ([2001:4830:134:3::10]:44159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oW-0003Og-Br
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oV-0008Nr-Fg
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 30 Jul 2018 17:09:54 +0200
Message-Id: <20180730150958.14607-10-kwolf@redhat.com>
In-Reply-To: <20180730150958.14607-1-kwolf@redhat.com>
References: <20180730150958.14607-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/13] block: Fix documentation for
 BDRV_REQ_MAY_UNMAP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

BDRV_REQ_MAY_UNMAP in a write_zeroes request does not only allow the
driver to unmap the blocks, but it actively requests that the blocks be
unmapped afterwards if at all possible.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index f85e3a6ed3..4e0871aaf9 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -43,11 +43,12 @@ typedef struct BlockFragInfo {
 typedef enum {
     BDRV_REQ_COPY_ON_READ       = 0x1,
     BDRV_REQ_ZERO_WRITE         = 0x2,
-    /* The BDRV_REQ_MAY_UNMAP flag is used to indicate that the block driver
-     * is allowed to optimize a write zeroes request by unmapping (discarding)
-     * blocks if it is guaranteed that the result will read back as
-     * zeroes. The flag is only passed to the driver if the block device is
-     * opened with BDRV_O_UNMAP.
+
+    /*
+     * The BDRV_REQ_MAY_UNMAP flag is used in write_zeroes requests to indicate
+     * that the block driver should unmap (discard) blocks if it is guaranteed
+     * that the result will read back as zeroes. The flag is only passed to the
+     * driver if the block device is opened with BDRV_O_UNMAP.
      */
     BDRV_REQ_MAY_UNMAP          = 0x4,
 
-- 
2.13.6
