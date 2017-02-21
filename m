Received: from eggs.gnu.org ([2001:4830:134:3::10]:43968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBvc-0001Ye-4V
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBvX-00006S-8l
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:32 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:48 +0100
Message-Id: <1487689130-30373-53-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 52/54] block: Assertions for resize permission
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

This adds an assertion that ensures that the necessary resize permission
has been granted before bdrv_truncate() is called.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block.c b/block.c
index 560e84a..33e6415 100644
--- a/block.c
+++ b/block.c
@@ -3098,6 +3098,9 @@ int bdrv_truncate(BdrvChild *child, int64_t offset)
     BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
     int ret;
+
+    assert(child->perm & BLK_PERM_RESIZE);
+
     if (!drv)
         return -ENOMEDIUM;
     if (!drv->bdrv_truncate)
-- 
1.8.3.1
