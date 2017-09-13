Received: from eggs.gnu.org ([2001:4830:134:3::10]:36390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCG3-0007ah-P7
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCG2-0004bc-Ky
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:19:31 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Sep 2017 20:18:53 +0200
Message-Id: <20170913181910.29688-2-mreitz@redhat.com>
In-Reply-To: <20170913181910.29688-1-mreitz@redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 01/18] block: Add BdrvDeletedStatus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

Sometimes an operation may delete a BDS.  It may then not be trivial to
determine this because the BDS object itself cannot be accessed
afterwards.  With this patch, one can attach a BdrvDeletedStatus object
to a BDS which can be used to safely query whether the BDS still exists
even after it has been deleted.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h | 12 ++++++++++++
 block.c                   |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index ba4c383393..eaeaad9428 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -498,6 +498,13 @@ typedef struct BdrvAioNotifier {
     QLIST_ENTRY(BdrvAioNotifier) list;
 } BdrvAioNotifier;
 
+typedef struct BdrvDeletedStatus {
+    /* Set to true by bdrv_delete() */
+    bool deleted;
+
+    QLIST_ENTRY(BdrvDeletedStatus) next;
+} BdrvDeletedStatus;
+
 struct BdrvChildRole {
     /* If true, bdrv_replace_node() doesn't change the node this BdrvChild
      * points to. */
@@ -706,6 +713,11 @@ struct BlockDriverState {
 
     /* Only read/written by whoever has set active_flush_req to true.  */
     unsigned int flushed_gen;             /* Flushed write generation */
+
+    /* When bdrv_delete() is invoked, it will walk through this list
+     * and set every entry's @deleted field to true.  The entries will
+     * not be freed automatically. */
+    QLIST_HEAD(, BdrvDeletedStatus) deleted_status;
 };
 
 struct BlockBackendRootState {
diff --git a/block.c b/block.c
index 6dd47e414e..0b55c5a41c 100644
--- a/block.c
+++ b/block.c
@@ -3246,10 +3246,16 @@ out:
 
 static void bdrv_delete(BlockDriverState *bs)
 {
+    BdrvDeletedStatus *del_stat;
+
     assert(!bs->job);
     assert(bdrv_op_blocker_is_empty(bs));
     assert(!bs->refcnt);
 
+    QLIST_FOREACH(del_stat, &bs->deleted_status, next) {
+        del_stat->deleted = true;
+    }
+
     bdrv_close(bs);
 
     /* remove from list, if necessary */
-- 
2.13.5
