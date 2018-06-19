Received: from eggs.gnu.org ([2001:4830:134:3::10]:44426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5gZ-0008So-IS
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5gY-0007d1-M4
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:43:55 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:43:07 -0500
Message-Id: <20180619014319.28272-102-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 101/113] block: Make bdrv_is_writable() public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

This is a useful function for the whole block layer, so make it public.
At the same time, users outside of block.c probably do not need to make
use of the reopen functionality, so rename the current function to
bdrv_is_writable_after_reopen() create a new bdrv_is_writable() function
that just passes NULL to it for the reopen queue.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180606193702.7113-2-mreitz@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit cc022140972f8b6ac3973c12ccf9dd6b1d2fd200)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block.c               | 17 ++++++++++++++---
 include/block/block.h |  1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index f236431da1..24dd28d51d 100644
--- a/block.c
+++ b/block.c
@@ -1596,13 +1596,24 @@ static int bdrv_reopen_get_flags(BlockReopenQueue *q, BlockDriverState *bs)
 
 /* Returns whether the image file can be written to after the reopen queue @q
  * has been successfully applied, or right now if @q is NULL. */
-static bool bdrv_is_writable(BlockDriverState *bs, BlockReopenQueue *q)
+static bool bdrv_is_writable_after_reopen(BlockDriverState *bs,
+                                          BlockReopenQueue *q)
 {
     int flags = bdrv_reopen_get_flags(q, bs);
 
     return (flags & (BDRV_O_RDWR | BDRV_O_INACTIVE)) == BDRV_O_RDWR;
 }
 
+/*
+ * Return whether the BDS can be written to.  This is not necessarily
+ * the same as !bdrv_is_read_only(bs), as inactivated images may not
+ * be written to but do not count as read-only images.
+ */
+bool bdrv_is_writable(BlockDriverState *bs)
+{
+    return bdrv_is_writable_after_reopen(bs, NULL);
+}
+
 static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
                             BdrvChild *c, const BdrvChildRole *role,
                             BlockReopenQueue *reopen_queue,
@@ -1640,7 +1651,7 @@ static int bdrv_check_perm(BlockDriverState *bs, BlockReopenQueue *q,
 
     /* Write permissions never work with read-only images */
     if ((cumulative_perms & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED)) &&
-        !bdrv_is_writable(bs, q))
+        !bdrv_is_writable_after_reopen(bs, q))
     {
         error_setg(errp, "Block node is read-only");
         return -EPERM;
@@ -1930,7 +1941,7 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                   &perm, &shared);
 
         /* Format drivers may touch metadata even if the guest doesn't write */
-        if (bdrv_is_writable(bs, reopen_queue)) {
+        if (bdrv_is_writable_after_reopen(bs, reopen_queue)) {
             perm |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
         }
 
diff --git a/include/block/block.h b/include/block/block.h
index c05cac57e5..f9e90beb21 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -437,6 +437,7 @@ bool bdrv_is_read_only(BlockDriverState *bs);
 int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
                            bool ignore_allow_rdw, Error **errp);
 int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
+bool bdrv_is_writable(BlockDriverState *bs);
 bool bdrv_is_sg(BlockDriverState *bs);
 bool bdrv_is_inserted(BlockDriverState *bs);
 void bdrv_lock_medium(BlockDriverState *bs, bool locked);
-- 
2.11.0
