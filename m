Received: from eggs.gnu.org ([2001:4830:134:3::10]:53616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70m-0002LG-S1
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70l-0005h0-JF
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:04 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 14 Nov 2018 20:03:26 -0600
Message-Id: <20181115020334.1189829-6-eblake@redhat.com>
In-Reply-To: <20181115020334.1189829-1-eblake@redhat.com>
References: <20181115020334.1189829-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/13] block: Switch to 64-bit
 bl.max_transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

This change has no semantic impact: all drivers either leave the
value at 0 (no inherent 32-bit limit is still translated into
fragmentation below 2G; see the previous patch for that audit), or
set it to a value less than 2G.  However, switching to a larger
type and enforcing the 2G cap at the block layer makes it easier
to audit specific drivers for their robustness to larger sizing,
by letting them specify a value larger than INT_MAX if they have
been audited to be 64-bit clean.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block_int.h | 8 +++++---
 block/io.c                | 7 +++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index f605622216d..b19d94dac5f 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -549,9 +549,11 @@ typedef struct BlockLimits {

     /* Maximal transfer length in bytes.  Need not be power of 2, but
      * must be multiple of opt_transfer and bl.request_alignment, or 0
-     * for no 32-bit limit.  For now, anything larger than INT_MAX is
-     * clamped down. */
-    uint32_t max_transfer;
+     * for no 32-bit limit.  The block layer fragments all actions
+     * below 2G, so setting this value to anything larger than INT_MAX
+     * implies that the driver has been audited for 64-bit
+     * cleanness. */
+    uint64_t max_transfer;

     /* memory alignment, in bytes so that no bounce buffer is needed */
     size_t min_mem_alignment;
diff --git a/block/io.c b/block/io.c
index 39d4e7a3ae1..4911a1123eb 100644
--- a/block/io.c
+++ b/block/io.c
@@ -159,6 +159,13 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
     if (drv->bdrv_refresh_limits) {
         drv->bdrv_refresh_limits(bs, errp);
     }
+
+    /* Clamp max_transfer to 2G */
+    if (bs->bl.max_transfer > UINT32_MAX) {
+        bs->bl.max_transfer = QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
+                                              MAX(bs->bl.opt_transfer,
+                                                  bs->bl.request_alignment));
+    }
 }

 /**
-- 
2.17.2
