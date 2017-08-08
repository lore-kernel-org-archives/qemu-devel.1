Received: from eggs.gnu.org ([2001:4830:134:3::10]:37237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df1Li-00059L-7s
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df1Le-00027Y-4g
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:02:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1df1Ld-000270-Qx
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:02:50 -0400
Date: Tue, 8 Aug 2017 12:02:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170808100243.GG4850@dhcp-200-186.str.redhat.com>
References: <20170713190116.21608-1-dgilbert@redhat.com>
	<20170717101703.GH7163@stefanha-x1.localdomain>
	<20170717102642.GG2106@work-vm>
	<c6161e7a-9b03-16bf-fb20-86df6f3fd9bc@redhat.com>
	<CAJSP0QWd7gtV21Hpr3noA0odAMhdriNkaqJtLJvbSNzoErvFdQ@mail.gmail.com>
	<9e79cd50-c23a-2b96-4206-f505993179f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e79cd50-c23a-2b96-4206-f505993179f5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Prasad Pandit <ppandit@redhat.com>

Am 04.08.2017 um 13:46 hat Paolo Bonzini geschrieben:
> On 04/08/2017 11:58, Stefan Hajnoczi wrote:
> >> the root cause of this bug is related to this as well:
> >> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg02945.html
> >>
> >> From commit 99723548 we started assuming (incorrectly?) that blk_
> >> functions always WILL have an attached BDS, but this is not always true,
> >> for instance, flushing the cache from an empty CDROM.
> >>
> >> Paolo, can we move the flight counter increment outside of the
> >> block-backend layer, is that safe?
> > I think the bdrv_inc_in_flight(blk_bs(blk)) needs to be fixed
> > regardless of the throttling timer issue discussed below.  BB cannot
> > assume that the BDS graph is non-empty.
> 
> Can we make bdrv_aio_* return NULL (even temporarily) if there is no
> attached BDS?  That would make it much easier to fix.

Would the proper fix be much more complicated than the following? I must
admit that I don't fully understand the current state of affairs with
respect to threading, AioContext etc. so I may well be missing
something.

Note that my blk_drain() implementation doesn't necessarily drain
blk_bs(blk) completely, but only those requests that came from the
specific BlockBackend. I think this is what the callers want, but
if otherwise, it shouldn't be hard to change.

Kevin

diff --git a/block.c b/block.c
index f1c3e98a4d..07decc3b5f 100644
--- a/block.c
+++ b/block.c
@@ -4563,7 +4563,7 @@ out:
 
 AioContext *bdrv_get_aio_context(BlockDriverState *bs)
 {
-    return bs->aio_context;
+    return bs ? bs->aio_context : qemu_get_aio_context();
 }
 
 void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *co)
diff --git a/block/block-backend.c b/block/block-backend.c
index 968438c149..649d11b4ef 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -68,6 +68,9 @@ struct BlockBackend {
     NotifierList remove_bs_notifiers, insert_bs_notifiers;
 
     int quiesce_counter;
+
+    /* Number of in-flight requests. Accessed with atomic ops. */
+    unsigned int in_flight;
 };
 
 typedef struct BlockBackendAIOCB {
@@ -1109,6 +1112,16 @@ int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags)
     return bdrv_make_zero(blk->root, flags);
 }
 
