Received: from eggs.gnu.org ([2001:4830:134:3::10]:55319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Ot1-0006pm-6Q
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Ot0-0006Zz-0O
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  3 Apr 2018 18:33:57 +0200
Message-Id: <20180403163400.6307-7-kwolf@redhat.com>
In-Reply-To: <20180403163400.6307-1-kwolf@redhat.com>
References: <20180403163400.6307-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 6/9] block/file-posix: Fix fully preallocated
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

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
---
 block/file-posix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index a2f6d8a8c8..3794c0007a 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1701,6 +1701,7 @@ static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
     case PREALLOC_MODE_FULL:
     {
         int64_t num = 0, left = offset - current_length;
+        off_t seek_result;
 
         /*
          * Knowing the final size from the beginning could allow the file
@@ -1715,8 +1716,8 @@ static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
 
         buf = g_malloc0(65536);
 
-        result = lseek(fd, current_length, SEEK_SET);
-        if (result < 0) {
+        seek_result = lseek(fd, current_length, SEEK_SET);
+        if (seek_result < 0) {
             result = -errno;
             error_setg_errno(errp, -result,
                              "Failed to seek to the old end of file");
-- 
2.13.6
