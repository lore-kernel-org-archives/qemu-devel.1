Received: from eggs.gnu.org ([2001:4830:134:3::10]:37046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHAC6-00039z-Tt
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:10:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHAC1-0005CD-7f
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:10:38 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Nov 2017 16:10:12 +0100
Message-Id: <20171121151017.28158-3-kwolf@redhat.com>
In-Reply-To: <20171121151017.28158-1-kwolf@redhat.com>
References: <20171121151017.28158-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] block: Don't request I/O permission with
 BDRV_O_NO_IO
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

'qemu-img info' makes sense even when BLK_PERM_CONSISTENT_READ cannot be
granted because of a block job in a running qemu process. It already
sets BDRV_O_NO_IO to indicate that it doesn't access the guest visible
data at all.

Check the BDRV_O_NO_IO flags in blk_new_open(), so that I/O related
permissions are not unnecessarily requested and 'qemu-img info' can work
even if BLK_PERM_CONSISTENT_READ cannot be granted.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/block-backend.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 5836cb3087..baef8e7abc 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -299,7 +299,7 @@ BlockBackend *blk_new_open(const char *filename, const char *reference,
 {
     BlockBackend *blk;
     BlockDriverState *bs;
-    uint64_t perm;
+    uint64_t perm = 0;
 
     /* blk_new_open() is mainly used in .bdrv_create implementations and the
      * tools where sharing isn't a concern because the BDS stays private, so we
@@ -309,9 +309,11 @@ BlockBackend *blk_new_open(const char *filename, const char *reference,
      * caller of blk_new_open() doesn't make use of the permissions, but they
      * shouldn't hurt either. We can still share everything here because the
      * guest devices will add their own blockers if they can't share. */
-    perm = BLK_PERM_CONSISTENT_READ;
-    if (flags & BDRV_O_RDWR) {
-        perm |= BLK_PERM_WRITE;
+    if ((flags & BDRV_O_NO_IO) == 0) {
+        perm |= BLK_PERM_CONSISTENT_READ;
+        if (flags & BDRV_O_RDWR) {
+            perm |= BLK_PERM_WRITE;
+        }
     }
     if (flags & BDRV_O_RESIZE) {
         perm |= BLK_PERM_RESIZE;
-- 
2.13.6
