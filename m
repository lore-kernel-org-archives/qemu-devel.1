Received: from eggs.gnu.org ([2001:4830:134:3::10]:60055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ceWm7-0001C6-Gq
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ceWm6-0007qa-O2
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:51:51 -0500
From: Nir Soffer <nirsof@gmail.com>
Date: Fri, 17 Feb 2017 02:51:26 +0200
Message-Id: <20170217005127.21010-3-nirsof@gmail.com>
In-Reply-To: <20170217005127.21010-1-nirsof@gmail.com>
References: <20170217005127.21010-1-nirsof@gmail.com>
Subject: [Qemu-devel] [PATCH 2/3] qemu-img: Truncate before full
 preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>

In commit 10ddfe7b6044 (qemu-img: Do not truncate before preallocation)
we moved truncate to the PREALLOC_MODE_OFF branch to avoid slowdown in
posix_fallocate().

However this change is not optimal when using PREALLOC_MODE_FULL, since
knowing the final size from the beginning could allow the file system
driver to do less allocations and possibly avoid fragmentation of the
file.

Now we truncate also before doing full preallocation.

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 block/file-posix.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 442f080..d24e34b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1604,6 +1604,17 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
 #endif
     case PREALLOC_MODE_FULL:
     {
+        /*
+         * Knowing the final size from the beginning could allow the file
+         * system driver to do less allocations and possibly avoid
+         * fragmentation of the file.
+         */
+        if (ftruncate(fd, total_size) != 0) {
+            result = -errno;
+            error_setg_errno(errp, -result, "Could not resize file");
+            goto out_close;
+        }
+
         int64_t num = 0, left = total_size;
         buf = g_malloc0(65536);
 
@@ -1642,6 +1653,7 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
         break;
     }
 
+out_close:
     if (qemu_close(fd) != 0 && result == 0) {
         result = -errno;
         error_setg_errno(errp, -result, "Could not close the new file");
-- 
2.9.3
