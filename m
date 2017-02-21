Received: from eggs.gnu.org ([2001:4830:134:3::10]:43003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuf-0000Oy-HF
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBue-0007xo-FM
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:33 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:17 +0100
Message-Id: <1487689130-30373-22-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 21/54] block: Require .bdrv_child_perm() with
 child nodes
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

All block drivers that can have child nodes implement .bdrv_child_perm()
now. Make this officially a requirement by asserting that only drivers
without children can omit .bdrv_child_perm().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 6d1362e..1c5f211 100644
--- a/block.c
+++ b/block.c
@@ -1361,8 +1361,9 @@ static int bdrv_check_perm(BlockDriverState *bs, uint64_t cumulative_perms,
                                     cumulative_shared_perms, errp);
     }
 
-    /* Drivers may not have .bdrv_child_perm() */
+    /* Drivers that never have children can omit .bdrv_child_perm() */
     if (!drv->bdrv_child_perm) {
+        assert(QLIST_EMPTY(&bs->children));
         return 0;
     }
 
@@ -1421,8 +1422,9 @@ static void bdrv_set_perm(BlockDriverState *bs, uint64_t cumulative_perms,
         drv->bdrv_set_perm(bs, cumulative_perms, cumulative_shared_perms);
     }
 
-    /* Drivers may not have .bdrv_child_perm() */
+    /* Drivers that never have children can omit .bdrv_child_perm() */
     if (!drv->bdrv_child_perm) {
+        assert(QLIST_EMPTY(&bs->children));
         return;
     }
 
-- 
1.8.3.1
