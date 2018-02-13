Received: from eggs.gnu.org ([2001:4830:134:3::10]:52119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1d-0002nV-B3
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1c-0005Ff-EP
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:49 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:04:43 +0100
Message-Id: <20180213170529.10858-10-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/55] gluster: Move glfs_close() to create's
 clean-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

glfs_close() is a classical clean-up operation, as can be seen by the
fact that it is executed even if the truncation before it failed.
Also, moving it to clean-up makes it more clear that if it fails, we do
not want it to overwrite the current ret value if that signifies an
error already.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/gluster.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index d8decc41ad..7fab2dfa12 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -970,7 +970,7 @@ static int qemu_gluster_create(const char *filename,
 {
     BlockdevOptionsGluster *gconf;
     struct glfs *glfs;
-    struct glfs_fd *fd;
+    struct glfs_fd *fd = NULL;
     int ret = 0;
     PreallocMode prealloc;
     int64_t total_size = 0;
@@ -1054,10 +1054,12 @@ static int qemu_gluster_create(const char *filename,
         break;
     }
 
-    if (glfs_close(fd) != 0) {
-        ret = -errno;
-    }
 out:
+    if (fd) {
+        if (glfs_close(fd) != 0 && ret == 0) {
+            ret = -errno;
+        }
+    }
     qapi_free_BlockdevOptionsGluster(gconf);
     glfs_clear_preopened(glfs);
     return ret;
-- 
2.13.6
