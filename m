Received: from eggs.gnu.org ([2001:4830:134:3::10]:38623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1Aml-0007aT-I6
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1AmY-0002vp-Jg
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:02:07 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Apr 2017 14:00:42 +0200
Message-Id: <20170420120058.28404-2-pbonzini@redhat.com>
In-Reply-To: <20170420120058.28404-1-pbonzini@redhat.com>
References: <20170420120058.28404-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 01/17] block: access copy_on_read with atomic
 ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c                   |  6 ++++--
 block/io.c                |  8 ++++----
 blockdev.c                |  2 +-
 include/block/block_int.h | 11 ++++++-----
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/block.c b/block.c
index 1fbbb8d..a48fdd8 100644
--- a/block.c
+++ b/block.c
@@ -1189,7 +1189,9 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
         goto fail_opts;
     }
 
-    assert(bs->copy_on_read == 0); /* bdrv_new() and bdrv_close() make it so */
+    /* bdrv_new() and bdrv_close() make it so */
+    assert(atomic_read(&bs->copy_on_read) == 0);
+
     if (bs->open_flags & BDRV_O_COPY_ON_READ) {
         if (!bs->read_only) {
             bdrv_enable_copy_on_read(bs);
@@ -2937,7 +2939,7 @@ static void bdrv_close(BlockDriverState *bs)
 
         g_free(bs->opaque);
         bs->opaque = NULL;
-        bs->copy_on_read = 0;
+        atomic_set(&bs->copy_on_read, 0);
         bs->backing_file[0] = '\0';
         bs->backing_format[0] = '\0';
         bs->total_sectors = 0;
diff --git a/block/io.c b/block/io.c
index a54e5c8..08de488 100644
--- a/block/io.c
+++ b/block/io.c
@@ -130,13 +130,13 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
  */
 void bdrv_enable_copy_on_read(BlockDriverState *bs)
 {
-    bs->copy_on_read++;
+    atomic_inc(&bs->copy_on_read);
 }
 
 void bdrv_disable_copy_on_read(BlockDriverState *bs)
 {
-    assert(bs->copy_on_read > 0);
-    bs->copy_on_read--;
+    assert(atomic_read(&bs->copy_on_read) > 0);
+    atomic_dec(&bs->copy_on_read);
 }
 
 /* Check if any requests are in-flight (including throttled requests) */
@@ -1144,7 +1144,7 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     bdrv_inc_in_flight(bs);
 
     /* Don't do copy-on-read if we read data before write operation */
-    if (bs->copy_on_read && !(flags & BDRV_REQ_NO_SERIALISING)) {
+    if (atomic_read(&bs->copy_on_read) && !(flags & BDRV_REQ_NO_SERIALISING)) {
         flags |= BDRV_REQ_COPY_ON_READ;
     }
 
diff --git a/blockdev.c b/blockdev.c
index 9098233..e9b5717 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1794,7 +1794,7 @@ static void external_snapshot_commit(BlkActionState *common)
     /* We don't need (or want) to use the transactional
      * bdrv_reopen_multiple() across all the entries at once, because we
      * don't want to abort all of them if one of them fails the reopen */
-    if (!state->old_bs->copy_on_read) {
+    if (!atomic_read(&state->old_bs->copy_on_read)) {
         bdrv_reopen(state->old_bs, state->old_bs->open_flags & ~BDRV_O_RDWR,
                     NULL);
     }
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 59400bd..d0b88ff 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -581,11 +581,6 @@ struct BlockDriverState {
 
     /* Protected by AioContext lock */
 
-    /* If true, copy read backing sectors into image.  Can be >1 if more
-     * than one client has requested copy-on-read.
-     */
-    int copy_on_read;
-
     /* If we are reading a disk image, give its size in sectors.
      * Generally read-only; it is written to by load_vmstate and save_vmstate,
      * but the block layer is quiescent during those.
@@ -619,6 +614,12 @@ struct BlockDriverState {
 
     QLIST_HEAD(, BdrvDirtyBitmap) dirty_bitmaps;
 
+    /* If true, copy read backing sectors into image.  Can be >1 if more
+     * than one client has requested copy-on-read.  Accessed with atomic
+     * ops.
+     */
+    int copy_on_read;
+
     /* do we need to tell the quest if we have a volatile write cache? */
     int enable_write_cache;
 
-- 
2.9.3
