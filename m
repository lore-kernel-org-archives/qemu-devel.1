Received: from eggs.gnu.org ([2001:4830:134:3::10]:60214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORML-0001dh-BW
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMK-0007uQ-Bw
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:40 +0200
Message-Id: <1498234919-27316-43-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 42/61] qed: Add return value to
 qed_aio_write_l2_update()
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

Don't recurse into qed_aio_next_io() and qed_aio_complete() here, but
just return an error code and let the caller handle it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index e43827f..3cda01f 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -986,15 +986,11 @@ static int qed_aio_write_l1_update(QEDAIOCB *acb)
 /**
  * Update L2 table with new cluster offsets and write them out
  */
-static void qed_aio_write_l2_update(QEDAIOCB *acb, int ret, uint64_t offset)
+static int qed_aio_write_l2_update(QEDAIOCB *acb, uint64_t offset)
 {
     BDRVQEDState *s = acb_to_s(acb);
     bool need_alloc = acb->find_cluster_ret == QED_CLUSTER_L1;
-    int index;
-
-    if (ret) {
-        goto err;
-    }
+    int index, ret;
 
     if (need_alloc) {
         qed_unref_l2_cache_entry(acb->request.l2_table);
@@ -1009,21 +1005,18 @@ static void qed_aio_write_l2_update(QEDAIOCB *acb, int ret, uint64_t offset)
         /* Write out the whole new L2 table */
         ret = qed_write_l2_table(s, &acb->request, 0, s->table_nelems, true);
         if (ret) {
-            goto err;
+            return ret;
         }
-        ret = qed_aio_write_l1_update(acb);
-        qed_aio_next_io(acb, ret);
-
+        return qed_aio_write_l1_update(acb);
     } else {
         /* Write out only the updated part of the L2 table */
         ret = qed_write_l2_table(s, &acb->request, index, acb->cur_nclusters,
                                  false);
-        qed_aio_next_io(acb, ret);
+        if (ret) {
+            return ret;
+        }
     }
-    return;
-
-err:
-    qed_aio_complete(acb, ret);
+    return 0;
 }
 
 /**
@@ -1065,8 +1058,19 @@ static void qed_aio_write_main(void *opaque, int ret)
              */
             ret = bdrv_flush(s->bs->file->bs);
         }
-        qed_aio_write_l2_update(acb, ret, acb->cur_cluster);
+        if (ret) {
+            goto err;
+        }
+        ret = qed_aio_write_l2_update(acb, acb->cur_cluster);
+        if (ret) {
+            goto err;
+        }
+        qed_aio_next_io(acb, 0);
     }
+    return;
+
+err:
+    qed_aio_complete(acb, ret);
 }
 
 /**
@@ -1124,7 +1128,12 @@ static void qed_aio_write_zero_cluster(void *opaque, int ret)
         return;
     }
 
-    qed_aio_write_l2_update(acb, 0, 1);
+    ret = qed_aio_write_l2_update(acb, 1);
+    if (ret < 0) {
+        qed_aio_complete(acb, ret);
+        return;
+    }
+    qed_aio_next_io(acb, 0);
 }
 
 /**
-- 
1.8.3.1
