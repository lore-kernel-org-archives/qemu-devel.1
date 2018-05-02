Received: from eggs.gnu.org ([2001:4830:134:3::10]:50510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDsMh-0007OA-Ky
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDsMb-00079y-Io
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:04:15 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  2 May 2018 16:03:59 +0200
Message-Id: <20180502140359.18222-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Document BDRV_REQ_WRITE_UNCHANGED
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

Add BDRV_REQ_WRITE_UNCHANGED to the list of flags honored during pwrite
and pwrite_zeroes, and also add a note on when you absolutely need to
support it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
I did not include a note on how this might be useful to protocol
drivers, because BDRV_REQ_WRITE_UNCHANGED requests will usually not end
up on the protocol level anyway.
(I suppose it would be possible in theory if a protocol driver reports a
 certain range as unallocated and the user installs a copy-on-read
 driver on top, but I think every protocol driver currently reports
 everything as allocated.)
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
2.14.3
