Received: from eggs.gnu.org ([2001:4830:134:3::10]:49769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6a-000444-UN
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6Z-0004Cp-9P
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 29 Jun 2018 16:09:51 +0200
Message-Id: <20180629140959.6690-22-kwolf@redhat.com>
In-Reply-To: <20180629140959.6690-1-kwolf@redhat.com>
References: <20180629140959.6690-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 21/29] file-posix: Fix EINTR handling
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

From: Fam Zheng <famz@redhat.com>

EINTR should be checked against errno, not ret. While fixing the bug,
collect the branches with a switch block.

Also, change the return value from -ENOSTUP to -ENOSPC when the actual
issue is request range passes EOF, which should be distinguishable from
the case of error == ENOSYS by the caller, so that it could still retry
with other byte ranges, whereas it shouldn't retry anymore upon ENOSYS.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index e3f1b045d1..829ee538d8 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1488,20 +1488,21 @@ static ssize_t handle_aiocb_copy_range(RawPosixAIOData *aiocb)
         ssize_t ret = copy_file_range(aiocb->aio_fildes, &in_off,
                                       aiocb->aio_fd2, &out_off,
                                       bytes, 0);
-        if (ret == -EINTR) {
-            continue;
+        if (ret == 0) {
+            /* No progress (e.g. when beyond EOF), let the caller fall back to
+             * buffer I/O. */
+            return -ENOSPC;
         }
         if (ret < 0) {
-            if (errno == ENOSYS) {
+            switch (errno) {
+            case ENOSYS:
                 return -ENOTSUP;
-            } else {
+            case EINTR:
+                continue;
+            default:
                 return -errno;
             }
         }
-        if (!ret) {
-            /* No progress (e.g. when beyond EOF), fall back to buffer I/O. */
-            return -ENOTSUP;
-        }
         bytes -= ret;
     }
     return 0;
-- 
2.13.6
