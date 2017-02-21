Received: from eggs.gnu.org ([2001:4830:134:3::10]:42477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuH-00081e-2m
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuG-0007jp-Ez
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:09 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:57:58 +0100
Message-Id: <1487689130-30373-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 02/54] qcow2: Use BB for resizing in
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
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

In order to able to conver bdrv_truncate() to take a BdrvChild and
later to correctly check the resize permission here, we need to use a
BlockBackend for resizing the image.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
