Received: from eggs.gnu.org ([2001:4830:134:3::10]:35573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fAxgL-0007gm-6n
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fAxgG-0005V0-Gy
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:08:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 24 Apr 2018 16:08:21 +0300
Message-Id: <20180424130821.50987-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180424130821.50987-1-vsementsov@virtuozzo.com>
References: <20180424130821.50987-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [RFC 3/3] blk: add 'reconnect' error action
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, famz@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

New action works as follows:

Firstly, not stopping the vm, it tries to bdrv_reconnect several times
with given pause. Then, if we failed to reconnect fallthrough to 'stop'
error action.

TODO:
 - qapi docs
 - support other disks (only scsi here)
 - support block jobs
 - add configuration of timeout and tries count parameters

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json  |  4 ++--
 block/block-backend.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 hw/scsi/scsi-disk.c   |  4 +++-
 3 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index c50517bff3..d4d87dbd4f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1028,7 +1028,7 @@
 # Since: 1.3
 ##
 { 'enum': 'BlockdevOnError',
-  'data': ['report', 'ignore', 'enospc', 'stop', 'auto'] }
+  'data': ['report', 'ignore', 'enospc', 'stop', 'auto', 'reconnect'] }
 
 ##
 # @MirrorSyncMode:
@@ -4351,7 +4351,7 @@
 # Since: 2.1
 ##
 { 'enum': 'BlockErrorAction',
-  'data': [ 'ignore', 'report', 'stop' ] }
+  'data': [ 'ignore', 'report', 'stop', 'reconnect' ] }
 
 
 ##
diff --git a/block/block-backend.c b/block/block-backend.c
index 681b240b12..81eb9a7bd0 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -89,6 +89,11 @@ struct BlockBackend {
      */
     unsigned int in_flight;
     AioWait wait;
+
+    bool reconnect_failed; /* TODO: worth tri-state variable? */
+    bool reconnecting;
+    unsigned int reconnect_max;
+    uint64_t reconnect_ns;
 };
 
 typedef struct BlockBackendAIOCB {
@@ -322,6 +327,8 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
     blk->refcnt = 1;
     blk->perm = perm;
     blk->shared_perm = shared_perm;
+    blk->reconnect_max = 10; /* TODO configure */
+    blk->reconnect_ns = 5000000000; /* 5 seconds, TODO configure */
     blk_set_enable_write_cache(blk, true);
 
     block_acct_init(&blk->stats);
@@ -1079,6 +1086,7 @@ void blk_iostatus_disable(BlockBackend *blk)
 
 void blk_iostatus_reset(BlockBackend *blk)
 {
+    blk->reconnect_failed = false;
     if (blk_iostatus_is_enabled(blk)) {
         BlockDriverState *bs = blk_bs(blk);
         blk->iostatus = BLOCK_DEVICE_IO_STATUS_OK;
@@ -1635,6 +1643,9 @@ BlockErrorAction blk_get_error_action(BlockBackend *blk, bool is_read,
     BlockdevOnError on_err = blk_get_on_error(blk, is_read);
 
     switch (on_err) {
+    case BLOCKDEV_ON_ERROR_RECONNECT:
+        return blk->reconnect_failed ? BLOCK_ERROR_ACTION_STOP :
+                                       BLOCK_ERROR_ACTION_RECONNECT;
     case BLOCKDEV_ON_ERROR_ENOSPC:
         return (error == ENOSPC) ?
                BLOCK_ERROR_ACTION_STOP : BLOCK_ERROR_ACTION_REPORT;
@@ -1665,6 +1676,29 @@ static void send_qmp_error_event(BlockBackend *blk,
                                    &error_abort);
 }
 
+
+static void coroutine_fn blk_reconnect_co(void *opaque)
+{
+    BlockBackend *blk = opaque;
+    int i;
+
+    for (i = 0; i < blk->reconnect_max; i++) {
+        int ret;
+
+        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, blk->reconnect_ns);
+
+        ret = bdrv_reconnect(blk_bs(blk), NULL);
+        if (ret == 0) {
+            blk->reconnecting = false;
+            blk_iostatus_reset(blk);
+            return;
+        }
+    }
+
+    blk->reconnecting = false;
+    blk->reconnect_failed = true;
+}
+
 /* This is done by device models because, while the block layer knows
  * about the error, it does not know whether an operation comes from
  * the device or the block layer (from a job, for example).
@@ -1674,7 +1708,19 @@ void blk_error_action(BlockBackend *blk, BlockErrorAction action,
 {
     assert(error >= 0);
 
-    if (action == BLOCK_ERROR_ACTION_STOP) {
+    if (action == BLOCK_ERROR_ACTION_RECONNECT) {
+        Coroutine *co;
+        blk_iostatus_set_err(blk, error);
+
+        if (blk->reconnecting || blk->reconnect_failed) {
+            return;
+        }
+
+        blk->reconnecting = true;
+
+        co = qemu_coroutine_create(blk_reconnect_co, blk);
+        aio_co_enter(blk_get_aio_context(blk), co);
+    } else if (action == BLOCK_ERROR_ACTION_STOP) {
         /* First set the iostatus, so that "info block" returns an iostatus
          * that matches the events raised so far (an additional error iostatus
          * is fine, but not a lost one).
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index ded23d36ca..f1c166dfda 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -474,7 +474,9 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
     }
 
     blk_error_action(s->qdev.conf.blk, action, is_read, error);
-    if (action == BLOCK_ERROR_ACTION_STOP) {
+    if (action == BLOCK_ERROR_ACTION_STOP ||
+        action == BLOCK_ERROR_ACTION_RECONNECT)
+    {
         scsi_req_retry(&r->req);
     }
     return action != BLOCK_ERROR_ACTION_IGNORE;
-- 
2.11.1
