Received: from eggs.gnu.org ([2001:4830:134:3::10]:52487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxy67-0005qJ-SA
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxy67-0007Cl-0y
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:52:51 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Apr 2017 17:52:26 +0200
Message-Id: <20170411155226.6395-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10] Revert "block/io: Comment out
 permission assertions"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

This reverts commit e3e0003a8f6570aba1421ef99a0b383a43371a74.

This commit was necessary for the 2.9 release because we were unable to
fix the underlying issue(s) in time. However, we will be for 2.10.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c    |  6 +-----
 block/io.c | 12 ++----------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/block.c b/block.c
index 1fbbb8d606..086a12df97 100644
--- a/block.c
+++ b/block.c
@@ -3274,11 +3274,7 @@ int bdrv_truncate(BdrvChild *child, int64_t offset)
     BlockDriver *drv = bs->drv;
     int ret;
 
-    /* FIXME: Some format block drivers use this function instead of implicitly
-     *        growing their file by writing beyond its end.
-     *        See bdrv_aligned_pwritev() for an explanation why we currently
-     *        cannot assert this permission in that case. */
-    // assert(child->perm & BLK_PERM_RESIZE);
+    assert(child->perm & BLK_PERM_RESIZE);
 
     if (!drv)
         return -ENOMEDIUM;
diff --git a/block/io.c b/block/io.c
index 8706bfa578..bae6947032 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1345,16 +1345,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     assert(!waited || !req->serialising);
     assert(req->overlap_offset <= offset);
     assert(offset + bytes <= req->overlap_offset + req->overlap_bytes);
-    /* FIXME: Block migration uses the BlockBackend of the guest device at a
-     *        point when it has not yet taken write permissions. This will be
-     *        fixed by a future patch, but for now we have to bypass this
-     *        assertion for block migration to work. */
-    // assert(child->perm & BLK_PERM_WRITE);
-    /* FIXME: Because of the above, we also cannot guarantee that all format
-     *        BDS take the BLK_PERM_RESIZE permission on their file BDS, since
-     *        they are not obligated to do so if they do not have any parent
-     *        that has taken the permission to write to them. */
-    // assert(end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE);
+    assert(child->perm & BLK_PERM_WRITE);
+    assert(end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE);
 
     ret = notifier_with_return_list_notify(&bs->before_write_notifiers, req);
 
-- 
2.12.2
