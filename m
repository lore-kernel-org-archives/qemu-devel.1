Received: from eggs.gnu.org ([2001:4830:134:3::10]:53182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCQ-0006HJ-7W
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCL-0001lJ-Mk
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:37:02 +0200
Message-Id: <1497634636-20230-18-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 17/31] qed: Add return value to
 qed_aio_write_l1_update()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

Don't recurse into qed_aio_next_io() and qed_aio_complete() here, but
just return an error code and let the caller handle it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 5462faa..e43827f 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -958,18 +958,12 @@ static void qed_aio_complete(QEDAIOCB *acb, int ret)
 /**
  * Update L1 table with new L2 table offset and write it out
  */
-static void qed_aio_write_l1_update(void *opaque, int ret)
+static int qed_aio_write_l1_update(QEDAIOCB *acb)
 {
-    QEDAIOCB *acb = opaque;
     BDRVQEDState *s = acb_to_s(acb);
     CachedL2Table *l2_table = acb->request.l2_table;
     uint64_t l2_offset = l2_table->offset;
-    int index;
-
-    if (ret) {
-        qed_aio_complete(acb, ret);
-        return;
-    }
+    int index, ret;
 
     index = qed_l1_index(s, acb->cur_pos);
     s->l1_table->offsets[index] = l2_table->offset;
@@ -985,7 +979,7 @@ static void qed_aio_write_l1_update(void *opaque, int ret)
     acb->request.l2_table = qed_find_l2_cache_entry(&s->l2_cache, l2_offset);
     assert(acb->request.l2_table != NULL);
 
-    qed_aio_next_io(acb, ret);
+    return ret;
 }
 
 
@@ -1014,7 +1008,12 @@ static void qed_aio_write_l2_update(QEDAIOCB *acb, int ret, uint64_t offset)
     if (need_alloc) {
         /* Write out the whole new L2 table */
         ret = qed_write_l2_table(s, &acb->request, 0, s->table_nelems, true);
-        qed_aio_write_l1_update(acb, ret);
+        if (ret) {
+            goto err;
+        }
+        ret = qed_aio_write_l1_update(acb);
+        qed_aio_next_io(acb, ret);
+
     } else {
         /* Write out only the updated part of the L2 table */
         ret = qed_write_l2_table(s, &acb->request, index, acb->cur_nclusters,
-- 
1.8.3.1
