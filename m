Received: from eggs.gnu.org ([2001:4830:134:3::10]:59530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dfiPF-0007TL-7Y
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dfiPE-0001bb-8Y
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:01:25 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 10 Aug 2017 16:01:08 +0800
Message-Id: <20170810080108.31047-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] file-posix: Clear out first sector in
 hdev_create
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

People get surprised when, after "qemu-imc create -f raw /dev/sdX", they
still see qcow2 with "qemu-img info", if previously the bdev had a qcow2
header. While this is natural because raw doesn't need to write any
magic bytes during creation, hdev_create is free to clear out the first
sector to make sure the stale qcow2 header doesn't cause such a
confusion.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index f4de022ae0..1d8ef6f873 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2703,6 +2703,17 @@ static int hdev_create(const char *filename, QemuOpts *opts,
         ret = -ENOSPC;
     }
 
+    if (total_size) {
+        int64_t zero_size = MIN(BDRV_SECTOR_SIZE, total_size);
+        uint8_t *buf;
+        if (lseek(fd, 0, SEEK_SET) == -1) {
+            ret = -errno;
+        } else {
+            buf = g_malloc0(zero_size);
+            ret = qemu_write_full(fd, buf, zero_size);
+            g_free(buf);
+        }
+    }
     qemu_close(fd);
     return ret;
 }
-- 
2.13.3
