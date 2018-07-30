Received: from eggs.gnu.org ([2001:4830:134:3::10]:44001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oO-0003GF-97
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oM-0008Hj-5Z
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 30 Jul 2018 17:09:48 +0200
Message-Id: <20180730150958.14607-4-kwolf@redhat.com>
In-Reply-To: <20180730150958.14607-1-kwolf@redhat.com>
References: <20180730150958.14607-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/13] file-posix: Handle EINTR in
 preallocation=full write
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

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.13.6
