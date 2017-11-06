Received: from eggs.gnu.org ([2001:4830:134:3::10]:60853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eBkgE-0003vA-4a
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:55:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eBkgA-0002Bm-3K
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:55:22 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  6 Nov 2017 17:55:00 +0100
Message-Id: <20171106165500.30278-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Fix error path in
 bdrv_backing_update_filename()
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

error_setg_errno() takes a positive errno code.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 684cb018da..f6415547fe 100644
--- a/block.c
+++ b/block.c
@@ -998,7 +998,7 @@ static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *base,
     ret = bdrv_change_backing_file(parent, filename,
                                    base->drv ? base->drv->format_name : "");
     if (ret < 0) {
-        error_setg_errno(errp, ret, "Could not update backing file link");
+        error_setg_errno(errp, -ret, "Could not update backing file link");
     }
 
     if (!(orig_flags & BDRV_O_RDWR)) {
-- 
2.13.6
