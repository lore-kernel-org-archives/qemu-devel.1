Received: from eggs.gnu.org ([2001:4830:134:3::10]:45661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEb-0003BR-5k
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEX-0004Fw-I7
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:29 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 26 Mar 2018 16:35:57 +0200
Message-Id: <20180326143600.7724-17-kwolf@redhat.com>
In-Reply-To: <20180326143600.7724-1-kwolf@redhat.com>
References: <20180326143600.7724-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 16/19] vhdx: Require power-of-two block size on
 create
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

Images with a non-power-of-two block size are invalid and cannot be
opened. Reject such block sizes when creating an image.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
 block/vhdx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/vhdx.c b/block/vhdx.c
index d2c54b7891..6a5e48eb69 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1877,6 +1877,10 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
         error_setg_errno(errp, EINVAL, "Block size must be a multiple of 1 MB");
         return -EINVAL;
     }
+    if (!is_power_of_2(block_size)) {
+        error_setg(errp, "Block size must be a power of two");
+        return -EINVAL;
+    }
     if (block_size > VHDX_BLOCK_SIZE_MAX) {
         error_setg_errno(errp, EINVAL, "Block size must not exceed %d",
                          VHDX_BLOCK_SIZE_MAX);
-- 
2.13.6
