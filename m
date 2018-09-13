Received: from eggs.gnu.org ([2001:4830:134:3::10]:47114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7c-0002dh-0F
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7b-0002FC-7T
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Sep 2018 14:52:15 +0200
Message-Id: <20180913125217.23173-16-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-1-kwolf@redhat.com>
References: <20180913125217.23173-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/17] test-bdrv-drain: Test nested poll in
 bdrv_drain_poll_top_level()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

This is a regression test for a deadlock that could occur in callbacks
called from the aio_poll() in bdrv_drain_poll_top_level(). The
AioContext lock wasn't released and therefore would be taken a second
time in the callback. This would cause a possible AIO_WAIT_WHILE() in
the callback to hang.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 tests/test-bdrv-drain.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index c3c17b9ff7..e105c0ae84 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -636,6 +636,17 @@ static void test_iothread_aio_cb(void *opaque, int ret)
     qemu_event_set(&done_event);
 }
 
+static void test_iothread_main_thread_bh(void *opaque)
+{
+    struct test_iothread_data *data = opaque;
+
+    /* Test that the AioContext is not yet locked in a random BH that is
+     * executed during drain, otherwise this would deadlock. */
+    aio_context_acquire(bdrv_get_aio_context(data->bs));
+    bdrv_flush(data->bs);
+    aio_context_release(bdrv_get_aio_context(data->bs));
+}
+
 /*
  * Starts an AIO request on a BDS that runs in the AioContext of iothread 1.
  * The request involves a BH on iothread 2 before it can complete.
@@ -705,6 +716,8 @@ static void test_iothread_common(enum drain_type drain_type, int drain_thread)
             aio_context_acquire(ctx_a);
         }
 
+        aio_bh_schedule_oneshot(ctx_a, test_iothread_main_thread_bh, &data);
+
         /* The request is running on the IOThread a. Draining its block device
          * will make sure that it has completed as far as the BDS is concerned,
          * but the drain in this thread can continue immediately after
-- 
2.13.6
