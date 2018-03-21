Received: from eggs.gnu.org ([2001:4830:134:3::10]:59823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyhgA-00056r-LM
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyhg9-0001lR-Fk
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:37:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 21 Mar 2018 18:37:12 +0100
Message-Id: <20180321173714.14741-11-kwolf@redhat.com>
In-Reply-To: <20180321173714.14741-1-kwolf@redhat.com>
References: <20180321173714.14741-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 v2 10/12] vhdx: Don't use
 error_setg_errno() with constant errno
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

error_setg_errno() is meant for cases where we got an errno from the OS
that can add useful extra information to an error message. It's
pointless if we pass a constant errno, these cases should use plain
error_setg().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
 block/vhdx.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index ca211a3196..0e48179b81 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1822,7 +1822,7 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
     /* Validate options and set default values */
     image_size = vhdx_opts->size;
     if (image_size > VHDX_MAX_IMAGE_SIZE) {
-        error_setg_errno(errp, EINVAL, "Image size too large; max of 64TB");
+        error_setg(errp, "Image size too large; max of 64TB");
         return -EINVAL;
     }
 
@@ -1832,7 +1832,7 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
         log_size = vhdx_opts->log_size;
     }
     if (log_size < MiB || (log_size % MiB) != 0) {
-        error_setg_errno(errp, EINVAL, "Log size must be a multiple of 1 MB");
+        error_setg(errp, "Log size must be a multiple of 1 MB");
         return -EINVAL;
     }
 
@@ -1874,7 +1874,7 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
     }
 
     if (block_size < MiB || (block_size % MiB) != 0) {
-        error_setg_errno(errp, EINVAL, "Block size must be a multiple of 1 MB");
+        error_setg(errp, "Block size must be a multiple of 1 MB");
         return -EINVAL;
     }
     if (!is_power_of_2(block_size)) {
@@ -1882,8 +1882,7 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
         return -EINVAL;
     }
     if (block_size > VHDX_BLOCK_SIZE_MAX) {
-        error_setg_errno(errp, EINVAL, "Block size must not exceed %d",
-                         VHDX_BLOCK_SIZE_MAX);
+        error_setg(errp, "Block size must not exceed %d", VHDX_BLOCK_SIZE_MAX);
         return -EINVAL;
     }
 
-- 
2.13.6
