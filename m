Received: from eggs.gnu.org ([2001:4830:134:3::10]:42559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52U-0000Ow-F2
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52P-0002FP-Hl
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  8 Aug 2017 15:58:34 +0200
Message-Id: <20170808135838.11525-15-kwolf@redhat.com>
In-Reply-To: <20170808135838.11525-1-kwolf@redhat.com>
References: <20170808135838.11525-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 14/18] block: Allow reopen rw without
 BDRV_O_ALLOW_RDWR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

BDRV_O_ALLOW_RDWR is a flag that tells whether qemu can internally
reopen a node read-write temporarily because the user requested
read-write for the top-level image, but qemu decided that read-only is
enough for this node (a backing file).

bdrv_reopen() is different, it is also used for cases where the user
changed their mind and wants to update the options. There is no reason
to forbid making a node read-write in that case.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 include/block/block.h |  3 ++-
 block.c               | 11 +++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 34770bb33a..ab80195378 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -436,7 +436,8 @@ int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
 
 bool bdrv_is_read_only(BlockDriverState *bs);
 bool bdrv_is_writable(BlockDriverState *bs);
-int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
+int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
+                           bool ignore_allow_rdw, Error **errp);
 int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
 bool bdrv_is_sg(BlockDriverState *bs);
 bool bdrv_is_inserted(BlockDriverState *bs);
diff --git a/block.c b/block.c
index ab908cdc50..2711c3dd3b 100644
--- a/block.c
+++ b/block.c
@@ -246,7 +246,8 @@ bool bdrv_is_writable(BlockDriverState *bs)
     return !bdrv_is_read_only(bs) && !(bs->open_flags & BDRV_O_INACTIVE);
 }
 
-int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
+int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
+                           bool ignore_allow_rdw, Error **errp)
 {
     /* Do not set read_only if copy_on_read is enabled */
     if (bs->copy_on_read && read_only) {
@@ -256,7 +257,9 @@ int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
     }
 
     /* Do not clear read_only if it is prohibited */
-    if (!read_only && !(bs->open_flags & BDRV_O_ALLOW_RDWR)) {
+    if (!read_only && !(bs->open_flags & BDRV_O_ALLOW_RDWR) &&
+        !ignore_allow_rdw)
+    {
         error_setg(errp, "Node '%s' is read only",
                    bdrv_get_device_or_node_name(bs));
         return -EPERM;
@@ -269,7 +272,7 @@ int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
 {
     int ret = 0;
 
-    ret = bdrv_can_set_read_only(bs, read_only, errp);
+    ret = bdrv_can_set_read_only(bs, read_only, false, errp);
     if (ret < 0) {
         return ret;
     }
@@ -2907,7 +2910,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
      * to r/w. Attempting to set to r/w may fail if either BDRV_O_ALLOW_RDWR is
      * not set, or if the BDS still has copy_on_read enabled */
     read_only = !(reopen_state->flags & BDRV_O_RDWR);
-    ret = bdrv_can_set_read_only(reopen_state->bs, read_only, &local_err);
+    ret = bdrv_can_set_read_only(reopen_state->bs, read_only, true, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto error;
-- 
2.13.4
