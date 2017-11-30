Received: from eggs.gnu.org ([2001:4830:134:3::10]:41168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKRwk-0002NE-Fc
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKRwj-0000Zk-QB
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:44:22 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 30 Nov 2017 17:44:01 +0100
Message-Id: <20171130164401.29221-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Formats don't need CONSISTENT_READ with
 NO_IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Commit 1f4ad7d fixed 'qemu-img info' for raw images that are currently
in use as a mirror target. It is not enough for image formats, though,
as these still unconditionally request BLK_PERM_CONSISTENT_READ.

As this permission is meaningless unless you do actual I/O on the image,
drop the requirement and allow 'qemu-img info' even for image formats
under conditions where BLK_PERM_CONSISTENT_READ can't be granted.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 9a1a0d1e73..ddb6836c52 100644
--- a/block.c
+++ b/block.c
@@ -1924,6 +1924,8 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
     assert(role == &child_backing || role == &child_file);
 
     if (!backing) {
+        int flags = bdrv_reopen_get_flags(reopen_queue, bs);
+
         /* Apart from the modifications below, the same permissions are
          * forwarded and left alone as for filters */
         bdrv_filter_default_perms(bs, c, role, reopen_queue, perm, shared,
@@ -1936,7 +1938,9 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
 
         /* bs->file always needs to be consistent because of the metadata. We
          * can never allow other users to resize or write to it. */
-        perm |= BLK_PERM_CONSISTENT_READ;
+        if (!(flags & BDRV_O_NO_IO)) {
+            perm |= BLK_PERM_CONSISTENT_READ;
+        }
         shared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
     } else {
         /* We want consistent read from backing files if the parent needs it.
-- 
2.13.6
