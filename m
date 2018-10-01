Received: from eggs.gnu.org ([2001:4830:134:3::10]:57990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rG-0002bz-A4
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rC-0007Ll-V9
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:46 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:19:01 +0200
Message-Id: <20181001171901.11004-24-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 23/23] tests/test-bdrv-drain: Fix too late
 qemu_event_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

qemu_event_reset() must be called before the AIO request in a different
iothread is submitted. Otherwise the request could be completed before
we do the qemu_event_reset() and the test would hang in
qemu_event_wait().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Tested-by: Max Reitz <mreitz@redhat.com>
---
 tests/test-bdrv-drain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index c9f29c8b10..ee1740ff06 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -694,6 +694,8 @@ static void test_iothread_common(enum drain_type drain_type, int drain_thread)
     s->bh_indirection_ctx = ctx_b;
 
     aio_ret = -EINPROGRESS;
+    qemu_event_reset(&done_event);
+
     if (drain_thread == 0) {
         acb = blk_aio_preadv(blk, 0, &qiov, 0, test_iothread_aio_cb, &aio_ret);
     } else {
@@ -723,7 +725,6 @@ static void test_iothread_common(enum drain_type drain_type, int drain_thread)
          * but the drain in this thread can continue immediately after
          * bdrv_dec_in_flight() and aio_ret might be assigned only slightly
          * later. */
-        qemu_event_reset(&done_event);
         do_drain_begin(drain_type, bs);
         g_assert_cmpint(bs->in_flight, ==, 0);
 
@@ -743,7 +744,6 @@ static void test_iothread_common(enum drain_type drain_type, int drain_thread)
         }
         break;
     case 1:
-        qemu_event_reset(&done_event);
         aio_bh_schedule_oneshot(ctx_a, test_iothread_drain_entry, &data);
         qemu_event_wait(&done_event);
         break;
-- 
2.13.6
