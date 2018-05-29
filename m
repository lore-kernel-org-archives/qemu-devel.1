Received: from eggs.gnu.org ([2001:4830:134:3::10]:58287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNiKO-00052M-2t
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNiKN-0001p9-5g
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:22:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 29 May 2018 19:21:47 +0200
Message-Id: <20180529172156.29311-12-kwolf@redhat.com>
In-Reply-To: <20180529172156.29311-1-kwolf@redhat.com>
References: <20180529172156.29311-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/20] test-bdrv-drain: Test node deletion
 in subtree recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, famz@redhat.com, stefanha@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

If bdrv_do_drained_begin() polls during its subtree recursion, the graph
can change and mess up the bs->children iteration. Test that this
doesn't happen.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index df438f0084..4b788e323e 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -880,7 +880,8 @@ static void coroutine_fn test_co_delete_by_drain(void *opaque)
  * If @detach_instead_of_delete is set, the BDS is not going to be
  * deleted but will only detach all of its children.
  */
-static void do_test_delete_by_drain(bool detach_instead_of_delete)
+static void do_test_delete_by_drain(bool detach_instead_of_delete,
+                                    enum drain_type drain_type)
 {
     BlockBackend *blk;
     BlockDriverState *bs, *child_bs, *null_bs;
@@ -936,9 +937,23 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete)
      * test_co_delete_by_drain() resuming.  Thus, @bs will be deleted
      * and the coroutine will exit while this drain operation is still
      * in progress. */
-    bdrv_ref(child_bs);
-    bdrv_drain(child_bs);
-    bdrv_unref(child_bs);
+    switch (drain_type) {
+    case BDRV_DRAIN:
+        bdrv_ref(child_bs);
+        bdrv_drain(child_bs);
+        bdrv_unref(child_bs);
+        break;
+    case BDRV_SUBTREE_DRAIN:
+        /* Would have to ref/unref bs here for !detach_instead_of_delete, but
+         * then the whole test becomes pointless because the graph changes
+         * don't occur during the drain any more. */
+        assert(detach_instead_of_delete);
+        bdrv_subtree_drained_begin(bs);
+        bdrv_subtree_drained_end(bs);
+        break;
+    default:
+        g_assert_not_reached();
+    }
 
     while (!dbdd.done) {
         aio_poll(qemu_get_aio_context(), true);
@@ -951,15 +966,19 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete)
     }
 }
 
-
 static void test_delete_by_drain(void)
 {
-    do_test_delete_by_drain(false);
+    do_test_delete_by_drain(false, BDRV_DRAIN);
 }
 
 static void test_detach_by_drain(void)
 {
-    do_test_delete_by_drain(true);
+    do_test_delete_by_drain(true, BDRV_DRAIN);
+}
+
+static void test_detach_by_drain_subtree(void)
+{
+    do_test_delete_by_drain(true, BDRV_SUBTREE_DRAIN);
 }
 
 
@@ -1010,8 +1029,9 @@ int main(int argc, char **argv)
     g_test_add_func("/bdrv-drain/blockjob/drain_subtree",
                     test_blockjob_drain_subtree);
 
-    g_test_add_func("/bdrv-drain/deletion", test_delete_by_drain);
-    g_test_add_func("/bdrv-drain/detach", test_detach_by_drain);
+    g_test_add_func("/bdrv-drain/deletion/drain", test_delete_by_drain);
+    g_test_add_func("/bdrv-drain/detach/drain", test_detach_by_drain);
+    g_test_add_func("/bdrv-drain/detach/drain_subtree", test_detach_by_drain_subtree);
 
     ret = g_test_run();
     qemu_event_destroy(&done_event);
-- 
2.13.6
