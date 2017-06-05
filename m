Received: from eggs.gnu.org ([2001:4830:134:3::10]:41688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrI5-0008TN-4o
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrI4-0005xH-B4
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHrI4-0005wr-5Z
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:24 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C25720264
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 12:39:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Jun 2017 14:39:00 +0200
Message-Id: <20170605123908.18777-12-pbonzini@redhat.com>
In-Reply-To: <20170605123908.18777-1-pbonzini@redhat.com>
References: <20170605123908.18777-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 11/19] block: use Stat64 for wr_highest_offset
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
 block/io.c                | 4 +---
 block/qapi.c              | 2 +-
 include/block/block_int.h | 7 ++++---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index bb1c9c5432..bc69b4cecd 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1405,9 +1405,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     ++bs->write_gen;
     bdrv_set_dirty(bs, start_sector, end_sector - start_sector);
 
-    if (bs->wr_highest_offset < offset + bytes) {
-        bs->wr_highest_offset = offset + bytes;
-    }
+    stat64_max(&bs->wr_highest_offset, offset + bytes);
 
     if (ret >= 0) {
         bs->total_sectors = MAX(bs->total_sectors, end_sector);
diff --git a/block/qapi.c b/block/qapi.c
index a40922ea26..14b60ae66c 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -441,7 +441,7 @@ static BlockStats *bdrv_query_bds_stats(const BlockDriverState *bs,
         s->node_name = g_strdup(bdrv_get_node_name(bs));
     }
 
-    s->stats->wr_highest_offset = bs->wr_highest_offset;
+    s->stats->wr_highest_offset = stat64_get(&bs->wr_highest_offset);
 
     if (bs->file) {
         s->has_parent = true;
diff --git a/include/block/block_int.h b/include/block/block_int.h
index d11417e60a..8f36d1fc1d 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -29,6 +29,7 @@
 #include "qemu/option.h"
 #include "qemu/queue.h"
 #include "qemu/coroutine.h"
+#include "qemu/stats64.h"
 #include "qemu/timer.h"
 #include "qapi-types.h"
 #include "qemu/hbitmap.h"
@@ -604,9 +605,6 @@ struct BlockDriverState {
     /* Callback before write request is processed */
     NotifierWithReturnList before_write_notifiers;
 
-    /* Offset after the highest byte written to */
-    uint64_t wr_highest_offset;
-
     /* threshold limit for writes, in bytes. "High water mark". */
     uint64_t write_threshold_offset;
     NotifierWithReturn write_threshold_notifier;
@@ -619,6 +617,9 @@ struct BlockDriverState {
 
     QLIST_HEAD(, BdrvDirtyBitmap) dirty_bitmaps;
 
+    /* Offset after the highest byte written to */
+    Stat64 wr_highest_offset;
+
     /* If true, copy read backing sectors into image.  Can be >1 if more
      * than one client has requested copy-on-read.  Accessed with atomic
      * ops.
-- 
2.13.0
