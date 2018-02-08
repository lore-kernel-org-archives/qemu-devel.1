Received: from eggs.gnu.org ([2001:4830:134:3::10]:58279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ejron-0003pN-LF
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ejrol-000205-TF
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:25:13 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  8 Feb 2018 20:23:25 +0100
Message-Id: <20180208192328.16550-25-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-1-kwolf@redhat.com>
References: <20180208192328.16550-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 24/27] file-posix: Fix no-op bdrv_truncate()
 with falloc preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

If bdrv_truncate() is called, but the requested size is the same as
before, don't call posix_fallocate(), which returns -EINVAL for length
zero and would therefore make bdrv_truncate() fail.

The problem can be triggered by creating a zero-sized raw image with
'falloc' preallocation mode.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 9ae5b7dcdf..15819a00b9 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1683,11 +1683,15 @@ static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
          * file systems that do not support fallocate(), trying to check if a
          * block is allocated before allocating it, so don't do that here.
          */
-        result = -posix_fallocate(fd, current_length, offset - current_length);
-        if (result != 0) {
-            /* posix_fallocate() doesn't set errno. */
-            error_setg_errno(errp, -result,
-                             "Could not preallocate new data");
+        if (offset != current_length) {
+            result = -posix_fallocate(fd, current_length, offset - current_length);
+            if (result != 0) {
+                /* posix_fallocate() doesn't set errno. */
+                error_setg_errno(errp, -result,
+                                 "Could not preallocate new data");
+            }
+        } else {
+            result = 0;
         }
         goto out;
 #endif
-- 
2.13.6
