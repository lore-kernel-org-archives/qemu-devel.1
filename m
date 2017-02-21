Received: from eggs.gnu.org ([2001:4830:134:3::10]:42966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBue-0000NI-AR
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBud-0007xD-B1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:32 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:16 +0100
Message-Id: <1487689130-30373-21-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 20/54] vvfat: Implement .bdrv_child_perm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

vvfat is the last remaining driver that can have children, but doesn't
implement .bdrv_child_perm() yet. The default handlers aren't suitable
here, so let's implement a very simple driver-specific one that protects
the internal child from being used by other users as good as our
permissions permit.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                   |  2 +-
 block/vvfat.c             | 22 ++++++++++++++++++++++
 include/block/block_int.h |  1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index f2e7178..6d1362e 100644
--- a/block.c
+++ b/block.c
@@ -823,7 +823,7 @@ static void bdrv_backing_options(int *child_flags, QDict *child_options,
     *child_flags = flags;
 }
 
-static const BdrvChildRole child_backing = {
+const BdrvChildRole child_backing = {
     .inherit_options = bdrv_backing_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
     .drained_end     = bdrv_child_cb_drained_end,
diff --git a/block/vvfat.c b/block/vvfat.c
index 7f230be..72b482c 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3052,6 +3052,27 @@ err:
     return ret;
 }
 
+static void vvfat_child_perm(BlockDriverState *bs, BdrvChild *c,
+                             const BdrvChildRole *role,
+                             uint64_t perm, uint64_t shared,
+                             uint64_t *nperm, uint64_t *nshared)
+{
+    BDRVVVFATState *s = bs->opaque;
+
+    assert(c == s->qcow || role == &child_backing);
+
+    if (c == s->qcow) {
+        /* This is a private node, nobody should try to attach to it */
+        *nperm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
+        *nshared = BLK_PERM_WRITE_UNCHANGED;
+    } else {
+        /* The backing file is there so 'commit' can use it. vvfat doesn't
+         * access it in any way. */
+        *nperm = 0;
+        *nshared = BLK_PERM_ALL;
+    }
+}
+
 static void vvfat_close(BlockDriverState *bs)
 {
     BDRVVVFATState *s = bs->opaque;
@@ -3077,6 +3098,7 @@ static BlockDriver bdrv_vvfat = {
     .bdrv_file_open         = vvfat_open,
     .bdrv_refresh_limits    = vvfat_refresh_limits,
     .bdrv_close             = vvfat_close,
+    .bdrv_child_perm        = vvfat_child_perm,
 
     .bdrv_co_preadv         = vvfat_co_preadv,
     .bdrv_co_pwritev        = vvfat_co_pwritev,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index eb0598e..63d5446 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -466,6 +466,7 @@ struct BdrvChildRole {
 
 extern const BdrvChildRole child_file;
 extern const BdrvChildRole child_format;
+extern const BdrvChildRole child_backing;
 
 struct BdrvChild {
     BlockDriverState *bs;
-- 
1.8.3.1
