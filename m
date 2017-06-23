Received: from eggs.gnu.org ([2001:4830:134:3::10]:60608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMa-0001tt-N2
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMW-00087X-Ht
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:48 +0200
Message-Id: <1498234919-27316-51-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 50/61] qed: Use CoQueue for serialising
 allocations
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

Now that we're running in coroutine context, the ad-hoc serialisation
code (which drops a request that has to wait out of coroutine context)
can be replaced by a CoQueue.

This means that when we resume a serialised request, it is running in
coroutine context again and its I/O isn't blocking any more.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 49 +++++++++++++++++--------------------------------
 block/qed.h |  3 ++-
 2 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index a5111fd..cd3ef55 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -269,16 +269,10 @@ static void qed_plug_allocating_write_reqs(BDRVQEDState *s)
 
 static void qed_unplug_allocating_write_reqs(BDRVQEDState *s)
 {
-    QEDAIOCB *acb;
-
     assert(s->allocating_write_reqs_plugged);
 
     s->allocating_write_reqs_plugged = false;
-
-    acb = QSIMPLEQ_FIRST(&s->allocating_write_reqs);
-    if (acb) {
-        qed_aio_start_io(acb);
-    }
+    qemu_co_enter_next(&s->allocating_write_reqs);
 }
 
 static void qed_clear_need_check(void *opaque, int ret)
@@ -305,7 +299,7 @@ static void qed_need_check_timer_cb(void *opaque)
     BDRVQEDState *s = opaque;
 
     /* The timer should only fire when allocating writes have drained */
-    assert(!QSIMPLEQ_FIRST(&s->allocating_write_reqs));
+    assert(!s->allocating_acb);
 
     trace_qed_need_check_timer_cb(s);
 
@@ -388,7 +382,7 @@ static int bdrv_qed_do_open(BlockDriverState *bs, QDict *options, int flags,
     int ret;
 
     s->bs = bs;
-    QSIMPLEQ_INIT(&s->allocating_write_reqs);
+    qemu_co_queue_init(&s->allocating_write_reqs);
 
     ret = bdrv_pread(bs->file, 0, &le_header, sizeof(le_header));
     if (ret < 0) {
@@ -910,11 +904,6 @@ static void qed_aio_complete_bh(void *opaque)
     qed_release(s);
 }
 
-static void qed_resume_alloc_bh(void *opaque)
-{
-    qed_aio_start_io(opaque);
-}
-
 static void qed_aio_complete(QEDAIOCB *acb, int ret)
 {
     BDRVQEDState *s = acb_to_s(acb);
@@ -942,13 +931,10 @@ static void qed_aio_complete(QEDAIOCB *acb, int ret)
      * next request in the queue.  This ensures that we don't cycle through
      * requests multiple times but rather finish one at a time completely.
      */
-    if (acb == QSIMPLEQ_FIRST(&s->allocating_write_reqs)) {
-        QEDAIOCB *next_acb;
-        QSIMPLEQ_REMOVE_HEAD(&s->allocating_write_reqs, next);
-        next_acb = QSIMPLEQ_FIRST(&s->allocating_write_reqs);
-        if (next_acb) {
-            aio_bh_schedule_oneshot(bdrv_get_aio_context(acb->common.bs),
-                                    qed_resume_alloc_bh, next_acb);
+    if (acb == s->allocating_acb) {
+        s->allocating_acb = NULL;
+        if (!qemu_co_queue_empty(&s->allocating_write_reqs)) {
+            qemu_co_enter_next(&s->allocating_write_reqs);
         } else if (s->header.features & QED_F_NEED_CHECK) {
             qed_start_need_check_timer(s);
         }
@@ -1124,17 +1110,18 @@ static int qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
     int ret;
 
     /* Cancel timer when the first allocating request comes in */
-    if (QSIMPLEQ_EMPTY(&s->allocating_write_reqs)) {
+    if (s->allocating_acb == NULL) {
         qed_cancel_need_check_timer(s);
     }
 
     /* Freeze this request if another allocating write is in progress */
-    if (acb != QSIMPLEQ_FIRST(&s->allocating_write_reqs)) {
-        QSIMPLEQ_INSERT_TAIL(&s->allocating_write_reqs, acb, next);
-    }
-    if (acb != QSIMPLEQ_FIRST(&s->allocating_write_reqs) ||
-        s->allocating_write_reqs_plugged) {
-        return -EINPROGRESS; /* wait for existing request to finish */
+    if (s->allocating_acb != acb || s->allocating_write_reqs_plugged) {
+        if (s->allocating_acb != NULL) {
+            qemu_co_queue_wait(&s->allocating_write_reqs, NULL);
+            assert(s->allocating_acb == NULL);
+        }
+        s->allocating_acb = acb;
+        return -EAGAIN; /* start over with looking up table entries */
     }
 
     acb->cur_nclusters = qed_bytes_to_clusters(s,
@@ -1313,10 +1300,8 @@ static void qed_aio_next_io(QEDAIOCB *acb)
             ret = qed_aio_read_data(acb, ret, offset, len);
         }
 
-        if (ret < 0) {
-            if (ret != -EINPROGRESS) {
-                qed_aio_complete(acb, ret);
-            }
+        if (ret < 0 && ret != -EAGAIN) {
+            qed_aio_complete(acb, ret);
             return;
         }
     }
diff --git a/block/qed.h b/block/qed.h
index 8644fed..37558e4 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -163,7 +163,8 @@ typedef struct {
     uint32_t l2_mask;
 
     /* Allocating write request queue */
-    QSIMPLEQ_HEAD(, QEDAIOCB) allocating_write_reqs;
+    QEDAIOCB *allocating_acb;
+    CoQueue allocating_write_reqs;
     bool allocating_write_reqs_plugged;
 
     /* Periodic flush and clear need check flag */
-- 
1.8.3.1
