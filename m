Received: from eggs.gnu.org ([2001:4830:134:3::10]:38906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dI8pM-0000nD-Ub
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dI8pL-0005NA-Se
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:22:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:58638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dI8pL-0005K6-Jx
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:22:55 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Tue,  6 Jun 2017 15:22:29 +0800
Message-Id: <20170606072229.9302-5-haozhong.zhang@intel.com>
In-Reply-To: <20170606072229.9302-1-haozhong.zhang@intel.com>
References: <20170606072229.9302-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v2 4/4] util/mmap-alloc: account for DAX device
 in qemu_fd_getpagesize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

A DAX device may require a page size different than getpagesize().

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 include/qemu/osdep.h | 10 ++++++++++
 util/mmap-alloc.c    |  6 ++++++
 util/osdep.c         | 23 +++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 7f26af371e..51aca88f0d 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -479,4 +479,14 @@ pid_t qemu_fork(Error **errp);
  */
 bool qemu_fd_is_dev_dax(int fd);
 
+/**
+ * qemu_get_dev_dax_align:
+ *
+ * Get the suggested alignment of a DAX device descried by @fd.
+ *
+ * Return a non-zero suggested alignment on success; return 0 if @fd
+ * does not describe a DAX device, or if it fails to get alignment
+ * of the DAX device.
+ */
+size_t qemu_get_dev_dax_align(int fd);
 #endif
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 3ec029a9ea..2d8af64b44 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -25,8 +25,14 @@ size_t qemu_fd_getpagesize(int fd)
 #ifdef CONFIG_LINUX
     struct statfs fs;
     int ret;
+    size_t align;
 
     if (fd != -1) {
+        align = qemu_get_dev_dax_align(fd);
+        if (align) {
+            return align;
+        }
+
         do {
             ret = fstatfs(fd, &fs);
         } while (ret != 0 && errno == EINTR);
diff --git a/util/osdep.c b/util/osdep.c
index 02881f96bc..e7837d30b4 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -532,3 +532,26 @@ bool qemu_fd_is_dev_dax(int fd)
 
     return is_dax;
 }
+
+size_t qemu_get_dev_dax_align(int fd)
+{
+    size_t align = 0;
+
+#ifdef __linux__
+    char buf[12];
+    ssize_t len;
+
+    if (!qemu_fd_is_dev_dax(fd)) {
+        return 0;
+    }
+    len = qemu_dev_dax_sysfs_read(fd, "device/align", buf, sizeof(buf));
+    if (len <= 0) {
+        return 0;
+    }
+    if (qemu_strtosz(buf, NULL, &align) < 0) {
+        align = 0;
+    }
+#endif /* __linux__ */
+
+    return align;
+}
-- 
2.11.0
