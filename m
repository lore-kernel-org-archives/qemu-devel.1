Received: from eggs.gnu.org ([2001:4830:134:3::10]:49910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwRCK-0002og-Bk
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwRCJ-0003q7-F6
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:32:56 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Apr 2017 12:32:45 +0200
Message-Id: <1491561165-12415-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9] block: Don't check permissions for
 copy on read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, rjones@redhat.com, qemu-devel@nongnu.org

The assertion is currently failing. We can't require callers to have
write permissions when all they are doing is a read, so comment it out.
Add a FIXME comment in the code so that the check is re-enabled when
copy on read is refactored into its own filter driver.

Reported-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 2709a70..7321dda 100644
--- a/block/io.c
+++ b/block/io.c
@@ -945,7 +945,14 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
     size_t skip_bytes;
     int ret;
 
-    assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));
+    /* FIXME We cannot require callers to have write permissions when all they
+     * are doing is a read request. If we did things right, write permissions
+     * would be obtained anyway, but internally by the copy-on-read code. As
+     * long as it is implemented here rather than in a separat filter driver,
+     * the copy-on-read code doesn't have its own BdrvChild, however, for which
+     * it could request permissions. Therefore we have to bypass the permission
+     * system for the moment. */
+    // assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));
 
     /* Cover entire cluster so no additional backing file I/O is required when
      * allocating cluster in the image file.
-- 
1.8.3.1
