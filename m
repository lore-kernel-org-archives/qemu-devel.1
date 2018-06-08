Received: from eggs.gnu.org ([2001:4830:134:3::10]:41922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fRAW6-0008UI-5E
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fRAW2-0008GK-Vo
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:04:54 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Jun 2018 14:04:12 +0800
Message-Id: <20180608060417.10170-2-famz@redhat.com>
In-Reply-To: <20180608060417.10170-1-famz@redhat.com>
References: <20180608060417.10170-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] file-posix: Fix EINTR handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

EINTR should be checked against errno, not ret. While fixing the bug,
collecting the branches with a switch block.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 513d371bb1..c6dae38f94 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1473,20 +1473,20 @@ static ssize_t handle_aiocb_copy_range(RawPosixAIOData *aiocb)
         ssize_t ret = copy_file_range(aiocb->aio_fildes, &in_off,
                                       aiocb->aio_fd2, &out_off,
                                       bytes, 0);
-        if (ret == -EINTR) {
-            continue;
-        }
-        if (ret < 0) {
-            if (errno == ENOSYS) {
+        if (ret <= 0) {
+            switch (errno) {
+            case 0:
+                /* No progress (e.g. when beyond EOF), let the caller fall back
+                 * to buffer I/O. */
+                /* fall through */
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
2.17.0
