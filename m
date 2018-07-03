Received: from eggs.gnu.org ([2001:4830:134:3::10]:52669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faMm7-0008V2-Mk
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faMm6-00053t-P3
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:59:27 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  3 Jul 2018 16:59:14 +0200
Message-Id: <20180703145915.32607-5-kwolf@redhat.com>
In-Reply-To: <20180703145915.32607-1-kwolf@redhat.com>
References: <20180703145915.32607-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] block: Move two block permission constants
 to the relevant enum
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

From: Ari Sundholm <ari@tuxera.com>

This allows using the two constants outside of block.c, which will
happen in a subsequent patch.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h | 7 +++++++
 block.c               | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index e5c7759a0c..bc76b1e59f 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -225,6 +225,13 @@ enum {
     BLK_PERM_GRAPH_MOD          = 0x10,
 
     BLK_PERM_ALL                = 0x1f,
+
+    DEFAULT_PERM_PASSTHROUGH    = BLK_PERM_CONSISTENT_READ
+                                 | BLK_PERM_WRITE
+                                 | BLK_PERM_WRITE_UNCHANGED
+                                 | BLK_PERM_RESIZE,
+
+    DEFAULT_PERM_UNCHANGED      = BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROUGH,
 };
 
 char *bdrv_perm_names(uint64_t perm);
diff --git a/block.c b/block.c
index 70a46fdd84..961ec97d26 100644
--- a/block.c
+++ b/block.c
@@ -1948,12 +1948,6 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
     return 0;
 }
 
-#define DEFAULT_PERM_PASSTHROUGH (BLK_PERM_CONSISTENT_READ \
-                                 | BLK_PERM_WRITE \
-                                 | BLK_PERM_WRITE_UNCHANGED \
-                                 | BLK_PERM_RESIZE)
-#define DEFAULT_PERM_UNCHANGED (BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROUGH)
-
 void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildRole *role,
                                BlockReopenQueue *reopen_queue,
-- 
2.13.6
