Received: from eggs.gnu.org ([2001:4830:134:3::10]:34051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMQ7-0000SN-Uh
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMQ7-0006wj-13
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:53:08 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 24 May 2017 10:52:24 +0800
Message-Id: <20170524025235.32190-6-famz@redhat.com>
In-Reply-To: <20170524025235.32190-1-famz@redhat.com>
References: <20170524025235.32190-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 05/16] block: Propagate
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
index d98662f..1e5eae7 100644
--- a/block.c
+++ b/block.c
@@ -1772,7 +1772,8 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
 #define DEFAULT_PERM_PASSTHROUGH (BLK_PERM_CONSISTENT_READ \
                                  | BLK_PERM_WRITE \
                                  | BLK_PERM_WRITE_UNCHANGED \
-                                 | BLK_PERM_RESIZE)
+                                 | BLK_PERM_RESIZE \
+                                 | BLK_PERM_AIO_CONTEXT_CHANGE)
 #define DEFAULT_PERM_UNCHANGED (BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROUGH)
 
 void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
@@ -1815,9 +1816,10 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
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
@@ -1829,7 +1831,7 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
         }
 
         shared |= BLK_PERM_CONSISTENT_READ | BLK_PERM_GRAPH_MOD |
-                  BLK_PERM_WRITE_UNCHANGED;
+                  BLK_PERM_WRITE_UNCHANGED | BLK_PERM_AIO_CONTEXT_CHANGE;
     }
 
     if (bs->open_flags & BDRV_O_INACTIVE) {
diff --git a/block/vvfat.c b/block/vvfat.c
index 426ca70..599a370 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3091,7 +3091,7 @@ static void vvfat_child_perm(BlockDriverState *bs, BdrvChild *c,
     if (c == s->qcow) {
         /* This is a private node, nobody should try to attach to it */
         *nperm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
-        *nshared = BLK_PERM_WRITE_UNCHANGED;
+        *nshared = BLK_PERM_WRITE_UNCHANGED | BLK_PERM_AIO_CONTEXT_CHANGE;
     } else {
         /* The backing file is there so 'commit' can use it. vvfat doesn't
          * access it in any way. */
-- 
2.9.4
