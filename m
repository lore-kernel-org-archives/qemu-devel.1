Received: from eggs.gnu.org ([2001:4830:134:3::10]:60441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMT-0001nN-3E
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMS-00081c-2G
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:09 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:45 +0200
Message-Id: <1498234919-27316-48-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 47/61] qed: Remove ret argument from
 qed_aio_next_io()
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

All callers pass ret = 0, so we can just remove it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 6f83831..db80987 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -253,11 +253,11 @@ static CachedL2Table *qed_new_l2_table(BDRVQEDState *s)
     return l2_table;
 }
 
-static void qed_aio_next_io(QEDAIOCB *acb, int ret);
+static void qed_aio_next_io(QEDAIOCB *acb);
 
 static void qed_aio_start_io(QEDAIOCB *acb)
 {
-    qed_aio_next_io(acb, 0);
+    qed_aio_next_io(acb);
 }
 
 static void qed_plug_allocating_write_reqs(BDRVQEDState *s)
@@ -1273,13 +1273,14 @@ static int qed_aio_read_data(void *opaque, int ret, uint64_t offset, size_t len)
 /**
  * Begin next I/O or complete the request
  */
-static void qed_aio_next_io(QEDAIOCB *acb, int ret)
+static void qed_aio_next_io(QEDAIOCB *acb)
 {
     BDRVQEDState *s = acb_to_s(acb);
     uint64_t offset;
     size_t len;
+    int ret;
 
-    trace_qed_aio_next_io(s, acb, ret, acb->cur_pos + acb->cur_qiov.size);
+    trace_qed_aio_next_io(s, acb, 0, acb->cur_pos + acb->cur_qiov.size);
 
     if (acb->backing_qiov) {
         qemu_iovec_destroy(acb->backing_qiov);
@@ -1287,12 +1288,6 @@ static void qed_aio_next_io(QEDAIOCB *acb, int ret)
         acb->backing_qiov = NULL;
     }
 
-    /* Handle I/O error */
-    if (ret) {
-        qed_aio_complete(acb, ret);
-        return;
-    }
-
     acb->qiov_offset += acb->cur_qiov.size;
     acb->cur_pos += acb->cur_qiov.size;
     qemu_iovec_reset(&acb->cur_qiov);
@@ -1323,7 +1318,7 @@ static void qed_aio_next_io(QEDAIOCB *acb, int ret)
         }
         return;
     }
-    qed_aio_next_io(acb, 0);
+    qed_aio_next_io(acb);
 }
 
 static BlockAIOCB *qed_aio_setup(BlockDriverState *bs,
-- 
1.8.3.1
