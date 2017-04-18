Received: from eggs.gnu.org ([2001:4830:134:3::10]:57008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0QYM-0000sW-PQ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0QYJ-0005ce-Jy
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:40:10 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 18 Apr 2017 18:39:48 +0800
Message-Id: <20170418103948.13965-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9-rc5 v3] block: Drain BH in
 bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, jcody@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

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

Also because the BH in question can do bdrv_unref and child replacing,
protect @bs carefully to avoid use-after-free.

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

---

v3: Report all aio_poll() progress as waited_. [Kevin]

v2: Do the BH poll in BDRV_POLL_WHILE to cover bdrv_drain_all_begin as
well. [Kevin]
---
 block/io.c            | 10 +++++++---
 include/block/block.h | 22 ++++++++++++++--------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/block/io.c b/block/io.c
index 8706bfa..a472157 100644
--- a/block/io.c
+++ b/block/io.c
@@ -158,7 +158,7 @@ bool bdrv_requests_pending(BlockDriverState *bs)
 
 static bool bdrv_drain_recurse(BlockDriverState *bs)
 {
-    BdrvChild *child;
+    BdrvChild *child, *tmp;
     bool waited;
 
     waited = BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
@@ -167,8 +167,12 @@ static bool bdrv_drain_recurse(BlockDriverState *bs)
         bs->drv->bdrv_drain(bs);
     }
 
-    QLIST_FOREACH(child, &bs->children, next) {
-        waited |= bdrv_drain_recurse(child->bs);
+    QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
+        BlockDriverState *bs = child->bs;
+        assert(bs->refcnt > 0);
+        bdrv_ref(bs);
+        waited |= bdrv_drain_recurse(bs);
+        bdrv_unref(bs);
     }
 
     return waited;
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
