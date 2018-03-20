Received: from eggs.gnu.org ([2001:4830:134:3::10]:51747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLC0-0000N1-3U
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLBz-0000X1-9c
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:37:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 20 Mar 2018 18:36:29 +0100
Message-Id: <20180320173632.25480-10-kwolf@redhat.com>
In-Reply-To: <20180320173632.25480-1-kwolf@redhat.com>
References: <20180320173632.25480-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 09/12] vhdx: Require power-of-two
 block size on create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

Images with a non-power-of-two block size are invalid and cannot be
opened. Reject such block sizes when creating an image.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vhdx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/vhdx.c b/block/vhdx.c
index f1b97f4b49..ca211a3196 100644
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
