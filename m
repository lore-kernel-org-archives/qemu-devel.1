Received: from eggs.gnu.org ([2001:4830:134:3::10]:38116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFqk-0002zq-Dv
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFqc-0001Ah-QB
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:45:22 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:44:57 +0800
Message-Id: <20170908094457.25317-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3] file-posix: Clear out first sector in
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
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

People get surprised when, after "qemu-img create -f raw /dev/sdX", they
still see qcow2 with "qemu-img info", if previously the bdev had a qcow2
header. While this is natural because raw doesn't need to write any
magic bytes during creation, hdev_create is free to clear out the first
sector to make sure the stale qcow2 header doesn't cause such confusion.

Signed-off-by: Fam Zheng <famz@redhat.com>

---

v3: Don't do anything if there were errors. [Kevin]

v2: Use stack allocated buffer. [Eric]
    Fix return value.
    (Keep qemu_write_full instead of switching to qemu_pwritev because
    the former handles short writes.)
    Fix typo "qemu-img". [Changlong]
---
 block/file-posix.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 6acbd56238..72ecfbb0e0 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2700,6 +2700,16 @@ static int hdev_create(const char *filename, QemuOpts *opts,
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
