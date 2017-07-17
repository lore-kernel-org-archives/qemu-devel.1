Received: from eggs.gnu.org ([2001:4830:134:3::10]:42484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1X-0000k3-9F
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1W-0004ab-4D
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dWx1V-0004aL-Rk
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:42 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 11:48:16 +0800
Message-Id: <20170717034825.1524-7-famz@redhat.com>
In-Reply-To: <20170717034825.1524-1-famz@redhat.com>
References: <20170717034825.1524-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 06/15] qed: move tail of qed_aio_write_main to
 qed_aio_write_{cow, alloc}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Paolo Bonzini <pbonzini@redhat.com>

This part is never called for in-place writes, move it away to avoid
the "backwards" coding style typical of callback-based code.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170629132749.997-7-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/qed.c | 70 ++++++++++++++++++++++++++++---------------------------------
 1 file changed, 32 insertions(+), 38 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 86cad21..5792796 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -982,40 +982,12 @@ static int coroutine_fn qed_aio_write_main(QEDAIOCB *acb)
     BDRVQEDState *s = acb_to_s(acb);
     uint64_t offset = acb->cur_cluster +
                       qed_offset_into_cluster(s, acb->cur_pos);
-    int ret;
 
     trace_qed_aio_write_main(s, acb, 0, offset, acb->cur_qiov.size);
 
     BLKDBG_EVENT(s->bs->file, BLKDBG_WRITE_AIO);
-    ret = bdrv_co_pwritev(s->bs->file, offset, acb->cur_qiov.size,
-                          &acb->cur_qiov, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    if (acb->find_cluster_ret != QED_CLUSTER_FOUND) {
-        if (s->bs->backing) {
-            /*
-             * Flush new data clusters before updating the L2 table
-             *
-             * This flush is necessary when a backing file is in use.  A crash
-             * during an allocating write could result in empty clusters in the
-             * image.  If the write only touched a subregion of the cluster,
-             * then backing image sectors have been lost in the untouched
-             * region.  The solution is to flush after writing a new data
-             * cluster and before updating the L2 table.
-             */
-            ret = bdrv_co_flush(s->bs->file->bs);
-            if (ret < 0) {
-                return ret;
-            }
-        }
-        ret = qed_aio_write_l2_update(acb, acb->cur_cluster);
-        if (ret < 0) {
-            return ret;
-        }
-    }
-    return 0;
+    return bdrv_co_pwritev(s->bs->file, offset, acb->cur_qiov.size,
+                           &acb->cur_qiov, 0);
 }
 
 /**
@@ -1050,7 +1022,29 @@ static int coroutine_fn qed_aio_write_cow(QEDAIOCB *acb)
         return ret;
     }
 
-    return qed_aio_write_main(acb);
+    ret = qed_aio_write_main(acb);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (s->bs->backing) {
+        /*
+         * Flush new data clusters before updating the L2 table
+         *
+         * This flush is necessary when a backing file is in use.  A crash
+         * during an allocating write could result in empty clusters in the
+         * image.  If the write only touched a subregion of the cluster,
+         * then backing image sectors have been lost in the untouched
+         * region.  The solution is to flush after writing a new data
+         * cluster and before updating the L2 table.
+         */
+        ret = bdrv_co_flush(s->bs->file->bs);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
 }
 
 /**
@@ -1103,6 +1097,7 @@ static int coroutine_fn qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
         if (acb->find_cluster_ret == QED_CLUSTER_ZERO) {
             return 0;
         }
+        acb->cur_cluster = 1;
     } else {
         acb->cur_cluster = qed_alloc_clusters(s, acb->cur_nclusters);
     }
@@ -1115,15 +1110,14 @@ static int coroutine_fn qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
         }
     }
 
-    if (acb->flags & QED_AIOCB_ZERO) {
-        ret = qed_aio_write_l2_update(acb, 1);
-    } else {
+    if (!(acb->flags & QED_AIOCB_ZERO)) {
         ret = qed_aio_write_cow(acb);
+        if (ret < 0) {
+            return ret;
+        }
     }
-    if (ret < 0) {
-        return ret;
-    }
-    return 0;
+
+    return qed_aio_write_l2_update(acb, acb->cur_cluster);
 }
 
 /**
-- 
2.9.4
