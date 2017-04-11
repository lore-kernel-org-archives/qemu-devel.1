Received: from eggs.gnu.org ([2001:4830:134:3::10]:39218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxut1-0004IK-24
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxusz-0003zv-Ce
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:27:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cxusz-0003yH-3y
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:27:05 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 11 Apr 2017 20:26:30 +0800
Message-Id: <20170411122632.14050-10-famz@redhat.com>
In-Reply-To: <20170411122632.14050-1-famz@redhat.com>
References: <20170411122632.14050-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 09/11] block: Use bdrv_coroutine_enter to start
 I/O coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, famz@redhat.com

BDRV_POLL_WHILE waits for the started I/O by releasing bs's ctx then polling
the main context, which relies on the yielded coroutine continuing on bs->ctx
before notifying qemu_aio_context with bdrv_wakeup().

Thus, using qemu_coroutine_enter to start I/O is wrong because if the coroutine
is entered from main loop, co->ctx will be qemu_aio_context, as a result of the
"release, poll, acquire" loop of BDRV_POLL_WHILE, race conditions happen when
both main thread and the iothread access the same BDS:

  main loop                                iothread
-----------------------------------------------------------------------
  blockdev_snapshot
    aio_context_acquire(bs->ctx)
                                           virtio_scsi_data_plane_handle_cmd
    bdrv_drained_begin(bs->ctx)
    bdrv_flush(bs)
      bdrv_co_flush(bs)                      aio_context_acquire(bs->ctx).enter
        ...
        qemu_coroutine_yield(co)
      BDRV_POLL_WHILE()
        aio_context_release(bs->ctx)
                                             aio_context_acquire(bs->ctx).return
                                               ...
                                                 aio_co_wake(co)
        aio_poll(qemu_aio_context)               ...
          co_schedule_bh_cb()                    ...
            qemu_coroutine_enter(co)             ...

              /* (A) bdrv_co_flush(bs)           /* (B) I/O on bs */
                      continues... */
                                             aio_context_release(bs->ctx)
        aio_context_acquire(bs->ctx)

Note that in above case, bdrv_drained_begin() doesn't do the "release,
poll, acquire" in BDRV_POLL_WHILE, because bs->in_flight == 0.

Fix this by using bdrv_coroutine_enter and enter coroutine in the right
context.

iotests 109 output is updated because the coroutine reenter flow during
mirror job complete is different (now through co_queue_wakeup, instead
of the unconditional qemu_coroutine_switch before), making the end job
len different.

Signed-off-by: Fam Zheng <famz@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c      |  4 ++--
 block/io.c                 | 14 +++++++-------
 tests/qemu-iotests/109.out | 10 +++++-----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 18ece99..a8f2b34 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1045,7 +1045,7 @@ static int blk_prw(BlockBackend *blk, int64_t offset, uint8_t *buf,
         co_entry(&rwco);
     } else {
         Coroutine *co = qemu_coroutine_create(co_entry, &rwco);
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(blk_bs(blk), co);
         BDRV_POLL_WHILE(blk_bs(blk), rwco.ret == NOT_DONE);
     }
 
@@ -1152,7 +1152,7 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
     acb->has_returned = false;
 
     co = qemu_coroutine_create(co_entry, acb);
-    qemu_coroutine_enter(co);
+    bdrv_coroutine_enter(blk_bs(blk), co);
 
     acb->has_returned = true;
     if (acb->rwco.ret != NOT_DONE) {
diff --git a/block/io.c b/block/io.c
index 9598646..00e45ca 100644
--- a/block/io.c
+++ b/block/io.c
@@ -616,7 +616,7 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
         bdrv_rw_co_entry(&rwco);
     } else {
         co = qemu_coroutine_create(bdrv_rw_co_entry, &rwco);
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(child->bs, co);
         BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
     }
     return rwco.ret;
@@ -1880,7 +1880,7 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
     } else {
         co = qemu_coroutine_create(bdrv_get_block_status_above_co_entry,
                                    &data);
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, !data.done);
     }
     return data.ret;
@@ -2006,7 +2006,7 @@ bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
         };
         Coroutine *co = qemu_coroutine_create(bdrv_co_rw_vmstate_entry, &data);
 
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(bs, co);
         while (data.ret == -EINPROGRESS) {
             aio_poll(bdrv_get_aio_context(bs), true);
         }
@@ -2223,7 +2223,7 @@ static BlockAIOCB *bdrv_co_aio_prw_vector(BdrvChild *child,
     acb->is_write = is_write;
 
     co = qemu_coroutine_create(bdrv_co_do_rw, acb);
-    qemu_coroutine_enter(co);
+    bdrv_coroutine_enter(child->bs, co);
 
     bdrv_co_maybe_schedule_bh(acb);
     return &acb->common;
@@ -2254,7 +2254,7 @@ BlockAIOCB *bdrv_aio_flush(BlockDriverState *bs,
     acb->req.error = -EINPROGRESS;
 
     co = qemu_coroutine_create(bdrv_aio_flush_co_entry, acb);
-    qemu_coroutine_enter(co);
+    bdrv_coroutine_enter(bs, co);
 
     bdrv_co_maybe_schedule_bh(acb);
     return &acb->common;
@@ -2387,7 +2387,7 @@ int bdrv_flush(BlockDriverState *bs)
         bdrv_flush_co_entry(&flush_co);
     } else {
         co = qemu_coroutine_create(bdrv_flush_co_entry, &flush_co);
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, flush_co.ret == NOT_DONE);
     }
 
@@ -2534,7 +2534,7 @@ int bdrv_pdiscard(BlockDriverState *bs, int64_t offset, int count)
         bdrv_pdiscard_co_entry(&rwco);
     } else {
         co = qemu_coroutine_create(bdrv_pdiscard_co_entry, &rwco);
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, rwco.ret == NOT_DONE);
     }
 
diff --git a/tests/qemu-iotests/109.out b/tests/qemu-iotests/109.out
index e5d70d7..55fe536 100644
--- a/tests/qemu-iotests/109.out
+++ b/tests/qemu-iotests/109.out
@@ -10,7 +10,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 1024, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -73,7 +73,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 1024, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -115,7 +115,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2560, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -135,7 +135,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2560, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -195,7 +195,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2048, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.9.3
