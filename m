Received: from eggs.gnu.org ([2001:4830:134:3::10]:59221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhbaE-0008Ba-GK
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhbaD-0007kD-Me
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:08:34 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 15 Aug 2017 21:07:38 +0800
Message-Id: <20170815130740.31229-3-famz@redhat.com>
In-Reply-To: <20170815130740.31229-1-famz@redhat.com>
References: <20170815130740.31229-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 v2 2/4] nbd: Fix order of
 bdrv_set_perm and bdrv_invalidate_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, stefanha@redhat.com

From: Kevin Wolf <kwolf@redhat.com>

The "inactive" state of BDS affects whether the permissions can be
granted, we must call bdrv_invalidate_cache before bdrv_set_perm to
support "-incoming defer" case.

Reported-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 nbd/server.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 82a78bf439..b68b6fb535 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1045,11 +1045,22 @@ NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t size,
                           bool writethrough, BlockBackend *on_eject_blk,
                           Error **errp)
 {
+    AioContext  *ctx;
     BlockBackend *blk;
     NBDExport *exp = g_malloc0(sizeof(NBDExport));
     uint64_t perm;
     int ret;
 
+    /*
+     * NBD exports are used for non-shared storage migration.  Make sure
+     * that BDRV_O_INACTIVE is cleared and the image is ready for write
+     * access since the export could be available before migration handover.
+     */
+    ctx = bdrv_get_aio_context(bs);
+    aio_context_acquire(ctx);
+    bdrv_invalidate_cache(bs, NULL);
+    aio_context_release(ctx);
+
     /* Don't allow resize while the NBD server is running, otherwise we don't
      * care what happens with the node. */
     perm = BLK_PERM_CONSISTENT_READ;
@@ -1087,15 +1098,6 @@ NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t size,
         exp->eject_notifier.notify = nbd_eject_notifier;
         blk_add_remove_bs_notifier(on_eject_blk, &exp->eject_notifier);
     }
-
-    /*
-     * NBD exports are used for non-shared storage migration.  Make sure
-     * that BDRV_O_INACTIVE is cleared and the image is ready for write
-     * access since the export could be available before migration handover.
-     */
-    aio_context_acquire(exp->ctx);
-    blk_invalidate_cache(blk, NULL);
-    aio_context_release(exp->ctx);
     return exp;
 
 fail:
-- 
2.13.4