+static void blk_inc_in_flight(BlockBackend *blk)
+{
+    atomic_inc(&blk->in_flight);
+}
+
+static void blk_dec_in_flight(BlockBackend *blk)
+{
+    atomic_dec(&blk->in_flight);
+}
+
 static void error_callback_bh(void *opaque)
 {
     struct BlockBackendAIOCB *acb = opaque;
@@ -1147,7 +1160,7 @@ static const AIOCBInfo blk_aio_em_aiocb_info = {
 static void blk_aio_complete(BlkAioEmAIOCB *acb)
 {
     if (acb->has_returned) {
-        bdrv_dec_in_flight(acb->common.bs);
+        blk_dec_in_flight(acb->rwco.blk);
         acb->common.cb(acb->common.opaque, acb->rwco.ret);
         qemu_aio_unref(acb);
     }
@@ -1168,7 +1181,7 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
     BlkAioEmAIOCB *acb;
     Coroutine *co;
 
-    bdrv_inc_in_flight(blk_bs(blk));
+    blk_inc_in_flight(blk);
     acb = blk_aio_get(&blk_aio_em_aiocb_info, blk, cb, opaque);
     acb->rwco = (BlkRwCo) {
         .blk    = blk,
@@ -1405,8 +1418,16 @@ int blk_flush(BlockBackend *blk)
 
 void blk_drain(BlockBackend *blk)
 {
-    if (blk_bs(blk)) {
-        bdrv_drain(blk_bs(blk));
+    AioContext *ctx = blk_get_aio_context(blk);
+
+    while (atomic_read(&blk->in_flight)) {
+        aio_context_acquire(ctx);
+        aio_poll(ctx, false);
+        aio_context_release(ctx);
+
+        if (blk_bs(blk)) {
+            bdrv_drain(blk_bs(blk));
+        }
     }
 }
 
@@ -1453,10 +1474,11 @@ static void send_qmp_error_event(BlockBackend *blk,
                                  bool is_read, int error)
 {
     IoOperationType optype;
+    BlockDriverState *bs = blk_bs(blk);
 
     optype = is_read ? IO_OPERATION_TYPE_READ : IO_OPERATION_TYPE_WRITE;
     qapi_event_send_block_io_error(blk_name(blk),
-                                   bdrv_get_node_name(blk_bs(blk)), optype,
+                                   bs ? bdrv_get_node_name(bs) : "", optype,
                                    action, blk_iostatus_is_enabled(blk),
                                    error == ENOSPC, strerror(error),
                                    &error_abort);
diff --git a/tests/ide-test.c b/tests/ide-test.c
index bfd79ddbdc..ffbfb04271 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -689,6 +689,24 @@ static void test_flush_nodev(void)
     ide_test_quit();
 }
 
+static void test_flush_empty_drive(void)
+{
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar;
+
+    ide_test_start("-device ide-cd,bus=ide.0");
+    dev = get_pci_device(&bmdma_bar, &ide_bar);
+
+    /* FLUSH CACHE command on device 0*/
+    qpci_io_writeb(dev, ide_bar, reg_device, 0);
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_FLUSH_CACHE);
+
+    /* Just testing that qemu doesn't crash... */
+
+    free_pci_device(dev);
+    ide_test_quit();
+}
+
 static void test_pci_retry_flush(void)
 {
     test_retry_flush("pc");
@@ -954,6 +972,7 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ide/flush", test_flush);
     qtest_add_func("/ide/flush/nodev", test_flush_nodev);
+    qtest_add_func("/ide/flush/empty_drive", test_flush_empty_drive);
     qtest_add_func("/ide/flush/retry_pci", test_pci_retry_flush);
     qtest_add_func("/ide/flush/retry_isa", test_isa_retry_flush);
 
diff --git a/tests/test-block-backend.c b/tests/test-block-backend.c
new file mode 100644
index 0000000000..5348781a42
--- /dev/null
+++ b/tests/test-block-backend.c
@@ -0,0 +1,62 @@
+/*
+ * BlockBackend tests
+ *
+ * Copyright (c) 2017 Kevin Wolf <kwolf@redhat.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "block/block.h"
+#include "sysemu/block-backend.h"
+#include "qapi/error.h"
+
+static void test_drain_aio_error_flush_cb(void *opaque, int ret)
+{
+    bool *completed = opaque;
+
+    g_assert(ret == -ENOMEDIUM);
+    *completed = true;
+}
+
+static void test_drain_aio_error(void)
+{
+    BlockBackend *blk = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    BlockAIOCB *acb;
+    bool completed = false;
+
+    acb = blk_aio_flush(blk, test_drain_aio_error_flush_cb, &completed);
+    g_assert(acb != NULL);
+    g_assert(completed == false);
+
+    blk_drain(blk);
+    g_assert(completed == true);
+}
+
+int main(int argc, char **argv)
+{
+    bdrv_init();
+    qemu_init_main_loop(&error_abort);
+
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/block-backend/drain_aio_error", test_drain_aio_error);
+
+    return g_test_run();
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 59e536bf0b..7beb65397b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -56,6 +56,7 @@ check-unit-y += tests/test-hbitmap$(EXESUF)
 gcov-files-test-hbitmap-y = blockjob.c
 check-unit-y += tests/test-blockjob$(EXESUF)
 check-unit-y += tests/test-blockjob-txn$(EXESUF)
+check-unit-y += tests/test-block-backend$(EXESUF)
 check-unit-y += tests/test-x86-cpuid$(EXESUF)
 # all code tested by test-x86-cpuid is inside topology.h
 gcov-files-test-x86-cpuid-y =
@@ -556,6 +557,7 @@ tests/test-aio-multithread$(EXESUF): tests/test-aio-multithread.o $(test-block-o
 tests/test-throttle$(EXESUF): tests/test-throttle.o $(test-block-obj-y)
 tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y) $(test-util-obj-y)
 tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block-obj-y) $(test-util-obj-y)
+tests/test-block-backend$(EXESUF): tests/test-block-backend.o $(test-block-obj-y) $(test-util-obj-y)
 tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
 tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
 tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
