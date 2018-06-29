Received: from eggs.gnu.org ([2001:4830:134:3::10]:35150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fYmVZ-00016O-Mc
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fYmVY-0007GI-TT
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:03:49 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 29 Jun 2018 14:03:28 +0800
Message-Id: <20180629060328.4423-4-famz@redhat.com>
In-Reply-To: <20180629060328.4423-1-famz@redhat.com>
References: <20180629060328.4423-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] file-posix: Fix EINTR handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

EINTR should be checked against errno, not ret. While fixing the bug,
collect the branches with a switch block.

Also, change the return value from -ENOSTUP to -ENOSPC when the actual
issue is request range passes EOF, which should be distinguishable from
the case of error == ENOSYS by the caller, so that it could still retry
with other byte ranges, whereas it shouldn't retry anymore upon ENOSYS.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 07bb061fe4..6b736f603a 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1474,20 +1474,21 @@ static ssize_t handle_aiocb_copy_range(RawPosixAIOData *aiocb)
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
2.17.1
