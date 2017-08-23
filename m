Received: from eggs.gnu.org ([2001:4830:134:3::10]:48136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkYbW-0008QR-96
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkYbV-0005QV-BZ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:34:06 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 23 Aug 2017 11:33:44 -0500
Message-Id: <20170823163349.11663-2-eblake@redhat.com>
In-Reply-To: <20170823163349.11663-1-eblake@redhat.com>
References: <20170823163349.11663-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] block-backend: Refactor inactivate check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Fam Zheng <famz@redhat.com>

The logic will be fixed (extended), move it to a separate function.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170823134242.12080-2-famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/block-backend.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index e9798e897d..a3984d2bec 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -192,19 +192,28 @@ static void blk_root_activate(BdrvChild *child, Error **errp)
     }
 }

-static int blk_root_inactivate(BdrvChild *child)
+static bool blk_can_inactivate(BlockBackend *blk)
 {
-    BlockBackend *blk = child->opaque;
-
-    if (blk->disable_perm) {
-        return 0;
-    }
-
     /* Only inactivate BlockBackends for guest devices (which are inactive at
      * this point because the VM is stopped) and unattached monitor-owned
      * BlockBackends. If there is still any other user like a block job, then
      * we simply can't inactivate the image. */
-    if (!blk->dev && !blk_name(blk)[0]) {
+    if (blk->dev || blk_name(blk)[0]) {
+        return true;
+    }
+
+    return false;
+}
+
+static int blk_root_inactivate(BdrvChild *child)
+{
+    BlockBackend *blk = child->opaque;
+
+    if (blk->disable_perm) {
+        return 0;
+    }
+
+    if (!blk_can_inactivate(blk)) {
         return -EPERM;
     }

-- 
2.13.5
