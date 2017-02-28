Received: from eggs.gnu.org ([2001:4830:134:3::10]:45827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioXK-0006o4-IR
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:38:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioXJ-0008BI-MD
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:38:18 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 21:36:43 +0100
Message-Id: <1488314205-16264-45-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 44/46] block: Assertions for resize permission
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

This adds an assertion that ensures that the necessary resize permission
has been granted before bdrv_truncate() is called.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
---
 block.c    | 3 +++
 block/io.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/block.c b/block.c
index 79d9ad0..74ac7dc 100644
--- a/block.c
+++ b/block.c
@@ -3122,6 +3122,9 @@ int bdrv_truncate(BdrvChild *child, int64_t offset)
     BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
     int ret;
+
+    assert(child->perm & BLK_PERM_RESIZE);
+
     if (!drv)
         return -ENOMEDIUM;
     if (!drv->bdrv_truncate)
diff --git a/block/io.c b/block/io.c
index 4c79745..8f38d46 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1339,6 +1339,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     assert(req->overlap_offset <= offset);
     assert(offset + bytes <= req->overlap_offset + req->overlap_bytes);
     assert(child->perm & BLK_PERM_WRITE);
+    assert(end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE);
 
     ret = notifier_with_return_list_notify(&bs->before_write_notifiers, req);
 
-- 
1.8.3.1
