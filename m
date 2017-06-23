Received: from eggs.gnu.org ([2001:4830:134:3::10]:59676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORM1-0001Ee-1v
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORM0-0007hc-5v
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:23 +0200
Message-Id: <1498234919-27316-26-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 25/61] qed: Use bottom half to resume waiting
 requests
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

The qed driver serialises allocating write requests. When the active
allocation is finished, the AIO callback is called, but after this, the
next allocating request is immediately processed instead of leaving the
coroutine. Resuming another allocation request in the same request
coroutine means that the request now runs in the wrong coroutine.

The following is one of the possible effects of this: The completed
request will generally reenter its request coroutine in a bottom half,
expecting that it completes the request in bdrv_driver_pwritev().
However, if the second request actually yielded before leaving the
coroutine, the reused request coroutine is in an entirely different
place and is reentered prematurely. Not a good idea.

Let's make sure that we exit the coroutine after completing the first
request by resuming the next allocating request only with a bottom
half.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 8d899fd..a837a28 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -967,6 +967,11 @@ static void qed_aio_complete_bh(void *opaque)
     qed_release(s);
 }
 
+static void qed_resume_alloc_bh(void *opaque)
+{
+    qed_aio_start_io(opaque);
+}
+
 static void qed_aio_complete(QEDAIOCB *acb, int ret)
 {
     BDRVQEDState *s = acb_to_s(acb);
@@ -995,10 +1000,12 @@ static void qed_aio_complete(QEDAIOCB *acb, int ret)
      * requests multiple times but rather finish one at a time completely.
      */
     if (acb == QSIMPLEQ_FIRST(&s->allocating_write_reqs)) {
+        QEDAIOCB *next_acb;
         QSIMPLEQ_REMOVE_HEAD(&s->allocating_write_reqs, next);
-        acb = QSIMPLEQ_FIRST(&s->allocating_write_reqs);
-        if (acb) {
-            qed_aio_start_io(acb);
+        next_acb = QSIMPLEQ_FIRST(&s->allocating_write_reqs);
+        if (next_acb) {
+            aio_bh_schedule_oneshot(bdrv_get_aio_context(acb->common.bs),
+                                    qed_resume_alloc_bh, next_acb);
         } else if (s->header.features & QED_F_NEED_CHECK) {
             qed_start_need_check_timer(s);
         }
-- 
1.8.3.1
