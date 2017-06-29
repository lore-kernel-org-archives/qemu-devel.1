Received: from eggs.gnu.org ([2001:4830:134:3::10]:48919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQZUI-0005mE-3H
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQZUG-0001Op-SZ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:28:02 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Jun 2017 15:27:44 +0200
Message-Id: <20170629132749.997-7-pbonzini@redhat.com>
In-Reply-To: <20170629132749.997-1-pbonzini@redhat.com>
References: <20170629132749.997-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 06/11] qed: move tail of qed_aio_write_main to
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
Cc: stefanha@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com

This part is never called for in-place writes, move it away to avoid
the "backwards" coding style typical of callback-based code.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/qed.c | 70 ++++++++++++++++++++++++++++---------------------------------
 1 file changed, 32 insertions(+), 38 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 385381a78a..d593557522 100644
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
2.13.0
