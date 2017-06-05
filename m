Received: from eggs.gnu.org ([2001:4830:134:3::10]:41606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrHy-0008Mb-RU
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrHy-0005rJ-1L
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHrHx-0005qv-Ru
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:17 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC73EC04B302
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 12:39:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Jun 2017 14:38:55 +0200
Message-Id: <20170605123908.18777-7-pbonzini@redhat.com>
In-Reply-To: <20170605123908.18777-1-pbonzini@redhat.com>
References: <20170605123908.18777-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 06/19] block: access io_plugged with atomic ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c                | 4 ++--
 include/block/block_int.h | 8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index 4a598299a9..bb1c9c5432 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2645,7 +2645,7 @@ void bdrv_io_plug(BlockDriverState *bs)
         bdrv_io_plug(child->bs);
     }
 
-    if (bs->io_plugged++ == 0) {
+    if (atomic_fetch_inc(&bs->io_plugged) == 0) {
         BlockDriver *drv = bs->drv;
         if (drv && drv->bdrv_io_plug) {
             drv->bdrv_io_plug(bs);
@@ -2658,7 +2658,7 @@ void bdrv_io_unplug(BlockDriverState *bs)
     BdrvChild *child;
 
     assert(bs->io_plugged);
-    if (--bs->io_plugged == 0) {
+    if (atomic_fetch_dec(&bs->io_plugged) == 1) {
         BlockDriver *drv = bs->drv;
         if (drv && drv->bdrv_io_unplug) {
             drv->bdrv_io_unplug(bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index dd09e0071b..d11417e60a 100644
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
2.13.0
