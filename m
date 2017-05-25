Received: from eggs.gnu.org ([2001:4830:134:3::10]:51657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDvgn-0004iC-Az
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDvgm-0003nC-JV
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:32:41 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 May 2017 18:32:13 +0200
Message-Id: <20170525163225.29954-7-pbonzini@redhat.com>
In-Reply-To: <20170525163225.29954-1-pbonzini@redhat.com>
References: <20170525163225.29954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 06/18] block: access io_plugged with atomic ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com, stefanha@redhat.com

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c                | 4 ++--
 include/block/block_int.h | 8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index 3a98b02..f34d030 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2658,7 +2658,7 @@ void bdrv_io_plug(BlockDriverState *bs)
         bdrv_io_plug(child->bs);
     }
 
-    if (bs->io_plugged++ == 0) {
+    if (atomic_fetch_inc(&bs->io_plugged) == 0) {
         BlockDriver *drv = bs->drv;
         if (drv && drv->bdrv_io_plug) {
             drv->bdrv_io_plug(bs);
@@ -2671,7 +2671,7 @@ void bdrv_io_unplug(BlockDriverState *bs)
     BdrvChild *child;
 
     assert(bs->io_plugged);
-    if (--bs->io_plugged == 0) {
+    if (atomic_fetch_dec(&bs->io_plugged) == 1) {
         BlockDriver *drv = bs->drv;
         if (drv && drv->bdrv_io_unplug) {
             drv->bdrv_io_unplug(bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index b690e58..d54ed75 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -611,9 +611,6 @@ struct BlockDriverState {
     uint64_t write_threshold_offset;
     NotifierWithReturn write_threshold_notifier;
 
-    /* counter for nested bdrv_io_plug */
-    unsigned io_plugged;
-
     QLIST_HEAD(, BdrvTrackedRequest) tracked_requests;
     CoQueue flush_queue;                  /* Serializing flush queue */
     bool active_flush_req;                /* Flush request in flight? */
@@ -639,6 +636,11 @@ struct BlockDriverState {
      */
     bool wakeup;
 
+    /* counter for nested bdrv_io_plug.
+     * Accessed with atomic ops.
+    */
+    unsigned io_plugged;
+
     /* do we need to tell the quest if we have a volatile write cache? */
     int enable_write_cache;
 
-- 
1.8.3.1
