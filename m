Received: from eggs.gnu.org ([2001:4830:134:3::10]:60208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cfkMN-0007Ky-Ly
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cfkMI-0007Tl-Kn
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:34:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cfkM0-0007JT-1J
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:34:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 20 Feb 2017 09:32:58 +0000
Message-Id: <20170220093304.20515-19-stefanha@redhat.com>
In-Reply-To: <20170220093304.20515-1-stefanha@redhat.com>
References: <20170220093304.20515-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 18/24] block: document fields protected by
 AioContext lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170213135235.12274-19-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block_int.h      | 64 +++++++++++++++++++++++++-----------------
 include/sysemu/block-backend.h | 14 ++++++---
 2 files changed, 49 insertions(+), 29 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 2d92d7e..1670941 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -430,8 +430,9 @@ struct BdrvChild {
  * copied as well.
  */
 struct BlockDriverState {
-    int64_t total_sectors; /* if we are reading a disk image, give its
-                              size in sectors */
+    /* Protected by big QEMU lock or read-only after opening.  No special
+     * locking needed during I/O...
+     */
     int open_flags; /* flags used to open the file, re-used for re-open */
     bool read_only; /* if true, the media is read only */
     bool encrypted; /* if true, the media is encrypted */
@@ -439,14 +440,6 @@ struct BlockDriverState {
     bool sg;        /* if true, the device is a /dev/sg* */
     bool probed;    /* if true, format was probed rather than specified */
 
-    int copy_on_read; /* if nonzero, copy read backing sectors into image.
-                         note this is a reference count */
-
-    CoQueue flush_queue;            /* Serializing flush queue */
-    bool active_flush_req;          /* Flush request in flight? */
-    unsigned int write_gen;         /* Current data generation */
-    unsigned int flushed_gen;       /* Flushed write generation */
-
     BlockDriver *drv; /* NULL means no media */
     void *opaque;
 
@@ -468,18 +461,6 @@ struct BlockDriverState {
     BdrvChild *backing;
     BdrvChild *file;
 
-    /* Callback before write request is processed */
-    NotifierWithReturnList before_write_notifiers;
-
-    /* number of in-flight requests; overall and serialising */
-    unsigned int in_flight;
-    unsigned int serialising_in_flight;
-
-    bool wakeup;
-
-    /* Offset after the highest byte written to */
-    uint64_t wr_highest_offset;
-
     /* I/O Limits */
     BlockLimits bl;
 
@@ -497,11 +478,8 @@ struct BlockDriverState {
     QTAILQ_ENTRY(BlockDriverState) bs_list;
     /* element of the list of monitor-owned BDS */
     QTAILQ_ENTRY(BlockDriverState) monitor_list;
-    QLIST_HEAD(, BdrvDirtyBitmap) dirty_bitmaps;
     int refcnt;
 
-    QLIST_HEAD(, BdrvTrackedRequest) tracked_requests;
-
     /* operation blockers */
     QLIST_HEAD(, BdrvOpBlocker) op_blockers[BLOCK_OP_TYPE_MAX];
 
@@ -522,6 +500,31 @@ struct BlockDriverState {
     /* The error object in use for blocking operations on backing_hd */
     Error *backing_blocker;
 
+    /* Protected by AioContext lock */
+
+    /* If true, copy read backing sectors into image.  Can be >1 if more
+     * than one client has requested copy-on-read.
+     */
+    int copy_on_read;
+
+    /* If we are reading a disk image, give its size in sectors.
+     * Generally read-only; it is written to by load_vmstate and save_vmstate,
+     * but the block layer is quiescent during those.
+     */
+    int64_t total_sectors;
+
+    /* Callback before write request is processed */
+    NotifierWithReturnList before_write_notifiers;
+
+    /* number of in-flight requests; overall and serialising */
+    unsigned int in_flight;
+    unsigned int serialising_in_flight;
+
+    bool wakeup;
+
+    /* Offset after the highest byte written to */
+    uint64_t wr_highest_offset;
+
     /* threshold limit for writes, in bytes. "High water mark". */
     uint64_t write_threshold_offset;
     NotifierWithReturn write_threshold_notifier;
@@ -529,6 +532,17 @@ struct BlockDriverState {
     /* counter for nested bdrv_io_plug */
     unsigned io_plugged;
 
+    QLIST_HEAD(, BdrvTrackedRequest) tracked_requests;
+    CoQueue flush_queue;                  /* Serializing flush queue */
+    bool active_flush_req;                /* Flush request in flight? */
+    unsigned int write_gen;               /* Current data generation */
+    unsigned int flushed_gen;             /* Flushed write generation */
+
+    QLIST_HEAD(, BdrvDirtyBitmap) dirty_bitmaps;
+
+    /* do we need to tell the quest if we have a volatile write cache? */
+    int enable_write_cache;
+
     int quiesce_counter;
 };
 
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 6444e41..f365a51 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -64,14 +64,20 @@ typedef struct BlockDevOps {
  * fields that must be public. This is in particular for QLIST_ENTRY() and
  * friends so that BlockBackends can be kept in lists outside block-backend.c */
 typedef struct BlockBackendPublic {
-    /* I/O throttling.
-     * throttle_state tells us if this BlockBackend has I/O limits configured.
-     * io_limits_disabled tells us if they are currently being enforced */
+    /* I/O throttling has its own locking, but also some fields are
+     * protected by the AioContext lock.
+     */
+
+    /* Protected by AioContext lock.  */
     CoQueue      throttled_reqs[2];
+
+    /* Nonzero if the I/O limits are currently being ignored; generally
+     * it is zero.  */
     unsigned int io_limits_disabled;
 
     /* The following fields are protected by the ThrottleGroup lock.
-     * See the ThrottleGroup documentation for details. */
+     * See the ThrottleGroup documentation for details.
+     * throttle_state tells us if I/O limits are configured. */
     ThrottleState *throttle_state;
     ThrottleTimers throttle_timers;
     unsigned       pending_reqs[2];
-- 
2.9.3
