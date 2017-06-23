Received: from eggs.gnu.org ([2001:4830:134:3::10]:59895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMB-0001Qx-9s
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMA-0007mb-9z
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:51 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:32 +0200
Message-Id: <1498234919-27316-35-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 34/61] qed: Remove callback from
 qed_write_header()
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 2665efc..95f1050 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -98,8 +98,7 @@ int qed_write_header_sync(BDRVQEDState *s)
  * This function only updates known header fields in-place and does not affect
  * extra data after the QED header.
  */
-static void qed_write_header(BDRVQEDState *s, BlockCompletionFunc cb,
-                             void *opaque)
+static int qed_write_header(BDRVQEDState *s)
 {
     /* We must write full sectors for O_DIRECT but cannot necessarily generate
      * the data following the header if an unrecognized compat feature is
@@ -137,7 +136,7 @@ static void qed_write_header(BDRVQEDState *s, BlockCompletionFunc cb,
     ret = 0;
 out:
     qemu_vfree(buf);
-    cb(opaque, ret);
+    return ret;
 }
 
 static uint64_t qed_max_image_size(uint32_t cluster_size, uint32_t table_size)
@@ -289,21 +288,6 @@ static void qed_unplug_allocating_write_reqs(BDRVQEDState *s)
     }
 }
 
-static void qed_finish_clear_need_check(void *opaque, int ret)
-{
-    /* Do nothing */
-}
-
-static void qed_flush_after_clear_need_check(void *opaque, int ret)
-{
-    BDRVQEDState *s = opaque;
-
-    bdrv_aio_flush(s->bs, qed_finish_clear_need_check, s);
-
-    /* No need to wait until flush completes */
-    qed_unplug_allocating_write_reqs(s);
-}
-
 static void qed_clear_need_check(void *opaque, int ret)
 {
     BDRVQEDState *s = opaque;
@@ -314,7 +298,13 @@ static void qed_clear_need_check(void *opaque, int ret)
     }
 
     s->header.features &= ~QED_F_NEED_CHECK;
-    qed_write_header(s, qed_flush_after_clear_need_check, s);
+    ret = qed_write_header(s);
+    (void) ret;
+
+    qed_unplug_allocating_write_reqs(s);
+
+    ret = bdrv_flush(s->bs);
+    (void) ret;
 }
 
 static void qed_need_check_timer_cb(void *opaque)
@@ -1179,6 +1169,7 @@ static void qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
 {
     BDRVQEDState *s = acb_to_s(acb);
     BlockCompletionFunc *cb;
+    int ret;
 
     /* Cancel timer when the first allocating request comes in */
     if (QSIMPLEQ_EMPTY(&s->allocating_write_reqs)) {
@@ -1213,7 +1204,8 @@ static void qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
 
     if (qed_should_set_need_check(s)) {
         s->header.features |= QED_F_NEED_CHECK;
-        qed_write_header(s, cb, acb);
+        ret = qed_write_header(s);
+        cb(acb, ret);
     } else {
         cb(acb, 0);
     }
-- 
1.8.3.1
