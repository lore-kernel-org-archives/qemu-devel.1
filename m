Received: from eggs.gnu.org ([2001:4830:134:3::10]:45461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er1Y5-0000G6-UC
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er1Y4-0001vn-Oz
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:13:33 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 28 Feb 2018 14:13:14 +0100
Message-Id: <20180228131315.30194-2-mreitz@redhat.com>
In-Reply-To: <20180228131315.30194-1-mreitz@redhat.com>
References: <20180228131315.30194-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] block/file-posix: Fix fully preallocated
 truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, qemu-stable@nongnu.org

Storing the lseek() result in an int results in it overflowing when the
file is at least 2 GB big.  Then, we have a 50 % chance of the result
being "negative" and thus thinking an error occurred when actually
everything went just fine.

So we should use the correct type for storing the result: off_t.

Reported-by: Daniel P. Berrange <berrange@redhat.com>
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1549231
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index f1591c3849..90c25864a0 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1697,6 +1697,7 @@ static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
     case PREALLOC_MODE_FULL:
     {
         int64_t num = 0, left = offset - current_length;
+        off_t seek_result;
 
         /*
          * Knowing the final size from the beginning could allow the file
@@ -1711,8 +1712,8 @@ static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
 
         buf = g_malloc0(65536);
 
-        result = lseek(fd, current_length, SEEK_SET);
-        if (result < 0) {
+        seek_result = lseek(fd, current_length, SEEK_SET);
+        if (seek_result < 0) {
             result = -errno;
             error_setg_errno(errp, -result,
                              "Failed to seek to the old end of file");
-- 
2.14.3
