Received: from eggs.gnu.org ([2001:4830:134:3::10]:52838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKO-0000JX-9u
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKN-0007WW-7L
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:20 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 18 Jul 2017 16:17:46 +0200
Message-Id: <1500387486-5469-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
References: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/21] commit: Add NULL check for overlay_bs
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

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/commit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/commit.c b/block/commit.c
index 1314360..5cc910f 100644
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
