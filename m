Received: from eggs.gnu.org ([2001:4830:134:3::10]:43157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuo-0000ZD-6a
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBun-00083M-5R
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:42 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:23 +0100
Message-Id: <1487689130-30373-28-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 27/54] block: Request real permissions in
 blk_new_open()
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

We can figure out the necessary permissions from the flags that the
caller passed.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 299948f..03d5495 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -166,17 +166,33 @@ BlockBackend *blk_new_open(const char *filename, const char *reference,
 {
     BlockBackend *blk;
     BlockDriverState *bs;
+    uint64_t perm;
+
+    /* blk_new_open() is mainly used in .bdrv_create implementations and the
+     * tools where sharing isn't a concern because the BDS stays private, so we
+     * just request permission according to the flags.
+     *
+     * The exceptions are xen_disk and blockdev_init(); in these cases, the
+     * caller of blk_new_open() doesn't make use of the permissions, but they
+     * shouldn't hurt either. We can still share everything here because the
+     * guest devices will add their own blockers if they can't share. */
+    perm = BLK_PERM_CONSISTENT_READ;
+    if (flags & BDRV_O_RDWR) {
+        perm |= BLK_PERM_WRITE;
+    }
+    if (flags & BDRV_O_RESIZE) {
+        perm |= BLK_PERM_RESIZE;
+    }
 
-    blk = blk_new(0, BLK_PERM_ALL);
+    blk = blk_new(perm, BLK_PERM_ALL);
     bs = bdrv_open(filename, reference, options, flags, errp);
     if (!bs) {
         blk_unref(blk);
         return NULL;
     }
 
-    /* FIXME Use real permissions */
     blk->root = bdrv_root_attach_child(bs, "root", &child_root,
-                                       0, BLK_PERM_ALL, blk, &error_abort);
+                                       perm, BLK_PERM_ALL, blk, &error_abort);
 
     return blk;
 }
-- 
1.8.3.1
