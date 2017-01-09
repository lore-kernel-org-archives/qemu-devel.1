Received: from eggs.gnu.org ([2001:4830:134:3::10]:33433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFr-0006mv-SS
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFq-00031J-Kc
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:55 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  9 Jan 2017 14:44:29 +0100
Message-Id: <1483969476-7172-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
References: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/14] quorum: Avoid bdrv_aio_writev() for
 rewrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Replacing it with bdrv_co_pwritev() prepares us for byte granularity
requests and gets us rid of the last bdrv_aio_*() user in quorum.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/quorum.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index 2c280bb..690fd36 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -221,15 +221,6 @@ static bool quorum_has_too_much_io_failed(QuorumAIOCB *acb)
     return false;
 }
 
-static void quorum_rewrite_aio_cb(void *opaque, int ret)
-{
-    QuorumAIOCB *acb = opaque;
-
-    /* one less rewrite to do */
-    acb->rewrite_count--;
-    qemu_coroutine_enter_if_inactive(acb->co);
-}
-
 static int read_fifo_child(QuorumAIOCB *acb);
 
 static void quorum_copy_qiov(QEMUIOVector *dest, QEMUIOVector *source)
@@ -296,7 +287,27 @@ static void quorum_report_bad_versions(BDRVQuorumState *s,
     }
 }
 
-static bool quorum_rewrite_bad_versions(BDRVQuorumState *s, QuorumAIOCB *acb,
+static void quorum_rewrite_entry(void *opaque)
+{
+    QuorumCo *co = opaque;
+    QuorumAIOCB *acb = co->acb;
+    BDRVQuorumState *s = acb->bs->opaque;
+
+    /* Ignore any errors, it's just a correction attempt for already
+     * corrupted data. */
+    bdrv_co_pwritev(s->children[co->idx],
+                    acb->sector_num * BDRV_SECTOR_SIZE,
+                    acb->nb_sectors * BDRV_SECTOR_SIZE,
+                    acb->qiov, 0);
+
+    /* Wake up the caller after the last rewrite */
+    acb->rewrite_count--;
+    if (!acb->rewrite_count) {
+        qemu_coroutine_enter_if_inactive(acb->co);
+    }
+}
+
+static bool quorum_rewrite_bad_versions(QuorumAIOCB *acb,
                                         QuorumVoteValue *value)
 {
     QuorumVoteVersion *version;
@@ -315,7 +326,7 @@ static bool quorum_rewrite_bad_versions(BDRVQuorumState *s, QuorumAIOCB *acb,
         }
     }
 
-    /* quorum_rewrite_aio_cb will count down this to zero */
+    /* quorum_rewrite_entry will count down this to zero */
     acb->rewrite_count = count;
 
     /* now fire the correcting rewrites */
@@ -324,9 +335,14 @@ static bool quorum_rewrite_bad_versions(BDRVQuorumState *s, QuorumAIOCB *acb,
             continue;
         }
         QLIST_FOREACH(item, &version->items, next) {
-            bdrv_aio_writev(s->children[item->index], acb->sector_num,
-                            acb->qiov, acb->nb_sectors, quorum_rewrite_aio_cb,
-                            acb);
+            Coroutine *co;
+            QuorumCo data = {
+                .acb = acb,
+                .idx = item->index,
+            };
+
+            co = qemu_coroutine_create(quorum_rewrite_entry, &data);
+            qemu_coroutine_enter(co);
         }
     }
 
@@ -579,7 +595,7 @@ static void quorum_vote(QuorumAIOCB *acb)
 
     /* corruption correction is enabled */
     if (s->rewrite_corrupted) {
-        quorum_rewrite_bad_versions(s, acb, &winner->value);
+        quorum_rewrite_bad_versions(acb, &winner->value);
     }
 
 free_exit:
-- 
1.8.3.1
