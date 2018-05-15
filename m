Received: from eggs.gnu.org ([2001:4830:134:3::10]:39217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4l-00075H-Dh
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4k-0001t3-Bn
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:30 +0200
Message-Id: <20180515154033.19899-35-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 34/37] block: Document BDRV_REQ_WRITE_UNCHANGED
 support
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

From: Max Reitz <mreitz@redhat.com>

Add BDRV_REQ_WRITE_UNCHANGED to the list of flags honored during pwrite
and pwrite_zeroes, and also add a note on when you absolutely need to
support it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180502140359.18222-1-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index e3d6219f4e..76b589da57 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -656,10 +656,24 @@ struct BlockDriverState {
     /* I/O Limits */
     BlockLimits bl;
 
-    /* Flags honored during pwrite (so far: BDRV_REQ_FUA) */
+    /* Flags honored during pwrite (so far: BDRV_REQ_FUA,
+     * BDRV_REQ_WRITE_UNCHANGED).
+     * If a driver does not support BDRV_REQ_WRITE_UNCHANGED, those
+     * writes will be issued as normal writes without the flag set.
+     * This is important to note for drivers that do not explicitly
+     * request a WRITE permission for their children and instead take
+     * the same permissions as their parent did (this is commonly what
+     * block filters do).  Such drivers have to be aware that the
+     * parent may have taken a WRITE_UNCHANGED permission only and is
+     * issuing such requests.  Drivers either must make sure that
+     * these requests do not result in plain WRITE accesses (usually
+     * by supporting BDRV_REQ_WRITE_UNCHANGED, and then forwarding
+     * every incoming write request as-is, including potentially that
+     * flag), or they have to explicitly take the WRITE permission for
+     * their children. */
     unsigned int supported_write_flags;
     /* Flags honored during pwrite_zeroes (so far: BDRV_REQ_FUA,
-     * BDRV_REQ_MAY_UNMAP) */
+     * BDRV_REQ_MAY_UNMAP, BDRV_REQ_WRITE_UNCHANGED) */
     unsigned int supported_zero_flags;
 
     /* the following member gives a name to every node on the bs graph. */
-- 
2.13.6
