Received: from eggs.gnu.org ([2001:4830:134:3::10]:54203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dEA3k-0004L3-W1
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dEA3k-0006CC-8T
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:53:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dEA3k-0006C5-3G
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:53:20 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 May 2017 15:52:34 +0800
Message-Id: <20170526075246.20265-11-famz@redhat.com>
In-Reply-To: <20170526075246.20265-1-famz@redhat.com>
References: <20170526075246.20265-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 10/22] block: access io_plugged with atomic ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170525163225.29954-7-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
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
2.9.4
