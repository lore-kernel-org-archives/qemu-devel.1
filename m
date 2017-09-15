Received: from eggs.gnu.org ([2001:4830:134:3::10]:37326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dsnZw-0002Dm-Cv
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dsnZr-0004N2-Ms
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:10:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 15 Sep 2017 12:10:06 +0200
Message-Id: <20170915101008.16646-5-kwolf@redhat.com>
In-Reply-To: <20170915101008.16646-1-kwolf@redhat.com>
References: <20170915101008.16646-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] block: Base permissions on rw state after
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

When new permissions are calculated during bdrv_reopen(), they need to
be based on the state of the graph as it will be after the reopen has
completed, not on the current state of the involved nodes.

This patch makes bdrv_is_writable() optionally accept a BlockReopenQueue
from which the new flags are taken. This is then used for determining
the new bs->file permissions of format drivers as soon as we add the
code to actually pass a non-NULL reopen queue to the .bdrv_child_perm
callbacks.

While moving bdrv_is_writable(), make it static. It isn't used outside
block.c.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  1 -
 block.c               | 52 ++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 2ad18775af..082eb2cd9c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -435,7 +435,6 @@ int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
                             int64_t offset, int64_t bytes, int64_t *pnum);
 
 bool bdrv_is_read_only(BlockDriverState *bs);
-bool bdrv_is_writable(BlockDriverState *bs);
 int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
                            bool ignore_allow_rdw, Error **errp);
 int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
diff --git a/block.c b/block.c
index 0b499fda4c..ed8d51dd42 100644
--- a/block.c
+++ b/block.c
@@ -239,12 +239,6 @@ bool bdrv_is_read_only(BlockDriverState *bs)
     return bs->read_only;
 }
 
-/* Returns whether the image file can be written to right now */
-bool bdrv_is_writable(BlockDriverState *bs)
-{
-    return !bdrv_is_read_only(bs) && !(bs->open_flags & BDRV_O_INACTIVE);
-}
-
 int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
                            bool ignore_allow_rdw, Error **errp)
 {
@@ -1537,6 +1531,41 @@ static int bdrv_child_check_perm(BdrvChild *c, BlockReopenQueue *q,
 static void bdrv_child_abort_perm_update(BdrvChild *c);
 static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared);
 
+typedef struct BlockReopenQueueEntry {
+     bool prepared;
+     BDRVReopenState state;
+     QSIMPLEQ_ENTRY(BlockReopenQueueEntry) entry;
+} BlockReopenQueueEntry;
+
+/*
+ * Return the flags that @bs will have after the reopens in @q have
+ * successfully completed. If @q is NULL (or @bs is not contained in @q),
+ * return the current flags.
+ */
+static int bdrv_reopen_get_flags(BlockReopenQueue *q, BlockDriverState *bs)
+{
+    BlockReopenQueueEntry *entry;
+
+    if (q != NULL) {
+        QSIMPLEQ_FOREACH(entry, q, entry) {
+            if (entry->state.bs == bs) {
+                return entry->state.flags;
+            }
+        }
+    }
+
+    return bs->open_flags;
+}
+
+/* Returns whether the image file can be written to after the reopen queue @q
+ * has been successfully applied, or right now if @q is NULL. */
+static bool bdrv_is_writable(BlockDriverState *bs, BlockReopenQueue *q)
+{
+    int flags = bdrv_reopen_get_flags(q, bs);
+
+    return (flags & (BDRV_O_RDWR | BDRV_O_INACTIVE)) == BDRV_O_RDWR;
+}
+
 static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
                             BdrvChild *c, const BdrvChildRole *role,
                             BlockReopenQueue *reopen_queue,
@@ -1574,7 +1603,7 @@ static int bdrv_check_perm(BlockDriverState *bs, BlockReopenQueue *q,
 
     /* Write permissions never work with read-only images */
     if ((cumulative_perms & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED)) &&
-        !bdrv_is_writable(bs))
+        !bdrv_is_writable(bs, q))
     {
         error_setg(errp, "Block node is read-only");
         return -EPERM;
@@ -1864,8 +1893,7 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                   &perm, &shared);
 
         /* Format drivers may touch metadata even if the guest doesn't write */
-        /* TODO Take flags from reopen_queue */
-        if (bdrv_is_writable(bs)) {
+        if (bdrv_is_writable(bs, reopen_queue)) {
             perm |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
         }
 
@@ -2642,12 +2670,6 @@ BlockDriverState *bdrv_open(const char *filename, const char *reference,
                              NULL, errp);
 }
 
-typedef struct BlockReopenQueueEntry {
-     bool prepared;
-     BDRVReopenState state;
-     QSIMPLEQ_ENTRY(BlockReopenQueueEntry) entry;
-} BlockReopenQueueEntry;
-
 /*
  * Adds a BlockDriverState to a simple queue for an atomic, transactional
  * reopen of multiple devices.
-- 
2.13.5
