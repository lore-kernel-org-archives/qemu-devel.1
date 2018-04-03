Received: from eggs.gnu.org ([2001:4830:134:3::10]:55255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Osy-0006mM-UX
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Osx-0006Xu-Mw
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  3 Apr 2018 18:33:53 +0200
Message-Id: <20180403163400.6307-3-kwolf@redhat.com>
In-Reply-To: <20180403163400.6307-1-kwolf@redhat.com>
References: <20180403163400.6307-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 2/9] block: handle invalid lseek returns
 gracefully
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Jeff Cody <jcody@redhat.com>

In commit 223a23c198787328ae75bc65d84edf5fde33c0b6, we implemented a
workaround in the gluster driver to handle invalid values returned for
SEEK_DATA or SEEK_HOLE.

In some instances, these same invalid values can be seen in the posix
file handler as well - for example, it has been reported on FUSE gluster
mounts.

Calling assert() for these invalid values is overly harsh; we can safely
return -EIO and allow this case to be treated as a "learned nothing"
case (e.g., D4 / H4, as commented in the code).

This patch does the same thing that 223a23c198787 did for gluster.c,
except in file-posix.c

Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index d7fb772c14..a2f6d8a8c8 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2114,7 +2114,12 @@ static int find_allocation(BlockDriverState *bs, off_t start,
     if (offs < 0) {
         return -errno;          /* D3 or D4 */
     }
-    assert(offs >= start);
+
+    if (offs < start) {
+        /* This is not a valid return by lseek().  We are safe to just return
+         * -EIO in this case, and we'll treat it like D4. */
+        return -EIO;
+    }
 
     if (offs > start) {
         /* D2: in hole, next data at offs */
@@ -2146,7 +2151,12 @@ static int find_allocation(BlockDriverState *bs, off_t start,
     if (offs < 0) {
         return -errno;          /* D1 and (H3 or H4) */
     }
-    assert(offs >= start);
+
+    if (offs < start) {
+        /* This is not a valid return by lseek().  We are safe to just return
+         * -EIO in this case, and we'll treat it like H4. */
+        return -EIO;
+    }
 
     if (offs > start) {
         /*
-- 
2.13.6
