Received: from eggs.gnu.org ([2001:4830:134:3::10]:52977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkVvv-0004IQ-KW
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkVvu-0001wq-PU
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:42:59 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 23 Aug 2017 21:42:39 +0800
Message-Id: <20170823134242.12080-2-famz@redhat.com>
In-Reply-To: <20170823134242.12080-1-famz@redhat.com>
References: <20170823134242.12080-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 1/4] block-backend: Refactor
 inactivate check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

The logic will be fixed (extended), move it to a separete function.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index e9798e897d..a3984d2bec 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -192,6 +192,19 @@ static void blk_root_activate(BdrvChild *child, Error **errp)
     }
 }
 
+static bool blk_can_inactivate(BlockBackend *blk)
+{
+    /* Only inactivate BlockBackends for guest devices (which are inactive at
+     * this point because the VM is stopped) and unattached monitor-owned
+     * BlockBackends. If there is still any other user like a block job, then
+     * we simply can't inactivate the image. */
+    if (blk->dev || blk_name(blk)[0]) {
+        return true;
+    }
+
+    return false;
+}
+
 static int blk_root_inactivate(BdrvChild *child)
 {
     BlockBackend *blk = child->opaque;
@@ -200,11 +213,7 @@ static int blk_root_inactivate(BdrvChild *child)
         return 0;
     }
 
-    /* Only inactivate BlockBackends for guest devices (which are inactive at
-     * this point because the VM is stopped) and unattached monitor-owned
-     * BlockBackends. If there is still any other user like a block job, then
-     * we simply can't inactivate the image. */
-    if (!blk->dev && !blk_name(blk)[0]) {
+    if (!blk_can_inactivate(blk)) {
         return -EPERM;
     }
 
-- 
2.13.5
