Received: from eggs.gnu.org ([2001:4830:134:3::10]:43890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQeF6-00036C-Pf
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQeF5-0007yq-Fw
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:37:12 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  6 Jun 2018 21:37:00 +0200
Message-Id: <20180606193702.7113-2-mreitz@redhat.com>
In-Reply-To: <20180606193702.7113-1-mreitz@redhat.com>
References: <20180606193702.7113-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] block: Make bdrv_is_writable() public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is a useful function for the whole block layer, so make it public.
At the same time, users outside of block.c probably do not need to make
use of the reopen functionality, so rename the current function to
bdrv_is_writable_after_reopen() create a new bdrv_is_writable() function
that just passes NULL to it for the reopen queue.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  1 +
 block.c               | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 4dd4f1eab2..e677080c4e 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -408,6 +408,7 @@ bool bdrv_is_read_only(BlockDriverState *bs);
 int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
                            bool ignore_allow_rdw, Error **errp);
 int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
+bool bdrv_is_writable(BlockDriverState *bs);
 bool bdrv_is_sg(BlockDriverState *bs);
 bool bdrv_is_inserted(BlockDriverState *bs);
 void bdrv_lock_medium(BlockDriverState *bs, bool locked);
diff --git a/block.c b/block.c
index 9d577f65bb..50887087f3 100644
--- a/block.c
+++ b/block.c
@@ -1620,13 +1620,24 @@ static int bdrv_reopen_get_flags(BlockReopenQueue *q, BlockDriverState *bs)
 
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
@@ -1664,7 +1675,7 @@ static int bdrv_check_perm(BlockDriverState *bs, BlockReopenQueue *q,
 
     /* Write permissions never work with read-only images */
     if ((cumulative_perms & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED)) &&
-        !bdrv_is_writable(bs, q))
+        !bdrv_is_writable_after_reopen(bs, q))
     {
         error_setg(errp, "Block node is read-only");
         return -EPERM;
@@ -1956,7 +1967,7 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                   &perm, &shared);
 
         /* Format drivers may touch metadata even if the guest doesn't write */
-        if (bdrv_is_writable(bs, reopen_queue)) {
+        if (bdrv_is_writable_after_reopen(bs, reopen_queue)) {
             perm |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
         }
 
-- 
2.17.0
