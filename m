Received: from eggs.gnu.org ([2001:4830:134:3::10]:50007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQt-0006RL-AA
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQs-0002oE-Ed
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:31 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 24 Feb 2017 19:17:01 +0100
Message-Id: <1487960230-18054-11-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
References: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/19] qcow2: Use BB for resizing in
 qcow2_amend_options()
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

In order to able to convert bdrv_truncate() to take a BdrvChild and
later to correctly check the resize permission here, we need to use a
BlockBackend for resizing the image.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3e274bd..254545a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3250,7 +3250,11 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
     }
 
     if (new_size) {
-        ret = bdrv_truncate(bs, new_size);
+        BlockBackend *blk = blk_new();
+        blk_insert_bs(blk, bs);
+        ret = blk_truncate(blk, new_size);
+        blk_unref(blk);
+
         if (ret < 0) {
             return ret;
         }
-- 
1.8.3.1
