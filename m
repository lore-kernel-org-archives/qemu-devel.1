Received: from eggs.gnu.org ([2001:4830:134:3::10]:47388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUX8A-0007Ub-IO
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUX89-0000zW-TM
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:45:34 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 10 Jul 2017 13:45:25 +0200
Message-Id: <1499687125-22948-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] commit: Add NULL check for overlay_bs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

I can't see how overlay_bs could become NULL with the current code, but
other code in this function already checks it and we can make Coverity
happy with this check, so let's add it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/commit.c b/block/commit.c
index 774a8a5..50e7950 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -90,7 +90,9 @@ static void commit_complete(BlockJob *job, void *opaque)
 
     /* Make sure overlay_bs and top stay around until bdrv_set_backing_hd() */
     bdrv_ref(top);
-    bdrv_ref(overlay_bs);
+    if (overlay_bs) {
+        bdrv_ref(overlay_bs);
+    }
 
     /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
      * the normal backing chain can be restored. */
-- 
1.8.3.1
