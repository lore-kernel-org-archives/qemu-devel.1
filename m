Received: from eggs.gnu.org ([2001:4830:134:3::10]:57992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rG-0002c6-Ab
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rD-0007MD-91
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:46 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:19:00 +0200
Message-Id: <20181001171901.11004-23-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 22/23] test-replication: Lock AioContext around
 blk_unref()
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

Recently, the test case has started failing because some job related
functions want to drop the AioContext lock even though it hasn't been
taken:

    (gdb) bt
    #0  0x00007f51c067c9fb in raise () from /lib64/libc.so.6
    #1  0x00007f51c067e77d in abort () from /lib64/libc.so.6
    #2  0x0000558c9d5dde7b in error_exit (err=<optimized out>, msg=msg@entry=0x558c9d6fe120 <__func__.18373> "qemu_mutex_unlock_impl") at util/qemu-thread-posix.c:36
    #3  0x0000558c9d6b5263 in qemu_mutex_unlock_impl (mutex=mutex@entry=0x558c9f3999a0, file=file@entry=0x558c9d6fd36f "util/async.c", line=line@entry=516) at util/qemu-thread-posix.c:96
    #4  0x0000558c9d6b0565 in aio_context_release (ctx=ctx@entry=0x558c9f399940) at util/async.c:516
    #5  0x0000558c9d5eb3da in job_completed_txn_abort (job=0x558c9f68e640) at job.c:738
    #6  0x0000558c9d5eb227 in job_finish_sync (job=0x558c9f68e640, finish=finish@entry=0x558c9d5eb8d0 <job_cancel_err>, errp=errp@entry=0x0) at job.c:986
    #7  0x0000558c9d5eb8ee in job_cancel_sync (job=<optimized out>) at job.c:941
    #8  0x0000558c9d64d853 in replication_close (bs=<optimized out>) at block/replication.c:148
    #9  0x0000558c9d5e5c9f in bdrv_close (bs=0x558c9f41b020) at block.c:3420
    #10 bdrv_delete (bs=0x558c9f41b020) at block.c:3629
    #11 bdrv_unref (bs=0x558c9f41b020) at block.c:4685
    #12 0x0000558c9d62a3f3 in blk_remove_bs (blk=blk@entry=0x558c9f42a7c0) at block/block-backend.c:783
    #13 0x0000558c9d62a667 in blk_delete (blk=0x558c9f42a7c0) at block/block-backend.c:402
    #14 blk_unref (blk=0x558c9f42a7c0) at block/block-backend.c:457
    #15 0x0000558c9d5dfcea in test_secondary_stop () at tests/test-replication.c:478
    #16 0x00007f51c1f13178 in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
    #17 0x00007f51c1f1337b in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
    #18 0x00007f51c1f1337b in g_test_run_suite_internal () from /lib64/libglib-2.0.so.0
    #19 0x00007f51c1f13552 in g_test_run_suite () from /lib64/libglib-2.0.so.0
    #20 0x00007f51c1f13571 in g_test_run () from /lib64/libglib-2.0.so.0
    #21 0x0000558c9d5de31f in main (argc=<optimized out>, argv=<optimized out>) at tests/test-replication.c:581

It is yet unclear whether this should really be considered a bug in the
test case or whether blk_unref() should work for callers that haven't
taken the AioContext lock, but in order to fix the build tests quickly,
just take the AioContext lock around blk_unref().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-replication.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/test-replication.c b/tests/test-replication.c
index c8165ae954..f085d1993a 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -207,13 +207,17 @@ static BlockBackend *start_primary(void)
 static void teardown_primary(void)
 {
     BlockBackend *blk;
+    AioContext *ctx;
 
     /* remove P_ID */
     blk = blk_by_name(P_ID);
     assert(blk);
 
+    ctx = blk_get_aio_context(blk);
+    aio_context_acquire(ctx);
     monitor_remove_blk(blk);
     blk_unref(blk);
+    aio_context_release(ctx);
 }
 
 static void test_primary_read(void)
@@ -365,20 +369,27 @@ static void teardown_secondary(void)
 {
     /* only need to destroy two BBs */
     BlockBackend *blk;
+    AioContext *ctx;
 
     /* remove S_LOCAL_DISK_ID */
     blk = blk_by_name(S_LOCAL_DISK_ID);
     assert(blk);
 
+    ctx = blk_get_aio_context(blk);
+    aio_context_acquire(ctx);
     monitor_remove_blk(blk);
     blk_unref(blk);
+    aio_context_release(ctx);
 
     /* remove S_ID */
     blk = blk_by_name(S_ID);
     assert(blk);
 
+    ctx = blk_get_aio_context(blk);
+    aio_context_acquire(ctx);
     monitor_remove_blk(blk);
     blk_unref(blk);
+    aio_context_release(ctx);
 }
 
 static void test_secondary_read(void)
-- 
2.13.6
