Received: from eggs.gnu.org ([2001:4830:134:3::10]:32828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkQ-0001Qg-Am
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkK-0005Kk-OX
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:06 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Sep 2017 16:21:12 +0200
Message-Id: <20170926142133.2498-4-kwolf@redhat.com>
In-Reply-To: <20170926142133.2498-1-kwolf@redhat.com>
References: <20170926142133.2498-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/24] file-posix: Clear out first sector in
 hdev_create
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

People get surprised when, after "qemu-img create -f raw /dev/sdX", they
still see qcow2 with "qemu-img info", if previously the bdev had a qcow2
header. While this is natural because raw doesn't need to write any
magic bytes during creation, hdev_create is free to clear out the first
sector to make sure the stale qcow2 header doesn't cause such confusion.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index ab12a2b591..36ee89e940 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2730,6 +2730,16 @@ static int hdev_create(const char *filename, QemuOpts *opts,
         ret = -ENOSPC;
     }
 
+    if (!ret && total_size) {
+        uint8_t buf[BDRV_SECTOR_SIZE] = { 0 };
+        int64_t zero_size = MIN(BDRV_SECTOR_SIZE, total_size);
+        if (lseek(fd, 0, SEEK_SET) == -1) {
+            ret = -errno;
+        } else {
+            ret = qemu_write_full(fd, buf, zero_size);
+            ret = ret == zero_size ? 0 : -errno;
+        }
+    }
     qemu_close(fd);
     return ret;
 }
-- 
2.13.5
