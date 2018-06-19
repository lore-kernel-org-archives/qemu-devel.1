Received: from eggs.gnu.org ([2001:4830:134:3::10]:46253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iW-00028u-Hi
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iR-00009l-Ly
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:56 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:14 -0500
Message-Id: <20180619014319.28272-49-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 048/113] block/file-posix: Fix fully
 preallocated truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

Storing the lseek() result in an int results in it overflowing when the
file is at least 2 GB big.  Then, we have a 50 % chance of the result
being "negative" and thus thinking an error occurred when actually
everything went just fine.

So we should use the correct type for storing the result: off_t.

Reported-by: Daniel P. Berrange <berrange@redhat.com>
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1549231
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180228131315.30194-2-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 82b45e0a0b824787bd79ce3f6453eaa2afddd138)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/file-posix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 36ee89e940..275953fdc6 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1694,6 +1694,7 @@ static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
     case PREALLOC_MODE_FULL:
     {
         int64_t num = 0, left = offset - current_length;
+        off_t seek_result;
 
         /*
          * Knowing the final size from the beginning could allow the file
@@ -1708,8 +1709,8 @@ static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
 
         buf = g_malloc0(65536);
 
-        result = lseek(fd, current_length, SEEK_SET);
-        if (result < 0) {
+        seek_result = lseek(fd, current_length, SEEK_SET);
+        if (seek_result < 0) {
             result = -errno;
             error_setg_errno(errp, -result,
                              "Failed to seek to the old end of file");
-- 
2.11.0
