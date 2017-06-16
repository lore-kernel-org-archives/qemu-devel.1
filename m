Received: from eggs.gnu.org ([2001:4830:134:3::10]:53268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCW-0006OX-Sx
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCV-0001wd-Uq
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:28 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:37:05 +0200
Message-Id: <1497634636-20230-21-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 20/31] qed: Add return value to
 qed_aio_write_cow()
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

While refactoring qed_aio_write_alloc() to accomodate the change,
qed_aio_write_zero_cluster() ended up with a single line, so I chose to
inline that line and remove the function completely.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 58 +++++++++++++++++++++-------------------------------------
 1 file changed, 21 insertions(+), 37 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index a4b13f8..84864e0 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1065,11 +1065,11 @@ static int qed_aio_write_main(QEDAIOCB *acb)
 /**
  * Populate untouched regions of new data cluster
  */
-static void qed_aio_write_cow(void *opaque, int ret)
+static int qed_aio_write_cow(QEDAIOCB *acb)
 {
-    QEDAIOCB *acb = opaque;
     BDRVQEDState *s = acb_to_s(acb);
     uint64_t start, len, offset;
+    int ret;
 
     /* Populate front untouched region of new data cluster */
     start = qed_start_of_cluster(s, acb->cur_pos);
@@ -1077,9 +1077,8 @@ static void qed_aio_write_cow(void *opaque, int ret)
 
     trace_qed_aio_write_prefill(s, acb, start, len, acb->cur_cluster);
     ret = qed_copy_from_backing_file(s, start, len, acb->cur_cluster);
-    if (ret) {
-        qed_aio_complete(acb, ret);
-        return;
+    if (ret < 0) {
+        return ret;
     }
 
     /* Populate back untouched region of new data cluster */
@@ -1091,17 +1090,11 @@ static void qed_aio_write_cow(void *opaque, int ret)
 
     trace_qed_aio_write_postfill(s, acb, start, len, offset);
     ret = qed_copy_from_backing_file(s, start, len, offset);
-    if (ret) {
-        qed_aio_complete(acb, ret);
-        return;
-    }
-
-    ret = qed_aio_write_main(acb);
     if (ret < 0) {
-        qed_aio_complete(acb, ret);
-        return;
+        return ret;
     }
-    qed_aio_next_io(acb, 0);
+
+    return qed_aio_write_main(acb);
 }
 
 /**
@@ -1117,23 +1110,6 @@ static bool qed_should_set_need_check(BDRVQEDState *s)
     return !(s->header.features & QED_F_NEED_CHECK);
 }
 
-static void qed_aio_write_zero_cluster(void *opaque, int ret)
-{
-    QEDAIOCB *acb = opaque;
-
-    if (ret) {
-        qed_aio_complete(acb, ret);
-        return;
-    }
-
-    ret = qed_aio_write_l2_update(acb, 1);
-    if (ret < 0) {
-        qed_aio_complete(acb, ret);
-        return;
-    }
-    qed_aio_next_io(acb, 0);
-}
-
 /**
  * Write new data cluster
  *
@@ -1145,7 +1121,6 @@ static void qed_aio_write_zero_cluster(void *opaque, int ret)
 static void qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
 {
     BDRVQEDState *s = acb_to_s(acb);
-    BlockCompletionFunc *cb;
     int ret;
 
     /* Cancel timer when the first allocating request comes in */
@@ -1172,20 +1147,29 @@ static void qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
             qed_aio_start_io(acb);
             return;
         }
-
-        cb = qed_aio_write_zero_cluster;
     } else {
-        cb = qed_aio_write_cow;
         acb->cur_cluster = qed_alloc_clusters(s, acb->cur_nclusters);
     }
 
     if (qed_should_set_need_check(s)) {
         s->header.features |= QED_F_NEED_CHECK;
         ret = qed_write_header(s);
-        cb(acb, ret);
+        if (ret < 0) {
+            qed_aio_complete(acb, ret);
+            return;
+        }
+    }
+
+    if (acb->flags & QED_AIOCB_ZERO) {
+        ret = qed_aio_write_l2_update(acb, 1);
     } else {
-        cb(acb, 0);
+        ret = qed_aio_write_cow(acb);
     }
+    if (ret < 0) {
+        qed_aio_complete(acb, ret);
+        return;
+    }
+    qed_aio_next_io(acb, 0);
 }
 
 /**
-- 
1.8.3.1
