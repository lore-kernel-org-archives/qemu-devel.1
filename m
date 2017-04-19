Received: from eggs.gnu.org ([2001:4830:134:3::10]:52381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0mA2-00043U-2U
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0mA0-0005N0-WD
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:44:30 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 19 Apr 2017 17:43:45 +0800
Message-Id: <20170419094356.19826-6-famz@redhat.com>
In-Reply-To: <20170419094356.19826-1-famz@redhat.com>
References: <20170419094356.19826-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/16] block: Propagate
 BLK_PERM_AIO_CONTEXT_CHANGE down the graph
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

bdrv_set_aio_context can take care of children recursively, so it is
okay to pass down the perm.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c       | 10 ++++++----
 block/vvfat.c |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 5a3affb..7e696e5 100644
--- a/block.c
+++ b/block.c
@@ -1685,7 +1685,8 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
 #define DEFAULT_PERM_PASSTHROUGH (BLK_PERM_CONSISTENT_READ \
                                  | BLK_PERM_WRITE \
                                  | BLK_PERM_WRITE_UNCHANGED \
-                                 | BLK_PERM_RESIZE)
+                                 | BLK_PERM_RESIZE \
+                                 | BLK_PERM_AIO_CONTEXT_CHANGE)
 #define DEFAULT_PERM_UNCHANGED (BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROUGH)
 
 void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
@@ -1728,9 +1729,10 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
         perm |= BLK_PERM_CONSISTENT_READ;
         shared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
     } else {
-        /* We want consistent read from backing files if the parent needs it.
+        /* We want consistent read and aio context change from backing files if
+         * the parent needs it.
          * No other operations are performed on backing files. */
-        perm &= BLK_PERM_CONSISTENT_READ;
+        perm &= BLK_PERM_CONSISTENT_READ | BLK_PERM_AIO_CONTEXT_CHANGE;
 
         /* If the parent can deal with changing data, we're okay with a
          * writable and resizable backing file. */
@@ -1742,7 +1744,7 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
         }
 
         shared |= BLK_PERM_CONSISTENT_READ | BLK_PERM_GRAPH_MOD |
-                  BLK_PERM_WRITE_UNCHANGED;
+                  BLK_PERM_WRITE_UNCHANGED | BLK_PERM_AIO_CONTEXT_CHANGE;
     }
 
     *nperm = perm;
diff --git a/block/vvfat.c b/block/vvfat.c
index af5153d..70ce452 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3080,7 +3080,7 @@ static void vvfat_child_perm(BlockDriverState *bs, BdrvChild *c,
     if (c == s->qcow) {
         /* This is a private node, nobody should try to attach to it */
         *nperm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
-        *nshared = BLK_PERM_WRITE_UNCHANGED;
+        *nshared = BLK_PERM_WRITE_UNCHANGED | BLK_PERM_AIO_CONTEXT_CHANGE;
     } else {
         /* The backing file is there so 'commit' can use it. vvfat doesn't
          * access it in any way. */
-- 
2.9.3
