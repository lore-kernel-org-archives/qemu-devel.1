Received: from eggs.gnu.org ([2001:4830:134:3::10]:55460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fiwdT-0000v9-0Z
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 02:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fiwdS-0001t8-Ch
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 02:53:59 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 27 Jul 2018 14:53:14 +0800
Message-Id: <20180727065314.1656-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] file-posix: Handle EINTR in preallocation=full
 write
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

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index ad299beb38..928b863ced 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1646,6 +1646,9 @@ static int handle_aiocb_truncate(RawPosixAIOData *aiocb)
             num = MIN(left, 65536);
             result = write(fd, buf, num);
             if (result < 0) {
+                if (errno == EINTR) {
+                    continue;
+                }
                 result = -errno;
                 error_setg_errno(errp, -result,
                                  "Could not write zeros for preallocation");
-- 
2.17.1
