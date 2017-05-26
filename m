Received: from eggs.gnu.org ([2001:4830:134:3::10]:59164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dELm4-000613-IF
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dELm3-0005aO-J4
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:23:52 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 26 May 2017 22:22:09 +0200
Message-Id: <1495830130-30611-29-git-send-email-kwolf@redhat.com>
In-Reply-To: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 28/29] qed: Use a coroutine for need_check_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

This fixes the last place where we degraded from AIO to actual blocking
synchronous I/O requests. Putting it into a coroutine means that instead
of blocking, the coroutine simply yields while doing I/O.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qed.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index d3f7d0c..20e81a0 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -264,11 +264,23 @@ static void qed_unplug_allocating_write_reqs(BDRVQEDState *s)
     qemu_co_enter_next(&s->allocating_write_reqs);
 }
 
-static void qed_clear_need_check(void *opaque, int ret)
+static void qed_need_check_timer_entry(void *opaque)
 {
     BDRVQEDState *s = opaque;
+    int ret;
 
-    if (ret) {
+    /* The timer should only fire when allocating writes have drained */
+    assert(!s->allocating_acb);
+
+    trace_qed_need_check_timer_cb(s);
+
+    qed_acquire(s);
+    qed_plug_allocating_write_reqs(s);
+
+    /* Ensure writes are on disk before clearing flag */
+    ret = bdrv_co_flush(s->bs->file->bs);
+    qed_release(s);
+    if (ret < 0) {
         goto out;
     }
 
@@ -276,7 +288,7 @@ static void qed_clear_need_check(void *opaque, int ret)
     ret = qed_write_header(s);
     (void) ret;
 
-    ret = bdrv_flush(s->bs);
+    ret = bdrv_co_flush(s->bs);
     (void) ret;
 
 out:
@@ -285,19 +297,8 @@ out:
 
 static void qed_need_check_timer_cb(void *opaque)
 {
-    BDRVQEDState *s = opaque;
-
-    /* The timer should only fire when allocating writes have drained */
-    assert(!s->allocating_acb);
-
-    trace_qed_need_check_timer_cb(s);
-
-    qed_acquire(s);
-    qed_plug_allocating_write_reqs(s);
-
-    /* Ensure writes are on disk before clearing flag */
-    bdrv_aio_flush(s->bs->file->bs, qed_clear_need_check, s);
-    qed_release(s);
+    Coroutine *co = qemu_coroutine_create(qed_need_check_timer_entry, opaque);
+    qemu_coroutine_enter(co);
 }
 
 void qed_acquire(BDRVQEDState *s)
-- 
1.8.3.1
