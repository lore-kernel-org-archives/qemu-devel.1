Received: from eggs.gnu.org ([2001:4830:134:3::10]:33102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elaFz-0007iT-1V
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:04:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elaFw-0006cK-IN
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:04:23 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 13 Feb 2018 14:03:52 +0100
Message-Id: <20180213130356.8885-4-mreitz@redhat.com>
In-Reply-To: <20180213130356.8885-1-mreitz@redhat.com>
References: <20180213130356.8885-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] gluster: Query current size in
 do_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, sheepdog@lists.wpkg.org, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>

Instead of expecting the current size to be 0, query it and allocate
only the area [current_size, offset) if preallocation is requested.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/gluster.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 8178541416..806b894bc8 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -968,10 +968,27 @@ static coroutine_fn int qemu_gluster_co_pwrite_zeroes(BlockDriverState *bs,
 static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
                                     PreallocMode prealloc, Error **errp)
 {
+    int64_t current_length;
+
+    current_length = glfs_lseek(fd, 0, SEEK_END);
+    if (current_length < 0) {
+        error_setg_errno(errp, errno, "Failed to determine current size");
+        return -errno;
+    }
+
+    if (current_length > offset && prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Cannot use preallocation for shrinking files");
+        return -ENOTSUP;
+    }
+
+    if (current_length == offset) {
+        return 0;
+    }
+
     switch (prealloc) {
 #ifdef CONFIG_GLUSTERFS_FALLOCATE
     case PREALLOC_MODE_FALLOC:
-        if (glfs_fallocate(fd, 0, 0, offset)) {
+        if (glfs_fallocate(fd, 0, current_length, offset - current_length)) {
             error_setg_errno(errp, errno, "Could not preallocate data");
             return -errno;
         }
@@ -983,7 +1000,7 @@ static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
             error_setg_errno(errp, errno, "Could not resize file");
             return -errno;
         }
-        if (glfs_zerofill(fd, 0, offset)) {
+        if (glfs_zerofill(fd, current_length, offset - current_length)) {
             error_setg_errno(errp, errno, "Could not zerofill the new area");
             return -errno;
         }
-- 
2.14.3
