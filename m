Received: from eggs.gnu.org ([2001:4830:134:3::10]:52825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqP-0001WE-DL
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqO-00033v-L1
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:49 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:33 +0100
Message-Id: <20180302185448.6314-23-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 22/37] block: fix write with zero flag set and
 iovector provided
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

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

The normal bdrv_co_pwritev() use is either
  - BDRV_REQ_ZERO_WRITE clear and iovector provided
  - BDRV_REQ_ZERO_WRITE set and iovector == NULL

while
  - the flag clear and iovector == NULL is an assertion failure
    in bdrv_co_do_zero_pwritev()
  - the flag set and iovector provided is in fact allowed
    (the flag prevails and zeroes are written)

However the alignment logic does not support the latter case so the padding
areas get overwritten with zeroes.

Currently, general functions like bdrv_rw_co() do provide iovector
regardless of flags. So, keep it supported and use bdrv_co_do_zero_pwritev()
alignment for it which also makes the code a bit more obvious anyway.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 4c3dba0973..4d3d1f640a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1701,7 +1701,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
      */
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_WRITE);
 
-    if (!qiov) {
+    if (flags & BDRV_REQ_ZERO_WRITE) {
         ret = bdrv_co_do_zero_pwritev(child, offset, bytes, flags, &req);
         goto out;
     }
-- 
2.13.6
