Received: from eggs.gnu.org ([2001:4830:134:3::10]:58423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9saO-0002sA-0C
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 09:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9saN-0000XJ-AK
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 09:29:52 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 21 Apr 2018 15:29:24 +0200
Message-Id: <20180421132929.21610-5-mreitz@redhat.com>
In-Reply-To: <20180421132929.21610-1-mreitz@redhat.com>
References: <20180421132929.21610-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/9] block: Set BDRV_REQ_WRITE_UNCHANGED for
 COR writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index 134b2a498f..fada4efbf3 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1115,13 +1115,15 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
                 /* FIXME: Should we (perhaps conditionally) be setting
                  * BDRV_REQ_MAY_UNMAP, if it will allow for a sparser copy
                  * that still correctly reads as zero? */
-                ret = bdrv_co_do_pwrite_zeroes(bs, cluster_offset, pnum, 0);
+                ret = bdrv_co_do_pwrite_zeroes(bs, cluster_offset, pnum,
+                                               BDRV_REQ_WRITE_UNCHANGED);
             } else {
                 /* This does not change the data on the disk, it is not
                  * necessary to flush even in cache=writethrough mode.
                  */
                 ret = bdrv_driver_pwritev(bs, cluster_offset, pnum,
-                                          &local_qiov, 0);
+                                          &local_qiov,
+                                          BDRV_REQ_WRITE_UNCHANGED);
             }
 
             if (ret < 0) {
-- 
2.14.3
