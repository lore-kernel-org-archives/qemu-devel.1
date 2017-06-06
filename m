Received: from eggs.gnu.org ([2001:4830:134:3::10]:38876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dI8pL-0000mp-Ur
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dI8pH-0005L2-UU
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:22:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:58638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dI8pH-0005K6-Jd
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:22:51 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Tue,  6 Jun 2017 15:22:27 +0800
Message-Id: <20170606072229.9302-3-haozhong.zhang@intel.com>
In-Reply-To: <20170606072229.9302-1-haozhong.zhang@intel.com>
References: <20170606072229.9302-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v2 2/4] nvdimm: warn if the backend is not a
 DAX device
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

Applications in Linux guest that use device-dax never trigger flush
that can be trapped by KVM/QEMU. Meanwhile, if the host backend is not
device-dax, QEMU cannot guarantee the persistence of guest writes.
Before solving this flushing problem, QEMU should warn users if the
host backend is not device-dax.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Message-id: CAPcyv4hV2-ZW8SMCRtD0P_86KgR3DHOvNe+6T5SY2u7wXg3gEg@mail.gmail.com
---
 hw/mem/nvdimm.c      |  6 ++++++
 include/qemu/osdep.h |  9 ++++++++
 util/osdep.c         | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index a9b0863f20..b23542fbdf 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/mem/nvdimm.h"
+#include "qemu/error-report.h"
 
 static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
@@ -84,6 +85,11 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
     NVDIMMDevice *nvdimm = NVDIMM(dimm);
     uint64_t align, pmem_size, size = memory_region_size(mr);
 
+    if (!qemu_fd_is_dev_dax(memory_region_get_fd(mr))) {
+        error_report("warning: nvdimm backend does not look like a DAX device, "
+                     "unable to guarantee persistence of guest writes");
+    }
+
     align = memory_region_get_alignment(mr);
 
     pmem_size = size - nvdimm->label_size;
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 1c9f5e260c..7f26af371e 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -470,4 +470,13 @@ char *qemu_get_pid_name(pid_t pid);
  */
 pid_t qemu_fork(Error **errp);
 
+/**
+ * qemu_fd_is_dev_dax:
+ *
+ * Check whether @fd describes a DAX device.
+ *
+ * Returns true if it is; otherwise, return false.
+ */
+bool qemu_fd_is_dev_dax(int fd);
+
 #endif
diff --git a/util/osdep.c b/util/osdep.c
index a2863c8e53..02881f96bc 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -471,3 +471,64 @@ writev(int fd, const struct iovec *iov, int iov_cnt)
     return readv_writev(fd, iov, iov_cnt, true);
 }
 #endif
+
+#ifdef __linux__
+static ssize_t qemu_dev_dax_sysfs_read(int fd, const char *entry,
+                                       char *buf, size_t len)
+{
+    ssize_t read_bytes;
+    struct stat st;
+    unsigned int major, minor;
+    char *path, *pos;
+    int sysfs_fd;
+
+    if (fstat(fd, &st)) {
+        return 0;
+    }
+
+    major = major(st.st_rdev);
+    minor = minor(st.st_rdev);
+    path = g_strdup_printf("/sys/dev/char/%u:%u/%s", major, minor, entry);
+
+    sysfs_fd = open(path, O_RDONLY);
+    g_free(path);
+    if (sysfs_fd == -1) {
+        return 0;
+    }
+
+    read_bytes = read(sysfs_fd, buf, len - 1);
+    close(sysfs_fd);
+    if (read_bytes > 0) {
+        buf[read_bytes] = '\0';
+        pos = g_strstr_len(buf, read_bytes, "\n");
+        if (pos) {
+            *pos = '\0';
+        }
+    }
+
+    return read_bytes;
+}
+#endif /* __linux__ */
+
+bool qemu_fd_is_dev_dax(int fd)
+{
+    bool is_dax = false;
+
+#ifdef __linux__
+    char devtype[7];
+    ssize_t len;
+
+    if (fd == -1) {
+        return false;
+    }
+
+    len = qemu_dev_dax_sysfs_read(fd, "device/devtype",
+                                  devtype, sizeof(devtype));
+    if (len <= 0) {
+        return false;
+    }
+    is_dax = !strncmp(devtype, "nd_dax", len);
+#endif /* __linux__ */
+
+    return is_dax;
+}
-- 
2.11.0
