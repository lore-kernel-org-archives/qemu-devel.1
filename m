Received: from eggs.gnu.org ([2001:4830:134:3::10]:48890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0UdY-0002F9-BZ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0UdX-0003xY-6d
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:01:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d0UdW-0003xF-U7
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:01:47 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 18 Apr 2017 23:01:33 +0800
Message-Id: <20170418150133.22436-3-famz@redhat.com>
In-Reply-To: <20170418150133.22436-1-famz@redhat.com>
References: <20170418150133.22436-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] block: Drain BH in bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>

During block job completion, nothing is preventing
block_job_defer_to_main_loop_bh from being called in a nested
aio_poll(), which is a trouble, such as in this code path:

    qmp_block_commit
      commit_active_start
        bdrv_reopen
          bdrv_reopen_multiple
            bdrv_reopen_prepare
              bdrv_flush
                aio_poll
                  aio_bh_poll
                    aio_bh_call
                      block_job_defer_to_main_loop_bh
                        stream_complete
                          bdrv_reopen

block_job_defer_to_main_loop_bh is the last step of the stream job,
which should have been "paused" by the bdrv_drained_begin/end in
bdrv_reopen_multiple, but it is not done because it's in the form of a
main loop BH.

Similar to why block jobs should be paused between drained_begin and
drained_end, BHs they schedule must be excluded as well.  To achieve
this, this patch forces draining the BH in BDRV_POLL_WHILE.

As a side effect this fixes a hang in block_job_detach_aio_context
during system_reset when a block job is ready:

    #0  0x0000555555aa79f3 in bdrv_drain_recurse
    #1  0x0000555555aa825d in bdrv_drained_begin
    #2  0x0000555555aa8449 in bdrv_drain
    #3  0x0000555555a9c356 in blk_drain
    #4  0x0000555555aa3cfd in mirror_drain
    #5  0x0000555555a66e11 in block_job_detach_aio_context
    #6  0x0000555555a62f4d in bdrv_detach_aio_context
    #7  0x0000555555a63116 in bdrv_set_aio_context
    #8  0x0000555555a9d326 in blk_set_aio_context
    #9  0x00005555557e38da in virtio_blk_data_plane_stop
    #10 0x00005555559f9d5f in virtio_bus_stop_ioeventfd
    #11 0x00005555559fa49b in virtio_bus_stop_ioeventfd
    #12 0x00005555559f6a18 in virtio_pci_stop_ioeventfd
    #13 0x00005555559f6a18 in virtio_pci_reset
    #14 0x00005555559139a9 in qdev_reset_one
    #15 0x0000555555916738 in qbus_walk_children
    #16 0x0000555555913318 in qdev_walk_children
    #17 0x0000555555916738 in qbus_walk_children
    #18 0x00005555559168ca in qemu_devices_reset
    #19 0x000055555581fcbb in pc_machine_reset
    #20 0x00005555558a4d96 in qemu_system_reset
    #21 0x000055555577157a in main_loop_should_exit
    #22 0x000055555577157a in main_loop
    #23 0x000055555577157a in main

The rationale is that the loop in block_job_detach_aio_context cannot
make any progress in pausing/completing the job, because bs->in_flight
is 0, so bdrv_drain doesn't process the block_job_defer_to_main_loop
BH. With this patch, it does.

Reported-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170418143044.12187-3-famz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Tested-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/block/block.h | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 97d4330..5ddc0cf 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -381,12 +381,13 @@ void bdrv_drain_all(void);
 
 #define BDRV_POLL_WHILE(bs, cond) ({                       \
     bool waited_ = false;                                  \
+    bool busy_ = true;                                     \
     BlockDriverState *bs_ = (bs);                          \
     AioContext *ctx_ = bdrv_get_aio_context(bs_);          \
     if (aio_context_in_iothread(ctx_)) {                   \
-        while ((cond)) {                                   \
-            aio_poll(ctx_, true);                          \
-            waited_ = true;                                \
+        while ((cond) || busy_) {                          \
+            busy_ = aio_poll(ctx_, (cond));                \
+            waited_ |= !!(cond) | busy_;                   \
         }                                                  \
     } else {                                               \
         assert(qemu_get_current_aio_context() ==           \
@@ -398,11 +399,16 @@ void bdrv_drain_all(void);
          */                                                \
         assert(!bs_->wakeup);                              \
         bs_->wakeup = true;                                \
-        while ((cond)) {                                   \
-            aio_context_release(ctx_);                     \
-            aio_poll(qemu_get_aio_context(), true);        \
-            aio_context_acquire(ctx_);                     \
-            waited_ = true;                                \
+        while (busy_) {                                    \
+            if ((cond)) {                                  \
+                waited_ = busy_ = true;                    \
+                aio_context_release(ctx_);                 \
+                aio_poll(qemu_get_aio_context(), true);    \
+                aio_context_acquire(ctx_);                 \
+            } else {                                       \
+                busy_ = aio_poll(ctx_, false);             \
+                waited_ |= busy_;                          \
+            }                                              \
         }                                                  \
         bs_->wakeup = false;                               \
     }                                                      \
-- 
2.9.3
