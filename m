Received: from eggs.gnu.org ([2001:4830:134:3::10]:59310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eGmnl-0003bm-Oq
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eGmnk-0004dX-Um
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:11:57 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 20 Nov 2017 15:11:40 +0100
Message-Id: <20171120141141.24626-2-kwolf@redhat.com>
In-Reply-To: <20171120141141.24626-1-kwolf@redhat.com>
References: <20171120141141.24626-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 1/2] block: Don't use
 BLK_PERM_CONSISTENT_READ for format probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

For format probing, we don't really care whether all of the image
content is consistent. The only thing we're looking at is the image
header, and specifically the magic numbers that are expected to never
change, no matter how inconsistent the guest visible disk content is.

Therefore, don't request BLK_PERM_CONSISTENT_READ. This allows to use
format probing, e.g. in the context of 'qemu-img info', even while the
guest visible data in the image is inconsistent during a running block
job.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 6c8ef98dfa..68b724206d 100644
--- a/block.c
+++ b/block.c
@@ -2579,7 +2579,10 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
             goto fail;
         }
         if (file_bs != NULL) {
-            file = blk_new(BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
+            /* Not requesting BLK_PERM_CONSISTENT_READ because we're only
+             * looking at the header to guess the image format. This works even
+             * in cases where a guest would not see a consistent state. */
+            file = blk_new(0, BLK_PERM_ALL);
             blk_insert_bs(file, file_bs, &local_err);
             bdrv_unref(file_bs);
             if (local_err) {
-- 
2.13.6
