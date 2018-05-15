Received: from eggs.gnu.org ([2001:4830:134:3::10]:39069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4e-0006vx-FR
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4a-0001gR-Jf
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:12 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:23 +0200
Message-Id: <20180515154033.19899-28-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 27/37] block: Set BDRV_REQ_WRITE_UNCHANGED for
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20180421132929.21610-5-mreitz@redhat.com
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index 9e8449e795..ca96b487eb 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1118,13 +1118,15 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
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
2.13.6
