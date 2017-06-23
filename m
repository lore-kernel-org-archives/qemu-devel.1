Received: from eggs.gnu.org ([2001:4830:134:3::10]:60136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMJ-0001at-Al
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMI-0007rp-Av
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:59 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:38 +0200
Message-Id: <1498234919-27316-41-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 40/61] qed: Inline qed_commit_l2_update()
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

qed_commit_l2_update() is unconditionally called at the end of
qed_aio_write_l1_update(). Inline it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index d164b0e..5462faa 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -956,15 +956,27 @@ static void qed_aio_complete(QEDAIOCB *acb, int ret)
 }
 
 /**
- * Commit the current L2 table to the cache
+ * Update L1 table with new L2 table offset and write it out
  */
-static void qed_commit_l2_update(void *opaque, int ret)
+static void qed_aio_write_l1_update(void *opaque, int ret)
 {
     QEDAIOCB *acb = opaque;
     BDRVQEDState *s = acb_to_s(acb);
     CachedL2Table *l2_table = acb->request.l2_table;
     uint64_t l2_offset = l2_table->offset;
+    int index;
+
+    if (ret) {
+        qed_aio_complete(acb, ret);
+        return;
+    }
 
+    index = qed_l1_index(s, acb->cur_pos);
+    s->l1_table->offsets[index] = l2_table->offset;
+
+    ret = qed_write_l1_table(s, index, 1);
+
+    /* Commit the current L2 table to the cache */
     qed_commit_l2_cache_entry(&s->l2_cache, l2_table);
 
     /* This is guaranteed to succeed because we just committed the entry to the
@@ -976,26 +988,6 @@ static void qed_commit_l2_update(void *opaque, int ret)
     qed_aio_next_io(acb, ret);
 }
 
-/**
- * Update L1 table with new L2 table offset and write it out
- */
-static void qed_aio_write_l1_update(void *opaque, int ret)
-{
-    QEDAIOCB *acb = opaque;
-    BDRVQEDState *s = acb_to_s(acb);
-    int index;
-
-    if (ret) {
-        qed_aio_complete(acb, ret);
-        return;
-    }
-
-    index = qed_l1_index(s, acb->cur_pos);
-    s->l1_table->offsets[index] = acb->request.l2_table->offset;
-
-    ret = qed_write_l1_table(s, index, 1);
-    qed_commit_l2_update(acb, ret);
-}
 
 /**
  * Update L2 table with new cluster offsets and write them out
-- 
1.8.3.1
